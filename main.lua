--// 99 Nights in the Forest Script with Rayfield GUI //--
-- Title: I Love Anne ❤️
-- Theme: Pink with animated watermark

-- Multiple loading methods for Rayfield to ensure it loads
local Rayfield
local success, err = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    -- Try backup method 1
    success, err = pcall(function()
        Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    end)
end

if not success then
    -- Try backup method 2
    success, err = pcall(function()
        Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/sirius0/rayfield/main/source'))()
    end)
end

if not success then
    -- Final backup method
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rayfield-RBLX/Rayfield-Interface/main/Rayfield.lua'))()
end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Pink Theme Colors
local PinkTheme = {
    Primary = Color3.fromRGB(255, 105, 180), -- Hot Pink
    Secondary = Color3.fromRGB(255, 182, 193), -- Light Pink
    Background = Color3.fromRGB(30, 25, 35), -- Dark purple-pink background
    Text = Color3.fromRGB(255, 255, 255)
}

-- Window Setup with Pink I Love Anne Theme
local Window = Rayfield:CreateWindow({
    Name = "I ❤️ Anne - 99 Nights",
    LoadingTitle = "I Love Anne Script",
    LoadingSubtitle = "Loading with love... 💕",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "I_Love_Anne_Settings",
        FileName = "ILoveAnne99Nights"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
    Theme = PinkTheme,
})

-- Create Animated Watermark GUI (Separate from main UI)
local WatermarkScreenGui = Instance.new("ScreenGui")
WatermarkScreenGui.Name = "I❤️AnneWatermark"
WatermarkScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
WatermarkScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
WatermarkScreenGui.ResetOnSpawn = false

-- Animated Watermark Frame
local WatermarkFrame = Instance.new("Frame")
WatermarkFrame.Name = "Watermark"
WatermarkFrame.Size = UDim2.new(0, 320, 0, 80)
WatermarkFrame.Position = UDim2.new(0.5, -160, 0.02, 0)
WatermarkFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
WatermarkFrame.BackgroundTransparency = 0.3
WatermarkFrame.BorderSizePixel = 0
WatermarkFrame.Parent = WatermarkScreenGui

-- Gradient effect
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, PinkTheme.Primary),
    ColorSequenceKeypoint.new(0.5, PinkTheme.Secondary),
    ColorSequenceKeypoint.new(1, PinkTheme.Primary)
})
Gradient.Rotation = 45
Gradient.Parent = WatermarkFrame

-- Corner rounding
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = WatermarkFrame

-- Stroke effect
local Stroke = Instance.new("UIStroke")
Stroke.Color = PinkTheme.Secondary
Stroke.Thickness = 2
Stroke.Transparency = 0.5
Stroke.Parent = WatermarkFrame

-- Animated glowing effect
local GlowEffect = Instance.new("Frame")
GlowEffect.Name = "GlowEffect"
GlowEffect.Size = UDim2.new(1, 10, 1, 10)
GlowEffect.Position = UDim2.new(0, -5, 0, -5)
GlowEffect.BackgroundTransparency = 1
GlowEffect.Parent = WatermarkFrame

local GlowStroke = Instance.new("UIStroke")
GlowStroke.Color = PinkTheme.Primary
GlowStroke.Thickness = 3
GlowStroke.Transparency = 0.7
GlowStroke.Parent = GlowEffect

-- Main text label
local WatermarkLabel = Instance.new("TextLabel")
WatermarkLabel.Name = "Text"
WatermarkLabel.Size = UDim2.new(1, 0, 0.6, 0)
WatermarkLabel.Position = UDim2.new(0, 0, 0.1, 0)
WatermarkLabel.BackgroundTransparency = 1
WatermarkLabel.Text = "I ❤️ Anne - 99 Nights"
WatermarkLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WatermarkLabel.TextScaled = true
WatermarkLabel.Font = Enum.Font.GothamBold
WatermarkLabel.TextStrokeTransparency = 0
WatermarkLabel.TextStrokeColor3 = PinkTheme.Primary
WatermarkLabel.Parent = WatermarkFrame

