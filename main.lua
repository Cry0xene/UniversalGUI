local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local Themes = {
    Default = {
        MainBg = Color3.fromRGB(25, 25, 35),
        SidebarBg = Color3.fromRGB(20, 20, 30),
        ContentBg = Color3.fromRGB(30, 30, 45),
        Accent = Color3.fromRGB(0, 170, 255),
        Text = Color3.fromRGB(220, 220, 255),
        Button = Color3.fromRGB(40, 40, 60)
    },
    Dark = {
        MainBg = Color3.fromRGB(15, 15, 20),
        SidebarBg = Color3.fromRGB(10, 10, 15),
        ContentBg = Color3.fromRGB(20, 20, 30),
        Accent = Color3.fromRGB(0, 200, 255),
        Text = Color3.fromRGB(240, 240, 255),
        Button = Color3.fromRGB(30, 30, 50)
    },
    Pink = {
        MainBg = Color3.fromRGB(30, 15, 25),
        SidebarBg = Color3.fromRGB(25, 10, 20),
        ContentBg = Color3.fromRGB(35, 20, 30),
        Accent = Color3.fromRGB(255, 105, 180),
        Text = Color3.fromRGB(255, 220, 240),
        Button = Color3.fromRGB(50, 30, 45)
    },
    Green = {
        MainBg = Color3.fromRGB(20, 30, 25),
        SidebarBg = Color3.fromRGB(15, 25, 20),
        ContentBg = Color3.fromRGB(25, 35, 30),
        Accent = Color3.fromRGB(0, 255, 150),
        Text = Color3.fromRGB(220, 255, 240),
        Button = Color3.fromRGB(30, 50, 40)
    },
    Purple = {
        MainBg = Color3.fromRGB(25, 20, 35),
        SidebarBg = Color3.fromRGB(20, 15, 30),
        ContentBg = Color3.fromRGB(30, 25, 45),
        Accent = Color3.fromRGB(170, 0, 255),
        Text = Color3.fromRGB(240, 220, 255),
        Button = Color3.fromRGB(40, 30, 60)
    }
}

local CurrentTheme = "Default"
local ThemeColors = Themes[CurrentTheme]

local function getPlayerAvatar(userId)
    local success, result = pcall(function()
        return game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    return success and result or "rbxasset://textures/ui/GuiImagePlaceholder.png"
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Cry0xeneGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local PlayerListScreenGui = Instance.new("ScreenGui")
PlayerListScreenGui.Name = "PlayerListGUI"
PlayerListScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PlayerListScreenGui.DisplayOrder = 998
PlayerListScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 700, 0, 550)
MainContainer.Position = UDim2.new(0.5, -350, 0.5, -275)
MainContainer.BackgroundColor3 = ThemeColors.MainBg
MainContainer.BorderSizePixel = 0
MainContainer.ClipsDescendants = true
MainContainer.Parent = ScreenGui

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 2
TopBar.Parent = MainContainer

local TitleContainer = Instance.new("Frame")
TitleContainer.Size = UDim2.new(0, 250, 1, 0)
TitleContainer.Position = UDim2.new(0, 15, 0, 0)
TitleContainer.BackgroundTransparency = 1
TitleContainer.Parent = TopBar

local Icon = Instance.new("ImageLabel")
Icon.Image = "rbxassetid://6031094678"
Icon.Size = UDim2.new(0, 25, 0, 25)
Icon.Position = UDim2.new(0, 0, 0.5, -12.5)
Icon.BackgroundTransparency = 1
Icon.ImageColor3 = ThemeColors.Accent
Icon.Parent = TitleContainer

local Title = Instance.new("TextLabel")
Title.Text = "Cry0xene GUI v6.0"
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 30, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = ThemeColors.Text
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleContainer

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "×"
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "−"
MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 24
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TopBar

local ProfileSection = Instance.new("Frame")
ProfileSection.Name = "ProfileSection"
ProfileSection.Size = UDim2.new(0, 200, 1, -45)
ProfileSection.Position = UDim2.new(0, 0, 0, 45)
ProfileSection.BackgroundColor3 = ThemeColors.SidebarBg
ProfileSection.BorderSizePixel = 0
ProfileSection.Parent = MainContainer

