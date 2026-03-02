-- =====================================================================
-- FYY RECORDER | AUTO WALK (Advanced Physics & Lag Compensation)
-- UI Design: Fyy Community Modern Dashboard (FIXED COLOR ISSUE)
-- Logic: Pro-Tier Auto Walk with Anti-Cheat Bypasses
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ========= ENGINE CONFIGURATION (PRO-TIER) =========
local RECORDING_FPS = 60
local VELOCITY_SCALE = 1
local VELOCITY_Y_SCALE = 1
local JUMP_VELOCITY_THRESHOLD = 10
local PLAYBACK_FIXED_TIMESTEP = 1 / 60
local TIME_BYPASS_THRESHOLD = 0.05

local IsRecording = false
local IsPlaying = false
local AutoLoop = false
local CurrentSpeed = 1.0

local StudioCurrentRecording = {Frames = {}, StartTime = 0, Name = ""}
local RecordedMovements = {}
local RecordingOrder = {}

local recordConn = nil
local playConn = nil

-- UI Forward Declarations
local ScreenGui, MainFrame, RecordList, RecordBtn, ResumeBtn, NameInput, LoopBtn, SpeedInput

local function SafeCall(func, ...)
    local success, err = pcall(func, ...)
    if not success then warn("Fyy Error:", err) end
    return success
end

-- ========= ADVANCED PHYSICS LOGIC =========
local function GetCurrentMoveState(hum)
    if not hum then return "Grounded" end
    local state = hum:GetState()
    if state == Enum.HumanoidStateType.Climbing then return "Climbing"
    elseif state == Enum.HumanoidStateType.Jumping then return "Jumping"
    elseif state == Enum.HumanoidStateType.Freefall then return "Falling"
    elseif state == Enum.HumanoidStateType.Swimming then return "Swimming"
    else return "Grounded" end
end

local function GetFrameVelocity(frame, moveState)
    if not frame or not frame.Velocity then return Vector3.new(0, 0, 0) end
    local velY = frame.Velocity[2] * VELOCITY_Y_SCALE
    -- [ BYPASS ]: Smart Velocity (Anti-Melayang di tanah rata/miring)
    if moveState == "Grounded" or moveState == nil then velY = 0 end 
    return Vector3.new(frame.Velocity[1] * VELOCITY_SCALE, velY, frame.Velocity[3] * VELOCITY_SCALE)
end

local function ApplyFrameDirect(frame)
    SafeCall(function()
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        
        -- CFrame & Velocity Apply
        hrp.CFrame = CFrame.lookAt(
            Vector3.new(frame.Position[1], frame.Position[2], frame.Position[3]), 
            Vector3.new(frame.Position[1], frame.Position[2], frame.Position[3]) + Vector3.new(frame.LookVector[1], frame.LookVector[2], frame.LookVector[3])
        )
        hrp.AssemblyLinearVelocity = GetFrameVelocity(frame, frame.MoveState)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hum.WalkSpeed = (frame.WalkSpeed or 16) * CurrentSpeed
        
        -- [ BYPASS ]: State Trigger (Animasi loncat/jatuh yang real)
        local frameVel = GetFrameVelocity(frame, frame.MoveState)
        if frameVel.Y > JUMP_VELOCITY_THRESHOLD then hum:ChangeState(Enum.HumanoidStateType.Jumping)
        elseif frameVel.Y < -5 then hum:ChangeState(Enum.HumanoidStateType.Freefall)
        elseif frame.MoveState == "Climbing" then hum:ChangeState(Enum.HumanoidStateType.Climbing)
        end
    end)
end