-- Subtitle label
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Name = "Subtitle"
SubtitleLabel.Size = UDim2.new(1, 0, 0.3, 0)
SubtitleLabel.Position = UDim2.new(0, 0, 0.6, 0)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Made By Cry0xene & metavrfr 💕"
SubtitleLabel.TextColor3 = PinkTheme.Secondary
SubtitleLabel.TextScaled = true
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextStrokeTransparency = 0.5
SubtitleLabel.Parent = WatermarkFrame

-- Animation for the watermark
task.spawn(function()
    local glowTransparency = 0.7
    local glowDirection = -0.01
    local gradientOffset = 0
    
    while true do
        -- Pulsing glow effect
        glowTransparency = glowTransparency + glowDirection
        if glowTransparency <= 0.3 then
            glowDirection = 0.01
        elseif glowTransparency >= 0.7 then
            glowDirection = -0.01
        end
        GlowStroke.Transparency = glowTransparency
        
        -- Moving gradient effect
        gradientOffset = (gradientOffset + 0.01) % 1
        Gradient.Offset = Vector2.new(gradientOffset, gradientOffset)
        
        -- Slight size pulse
        local pulse = math.sin(tick() * 2) * 0.5
        WatermarkFrame.Size = UDim2.new(0, 320 + pulse, 0, 80 + pulse)
        WatermarkFrame.Position = UDim2.new(0.5, -160 - pulse/2, 0.02, -pulse/2)
        
        task.wait(0.03)
    end
end)

-- Variables
local teleportTargets = {
"Alpha Wolf", "Alpha Wolf Pelt", "Anvil Base", "Apple", "Bandage", "Bear", "Berry", 
"Bolt", "Broken Fan", "Broken Microwave", "Bunny", "Bunny Foot", "Cake", "Carrot", "Chair Set", "Chest", "Chilli",
"Coal", "Coin Stack", "Crossbow Cultist", "Cultist", "Cultist Gem", "Deer", "Fuel Canister", "Good Sack", "Good Axe", "Iron Body",
"Item Chest", "Item Chest2", "Item Chest3", "Item Chest4", "Item Chest6", "Leather Body", "Log", "Lost Child",
"Lost Child2", "Lost Child3", "Lost Child4", "Medkit", "Meat? Sandwich", "Morsel", "Old Car Engine", "Old Flashlight", "Old Radio", "Oil Barrel",
"Revolver", "Revolver Ammo", "Rifle", "Rifle Ammo", "Riot Shield", "Sapling", "Seed Box", "Sheet Metal", "Spear",
"Steak", "Stronghold Diamond Chest", "Tyre", "Washing Machine", "Wolf", "Wolf Corpse", "Wolf Pelt"
}
local AimbotTargets = {"Alpha Wolf", "Wolf", "Crossbow Cultist", "Cultist", "Bunny", "Bear", "Polar Bear"}
local espEnabled = false
local npcESPEnabled = false
local ignoreDistanceFrom = Vector3.new(0, 0, 0)
local minDistance = 50
local AutoTreeFarmEnabled = false

-- Click simulation
local VirtualInputManager = game:GetService("VirtualInputManager")
function mouse1click()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

-- Aimbot FOV Circle (Pink)
local AimbotEnabled = false
local FOVRadius = 100
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = PinkTheme.Primary
FOVCircle.Thickness = 2
FOVCircle.Radius = FOVRadius
FOVCircle.Transparency = 0.5
FOVCircle.Filled = false
FOVCircle.Visible = false

RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local mousePos = UserInputService:GetMouseLocation()
        FOVCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
end)