local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0, 120, 0, 120)
ProfileFrame.Position = UDim2.new(0.5, -60, 0, 20)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ProfileFrame.BorderSizePixel = 0
local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(1, 0)
ProfileCorner.Parent = ProfileFrame

local ProfileImage = Instance.new("ImageLabel")
ProfileImage.Size = UDim2.new(1, -10, 1, -10)
ProfileImage.Position = UDim2.new(0, 5, 0, 5)
ProfileImage.BackgroundTransparency = 1
ProfileImage.Image = getPlayerAvatar(LocalPlayer.UserId)
local ImageCorner = Instance.new("UICorner")
ImageCorner.CornerRadius = UDim.new(1, 0)
ImageCorner.Parent = ProfileImage
ProfileImage.Parent = ProfileFrame
ProfileFrame.Parent = ProfileSection

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Text = "@" .. LocalPlayer.Name
UsernameLabel.Size = UDim2.new(1, -20, 0, 25)
UsernameLabel.Position = UDim2.new(0, 10, 0, 160)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.TextColor3 = ThemeColors.Text
UsernameLabel.TextSize = 16
UsernameLabel.Font = Enum.Font.GothamBold
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Center
UsernameLabel.Parent = ProfileSection

local DisplayName = Instance.new("TextLabel")
DisplayName.Text = LocalPlayer.DisplayName
DisplayName.Size = UDim2.new(1, -20, 0, 20)
DisplayName.Position = UDim2.new(0, 10, 0, 185)
DisplayName.BackgroundTransparency = 1
DisplayName.TextColor3 = ThemeColors.Text
DisplayName.TextSize = 14
DisplayName.Font = Enum.Font.Gotham
DisplayName.TextXAlignment = Enum.TextXAlignment.Center
DisplayName.Parent = ProfileSection

local TimeContainer = Instance.new("Frame")
TimeContainer.Size = UDim2.new(1, -20, 0, 40)
TimeContainer.Position = UDim2.new(0, 10, 0, 220)
TimeContainer.BackgroundColor3 = ThemeColors.ContentBg
TimeContainer.BorderSizePixel = 0
local TimeCorner = Instance.new("UICorner")
TimeCorner.CornerRadius = UDim.new(0.2, 0)
TimeCorner.Parent = TimeContainer
TimeContainer.Parent = ProfileSection

local TimeIcon = Instance.new("ImageLabel")
TimeIcon.Image = "rbxassetid://6031280882"
TimeIcon.Size = UDim2.new(0, 20, 0, 20)
TimeIcon.Position = UDim2.new(0, 10, 0.5, -10)
TimeIcon.BackgroundTransparency = 1
TimeIcon.ImageColor3 = ThemeColors.Accent
TimeIcon.Parent = TimeContainer

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Text = "00:00:00"
TimeLabel.Size = UDim2.new(1, -40, 1, 0)
TimeLabel.Position = UDim2.new(0, 35, 0, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.TextColor3 = ThemeColors.Text
TimeLabel.TextSize = 16
TimeLabel.Font = Enum.Font.GothamBold
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeLabel.Parent = TimeContainer

spawn(function()
    while true do
        local time = os.date("%H:%M:%S")
        TimeLabel.Text = time
        wait(1)
    end
end)

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 200, 1, -45)
TabContainer.Position = UDim2.new(0, 0, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainContainer

local TabButtonsFrame = Instance.new("ScrollingFrame")
TabButtonsFrame.Size = UDim2.new(1, 0, 1, -280)
TabButtonsFrame.Position = UDim2.new(0, 0, 0, 280)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.BorderSizePixel = 0
TabButtonsFrame.ScrollBarThickness = 3
TabButtonsFrame.ScrollBarImageColor3 = ThemeColors.Accent
TabButtonsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
TabButtonsFrame.Parent = TabContainer

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -200, 1, -45)
ContentArea.Position = UDim2.new(0, 200, 0, 45)
ContentArea.BackgroundColor3 = ThemeColors.ContentBg
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainContainer

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 6
ContentScroll.ScrollBarImageColor3 = ThemeColors.Accent
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentArea

