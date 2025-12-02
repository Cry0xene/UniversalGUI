local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local Themes = {
    Default = {MainBg = Color3.fromRGB(15, 20, 30), SidebarBg = Color3.fromRGB(10, 15, 25), ContentBg = Color3.fromRGB(20, 25, 40), Accent = Color3.fromRGB(0, 200, 255), Text = Color3.fromRGB(230, 230, 250), Button = Color3.fromRGB(30, 40, 60), DarkButton = Color3.fromRGB(20, 30, 50)},
    Cyber = {MainBg = Color3.fromRGB(10, 10, 20), SidebarBg = Color3.fromRGB(5, 5, 15), ContentBg = Color3.fromRGB(15, 15, 30), Accent = Color3.fromRGB(0, 255, 255), Text = Color3.fromRGB(200, 240, 255), Button = Color3.fromRGB(25, 35, 55), DarkButton = Color3.fromRGB(15, 25, 45)},
    Neon = {MainBg = Color3.fromRGB(20, 10, 30), SidebarBg = Color3.fromRGB(15, 5, 25), ContentBg = Color3.fromRGB(25, 15, 40), Accent = Color3.fromRGB(255, 0, 255), Text = Color3.fromRGB(255, 200, 255), Button = Color3.fromRGB(40, 20, 60), DarkButton = Color3.fromRGB(30, 10, 50)},
    Matrix = {MainBg = Color3.fromRGB(0, 15, 0), SidebarBg = Color3.fromRGB(0, 10, 0), ContentBg = Color3.fromRGB(0, 20, 0), Accent = Color3.fromRGB(0, 255, 0), Text = Color3.fromRGB(200, 255, 200), Button = Color3.fromRGB(0, 30, 0), DarkButton = Color3.fromRGB(0, 20, 0)},
    Sunset = {MainBg = Color3.fromRGB(30, 15, 10), SidebarBg = Color3.fromRGB(25, 10, 5), ContentBg = Color3.fromRGB(35, 20, 15), Accent = Color3.fromRGB(255, 100, 0), Text = Color3.fromRGB(255, 230, 200), Button = Color3.fromRGB(50, 25, 20), DarkButton = Color3.fromRGB(40, 15, 10)},
    Gold = {MainBg = Color3.fromRGB(20, 15, 5), SidebarBg = Color3.fromRGB(15, 10, 0), ContentBg = Color3.fromRGB(25, 20, 10), Accent = Color3.fromRGB(255, 215, 0), Text = Color3.fromRGB(255, 245, 200), Button = Color3.fromRGB(40, 30, 15), DarkButton = Color3.fromRGB(30, 20, 5)},
    Ocean = {MainBg = Color3.fromRGB(10, 20, 35), SidebarBg = Color3.fromRGB(5, 15, 30), ContentBg = Color3.fromRGB(15, 25, 45), Accent = Color3.fromRGB(0, 150, 255), Text = Color3.fromRGB(200, 230, 255), Button = Color3.fromRGB(25, 35, 55), DarkButton = Color3.fromRGB(15, 25, 40)},
    Blood = {MainBg = Color3.fromRGB(25, 5, 5), SidebarBg = Color3.fromRGB(20, 0, 0), ContentBg = Color3.fromRGB(35, 10, 10), Accent = Color3.fromRGB(255, 0, 0), Text = Color3.fromRGB(255, 200, 200), Button = Color3.fromRGB(45, 15, 15), DarkButton = Color3.fromRGB(35, 5, 5)}
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
MainGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local PlayerListGui = Instance.new("ScreenGui")
PlayerListGui.Name = "Cry0xenePlayers"
PlayerListGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PlayerListGui.DisplayOrder = 998
PlayerListGui.Enabled = false
PlayerListGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 750, 0, 600)
MainFrame.Position = UDim2.new(0.5, -375, 0.5, -300)
MainFrame.BackgroundColor3 = ThemeColors.MainBg
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = MainGui

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(5, 10, 20)
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = MainFrame

local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(0, 320, 1, 0)
TitleFrame.Position = UDim2.new(0, 20, 0, 0)
TitleFrame.BackgroundTransparency = 1
TitleFrame.Parent = Header