-- ESP Function (Pink Theme)
local function createESP(item)
    local adorneePart
    if item:IsA("Model") then
        if item:FindFirstChildWhichIsA("Humanoid") then return end
        adorneePart = item:FindFirstChildWhichIsA("BasePart")
    elseif item:IsA("BasePart") then
        adorneePart = item
    else
        return
    end

    if not adorneePart then return end

    local distance = (adorneePart.Position - ignoreDistanceFrom).Magnitude
    if distance < minDistance then return end

    if not item:FindFirstChild("ESP_Billboard") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Billboard"
        billboard.Adornee = adorneePart
        billboard.Size = UDim2.new(0, 50, 0, 20)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 2, 0)

        local label = Instance.new("TextLabel", billboard)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Text = item.Name
        label.BackgroundTransparency = 1
        label.TextColor3 = PinkTheme.Secondary
        label.TextStrokeTransparency = 0
        label.TextScaled = true
        billboard.Parent = item
    end

    if not item:FindFirstChild("ESP_Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = PinkTheme.Primary
        highlight.OutlineColor = PinkTheme.Secondary
        highlight.FillTransparency = 0.25
        highlight.OutlineTransparency = 0
        highlight.Adornee = item:IsA("Model") and item or adorneePart
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = item
    end
end


local function toggleESP(state)
    espEnabled = state
    for _, item in pairs(workspace:GetDescendants()) do
        if table.find(teleportTargets, item.Name) then
            if espEnabled then
                createESP(item)
            else
                if item:FindFirstChild("ESP_Billboard") then item.ESP_Billboard:Destroy() end
                if item:FindFirstChild("ESP_Highlight") then item.ESP_Highlight:Destroy() end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(desc)
    if espEnabled and table.find(teleportTargets, desc.Name) then
        task.wait(0.1)
        createESP(desc)
    end
end)

-- ESP for NPCs (Pink Theme)
local npcBoxes = {}

local function createNPCESP(npc)
    if not npc:IsA("Model") or npc:FindFirstChild("HumanoidRootPart") == nil then return end

    local root = npc:FindFirstChild("HumanoidRootPart")
    if npcBoxes[npc] then return end

    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Transparency = 1
    box.Color = PinkTheme.Primary
    box.Filled = false
    box.Visible = true

    local nameText = Drawing.new("Text")
    nameText.Text = "💗 " .. npc.Name
    nameText.Color = PinkTheme.Secondary
    nameText.Size = 16
    nameText.Center = true
    nameText.Outline = true
    nameText.Visible = true

    npcBoxes[npc] = {box = box, name = nameText}

    -- Cleanup on remove
    npc.AncestryChanged:Connect(function(_, parent)
        if not parent and npcBoxes[npc] then
            npcBoxes[npc].box:Remove()
            npcBoxes[npc].name:Remove()
            npcBoxes[npc] = nil
        end
    end)
end

local function toggleNPCESP(state)
    npcESPEnabled = state
    if not state then
        for npc, visuals in pairs(npcBoxes) do
            if visuals.box then visuals.box:Remove() end
            if visuals.name then visuals.name:Remove() end
        end
        npcBoxes = {}
    else
        -- Show NPC ESP for already existing NPCs
        for _, obj in ipairs(workspace:GetDescendants()) do
            if table.find(AimbotTargets, obj.Name) and obj:IsA("Model") then
                createNPCESP(obj)
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(desc)
    if table.find(AimbotTargets, desc.Name) and desc:IsA("Model") then
        task.wait(0.1)
        if npcESPEnabled then
            createNPCESP(desc)
        end
    end
end)

-- Auto Tree Farm Logic with timeout
local badTrees = {}

