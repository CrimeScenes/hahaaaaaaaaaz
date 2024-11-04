if delusion.IntroSettings.Intro then 
        local cam = workspace.CurrentCamera
        local x = cam.ViewportSize.X
        local y = cam.ViewportSize.Y
        local newx = math.floor(x * 0.5)
        local newy = math.floor(y * 0.5)
        local SplashScreen = Instance.new("ScreenGui")
        local Image = Instance.new("ImageLabel")
        SplashScreen.Name = "SplashScreen"
        SplashScreen.Parent = game.CoreGui
        SplashScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
        Image.Name = "Image"
        Image.Parent = SplashScreen
        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Image.BackgroundTransparency = 1
        Image.Position = UDim2.new(0, newx, 0, newy)
        Image.Size = UDim2.new(0, 825, 0, 377)
        Image.Image = delusion.IntroSettings.IntroID
        Image.ImageTransparency = 1
        Image.AnchorPoint = Vector2.new(0.5, 0.5)
    
        local Blur = Instance.new("BlurEffect")
        Blur.Parent = game.Lighting
        Blur.Size = 0
        Blur.Name = "IntroBlur"
    
        local function gui(element, properties, duration, easingStyle, easingDirection)
            local tweenInfo = TweenInfo.new(duration or 1, easingStyle or Enum.EasingStyle.Sine, easingDirection or Enum.EasingDirection.InOut)
            local tween = game:GetService("TweenService"):Create(element, tweenInfo, properties)
            tween:Play()
            return tween
        end
    
        gui(Image, {ImageTransparency = 0}, 0.3) 
        gui(Blur, {Size = 20}, 0.3)              
        wait(3)                                  
        gui(Image, {ImageTransparency = 1}, 0.3)  
        gui(Blur, {Size = 0}, 0.3)            
        wait(0.3)                               
    end
    
    wait(0.5)

if (not getgenv().Loaded) then
local userInputService = game:GetService("UserInputService")

local function CheckAnti(Plr) -- // Anti-aim detection
    if Plr.Character.HumanoidRootPart.Velocity.Y < -70 then
        return true
    elseif Plr and (Plr.Character.HumanoidRootPart.Velocity.X > 450 or Plr.Character.HumanoidRootPart.Velocity.X < -35) then
        return true
    elseif Plr and Plr.Character.HumanoidRootPart.Velocity.Y > 60 then
        return true
    elseif Plr and (Plr.Character.HumanoidRootPart.Velocity.Z > 35 or Plr.Character.HumanoidRootPart.Velocity.Z < -35) then
        return true
    else
        return false
    end
end

local function getnamecall()
    if game.PlaceId == 2788229376 then
        return "UpdateMousePosI2"
    elseif game.PlaceId == 5602055394 or game.PlaceId == 7951883376 then
        return "MousePos"
    elseif game.PlaceId == 9825515356 then
        return "GetMousePos"
    end
end

function MainEventLocate()
    for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v.Name == "MainEvent" then
            return v
        end
    end
end


local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local MainEvent           = ReplicatedStorage:FindFirstChild("MainEvent")


local Locking = false
local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local Plr = nil -- Initialize Plr here

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local SpeedGlitch = false
local Mouse = game.Players.LocalPlayer:GetMouse()


UserInputService.InputBegan:Connect(OnKeyPress)

UserInputService.InputBegan:Connect(function(keygo, ok)
    if (not ok) then
        if (keygo.KeyCode == getgenv().delusion.Combat.Keybind) then
            Locking = not Locking
            if Locking then
                Plr = getClosestPlayerToCursor()
            elseif not Locking then
                if Plr then
                    Plr = nil
                end
            end
        end
    end
end)

function getClosestPlayerToCursor()
    local closestDist = math.huge
    local closestPlr = nil
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= Client and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local screenPos, cameraVisible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if cameraVisible then
                local distToMouse = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if distToMouse < closestDist then
                    closestPlr = v
                    closestDist = distToMouse
                end
            end
        end
    end
    return closestPlr
end

function getClosestPartToCursor(Player)
    local closestPart, closestDist = nil, math.huge
    if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("Head") and Player.Character.Humanoid.Health ~= 0 and Player.Character:FindFirstChild("HumanoidRootPart") then
        for i, part in pairs(Player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                local screenPos, cameraVisible = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                local distToMouse = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if distToMouse < closestDist and table.find(getgenv().delusion.Combat.MultipleTargetPart, part.Name) then
                    closestPart = part
                    closestDist = distToMouse
                end
            end
        end
        return closestPart
    end
end


local function getVelocity(Player)
    local Old = Player.Character.HumanoidRootPart.Position
    wait(0.145)
    local Current = Player.Character.HumanoidRootPart.Position
    return (Current - Old) / 0.145
end

local function GetShakedVector3(Setting)
    return Vector3.new(math.random(-Setting * 1e9, Setting * 1e9), math.random(-Setting * 1e9, Setting * 1e9), math.random(-Setting * 1e9, Setting * 1e9)) / 1e9;
end

local v = nil
game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
    if Plr ~= nil and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
        v = getVelocity(Plr)
    end
end)

