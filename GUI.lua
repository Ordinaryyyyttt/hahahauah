-- Hasil Gui to Lua Converter
-- Target: RullzsyHUB_Recorder

local UI_1 = Instance.new('ScreenGui')
UI_1.Name = 'RullzsyHUB_Recorder'
UI_1.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')

local UI_2 = Instance.new('ImageButton')
UI_2.Name = 'FloatingLogo'
UI_2.Parent = UI_1
UI_2.Size = UDim2.new(0, 75, 0, 75)
UI_2.Position = UDim2.new(0, 50, 0, 50)
UI_2.BackgroundColor3 = Color3.new(0.05882352963089943, 0.05882352963089943, 0.05882352963089943)
UI_2.BackgroundTransparency = 0
UI_2.Visible = false

local UI_3 = Instance.new('UICorner')
UI_3.Name = 'UICorner'
UI_3.Parent = UI_2

local UI_4 = Instance.new('UIStroke')
UI_4.Name = 'UIStroke'
UI_4.Parent = UI_2

local UI_5 = Instance.new('Frame')
UI_5.Name = 'MainFrame'
UI_5.Parent = UI_1
UI_5.Size = UDim2.new(0, 400, 0, 360)
UI_5.Position = UDim2.new(0.5, -200, 0.5, -180)
UI_5.BackgroundColor3 = Color3.new(0.05882352963089943, 0.05882352963089943, 0.05882352963089943)
UI_5.BackgroundTransparency = 0
UI_5.Visible = true

local UI_6 = Instance.new('UICorner')
UI_6.Name = 'UICorner'
UI_6.Parent = UI_5

local UI_7 = Instance.new('UIStroke')
UI_7.Name = 'UIStroke'
UI_7.Parent = UI_5

local UI_8 = Instance.new('ImageLabel')
UI_8.Name = 'Shadow'
UI_8.Parent = UI_5
UI_8.Size = UDim2.new(1, 30, 1, 30)
UI_8.Position = UDim2.new(0, -15, 0, -15)
UI_8.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_8.BackgroundTransparency = 1
UI_8.Visible = true

local UI_9 = Instance.new('Frame')
UI_9.Name = 'TitleBar'
UI_9.Parent = UI_5
UI_9.Size = UDim2.new(0, 400, 0, 40)
UI_9.Position = UDim2.new(0, 0, 0, 0)
UI_9.BackgroundColor3 = Color3.new(0.10980392247438431, 0.10980392247438431, 0.10980392247438431)
UI_9.BackgroundTransparency = 0
UI_9.Visible = true

local UI_10 = Instance.new('UICorner')
UI_10.Name = 'UICorner'
UI_10.Parent = UI_9

local UI_11 = Instance.new('ImageLabel')
UI_11.Name = 'ImageLabel'
UI_11.Parent = UI_9
UI_11.Size = UDim2.new(0, 30, 0, 30)
UI_11.Position = UDim2.new(0, 8, 0, 5)
UI_11.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_11.BackgroundTransparency = 1
UI_11.Visible = true

local UI_12 = Instance.new('UICorner')
UI_12.Name = 'UICorner'
UI_12.Parent = UI_11

local UI_13 = Instance.new('TextLabel')
UI_13.Name = 'TextLabel'
UI_13.Parent = UI_9
UI_13.Size = UDim2.new(0, 200, 0, 40)
UI_13.Position = UDim2.new(0, 45, 0, 0)
UI_13.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_13.BackgroundTransparency = 1
UI_13.Text = 'Recorder | Auto Walk'
UI_13.TextColor3 = Color3.new(1, 1, 1)
UI_13.TextScaled = false
UI_13.Font = Enum.Font.GothamBold
UI_13.Visible = true

local UI_14 = Instance.new('TextButton')
UI_14.Name = 'TextButton'
UI_14.Parent = UI_9
UI_14.Size = UDim2.new(0, 30, 0, 30)
UI_14.Position = UDim2.new(0, 325, 0, 5)
UI_14.BackgroundColor3 = Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886)
UI_14.BackgroundTransparency = 0
UI_14.Text = '−'
UI_14.TextColor3 = Color3.new(1, 1, 1)
UI_14.TextScaled = false
UI_14.Font = Enum.Font.Gotham
UI_14.Visible = true

local UI_15 = Instance.new('UICorner')
UI_15.Name = 'UICorner'
UI_15.Parent = UI_14