task.spawn(function()
    while true do
        if AutoTreeFarmEnabled then
            local trees = {}
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Trunk" and obj.Parent and obj.Parent.Name == "Small Tree" then
                    local distance = (obj.Position - ignoreDistanceFrom).Magnitude
                    if distance > minDistance and not badTrees[obj:GetFullName()] then
                        table.insert(trees, obj)
                    end
                end
            end

            table.sort(trees, function(a, b)
                return (a.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <
                       (b.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            end)

            for _, trunk in ipairs(trees) do
                if not AutoTreeFarmEnabled then break end
                LocalPlayer.Character:PivotTo(trunk.CFrame + Vector3.new(0, 3, 0))
                task.wait(0.2)
                local startTime = tick()
                while AutoTreeFarmEnabled and trunk and trunk.Parent and trunk.Parent.Name == "Small Tree" do
                    mouse1click()
                    task.wait(0.2)
                    if tick() - startTime > 12 then
                        badTrees[trunk:GetFullName()] = true
                        break
                    end
                end
                task.wait(0.3)
            end
        end
        task.wait(1.5)
    end
end)

local AutoLogFarmEnabled = false
local LogDropType = "Campfire" -- or "Grinder"

local function teleportToClosestLog()
    local closest, shortest = nil, math.huge
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Log" and obj:IsA("Model") then
            local cf = nil
            if pcall(function() cf = obj:GetPivot() end) then
                -- success
            else
                local part = obj:FindFirstChildWhichIsA("BasePart")
                if part then cf = part.CFrame end
            end
            if cf then
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (cf.Position - hrp.Position).Magnitude
                    if dist < shortest then
                        closest = obj
                        shortest = dist
                    end
                end
            end
        end
    end
    if closest then
        local cf = nil
        if pcall(function() cf = closest:GetPivot() end) then
            -- success
        else
            local part = closest:FindFirstChildWhichIsA("BasePart")
            if part then cf = part.CFrame end
        end
        if cf then
            LocalPlayer.Character:PivotTo(cf + Vector3.new(0, 5, 0)) -- Teleport 5 studs above log
            return closest
        end
    end
    return nil
end


local function getBagPickupCount()
    if LogBagType == "Old Sack" then
        return 5
    elseif LogBagType == "Good Sack" then
        return 15
    elseif LogBagType == "Auto" then
        local bag = getBagType()
        if bag == "Good Sack" then return 15 end
        if bag == "Old Sack" then return 5 end
    end
    return 0
end

task.spawn(function()
    while true do
        if AutoLogFarmEnabled then
            local pickupCount = getBagPickupCount()
            if pickupCount == 0 then
                Rayfield:Notify({Title="💗 Auto Log Farm", Content="No sack type selected or found! 💔", Duration=3})
                AutoLogFarmEnabled = false
                continue
            end

            -- Find the nearest log
            local log = getClosestLog()
            if log then
                -- Teleport above log
                local pos = log.Position or (log.PrimaryPart and log.PrimaryPart.Position)
                if pos then
                    LocalPlayer.Character:PivotTo(CFrame.new(pos + Vector3.new(0, 2, 0)))
                    task.wait(0.5)
                    -- Move mouse to feet
                    local footPos = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
                    local screen = camera:WorldToScreenPoint(footPos)
                    VirtualInputManager:SendMouseMoveEvent(screen.X, screen.Y, game)
                    task.wait(0.25)
                    -- Pickup logs (F then E, x times)
                    for i=1, pickupCount do
                        pressKey("F")
                        pressKey("E")
                        task.wait(0.13)
                    end

                    -- Teleport to drop location
                    if LogDropType == "Campfire" then
                        LocalPlayer.Character:PivotTo(CFrame.new(0, 10, 0))
                    else
                        LocalPlayer.Character:PivotTo(CFrame.new(16.1,4,-4.6))
                    end
                    task.wait(2)
                end
            else
                Rayfield:Notify({Title="💗 Auto Log Farm", Content="No log found! 🌳", Duration=3})
                task.wait(3)
            end
        end
        task.wait(1)
    end
end)




local function getClosestLog()
    local minDist = math.huge
    local closest = nil
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Log" then
            local pos = nil
            if obj:IsA("BasePart") then
                pos = obj.Position
            elseif obj:IsA("Model") then
                -- Try PrimaryPart
                if obj.PrimaryPart then
                    pos = obj.PrimaryPart.Position
                else
                    -- Fallback: Find any BasePart inside the Model
                    for _, part in ipairs(obj:GetChildren()) do
                        if part:IsA("BasePart") then
                            pos = part.Position
                            break
                        end
                    end
                end
            end
            if pos then
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - pos).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = obj
                    end
                end
            end
        end
    end
    return closest
end



local function pressKey(key)
    key = typeof(key) == "EnumItem" and key or Enum.KeyCode[key]
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(0.07)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end



-- Variables for optimized aimbot
local lastAimbotCheck = 0
local aimbotCheckInterval = 0.02 -- How often aimbot updates (in seconds)
local smoothness = 0.2 -- How smoothly the camera moves towards target

RunService.RenderStepped:Connect(function()
    -- Only run if aimbot is enabled and right mouse button is held
    if not AimbotEnabled or not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        FOVCircle.Visible = false
        return
    end

    local currentTime = tick()
    if currentTime - lastAimbotCheck < aimbotCheckInterval then
        -- Skip until next allowed update time
        return
    end
    lastAimbotCheck = currentTime

    local mousePos = UserInputService:GetMouseLocation()
    local closestTarget = nil
    local shortestDistance = math.huge

    -- Search for closest target inside FOV radius
    for _, obj in ipairs(workspace:GetDescendants()) do
        if table.find(AimbotTargets, obj.Name) and obj:IsA("Model") then
            local head = obj:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortestDistance and dist <= FOVRadius then
                        shortestDistance = dist
                        closestTarget = head
                    end
                end
            end
        end
    end

    if closestTarget then
        -- Smoothly rotate camera towards the target's head
        local currentCF = camera.CFrame
        local targetCF = CFrame.new(currentCF.Position, closestTarget.Position)
        camera.CFrame = currentCF:Lerp(targetCF, smoothness)

        -- Keep FOV circle visible and at mouse position
        FOVCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
end)



-- Fly Logic
local flying, flyConnection = false, nil
local speed = 60

local function startFlying()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local bodyGyro = Instance.new("BodyGyro", hrp)
    local bodyVelocity = Instance.new("BodyVelocity", hrp)
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = hrp.CFrame
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

    flyConnection = RunService.RenderStepped:Connect(function()
        local moveVec = Vector3.zero
        local camCF = camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec += camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec -= camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec -= camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec += camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec += camCF.UpVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec -= camCF.UpVector end
        bodyVelocity.Velocity = moveVec.Magnitude > 0 and moveVec.Unit * speed or Vector3.zero
        bodyGyro.CFrame = camCF
    end)
end

local function stopFlying()
    if flyConnection then flyConnection:Disconnect() end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, v in pairs(hrp:GetChildren()) do
            if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end
        end
    end
end

local function toggleFly(state)
    flying = state
    if flying then startFlying() else stopFlying() end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        toggleFly(not flying)
    end
end)