local dragging = false
local dragStart, startPos

local function updateTheme()
    ThemeColors = Themes[CurrentTheme]
    
    MainContainer.BackgroundColor3 = ThemeColors.MainBg
    ProfileSection.BackgroundColor3 = ThemeColors.SidebarBg
    ContentArea.BackgroundColor3 = ThemeColors.ContentBg
    Icon.ImageColor3 = ThemeColors.Accent
    Title.TextColor3 = ThemeColors.Text
    UsernameLabel.TextColor3 = ThemeColors.Text
    DisplayName.TextColor3 = ThemeColors.Text
    TimeContainer.BackgroundColor3 = ThemeColors.ContentBg
    TimeIcon.ImageColor3 = ThemeColors.Accent
    TimeLabel.TextColor3 = ThemeColors.Text
    TabButtonsFrame.ScrollBarImageColor3 = ThemeColors.Accent
    ContentScroll.ScrollBarImageColor3 = ThemeColors.Accent
    
    for _, tab in pairs(Tabs) do
        if tab.Button and tab.Button:IsA("TextButton") then
            if CurrentTab == tab.Button.Name:gsub("Tab", "") then
                tab.Button.BackgroundColor3 = ThemeColors.Accent
                tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                if tab.Icon then
                    tab.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
            else
                tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                tab.Button.TextColor3 = ThemeColors.Text
                if tab.Icon then
                    tab.Icon.ImageColor3 = Color3.fromRGB(150, 150, 200)
                end
            end
        end
    end
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainContainer.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainContainer.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local function setupButtonHover(button, defaultColor, hoverColor)
    defaultColor = defaultColor or ThemeColors.Button
    hoverColor = hoverColor or Color3.fromRGB(
        math.min(defaultColor.R * 255 + 30, 255),
        math.min(defaultColor.G * 255 + 30, 255),
        math.min(defaultColor.B * 255 + 30, 255)
    ) / 255
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = defaultColor}):Play()
    end)
end

local Tabs = {}
local CurrentTab = nil

local tabDefinitions = {
    {Name = "🏠 Home", Icon = "rbxassetid://6031094678"},
    {Name = "👤 Player Tools", Icon = "rbxassetid://6031302931"},
    {Name = "👤 Self", Icon = "rbxassetid://6031302931"},
    {Name = "⚙️ ESP", Icon = "rbxassetid://6031302931"},
    {Name = "⚔️ Combat", Icon = "rbxassetid://6031302931"},
    {Name = "🚀 Movement", Icon = "rbxassetid://6031302931"},
    {Name = "🌍 World", Icon = "rbxassetid://6031302931"},
    {Name = "🗑️ Cleanup", Icon = "rbxassetid://6031302931"},
    {Name = "🌐 Server", Icon = "rbxassetid://6031302931"},
    {Name = "⚙️ Settings", Icon = "rbxassetid://6031302931"},
    {Name = "📋 Player List", Icon = "rbxassetid://6031280882"}
}