local UI_16 = Instance.new('TextButton')
UI_16.Name = 'TextButton'
UI_16.Parent = UI_9
UI_16.Size = UDim2.new(0, 30, 0, 30)
UI_16.Position = UDim2.new(0, 360, 0, 5)
UI_16.BackgroundColor3 = Color3.new(0.9372549057006836, 0.2666666805744171, 0.2666666805744171)
UI_16.BackgroundTransparency = 0
UI_16.Text = 'X'
UI_16.TextColor3 = Color3.new(1, 1, 1)
UI_16.TextScaled = false
UI_16.Font = Enum.Font.Gotham
UI_16.Visible = true

local UI_17 = Instance.new('UICorner')
UI_17.Name = 'UICorner'
UI_17.Parent = UI_16

local UI_18 = Instance.new('Frame')
UI_18.Name = 'LeftSidebar'
UI_18.Parent = UI_5
UI_18.Size = UDim2.new(0, 185, 0, 310)
UI_18.Position = UDim2.new(0, 5, 0, 45)
UI_18.BackgroundColor3 = Color3.new(0.0784313753247261, 0.0784313753247261, 0.0784313753247261)
UI_18.BackgroundTransparency = 0
UI_18.Visible = true

local UI_19 = Instance.new('UICorner')
UI_19.Name = 'UICorner'
UI_19.Parent = UI_18

local UI_20 = Instance.new('UIStroke')
UI_20.Name = 'UIStroke'
UI_20.Parent = UI_18

local UI_21 = Instance.new('TextLabel')
UI_21.Name = 'TextLabel'
UI_21.Parent = UI_18
UI_21.Size = UDim2.new(0, 175, 0, 25)
UI_21.Position = UDim2.new(0, 5, 0, 5)
UI_21.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_21.BackgroundTransparency = 1
UI_21.Text = '🎬 CONTROLS'
UI_21.TextColor3 = Color3.new(0.8627451062202454, 0.14901961386203766, 0.14901961386203766)
UI_21.TextScaled = false
UI_21.Font = Enum.Font.GothamBold
UI_21.Visible = true

local UI_22 = Instance.new('TextButton')
UI_22.Name = 'TextButton'
UI_22.Parent = UI_18
UI_22.Size = UDim2.new(0, 175, 0, 35)
UI_22.Position = UDim2.new(0, 5, 0, 35)
UI_22.BackgroundColor3 = Color3.new(0.8627451062202454, 0.14901961386203766, 0.14901961386203766)
UI_22.BackgroundTransparency = 0
UI_22.Text = '🔴 RECORD'
UI_22.TextColor3 = Color3.new(1, 1, 1)
UI_22.TextScaled = false
UI_22.Font = Enum.Font.GothamBold
UI_22.Visible = true

local UI_23 = Instance.new('UICorner')
UI_23.Name = 'UICorner'
UI_23.Parent = UI_22

local UI_24 = Instance.new('TextButton')
UI_24.Name = 'TextButton'
UI_24.Parent = UI_18
UI_24.Size = UDim2.new(0, 175, 0, 35)
UI_24.Position = UDim2.new(0, 5, 0, 75)
UI_24.BackgroundColor3 = Color3.new(0.9843137264251709, 0.572549045085907, 0.23529411852359772)
UI_24.BackgroundTransparency = 0
UI_24.Text = '🎯 RESUME'
UI_24.TextColor3 = Color3.new(1, 1, 1)
UI_24.TextScaled = false
UI_24.Font = Enum.Font.GothamBold
UI_24.Visible = true

local UI_25 = Instance.new('UICorner')
UI_25.Name = 'UICorner'
UI_25.Parent = UI_24

local UI_26 = Instance.new('TextLabel')
UI_26.Name = 'TextLabel'
UI_26.Parent = UI_18
UI_26.Size = UDim2.new(0, 175, 0, 20)
UI_26.Position = UDim2.new(0, 5, 0, 120)
UI_26.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_26.BackgroundTransparency = 1
UI_26.Text = '⚙️ PLAYBACK'
UI_26.TextColor3 = Color3.new(0.5882353186607361, 0.5882353186607361, 0.5882353186607361)
UI_26.TextScaled = false
UI_26.Font = Enum.Font.GothamBold
UI_26.Visible = true

local UI_27 = Instance.new('TextBox')
UI_27.Name = 'TextBox'
UI_27.Parent = UI_18
UI_27.Size = UDim2.new(0, 83, 0, 30)
UI_27.Position = UDim2.new(0, 5, 0, 145)
UI_27.BackgroundColor3 = Color3.new(0.10980392247438431, 0.10980392247438431, 0.10980392247438431)
UI_27.BackgroundTransparency = 0
UI_27.Text = '1.0'
UI_27.TextColor3 = Color3.new(1, 1, 1)
UI_27.TextScaled = false
UI_27.Font = Enum.Font.Gotham
UI_27.Visible = true