local mainevent = game:GetService("ReplicatedStorage").MainEvent

Client.Character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and child:FindFirstChild("MaxAmmo") then
        child.Activated:Connect(function()
            if Plr and Plr.Character then
                local Position = Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and Plr.Character[getgenv().delusion.Combat.Part].Position + Vector3.new(0, getgenv().delusion.Offsets.JumpOffset, 0) or Plr.Character[getgenv().delusion.Combat.Part].Position
                if not CheckAnti(Plr) then
                    mainevent:FireServer("UpdateMousePosI2", Position + ((Plr.Character.HumanoidRootPart.Velocity) * getgenv().delusion.Silent.Prediction))
                else
                    mainevent:FireServer("UpdateMousePosI2", Position + ((Plr.Character.Humanoid.MoveDirection * Plr.Character.Humanoid.WalkSpeed) * getgenv().delusion.Silent.Prediction))
                end
            end
        end)
    end
end)

Client.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") and child:FindFirstChild("MaxAmmo") then
            child.Activated:Connect(function()
                if Plr and Plr.Character then
                    local Position = Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and Plr.Character[getgenv().delusion.Combat.Part].Position + Vector3.new(0, getgenv().delusion.Offsets.JumpOffset, 0) or Plr.Character[getgenv().delusion.Combat.Part].Position
                    if not CheckAnti(Plr) then
                        mainevent:FireServer("UpdateMousePosI2", Position + ((Plr.Character.HumanoidRootPart.Velocity) * getgenv().delusion.Silent.Silent.Prediction))
                    else
                        mainevent:FireServer("UpdateMousePosI2", Position + ((Plr.Character.Humanoid.MoveDirection * Plr.Character.Humanoid.WalkSpeed) * getgenv().delusion.Silent.Prediction))
                    end
                end
            end)
        end
    end)
end)

local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function()
    if Plr and Plr.Character then
        local humanoid = Plr.Character:FindFirstChild("Humanoid")
        local targetPart = Plr.Character:FindFirstChild(getgenv().delusion.Combat.Part)
        
        if humanoid and targetPart then
      
            local Position = (humanoid:GetState() == Enum.HumanoidStateType.Freefall)
                and targetPart.Position + Vector3.new(0, getgenv().delusion.Offsets.JumpOffset, 0)
                or targetPart.Position
            
            local Main
            if not CheckAnti(Plr) then
                Main = CFrame.new(
                    workspace.CurrentCamera.CFrame.p,
                    Position + ((Plr.Character.HumanoidRootPart.Velocity) * getgenv().delusion.Silent.Prediction) 
                    + GetShakedVector3(getgenv().delusion.Shake.CameraShake)
                )
            else
                Main = CFrame.new(
                    workspace.CurrentCamera.CFrame.p,
                    Position + ((Plr.Character.Humanoid.MoveDirection * Plr.Character.Humanoid.WalkSpeed) * getgenv().delusion.Silent.Prediction) 
                    + GetShakedVector3(getgenv().delusion.Shake.CameraShake)
                )
            end

            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(
                Main, getgenv().delusion.Smoothness.Amount, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut
            )
        end
    end

    if getgenv().delusion.Checks.CheckKoStatus and Plr and Plr.Character then
        local bodyEffects = Plr.Character:FindFirstChild("BodyEffects")
        local humanoid = Plr.Character:FindFirstChild("Humanoid")
        local koValue = bodyEffects and bodyEffects:FindFirstChild("K.O")

        if humanoid and (humanoid.Health < 1 or (koValue and koValue.Value) or Plr.Character:FindFirstChild("GRABBING_CONSTRAINT")) then
            if Locking then
                Plr = nil
                Locking = false
            end
        end
    end

    if getgenv().delusion.Checks.TargetDeath and Plr and Plr.Character:FindFirstChild("Humanoid") then
        if Plr.Character.Humanoid.Health < 1 and Locking then
            Plr = nil
            Locking = false
        end
    end

    local clientHumanoid = Client.Character and Client.Character:FindFirstChild("Humanoid")
    if getgenv().delusion.Checks.PlayerDeath and clientHumanoid and clientHumanoid.Health < 1 and Locking then
        Plr = nil
        Locking = false
    end
end)


if getgenv().delusion.Esp.Chams == true then

local UserInputService = game:GetService("UserInputService")
local ToggleKey = getgenv().delusion.Esp.Key