-- ========= CORE RECORDING & PLAYBACK LOGIC =========
local function StartRecord()
    if IsRecording then 
        IsRecording = false
        RecordBtn.Text = "RECORD"
        RecordBtn.BackgroundColor3 = Color3.fromRGB(219, 52, 63)
        if recordConn then recordConn:Disconnect() end
        return 
    end
    
    IsRecording = true
    StudioCurrentRecording = {Frames = {}, StartTime = tick(), Name = NameInput.Text ~= "" and NameInput.Text or "Fyy_Path"}
    RecordBtn.Text = "STOP RECORDING"
    RecordBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local lastRecordTime = tick()
    
    recordConn = RunService.Heartbeat:Connect(function()
        if not hrp then return end
        local now = tick()
        
        -- [ BYPASS ]: Anti-Speedhack Spam Frame Detection
        if (now - lastRecordTime) < (1 / RECORDING_FPS) then return end
        lastRecordTime = now

        local cf = hrp.CFrame
        table.insert(StudioCurrentRecording.Frames, {
            Position = {cf.Position.X, cf.Position.Y, cf.Position.Z},
            LookVector = {cf.LookVector.X, cf.LookVector.Y, cf.LookVector.Z},
            Velocity = {hrp.AssemblyLinearVelocity.X, hrp.AssemblyLinearVelocity.Y, hrp.AssemblyLinearVelocity.Z},
            MoveState = GetCurrentMoveState(char:FindFirstChildOfClass("Humanoid")),
            
            -- [ BYPASS ]: Timestamp Noise
            Timestamp = (now - StudioCurrentRecording.StartTime) + (math.random(-2, 2) / 1000)
        })
    end)
end

local function SaveRecord()
    if #StudioCurrentRecording.Frames == 0 then return end
    if IsRecording then StartRecord() end -- Auto stop if saving
    
    local name = NameInput.Text ~= "" and NameInput.Text or ("Rute " .. (#RecordingOrder + 1))
    RecordedMovements[name] = StudioCurrentRecording.Frames
    table.insert(RecordingOrder, name)
    
    -- Generate Checklist UI Dynamically
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, 0, 0, 35)
    item.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    item.Parent = RecordList
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "📁 " .. name
    lbl.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = item
    
    local playThis = Instance.new("TextButton")
    playThis.Size = UDim2.fromOffset(30, 30)
    playThis.Position = UDim2.new(1, -35, 0, 2)
    playThis.BackgroundColor3 = Color3.fromRGB(65, 185, 95)
    playThis.Text = "✓"
    playThis.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
    playThis.Parent = item
    Instance.new("UICorner", playThis).CornerRadius = UDim.new(0, 6)
    
    NameInput.Text = ""
    StudioCurrentRecording = {Frames = {}, StartTime = 0, Name = ""}
end

local function Playback()
    if IsPlaying then
        IsPlaying = false
        ResumeBtn.Text = "RESUME / PLAY"
        ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
        if playConn then playConn:Disconnect() end
        return
    end
    
    local targetName = RecordingOrder[#RecordingOrder]
    if not targetName or not RecordedMovements[targetName] then return end
    
    IsPlaying = true
    ResumeBtn.Text = "STOP PLAYBACK"
    ResumeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    local recording = RecordedMovements[targetName]
    local startTick = tick()
    local currentIdx = 1
    local playbackAccumulator = 0
    
    playConn = RunService.Heartbeat:Connect(function(deltaTime)
        if not IsPlaying then return end
        
        playbackAccumulator = playbackAccumulator + deltaTime
        
        while playbackAccumulator >= PLAYBACK_FIXED_TIMESTEP do
            playbackAccumulator = playbackAccumulator - PLAYBACK_FIXED_TIMESTEP
            local elapsed = (tick() - startTick) * CurrentSpeed
            
            local nextFrame = currentIdx
            while nextFrame < #recording and recording[nextFrame + 1].Timestamp <= elapsed do
                nextFrame = nextFrame + 1
            end
            
            if nextFrame >= #recording then
                IsPlaying = false
                ResumeBtn.Text = "RESUME / PLAY"
                ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
                if playConn then playConn:Disconnect() end
                
                if AutoLoop then 
                    task.wait(math.random(2, 6) / 10) 
                    Playback() 
                end 
                return
            end
            
            ApplyFrameDirect(recording[nextFrame])
            currentIdx = nextFrame
        end
    end)
end

-- ========= MODERN UI CREATION =========
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FyyRecorderUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(500, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(219, 52, 63)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌪 Fyy Recorder | Auto Walk"
Title.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(30, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.45, 0, 1, -50)
LeftPanel.Position = UDim2.new(0, 15, 0, 40)
LeftPanel.BackgroundTransparency = 1
LeftPanel.Parent = MainFrame

local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.5, 0, 1, -50)
RightPanel.Position = UDim2.new(0.48, 0, 0, 40)
RightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
RightPanel.Parent = MainFrame
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 8)

local UIListLeft = Instance.new("UIListLayout")
UIListLeft.SortOrder = Enum.SortOrder.LayoutOrder
UIListLeft.Padding = UDim.new(0, 8)
UIListLeft.Parent = LeftPanel

local function CreateHeaderLabel(text, parent)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
end

CreateHeaderLabel("🎬 CONTROLS", LeftPanel)

RecordBtn = Instance.new("TextButton")
RecordBtn.Size = UDim2.new(1, 0, 0, 40)
RecordBtn.BackgroundColor3 = Color3.fromRGB(219, 52, 63)
RecordBtn.Text = "RECORD"
RecordBtn.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
RecordBtn.Font = Enum.Font.GothamBold
RecordBtn.TextSize = 14
RecordBtn.Parent = LeftPanel
Instance.new("UICorner", RecordBtn).CornerRadius = UDim.new(0, 8)

ResumeBtn = Instance.new("TextButton")
ResumeBtn.Size = UDim2.new(1, 0, 0, 40)
ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
ResumeBtn.Text = "RESUME / PLAY"
ResumeBtn.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
ResumeBtn.Font = Enum.Font.GothamBold
ResumeBtn.TextSize = 14
ResumeBtn.Parent = LeftPanel
Instance.new("UICorner", ResumeBtn).CornerRadius = UDim.new(0, 8)

CreateHeaderLabel("⚙ PLAYBACK", LeftPanel)

local PlaybackRow = Instance.new("Frame")
PlaybackRow.Size = UDim2.new(1, 0, 0, 35)
PlaybackRow.BackgroundTransparency = 1
PlaybackRow.Parent = LeftPanel

SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.48, 0, 1, 0)
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInput.Text = "1.0"
SpeedInput.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
SpeedInput.Font = Enum.Font.GothamBold
SpeedInput.Parent = PlaybackRow
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 6)

