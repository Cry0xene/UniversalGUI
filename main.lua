local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "Cry0xeneHUB"
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.DisplayOrder = 999
MainGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(1, -360, 1, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = MainGui

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 25)
TopBar.BackgroundColor3 = Color3.fromRGB(5, 10, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "CRY0XENE"
Title.Size = UDim2.new(0, 100, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 25, 1, 0)
CloseButton.Position = UDim2.new(1, -25, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local SearchBox = Instance.new("TextBox")
SearchBox.PlaceholderText = "Type command..."
SearchBox.Size = UDim2.new(1, -10, 0, 25)
SearchBox.Position = UDim2.new(0, 5, 0, 30)
SearchBox.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
SearchBox.TextColor3 = Color3.fromRGB(230, 230, 250)
SearchBox.TextSize = 12
SearchBox.Font = Enum.Font.Gotham
SearchBox.Text = ""
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = MainFrame

local SearchBoxCorner = Instance.new("UICorner")
SearchBoxCorner.CornerRadius = UDim.new(0.1, 0)
SearchBoxCorner.Parent = SearchBox

local CommandsFrame = Instance.new("ScrollingFrame")
CommandsFrame.Size = UDim2.new(1, -10, 1, -70)
CommandsFrame.Position = UDim2.new(0, 5, 0, 60)
CommandsFrame.BackgroundTransparency = 1
CommandsFrame.BorderSizePixel = 0
CommandsFrame.ScrollBarThickness = 4
CommandsFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
CommandsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
CommandsFrame.Parent = MainFrame

local dragging = false
local dragStart, startPos

local function setupButtonHover(button, defaultColor, hoverColor)
    defaultColor = defaultColor or Color3.fromRGB(30, 40, 60)
    hoverColor = hoverColor or Color3.fromRGB(40, 50, 70)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = defaultColor}):Play()
    end)
end

local Features = {
    Fly = false,
    NoClip = false,
    Speed = false,
    Xray = false,
    Fullbright = false,
    Esp = false,
    Aimbot = false,
    AutoClick = false,
    InfJump = false,
    GodMode = false,
    Invisible = false
}

local flyBodyVelocity = nil
local flyBodyGyro = nil
local originalTransparency = {}

local CommandsList = {
    "fly", "noclip", "speed 50", "infjump", "godmode", "invisible",
    "heal", "refresh", "fullbright", "xray", "esp", "day", "night",
    "nofog", "aimbot", "autoclick", "goto [plr]", "bring [plr]", 
    "kill [plr]", "freeze [plr]", "unfreeze [plr]", "tools", "size 2",
    "grav 50", "rejoin", "hop", "clear", "reset", "help", "exit"
}