RunService.RenderStepped:Connect(function()
    for npc, visuals in pairs(npcBoxes) do
        local box = visuals.box
        local name = visuals.name

        if npc and npc:FindFirstChild("HumanoidRootPart") then
            local hrp = npc.HumanoidRootPart
            local size = Vector2.new(60, 80)
            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)

            if onScreen then
                box.Position = Vector2.new(screenPos.X - size.X / 2, screenPos.Y - size.Y / 2)
                box.Size = size
                box.Visible = true

                name.Position = Vector2.new(screenPos.X, screenPos.Y - size.Y / 2 - 15)
                name.Visible = true
            else
                box.Visible = false
                name.Visible = false
            end
        else
            box:Remove()
            name:Remove()
            npcBoxes[npc] = nil
        end
    end
end)

-- Walk Speed Variable
local currentSpeed = 16

-- Function to apply speed
local function setWalkSpeed(speed)
    currentSpeed = speed
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
    end
end

-- Update speed whenever character respawns
LocalPlayer.CharacterAdded:Connect(function(char)
    task.spawn(function()
        local humanoid = char:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.WalkSpeed = currentSpeed
        end
    end)
end)

-- GUI Tabs with updated emojis and placement
local HomeTab = Window:CreateTab("💕 Home 💕", 4483362458)

HomeTab:CreateButton({
    Name = "🔥 Teleport to Campfire",
    Callback = function()
        LocalPlayer.Character:PivotTo(CFrame.new(0, 10, 0))
        Rayfield:Notify({
            Title = "💕 Teleport",
            Content = "Teleported to Campfire! 🔥",
            Duration = 3,
            Image = 4483362458,
        })
    end
})

HomeTab:CreateButton({
    Name = "⚙️ Teleport to Grinder",
    Callback = function()
        LocalPlayer.Character:PivotTo(CFrame.new(16.1,4,-4.6))
        Rayfield:Notify({
            Title = "💕 Teleport",
            Content = "Teleported to Grinder! ⚙️",
            Duration = 3,
            Image = 4483362458,
        })
    end
})

-- Speed Slider
HomeTab:CreateSlider({
    Name = "💨 Speedhack",
    Range = {16, 100}, -- From normal speed to fast
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = setWalkSpeed
})

HomeTab:CreateToggle({
    Name = "👁️ Item ESP",
    CurrentValue = false,
    Callback = toggleESP
})

HomeTab:CreateToggle({
    Name = "👥 NPC ESP",
    CurrentValue = false,
    Callback = function(value)
        toggleNPCESP(value)
        Rayfield:Notify({
            Title = "💕 NPC ESP",
            Content = value and "NPC ESP Enabled 💗" or "NPC ESP Disabled 💔",
            Duration = 4,
            Image = 4483362458,
        })
    end
})