local UI_28 = Instance.new('UICorner')
UI_28.Name = 'UICorner'
UI_28.Parent = UI_27

local UI_29 = Instance.new('TextButton')
UI_29.Name = 'TextButton'
UI_29.Parent = UI_18
UI_29.Size = UDim2.new(0, 83, 0, 30)
UI_29.Position = UDim2.new(0, 97, 0, 145)
UI_29.BackgroundColor3 = Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886)
UI_29.BackgroundTransparency = 0
UI_29.Text = '🔁 OFF'
UI_29.TextColor3 = Color3.new(1, 1, 1)
UI_29.TextScaled = false
UI_29.Font = Enum.Font.Gotham
UI_29.Visible = true

local UI_30 = Instance.new('UICorner')
UI_30.Name = 'UICorner'
UI_30.Parent = UI_29

local UI_31 = Instance.new('TextLabel')
UI_31.Name = 'TextLabel'
UI_31.Parent = UI_18
UI_31.Size = UDim2.new(0, 175, 0, 20)
UI_31.Position = UDim2.new(0, 5, 0, 185)
UI_31.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_31.BackgroundTransparency = 1
UI_31.Text = '💾 SAVE'
UI_31.TextColor3 = Color3.new(0.5882353186607361, 0.5882353186607361, 0.5882353186607361)
UI_31.TextScaled = false
UI_31.Font = Enum.Font.GothamBold
UI_31.Visible = true

local UI_32 = Instance.new('TextBox')
UI_32.Name = 'TextBox'
UI_32.Parent = UI_18
UI_32.Size = UDim2.new(0, 175, 0, 30)
UI_32.Position = UDim2.new(0, 5, 0, 210)
UI_32.BackgroundColor3 = Color3.new(0.10980392247438431, 0.10980392247438431, 0.10980392247438431)
UI_32.BackgroundTransparency = 0
UI_32.Text = ''
UI_32.TextColor3 = Color3.new(1, 1, 1)
UI_32.TextScaled = false
UI_32.Font = Enum.Font.Gotham
UI_32.Visible = true

local UI_33 = Instance.new('UICorner')
UI_33.Name = 'UICorner'
UI_33.Parent = UI_32

local UI_34 = Instance.new('TextButton')
UI_34.Name = 'TextButton'
UI_34.Parent = UI_18
UI_34.Size = UDim2.new(0, 175, 0, 30)
UI_34.Position = UDim2.new(0, 5, 0, 247)
UI_34.BackgroundColor3 = Color3.new(0.13333334028720856, 0.772549033164978, 0.3686274588108063)
UI_34.BackgroundTransparency = 0
UI_34.Text = '💾 SAVE'
UI_34.TextColor3 = Color3.new(1, 1, 1)
UI_34.TextScaled = false
UI_34.Font = Enum.Font.GothamBold
UI_34.Visible = true

local UI_35 = Instance.new('UICorner')
UI_35.Name = 'UICorner'
UI_35.Parent = UI_34

local UI_36 = Instance.new('TextButton')
UI_36.Name = 'TextButton'
UI_36.Parent = UI_18
UI_36.Size = UDim2.new(0, 175, 0, 30)
UI_36.Position = UDim2.new(0, 5, 0, 247)
UI_36.BackgroundColor3 = Color3.new(0.9372549057006836, 0.2666666805744171, 0.2666666805744171)
UI_36.BackgroundTransparency = 0
UI_36.Text = '■ STOP'
UI_36.TextColor3 = Color3.new(1, 1, 1)
UI_36.TextScaled = false
UI_36.Font = Enum.Font.GothamBold
UI_36.Visible = false

local UI_37 = Instance.new('UICorner')
UI_37.Name = 'UICorner'
UI_37.Parent = UI_36

local UI_38 = Instance.new('Frame')
UI_38.Name = 'RightSidebar'
UI_38.Parent = UI_5
UI_38.Size = UDim2.new(0, 200, 0, 310)
UI_38.Position = UDim2.new(0, 195, 0, 45)
UI_38.BackgroundColor3 = Color3.new(0.0784313753247261, 0.0784313753247261, 0.0784313753247261)
UI_38.BackgroundTransparency = 0
UI_38.Visible = true

local UI_39 = Instance.new('UICorner')
UI_39.Name = 'UICorner'
UI_39.Parent = UI_38

local UI_40 = Instance.new('UIStroke')
UI_40.Name = 'UIStroke'
UI_40.Parent = UI_38