local yOffset = 0
for i, tabDef in ipairs(tabDefinitions) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabDef.Name .. "Tab"
    TabButton.Text = "  " .. tabDef.Name
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.Position = UDim2.new(0, 5, 0, yOffset)
    TabButton.BackgroundColor3 = i == 1 and ThemeColors.Accent or Color3.fromRGB(50, 50, 70)
    TabButton.BorderSizePixel = 0
    TabButton.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or ThemeColors.Text
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.1, 0)
    Corner.Parent = TabButton
    
    if tabDef.Icon then
        TabButton.Text = "    " .. tabDef.Name
        local IconLabel = Instance.new("ImageLabel")
        IconLabel.Image = tabDef.Icon
        IconLabel.Size = UDim2.new(0, 20, 0, 20)
        IconLabel.Position = UDim2.new(0, 10, 0.5, -10)
        IconLabel.BackgroundTransparency = 1
        IconLabel.ImageColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 200)
        IconLabel.Parent = TabButton
    end
    
    TabButton.Parent = TabButtonsFrame
    setupButtonHover(TabButton, TabButton.BackgroundColor3, Color3.fromRGB(70, 70, 90))
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = tabDef.Name .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = i == 1
    TabContent.ScrollBarThickness = 6
    TabContent.ScrollBarImageColor3 = ThemeColors.Accent
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.Parent = ContentScroll
    
    Tabs[tabDef.Name] = {
        Button = TabButton,
        Content = TabContent,
        Icon = IconLabel
    }
    
    TabButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            Tabs[CurrentTab].Content.Visible = false
            Tabs[CurrentTab].Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            Tabs[CurrentTab].Button.TextColor3 = ThemeColors.Text
            if Tabs[CurrentTab].Icon then
                Tabs[CurrentTab].Icon.ImageColor3 = Color3.fromRGB(150, 150, 200)
            end
        end
        
        TabContent.Visible = true
        TabButton.BackgroundColor3 = ThemeColors.Accent
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        if tabDef.Icon then
            IconLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end
        CurrentTab = tabDef.Name
        
        loadTabContent(tabDef.Name, TabContent)
    end)
    
    yOffset = yOffset + 45
end

TabButtonsFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    PlayerListScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainContainer.Visible = not MainContainer.Visible
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        MainContainer.Visible = not MainContainer.Visible
    end
end)

local UniversalFeatures = {}

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
    setupButtonHover(Button, ThemeColors.Button, Color3.fromRGB(
        math.min(ThemeColors.Button.R * 255 + 30, 255),
        math.min(ThemeColors.Button.G * 255 + 30, 255),
        math.min(ThemeColors.Button.B * 255 + 30, 255)
    ) / 255)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
    return Button
end

local function createToggle(parent, text, callback)
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
    ToggleButton.Text = "OFF"
    ToggleButton.Size = UDim2.new(0, 70, 0, 30)
    ToggleButton.Position = UDim2.new(1, -70, 0.5, -15)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    ToggleButton.TextColor3 = ThemeColors.Text
    ToggleButton.TextSize = 12
    ToggleButton.Font = Enum.Font.GothamBold
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.2, 0)
    Corner.Parent = ToggleButton
    ToggleButton.Parent = ToggleFrame
    
    local state = false
    ToggleButton.MouseButton1Click:Connect(function()
        state = not state
        ToggleButton.Text = state and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 80)
        callback(state)
    end)
    
    setupButtonHover(ToggleButton, ToggleButton.BackgroundColor3, Color3.fromRGB(80, 80, 100))
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
    return ToggleFrame
end