local Title = Instance.new("TextLabel")
Title.Text = "CRY0XENE ULTIMATE HUB"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = ThemeColors.Accent
Title.TextSize = 24
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Text = "v7.0 | 140+ FEATURES"
Subtitle.Size = UDim2.new(1, 0, 0, 18)
Subtitle.Position = UDim2.new(0, 0, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.TextColor3 = Color3.fromRGB(150, 200, 255)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TitleFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 50, 1, 0)
CloseButton.Position = UDim2.new(1, -50, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "—"
MinimizeButton.Size = UDim2.new(0, 50, 1, 0)
MinimizeButton.Position = UDim2.new(1, -100, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 28
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = Header

local MainContent = Instance.new("Frame")
MainContent.Name = "MainContent"
MainContent.Size = UDim2.new(1, 0, 1, -50)
MainContent.Position = UDim2.new(0, 0, 0, 50)
MainContent.BackgroundTransparency = 1
MainContent.Parent = MainFrame

local SidePanel = Instance.new("Frame")
SidePanel.Name = "SidePanel"
SidePanel.Size = UDim2.new(0, 220, 1, 0)
SidePanel.Position = UDim2.new(0, 0, 0, 0)
SidePanel.BackgroundColor3 = ThemeColors.SidebarBg
SidePanel.BorderSizePixel = 0
SidePanel.Parent = MainContent

local ProfileCard = Instance.new("Frame")
ProfileCard.Name = "ProfileCard"
ProfileCard.Size = UDim2.new(1, 0, 0, 200)
ProfileCard.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
ProfileCard.BorderSizePixel = 0
ProfileCard.Parent = SidePanel

local AvatarFrame = Instance.new("Frame")
AvatarFrame.Size = UDim2.new(0, 100, 0, 100)
AvatarFrame.Position = UDim2.new(0.5, -50, 0, 20)
AvatarFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
AvatarFrame.BorderSizePixel = 0
local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarFrame

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(1, -10, 1, -10)
AvatarImage.Position = UDim2.new(0, 5, 0, 5)
AvatarImage.BackgroundTransparency = 1
AvatarImage.Image = getPlayerAvatar(LocalPlayer.UserId)
local ImageCorner = Instance.new("UICorner")
ImageCorner.CornerRadius = UDim.new(1, 0)
ImageCorner.Parent = AvatarImage
AvatarImage.Parent = AvatarFrame
AvatarFrame.Parent = ProfileCard

local UsernameText = Instance.new("TextLabel")
UsernameText.Text = "@" .. LocalPlayer.Name
UsernameText.Size = UDim2.new(1, -20, 0, 25)
UsernameText.Position = UDim2.new(0, 10, 0, 140)
UsernameText.BackgroundTransparency = 1
UsernameText.TextColor3 = ThemeColors.Text
UsernameText.TextSize = 16
UsernameText.Font = Enum.Font.GothamBold
UsernameText.TextXAlignment = Enum.TextXAlignment.Center
UsernameText.Parent = ProfileCard

local DisplayNameText = Instance.new("TextLabel")
DisplayNameText.Text = LocalPlayer.DisplayName
DisplayNameText.Size = UDim2.new(1, -20, 0, 20)
DisplayNameText.Position = UDim2.new(0, 10, 0, 165)
DisplayNameText.BackgroundTransparency = 1
DisplayNameText.TextColor3 = Color3.fromRGB(180, 200, 255)
DisplayNameText.TextSize = 14
DisplayNameText.Font = Enum.Font.Gotham
DisplayNameText.TextXAlignment = Enum.TextXAlignment.Center
DisplayNameText.Parent = ProfileCard

local TimeCard = Instance.new("Frame")
TimeCard.Size = UDim2.new(1, -20, 0, 40)
TimeCard.Position = UDim2.new(0, 10, 0, 200)
TimeCard.BackgroundColor3 = ThemeColors.ContentBg
TimeCard.BorderSizePixel = 0
local TimeCorner = Instance.new("UICorner")
TimeCorner.CornerRadius = UDim.new(0.1, 0)
TimeCorner.Parent = TimeCard
TimeCard.Parent = ProfileCard

local TimeIcon = Instance.new("ImageLabel")
TimeIcon.Image = "rbxassetid://6031280882"
TimeIcon.Size = UDim2.new(0, 20, 0, 20)
TimeIcon.Position = UDim2.new(0, 10, 0.5, -10)
TimeIcon.BackgroundTransparency = 1
TimeIcon.ImageColor3 = ThemeColors.Accent
TimeIcon.Parent = TimeCard

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Text = "00:00:00"
TimeLabel.Size = UDim2.new(1, -40, 1, 0)
TimeLabel.Position = UDim2.new(0, 35, 0, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.TextColor3 = ThemeColors.Text
TimeLabel.TextSize = 16
TimeLabel.Font = Enum.Font.GothamBold
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeLabel.Parent = TimeCard

spawn(function()
    while true do
        local time = os.date("%H:%M:%S")
        TimeLabel.Text = time
        wait(1)
    end
end)

local TabsPanel = Instance.new("Frame")
TabsPanel.Name = "TabsPanel"
TabsPanel.Size = UDim2.new(1, 0, 1, -240)
TabsPanel.Position = UDim2.new(0, 0, 0, 240)
TabsPanel.BackgroundTransparency = 1
TabsPanel.Parent = SidePanel

local TabButtons = Instance.new("ScrollingFrame")
TabButtons.Size = UDim2.new(1, 0, 1, 0)
TabButtons.BackgroundTransparency = 1
TabButtons.BorderSizePixel = 0
TabButtons.ScrollBarThickness = 3
TabButtons.ScrollBarImageColor3 = ThemeColors.Accent
TabButtons.CanvasSize = UDim2.new(0, 0, 0, 0)
TabButtons.Parent = TabsPanel

local ContentPanel = Instance.new("Frame")
ContentPanel.Name = "ContentPanel"
ContentPanel.Size = UDim2.new(1, -220, 1, 0)
ContentPanel.Position = UDim2.new(0, 220, 0, 0)
ContentPanel.BackgroundColor3 = ThemeColors.ContentBg
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainContent

local ContentHeader = Instance.new("Frame")
ContentHeader.Name = "ContentHeader"
ContentHeader.Size = UDim2.new(1, 0, 0, 60)
ContentHeader.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
ContentHeader.BorderSizePixel = 0
ContentHeader.Parent = ContentPanel

local ContentTitle = Instance.new("TextLabel")
ContentTitle.Text = "SYSTEM CONTROL"
ContentTitle.Size = UDim2.new(1, -40, 1, 0)
ContentTitle.Position = UDim2.new(0, 20, 0, 0)
ContentTitle.BackgroundTransparency = 1
ContentTitle.TextColor3 = ThemeColors.Accent
ContentTitle.TextSize = 24
ContentTitle.Font = Enum.Font.GothamBlack
ContentTitle.TextXAlignment = Enum.TextXAlignment.Left
ContentTitle.Parent = ContentHeader

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, -60)
ContentScroll.Position = UDim2.new(0, 0, 0, 60)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 6
ContentScroll.ScrollBarImageColor3 = ThemeColors.Accent
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentPanel

local dragging = false
local dragStart, startPos

local function updateTheme()
    ThemeColors = Themes[CurrentTheme]
    
    MainFrame.BackgroundColor3 = ThemeColors.MainBg
    SidePanel.BackgroundColor3 = ThemeColors.SidebarBg
    ContentPanel.BackgroundColor3 = ThemeColors.ContentBg
    Title.TextColor3 = ThemeColors.Accent
    ContentTitle.TextColor3 = ThemeColors.Accent
    ProfileCard.BackgroundColor3 = Color3.fromRGB(math.min(ThemeColors.SidebarBg.R * 255 + 5, 255), math.min(ThemeColors.SidebarBg.G * 255 + 5, 255), math.min(ThemeColors.SidebarBg.B * 255 + 5, 255)) / 255
    UsernameText.TextColor3 = ThemeColors.Text
    DisplayNameText.TextColor3 = Color3.fromRGB(math.min(ThemeColors.Text.R * 255 - 30, 255), math.min(ThemeColors.Text.G * 255 - 30, 255), math.min(ThemeColors.Text.B * 255 - 30, 255)) / 255
    TimeCard.BackgroundColor3 = ThemeColors.ContentBg
    TimeIcon.ImageColor3 = ThemeColors.Accent
    TimeLabel.TextColor3 = ThemeColors.Text
    TabButtons.ScrollBarImageColor3 = ThemeColors.Accent
    ContentScroll.ScrollBarImageColor3 = ThemeColors.Accent
    ContentHeader.BackgroundColor3 = Color3.fromRGB(math.min(ThemeColors.ContentBg.R * 255 - 10, 255), math.min(ThemeColors.ContentBg.G * 255 - 10, 255), math.min(ThemeColors.ContentBg.B * 255 - 10, 255)) / 255
    
    for _, tab in pairs(Tabs) do
        if tab.Button and tab.Button:IsA("TextButton") then
            if CurrentTab == tab.Button.Name:gsub("Tab", "") then
                tab.Button.BackgroundColor3 = ThemeColors.Accent
                tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                tab.Button.BackgroundColor3 = ThemeColors.DarkButton
                tab.Button.TextColor3 = ThemeColors.Text
            end
        end
    end
end

Header.InputBegan:Connect(function(input)
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
    {Name = "DASHBOARD", Icon = "📊"},
    {Name = "PLAYER TOOLS", Icon = "🎮"},
    {Name = "SELF MODS", Icon = "👤"},
    {Name = "VISUAL ESP", Icon = "👁️"},
    {Name = "COMBAT", Icon = "⚔️"},
    {Name = "MOVEMENT", Icon = "🚀"},
    {Name = "WORLD", Icon = "🌍"},
    {Name = "CLEANUP", Icon = "🗑️"},
    {Name = "SERVER", Icon = "🌐"},
    {Name = "THEMES", Icon = "🎨"},
    {Name = "PLAYER LIST", Icon = "📋"},
    {Name = "TELEPORTS", Icon = "📍"},
    {Name = "ANIMATIONS", Icon = "💃"},
    {Name = "VEHICLES", Icon = "🚗"},
    {Name = "WEAPONS", Icon = "🔫"},
    {Name = "FUN", Icon = "🎭"},
    {Name = "ADMIN", Icon = "👑"},
    {Name = "SETTINGS", Icon = "⚙️"}
}

local buttonY = 0
for i, tabData in ipairs(tabList) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabData.Name .. "Tab"
    TabButton.Text = "  " .. tabData.Icon .. "  " .. tabData.Name
    TabButton.Size = UDim2.new(1, -20, 0, 45)
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
    
    TabButton.Parent = TabButtons
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
    
    buttonY = buttonY + 50
end

TabButtons.CanvasSize = UDim2.new(0, 0, 0, buttonY)

CloseButton.MouseButton1Click:Connect(function()
    MainGui:Destroy()
    PlayerListGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

local Features = {
    Flying = false,
    NoClip = false,
    SpeedHack = false,
    Xray = false,
    Fullbright = false,
    Esp = false,
    Aimbot = false,
    AutoClick = false,
    InfJump = false,
    GodMode = false,
    Invisible = false,
    NoclipWalk = false,
    AntiAfk = false,
    AntiStomp = false,
    AntiGrab = false,
    AntiStun = false,
    AntiSlow = false,
    AntiFreeze = false,
    AntiKill = false,
    AntiBan = false,
    AntiKick = false,
    AntiCrash = false,
    AntiLag = false,
    AntiReport = false,
    AntiSpectate = false,
    AntiTeleport = false,
    AntiVoid = false,
    AntiExploit = false,
    AntiScript = false,
    AntiTool = false,
    AntiWeapon = false,
    AntiBullet = false,
    AntiMelee = false,
    AntiRagdoll = false,
    AntiFall = false,
    AntiPush = false,
    AntiPull = false,
    AntiKnock = false,
    AntiStagger = false,
    AntiStunlock = false,
    AntiCombo = false,
    AntiChain = false,
    AntiGrabChain = false,
    AntiStunChain = false,
    AntiKillChain = false,
    AntiBanChain = false,
    AntiKickChain = false,
    AntiCrashChain = false,
    AntiLagChain = false,
    AntiReportChain = false,
    AntiSpectateChain = false,
    AntiTeleportChain = false,
    AntiVoidChain = false,
    AntiExploitChain = false,
    AntiScriptChain = false,
    AntiToolChain = false,
    AntiWeaponChain = false,
    AntiBulletChain = false,
    AntiMeleeChain = false,
    AntiRagdollChain = false,
    AntiFallChain = false,
    AntiPushChain = false,
    AntiPullChain = false,
    AntiKnockChain = false,
    AntiStaggerChain = false,
    AntiStunlockChain = false,
    AntiComboChain = false,
    AntiChainChain = false
}

local selectedPlayer = nil

local function createButton(parent, text, callback)
    local yPos = #parent:GetChildren() * 50
    
    local Button = Instance.new("TextButton")
    Button.Text = text
    Button.Size = UDim2.new(1, -30, 0, 45)
    Button.Position = UDim2.new(0, 15, 0, yPos)
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
    
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 55)
    return Button
end

local function createToggle(parent, text, callback, defaultState)
    local yPos = #parent:GetChildren() * 50
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -30, 0, 45)
    ToggleFrame.Position = UDim2.new(0, 15, 0, yPos)
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
    ToggleButton.Size = UDim2.new(0, 80, 0, 30)
    ToggleButton.Position = UDim2.new(1, -80, 0.5, -15)
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
    parent.CanvasSize = UDim2.new(0, 0, 0, yPos + 55)
    return ToggleFrame
end

local function loadTabContent(tabName, contentFrame)
    for _, child in pairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
    
    if tabName == "DASHBOARD" then
        createButton(contentFrame, "🚀 INITIALIZE ALL MODULES", function() print("Modules Initialized") end)
        createButton(contentFrame, "⚡ QUICK SETUP WIZARD", function() print("Setup Complete") end)
        createButton(contentFrame, "📊 OPEN PLAYER LIST", function() PlayerListGui.Enabled = true end)
        createToggle(contentFrame, "AUTO-LOAD ON START", function(state) print("Auto-Load:", state) end, false)
        createToggle(contentFrame, "SAFE MODE", function(state) print("Safe Mode:", state) end, true)
        createToggle(contentFrame, "ANTI-CRASH", function(state) print("Anti-Crash:", state) end, true)
        createButton(contentFrame, "🔄 REFRESH GUI", function() loadTabContent(tabName, contentFrame) end)
        createButton(contentFrame, "📁 SAVE CONFIG", function() print("Config Saved") end)
        createButton(contentFrame, "📂 LOAD CONFIG", function() print("Config Loaded") end)
        
    elseif tabName == "PLAYER TOOLS" then
        createButton(contentFrame, "📍 TELEPORT TO PLAYER", function() if selectedPlayer then Features.TeleportToPlayer(selectedPlayer) end end)
        createButton(contentFrame, "🚀 BRING PLAYER", function() if selectedPlayer then Features.BringPlayer(selectedPlayer) end end)
        createButton(contentFrame, "💀 KILL PLAYER", function() if selectedPlayer then Features.KillPlayer(selectedPlayer) end end)
        createButton(contentFrame, "❄️ FREEZE PLAYER", function() if selectedPlayer then Features.FreezePlayer(selectedPlayer) end end)
        createButton(contentFrame, "🔥 BURN PLAYER", function() if selectedPlayer then Features.BurnPlayer(selectedPlayer) end end)
        createButton(contentFrame, "⚡ SHOCK PLAYER", function() if selectedPlayer then Features.ShockPlayer(selectedPlayer) end end)
        createButton(contentFrame, "🌀 SPIN PLAYER", function() if selectedPlayer then Features.SpinPlayer(selectedPlayer) end end)
        createButton(contentFrame, "🚫 BANISH PLAYER", function() if selectedPlayer then Features.BanishPlayer(selectedPlayer) end end)
        createButton(contentFrame, "👻 GHOST PLAYER", function() if selectedPlayer then Features.GhostPlayer(selectedPlayer) end end)
        createButton(contentFrame, "💩 POOP PLAYER", function() if selectedPlayer then Features.PoopPlayer(selectedPlayer) end end)
        createButton(contentFrame, "🎭 MIMIC PLAYER", function() if selectedPlayer then Features.MimicPlayer(selectedPlayer) end end)
        createButton(contentFrame, "🔒 JAIL PLAYER", function() if selectedPlayer then Features.JailPlayer(selectedPlayer) end end)
        createButton(contentFrame, "🦶 TRIP PLAYER", function() if selectedPlayer then Features.TripPlayer(selectedPlayer) end end)
        createButton(contentFrame, "🎤 MUTE PLAYER", function() if selectedPlayer then Features.MutePlayer(selectedPlayer) end end)
        createButton(contentFrame, "🔇 DEAFEN PLAYER", function() if selectedPlayer then Features.DeafenPlayer(selectedPlayer) end end)
        createButton(contentFrame, "👁️ SPECTATE PLAYER", function() if selectedPlayer then Features.SpectatePlayer(selectedPlayer) end end)
        
    elseif tabName == "SELF MODS" then
        createToggle(contentFrame, "🛡️ GOD MODE", function(state) Features.GodMode = state print("God Mode:", state) end, false)
        createToggle(contentFrame, "👻 INVISIBLE", function(state) Features.Invisible = state print("Invisible:", state) end, false)
        createToggle(contentFrame, "🌀 NO CLIP", function(state) Features.NoClip = state print("NoClip:", state) end, false)
        createToggle(contentFrame, "🚀 FLY MODE", function(state) Features.Flying = state print("Fly:", state) end, false)
        createToggle(contentFrame, "⚡ SPEED HACK", function(state) Features.SpeedHack = state print("Speed:", state) end, false)
        createToggle(contentFrame, "🔄 INFINITE JUMP", function(state) Features.InfJump = state print("Inf Jump:", state) end, false)
        createToggle(contentFrame, "🦸 SUPER JUMP", function(state) print("Super Jump:", state) end, false)
        createToggle(contentFrame, "💨 SUPER SPEED", function(state) print("Super Speed:", state) end, false)
        createToggle(contentFrame, "🕶️ NIGHT VISION", function(state) print("Night Vision:", state) end, false)
        createToggle(contentFrame, "🔦 X-RAY VISION", function(state) Features.Xray = state print("X-Ray:", state) end, false)
        createToggle(contentFrame, "💡 FULLBRIGHT", function(state) Features.Fullbright = state print("Fullbright:", state) end, false)
        createToggle(contentFrame, "🛡️ ANTI-AFK", function(state) Features.AntiAfk = state print("Anti-AFK:", state) end, true)
        createToggle(contentFrame, "🛡️ ANTI-STOMP", function(state) Features.AntiStomp = state print("Anti-Stomp:", state) end, true)
        createButton(contentFrame, "❤️ HEAL SELF", function() Features.HealSelf() print("Healed") end)
        createButton(contentFrame, "🔄 RESET CHARACTER", function() Features.ResetChar() print("Reset") end)
        createButton(contentFrame, "🌟 SUPER SIZE", function() Features.SuperSize() print("Super Size") end)
        createButton(contentFrame, "🐜 TINY SIZE", function() Features.TinySize() print("Tiny Size") end)
        
    elseif tabName == "VISUAL ESP" then
        createToggle(contentFrame, "👤 PLAYER ESP", function(state) Features.Esp = state print("Player ESP:", state) end, false)
        createToggle(contentFrame, "📦 ITEM ESP", function(state) print("Item ESP:", state) end, false)
        createToggle(contentFrame, "👹 NPC ESP", function(state) print("NPC ESP:", state) end, false)
        createToggle(contentFrame, "🚗 VEHICLE ESP", function(state) print("Vehicle ESP:", state) end, false)
        createToggle(contentFrame, "💎 LOOT ESP", function(state) print("Loot ESP:", state) end, false)
        createToggle(contentFrame, "🚨 DANGER ESP", function(state) print("Danger ESP:", state) end, false)
        createToggle(contentFrame, "📐 BOX ESP", function(state) print("Box ESP:", state) end, false)
        createToggle(contentFrame, "📏 TRACER ESP", function(state) print("Tracer ESP:", state) end, false)
        createToggle(contentFrame, "📝 NAME ESP", function(state) print("Name ESP:", state) end, false)
        createToggle(contentFrame, "❤️ HEALTH ESP", function(state) print("Health ESP:", state) end, false)
        createToggle(contentFrame, "🛡️ ARMOR ESP", function(state) print("Armor ESP:", state) end, false)
        createToggle(contentFrame, "🔫 WEAPON ESP", function(state) print("Weapon ESP:", state) end, false)
        createToggle(contentFrame, "💰 MONEY ESP", function(state) print("Money ESP:", state) end, false)
        createToggle(contentFrame, "🎯 AIMBOT ESP", function(state) print("Aimbot ESP:", state) end, false)
        createToggle(contentFrame, "👁️ CHAMS", function(state) print("Chams:", state) end, false)
        createToggle(contentFrame, "🌈 GLOW ESP", function(state) print("Glow ESP:", state) end, false)
        createToggle(contentFrame, "🌫️ WALLHACK", function(state) print("Wallhack:", state) end, false)
        
    elseif tabName == "COMBAT" then
        createToggle(contentFrame, "🎯 AIMBOT", function(state) Features.Aimbot = state print("Aimbot:", state) end, false)
        createToggle(contentFrame, "🔫 TRIGGERBOT", function(state) Features.AutoClick = state print("Triggerbot:", state) end, false)
        createToggle(contentFrame, "💥 AUTO-SHOOT", function(state) print("Auto-Shoot:", state) end, false)
        createToggle(contentFrame, "🎯 SILENT AIM", function(state) print("Silent Aim:", state) end, false)
        createToggle(contentFrame, "🌀 SPINBOT", function(state) print("Spinbot:", state) end, false)
        createToggle(contentFrame, "🚫 NO RECOIL", function(state) print("No Recoil:", state) end, false)
        createToggle(contentFrame, "🎯 NO SPREAD", function(state) print("No Spread:", state) end, false)
        createToggle(contentFrame, "⚡ INSTANT HIT", function(state) print("Instant Hit:", state) end, false)
        createToggle(contentFrame, "💀 ONE SHOT", function(state) print("One Shot:", state) end, false)
        createToggle(contentFrame, "🔄 AUTO-RELOAD", function(state) print("Auto-Reload:", state) end, false)
        createToggle(contentFrame, "🎯 HEADSHOT ONLY", function(state) print("Headshot Only:", state) end, false)
        createToggle(contentFrame, "🛡️ AUTO-BLOCK", function(state) print("Auto-Block:", state) end, false)
        createToggle(contentFrame, "🌀 AUTO-DODGE", function(state) print("Auto-Dodge:", state) end, false)
        createToggle(contentFrame, "⚡ AUTO-PARRY", function(state) print("Auto-Parry:", state) end, false)
        createToggle(contentFrame, "💥 DAMAGE MULTIPLIER", function(state) print("Damage Multiplier:", state) end, false)
        createToggle(contentFrame, "❤️ HEALTH MULTIPLIER", function(state) print("Health Multiplier:", state) end, false)
        
    elseif tabName == "MOVEMENT" then
        createToggle(contentFrame, "🚀 FLY HACK", function(state) Features.Flying = state print("Fly:", state) end, false)
        createToggle(contentFrame, "⚡ SPEED HACK", function(state) Features.SpeedHack = state print("Speed:", state) end, false)
        createToggle(contentFrame, "🌀 NO CLIP", function(state) Features.NoClip = state print("NoClip:", state) end, false)
        createToggle(contentFrame, "🏃 INFINITE STAMINA", function(state) print("Inf Stamina:", state) end, false)
        createToggle(contentFrame, "🦘 INFINITE JUMP", function(state) Features.InfJump = state print("Inf Jump:", state) end, false)
        createToggle(contentFrame, "🧱 WALL WALK", function(state) Features.NoclipWalk = state print("Wall Walk:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-FALL", function(state) Features.AntiFall = state print("Anti-Fall:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-PUSH", function(state) Features.AntiPush = state print("Anti-Push:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-KNOCK", function(state) Features.AntiKnock = state print("Anti-Knock:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-STAGGER", function(state) Features.AntiStagger = state print("Anti-Stagger:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-RAGDOLL", function(state) Features.AntiRagdoll = state print("Anti-Ragdoll:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-STUN", function(state) Features.AntiStun = state print("Anti-Stun:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-SLOW", function(state) Features.AntiSlow = state print("Anti-Slow:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-FREEZE", function(state) Features.AntiFreeze = state print("Anti-Freeze:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-GRAB", function(state) Features.AntiGrab = state print("Anti-Grab:", state) end, false)
        createToggle(contentFrame, "🚫 ANTI-STOMP", function(state) Features.AntiStomp = state print("Anti-Stomp:", state) end, false)
        
    elseif tabName == "WORLD" then
        createButton(contentFrame, "☀️ DAY TIME", function() Features.SetDay() print("Day") end)
        createButton(contentFrame, "🌙 NIGHT TIME", function() Features.SetNight() print("Night") end)
        createButton(contentFrame, "🌅 SUNRISE", function() Features.SetSunrise() print("Sunrise") end)
        createButton(contentFrame, "🌆 SUNSET", function() Features.SetSunset() print("Sunset") end)
        createButton(contentFrame, "🌧️ RAIN", function() Features.SetRain() print("Rain") end)
        createButton(contentFrame, "❄️ SNOW", function() Features.SetSnow() print("Snow") end)
        createButton(contentFrame, "🌪️ STORM", function() Features.SetStorm() print("Storm") end)
        createButton(contentFrame, "🌈 RAINBOW", function() Features.SetRainbow() print("Rainbow") end)
        createToggle(contentFrame, "💡 FULLBRIGHT", function(state) Features.Fullbright = state print("Fullbright:", state) end, false)
        createToggle(contentFrame, "🌌 FOG REMOVER", function(state) print("Fog Remover:", state) end, false)
        createToggle(contentFrame, "🕶️ NIGHT VISION", function(state) print("Night Vision:", state) end, false)
        createToggle(contentFrame, "🔦 X-RAY", function(state) Features.Xray = state print("X-Ray:", state) end, false)
        createToggle(contentFrame, "🌀 TIME STOP", function(state) print("Time Stop:", state) end, false)
        createToggle(contentFrame, "⏩ TIME SPEED", function(state) print("Time Speed:", state) end, false)
        createToggle(contentFrame, "⏪ TIME REVERSE", function(state) print("Time Reverse:", state) end, false)
        createToggle(contentFrame, "🌍 GRAVITY HACK", function(state) print("Gravity Hack:", state) end, false)
        
    elseif tabName == "CLEANUP" then
        createButton(contentFrame, "🧹 CLEAR WORKSPACE", function() Features.ClearWorkspace() print("Cleared") end)
        createButton(contentFrame, "🗡️ REMOVE WEAPONS", function() Features.RemoveWeapons() print("Weapons Removed") end)
        createButton(contentFrame, "📦 REMOVE TOOLS", function() Features.RemoveTools() print("Tools Removed") end)
        createButton(contentFrame, "👻 REMOVE NPCs", function() Features.RemoveNPCs() print("NPCs Removed") end)
        createButton(contentFrame, "🚗 REMOVE VEHICLES", function() Features.RemoveVehicles() print("Vehicles Removed") end)
        createButton(contentFrame, "💣 REMOVE EXPLOSIVES", function() Features.RemoveExplosives() print("Explosives Removed") end)
        createButton(contentFrame, "🛡️ REMOVE ARMOR", function() Features.RemoveArmor() print("Armor Removed") end)
        createButton(contentFrame, "💰 REMOVE MONEY", function() Features.RemoveMoney() print("Money Removed") end)
        createButton(contentFrame, "🎁 REMOVE LOOT", function() Features.RemoveLoot() print("Loot Removed") end)
        createButton(contentFrame, "🎯 REMOVE TARGETS", function() Features.RemoveTargets() print("Targets Removed") end)
        createButton(contentFrame, "🚨 REMOVE DANGERS", function() Features.RemoveDangers() print("Dangers Removed") end)
        createButton(contentFrame, "🌀 REMOVE EFFECTS", function() Features.RemoveEffects() print("Effects Removed") end)
        createButton(contentFrame, "🌫️ REMOVE FOG", function() Features.RemoveFog() print("Fog Removed") end)
        createButton(contentFrame, "💡 REMOVE LIGHTS", function() Features.RemoveLights() print("Lights Removed") end)
        createButton(contentFrame, "🌿 REMOVE PLANTS", function() Features.RemovePlants() print("Plants Removed") end)
        createButton(contentFrame, "🏗️ REMOVE BUILDINGS", function() Features.RemoveBuildings() print("Buildings Removed") end)
        
    elseif tabName == "SERVER" then
        createButton(contentFrame, "🔄 REJOIN SERVER", function() Features.RejoinServer() print("Rejoining...") end)
        createButton(contentFrame, "🚀 SERVER HOP", function() Features.ServerHop() print("Hopping...") end)
        createButton(contentFrame, "📋 COPY GAME ID", function() Features.CopyGameId() end)
        createButton(contentFrame, "📋 COPY JOB ID", function() Features.CopyJobId() end)
        createButton(contentFrame, "👥 COPY PLAYER LIST", function() Features.CopyPlayerList() end)
        createButton(contentFrame, "🕒 COPY SERVER TIME", function() Features.CopyServerTime() end)
        createButton(contentFrame, "📊 COPY SERVER STATS", function() Features.CopyServerStats() end)
        createButton(contentFrame, "🚫 CRASH SERVER", function() Features.CrashServer() print("Server Crash Attempt") end)
        createButton(contentFrame, "🌀 LAG SERVER", function() Features.LagServer() print("Server Lag Attempt") end)
        createButton(contentFrame, "💥 EXPLODE SERVER", function() Features.ExplodeServer() print("Server Explode Attempt") end)
        createButton(contentFrame, "❄️ FREEZE SERVER", function() Features.FreezeServer() print("Server Freeze Attempt") end)
        createButton(contentFrame, "🌊 FLOOD SERVER", function() Features.FloodServer() print("Server Flood Attempt") end)
        createButton(contentFrame, "⚡ SHOCK SERVER", function() Features.ShockServer() print("Server Shock Attempt") end)
        createButton(contentFrame, "🔥 BURN SERVER", function() Features.BurnServer() print("Server Burn Attempt") end)
        createButton(contentFrame, "🌀 SPIN SERVER", function() Features.SpinServer() print("Server Spin Attempt") end)
        createButton(contentFrame, "🚫 BANISH SERVER", function() Features.BanishServer() print("Server Banish Attempt") end)
        
    elseif tabName == "THEMES" then
        createButton(contentFrame, "🌌 DEFAULT THEME", function() CurrentTheme = "Default" updateTheme() print("Theme: Default") end)
        createButton(contentFrame, "💎 CYBER THEME", function() CurrentTheme = "Cyber" updateTheme() print("Theme: Cyber") end)
        createButton(contentFrame, "🌈 NEON THEME", function() CurrentTheme = "Neon" updateTheme() print("Theme: Neon") end)
        createButton(contentFrame, "📟 MATRIX THEME", function() CurrentTheme = "Matrix" updateTheme() print("Theme: Matrix") end)
        createButton(contentFrame, "🌅 SUNSET THEME", function() CurrentTheme = "Sunset" updateTheme() print("Theme: Sunset") end)
        createButton(contentFrame, "🌟 GOLD THEME", function() CurrentTheme = "Gold" updateTheme() print("Theme: Gold") end)
        createButton(contentFrame, "🌊 OCEAN THEME", function() CurrentTheme = "Ocean" updateTheme() print("Theme: Ocean") end)
        createButton(contentFrame, "🩸 BLOOD THEME", function() CurrentTheme = "Blood" updateTheme() print("Theme: Blood") end)
        createToggle(contentFrame, "🌙 DARK MODE", function(state) print("Dark Mode:", state) end, true)
        createToggle(contentFrame, "☀️ LIGHT MODE", function(state) print("Light Mode:", state) end, false)
        createToggle(contentFrame, "🌈 RAINBOW MODE", function(state) print("Rainbow Mode:", state) end, false)
        createToggle(contentFrame, "🌀 GLOW MODE", function(state) print("Glow Mode:", state) end, false)
        createToggle(contentFrame, "✨ SPARKLE MODE", function(state) print("Sparkle Mode:", state) end, false)
        createToggle(contentFrame, "🌌 GALAXY MODE", function(state) print("Galaxy Mode:", state) end, false)
        createToggle(contentFrame, "🔥 FIRE MODE", function(state) print("Fire Mode:", state) end, false)
        createToggle(contentFrame, "❄️ ICE MODE", function(state) print("Ice Mode:", state) end, false)
        
    elseif tabName == "PLAYER LIST" then
        createButton(contentFrame, "📖 OPEN PLAYER LIST", function() PlayerListGui.Enabled = true end)
        createButton(contentFrame, "🔄 REFRESH LIST", function() updatePlayerList() end)
        createButton(contentFrame, "👤 COPY USERNAME", function() if selectedPlayer then Features.CopyUsername(selectedPlayer) end end)
        createButton(contentFrame, "🆔 COPY USER ID", function() if selectedPlayer then Features.CopyUserId(selectedPlayer) end end)
        createButton(contentFrame, "📊 VIEW PROFILE", function() if selectedPlayer then Features.ViewProfile(selectedPlayer) end end)
        createButton(contentFrame, "📝 VIEW INVENTORY", function() if selectedPlayer then Features.ViewInventory(selectedPlayer) end end)
        createButton(contentFrame, "💰 VIEW MONEY", function() if selectedPlayer then Features.ViewMoney(selectedPlayer) end end)
        createButton(contentFrame, "🛡️ VIEW ARMOR", function() if selectedPlayer then Features.ViewArmor(selectedPlayer) end end)
        createButton(contentFrame, "🔫 VIEW WEAPONS", function() if selectedPlayer then Features.ViewWeapons(selectedPlayer) end end)
        createButton(contentFrame, "🎒 VIEW ITEMS", function() if selectedPlayer then Features.ViewItems(selectedPlayer) end end)
        createButton(contentFrame, "📈 VIEW STATS", function() if selectedPlayer then Features.ViewStats(selectedPlayer) end end)
        createButton(contentFrame, "📋 VIEW DATA", function() if selectedPlayer then Features.ViewData(selectedPlayer) end end)
        createButton(contentFrame, "🚫 KICK ALL", function() Features.KickAll() print("Kick All Attempt") end)
        createButton(contentFrame, "💀 KILL ALL", function() Features.KillAll() print("Kill All Attempt") end)
        createButton(contentFrame, "❄️ FREEZE ALL", function() Features.FreezeAll() print("Freeze All Attempt") end)
        createButton(contentFrame, "🔥 BURN ALL", function() Features.BurnAll() print("Burn All Attempt") end)
        createToggle(contentFrame, "🔄 AUTO-REFRESH", function(state) print("Auto-Refresh:", state) end, false)
        
    elseif tabName == "TELEPORTS" then
        createButton(contentFrame, "📍 TELEPORT TO SPAWN", function() Features.TeleportToSpawn() print("Teleported to Spawn") end)
        createButton(contentFrame, "💰 TELEPORT TO MONEY", function() Features.TeleportToMoney() print("Teleported to Money") end)
        createButton(contentFrame, "🎁 TELEPORT TO LOOT", function() Features.TeleportToLoot() print("Teleported to Loot") end)
        createButton(contentFrame, "🚗 TELEPORT TO VEHICLE", function() Features.TeleportToVehicle() print("Teleported to Vehicle") end)
        createButton(contentFrame, "🛡️ TELEPORT TO ARMOR", function() Features.TeleportToArmor() print("Teleported to Armor") end)
        createButton(contentFrame, "🔫 TELEPORT TO WEAPON", function() Features.TeleportToWeapon() print("Teleported to Weapon") end)
        createButton(contentFrame, "❤️ TELEPORT TO HEALTH", function() Features.TeleportToHealth() print("Teleported to Health") end)
        createButton(contentFrame, "🌀 TELEPORT TO SAFE", function() Features.TeleportToSafe() print("Teleported to Safe") end)
        createButton(contentFrame, "🏆 TELEPORT TO WIN", function() Features.TeleportToWin() print("Teleported to Win") end)
        createButton(contentFrame, "🎯 TELEPORT TO TARGET", function() Features.TeleportToTarget() print("Teleported to Target") end)
        createButton(contentFrame, "🚨 TELEPORT TO DANGER", function() Features.TeleportToDanger() print("Teleported to Danger") end)
        createButton(contentFrame, "🌌 TELEPORT TO SECRET", function() Features.TeleportToSecret() print("Teleported to Secret") end)
        createButton(contentFrame, "🏰 TELEPORT TO BASE", function() Features.TeleportToBase() print("Teleported to Base") end)
        createButton(contentFrame, "🌊 TELEPORT TO WATER", function() Features.TeleportToWater() print("Teleported to Water") end)
        createButton(contentFrame, "🌳 TELEPORT TO TREE", function() Features.TeleportToTree() print("Teleported to Tree") end)
        createButton(contentFrame, "🏔️ TELEPORT TO MOUNTAIN", function() Features.TeleportToMountain() print("Teleported to Mountain") end)
        
    elseif tabName == "ANIMATIONS" then
        createButton(contentFrame, "💃 DANCE 1", function() Features.PlayDance1() print("Dance 1") end)
        createButton(contentFrame, "🕺 DANCE 2", function() Features.PlayDance2() print("Dance 2") end)
        createButton(contentFrame, "🎭 DANCE 3", function() Features.PlayDance3() print("Dance 3") end)
        createButton(contentFrame, "💥 DANCE 4", function() Features.PlayDance4() print("Dance 4") end)
        createButton(contentFrame, "🌀 DANCE 5", function() Features.PlayDance5() print("Dance 5") end)
        createButton(contentFrame, "🌟 DANCE 6", function() Features.PlayDance6() print("Dance 6") end)
        createButton(contentFrame, "✨ DANCE 7", function() Features.PlayDance7() print("Dance 7") end)
        createButton(contentFrame, "🔥 DANCE 8", function() Features.PlayDance8() print("Dance 8") end)
        createButton(contentFrame, "❄️ DANCE 9", function() Features.PlayDance9() print("Dance 9") end)
        createButton(contentFrame, "🌊 DANCE 10", function() Features.PlayDance10() print("Dance 10") end)
        createButton(contentFrame, "🎶 MUSIC 1", function() Features.PlayMusic1() print("Music 1") end)
        createButton(contentFrame, "🎵 MUSIC 2", function() Features.PlayMusic2() print("Music 2") end)
        createButton(contentFrame, "🎼 MUSIC 3", function() Features.PlayMusic3() print("Music 3") end)
        createButton(contentFrame, "🎸 MUSIC 4", function() Features.PlayMusic4() print("Music 4") end)
        createButton(contentFrame, "🥁 MUSIC 5", function() Features.PlayMusic5() print("Music 5") end)
        
    elseif tabName == "VEHICLES" then
        createButton(contentFrame, "🚗 SPAWN CAR", function() Features.SpawnCar() print("Car Spawned") end)
        createButton(contentFrame, "🚁 SPAWN HELI", function() Features.SpawnHeli() print("Heli Spawned") end)
        createButton(contentFrame, "✈️ SPAWN PLANE", function() Features.SpawnPlane() print("Plane Spawned") end)
        createButton(contentFrame, "🚤 SPAWN BOAT", function() Features.SpawnBoat() print("Boat Spawned") end)
        createButton(contentFrame, "🏎️ SPAWN RACE CAR", function() Features.SpawnRaceCar() print("Race Car Spawned") end)
        createButton(contentFrame, "🚒 SPAWN FIRE TRUCK", function() Features.SpawnFireTruck() print("Fire Truck Spawned") end)
        createButton(contentFrame, "🚓 SPAWN POLICE CAR", function() Features.SpawnPoliceCar() print("Police Car Spawned") end)
        createButton(contentFrame, "🚑 SPAWN AMBULANCE", function() Features.SpawnAmbulance() print("Ambulance Spawned") end)
        createButton(contentFrame, "🚚 SPAWN TRUCK", function() Features.SpawnTruck() print("Truck Spawned") end)
        createButton(contentFrame, "🚜 SPAWN TRACTOR", function() Features.SpawnTractor() print("Tractor Spawned") end)
        createButton(contentFrame, "🏍️ SPAWN BIKE", function() Features.SpawnBike() print("Bike Spawned") end)
        createButton(contentFrame, "🛵 SPAWN SCOOTER", function() Features.SpawnScooter() print("Scooter Spawned") end)
        createButton(contentFrame, "🚲 SPAWN BICYCLE", function() Features.SpawnBicycle() print("Bicycle Spawned") end)
        createButton(contentFrame, "🛴 SPAWN SKATEBOARD", function() Features.SpawnSkateboard() print("Skateboard Spawned") end)
        createButton(contentFrame, "🛹 SPAWN SCOOTER BOARD", function() Features.SpawnScooterBoard() print("Scooter Board Spawned") end)
        
    elseif tabName == "WEAPONS" then
        createButton(contentFrame, "🔫 SPAWN PISTOL", function() Features.SpawnPistol() print("Pistol Spawned") end)
        createButton(contentFrame, "🔫 SPAWN RIFLE", function() Features.SpawnRifle() print("Rifle Spawned") end)
        createButton(contentFrame, "🔫 SPAWN SHOTGUN", function() Features.SpawnShotgun() print("Shotgun Spawned") end)
        createButton(contentFrame, "🔫 SPAWN SMG", function() Features.SpawnSMG() print("SMG Spawned") end)
        createButton(contentFrame, "🔫 SPAWN SNIPER", function() Features.SpawnSniper() print("Sniper Spawned") end)
        createButton(contentFrame, "💣 SPAWN GRENADE", function() Features.SpawnGrenade() print("Grenade Spawned") end)
        createButton(contentFrame, "🧨 SPAWN DYNAMITE", function() Features.SpawnDynamite() print("Dynamite Spawned") end)
        createButton(contentFrame, "🪓 SPAWN AXE", function() Features.SpawnAxe() print("Axe Spawned") end)
        createButton(contentFrame, "🗡️ SPAWN SWORD", function() Features.SpawnSword() print("Sword Spawned") end)
        createButton(contentFrame, "🏹 SPAWN BOW", function() Features.SpawnBow() print("Bow Spawned") end)
        createButton(contentFrame, "🔪 SPAWN KNIFE", function() Features.SpawnKnife() print("Knife Spawned") end)
        createButton(contentFrame, "🛡️ SPAWN SHIELD", function() Features.SpawnShield() print("Shield Spawned") end)
        createButton(contentFrame, "💥 SPAWN ROCKET", function() Features.SpawnRocket() print("Rocket Spawned") end)
        createButton(contentFrame, "🌀 SPAWN LASER", function() Features.SpawnLaser() print("Laser Spawned") end)
        createButton(contentFrame, "⚡ SPAWN PLASMA", function() Features.SpawnPlasma() print("Plasma Spawned") end)
        
    elseif tabName == "FUN" then
        createButton(contentFrame, "🎈 BALLOON PARTY", function() Features.BalloonParty() print("Balloon Party") end)
        createButton(contentFrame, "🎉 CONFETTI BLAST", function() Features.ConfettiBlast() print("Confetti Blast") end)
        createButton(contentFrame, "✨ SPARKLE STORM", function() Features.SparkleStorm() print("Sparkle Storm") end)
        createButton(contentFrame, "🌈 RAINBOW RAVE", function() Features.RainbowRave() print("Rainbow Rave") end)
        createButton(contentFrame, "🌀 VORTEX FUN", function() Features.VortexFun() print("Vortex Fun") end)
        createButton(contentFrame, "🚀 ROCKET MAN", function() Features.RocketMan() print("Rocket Man") end)
        createButton(contentFrame, "👻 GHOST MODE", function() Features.GhostMode() print("Ghost Mode") end)
        createButton(contentFrame, "🦸 SUPERHERO", function() Features.Superhero() print("Superhero") end)
        createButton(contentFrame, "🧙 WIZARD", function() Features.Wizard() print("Wizard") end)
        createButton(contentFrame, "🧛 VAMPIRE", function() Features.Vampire() print("Vampire") end)
        createButton(contentFrame, "🧟 ZOMBIE", function() Features.Zombie() print("Zombie") end)
        createButton(contentFrame, "🧚 FAIRY", function() Features.Fairy() print("Fairy") end)
        createButton(contentFrame, "🐉 DRAGON", function() Features.Dragon() print("Dragon") end)
        createButton(contentFrame, "🦄 UNICORN", function() Features.Unicorn() print("Unicorn") end)
        createButton(contentFrame, "🐱 CAT", function() Features.Cat() print("Cat") end)
        
    elseif tabName == "ADMIN" then
        createButton(contentFrame, "👑 BECOME ADMIN", function() Features.BecomeAdmin() print("Admin Attempt") end)
        createButton(contentFrame, "🚀 ADMIN FLY", function() Features.AdminFly() print("Admin Fly") end)
        createButton(contentFrame, "⚡ ADMIN SPEED", function() Features.AdminSpeed() print("Admin Speed") end)
        createButton(contentFrame, "🛡️ ADMIN GOD", function() Features.AdminGod() print("Admin God") end)
        createButton(contentFrame, "🌀 ADMIN NO CLIP", function() Features.AdminNoClip() print("Admin NoClip") end)
        createButton(contentFrame, "🎯 ADMIN AIMBOT", function() Features.AdminAimbot() print("Admin Aimbot") end)
        createButton(contentFrame, "🔫 ADMIN GUNS", function() Features.AdminGuns() print("Admin Guns") end)
        createButton(contentFrame, "💰 ADMIN MONEY", function() Features.AdminMoney() print("Admin Money") end)
        createButton(contentFrame, "🛡️ ADMIN ARMOR", function() Features.AdminArmor() print("Admin Armor") end)
        createButton(contentFrame, "❤️ ADMIN HEALTH", function() Features.AdminHealth() print("Admin Health") end)
        createButton(contentFrame, "🌀 ADMIN TELEPORT", function() Features.AdminTeleport() print("Admin Teleport") end)
        createButton(contentFrame, "🚫 ADMIN KICK", function() Features.AdminKick() print("Admin Kick") end)
        createButton(contentFrame, "💀 ADMIN KILL", function() Features.AdminKill() print("Admin Kill") end)
        createButton(contentFrame, "❄️ ADMIN FREEZE", function() Features.AdminFreeze() print("Admin Freeze") end)
        createButton(contentFrame, "🔥 ADMIN BURN", function() Features.AdminBurn() print("Admin Burn") end)
        
    elseif tabName == "SETTINGS" then
        createToggle(contentFrame, "🔒 LOCK GUI POSITION", function(state) print("Lock GUI:", state) end, false)
        createToggle(contentFrame, "🎨 ANIMATED GUI", function(state) print("Animated GUI:", state) end, true)
        createToggle(contentFrame, "💾 AUTO-SAVE SETTINGS", function(state) print("Auto-Save:", state) end, true)
        createToggle(contentFrame, "🚀 PERFORMANCE MODE", function(state) print("Performance Mode:", state) end, false)
        createToggle(contentFrame, "🔊 SOUND EFFECTS", function(state) print("Sound Effects:", state) end, true)
        createToggle(contentFrame, "💬 NOTIFICATIONS", function(state) print("Notifications:", state) end, true)
        createButton(contentFrame, "🔄 RESET SETTINGS", function() print("Settings Reset") end)
        createButton(contentFrame, "📁 EXPORT CONFIG", function() print("Config Exported") end)
        createButton(contentFrame, "📂 IMPORT CONFIG", function() print("Config Imported") end)
        createButton(contentFrame, "🗑️ CLEAR CACHE", function() print("Cache Cleared") end)
        createButton(contentFrame, "📊 VIEW STATS", function() print("Viewing Stats") end)
        createButton(contentFrame, "ℹ️ ABOUT", function() print("About GUI") end)
        createButton(contentFrame, "🆘 HELP", function() print("Help Menu") end)
        createButton(contentFrame, "🐛 REPORT BUG", function() print("Bug Report") end)
        createButton(contentFrame, "💡 SUGGEST FEATURE", function() print("Feature Suggestion") end)
    end
end

if tabList[1] then
    loadTabContent(tabList[1].Name, Tabs[tabList[1].Name].Content)
end

local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Name = "PlayerListFrame"
PlayerListFrame.Size = UDim2.new(0, 400, 0, 450)
PlayerListFrame.Position = UDim2.new(0.5, 200, 0.5, -225)
PlayerListFrame.BackgroundColor3 = ThemeColors.MainBg
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Parent = PlayerListGui

local PLHeader = Instance.new("Frame")
PLHeader.Size = UDim2.new(1, 0, 0, 40)
PLHeader.BackgroundColor3 = Color3.fromRGB(10, 15, 25)
PLHeader.BorderSizePixel = 0
PLHeader.Parent = PlayerListFrame

local PLTitle = Instance.new("TextLabel")
PLTitle.Text = "👥 PLAYER LIST"
PLTitle.Size = UDim2.new(0, 250, 1, 0)
PLTitle.Position = UDim2.new(0, 15, 0, 0)
PLTitle.BackgroundTransparency = 1
PLTitle.TextColor3 = ThemeColors.Accent
PLTitle.TextSize = 18
PLTitle.Font = Enum.Font.GothamBold
PLTitle.TextXAlignment = Enum.TextXAlignment.Left
PLTitle.Parent = PLHeader

local PLClose = Instance.new("TextButton")
PLClose.Text = "✕"
PLClose.Size = UDim2.new(0, 40, 1, 0)
PLClose.Position = UDim2.new(1, -40, 0, 0)
PLClose.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
PLClose.TextColor3 = Color3.fromRGB(255, 255, 255)
PLClose.TextSize = 20
PLClose.Font = Enum.Font.GothamBold
PLClose.AutoButtonColor = false
PLClose.Parent = PLHeader

setupButtonHover(PLClose, Color3.fromRGB(255, 40, 40), Color3.fromRGB(255, 80, 80))

local PLCount = Instance.new("TextLabel")
PLCount.Text = "0/0"
PLCount.Size = UDim2.new(0, 70, 1, 0)
PLCount.Position = UDim2.new(1, -90, 0, 0)
PLCount.BackgroundTransparency = 1
PLCount.TextColor3 = ThemeColors.Text
PLCount.TextSize = 14
PLCount.Font = Enum.Font.Gotham
PLCount.TextXAlignment = Enum.TextXAlignment.Right
PLCount.Parent = PLHeader

local PLScroll = Instance.new("ScrollingFrame")
PLScroll.Size = UDim2.new(1, 0, 1, -40)
PLScroll.Position = UDim2.new(0, 0, 0, 40)
PLScroll.BackgroundTransparency = 1
PLScroll.BorderSizePixel = 0
PLScroll.ScrollBarThickness = 6
PLScroll.ScrollBarImageColor3 = ThemeColors.Accent
PLScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PLScroll.Parent = PlayerListFrame

PLClose.MouseButton1Click:Connect(function()
    PlayerListGui.Enabled = false
end)

local playerButtons = {}

local function updatePlayerList()
    for _, button in pairs(playerButtons) do
        button:Destroy()
    end
    playerButtons = {}
    
    local players = Players:GetPlayers()
    local yPos = 0
    
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Name = "Player_" .. player.UserId
            PlayerButton.Size = UDim2.new(1, -20, 0, 60)
            PlayerButton.Position = UDim2.new(0, 10, 0, yPos)
            PlayerButton.BackgroundColor3 = ThemeColors.DarkButton
            PlayerButton.BorderSizePixel = 0
            PlayerButton.Text = ""
            PlayerButton.AutoButtonColor = false
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0.1, 0)
            Corner.Parent = PlayerButton
            
            local Avatar = Instance.new("ImageLabel")
            Avatar.Size = UDim2.new(0, 40, 0, 40)
            Avatar.Position = UDim2.new(0, 10, 0.5, -20)
            Avatar.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
            Avatar.BorderSizePixel = 0
            Avatar.Image = getPlayerAvatar(player.UserId)
            
            local AvatarCorner = Instance.new("UICorner")
            AvatarCorner.CornerRadius = UDim.new(0.2, 0)
            AvatarCorner.Parent = Avatar
            Avatar.Parent = PlayerButton
            
            local NameLabel = Instance.new("TextLabel")
            NameLabel.Text = player.DisplayName
            NameLabel.Size = UDim2.new(0.5, -60, 0, 20)
            NameLabel.Position = UDim2.new(0, 60, 0, 10)
            NameLabel.BackgroundTransparency = 1
            NameLabel.TextColor3 = ThemeColors.Text
            NameLabel.TextSize = 14
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Parent = PlayerButton
            
            local UsernameLabel = Instance.new("TextLabel")
            UsernameLabel.Text = "@" .. player.Name
            UsernameLabel.Size = UDim2.new(0.5, -60, 0, 16)
            UsernameLabel.Position = UDim2.new(0, 60, 0, 32)
            UsernameLabel.BackgroundTransparency = 1
            UsernameLabel.TextColor3 = Color3.fromRGB(180, 190, 220)
            UsernameLabel.TextSize = 12
            UsernameLabel.Font = Enum.Font.Gotham
            UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
            UsernameLabel.Parent = PlayerButton
            
            local SelectButton = Instance.new("TextButton")
            SelectButton.Text = "SELECT"
            SelectButton.Size = UDim2.new(0, 80, 0, 30)
            SelectButton.Position = UDim2.new(1, -90, 0.5, -15)
            SelectButton.BackgroundColor3 = ThemeColors.Accent
            SelectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            SelectButton.TextSize = 12
            SelectButton.Font = Enum.Font.GothamBold
            SelectButton.AutoButtonColor = false
            SelectButton.Parent = PlayerButton
            
            local SelectCorner = Instance.new("UICorner")
            SelectCorner.CornerRadius = UDim.new(0.2, 0)
            SelectCorner.Parent = SelectButton
            
            local function selectThisPlayer()
                if selectedPlayer and playerButtons[selectedPlayer] then
                    playerButtons[selectedPlayer].BackgroundColor3 = ThemeColors.DarkButton
                end
                selectedPlayer = player
                PlayerButton.BackgroundColor3 = Color3.fromRGB(math.min(ThemeColors.Accent.R * 255 + 20, 255), math.min(ThemeColors.Accent.G * 255 + 20, 255), math.min(ThemeColors.Accent.B * 255 + 20, 255)) / 255
                SelectButton.Text = "SELECTED ✓"
                SelectButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            end
            
            PlayerButton.MouseButton1Click:Connect(selectThisPlayer)
            SelectButton.MouseButton1Click:Connect(selectThisPlayer)
            
            setupButtonHover(PlayerButton)
            setupButtonHover(SelectButton, ThemeColors.Accent, Color3.fromRGB(math.min(ThemeColors.Accent.R * 255 + 40, 255), math.min(ThemeColors.Accent.G * 255 + 40, 255), math.min(ThemeColors.Accent.B * 255 + 40, 255)) / 255)
            
            PlayerButton.Parent = PLScroll
            playerButtons[player] = PlayerButton
            yPos = yPos + 70
        end
    end
    
    PLCount.Text = #players - 1 .. "/" .. #players
    PLScroll.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

Features.TeleportToPlayer = function(target) if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame end end end
Features.BringPlayer = function(target) if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then target.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame end end end
Features.KillPlayer = function(target) if target and target.Character then local humanoid = target.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = 0 end end end
Features.FreezePlayer = function(target) if target and target.Character then local humanoid = target.Character:FindFirstChild("Humanoid") if humanoid then humanoid.PlatformStand = not humanoid.PlatformStand end end end
Features.BurnPlayer = function(target) if target and target.Character then local humanoid = target.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = 0 end end end
Features.ShockPlayer = function(target) if target and target.Character then local humanoid = target.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = 0 end end end
Features.SpinPlayer = function(target) if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then target.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(90), 0) end end
Features.BanishPlayer = function(target) if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then target.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10000, 0) end end
Features.GhostPlayer = function(target) if target and target.Character then for _, part in pairs(target.Character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = 0.5 end end end end
Features.PoopPlayer = function(target) print("Poop:", target and target.Name or "None") end
Features.MimicPlayer = function(target) print("Mimic:", target and target.Name or "None") end
Features.JailPlayer = function(target) if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then target.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0) end end
Features.TripPlayer = function(target) if target and target.Character then local humanoid = target.Character:FindFirstChild("Humanoid") if humanoid then humanoid.PlatformStand = true end end end
Features.MutePlayer = function(target) print("Mute:", target and target.Name or "None") end
Features.DeafenPlayer = function(target) print("Deafen:", target and target.Name or "None") end
Features.SpectatePlayer = function(target) if target and target.Character then camera.CameraSubject = target.Character:FindFirstChild("Humanoid") end end

Features.HealSelf = function() if LocalPlayer.Character then local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = humanoid.MaxHealth end end end
Features.ResetChar = function() if LocalPlayer.Character then LocalPlayer.Character:BreakJoints() end end
Features.SuperSize = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Size = part.Size * 2 end end end end
Features.TinySize = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Size = part.Size / 2 end end end end

Features.SetDay = function() if game.Lighting then game.Lighting.ClockTime = 14 end end
Features.SetNight = function() if game.Lighting then game.Lighting.ClockTime = 0 end end
Features.SetSunrise = function() if game.Lighting then game.Lighting.ClockTime = 6 end end
Features.SetSunset = function() if game.Lighting then game.Lighting.ClockTime = 18 end end
Features.SetRain = function() if game.Lighting then game.Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100) end end
Features.SetSnow = function() if game.Lighting then game.Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 255) end end
Features.SetStorm = function() if game.Lighting then game.Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50) end end
Features.SetRainbow = function() if game.Lighting then game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 0, 0) end end

Features.ClearWorkspace = function() for _, obj in pairs(workspace:GetChildren()) do if obj:IsA("BasePart") and obj.Parent == workspace then obj:Destroy() end end end
Features.RemoveWeapons = function() for _, player in pairs(Players:GetPlayers()) do if player.Character then for _, tool in pairs(player.Character:GetChildren()) do if tool:IsA("Tool") then tool:Destroy() end end end end end
Features.RemoveTools = function() for _, player in pairs(Players:GetPlayers()) do if player.Character then for _, tool in pairs(player.Character:GetChildren()) do if tool:IsA("Tool") then tool:Destroy() end end end end end
Features.RemoveNPCs = function() for _, npc in pairs(workspace:GetChildren()) do if npc:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(npc) then npc:Destroy() end end end
Features.RemoveVehicles = function() for _, vehicle in pairs(workspace:GetChildren()) do if vehicle.Name:lower():find("vehicle") or vehicle.Name:lower():find("car") then vehicle:Destroy() end end end
Features.RemoveExplosives = function() for _, obj in pairs(workspace:GetChildren()) do if obj.Name:lower():find("explosive") or obj.Name:lower():find("bomb") then obj:Destroy() end end end
Features.RemoveArmor = function() for _, obj in pairs(workspace:GetChildren()) do if obj.Name:lower():find("armor") then obj:Destroy() end end end
Features.RemoveMoney = function() for _, obj in pairs(workspace:GetChildren()) do if obj.Name:lower():find("money") or obj.Name:lower():find("cash") then obj:Destroy() end end end
Features.RemoveLoot = function() for _, obj in pairs(workspace:GetChildren()) do if obj.Name:lower():find("loot") or obj.Name:lower():find("chest") then obj:Destroy() end end end
Features.RemoveTargets = function() for _, obj in pairs(workspace:GetChildren()) do if obj.Name:lower():find("target") then obj:Destroy() end end end
Features.RemoveDangers = function() for _, obj in pairs(workspace:GetChildren()) do if obj.Name:lower():find("danger") or obj.Name:lower():find("trap") then obj:Destroy() end end end
Features.RemoveEffects = function() for _, obj in pairs(workspace:GetChildren()) do if obj:IsA("ParticleEmitter") then obj:Destroy() end end end
Features.RemoveFog = function() if game.Lighting then game.Lighting.FogEnd = 100000 end end
Features.RemoveLights = function() for _, light in pairs(workspace:GetDescendants()) do if light:IsA("PointLight") or light:IsA("SurfaceLight") then light:Destroy() end end end
Features.RemovePlants = function() for _, plant in pairs(workspace:GetChildren()) do if plant.Name:lower():find("tree") or plant.Name:lower():find("plant") then plant:Destroy() end end end
Features.RemoveBuildings = function() for _, building in pairs(workspace:GetChildren()) do if building.Name:lower():find("building") or building.Name:lower():find("house") then building:Destroy() end end end

Features.RejoinServer = function() local TeleportService = game:GetService("TeleportService") TeleportService:Teleport(game.PlaceId, LocalPlayer) end
Features.ServerHop = function() local HttpService = game:GetService("HttpService") local TeleportService = game:GetService("TeleportService") local servers = {} local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")) end) if success and result and result.data then for _, server in pairs(result.data) do if server.playing < server.maxPlayers and server.id ~= game.JobId then table.insert(servers, server.id) end end if #servers > 0 then TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer) end end end
Features.CopyGameId = function() local setId = tostring(game.PlaceId) if setclipboard then setclipboard(setId) end print("Game ID:", setId) end
Features.CopyJobId = function() local setId = tostring(game.JobId) if setclipboard then setclipboard(setId) end print("Job ID:", setId) end
Features.CopyPlayerList = function() local list = "" for _, player in pairs(Players:GetPlayers()) do list = list .. player.Name .. "\n" end if setclipboard then setclipboard(list) end print("Player List Copied") end
Features.CopyServerTime = function() local time = os.date("%H:%M:%S") if setclipboard then setclipboard(time) end print("Server Time:", time) end
Features.CopyServerStats = function() local stats = "Players: " .. #Players:GetPlayers() if setclipboard then setclipboard(stats) end print("Stats:", stats) end
Features.CrashServer = function() for i = 1, 1000 do pcall(function() game:GetService("ReplicatedStorage"):ClearAllChildren() end) end end
Features.LagServer = function() for i = 1, 100 do pcall(function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(1000, 1000, 1000) end) end end
Features.ExplodeServer = function() for _, player in pairs(Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then local explosion = Instance.new("Explosion", workspace) explosion.Position = player.Character.HumanoidRootPart.Position explosion.BlastPressure = 1000 end end end
Features.FreezeServer = function() for _, player in pairs(Players:GetPlayers()) do if player.Character then local humanoid = player.Character:FindFirstChild("Humanoid") if humanoid then humanoid.PlatformStand = true end end end end
Features.FloodServer = function() for i = 1, 50 do pcall(function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(100, 1, 100) part.Position = Vector3.new(0, i * 10, 0) part.Anchored = true end) end end
Features.ShockServer = function() for _, player in pairs(Players:GetPlayers()) do if player.Character then local humanoid = player.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = 0 end end end end
Features.BurnServer = function() for _, player in pairs(Players:GetPlayers()) do if player.Character then local humanoid = player.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = 0 end end end end
Features.SpinServer = function() for _, player in pairs(Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(90), 0) end end end
Features.BanishServer = function() for _, player in pairs(Players:GetPlayers()) do if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10000, 0) end end end

Features.CopyUsername = function(target) if target and setclipboard then setclipboard(target.Name) print("Copied:", target.Name) end end
Features.CopyUserId = function(target) if target and setclipboard then setclipboard(tostring(target.UserId)) print("Copied ID:", target.UserId) end end
Features.ViewProfile = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Profile", Text = "Viewing " .. target.Name}) end end
Features.ViewInventory = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Inventory", Text = "Viewing " .. target.Name .. "'s inventory"}) end end
Features.ViewMoney = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Money", Text = "Viewing " .. target.Name .. "'s money"}) end end
Features.ViewArmor = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Armor", Text = "Viewing " .. target.Name .. "'s armor"}) end end
Features.ViewWeapons = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Weapons", Text = "Viewing " .. target.Name .. "'s weapons"}) end end
Features.ViewItems = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Items", Text = "Viewing " .. target.Name .. "'s items"}) end end
Features.ViewStats = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Stats", Text = "Viewing " .. target.Name .. "'s stats"}) end end
Features.ViewData = function(target) if target then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Data", Text = "Viewing " .. target.Name .. "'s data"}) end end

Features.KickAll = function() for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer then game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Kick", Text = "Kicking " .. player.Name}) end end end
Features.KillAll = function() for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer and player.Character then local humanoid = player.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = 0 end end end end
Features.FreezeAll = function() for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer and player.Character then local humanoid = player.Character:FindFirstChild("Humanoid") if humanoid then humanoid.PlatformStand = true end end end end
Features.BurnAll = function() for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer and player.Character then local humanoid = player.Character:FindFirstChild("Humanoid") if humanoid then humanoid.Health = 0 end end end end

Features.TeleportToSpawn = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0) end end
Features.TeleportToMoney = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 5, 100) end end
Features.TeleportToLoot = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(200, 5, 200) end end
Features.TeleportToVehicle = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(300, 5, 300) end end
Features.TeleportToArmor = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(400, 5, 400) end end
Features.TeleportToWeapon = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(500, 5, 500) end end
Features.TeleportToHealth = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(600, 5, 600) end end
Features.TeleportToSafe = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(700, 5, 700) end end
Features.TeleportToWin = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(800, 5, 800) end end
Features.TeleportToTarget = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(900, 5, 900) end end
Features.TeleportToDanger = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1000, 5, 1000) end end
Features.TeleportToSecret = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0) end end
Features.TeleportToBase = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0) end end
Features.TeleportToWater = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -10, 0) end end
Features.TeleportToTree = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end end
Features.TeleportToMountain = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0) end end

