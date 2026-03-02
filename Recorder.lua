-- =====================================================================
-- FYY RECORDER | AUTO WALK (60 FPS Ultra Smooth Physics Engine)
-- UI Design: Dashboard + Floating Mini Buttons (No Bug)
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- ========= ENGINE CONFIGURATION =========
local RECORDING_FPS = 60
local VELOCITY_SCALE = 1
local VELOCITY_Y_SCALE = 1
local JUMP_VELOCITY_THRESHOLD = 10
local PLAYBACK_FIXED_TIMESTEP = 1 / 60

local IsRecording, IsPlaying, AutoLoop = false, false, false
local CurrentSpeed = 1.0
local StudioCurrentRecording = {Frames = {}, StartTime = 0, Name = ""}
local RecordedMovements = {}
local RecordingOrder = {}
local recordConn, playConn

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
    if not frame or not frame.Velocity then return Vector3.zero end
    local velY = frame.Velocity[2] * VELOCITY_Y_SCALE
    if moveState == "Grounded" or moveState == nil then velY = 0 end 
    return Vector3.new(frame.Velocity[1] * VELOCITY_SCALE, velY, frame.Velocity[3] * VELOCITY_SCALE)
end

local function ApplyFrameDirect(frame)
    SafeCall(function()
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        
        -- MATIKAN AUTOROTATE BENGKOK (Rahasia Anti-Getar)
        hum.AutoRotate = false
        
        hrp.CFrame = CFrame.lookAt(
            Vector3.new(frame.Position[1], frame.Position[2], frame.Position[3]), 
            Vector3.new(frame.Position[1], frame.Position[2], frame.Position[3]) + Vector3.new(frame.LookVector[1], frame.LookVector[2], frame.LookVector[3])
        )
        hrp.AssemblyLinearVelocity = GetFrameVelocity(frame, frame.MoveState)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hum.WalkSpeed = (frame.WalkSpeed or 16) * CurrentSpeed
        
        local frameVel = GetFrameVelocity(frame, frame.MoveState)
        if frameVel.Y > JUMP_VELOCITY_THRESHOLD then hum:ChangeState(Enum.HumanoidStateType.Jumping)
        elseif frameVel.Y < -5 then hum:ChangeState(Enum.HumanoidStateType.Freefall)
        elseif frame.MoveState == "Climbing" then hum:ChangeState(Enum.HumanoidStateType.Climbing)
        end
    end)
end

local function StopPlaybackAction()
    IsPlaying = false
    if playConn then playConn:Disconnect() end
    
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.AutoRotate = true end -- Balikin rotasi normal
end

-- UI Declarations
local ScreenGui, MainFrame, RecordList, RecordBtn, ResumeBtn, NameInput, FloatRec, FloatPlay

-- ========= CORE RECORDING & PLAYBACK LOGIC =========
local function ToggleRecord()
    if IsRecording then 
        IsRecording = false
        RecordBtn.Text = "RECORD"
        RecordBtn.BackgroundColor3 = Color3.fromRGB(219, 52, 63)
        FloatRec.BackgroundColor3 = Color3.fromRGB(219, 52, 63)
        if recordConn then recordConn:Disconnect() end
        return 
    end
    
    IsRecording = true
    StudioCurrentRecording = {Frames = {}, StartTime = tick(), Name = NameInput.Text ~= "" and NameInput.Text or "Fyy_Path"}
    RecordBtn.Text = "STOP RECORDING"
    RecordBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    FloatRec.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local lastRecordTime = tick()
    
    recordConn = RunService.Heartbeat:Connect(function()
        if not hrp then return end
        local now = tick()
        if (now - lastRecordTime) < (1 / RECORDING_FPS) then return end
        lastRecordTime = now

        local cf = hrp.CFrame
        table.insert(StudioCurrentRecording.Frames, {
            Position = {cf.Position.X, cf.Position.Y, cf.Position.Z},
            LookVector = {cf.LookVector.X, cf.LookVector.Y, cf.LookVector.Z},
            Velocity = {hrp.AssemblyLinearVelocity.X, hrp.AssemblyLinearVelocity.Y, hrp.AssemblyLinearVelocity.Z},
            MoveState = GetCurrentMoveState(char:FindFirstChildOfClass("Humanoid")),
            Timestamp = (now - StudioCurrentRecording.StartTime)
        })
    end)
end