local UI_41 = Instance.new('Frame')
UI_41.Name = 'Frame'
UI_41.Parent = UI_38
UI_41.Size = UDim2.new(0, 190, 0, 25)
UI_41.Position = UDim2.new(0, 5, 0, 5)
UI_41.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_41.BackgroundTransparency = 1
UI_41.Visible = true

local UI_42 = Instance.new('TextLabel')
UI_42.Name = 'TextLabel'
UI_42.Parent = UI_41
UI_42.Size = UDim2.new(0, 88, 0, 25)
UI_42.Position = UDim2.new(0, 0, 0, 0)
UI_42.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_42.BackgroundTransparency = 1
UI_42.Text = '📂 CHECKPOINTS'
UI_42.TextColor3 = Color3.new(0.8627451062202454, 0.14901961386203766, 0.14901961386203766)
UI_42.TextScaled = false
UI_42.Font = Enum.Font.GothamBold
UI_42.Visible = true

local UI_43 = Instance.new('TextButton')
UI_43.Name = 'TextButton'
UI_43.Parent = UI_41
UI_43.Size = UDim2.new(0, 24, 0, 25)
UI_43.Position = UDim2.new(0, 90, 0, 0)
UI_43.BackgroundColor3 = Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886)
UI_43.BackgroundTransparency = 0
UI_43.Text = '🔄'
UI_43.TextColor3 = Color3.new(1, 1, 1)
UI_43.TextScaled = false
UI_43.Font = Enum.Font.Gotham
UI_43.Visible = true

local UI_44 = Instance.new('UICorner')
UI_44.Name = 'UICorner'
UI_44.Parent = UI_43

local UI_45 = Instance.new('TextButton')
UI_45.Name = 'TextButton'
UI_45.Parent = UI_41
UI_45.Size = UDim2.new(0, 44, 0, 25)
UI_45.Position = UDim2.new(0, 117, 0, 0)
UI_45.BackgroundColor3 = Color3.new(0.3921568691730499, 0.3921568691730499, 1)
UI_45.BackgroundTransparency = 0
UI_45.Text = '⚡Merge'
UI_45.TextColor3 = Color3.new(1, 1, 1)
UI_45.TextScaled = false
UI_45.Font = Enum.Font.Gotham
UI_45.Visible = true

local UI_46 = Instance.new('UICorner')
UI_46.Name = 'UICorner'
UI_46.Parent = UI_45

local UI_47 = Instance.new('TextButton')
UI_47.Name = 'TextButton'
UI_47.Parent = UI_41
UI_47.Size = UDim2.new(0, 24, 0, 25)
UI_47.Position = UDim2.new(0, 164, 0, 0)
UI_47.BackgroundColor3 = Color3.new(0.9372549057006836, 0.2666666805744171, 0.2666666805744171)
UI_47.BackgroundTransparency = 0
UI_47.Text = '🗑'
UI_47.TextColor3 = Color3.new(1, 1, 1)
UI_47.TextScaled = false
UI_47.Font = Enum.Font.Gotham
UI_47.Visible = true

local UI_48 = Instance.new('UICorner')
UI_48.Name = 'UICorner'
UI_48.Parent = UI_47

local UI_49 = Instance.new('Frame')
UI_49.Name = 'Frame'
UI_49.Parent = UI_38
UI_49.Size = UDim2.new(0, 190, 0, 26)
UI_49.Position = UDim2.new(0, 5, 0, 34)
UI_49.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_49.BackgroundTransparency = 1
UI_49.Visible = true

local UI_50 = Instance.new('TextBox')
UI_50.Name = 'TextBox'
UI_50.Parent = UI_49
UI_50.Size = UDim2.new(0, 156, 0, 26)
UI_50.Position = UDim2.new(0, 0, 0, 0)
UI_50.BackgroundColor3 = Color3.new(0.10980392247438431, 0.10980392247438431, 0.10980392247438431)
UI_50.BackgroundTransparency = 0
UI_50.Text = ''
UI_50.TextColor3 = Color3.new(1, 1, 1)
UI_50.TextScaled = false
UI_50.Font = Enum.Font.Gotham
UI_50.Visible = true

local UI_51 = Instance.new('UICorner')
UI_51.Name = 'UICorner'
UI_51.Parent = UI_50

local UI_52 = Instance.new('UIStroke')
UI_52.Name = 'UIStroke'
UI_52.Parent = UI_50