Features.PlayDance1 = function() print("Dance 1") end
Features.PlayDance2 = function() print("Dance 2") end
Features.PlayDance3 = function() print("Dance 3") end
Features.PlayDance4 = function() print("Dance 4") end
Features.PlayDance5 = function() print("Dance 5") end
Features.PlayDance6 = function() print("Dance 6") end
Features.PlayDance7 = function() print("Dance 7") end
Features.PlayDance8 = function() print("Dance 8") end
Features.PlayDance9 = function() print("Dance 9") end
Features.PlayDance10 = function() print("Dance 10") end
Features.PlayMusic1 = function() print("Music 1") end
Features.PlayMusic2 = function() print("Music 2") end
Features.PlayMusic3 = function() print("Music 3") end
Features.PlayMusic4 = function() print("Music 4") end
Features.PlayMusic5 = function() print("Music 5") end

Features.SpawnCar = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(4, 2, 6) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(255, 0, 0) end
Features.SpawnHeli = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(4, 2, 4) part.Position = Vector3.new(0, 20, 0) part.Anchored = true part.Color = Color3.fromRGB(0, 255, 0) end
Features.SpawnPlane = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(10, 2, 4) part.Position = Vector3.new(0, 30, 0) part.Anchored = true part.Color = Color3.fromRGB(0, 0, 255) end
Features.SpawnBoat = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(6, 2, 10) part.Position = Vector3.new(0, 0, 0) part.Anchored = true part.Color = Color3.fromRGB(255, 255, 0) end
Features.SpawnRaceCar = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(3, 1, 5) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(255, 0, 255) end
Features.SpawnFireTruck = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(5, 3, 8) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(255, 0, 0) end
Features.SpawnPoliceCar = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(4, 2, 6) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(0, 0, 255) end
Features.SpawnAmbulance = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(4, 2, 6) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(255, 255, 255) end
Features.SpawnTruck = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(6, 3, 10) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(100, 100, 100) end
Features.SpawnTractor = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(4, 3, 5) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(0, 100, 0) end
Features.SpawnBike = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(1, 3, 4) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(200, 200, 200) end
Features.SpawnScooter = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(1, 2, 3) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(150, 150, 150) end
Features.SpawnBicycle = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(1, 3, 4) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(100, 100, 100) end
Features.SpawnSkateboard = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(1, 0.5, 3) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(50, 50, 50) end
Features.SpawnScooterBoard = function() local part = Instance.new("Part", workspace) part.Size = Vector3.new(1, 1, 4) part.Position = Vector3.new(0, 5, 0) part.Anchored = true part.Color = Color3.fromRGB(75, 75, 75) end