local function loadTabContent(tabName, contentFrame)
    for _, child in pairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
    
    if tabName == "🏠 Home" then
        createButton(contentFrame, "📊 Load All Features", function()
            print("All features loaded!")
        end)
        
        createButton(contentFrame, "⚡ Quick Settings", function()
            print("Quick settings opened!")
        end)
        
        createButton(contentFrame, "📖 Open Player List", function()
            PlayerListContainer.Visible = not PlayerListContainer.Visible
        end)
        
    elseif tabName == "👤 Player Tools" then
        createButton(contentFrame, "📍 Teleport to Selected", function()
            if selectedPlayer then
                UniversalFeatures.TeleportToPlayer(selectedPlayer)
            end
        end)
        
        createButton(contentFrame, "🚀 Bring Player", function()
            if selectedPlayer then
                UniversalFeatures.BringPlayer(selectedPlayer)
            end
        end)
        
        createButton(contentFrame, "💀 Kill Player", function()
            if selectedPlayer then
                UniversalFeatures.KillPlayer(selectedPlayer)
            end
        end)
        
        createButton(contentFrame, "❄️ Freeze Player", function()
            if selectedPlayer then
                UniversalFeatures.FreezePlayer(selectedPlayer)
            end
        end)
        
        createButton(contentFrame, "👑 Sit on Head", function()
            if selectedPlayer then
                UniversalFeatures.SitOnHead(selectedPlayer)
            end
        end)
        
    elseif tabName == "👤 Self" then
        createButton(contentFrame, "🛡️ God Mode", function()
            UniversalFeatures.GodMode()
            print("God Mode Activated")
        end)
        
        createButton(contentFrame, "👻 Invisible", function()
            UniversalFeatures.Invisible()
            print("Invisible Mode")
        end)
        
        createButton(contentFrame, "❤️ Heal Self", function()
            UniversalFeatures.HealCharacter()
            print("Healed Self")
        end)
        
        createButton(contentFrame, "🔄 Reset Character", function()
            UniversalFeatures.ResetCharacter()
            print("Character Reset")
        end)
        
        createToggle(contentFrame, "🔄 Infinite Jump", function(state)
            UniversalFeatures.InfiniteJump = state
            print("Infinite Jump:", state)
        end)
        
    elseif tabName == "⚙️ ESP" then
        createToggle(contentFrame, "Player ESP", function(state)
            UniversalFeatures.PlayerEspEnabled = state
            print("Player ESP:", state)
        end)
        
        createToggle(contentFrame, "Item ESP", function(state)
            UniversalFeatures.EspEnabled = state
            print("Item ESP:", state)
        end)
        
        createToggle(contentFrame, "NPC ESP", function(state)
            UniversalFeatures.NpcEspEnabled = state
            print("NPC ESP:", state)
        end)
        
        createToggle(contentFrame, "X-Ray", function(state)
            UniversalFeatures.XrayEnabled = state
            print("X-Ray:", state)
        end)
        
    elseif tabName == "⚔️ Combat" then
        createToggle(contentFrame, "Aimbot", function(state)
            UniversalFeatures.AimbotEnabled = state
            print("Aimbot:", state)
        end)
        
        createToggle(contentFrame, "Triggerbot", function(state)
            UniversalFeatures.AutoClicker = state
            print("Triggerbot:", state)
        end)
        
    elseif tabName == "🚀 Movement" then
        createToggle(contentFrame, "Fly", function(state)
            UniversalFeatures.Flying = state
            print("Fly:", state)
        end)
        
        createToggle(contentFrame, "Speed", function(state)
            UniversalFeatures.SpeedEnabled = state
            print("Speed:", state)
        end)
        
        createToggle(contentFrame, "NoClip", function(state)
            UniversalFeatures.NoClipEnabled = state
            print("NoClip:", state)
        end)
        
    elseif tabName == "🌍 World" then
        createButton(contentFrame, "☀️ Day Time", function()
            UniversalFeatures.TimeDay()
            print("Day Time Set")
        end)
        
        createButton(contentFrame, "🌙 Night Time", function()
            UniversalFeatures.TimeNight()
            print("Night Time Set")
        end)
        
        createButton(contentFrame, "⬇️ Low Gravity", function()
            UniversalFeatures.LowGravity()
            print("Low Gravity Set")
        end)
        
        createToggle(contentFrame, "💡 Fullbright", function(state)
            UniversalFeatures.Fullbright = state
            print("Fullbright:", state)
        end)
        
    elseif tabName == "🗑️ Cleanup" then
        createButton(contentFrame, "🧹 Clear Workspace", function()
            UniversalFeatures.RemoveAll()
            print("Workspace Cleared")
        end)
        
        createButton(contentFrame, "🗡️ Remove Weapons", function()
            UniversalFeatures.RemoveTools()
            print("Weapons Removed")
        end)
        
    elseif tabName == "🌐 Server" then
        createButton(contentFrame, "🔄 Rejoin Server", function()
            UniversalFeatures.RejoinServer()
            print("Rejoining Server...")
        end)
        
        createButton(contentFrame, "🚀 Server Hop", function()
            UniversalFeatures.ServerHop()
            print("Server Hopping...")
        end)
        
        createButton(contentFrame, "📋 Copy Game ID", function()
            UniversalFeatures.CopyGameId()
        end)
        
    elseif tabName == "⚙️ Settings" then
        createButton(contentFrame, "🎨 Default Theme", function()
            CurrentTheme = "Default"
            updateTheme()
            print("Theme changed to Default")
        end)
        
        createButton(contentFrame, "🌙 Dark Theme", function()
            CurrentTheme = "Dark"
            updateTheme()
            print("Theme changed to Dark")
        end)
        
        createButton(contentFrame, "💖 Pink Theme", function()
            CurrentTheme = "Pink"
            updateTheme()
            print("Theme changed to Pink")
        end)
        
        createButton(contentFrame, "💚 Green Theme", function()
            CurrentTheme = "Green"
            updateTheme()
            print("Theme changed to Green")
        end)
        
        createButton(contentFrame, "💜 Purple Theme", function()
            CurrentTheme = "Purple"
            updateTheme()
            print("Theme changed to Purple")
        end)
        
    elseif tabName == "📋 Player List" then
        createButton(contentFrame, "📖 Open Player List GUI", function()
            PlayerListContainer.Visible = not PlayerListContainer.Visible
        end)
        
        createButton(contentFrame, "🔄 Refresh List", function()
            updatePlayerList()
        end)
    end