local function SaveRecord()
    if #StudioCurrentRecording.Frames == 0 then return end
    if IsRecording then ToggleRecord() end
    
    local name = NameInput.Text ~= "" and NameInput.Text or ("Rute " .. (#RecordingOrder + 1))
    RecordedMovements[name] = StudioCurrentRecording.Frames
    table.insert(RecordingOrder, name)
    
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
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = item
    
    local playThis = Instance.new("TextButton")
    playThis.Size = UDim2.fromOffset(30, 30)
    playThis.Position = UDim2.new(1, -35, 0, 2)
    playThis.BackgroundColor3 = Color3.fromRGB(65, 185, 95)
    playThis.Text = "✓"
    playThis.TextColor3 = Color3.new(1, 1, 1)
    playThis.Parent = item
    Instance.new("UICorner", playThis).CornerRadius = UDim.new(0, 6)
    
    NameInput.Text = ""
    StudioCurrentRecording = {Frames = {}, StartTime = 0, Name = ""}
end

local function TogglePlayback()
    if IsPlaying then
        StopPlaybackAction()
        ResumeBtn.Text = "RESUME / PLAY"
        ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
        FloatPlay.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
        return
    end
    
    local targetName = RecordingOrder[#RecordingOrder]
    if not targetName or not RecordedMovements[targetName] then return end
    
    IsPlaying = true
    ResumeBtn.Text = "STOP PLAYBACK"
    ResumeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    FloatPlay.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    local recording = RecordedMovements[targetName]
    local startTick = tick()
    local currentIdx = 1
    local playbackAccumulator = 0
    
    -- MENGGUNAKAN HEARTBEAT & TIMESTEP FIX BUKAN LERP MENTAH
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
                StopPlaybackAction()
                ResumeBtn.Text = "RESUME / PLAY"
                ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
                FloatPlay.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
                
                if AutoLoop then 
                    task.wait(0.3) 
                    TogglePlayback() 
                end 
                return
            end
            
            ApplyFrameDirect(recording[nextFrame])
            currentIdx = nextFrame
        end
    end)
end

-- ========= UI CREATION =========
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FyyRecorderUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- 1. MAIN DASHBOARD
MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(450, 280)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
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

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌪 Fyy Recorder | Auto Walk"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(25, 25)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- Panels
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.45, 0, 1, -45)
LeftPanel.Position = UDim2.new(0, 15, 0, 35)
LeftPanel.BackgroundTransparency = 1
LeftPanel.Parent = MainFrame

local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.5, 0, 1, -45)
RightPanel.Position = UDim2.new(0.48, 0, 0, 35)
RightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
RightPanel.Parent = MainFrame
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 8)

local UIListLeft = Instance.new("UIListLayout")
UIListLeft.SortOrder = Enum.SortOrder.LayoutOrder
UIListLeft.Padding = UDim.new(0, 6)
UIListLeft.Parent = LeftPanel

local function CreateHeaderLabel(text, parent)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
end

-- Controls
CreateHeaderLabel("🎬 CONTROLS", LeftPanel)

RecordBtn = Instance.new("TextButton")
RecordBtn.Size = UDim2.new(1, 0, 0, 35)
RecordBtn.BackgroundColor3 = Color3.fromRGB(219, 52, 63)
RecordBtn.Text = "RECORD"
RecordBtn.TextColor3 = Color3.new(1, 1, 1)
RecordBtn.Font = Enum.Font.GothamBold
RecordBtn.TextSize = 13
RecordBtn.Parent = LeftPanel
Instance.new("UICorner", RecordBtn).CornerRadius = UDim.new(0, 8)

ResumeBtn = Instance.new("TextButton")
ResumeBtn.Size = UDim2.new(1, 0, 0, 35)
ResumeBtn.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
ResumeBtn.Text = "RESUME / PLAY"
ResumeBtn.TextColor3 = Color3.new(1, 1, 1)
ResumeBtn.Font = Enum.Font.GothamBold
ResumeBtn.TextSize = 13
ResumeBtn.Parent = LeftPanel
Instance.new("UICorner", ResumeBtn).CornerRadius = UDim.new(0, 8)

-- Playback Settings
CreateHeaderLabel("⚙ PLAYBACK", LeftPanel)

local PlaybackRow = Instance.new("Frame")
PlaybackRow.Size = UDim2.new(1, 0, 0, 30)
PlaybackRow.BackgroundTransparency = 1
PlaybackRow.Parent = LeftPanel

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.48, 0, 1, 0)
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInput.Text = "1.0"
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Font = Enum.Font.GothamBold
SpeedInput.Parent = PlaybackRow
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 6)