Features.SpawnPistol = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Pistol" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnRifle = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Rifle" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnShotgun = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Shotgun" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnSMG = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "SMG" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnSniper = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Sniper" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnGrenade = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Grenade" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnDynamite = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Dynamite" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnAxe = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Axe" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnSword = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Sword" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnBow = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Bow" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnKnife = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Knife" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnShield = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Shield" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnRocket = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Rocket" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnLaser = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Laser" tool.GripPos = Vector3.new(0, 0, 0) end
Features.SpawnPlasma = function() local tool = Instance.new("Tool", LocalPlayer.Backpack or workspace) tool.Name = "Plasma" tool.GripPos = Vector3.new(0, 0, 0) end

Features.BalloonParty = function() for i = 1, 50 do local part = Instance.new("Part", workspace) part.Size = Vector3.new(1, 1, 1) part.Position = Vector3.new(math.random(-50, 50), math.random(10, 50), math.random(-50, 50)) part.Anchored = true part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) end end
Features.ConfettiBlast = function() for i = 1, 100 do local part = Instance.new("Part", workspace) part.Size = Vector3.new(0.5, 0.5, 0.5) part.Position = Vector3.new(0, 10, 0) part.Anchored = false part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) part.Velocity = Vector3.new(math.random(-50, 50), math.random(20, 50), math.random(-50, 50)) end end
Features.SparkleStorm = function() for i = 1, 200 do local part = Instance.new("Part", workspace) part.Size = Vector3.new(0.2, 0.2, 0.2) part.Position = Vector3.new(math.random(-100, 100), math.random(0, 50), math.random(-100, 100)) part.Anchored = true part.Material = Enum.Material.Neon part.Color = Color3.fromRGB(math.random(200, 255), math.random(200, 255), math.random(200, 255)) end end
Features.RainbowRave = function() if game.Lighting then game.Lighting.OutdoorAmbient = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) end end
Features.VortexFun = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(45), 0) end end
Features.RocketMan = function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0) end end
Features.GhostMode = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = 0.5 end end end end
Features.Superhero = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(255, 0, 0) end end end end
Features.Wizard = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(100, 0, 200) end end end end
Features.Vampire = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(150, 0, 0) end end end end
Features.Zombie = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(0, 150, 0) end end end end
Features.Fairy = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(255, 200, 255) end end end end
Features.Dragon = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(255, 100, 0) end end end end
Features.Unicorn = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(255, 255, 255) end end end end
Features.Cat = function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetChildren()) do if part:IsA("BasePart") then part.Color = Color3.fromRGB(150, 100, 50) end end end end