LoopBtn = Instance.new("TextButton")
LoopBtn.Size = UDim2.new(0.48, 0, 1, 0)
LoopBtn.Position = UDim2.new(0.52, 0, 0, 0)
LoopBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LoopBtn.Text = "🔄 OFF"
LoopBtn.TextColor3 = Color3.fromRGB(150, 150, 255)
LoopBtn.Font = Enum.Font.GothamBold
LoopBtn.Parent = PlaybackRow
Instance.new("UICorner", LoopBtn).CornerRadius = UDim.new(0, 6)

CreateHeaderLabel("💾 SAVE", LeftPanel)

NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(1, 0, 0, 35)
NameInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NameInput.PlaceholderText = "Checkpoint name..."
NameInput.Text = ""
NameInput.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
NameInput.Font = Enum.Font.Gotham
NameInput.Parent = LeftPanel
Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1, 0, 0, 40)
SaveBtn.BackgroundColor3 = Color3.fromRGB(65, 185, 95)
SaveBtn.Text = "💾 SAVE"
SaveBtn.TextColor3 = Color3.new(1, 1, 1) -- FIXED COLOR
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 14
SaveBtn.Parent = LeftPanel
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 8)

local RightTopRow = Instance.new("Frame")
RightTopRow.Size = UDim2.new(1, -20, 0, 30)
RightTopRow.Position = UDim2.new(0, 10, 0, 10)
RightTopRow.BackgroundTransparency = 1
RightTopRow.Parent = RightPanel
CreateHeaderLabel("📁 CHECKPOINTS", RightTopRow)

RecordList = Instance.new("ScrollingFrame")
RecordList.Size = UDim2.new(1, -20, 1, -60)
RecordList.Position = UDim2.new(0, 10, 0, 50)
RecordList.BackgroundTransparency = 1
RecordList.ScrollBarThickness = 4
RecordList.Parent = RightPanel
local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = RecordList

-- Button Bindings
RecordBtn.MouseButton1Click:Connect(StartRecord)
SaveBtn.MouseButton1Click:Connect(SaveRecord)
ResumeBtn.MouseButton1Click:Connect(Playback)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
LoopBtn.MouseButton1Click:Connect(function()
    AutoLoop = not AutoLoop
    LoopBtn.Text = AutoLoop and "🔄 ON" or "🔄 OFF"
    LoopBtn.TextColor3 = AutoLoop and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(150, 150, 255)
end)
SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then CurrentSpeed = num else SpeedInput.Text = tostring(CurrentSpeed) end
end)        lastRecordTime = now

        local cf = hrp.CFrame
        table.insert(StudioCurrentRecording.Frames, {
            Position = {cf.Position.X, cf.Position.Y, cf.Position.Z},
            LookVector = {cf.LookVector.X, cf.LookVector.Y, cf.LookVector.Z},
            Velocity = {hrp.AssemblyLinearVelocity.X, hrp.AssemblyLinearVelocity.Y, hrp.AssemblyLinearVelocity.Z},
            MoveState = GetCurrentMoveState(char:FindFirstChildOfClass("Humanoid")),
            
            -- [ BYPASS ]: Timestamp Noise biar log terlihat seperti human ping
            Timestamp = (now - StudioCurrentRecording.StartTime) + (math.random(-2, 2) / 1000)
        })
    end)