local function executeCommand(cmd)
    local args = {}
    for arg in cmd:gmatch("%S+") do
        table.insert(args, arg:lower())
    end
    
    local command = args[1]
    
    if command == "fly" then
        Features.Fly = not Features.Fly
        if Features.Fly then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                flyBodyVelocity = Instance.new("BodyVelocity")
                flyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                flyBodyVelocity.Parent = char.HumanoidRootPart
                
                flyBodyGyro = Instance.new("BodyGyro")
                flyBodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
                flyBodyGyro.P = 1000
                flyBodyGyro.D = 50
                flyBodyGyro.Parent = char.HumanoidRootPart
                
                local flySpeed = 50
                RunService.RenderStepped:Connect(function()
                    if Features.Fly and flyBodyVelocity then
                        local cam = workspace.CurrentCamera
                        local velocity = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then velocity = velocity + cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then velocity = velocity - cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then velocity = velocity + cam.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then velocity = velocity - cam.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then velocity = velocity + Vector3.new(0, 1, 0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then velocity = velocity - Vector3.new(0, 1, 0) end
                        
                        if velocity.Magnitude > 0 then velocity = velocity.Unit * flySpeed end
                        
                        flyBodyVelocity.Velocity = velocity
                        flyBodyGyro.CFrame = cam.CFrame
                    end
                end)
            end
        else
            if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
            if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
        end
        print("Fly:", Features.Fly and "ON" or "OFF")
        
    elseif command == "noclip" then
        Features.NoClip = not Features.NoClip
        print("NoClip:", Features.NoClip and "ON" or "OFF")
        
    elseif command == "speed" then
        local value = tonumber(args[2]) or 50
        Features.Speed = true
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
                print("Speed:", value)
            end
        end
        
    elseif command == "infjump" then
        Features.InfJump = not Features.InfJump
        print("InfJump:", Features.InfJump and "ON" or "OFF")
        
    elseif command == "godmode" then
        Features.GodMode = not Features.GodMode
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                if Features.GodMode then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                else
                    humanoid.MaxHealth = 100
                    humanoid.Health = 100
                end
            end
        end
        print("GodMode:", Features.GodMode and "ON" or "OFF")
        
    elseif command == "invisible" then
        Features.Invisible = not Features.Invisible
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = Features.Invisible and 1 or 0
                end
            end
        end
        print("Invisible:", Features.Invisible and "ON" or "OFF")
        
    elseif command == "heal" then
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
                print("Healed!")
            end
        end
        
    elseif command == "refresh" then
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
            print("Refreshed!")
        end
        
    elseif command == "fullbright" then
        Features.Fullbright = not Features.Fullbright
        if game.Lighting then
            game.Lighting.GlobalShadows = not Features.Fullbright
            game.Lighting.FogEnd = Features.Fullbright and 100000 or 1000
            game.Lighting.Brightness = Features.Fullbright and 2 or 1
        end
        print("Fullbright:", Features.Fullbright and "ON" or "OFF")
        
    elseif command == "xray" then
        Features.Xray = not Features.Xray
        print("Xray:", Features.Xray and "ON" or "OFF")
        
    elseif command == "esp" then
        Features.Esp = not Features.Esp
        print("ESP:", Features.Esp and "ON" or "OFF")
        
    elseif command == "day" then
        if game.Lighting then
            game.Lighting.ClockTime = 14
            print("Day!")
        end
        
    elseif command == "night" then
        if game.Lighting then
            game.Lighting.ClockTime = 0
            print("Night!")
        end
        
    elseif command == "nofog" then
        if game.Lighting then
            game.Lighting.FogEnd = 100000
            print("Fog removed!")
        end
        
    elseif command == "aimbot" then
        Features.Aimbot = not Features.Aimbot
        print("Aimbot:", Features.Aimbot and "ON" or "OFF")
        
    elseif command == "autoclick" then
        Features.AutoClick = not Features.AutoClick
        print("AutoClick:", Features.AutoClick and "ON" or "OFF")
        
    elseif command == "goto" then
        local target = args[2]
        if target then
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(player.Name:lower(), target:lower()) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                            print("Goto", player.Name)
                        end
                    end
                    break
                end
            end
        end
        
    elseif command == "bring" then
        local target = args[2]
        if target then
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(player.Name:lower(), target:lower()) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            player.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                            print("Brought", player.Name)
                        end
                    end
                    break
                end
            end
        end
        
    elseif command == "kill" then
        local target = args[2]
        if target then
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(player.Name:lower(), target:lower()) then
                    if player.Character then
                        local humanoid = player.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                            print("Killed", player.Name)
                        end
                    end
                    break
                end
            end
        end
        
    elseif command == "freeze" then
        local target = args[2]
        if target then
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(player.Name:lower(), target:lower()) then
                    if player.Character then
                        local humanoid = player.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.PlatformStand = true
                            print("Froze", player.Name)
                        end
                    end
                    break
                end
            end
        end
        
    elseif command == "unfreeze" then
        local target = args[2]
        if target then
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(player.Name:lower(), target:lower()) then
                    if player.Character then
                        local humanoid = player.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.PlatformStand = false
                            print("Unfroze", player.Name)
                        end
                    end
                    break
                end
            end
        end
        
    elseif command == "tools" then
        for i = 1, 5 do
            local tool = Instance.new("Tool")
            tool.Name = "Tool" .. i
            tool.Parent = LocalPlayer.Backpack or workspace
        end
        print("Tools given!")
        
    elseif command == "size" then
        local size = tonumber(args[2]) or 2
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size * size
                end
            end
            print("Size:", size)
        end
        
    elseif command == "grav" then
        local grav = tonumber(args[2]) or 50
        workspace.Gravity = grav
        print("Gravity:", grav)
        
    elseif command == "rejoin" then
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
        
    elseif command == "hop" then
        print("Server hop - Requires HTTP")
        
    elseif command == "clear" then
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("BasePart") and obj.Parent == workspace then
                obj:Destroy()
            end
        end
        print("Cleared workspace!")
        
    elseif command == "reset" then
        Features.Fly = false
        Features.NoClip = false
        Features.Speed = false
        Features.Xray = false
        Features.Fullbright = false
        Features.Esp = false
        Features.Aimbot = false
        Features.AutoClick = false
        Features.InfJump = false
        Features.GodMode = false
        Features.Invisible = false
        
        if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
        if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
        
        if game.Lighting then
            game.Lighting.GlobalShadows = true
            game.Lighting.FogEnd = 1000
            game.Lighting.Brightness = 1
        end
        
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
            
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
            end
        end
        
        for part, transparency in pairs(originalTransparency) do
            if part.Parent then
                part.Transparency = transparency
                part.Material = Enum.Material.Plastic
            end
        end
        originalTransparency = {}
        
        print("Reset all!")
        
    elseif command == "help" then
        print("Commands: " .. table.concat(CommandsList, ", "))
        
    elseif command == "exit" then
        MainGui:Destroy()
        
    else
        print("Unknown command. Type 'help'")
    end
end

local function updateCommandList(searchText)
    for _, child in pairs(CommandsFrame:GetChildren()) do
        child:Destroy()
    end
    
    local yPos = 0
    local searchLower = searchText:lower()
    
    for _, cmd in pairs(CommandsList) do
        if searchText == "" or cmd:lower():find(searchLower) then
            local CommandButton = Instance.new("TextButton")
            CommandButton.Text = cmd
            CommandButton.Size = UDim2.new(1, 0, 0, 25)
            CommandButton.Position = UDim2.new(0, 0, 0, yPos)
            CommandButton.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
            CommandButton.BorderSizePixel = 0
            CommandButton.TextColor3 = Color3.fromRGB(230, 230, 250)
            CommandButton.TextSize = 11
            CommandButton.Font = Enum.Font.Gotham
            CommandButton.Parent = CommandsFrame
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0.1, 0)
            Corner.Parent = CommandButton
            
            CommandButton.MouseButton1Click:Connect(function()
                executeCommand(cmd:gsub("%[plr%]", ""))
            end)
            
            setupButtonHover(CommandButton)
            
            yPos = yPos + 28
        end
    end
    
    CommandsFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 5)
end

updateCommandList("")

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateCommandList(SearchBox.Text)
end)

SearchBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and SearchBox.Text ~= "" then
        executeCommand(SearchBox.Text)
        SearchBox.Text = ""
        updateCommandList("")
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Features.InfJump and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and Features.Speed then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then humanoid.WalkSpeed = 50 end
    elseif char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then humanoid.WalkSpeed = 16 end
    end
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char and Features.NoClip then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if Features.Xray then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.5 then
                if not originalTransparency[part] then originalTransparency[part] = part.Transparency end
                part.Transparency = 0.5
                part.Material = Enum.Material.ForceField
            end
        end
    else
        for part, transparency in pairs(originalTransparency) do
            if part.Parent then
                part.Transparency = transparency
                part.Material = Enum.Material.Plastic
            end
        end
        originalTransparency = {}
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainGui:Destroy()
end)

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("Cry0xene Commands v2")
print("Bottom-right corner")
print("RightControl toggle")
