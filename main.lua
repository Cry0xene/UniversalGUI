local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Themes = {
    Default = {MainBg = Color3.fromRGB(15, 20, 30), SidebarBg = Color3.fromRGB(10, 15, 25), ContentBg = Color3.fromRGB(20, 25, 40), Accent = Color3.fromRGB(0, 200, 255), Text = Color3.fromRGB(230, 230, 250), Button = Color3.fromRGB(30, 40, 60), DarkButton = Color3.fromRGB(20, 30, 50)}
}

local CurrentTheme = "Default"
local ThemeColors = Themes[CurrentTheme]

local function getPlayerAvatar(userId)
    local success, result = pcall(function()
        return game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    return success and result or "rbxasset://textures/ui/GuiImagePlaceholder.png"
end

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "Cry0xeneHUB"
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.DisplayOrder = 999
MainGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 700, 0, 500)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
MainFrame.BackgroundColor3 = ThemeColors.MainBg
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = MainGui

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(5, 10, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "CRY0XENE HUB"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = ThemeColors.Accent
Title.TextSize = 20
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 200, 1, -40)
SideBar.Position = UDim2.new(0, 0, 0, 40)
SideBar.BackgroundColor3 = ThemeColors.SidebarBg
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(1, -20, 0, 150)
ProfileFrame.Position = UDim2.new(0, 10, 0, 10)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Parent = SideBar

local AvatarFrame = Instance.new("ImageButton")
AvatarFrame.Size = UDim2.new(0, 80, 0, 80)
AvatarFrame.Position = UDim2.new(0.5, -40, 0, 10)
AvatarFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
AvatarFrame.Image = getPlayerAvatar(LocalPlayer.UserId)
local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarFrame
AvatarFrame.Parent = ProfileFrame

local Username = Instance.new("TextLabel")
Username.Text = "@" .. LocalPlayer.Name
Username.Size = UDim2.new(1, -20, 0, 20)
Username.Position = UDim2.new(0, 10, 0, 100)
Username.BackgroundTransparency = 1
Username.TextColor3 = ThemeColors.Text
Username.TextSize = 14
Username.Font = Enum.Font.GothamBold
Username.TextXAlignment = Enum.TextXAlignment.Center
Username.Parent = ProfileFrame

local DisplayName = Instance.new("TextLabel")
DisplayName.Text = LocalPlayer.DisplayName
DisplayName.Size = UDim2.new(1, -20, 0, 18)
DisplayName.Position = UDim2.new(0, 10, 0, 120)
DisplayName.BackgroundTransparency = 1
DisplayName.TextColor3 = Color3.fromRGB(180, 200, 255)
DisplayName.TextSize = 12
DisplayName.Font = Enum.Font.Gotham
DisplayName.TextXAlignment = Enum.TextXAlignment.Center
DisplayName.Parent = ProfileFrame

local TimeFrame = Instance.new("Frame")
TimeFrame.Size = UDim2.new(1, -20, 0, 35)
TimeFrame.Position = UDim2.new(0, 10, 0, 170)
TimeFrame.BackgroundColor3 = ThemeColors.ContentBg
TimeFrame.BorderSizePixel = 0
local TimeCorner = Instance.new("UICorner")
TimeCorner.CornerRadius = UDim.new(0.1, 0)
TimeCorner.Parent = TimeFrame
TimeFrame.Parent = SideBar

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Text = "00:00:00"
TimeLabel.Size = UDim2.new(1, -10, 1, 0)
TimeLabel.Position = UDim2.new(0, 5, 0, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.TextColor3 = ThemeColors.Text
TimeLabel.TextSize = 14
TimeLabel.Font = Enum.Font.GothamBold
TimeLabel.TextXAlignment = Enum.TextXAlignment.Center
TimeLabel.Parent = TimeFrame

spawn(function()
    while true do
        TimeLabel.Text = os.date("%H:%M:%S")
        wait(1)
    end
end)

local TabsFrame = Instance.new("ScrollingFrame")
TabsFrame.Size = UDim2.new(1, 0, 1, -220)
TabsFrame.Position = UDim2.new(0, 0, 0, 220)
TabsFrame.BackgroundTransparency = 1
TabsFrame.BorderSizePixel = 0
TabsFrame.ScrollBarThickness = 3
TabsFrame.ScrollBarImageColor3 = ThemeColors.Accent
TabsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
TabsFrame.Parent = SideBar

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -200, 1, -40)
ContentFrame.Position = UDim2.new(0, 200, 0, 40)
ContentFrame.BackgroundColor3 = ThemeColors.ContentBg
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentTitle = Instance.new("TextLabel")
ContentTitle.Text = "MAIN"
ContentTitle.Size = UDim2.new(1, -20, 0, 40)
ContentTitle.Position = UDim2.new(0, 10, 0, 10)
ContentTitle.BackgroundTransparency = 1
ContentTitle.TextColor3 = ThemeColors.Accent
ContentTitle.TextSize = 22
ContentTitle.Font = Enum.Font.GothamBlack
ContentTitle.TextXAlignment = Enum.TextXAlignment.Left
ContentTitle.Parent = ContentFrame

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, -60)
ContentScroll.Position = UDim2.new(0, 0, 0, 60)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 6
ContentScroll.ScrollBarImageColor3 = ThemeColors.Accent
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentFrame

local dragging = false
local dragStart, startPos

local function setupButtonHover(button, defaultColor, hoverColor)
    defaultColor = defaultColor or ThemeColors.Button
    hoverColor = hoverColor or Color3.fromRGB(math.min(defaultColor.R * 255 + 40, 255), math.min(defaultColor.G * 255 + 40, 255), math.min(defaultColor.B * 255 + 40, 255)) / 255
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = defaultColor}):Play()
    end)
end

local Tabs = {}
local CurrentTab = nil

local tabList = {
    {Name = "MAIN", Icon = "🏠"},
    {Name = "VISUALS", Icon = "👁️"},
    {Name = "SETTINGS", Icon = "⚙️"}
}

local buttonY = 0
for i, tabData in ipairs(tabList) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabData.Name .. "Tab"
    TabButton.Text = "  " .. tabData.Icon .. "  " .. tabData.Name
    TabButton.Size = UDim2.new(1, -20, 0, 40)
    TabButton.Position = UDim2.new(0, 10, 0, buttonY)
    TabButton.BackgroundColor3 = i == 1 and ThemeColors.Accent or ThemeColors.DarkButton
    TabButton.BorderSizePixel = 0
    TabButton.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or ThemeColors.Text
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.1, 0)
    Corner.Parent = TabButton
    
    TabButton.Parent = TabsFrame
    setupButtonHover(TabButton, TabButton.BackgroundColor3, Color3.fromRGB(math.min(TabButton.BackgroundColor3.R * 255 + 40, 255), math.min(TabButton.BackgroundColor3.G * 255 + 40, 255), math.min(TabButton.BackgroundColor3.B * 255 + 40, 255)) / 255)
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = tabData.Name .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = i == 1
    TabContent.ScrollBarThickness = 6
    TabContent.ScrollBarImageColor3 = ThemeColors.Accent
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.Parent = ContentScroll
    
    Tabs[tabData.Name] = {Button = TabButton, Content = TabContent}
    
    TabButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            Tabs[CurrentTab].Content.Visible = false
            Tabs[CurrentTab].Button.BackgroundColor3 = ThemeColors.DarkButton
            Tabs[CurrentTab].Button.TextColor3 = ThemeColors.Text
        end
        
        TabContent.Visible = true
        ContentTitle.Text = tabData.Name
        TabButton.BackgroundColor3 = ThemeColors.Accent
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CurrentTab = tabData.Name
        
        loadTabContent(tabData.Name, TabContent)
    end)
    
    buttonY = buttonY + 45
end

TabsFrame.CanvasSize = UDim2.new(0, 0, 0, buttonY)

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

local function createButton(parent, text, callback)
    local yPos = #parent:GetChildren() * 45
    
    local Button = Instance.new("TextButton")
    Button.Text = text
    Button.Size = UDim2.new(1, -20, 0, 40)
    Button.Position = UDim2.new(0, 10, 0, yPos)
    Button.BackgroundColor3 = ThemeColors.Button
    Button.BorderSizePixel = 0
    Button.TextColor3 = ThemeColors.Text
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.1, 0)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    setupButtonHover(Button)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
    return Button
end

local function createToggle(parent, text, callback, defaultState)
    local yPos = #parent:GetChildren() * 45
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    ToggleFrame.Position = UDim2.new(0, 10, 0, yPos)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = ThemeColors.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Text = defaultState and "ON" or "OFF"
    ToggleButton.Size = UDim2.new(0, 60, 0, 25)
    ToggleButton.Position = UDim2.new(1, -65, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 70, 90)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 12
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.AutoButtonColor = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.2, 0)
    Corner.Parent = ToggleButton
    ToggleButton.Parent = ToggleFrame
    
    local state = defaultState or false
    ToggleButton.MouseButton1Click:Connect(function()
        state = not state
        ToggleButton.Text = state and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 70, 90)
        callback(state)
    end)
    
    setupButtonHover(ToggleButton, ToggleButton.BackgroundColor3, Color3.fromRGB(80, 90, 110))
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
    return ToggleFrame