end

local function SaveRecord()
    if #StudioCurrentRecording.Frames == 0 then return end
    if IsRecording then StartRecord() end -- Auto stop if saving
    
    local name = NameInput.Text ~= "" and NameInput.Text or ("Rute " .. (#RecordingOrder + 1))
    RecordedMovements[name] = StudioCurrentRecording.Frames
    table.insert(RecordingOrder, name)
    
    -- Generate Checklist UI Dynamically
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, 0, 0, 35)
    item.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    item.Parent = RecordList
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "📁 " .. name
    lbl.TextColor3 = Color3.white
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = item
    
    local playThis = Instance.new("TextButton")
    playThis.Size = UDim2.fromOffset(30, 30)
    playThis.Position = UDim2.new(1, -35, 0, 2)
    playThis.BackgroundColor3 = Color3.fromRGB(65, 185, 95)
    playThis.Text = "✓"
    playThis.TextColor3 = Color3.white
    playThis.Parent = item
    Instance.new("UICorner", playThis).CornerRadius = UDim.new(0, 6)
    
    NameInput.Text = ""
    StudioCurrentRecording = {Frames = {}, StartTime = 0, Name = ""}
end

local function Playback()
    if IsPlaying then
        IsPlaying = false
        ResumeBtn.Text = "RESUME / PLAY"
        ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
        if playConn then playConn:Disconnect() end
        return
    end
    
    local targetName = RecordingOrder[#RecordingOrder]
    if not targetName or not RecordedMovements[targetName] then return end
    
    IsPlaying = true
    ResumeBtn.Text = "STOP PLAYBACK"
    ResumeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    local recording = RecordedMovements[targetName]
    local startTick = tick()
    local currentIdx = 1
    local playbackAccumulator = 0
    
    playConn = RunService.Heartbeat:Connect(function(deltaTime)
        if not IsPlaying then return end
        
        -- [ BYPASS ]: Fixed Timestep (Anti patah-patah kalau ngelag)
        playbackAccumulator = playbackAccumulator + deltaTime
        
        while playbackAccumulator >= PLAYBACK_FIXED_TIMESTEP do
            playbackAccumulator = playbackAccumulator - PLAYBACK_FIXED_TIMESTEP
            local elapsed = (tick() - startTick) * CurrentSpeed
            
            -- [ BYPASS ]: Lag Compensation Frame Skipper
            local nextFrame = currentIdx
            while nextFrame < #recording and recording[nextFrame + 1].Timestamp <= elapsed do
                nextFrame = nextFrame + 1
            end
            
            if nextFrame >= #recording then
                IsPlaying = false
                ResumeBtn.Text = "RESUME / PLAY"
                ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
                if playConn then playConn:Disconnect() end
                
                -- [ BYPASS ]: Humanized Auto-Loop Delay
                if AutoLoop then 
                    task.wait(math.random(2, 6) / 10) 
                    Playback() 
                end 
                return
            end
            
            ApplyFrameDirect(recording[nextFrame])
            currentIdx = nextFrame
        end
    end)
end

-- ========= MODERN UI CREATION =========
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FyyRecorderUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(500, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(219, 52, 63)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌪 Fyy Recorder | Auto Walk"
Title.TextColor3 = Color3.white
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(30, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.white
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.45, 0, 1, -50)
LeftPanel.Position = UDim2.new(0, 15, 0, 40)
LeftPanel.BackgroundTransparency = 1
LeftPanel.Parent = MainFrame

local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.5, 0, 1, -50)
RightPanel.Position = UDim2.new(0.48, 0, 0, 40)
RightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
RightPanel.Parent = MainFrame
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 8)

local UIListLeft = Instance.new("UIListLayout")
UIListLeft.SortOrder = Enum.SortOrder.LayoutOrder
UIListLeft.Padding = UDim.new(0, 8)
UIListLeft.Parent = LeftPanel

local function CreateHeaderLabel(text, parent)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
end

CreateHeaderLabel("🎬 CONTROLS", LeftPanel)

RecordBtn = Instance.new("TextButton")
RecordBtn.Size = UDim2.new(1, 0, 0, 40)
RecordBtn.BackgroundColor3 = Color3.fromRGB(219, 52, 63)
RecordBtn.Text = "RECORD"
RecordBtn.TextColor3 = Color3.white
RecordBtn.Font = Enum.Font.GothamBold
RecordBtn.TextSize = 14
RecordBtn.Parent = LeftPanel
Instance.new("UICorner", RecordBtn).CornerRadius = UDim.new(0, 8)

ResumeBtn = Instance.new("TextButton")
ResumeBtn.Size = UDim2.new(1, 0, 0, 40)
ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
ResumeBtn.Text = "RESUME / PLAY"
ResumeBtn.TextColor3 = Color3.white
ResumeBtn.Font = Enum.Font.GothamBold
ResumeBtn.TextSize = 14
ResumeBtn.Parent = LeftPanel
Instance.new("UICorner", ResumeBtn).CornerRadius = UDim.new(0, 8)

CreateHeaderLabel("⚙ PLAYBACK", LeftPanel)

local PlaybackRow = Instance.new("Frame")
PlaybackRow.Size = UDim2.new(1, 0, 0, 35)
PlaybackRow.BackgroundTransparency = 1
PlaybackRow.Parent = LeftPanel

SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.48, 0, 1, 0)
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInput.Text = "1.0"
SpeedInput.TextColor3 = Color3.white
SpeedInput.Font = Enum.Font.GothamBold
SpeedInput.Parent = PlaybackRow
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 6)