HomeTab:CreateToggle({
    Name = "🌳 Auto Tree Farm",
    CurrentValue = false,
    Callback = function(value)
        AutoTreeFarmEnabled = value
        Rayfield:Notify({
            Title = "💕 Auto Tree Farm",
            Content = value and "Tree farming started! 🌿" or "Tree farming stopped! 🍂",
            Duration = 4,
            Image = 4483362458,
        })
    end
})

HomeTab:CreateToggle({
    Name = "🪵 Auto Log Farm",
    CurrentValue = false,
    Callback = function(value)
        AutoLogFarmEnabled = value
        Rayfield:Notify({Title="💕 Auto Log Farm", Content=value and "Enabled 🌳" or "Disabled 🍂", Duration=3})
    end
})


HomeTab:CreateToggle({
    Name = "🎯 Aimbot (Right Click)",
    CurrentValue = false,
    Callback = function(value)
        AimbotEnabled = value
        Rayfield:Notify({
            Title = "💕 Aimbot",
            Content = value and "Enabled - Hold Right Click to aim 🎯" or "Disabled ❌",
            Duration = 4,
            Image = 4483362458,
        })
    end
})

HomeTab:CreateToggle({
    Name = "🕊️ Fly (WASD + Space + Shift)",
    CurrentValue = false,
    Callback = function(value)
        toggleFly(value)
        Rayfield:Notify({
            Title = "💕 Fly",
            Content = value and "Fly Enabled 🕊️" or "Fly Disabled 🚫",
            Duration = 4,
            Image = 4483362458,
        })
    end
})


-- Anti Death Teleport Variables
local AntiDeathEnabled = false
local AntiDeathRadius = 50
local AntiDeathTargets = {
    Alien = true,
    ["Alpha Wolf"] = true,
    Wolf = true,
    ["Crossbow Cultist"] = true,
    Cultist = true,
    Bear = true,
}

-- Visual circle for detection radius (Pink)
local detectionCircle = Instance.new("Part")
detectionCircle.Name = "AntiDeathCircle"
detectionCircle.Anchored = true
detectionCircle.CanCollide = false
detectionCircle.Transparency = 0.7
detectionCircle.Material = Enum.Material.Neon
detectionCircle.Color = PinkTheme.Primary
detectionCircle.Parent = workspace

local mesh = Instance.new("SpecialMesh", detectionCircle)
mesh.MeshType = Enum.MeshType.Cylinder
mesh.Scale = Vector3.new(AntiDeathRadius * 2, 0.2, AntiDeathRadius * 2)

-- Update detection circle position and size
local function updateDetectionCircle()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        detectionCircle.Position = Vector3.new(hrp.Position.X, hrp.Position.Y - 3, hrp.Position.Z)
        mesh.Scale = Vector3.new(AntiDeathRadius * 2, 0.2, AntiDeathRadius * 2)
        detectionCircle.Transparency = AntiDeathEnabled and 0.5 or 1
    else
        detectionCircle.Transparency = 1
    end
end

RunService.RenderStepped:Connect(function()
    updateDetectionCircle()
end)

-- Anti Death Teleport Logic
task.spawn(function()
    while true do
        if AntiDeathEnabled then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos = hrp.Position
                for _, npc in ipairs(workspace:GetDescendants()) do
                    if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") and AntiDeathTargets[npc.Name] then
                        local npcPos = npc.HumanoidRootPart.Position
                        if (npcPos - pos).Magnitude <= AntiDeathRadius then
                            -- Teleport away immediately
                            LocalPlayer.Character:PivotTo(CFrame.new(0, 10, 0))
                            Rayfield:Notify({
                                Title = "💕 Anti Death",
                                Content = "Teleported away from danger! 🛡️",
                                Duration = 3,
                                Image = 4483362458,
                            })
                            break
                        end
                    end
                end
            end
        end
        task.wait(0.2)
    end
end)