local LoopBtn = Instance.new("TextButton")
LoopBtn.Size = UDim2.new(0.48, 0, 1, 0)
LoopBtn.Position = UDim2.new(0.52, 0, 0, 0)
LoopBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LoopBtn.Text = "🔄 OFF"
LoopBtn.TextColor3 = Color3.fromRGB(150, 150, 255)
LoopBtn.Font = Enum.Font.GothamBold
LoopBtn.Parent = PlaybackRow
Instance.new("UICorner", LoopBtn).CornerRadius = UDim.new(0, 6)

-- Save System
CreateHeaderLabel("💾 SAVE", LeftPanel)

NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(1, 0, 0, 30)
NameInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NameInput.PlaceholderText = "Checkpoint name..."
NameInput.Text = ""
NameInput.TextColor3 = Color3.new(1, 1, 1)
NameInput.Font = Enum.Font.Gotham
NameInput.Parent = LeftPanel
Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1, 0, 0, 35)
SaveBtn.BackgroundColor3 = Color3.fromRGB(65, 185, 95)
SaveBtn.Text = "💾 SAVE"
SaveBtn.TextColor3 = Color3.new(1, 1, 1)
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.Parent = LeftPanel
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 8)

-- Checkpoints List
local RightTopRow = Instance.new("Frame")
RightTopRow.Size = UDim2.new(1, -20, 0, 25)
RightTopRow.Position = UDim2.new(0, 10, 0, 5)
RightTopRow.BackgroundTransparency = 1
RightTopRow.Parent = RightPanel
CreateHeaderLabel("📁 CHECKPOINTS", RightTopRow)

RecordList = Instance.new("ScrollingFrame")
RecordList.Size = UDim2.new(1, -20, 1, -45)
RecordList.Position = UDim2.new(0, 10, 0, 35)
RecordList.BackgroundTransparency = 1
RecordList.ScrollBarThickness = 4
RecordList.Parent = RightPanel
local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = RecordList

-- 2. FLOATING MINI BUTTONS (Bisa Digeser)
local FloatUI = Instance.new("Frame")
FloatUI.Size = UDim2.fromOffset(130, 60)
FloatUI.Position = UDim2.new(0.5, -65, 0.1, 0)
FloatUI.BackgroundTransparency = 1
FloatUI.Active = true
FloatUI.Draggable = true
FloatUI.Parent = ScreenGui

FloatRec = Instance.new("TextButton")
FloatRec.Size = UDim2.fromOffset(60, 60)
FloatRec.BackgroundColor3 = Color3.fromRGB(219, 52, 63)
FloatRec.Text = "●"
FloatRec.TextColor3 = Color3.new(1, 1, 1)
FloatRec.TextSize = 25
FloatRec.Parent = FloatUI
Instance.new("UICorner", FloatRec).CornerRadius = UDim.new(1, 0)

FloatPlay = Instance.new("TextButton")
FloatPlay.Size = UDim2.fromOffset(60, 60)
FloatPlay.Position = UDim2.fromOffset(70, 0)
FloatPlay.BackgroundColor3 = Color3.fromRGB(240, 150, 50)
FloatPlay.Text = "<<"
FloatPlay.TextColor3 = Color3.new(1, 1, 1)
FloatPlay.TextSize = 25
FloatPlay.Font = Enum.Font.GothamBold
FloatPlay.Parent = FloatUI
Instance.new("UICorner", FloatPlay).CornerRadius = UDim.new(1, 0)

local OpenMenuBtn = Instance.new("TextButton")
OpenMenuBtn.Size = UDim2.fromOffset(60, 20)
OpenMenuBtn.Position = UDim2.fromOffset(35, 65)
OpenMenuBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenMenuBtn.Text = "MENU"
OpenMenuBtn.TextColor3 = Color3.new(1, 1, 1)
OpenMenuBtn.Font = Enum.Font.GothamBold
OpenMenuBtn.TextSize = 10
OpenMenuBtn.Parent = FloatUI
Instance.new("UICorner", OpenMenuBtn).CornerRadius = UDim.new(0, 4)

-- Bindings
RecordBtn.MouseButton1Click:Connect(ToggleRecord)
FloatRec.MouseButton1Click:Connect(ToggleRecord)

ResumeBtn.MouseButton1Click:Connect(TogglePlayback)
FloatPlay.MouseButton1Click:Connect(TogglePlayback)

SaveBtn.MouseButton1Click:Connect(SaveRecord)
OpenMenuBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

LoopBtn.MouseButton1Click:Connect(function()
    AutoLoop = not AutoLoop
    LoopBtn.Text = AutoLoop and "🔄 ON" or "🔄 OFF"
    LoopBtn.TextColor3 = AutoLoop and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(150, 150, 255)
end)

SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then CurrentSpeed = num else SpeedInput.Text = tostring(CurrentSpeed) end
end)