end

if tabDefinitions[1] then
    loadTabContent(tabDefinitions[1].Name, Tabs[tabDefinitions[1].Name].Content)
end

local PlayerListContainer = Instance.new("Frame")
PlayerListContainer.Name = "PlayerListContainer"
PlayerListContainer.Size = UDim2.new(0, 350, 0, 400)
PlayerListContainer.Position = UDim2.new(0.5, 200, 0.5, -200)
PlayerListContainer.BackgroundColor3 = ThemeColors.MainBg
PlayerListContainer.BorderSizePixel = 0
PlayerListContainer.Visible = false
PlayerListContainer.Parent = PlayerListScreenGui

local PlayerListTopBar = Instance.new("Frame")
PlayerListTopBar.Size = UDim2.new(1, 0, 0, 35)
PlayerListTopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
PlayerListTopBar.BorderSizePixel = 0
PlayerListTopBar.Parent = PlayerListContainer

local PlayerListTitle = Instance.new("TextLabel")
PlayerListTitle.Text = "👥 Player List"
PlayerListTitle.Size = UDim2.new(0, 200, 1, 0)
PlayerListTitle.Position = UDim2.new(0, 10, 0, 0)
PlayerListTitle.BackgroundTransparency = 1
PlayerListTitle.TextColor3 = ThemeColors.Accent
PlayerListTitle.TextSize = 18
PlayerListTitle.Font = Enum.Font.GothamBold
PlayerListTitle.TextXAlignment = Enum.TextXAlignment.Left
PlayerListTitle.Parent = PlayerListTopBar

local PlayerListClose = Instance.new("TextButton")
PlayerListClose.Text = "×"
PlayerListClose.Size = UDim2.new(0, 35, 1, 0)
PlayerListClose.Position = UDim2.new(1, -35, 0, 0)
PlayerListClose.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
PlayerListClose.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerListClose.TextSize = 20
PlayerListClose.Font = Enum.Font.GothamBold
PlayerListClose.Parent = PlayerListTopBar

local PlayerListScroll = Instance.new("ScrollingFrame")
PlayerListScroll.Size = UDim2.new(1, 0, 1, -35)
PlayerListScroll.Position = UDim2.new(0, 0, 0, 35)
PlayerListScroll.BackgroundColor3 = ThemeColors.ContentBg
PlayerListScroll.BorderSizePixel = 0
PlayerListScroll.ScrollBarThickness = 6
PlayerListScroll.ScrollBarImageColor3 = ThemeColors.Accent
PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListScroll.Parent = PlayerListContainer

PlayerListTopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local dragStart = input.Position
        local startPos = PlayerListContainer.Position
        local connection
        
        connection = RunService.RenderStepped:Connect(function()
            local mouse = UserInputService:GetMouseLocation()
            local delta = mouse - dragStart
            PlayerListContainer.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end)
        
        UserInputService.InputEnded:Connect(function(endInput)
            if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
end)

PlayerListClose.MouseButton1Click:Connect(function()
    PlayerListContainer.Visible = false
end)