-- Add toggle to Home Tab
HomeTab:CreateToggle({
    Name = "🛡️ Anti Death Teleport",
    CurrentValue = false,
    Callback = function(value)
        AntiDeathEnabled = value
        Rayfield:Notify({
            Title = "💕 Anti Death Teleport",
            Content = value and "Enabled 🛡️" or "Disabled ❌",
            Duration = 4,
            Image = 4483362458,
        })
    end
})

-- Teleport Tab with updated emojis
local TeleTab = Window:CreateTab("🧭 Teleport 🧭", 4483362458)
for _, itemName in ipairs(teleportTargets) do
    -- Add emojis based on item type
    local emoji = "📍"
    if string.find(itemName:lower(), "wolf") then emoji = "🐺"
    elseif string.find(itemName:lower(), "bear") then emoji = "🐻"
    elseif string.find(itemName:lower(), "bunny") then emoji = "🐰"
    elseif string.find(itemName:lower(), "deer") then emoji = "🦌"
    elseif string.find(itemName:lower(), "chest") then emoji = "📦"
    elseif string.find(itemName:lower(), "log") then emoji = "🪵"
    elseif string.find(itemName:lower(), "apple") or string.find(itemName:lower(), "berry") then emoji = "🍎"
    elseif string.find(itemName:lower(), "cultist") then emoji = "👤"
    elseif string.find(itemName:lower(), "child") then emoji = "👶"
    elseif string.find(itemName:lower(), "weapon") or string.find(itemName:lower(), "gun") then emoji = "🔫"
    end
    
    TeleTab:CreateButton({
        Name = emoji .. " Teleport to " .. itemName,
        Callback = function()
            local closest, shortest = nil, math.huge
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == itemName and obj:IsA("Model") then
                    local cf = nil
                    if pcall(function() cf = obj:GetPivot() end) then
                        -- success
                    else
                        local part = obj:FindFirstChildWhichIsA("BasePart")
                        if part then cf = part.CFrame end
                    end
                    if cf then
                        local dist = (cf.Position - ignoreDistanceFrom).Magnitude
                        if dist >= minDistance and dist < shortest then
                            closest = obj
                            shortest = dist
                        end
                    end
                end
            end
            if closest then
                local cf = nil
                if pcall(function() cf = closest:GetPivot() end) then
                    -- success
                else
                    local part = closest:FindFirstChildWhichIsA("BasePart")
                    if part then cf = part.CFrame end
                end
                if cf then
                    LocalPlayer.Character:PivotTo(cf + Vector3.new(0, 5, 0))
                    Rayfield:Notify({
                        Title = "💕 Teleport",
                        Content = "Teleported to " .. itemName .. " " .. emoji,
                        Duration = 3,
                        Image = 4483362458,
                    })
                else
                    Rayfield:Notify({
                        Title = "💔 Teleport Failed",
                        Content = "Could not find a valid position to teleport.",
                        Duration = 5,
                        Image = 4483362458,
                    })
                end
            else
                Rayfield:Notify({
                    Title = "💔 Item Not Found",
                    Content = itemName .. " not found or too close to origin.",
                    Duration = 5,
                    Image = 4483362458,
                })
            end
        end
    })
end


local LogTab = Window:CreateTab("🌲 Log Farm 🌲", 4483362458)
local LogBagType = "Old Sack" -- "Old Sack", "Good Sack", or "Auto"
local OldSackToggle = nil
local GoodSackToggle = nil

OldSackToggle = LogTab:CreateToggle({
    Name = "🎒 Use Old Sack (5 logs)",
    CurrentValue = false,
    Callback = function(value)
        if value then
            LogBagType = "Old Sack"
            if GoodSackToggle then GoodSackToggle.Set(false) end
            Rayfield:Notify({
                Title = "💕 Log Farm",
                Content = "Using Old Sack (5 logs) 🎒",
                Duration = 3,
                Image = 4483362458,
            })
        else
            if LogBagType == "Old Sack" then LogBagType = "Auto" end
        end
    end
})

GoodSackToggle = LogTab:CreateToggle({
    Name = "💼 Use Good Sack (15 logs)",
    CurrentValue = false,
    Callback = function(value)
        if value then
            LogBagType = "Good Sack"
            if OldSackToggle then OldSackToggle.Set(false) end
            Rayfield:Notify({
                Title = "💕 Log Farm",
                Content = "Using Good Sack (15 logs) 💼",
                Duration = 3,
                Image = 4483362458,
            })
        else
            if LogBagType == "Good Sack" then LogBagType = "Auto" end
        end
    end
})