local UI_53 = Instance.new('TextButton')
UI_53.Name = 'TextButton'
UI_53.Parent = UI_49
UI_53.Size = UDim2.new(0, 30, 0, 26)
UI_53.Position = UDim2.new(0, 159, 0, 0)
UI_53.BackgroundColor3 = Color3.new(0.13333334028720856, 0.772549033164978, 0.3686274588108063)
UI_53.BackgroundTransparency = 0
UI_53.Text = '✓'
UI_53.TextColor3 = Color3.new(1, 1, 1)
UI_53.TextScaled = false
UI_53.Font = Enum.Font.GothamBold
UI_53.Visible = true

local UI_54 = Instance.new('UICorner')
UI_54.Name = 'UICorner'
UI_54.Parent = UI_53

local UI_55 = Instance.new('TextBox')
UI_55.Name = 'TextBox'
UI_55.Parent = UI_38
UI_55.Size = UDim2.new(0, 190, 0, 27)
UI_55.Position = UDim2.new(0, 5, 0, 64)
UI_55.BackgroundColor3 = Color3.new(0.10980392247438431, 0.10980392247438431, 0.10980392247438431)
UI_55.BackgroundTransparency = 0
UI_55.Text = ''
UI_55.TextColor3 = Color3.new(1, 1, 1)
UI_55.TextScaled = false
UI_55.Font = Enum.Font.Gotham
UI_55.Visible = true

local UI_56 = Instance.new('UICorner')
UI_56.Name = 'UICorner'
UI_56.Parent = UI_55

local UI_57 = Instance.new('ScrollingFrame')
UI_57.Name = 'ScrollingFrame'
UI_57.Parent = UI_38
UI_57.Size = UDim2.new(0, 190, 0, 200)
UI_57.Position = UDim2.new(0, 5, 0, 96)
UI_57.BackgroundColor3 = Color3.new(0.05882352963089943, 0.05882352963089943, 0.05882352963089943)
UI_57.BackgroundTransparency = 0
UI_57.Visible = true

local UI_58 = Instance.new('UICorner')
UI_58.Name = 'UICorner'
UI_58.Parent = UI_57

local UI_59 = Instance.new('UIListLayout')
UI_59.Name = 'UIListLayout'
UI_59.Parent = UI_57

local UI_60 = Instance.new('UIPadding')
UI_60.Name = 'UIPadding'
UI_60.Parent = UI_57

local UI_61 = Instance.new('Frame')
UI_61.Name = 'Frame'
UI_61.Parent = UI_5
UI_61.Size = UDim2.new(0, 185, 0, 3)
UI_61.Position = UDim2.new(0, 5, 0, 350)
UI_61.BackgroundColor3 = Color3.new(0.13333334028720856, 0.772549033164978, 0.3686274588108063)
UI_61.BackgroundTransparency = 0
UI_61.Visible = true

local UI_62 = Instance.new('UICorner')
UI_62.Name = 'UICorner'
UI_62.Parent = UI_61

local UI_63 = Instance.new('Frame')
UI_63.Name = 'MergePopup'
UI_63.Parent = UI_5
UI_63.Size = UDim2.new(1, 0, 1, 0)
UI_63.Position = UDim2.new(0, 0, 0, 0)
UI_63.BackgroundColor3 = Color3.new(0, 0, 0)
UI_63.BackgroundTransparency = 0.6000000238418579
UI_63.Visible = false

local UI_64 = Instance.new('Frame')
UI_64.Name = 'Frame'
UI_64.Parent = UI_63
UI_64.Size = UDim2.new(0, 350, 0, 250)
UI_64.Position = UDim2.new(0.5, -175, 0.5, -125)
UI_64.BackgroundColor3 = Color3.new(0.05882352963089943, 0.05882352963089943, 0.05882352963089943)
UI_64.BackgroundTransparency = 0
UI_64.Visible = true

local UI_65 = Instance.new('UICorner')
UI_65.Name = 'UICorner'
UI_65.Parent = UI_64

local UI_66 = Instance.new('UIStroke')
UI_66.Name = 'UIStroke'
UI_66.Parent = UI_64

local UI_67 = Instance.new('TextLabel')
UI_67.Name = 'TextLabel'
UI_67.Parent = UI_64
UI_67.Size = UDim2.new(0, 330, 0, 35)
UI_67.Position = UDim2.new(0, 10, 0, 10)
UI_67.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_67.BackgroundTransparency = 1
UI_67.Text = '⚡ Auto Merge All Checkpoints'
UI_67.TextColor3 = Color3.new(0.8627451062202454, 0.14901961386203766, 0.14901961386203766)
UI_67.TextScaled = false
UI_67.Font = Enum.Font.GothamBold
UI_67.Visible = true

