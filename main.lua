local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local LocalPlayer = Players.LocalPlayer

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "Cry0xeneHUB"
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.DisplayOrder = 999
MainGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = MainGui

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(5, 10, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "CRY0XENE COMMANDS"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local SearchBox = Instance.new("TextBox")
SearchBox.PlaceholderText = "Search commands..."
SearchBox.Size = UDim2.new(1, -40, 0, 30)
SearchBox.Position = UDim2.new(0, 10, 0, 40)
SearchBox.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
SearchBox.TextColor3 = Color3.fromRGB(230, 230, 250)
SearchBox.TextSize = 14
SearchBox.Font = Enum.Font.Gotham
SearchBox.Text = ""
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = MainFrame

local SearchBoxCorner = Instance.new("UICorner")
SearchBoxCorner.CornerRadius = UDim.new(0.1, 0)
SearchBoxCorner.Parent = SearchBox

local CommandsFrame = Instance.new("ScrollingFrame")
CommandsFrame.Size = UDim2.new(1, -20, 1, -110)
CommandsFrame.Position = UDim2.new(0, 10, 0, 80)
CommandsFrame.BackgroundTransparency = 1
CommandsFrame.BorderSizePixel = 0
CommandsFrame.ScrollBarThickness = 6
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

local function toggleFly()
    if Features.Fly then
        local char = LocalPlayer.Character
        if char then
            local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                if not flyBodyVelocity then
                    flyBodyVelocity = Instance.new("BodyVelocity")
                    flyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                    flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    flyBodyVelocity.Parent = humanoidRootPart
                    
                    flyBodyGyro = Instance.new("BodyGyro")
                    flyBodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
                    flyBodyGyro.P = 1000
                    flyBodyGyro.D = 50
                    flyBodyGyro.Parent = humanoidRootPart
                end
                
                local flySpeed = 50
                RunService.RenderStepped:Connect(function()
                    if Features.Fly and flyBodyVelocity then
                        local cam = workspace.CurrentCamera
                        local lookVector = cam.CFrame.LookVector
                        local rightVector = cam.CFrame.RightVector
                        
                        local velocity = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then velocity = velocity + lookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then velocity = velocity - lookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then velocity = velocity + rightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then velocity = velocity - rightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then velocity = velocity + Vector3.new(0, 1, 0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then velocity = velocity - Vector3.new(0, 1, 0) end
                        
                        if velocity.Magnitude > 0 then velocity = velocity.Unit * flySpeed end
                        
                        flyBodyVelocity.Velocity = velocity
                        flyBodyGyro.CFrame = cam.CFrame
                    end
                end)
            end
        end
    else
        if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
        if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
    end
end

local originalTransparency = {}
local espObjects = {}

local CommandsList = {
    {Name = "fly", Description = "Toggle fly mode", Category = "Movement"},
    {Name = "noclip", Description = "Toggle noclip", Category = "Movement"},
    {Name = "speed [value]", Description = "Set walk speed (default: 50)", Category = "Movement"},
    {Name = "infjump", Description = "Toggle infinite jump", Category = "Movement"},
    {Name = "godmode", Description = "Toggle god mode", Category = "Player"},
    {Name = "invisible", Description = "Toggle invisibility", Category = "Player"},
    {Name = "heal", Description = "Heal yourself", Category = "Player"},
    {Name = "refresh", Description = "Refresh character", Category = "Player"},
    {Name = "fullbright", Description = "Toggle fullbright", Category = "Visuals"},
    {Name = "xray", Description = "Toggle xray vision", Category = "Visuals"},
    {Name = "esp", Description = "Toggle player ESP", Category = "Visuals"},
    {Name = "day", Description = "Set to day time", Category = "World"},
    {Name = "night", Description = "Set to night time", Category = "World"},
    {Name = "nofog", Description = "Remove fog", Category = "World"},
    {Name = "aimbot", Description = "Toggle aimbot", Category = "Combat"},
    {Name = "autoclick", Description = "Toggle auto click", Category = "Combat"},
    {Name = "goto [player]", Description = "Teleport to player", Category = "Teleport"},
    {Name = "bring [player]", Description = "Bring player to you", Category = "Teleport"},
    {Name = "kill [player]", Description = "Kill player", Category = "Player"},
    {Name = "freeze [player]", Description = "Freeze player", Category = "Player"},
    {Name = "unfreeze [player]", Description = "Unfreeze player", Category = "Player"},
    {Name = "tools", Description = "Give all tools", Category = "Fun"},
    {Name = "money", Description = "Give money", Category = "Fun"},
    {Name = "size [value]", Description = "Change size", Category = "Fun"},
    {Name = "grav [value]", Description = "Change gravity", Category = "World"},
    {Name = "rejoin", Description = "Rejoin server", Category = "Server"},
    {Name = "hop", Description = "Server hop", Category = "Server"},
    {Name = "clear", Description = "Clear workspace", Category = "Cleanup"},
    {Name = "reset", Description = "Reset all features", Category = "Misc"},
    {Name = "help", Description = "Show commands list", Category = "Misc"},
    {Name = "exit", Description = "Close GUI", Category = "Misc"}
}

local function executeCommand(cmd)
    local args = {}
    for arg in cmd:gmatch("%S+") do
        table.insert(args, arg:lower())
    end
    
    local command = args[1]
    
    if command == "fly" then
        Features.Fly = not Features.Fly
        toggleFly()
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
                print("Speed set to:", value)
            end
        end
        
    elseif command == "infjump" then
        Features.InfJump = not Features.InfJump
        print("Infinite Jump:", Features.InfJump and "ON" or "OFF")
        
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
        print("God Mode:", Features.GodMode and "ON" or "OFF")
        
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
            print("Character refreshed!")
        end
        
    elseif command == "fullbright" then
        Features.Fullbright = not Features.Fullbright
        if game.Lighting then
            game.Lighting.GlobalShadows = not Features.Fullbright
            if Features.Fullbright then
                game.Lighting.FogEnd = 100000
                game.Lighting.Brightness = 2
            else
                game.Lighting.FogEnd = 1000
                game.Lighting.Brightness = 1
            end
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
            print("Set to day!")
        end
        
    elseif command == "night" then
        if game.Lighting then
            game.Lighting.ClockTime = 0
            print("Set to night!")
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
        local targetName = args[2]
        if targetName then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name:lower():find(targetName:lower()) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                            print("Teleported to", player.Name)
                        end
                    end
                    break
                end
            end
        end
        
    elseif command == "bring" then
        local targetName = args[2]
        if targetName then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name:lower():find(targetName:lower()) then
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
        local targetName = args[2]
        if targetName then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name:lower():find(targetName:lower()) then
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
        local targetName = args[2]
        if targetName then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name:lower():find(targetName:lower()) then
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
        local targetName = args[2]
        if targetName then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name:lower():find(targetName:lower()) then
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
        for i = 1, 10 do
            local tool = Instance.new("Tool")
            tool.Name = "Tool" .. i
            tool.Parent = LocalPlayer.Backpack or workspace
        end
        print("Tools given!")
        
    elseif command == "money" then
        print("Money command - Game specific")
        
    elseif command == "size" then
        local value = tonumber(args[2]) or 1
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size * value
                end
            end
            print("Size changed to:", value)
        end
        
    elseif command == "grav" then
        local value = tonumber(args[2]) or 196.2
        workspace.Gravity = value
        print("Gravity set to:", value)
        
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
        print("Workspace cleared!")
        
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
            game.Lighting.ClockTime = 14
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
        
        print("All features reset!")
        
    elseif command == "help" then
        print("Available commands:")
        for _, cmd in pairs(CommandsList) do
            print(cmd.Name .. " - " .. cmd.Description)
        end
        
    elseif command == "exit" then
        MainGui:Destroy()
        
    else
        print("Unknown command. Type 'help' for commands list.")
    end
end

local function updateCommandList(searchText)
    for _, child in pairs(CommandsFrame:GetChildren()) do
        child:Destroy()
    end
    
    local yPos = 0
    local searchLower = searchText:lower()
    
    for _, cmd in pairs(CommandsList) do
        if searchText == "" or cmd.Name:lower():find(searchLower) or cmd.Description:lower():find(searchLower) or cmd.Category:lower():find(searchLower) then
            local CommandButton = Instance.new("TextButton")
            CommandButton.Text = ""
            CommandButton.Size = UDim2.new(1, 0, 0, 35)
            CommandButton.Position = UDim2.new(0, 0, 0, yPos)
            CommandButton.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
            CommandButton.BorderSizePixel = 0
            CommandButton.AutoButtonColor = false
            CommandButton.Parent = CommandsFrame
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0.1, 0)
            Corner.Parent = CommandButton
            
            local NameLabel = Instance.new("TextLabel")
            NameLabel.Text = cmd.Name
            NameLabel.Size = UDim2.new(0.4, 0, 1, 0)
            NameLabel.Position = UDim2.new(0, 10, 0, 0)
            NameLabel.BackgroundTransparency = 1
            NameLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
            NameLabel.TextSize = 13
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Parent = CommandButton
            
            local DescLabel = Instance.new("TextLabel")
            DescLabel.Text = cmd.Description
            DescLabel.Size = UDim2.new(0.4, 0, 1, 0)
            DescLabel.Position = UDim2.new(0.4, 0, 0, 0)
            DescLabel.BackgroundTransparency = 1
            DescLabel.TextColor3 = Color3.fromRGB(180, 190, 220)
            DescLabel.TextSize = 12
            DescLabel.Font = Enum.Font.Gotham
            DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            DescLabel.Parent = CommandButton
            
            local CatLabel = Instance.new("TextLabel")
            CatLabel.Text = cmd.Category
            CatLabel.Size = UDim2.new(0.2, -10, 1, 0)
            CatLabel.Position = UDim2.new(0.8, 0, 0, 0)
            CatLabel.BackgroundTransparency = 1
            CatLabel.TextColor3 = Color3.fromRGB(150, 200, 100)
            CatLabel.TextSize = 11
            CatLabel.Font = Enum.Font.Gotham
            CatLabel.TextXAlignment = Enum.TextXAlignment.Right
            CatLabel.Parent = CommandButton
            
            CommandButton.MouseButton1Click:Connect(function()
                executeCommand(cmd.Name)
            end)
            
            setupButtonHover(CommandButton)
            
            yPos = yPos + 40
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

print("Cry0xene Commands Loaded!")
print("Type commands in search box or click them")
print("Press RightControl to hide/show")
print("Type 'help' for commands list")