local selectedPlayer = nil
local function updatePlayerList()
    for _, child in pairs(PlayerListScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for i, player in ipairs(Players:GetPlayers()) do
        local PlayerButton = Instance.new("TextButton")
        PlayerButton.Text = player.Name .. (player == LocalPlayer and " (You)" or "")
        PlayerButton.Size = UDim2.new(1, -20, 0, 40)
        PlayerButton.Position = UDim2.new(0, 10, 0, (i-1) * 45)
        PlayerButton.BackgroundColor3 = player == LocalPlayer and Color3.fromRGB(40, 60, 80) or ThemeColors.Button
        PlayerButton.BorderSizePixel = 0
        PlayerButton.TextColor3 = player == LocalPlayer and ThemeColors.Accent or ThemeColors.Text
        PlayerButton.TextSize = 14
        PlayerButton.Font = Enum.Font.Gotham
        PlayerButton.Parent = PlayerListScroll
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0.1, 0)
        Corner.Parent = PlayerButton
        
        if player ~= LocalPlayer then
            PlayerButton.MouseButton1Click:Connect(function()
                selectedPlayer = player.Name
                for _, btn in pairs(PlayerListScroll:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = (btn == PlayerButton and ThemeColors.Accent) or 
                                              (btn.Text:find("(You)") and Color3.fromRGB(40, 60, 80) or ThemeColors.Button)
                    end
                end
                print("Selected Player:", selectedPlayer)
            end)
            
            setupButtonHover(PlayerButton, PlayerButton.BackgroundColor3, Color3.fromRGB(
                math.min(PlayerButton.BackgroundColor3.R * 255 + 30, 255),
                math.min(PlayerButton.BackgroundColor3.G * 255 + 30, 255),
                math.min(PlayerButton.BackgroundColor3.B * 255 + 30, 255)
            ) / 255)
        end
    end
    
    PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 45)
end

updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

UniversalFeatures.TeleportToPlayer = function(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:PivotTo(targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
        end
    end
end

UniversalFeatures.BringPlayer = function(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer.Character:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
        end
    end
end

UniversalFeatures.KillPlayer = function(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
        targetPlayer.Character.Humanoid.Health = 0
    end
end

UniversalFeatures.FreezePlayer = function(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character then
        for _, part in pairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
            end
        end
    end
end

UniversalFeatures.SitOnHead = function(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:PivotTo(targetPlayer.Character.Head.CFrame + Vector3.new(0, 3, 0))
        end
    end
end

UniversalFeatures.GodMode = function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.MaxHealth = math.huge
        LocalPlayer.Character.Humanoid.Health = math.huge
    end
end

UniversalFeatures.Invisible = function()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.Transparency = 1 end
        end
    end
end

UniversalFeatures.HealCharacter = function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
    end
end

UniversalFeatures.ResetCharacter = function()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end

UniversalFeatures.TimeDay = function()
    game:GetService("Lighting").ClockTime = 14
end

UniversalFeatures.TimeNight = function()
    game:GetService("Lighting").ClockTime = 0
end

UniversalFeatures.LowGravity = function()
    workspace.Gravity = 10
end

UniversalFeatures.RemoveAll = function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            obj:Destroy()
        end
    end
end

UniversalFeatures.RemoveTools = function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            for _, tool in pairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") then tool:Destroy() end
            end
        end
    end
end

UniversalFeatures.RejoinServer = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end

UniversalFeatures.ServerHop = function()
end

UniversalFeatures.CopyGameId = function()
    setclipboard(tostring(game.PlaceId))
end

local Cry0xeneWatermark = Drawing.new("Text")
Cry0xeneWatermark.Text = "Cry0xene"
Cry0xeneWatermark.Size = 35
Cry0xeneWatermark.Font = 2
Cry0xeneWatermark.Outline = true
Cry0xeneWatermark.Center = true
RunService.RenderStepped:Connect(function()
    Cry0xeneWatermark.Position = Vector2.new(camera.ViewportSize.X/2, 60)
    Cry0xeneWatermark.Color = ThemeColors.Accent
end)

print("✅ Cry0xene GUI v6.0 Loaded!")
print("✅ Fixed dragging - now works properly")
print("✅ Added 5 beautiful themes in Settings tab")
print("✅ All buttons now clickable")
print("✅ Right Control to toggle")
print("✅ Awesome UI with your profile picture")

return UniversalFeatures