local UI_68 = Instance.new('TextLabel')
UI_68.Name = 'TextLabel'
UI_68.Parent = UI_64
UI_68.Size = UDim2.new(0, 330, 0, 40)
UI_68.Position = UDim2.new(0, 10, 0, 50)
UI_68.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_68.BackgroundTransparency = 1
UI_68.Text = 'All JSON files will be merged automatically in sorted order. Enter custom name or leave blank for auto-name.'
UI_68.TextColor3 = Color3.new(0.5882353186607361, 0.5882353186607361, 0.5882353186607361)
UI_68.TextScaled = false
UI_68.Font = Enum.Font.Gotham
UI_68.Visible = true

local UI_69 = Instance.new('TextLabel')
UI_69.Name = 'TextLabel'
UI_69.Parent = UI_64
UI_69.Size = UDim2.new(0, 330, 0, 25)
UI_69.Position = UDim2.new(0, 10, 0, 100)
UI_69.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_69.BackgroundTransparency = 1
UI_69.Text = '📝 Output Name:'
UI_69.TextColor3 = Color3.new(1, 1, 1)
UI_69.TextScaled = false
UI_69.Font = Enum.Font.GothamBold
UI_69.Visible = true

local UI_70 = Instance.new('TextBox')
UI_70.Name = 'MergeNameInput'
UI_70.Parent = UI_64
UI_70.Size = UDim2.new(0, 330, 0, 40)
UI_70.Position = UDim2.new(0, 10, 0, 130)
UI_70.BackgroundColor3 = Color3.new(0.10980392247438431, 0.10980392247438431, 0.10980392247438431)
UI_70.BackgroundTransparency = 0
UI_70.Text = ''
UI_70.TextColor3 = Color3.new(1, 1, 1)
UI_70.TextScaled = false
UI_70.Font = Enum.Font.Gotham
UI_70.Visible = true

local UI_71 = Instance.new('UICorner')
UI_71.Name = 'UICorner'
UI_71.Parent = UI_70

local UI_72 = Instance.new('UIStroke')
UI_72.Name = 'UIStroke'
UI_72.Parent = UI_70

local UI_73 = Instance.new('TextButton')
UI_73.Name = 'TextButton'
UI_73.Parent = UI_64
UI_73.Size = UDim2.new(0, 155, 0, 40)
UI_73.Position = UDim2.new(0, 10, 0, 190)
UI_73.BackgroundColor3 = Color3.new(0.13333334028720856, 0.772549033164978, 0.3686274588108063)
UI_73.BackgroundTransparency = 0
UI_73.Text = '✓ Merge Now'
UI_73.TextColor3 = Color3.new(1, 1, 1)
UI_73.TextScaled = false
UI_73.Font = Enum.Font.GothamBold
UI_73.Visible = true

local UI_74 = Instance.new('UICorner')
UI_74.Name = 'UICorner'
UI_74.Parent = UI_73

local UI_75 = Instance.new('TextButton')
UI_75.Name = 'TextButton'
UI_75.Parent = UI_64
UI_75.Size = UDim2.new(0, 155, 0, 40)
UI_75.Position = UDim2.new(0, 175, 0, 190)
UI_75.BackgroundColor3 = Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886)
UI_75.BackgroundTransparency = 0
UI_75.Text = 'X Cancel'
UI_75.TextColor3 = Color3.new(1, 1, 1)
UI_75.TextScaled = false
UI_75.Font = Enum.Font.GothamBold
UI_75.Visible = true

local UI_76 = Instance.new('UICorner')
UI_76.Name = 'UICorner'
UI_76.Parent = UI_75

local UI_77 = Instance.new('Frame')
UI_77.Name = 'ConfirmDialog'
UI_77.Parent = UI_5
UI_77.Size = UDim2.new(1, 0, 1, 0)
UI_77.Position = UDim2.new(0, 0, 0, 0)
UI_77.BackgroundColor3 = Color3.new(0, 0, 0)
UI_77.BackgroundTransparency = 0.6000000238418579
UI_77.Visible = false

local UI_78 = Instance.new('Frame')
UI_78.Name = 'Frame'
UI_78.Parent = UI_77
UI_78.Size = UDim2.new(0, 280, 0, 120)
UI_78.Position = UDim2.new(0.5, -140, 0.5, -60)
UI_78.BackgroundColor3 = Color3.new(0.05882352963089943, 0.05882352963089943, 0.05882352963089943)
UI_78.BackgroundTransparency = 0
UI_78.Visible = true

local UI_79 = Instance.new('UICorner')
UI_79.Name = 'UICorner'
UI_79.Parent = UI_78

local UI_80 = Instance.new('UIStroke')
UI_80.Name = 'UIStroke'
UI_80.Parent = UI_78