-- Anti Death Settings Tab with updated emojis
local AntiDeathTab = Window:CreateTab("⚔️ Anti Death ⚔️", 4483362458)

-- Radius Slider
AntiDeathTab:CreateSlider({
    Name = "📏 Detection Radius",
    Range = {10, 150},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = AntiDeathRadius,
    Callback = function(value)
        AntiDeathRadius = value
        updateDetectionCircle()
        Rayfield:Notify({
            Title = "💕 Anti Death",
            Content = "Detection radius set to " .. value .. " studs 📏",
            Duration = 3,
            Image = 4483362458,
        })
    end
})

-- Toggles for NPCs with emojis
AntiDeathTab:CreateLabel("👹 NPCs to Avoid:")
for npcName, _ in pairs(AntiDeathTargets) do
    local emoji = "👹"
    if npcName == "Wolf" or npcName == "Alpha Wolf" then emoji = "🐺"
    elseif npcName == "Bear" then emoji = "🐻"
    elseif npcName == "Alien" then emoji = "👽"
    elseif npcName:find("Cultist") then emoji = "👤"
    end
    
    AntiDeathTab:CreateToggle({
        Name = emoji .. " Avoid " .. npcName,
        CurrentValue = true,
        Callback = function(value)
            AntiDeathTargets[npcName] = value
        end
    })
end

-- Store default fog values to restore later
local defaultFogStart = game.Lighting.FogStart
local defaultFogEnd = game.Lighting.FogEnd

local fogEnabled = false

HomeTab:CreateToggle({
    Name = "☁️ No Fog (Clear Skies)",
    CurrentValue = false,
    Callback = function(value)
        fogEnabled = value
        if fogEnabled then
            -- Disable fog (clear sky)
            game.Lighting.FogStart = 999999 -- so far away it's basically off
            game.Lighting.FogEnd = 1000000
        else
            -- Restore default fog settings
            game.Lighting.FogStart = defaultFogStart
            game.Lighting.FogEnd = defaultFogEnd
        end
        Rayfield:Notify({
            Title = "💕 Fog Toggle",
            Content = fogEnabled and "No Fog Enabled ☀️" or "Fog Restored ☁️",
            Duration = 3,
            Image = 4483362458,
        })
    end
})

-- Add a Visuals tab
local VisualsTab = Window:CreateTab("🎨 Visuals 🎨", 4483362458)

VisualsTab:CreateToggle({
    Name = "💗 Pink ESP Colors",
    CurrentValue = true,
    Callback = function(value)
        if value then
            Rayfield:Notify({
                Title = "💕 Visuals",
                Content = "Pink ESP colors enabled! 💗",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end
})

VisualsTab:CreateButton({
    Name = "✨ Refresh Watermark",
    Callback = function()
        if WatermarkScreenGui then
            WatermarkScreenGui:Destroy()
        end
        Rayfield:Notify({
            Title = "💕 Watermark",
            Content = "Watermark refreshed! ✨",
            Duration = 3,
            Image = 4483362458,
        })
    end
})

-- Credits Tab
local CreditsTab = Window:CreateTab("💝 Credits 💝", 4483362458)

CreditsTab:CreateLabel("I ❤️ Anne - 99 Nights Script")
CreditsTab:CreateLabel("Made with love 💕")
CreditsTab:CreateLabel("")
CreditsTab:CreateLabel("Developers:")
CreditsTab:CreateLabel("💗 Cry0xene")
CreditsTab:CreateLabel("💗 metavrfr")
CreditsTab:CreateLabel("")
CreditsTab:CreateLabel("Special Thanks:")
CreditsTab:CreateLabel("💕 Anne - For the inspiration")
CreditsTab:CreateLabel("💕 Rayfield - For the amazing UI")
CreditsTab:CreateLabel("")
CreditsTab:CreateLabel("Version: 1.0 - Love Edition")

-- Welcome notification
Rayfield:Notify({
    Title = "💕 Welcome to I Love Anne!",
    Content = "Script loaded successfully! Made By Cry0xene & metavrfr 💝",
    Duration = 6,
    Image = 4483362458,
})