end

local function loadTabContent(tabName, contentFrame)
    for _, child in pairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
    
    if tabName == "MAIN" then
        createButton(contentFrame, "🔄 REFRESH CHARACTER", function()
            if LocalPlayer.Character then
                LocalPlayer.Character:BreakJoints()
            end
        end)
        
        createButton(contentFrame, "❤️ HEAL SELF", function()
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end)
        
        createToggle(contentFrame, "🛡️ GOD MODE", function(state)
            Features.GodMode = state
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    if state then
                        humanoid.MaxHealth = math.huge
                        humanoid.Health = math.huge
                    else
                        humanoid.MaxHealth = 100
                        humanoid.Health = 100
                    end
                end
            end
        end, false)
        
        createToggle(contentFrame, "👻 INVISIBLE", function(state)
            Features.Invisible = state
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = state and 1 or 0
                    end
                end
            end
        end, false)
        
        createToggle(contentFrame, "🚀 FLY MODE", function(state)
            Features.Fly = state
            toggleFly()
        end, false)
        
        createToggle(contentFrame, "⚡ SPEED HACK", function(state)
            Features.Speed = state
        end, false)
        
        createToggle(contentFrame, "🔄 INFINITE JUMP", function(state)
            Features.InfJump = state
        end, false)
        
        createToggle(contentFrame, "🌀 NO CLIP", function(state)
            Features.NoClip = state
        end, false)
        
    elseif tabName == "VISUALS" then
        createToggle(contentFrame, "💡 FULLBRIGHT", function(state)
            Features.Fullbright = state
            if game.Lighting then
                game.Lighting.GlobalShadows = not state
                if state then
                    game.Lighting.FogEnd = 100000
                    game.Lighting.Brightness = 2
                else
                    game.Lighting.FogEnd = 1000
                    game.Lighting.Brightness = 1
                end
            end
        end, false)
        
        createToggle(contentFrame, "🔦 X-RAY VISION", function(state)
            Features.Xray = state
        end, false)
        
        createToggle(contentFrame, "👤 PLAYER ESP", function(state)
            Features.Esp = state
        end, false)
        
        createButton(contentFrame, "☀️ DAY TIME", function()
            if game.Lighting then
                game.Lighting.ClockTime = 14
            end
        end)
        
        createButton(contentFrame, "🌙 NIGHT TIME", function()
            if game.Lighting then
                game.Lighting.ClockTime = 0
            end
        end)
        
        createButton(contentFrame, "🌈 RAINBOW MODE", function()
            spawn(function()
                while wait(0.1) do
                    if game.Lighting then
                        game.Lighting.OutdoorAmbient = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                    end
                end
            end)
        end)
        
        createButton(contentFrame, "🌀 REMOVE FOG", function()
            if game.Lighting then
                game.Lighting.FogEnd = 100000
            end
        end)
        
    elseif tabName == "SETTINGS" then
        createButton(contentFrame, "🔄 RELOAD GUI", function()
            loadTabContent(tabName, contentFrame)
        end)
        
        createToggle(contentFrame, "🔒 LOCK GUI", function(state)
        end, false)
        
        createButton(contentFrame, "🔼 MOVE GUI UP", function()
            MainFrame.Position = UDim2.new(0.5, -350, 0.1, 0)
        end)
        
        createButton(contentFrame, "🔽 MOVE GUI DOWN", function()
            MainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
        end)
        
        createButton(contentFrame, "📏 CHANGE SIZE", function()
            MainFrame.Size = UDim2.new(0, 750, 0, 550)
            MainFrame.Position = UDim2.new(0.5, -375, 0.5, -275)
        end)
        
        createButton(contentFrame, "❌ DESTROY GUI", function()
            MainGui:Destroy()
        end)
    end
end

if tabList[1] then
    loadTabContent(tabList[1].Name, Tabs[tabList[1].Name].Content)
end

UserInputService.JumpRequest:Connect(function()
    if Features.InfJump and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

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

toggleFly()

local originalWalkSpeed = 16
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and Features.Speed then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then humanoid.WalkSpeed = 50 end
    elseif char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then humanoid.WalkSpeed = originalWalkSpeed end
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

local originalTransparency = {}
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
            if part.Parent then part.Transparency = transparency part.Material = Enum.Material.Plastic end
        end
        originalTransparency = {}
    end
end)

print("Cry0xene Hub Loaded!")
print("GUI Visible - Press RightControl to hide/show")