local UI_81 = Instance.new('TextLabel')
UI_81.Name = 'DialogMessage'
UI_81.Parent = UI_78
UI_81.Size = UDim2.new(0, 260, 0, 60)
UI_81.Position = UDim2.new(0, 10, 0, 10)
UI_81.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_81.BackgroundTransparency = 1
UI_81.Text = 'Delete this checkpoint?'
UI_81.TextColor3 = Color3.new(1, 1, 1)
UI_81.TextScaled = false
UI_81.Font = Enum.Font.Gotham
UI_81.Visible = true

local UI_82 = Instance.new('TextButton')
UI_82.Name = 'ConfirmDelete'
UI_82.Parent = UI_78
UI_82.Size = UDim2.new(0, 125, 0, 35)
UI_82.Position = UDim2.new(0, 10, 0, 75)
UI_82.BackgroundColor3 = Color3.new(0.9372549057006836, 0.2666666805744171, 0.2666666805744171)
UI_82.BackgroundTransparency = 0
UI_82.Text = '✓ Delete'
UI_82.TextColor3 = Color3.new(1, 1, 1)
UI_82.TextScaled = false
UI_82.Font = Enum.Font.Gotham
UI_82.Visible = true

local UI_83 = Instance.new('UICorner')
UI_83.Name = 'UICorner'
UI_83.Parent = UI_82

local UI_84 = Instance.new('TextButton')
UI_84.Name = 'CancelDelete'
UI_84.Parent = UI_78
UI_84.Size = UDim2.new(0, 125, 0, 35)
UI_84.Position = UDim2.new(0, 145, 0, 75)
UI_84.BackgroundColor3 = Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886)
UI_84.BackgroundTransparency = 0
UI_84.Text = 'X Cancel'
UI_84.TextColor3 = Color3.new(1, 1, 1)
UI_84.TextScaled = false
UI_84.Font = Enum.Font.Gotham
UI_84.Visible = true

local UI_85 = Instance.new('UICorner')
UI_85.Name = 'UICorner'
UI_85.Parent = UI_84

local UI_86 = Instance.new('Frame')
UI_86.Name = 'ConfirmDeleteAllDialog'
UI_86.Parent = UI_5
UI_86.Size = UDim2.new(1, 0, 1, 0)
UI_86.Position = UDim2.new(0, 0, 0, 0)
UI_86.BackgroundColor3 = Color3.new(0, 0, 0)
UI_86.BackgroundTransparency = 0.5
UI_86.Visible = false

local UI_87 = Instance.new('Frame')
UI_87.Name = 'Frame'
UI_87.Parent = UI_86
UI_87.Size = UDim2.new(0, 310, 0, 140)
UI_87.Position = UDim2.new(0.5, -155, 0.5, -70)
UI_87.BackgroundColor3 = Color3.new(0.05882352963089943, 0.05882352963089943, 0.05882352963089943)
UI_87.BackgroundTransparency = 0
UI_87.Visible = true

local UI_88 = Instance.new('UICorner')
UI_88.Name = 'UICorner'
UI_88.Parent = UI_87

local UI_89 = Instance.new('UIStroke')
UI_89.Name = 'UIStroke'
UI_89.Parent = UI_87

local UI_90 = Instance.new('TextLabel')
UI_90.Name = 'TextLabel'
UI_90.Parent = UI_87
UI_90.Size = UDim2.new(0, 290, 0, 80)
UI_90.Position = UDim2.new(0, 10, 0, 10)
UI_90.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_90.BackgroundTransparency = 1
UI_90.Text = '⚠ DELETE ALL CHECKPOINTS?

Semua file .json di folder aktif akan dihapus secara permanen. Tindakan ini tidak bisa dibatalkan!'
UI_90.TextColor3 = Color3.new(1, 1, 1)
UI_90.TextScaled = false
UI_90.Font = Enum.Font.Gotham
UI_90.Visible = true

local UI_91 = Instance.new('TextButton')
UI_91.Name = 'TextButton'
UI_91.Parent = UI_87
UI_91.Size = UDim2.new(0, 140, 0, 38)
UI_91.Position = UDim2.new(0, 10, 0, 93)
UI_91.BackgroundColor3 = Color3.new(0.9372549057006836, 0.2666666805744171, 0.2666666805744171)
UI_91.BackgroundTransparency = 0
UI_91.Text = '🗑 DELETE ALL'
UI_91.TextColor3 = Color3.new(1, 1, 1)
UI_91.TextScaled = false
UI_91.Font = Enum.Font.GothamBold
UI_91.Visible = true

