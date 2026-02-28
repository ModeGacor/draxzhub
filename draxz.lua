local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👾DRAXZHUB SCRIPT👾",
   Icon = 0,
   LoadingTitle = "DRAXZHUB",
   LoadingSubtitle = "by Draxz",
   ShowText = "DraxzHub",
   Theme = "Default",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Youtubedraxzoffc25"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil)
local Section = MainTab:CreateSection("Fly Script")

Rayfield:Notify({
   Title = "Berhasil execute script",
   Content = "DRAXZHUB",
   Duration = 5,
   Image = nil,
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart")

local FLY_SPEED = 80
local isFlying = false
local flyConn = nil
local bv, bg = nil, nil

-- Hapus GUI lama
if game.CoreGui:FindFirstChild("FlyGUI") then
    game.CoreGui.FlyGUI:Destroy()
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Position = UDim2.new(0, 20, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local gradient = Instance.new("UIGradient", Main)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 18))
})
gradient.Rotation = 135

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleFix = Instance.new("Frame", TitleBar)
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TitleFix.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✈️  FLY SCRIPT"
Title.TextColor3 = Color3.fromRGB(120, 180, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.white
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local StatusLabel = Instance.new("TextLabel", Main)
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: OFF"
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local FlyBtn = Instance.new("TextButton", Main)
FlyBtn.Size = UDim2.new(1, -20, 0, 45)
FlyBtn.Position = UDim2.new(0, 10, 0, 90)
FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
FlyBtn.Text = "▶  ENABLE FLY"
FlyBtn.TextColor3 = Color3.fromRGB(120, 200, 120)
FlyBtn.TextScaled = true
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.BorderSizePixel = 0
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 8)

local SpeedLabel = Instance.new("TextLabel", Main)
SpeedLabel.Size = UDim2.new(1, -20, 0, 25)
SpeedLabel.Position = UDim2.new(0, 10, 0, 148)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 80"
SpeedLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SpeedLabel.TextScaled = true
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SliderBg = Instance.new("Frame", Main)
SliderBg.Size = UDim2.new(1, -20, 0, 16)
SliderBg.Position = UDim2.new(0, 10, 0, 178)
SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SliderBg.BorderSizePixel = 0
Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 8)

local SliderFill = Instance.new("Frame", SliderBg)
SliderFill.Size = UDim2.new(0.4, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
SliderFill.BorderSizePixel = 0
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 8)

local Knob = Instance.new("Frame", SliderBg)
Knob.Size = UDim2.new(0, 18, 0, 18)
Knob.Position = UDim2.new(0.4, -9, 0.5, -9)
Knob.BackgroundColor3 = Color3.white
Knob.BorderSizePixel = 0
Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

local dragging = false
Knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local sliderPos = SliderBg.AbsolutePosition.X
        local sliderWidth = SliderBg.AbsoluteSize.X
        local mouseX = input.Position.X
        local percent = math.clamp((mouseX - sliderPos) / sliderWidth, 0, 1)
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        Knob.Position = UDim2.new(percent, -9, 0.5, -9)
        FLY_SPEED = math.floor(20 + (percent * 180))
        SpeedLabel.Text = "Speed: " .. FLY_SPEED
    end
end)

local KeyLabel = Instance.new("TextLabel", Main)
KeyLabel.Size = UDim2.new(1, -20, 0, 25)
KeyLabel.Position = UDim2.new(0, 10, 0, 205)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Text = "Keyboard: [ F ] to toggle"
KeyLabel.TextColor3 = Color3.fromRGB(120, 120, 150)
KeyLabel.TextScaled = true
KeyLabel.Font = Enum.Font.Gotham
KeyLabel.TextXAlignment = Enum.TextXAlignment.Left

local ControlLabel = Instance.new("TextLabel", Main)
ControlLabel.Size = UDim2.new(1, -20, 0, 50)
ControlLabel.Position = UDim2.new(0, 10, 0, 225)
ControlLabel.BackgroundTransparency = 1
ControlLabel.Text = "WASD = Gerak  |  Space = Naik\nCtrl = Turun"
ControlLabel.TextColor3 = Color3.fromRGB(100, 100, 130)
ControlLabel.TextScaled = true
ControlLabel.Font = Enum.Font.Gotham

-- Fly Functions
local function Fly()
    character = player.Character
    humanoid = character:FindFirstChildOfClass("Humanoid")
    rootPart = character:FindFirstChild("HumanoidRootPart")

    isFlying = true
    humanoid.PlatformStand = true

    bv = Instance.new("BodyVelocity", rootPart)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

    bg = Instance.new("BodyGyro", rootPart)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 9000

    flyConn = RunService.Heartbeat:Connect(function()
        local cam = workspace.CurrentCamera
        local dir = Vector3.new(0, 0, 0)

        -- FIX: ganti += jadi = ... + ...
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            dir = dir + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            dir = dir - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            dir = dir - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            dir = dir + cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            dir = dir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            dir = dir - Vector3.new(0, 1, 0)
        end

        if dir.Magnitude > 0 then
            bv.Velocity = dir.Unit * FLY_SPEED
        else
            bv.Velocity = Vector3.new(0, 0, 0)
        end
        bg.CFrame = cam.CFrame
    end)

    FlyBtn.Text = "⏹  DISABLE FLY"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 80, 50)
    FlyBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    StatusLabel.Text = "Status: ON ✅"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end

local function UnFly()
    isFlying = false
    if humanoid then humanoid.PlatformStand = false end
    if flyConn then flyConn:Disconnect() end
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    bv, bg, flyConn = nil, nil, nil

    FlyBtn.Text = "▶  ENABLE FLY"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    FlyBtn.TextColor3 = Color3.fromRGB(120, 200, 120)
    StatusLabel.Text = "Status: OFF"
    StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
end

FlyBtn.MouseButton1Click:Connect(function()
    if isFlying then UnFly() else Fly() end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        if isFlying then UnFly() else Fly() end
    end
end)

print("✈️ Fly GUI loaded!")
