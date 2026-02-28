local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👾DRAXZHUB SCRIPT👾",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "DRAXZHUB",
   LoadingSubtitle = "by Draxz",
   ShowText = "DraxzHub", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
  DisableBuildWarnings = false, -- ← TAMBAH KOMA DI SINI

ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Youtubedraxzoffc25"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil) -- Title, Image
local Section = MainTab:CreateSection("Section Example")

Rayfield:Notify({
   Title = "Berhasil excetuce script",
   Content = "DRAXZHUB",
   Duration = 5,
   Image = nill,
})

local Button = MainTab:CreateButton({
   Name = "Infinite Jump",
   Callback = function()
       --Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
	--Ensures this only runs once to save resources
	_G.infinJumpStarted = true
	
	--Notifies readiness
	game.StarterGui:SetCore("SendNotification", {Title="Youtube Hub"; Text="Infinite Jump Activated!"; Duration=5;})

	--The actual infinite jump
	local plr = game:GetService('Players').LocalPlayer
	local m = plr:GetMouse()
	m.KeyDown:connect(function(k)
		if _G.infinjump then
			if k:byte() == 32 then
			humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
			humanoid:ChangeState('Jumping')
			wait()
			humanoid:ChangeState('Seated')
			end
		end
	end)
end
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local EspTab = Window:CreateTab("💕 ESP MENU 💕", nil) -- Title, Image
    local Section = EspTab:CreateSection("ESP MENU")

local Players = game:GetService("Players"):GetChildren() 
local RunService = game:GetService("RunService") 
local highlight = Instance.new("Highlight") 
highlight.Name = "Highlight" 
 
for i, v in pairs(Players) do 
    repeat wait() until v.Character 
    if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then 
        local highlightClone = highlight:Clone() 
        highlightClone.Adornee = v.Character 
        highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart") 
        highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop 
        highlightClone.Name = "Highlight" 
    end 
end 
 
game.Players.PlayerAdded:Connect(function(player) 
    repeat wait() until player.Character 
    if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then 
        local highlightClone = highlight:Clone() 
        highlightClone.Adornee = player.Character 
        highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart") 
        highlightClone.Name = "Highlight" 
    end 
end) 
 
game.Players.PlayerRemoving:Connect(function(playerRemoved) 
    playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy() 
end) 
 
RunService.Heartbeat:Connect(function() 
    for i, v in pairs(Players) do 
        repeat wait() until v.Character 
        if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then 
            local highlightClone = highlight:Clone() 
            highlightClone.Adornee = v.Character 
            highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart") 
            highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop 
            highlightClone.Name = "Highlight" 
            task.wait() 
        end 
end 
end)
  
-- Advanced Lock-On Script (With Visibility Check + UI Indicator)
 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
 
local LockOnEnabled = false
local LockOnRange = 100
local Target = nil
 
-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockOnUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
 
-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "LockOnToggle"
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(1, -130, 1, -60)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Text = "Lock-On: OFF"
toggleButton.TextSize = 18
toggleButton.Parent = screenGui
 
-- Target Indicator (Red Box)
local targetIndicator = Instance.new("Frame")
targetIndicator.Name = "TargetIndicator"
targetIndicator.Size = UDim2.new(0, 40, 0, 40)
targetIndicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
targetIndicator.BorderSizePixel = 2
targetIndicator.Visible = false
targetIndicator.BackgroundTransparency = 0.3
targetIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
targetIndicator.Parent = screenGui
 
-- Function to check if a part is on screen and visible
local function isOnScreen(part)
 local vector, onScreen = Camera:WorldToViewportPoint(part.Position)
 return onScreen and vector.Z > 0
end
 
-- Get Closest Visible Player
local function getClosestVisiblePlayer()
 local closestDistance = LockOnRange
 local closestCharacter = nil
 
 for _, player in pairs(Players:GetPlayers()) do
  if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
   local head = player.Character.Head
   if isOnScreen(head) then
    local myHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
    if myHead then
     local distance = (head.Position - myHead.Position).Magnitude
     if distance < closestDistance then
      closestDistance = distance
      closestCharacter = player.Character
     end
    end
   end
  end
 end
 
 return closestCharacter
end
 
-- Toggle Button Functionality
toggleButton.MouseButton1Click:Connect(function()
 LockOnEnabled = not LockOnEnabled
 toggleButton.Text = "Lock-On: " .. (LockOnEnabled and "ON" or "OFF")
 if LockOnEnabled then
  Target = getClosestVisiblePlayer()
 else
  Target = nil
  targetIndicator.Visible = false
 end
end)
 
-- Main Lock-On Loop
RunService.RenderStepped:Connect(function()
 if LockOnEnabled then
  if not Target or not Target:FindFirstChild("Head") or not isOnScreen(Target.Head) then
   Target = getClosestVisiblePlayer()
   if not Target then
    targetIndicator.Visible = false
    return
   end
  end
 
  -- Rotate camera to face the target's head
  local headPos = Target.Head.Position
  local camPos = Camera.CFrame.Position
  Camera.CFrame = CFrame.new(camPos, headPos)
 
  -- UI Indicator positioning
  local screenPos, onScreen = Camera:WorldToViewportPoint(Target.Head.Position)
  if onScreen then
   targetIndicator.Visible = true
   targetIndicator.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)
  else
   targetIndicator.Visible = false
  end
 else
  targetIndicator.Visible = false
 end
end)

local player = game:GetService("Players").LocalPlayer
local character = player:WaitForChild("Character")

local Tool = script.Parent

local equipped
Tool.Equipped:Connect(function()
    equipped = true
 if character then
        while equipped == true do
            character.Humanoid.Health = 100
        end
 end
end)

Tool.Unequipped:Connect(function()
    equipped = false
end)