local UI_92 = Instance.new('UICorner')
UI_92.Name = 'UICorner'
UI_92.Parent = UI_91

local UI_93 = Instance.new('TextButton')
UI_93.Name = 'TextButton'
UI_93.Parent = UI_87
UI_93.Size = UDim2.new(0, 140, 0, 38)
UI_93.Position = UDim2.new(0, 160, 0, 93)
UI_93.BackgroundColor3 = Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886)
UI_93.BackgroundTransparency = 0
UI_93.Text = 'X Cancel'
UI_93.TextColor3 = Color3.new(1, 1, 1)
UI_93.TextScaled = false
UI_93.Font = Enum.Font.GothamBold
UI_93.Visible = true

local UI_94 = Instance.new('UICorner')
UI_94.Name = 'UICorner'
UI_94.Parent = UI_93

local UI_95 = Instance.new('Frame')
UI_95.Name = 'RecordingIndicator'
UI_95.Parent = UI_1
UI_95.Size = UDim2.new(0, 60, 0, 60)
UI_95.Position = UDim2.new(0, 20, 0, 100)
UI_95.BackgroundColor3 = Color3.new(0.9372549057006836, 0.2666666805744171, 0.2666666805744171)
UI_95.BackgroundTransparency = 0
UI_95.Visible = false

local UI_96 = Instance.new('UICorner')
UI_96.Name = 'UICorner'
UI_96.Parent = UI_95

local UI_97 = Instance.new('UIStroke')
UI_97.Name = 'UIStroke'
UI_97.Parent = UI_95

local UI_98 = Instance.new('TextLabel')
UI_98.Name = 'TextLabel'
UI_98.Parent = UI_95
UI_98.Size = UDim2.new(1, 0, 1, 0)
UI_98.Position = UDim2.new(0, 0, 0, 0)
UI_98.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_98.BackgroundTransparency = 1
UI_98.Text = '🔴'
UI_98.TextColor3 = Color3.new(0.10588236153125763, 0.16470588743686676, 0.20784315466880798)
UI_98.TextScaled = false
UI_98.Font = Enum.Font.Gotham
UI_98.Visible = true

local UI_99 = Instance.new('TextButton')
UI_99.Name = 'TextButton'
UI_99.Parent = UI_95
UI_99.Size = UDim2.new(1, 0, 1, 0)
UI_99.Position = UDim2.new(0, 0, 0, 0)
UI_99.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_99.BackgroundTransparency = 1
UI_99.Text = ''
UI_99.TextColor3 = Color3.new(0.10588236153125763, 0.16470588743686676, 0.20784315466880798)
UI_99.TextScaled = false
UI_99.Font = Enum.Font.Legacy
UI_99.Visible = true

local UI_100 = Instance.new('Frame')
UI_100.Name = 'RollbackButton'
UI_100.Parent = UI_1
UI_100.Size = UDim2.new(0, 60, 0, 60)
UI_100.Position = UDim2.new(0, 90, 0, 100)
UI_100.BackgroundColor3 = Color3.new(0.9843137264251709, 0.572549045085907, 0.23529411852359772)
UI_100.BackgroundTransparency = 0
UI_100.Visible = false

local UI_101 = Instance.new('UICorner')
UI_101.Name = 'UICorner'
UI_101.Parent = UI_100

local UI_102 = Instance.new('UIStroke')
UI_102.Name = 'UIStroke'
UI_102.Parent = UI_100

local UI_103 = Instance.new('TextLabel')
UI_103.Name = 'TextLabel'
UI_103.Parent = UI_100
UI_103.Size = UDim2.new(1, 0, 1, 0)
UI_103.Position = UDim2.new(0, 0, 0, 0)
UI_103.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_103.BackgroundTransparency = 1
UI_103.Text = '⏪'
UI_103.TextColor3 = Color3.new(0.10588236153125763, 0.16470588743686676, 0.20784315466880798)
UI_103.TextScaled = false
UI_103.Font = Enum.Font.Gotham
UI_103.Visible = true

local UI_104 = Instance.new('TextButton')
UI_104.Name = 'TextButton'
UI_104.Parent = UI_100
UI_104.Size = UDim2.new(1, 0, 1, 0)
UI_104.Position = UDim2.new(0, 0, 0, 0)
UI_104.BackgroundColor3 = Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452)
UI_104.BackgroundTransparency = 1
UI_104.Text = ''
UI_104.TextColor3 = Color3.new(0.10588236153125763, 0.16470588743686676, 0.20784315466880798)
UI_104.TextScaled = false
UI_104.Font = Enum.Font.Legacy
UI_104.Visible = true