LoopBtn = Instance.new("TextButton")
LoopBtn.Size = UDim2.new(0.48, 0, 1, 0)
LoopBtn.Position = UDim2.new(0.52, 0, 0, 0)
LoopBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LoopBtn.Text = "🔄 OFF"
LoopBtn.TextColor3 = Color3.fromRGB(150, 150, 255)
LoopBtn.Font = Enum.Font.GothamBold
LoopBtn.Parent = PlaybackRow
Instance.new("UICorner", LoopBtn).CornerRadius = UDim.new(0, 6)

CreateHeaderLabel("💾 SAVE", LeftPanel)

NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(1, 0, 0, 35)
NameInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NameInput.PlaceholderText = "Checkpoint name..."
NameInput.Text = ""
NameInput.TextColor3 = Color3.white
NameInput.Font = Enum.Font.Gotham
NameInput.Parent = LeftPanel
Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1, 0, 0, 40)
SaveBtn.BackgroundColor3 = Color3.fromRGB(65, 185, 95)
SaveBtn.Text = "💾 SAVE"
SaveBtn.TextColor3 = Color3.white
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 14
SaveBtn.Parent = LeftPanel
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 8)

local RightTopRow = Instance.new("Frame")
RightTopRow.Size = UDim2.new(1, -20, 0, 30)
RightTopRow.Position = UDim2.new(0, 10, 0, 10)
RightTopRow.BackgroundTransparency = 1
RightTopRow.Parent = RightPanel
CreateHeaderLabel("📁 CHECKPOINTS", RightTopRow)

RecordList = Instance.new("ScrollingFrame")
RecordList.Size = UDim2.new(1, -20, 1, -60)
RecordList.Position = UDim2.new(0, 10, 0, 50)
RecordList.BackgroundTransparency = 1
RecordList.ScrollBarThickness = 4
RecordList.Parent = RightPanel
local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = RecordList

-- Button Bindings
RecordBtn.MouseButton1Click:Connect(StartRecord)
SaveBtn.MouseButton1Click:Connect(SaveRecord)
ResumeBtn.MouseButton1Click:Connect(Playback)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
LoopBtn.MouseButton1Click:Connect(function()
    AutoLoop = not AutoLoop
    LoopBtn.Text = AutoLoop and "🔄 ON" or "🔄 OFF"
    LoopBtn.TextColor3 = AutoLoop and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(150, 150, 255)
end)
SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then CurrentSpeed = num else SpeedInput.Text = tostring(CurrentSpeed) end
end)