local FillColor = getgenv().delusion.Esp.Color
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = getgenv().delusion.Esp.Outline
local OutlineTransparency = 0

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local isEnabled = false

local function Highlight(plr)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Storage
    
    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        Highlight.Adornee = char
    end)
end

local function EnableHighlight()
    isEnabled = true
    for _, player in ipairs(Players:GetPlayers()) do
        Highlight(player)
    end
end

local function DisableHighlight()
    isEnabled = false
    for _, highlight in ipairs(Storage:GetChildren()) do
        highlight:Destroy()
    end
    for _, connection in pairs(connections) do
        connection:Disconnect()
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == ToggleKey then
        if isEnabled then
            DisableHighlight()
        else
            EnableHighlight()
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    if isEnabled then
        Highlight(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    local highlight = Storage:FindFirstChild(player.Name)
    if highlight then
        highlight:Destroy()
    end
    local connection = connections[player]
    if connection then
        connection:Disconnect()
    end
end)


if isEnabled then
    EnableHighlight()
end
end


if getgenv().delusion.Spin.Enabled == true then
    -- 360 made by @fwedsw
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local Toggle = getgenv().delusion.Spin.Enabled
    local RotationSpeed = getgenv().delusion.Spin.SpinSpeed
    local Keybind = getgenv().delusion.Spin.Keybind
    
    local function OnKeyPress(Input, GameProcessedEvent)
        if Input.KeyCode == Keybind and not GameProcessedEvent then 
            Toggle = not Toggle
        end
    end
    
    UserInputService.InputBegan:Connect(OnKeyPress)
    
    local LastRenderTime = 0
    local TotalRotation = 0
    -- 360 made by @fwedsw
    local function RotateCamera()
        if Toggle then
            local CurrentTime = tick()
            local TimeDelta = math.min(CurrentTime - LastRenderTime, 0.01)
            LastRenderTime = CurrentTime
    
            local RotationAngle = RotationSpeed * TimeDelta
            local Rotation = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.rad(RotationAngle))
            Camera.CFrame = Camera.CFrame * Rotation
            -- 360 made by @fwedsw
            TotalRotation = TotalRotation + RotationAngle
            if TotalRotation >= getgenv().delusion.Spin.Degrees then 
                Toggle = false
                TotalRotation = 0
            end
        end
    end
    
    RunService.RenderStepped:Connect(RotateCamera)
    end

        if getgenv().delusion.Textures.Enabled then
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                v.Material = getgenv().delusion.Textures.Material
                v.Color = getgenv().delusion.Textures.Color
                if v:IsA("Texture") then
                    v:Destroy()
                end
            end
    end
end


local function updateFog()
    local fogSettings = getgenv().delusion["Misc"]["Fog"]
    if fogSettings.Enabled then
        Lighting.FogColor = fogSettings.Color
        Lighting.FogStart = fogSettings.StartDistance
        Lighting.FogEnd = fogSettings.EndDistance
    end
end

local function updateAmbient()
    local surroundingAmbient = getgenv().delusion["Misc"]["SurroundingAmbient"]
    local externalAmbient = getgenv().delusion["Misc"]["ExternalAmbient"]

    if surroundingAmbient.Enabled then
        Lighting.Ambient = surroundingAmbient.Color
    end

    if externalAmbient.Enabled then
        Lighting.OutdoorAmbient = externalAmbient.Color
    end
end

local function toggleSpeedGlitch()
    SpeedGlitch = not SpeedGlitch
    if SpeedGlitch then
    if getgenv().delusion.Macro.Type == "Third" then
        repeat
            task.wait(getgenv().delusion.Macro.Speed / 100)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "I", false, game)
            task.wait(getgenv().delusion.Macro.Speed / 100)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "O", false, game)
        until not SpeedGlitch or not getgenv().delusion.Macro.Enabled
    elseif getgenv().delusion.Macro.Type == "First" then
        repeat
            task.wait(getgenv().delusion.Macro.Speed / 100)
            game:GetService("VirtualInputManager"):SendMouseWheelEvent(0, 0, true, game)
            task.wait(getgenv().delusion.Macro.Speed / 100)
            game:GetService("VirtualInputManager"):SendMouseWheelEvent(0, 0, false, game)
        until not SpeedGlitch or not getgenv().delusion.Macro.Enabled
    end
    end
    end
    
    Mouse.KeyDown:Connect(function(Key)
    if not getgenv().delusion.Macro.Enabled then return end 
    
    if string.lower(Key) == string.lower(getgenv().delusion.Macro.Keybind) then
    toggleSpeedGlitch()
    end
    end)


getgenv().Loaded = true -- end of the script
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Delusion",
        Text = "Updated Table",
        Duration = 0.001
    })
end