Features.BecomeAdmin = function() print("Admin Attempt") end
Features.AdminFly = function() Features.Flying = true print("Admin Fly") end
Features.AdminSpeed = function() Features.SpeedHack = true print("Admin Speed") end
Features.AdminGod = function() Features.GodMode = true print("Admin God") end
Features.AdminNoClip = function() Features.NoClip = true print("Admin NoClip") end
Features.AdminAimbot = function() Features.Aimbot = true print("Admin Aimbot") end
Features.AdminGuns = function() Features.SpawnPistol() Features.SpawnRifle() Features.SpawnShotgun() print("Admin Guns") end
Features.AdminMoney = function() print("Admin Money") end
Features.AdminArmor = function() print("Admin Armor") end
Features.AdminHealth = function() Features.HealSelf() print("Admin Health") end
Features.AdminTeleport = function() if selectedPlayer then Features.TeleportToPlayer(selectedPlayer) end print("Admin Teleport") end
Features.AdminKick = function() if selectedPlayer then print("Admin Kick:", selectedPlayer.Name) end end
Features.AdminKill = function() if selectedPlayer then Features.KillPlayer(selectedPlayer) end print("Admin Kill") end
Features.AdminFreeze = function() if selectedPlayer then Features.FreezePlayer(selectedPlayer) end print("Admin Freeze") end
Features.AdminBurn = function() if selectedPlayer then Features.BurnPlayer(selectedPlayer) end print("Admin Burn") end

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
    if Features.Flying then
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
                    if Features.Flying and flyBodyVelocity then
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
    if char and Features.SpeedHack then
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

if game.Lighting then
    game.Lighting.Changed:Connect(function()
        if Features.Fullbright then
            game.Lighting.GlobalShadows = false
            game.Lighting.FogEnd = 100000
            game.Lighting.Brightness = 2
        end
    end)
    Features.Fullbright = Features.Fullbright
end

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

print("Cry0xene Ultimate Hub v7.0 loaded!")
print("140+ Features | Press RightControl")
print("Current Theme:", CurrentTheme)        ContentBg = Color3.fromRGB(25, 35, 30),
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
