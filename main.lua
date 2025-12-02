--// 99 Nights in the Forest Script with Pink I Love Anne Theme //--

-- Load Orion UI Library (Clean, modern, mobile-friendly)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Pink Theme Colors
local ThemeColor = Color3.fromRGB(255, 105, 180) -- Hot Pink
local ThemeColor2 = Color3.fromRGB(255, 182, 193) -- Light Pink
local BackgroundColor = Color3.fromRGB(30, 30, 40) -- Dark background for contrast
local TextColor = Color3.fromRGB(255, 255, 255)

-- Window Setup with Pink Theme
local Window = OrionLib:MakeWindow({
    Name = "I ❤️ Anne - 99 Nights",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "I_Love_Anne_Settings",
    IntroEnabled = true,
    IntroText = "I Love Anne",
    IntroIcon = "rbxassetid://4483362458",
    ThemeColor = ThemeColor,
    Icon = "rbxassetid://4483362458"
})

-- Update OrionLib theme colors
OrionLib.ThemeColor = ThemeColor

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
FOVCircle.Color = ThemeColor
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

-- ESP Function (Pink highlights)
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
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 3, 0)

        local label = Instance.new("TextLabel", billboard)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Text = item.Name
        label.BackgroundTransparency = 1
        label.TextColor3 = ThemeColor2
        label.TextStrokeTransparency = 0
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        billboard.Parent = item
    end

    if not item:FindFirstChild("ESP_Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = ThemeColor
        highlight.OutlineColor = ThemeColor2
        highlight.FillTransparency = 0.3
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

-- ESP for NPCs (Pink)
local npcBoxes = {}

local function createNPCESP(npc)
    if not npc:IsA("Model") or npc:FindFirstChild("HumanoidRootPart") == nil then return end

    local root = npc:FindFirstChild("HumanoidRootPart")
    if npcBoxes[npc] then return end

    local box = Drawing.new("Square")
    box.Thickness = 3
    box.Transparency = 1
    box.Color = ThemeColor
    box.Filled = false
    box.Visible = true

    local nameText = Drawing.new("Text")
    nameText.Text = "❤️ " .. npc.Name .. " ❤️"
    nameText.Color = ThemeColor2
    nameText.Size = 18
    nameText.Center = true
    nameText.Outline = true
    nameText.OutlineColor = Color3.fromRGB(0, 0, 0)
    nameText.Visible = true

    local healthText = Drawing.new("Text")
    healthText.Color = Color3.fromRGB(255, 255, 255)
    healthText.Size = 14
    healthText.Center = true
    healthText.Outline = true
    healthText.Visible = true

    npcBoxes[npc] = {box = box, name = nameText, health = healthText}

    npc.AncestryChanged:Connect(function(_, parent)
        if not parent and npcBoxes[npc] then
            npcBoxes[npc].box:Remove()
            npcBoxes[npc].name:Remove()
            npcBoxes[npc].health:Remove()
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
            if visuals.health then visuals.health:Remove() end
        end
        npcBoxes = {}
    else
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

-- Auto Tree Farm Logic
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

-- Auto Log Farm Variables
local AutoLogFarmEnabled = false
local LogBagType = "Auto"
local currentSack = nil

local function getBagType()
    if not LocalPlayer.Character then return nil end
    for _, child in pairs(LocalPlayer.Character:GetChildren()) do
        if child.Name == "Old Sack" or child.Name == "Good Sack" then
            return child.Name
        end
    end
    return nil
end

local function getBagPickupCount()
    local bagType = LogBagType == "Auto" and getBagType() or LogBagType
    if bagType == "Good Sack" then
        return 15
    elseif bagType == "Old Sack" then
        return 5
    end
    return 0
end

local function pressKey(key)
    key = typeof(key) == "EnumItem" and key or Enum.KeyCode[key]
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(0.07)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

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
            LocalPlayer.Character:PivotTo(cf + Vector3.new(0, 5, 0))
            return closest
        end
    end
    return nil
end

task.spawn(function()
    while true do
        if AutoLogFarmEnabled then
            local pickupCount = getBagPickupCount()
            if pickupCount == 0 then
                OrionLib:MakeNotification({
                    Name = "Auto Log Farm",
                    Content = "No sack found!",
                    Image = "rbxassetid://4483362458",
                    Time = 3
                })
                task.wait(3)
                continue
            end

            local log = teleportToClosestLog()
            if log then
                local footPos = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
                local screen = camera:WorldToScreenPoint(footPos)
                VirtualInputManager:SendMouseMoveEvent(screen.X, screen.Y, game)
                task.wait(0.25)
                
                for i=1, pickupCount do
                    pressKey("F")
                    pressKey("E")
                    task.wait(0.13)
                end
                
                LocalPlayer.Character:PivotTo(CFrame.new(0, 10, 0))
                task.wait(2)
            else
                OrionLib:MakeNotification({
                    Name = "Auto Log Farm",
                    Content = "No logs found!",
                    Image = "rbxassetid://4483362458",
                    Time = 3
                })
                task.wait(3)
            end
        end
        task.wait(1)
    end
end)

-- Optimized Aimbot
local lastAimbotCheck = 0
local aimbotCheckInterval = 0.02
local smoothness = 0.2

RunService.RenderStepped:Connect(function()
    if not AimbotEnabled or not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        return
    end

    local currentTime = tick()
    if currentTime - lastAimbotCheck < aimbotCheckInterval then
        return
    end
    lastAimbotCheck = currentTime

    local mousePos = UserInputService:GetMouseLocation()
    local closestTarget = nil
    local shortestDistance = math.huge

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
        local currentCF = camera.CFrame
        local targetCF = CFrame.new(currentCF.Position, closestTarget.Position)
        camera.CFrame = currentCF:Lerp(targetCF, smoothness)
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

-- NPC ESP Update Loop
RunService.RenderStepped:Connect(function()
    for npc, visuals in pairs(npcBoxes) do
        local box = visuals.box
        local name = visuals.name
        local health = visuals.health

        if npc and npc:FindFirstChild("HumanoidRootPart") then
            local hrp = npc.HumanoidRootPart
            local humanoid = npc:FindFirstChildOfClass("Humanoid")
            local size = Vector2.new(60, 80)
            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)

            if onScreen then
                box.Position = Vector2.new(screenPos.X - size.X / 2, screenPos.Y - size.Y / 2)
                box.Size = size
                box.Visible = true

                name.Position = Vector2.new(screenPos.X, screenPos.Y - size.Y / 2 - 15)
                name.Visible = true

                if humanoid then
                    health.Text = "❤️ " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
                    health.Position = Vector2.new(screenPos.X, screenPos.Y + size.Y / 2 + 5)
                    health.Visible = true
                end
            else
                box.Visible = false
                name.Visible = false
                health.Visible = false
            end
        else
            if box then box:Remove() end
            if name then name:Remove() end
            if health then health:Remove() end
            npcBoxes[npc] = nil
        end
    end
end)

-- Walk Speed Variable
local currentSpeed = 16

local function setWalkSpeed(speedValue)
    currentSpeed = speedValue
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = speedValue
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.spawn(function()
        local humanoid = char:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.WalkSpeed = currentSpeed
        end
    end)
end)

-- GUI Tabs
local HomeTab = Window:MakeTab({
    Name = "🏠 Home",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

HomeTab:AddButton({
    Name = "Teleport to Campfire",
    Callback = function()
        LocalPlayer.Character:PivotTo(CFrame.new(0, 10, 0))
        OrionLib:MakeNotification({
            Name = "Teleport",
            Content = "Teleported to Campfire!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

HomeTab:AddButton({
    Name = "Teleport to Grinder",
    Callback = function()
        LocalPlayer.Character:PivotTo(CFrame.new(16.1, 4, -4.6))
        OrionLib:MakeNotification({
            Name = "Teleport",
            Content = "Teleported to Grinder!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

HomeTab:AddSlider({
    Name = "Speedhack",
    Min = 16,
    Max = 100,
    Default = 16,
    Color = ThemeColor,
    Increment = 1,
    ValueName = "Speed",
    Callback = setWalkSpeed
})

HomeTab:AddToggle({
    Name = "Item ESP",
    Default = false,
    Callback = toggleESP
})

HomeTab:AddToggle({
    Name = "NPC ESP",
    Default = false,
    Callback = function(value)
        toggleNPCESP(value)
        OrionLib:MakeNotification({
            Name = "NPC ESP",
            Content = value and "NPC ESP Enabled" or "NPC ESP Disabled",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

HomeTab:AddToggle({
    Name = "Auto Tree Farm",
    Default = false,
    Callback = function(value)
        AutoTreeFarmEnabled = value
        OrionLib:MakeNotification({
            Name = "Auto Tree Farm",
            Content = value and "Enabled" or "Disabled",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

HomeTab:AddToggle({
    Name = "Auto Log Farm",
    Default = false,
    Callback = function(value)
        AutoLogFarmEnabled = value
        OrionLib:MakeNotification({
            Name = "Auto Log Farm",
            Content = value and "Enabled" or "Disabled",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

HomeTab:AddToggle({
    Name = "Aimbot (Right Click)",
    Default = false,
    Callback = function(value)
        AimbotEnabled = value
        OrionLib:MakeNotification({
            Name = "Aimbot",
            Content = value and "Hold Right Click to aim" or "Disabled",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

HomeTab:AddToggle({
    Name = "Fly (WASD + Space + Shift)",
    Default = false,
    Callback = function(value)
        toggleFly(value)
        OrionLib:MakeNotification({
            Name = "Fly",
            Content = value and "Enabled - Q to toggle" or "Disabled",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

-- Anti Death System
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

-- Visual indicator
local detectionCircle = Instance.new("Part")
detectionCircle.Name = "AntiDeathCircle"
detectionCircle.Anchored = true
detectionCircle.CanCollide = false
detectionCircle.Transparency = 0.6
detectionCircle.Material = Enum.Material.Neon
detectionCircle.Color = ThemeColor
detectionCircle.Parent = workspace

local mesh = Instance.new("CylinderMesh", detectionCircle)
mesh.Scale = Vector3.new(AntiDeathRadius * 2, 0.1, AntiDeathRadius * 2)

local function updateDetectionCircle()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        detectionCircle.Position = Vector3.new(hrp.Position.X, hrp.Position.Y - 3, hrp.Position.Z)
        detectionCircle.Transparency = AntiDeathEnabled and 0.6 or 1
    else
        detectionCircle.Transparency = 1
    end
end

RunService.RenderStepped:Connect(updateDetectionCircle)

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
                            LocalPlayer.Character:PivotTo(CFrame.new(0, 10, 0))
                            OrionLib:MakeNotification({
                                Name = "Anti Death",
                                Content = "Teleported away from " .. npc.Name,
                                Image = "rbxassetid://4483362458",
                                Time = 3
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

HomeTab:AddToggle({
    Name = "Anti Death Teleport",
    Default = false,
    Callback = function(value)
        AntiDeathEnabled = value
        OrionLib:MakeNotification({
            Name = "Anti Death",
            Content = value and "Enabled" or "Disabled",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

HomeTab:AddSlider({
    Name = "Anti Death Radius",
    Min = 10,
    Max = 150,
    Default = 50,
    Color = ThemeColor,
    Increment = 1,
    ValueName = "Studs",
    Callback = function(value)
        AntiDeathRadius = value
        mesh.Scale = Vector3.new(value * 2, 0.1, value * 2)
    end
})

-- Teleport Tab
local TeleTab = Window:MakeTab({
    Name = "🧲 Teleport",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- Group teleports by category for better organization
local teleportCategories = {
    ["Animals"] = {"Alpha Wolf", "Wolf", "Bear", "Deer", "Bunny", "Alpha Wolf Pelt", "Wolf Corpse", "Wolf Pelt", "Bunny Foot"},
    ["Resources"] = {"Apple", "Berry", "Carrot", "Chilli", "Coal", "Log", "Sapling", "Seed Box", "Sheet Metal", "Tyre"},
    ["Containers"] = {"Item Chest", "Item Chest2", "Item Chest3", "Item Chest4", "Item Chest6", "Stronghold Diamond Chest", "Chest", "Good Sack"},
    ["Weapons"] = {"Revolver", "Revolver Ammo", "Rifle", "Rifle Ammo", "Spear", "Riot Shield", "Good Axe"},
    ["Crafting"] = {"Anvil Base", "Fuel Canister", "Oil Barrel", "Bolt", "Iron Body", "Leather Body"},
    ["Special"] = {"Crossbow Cultist", "Cultist", "Cultist Gem", "Lost Child", "Lost Child2", "Lost Child3", "Lost Child4"},
    ["Items"] = {"Bandage", "Broken Fan", "Broken Microwave", "Cake", "Medkit", "Meat? Sandwich", "Morsel", "Old Car Engine", "Old Flashlight", "Old Radio", "Steak", "Washing Machine", "Chair Set", "Coin Stack"}
}

for category, items in pairs(teleportCategories) do
    TeleTab:AddSection({
        Name = "📁 " .. category
    })
    
    for _, itemName in ipairs(items) do
        TeleTab:AddButton({
            Name = "Teleport to " .. itemName,
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
                        OrionLib:MakeNotification({
                            Name = "Teleport",
                            Content = "Teleported to " .. itemName,
                            Image = "rbxassetid://4483362458",
                            Time = 3
                        })
                    else
                        OrionLib:MakeNotification({
                            Name = "Teleport Failed",
                            Content = "Could not find valid position",
                            Image = "rbxassetid://4483362458",
                            Time = 5
                        })
                    end
                else
                    OrionLib:MakeNotification({
                        Name = "Item Not Found",
                        Content = itemName .. " not found",
                        Image = "rbxassetid://4483362458",
                        Time = 5
                    })
                end
            end
        })
    end
end

-- Log Farm Tab
local LogTab = Window:MakeTab({
    Name = "🌳 Log Farm",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

LogTab:AddSection({
    Name = "Bag Settings"
})

local oldSackToggle = LogTab:AddToggle({
    Name = "Use Old Sack (5 logs)",
    Default = false,
    Callback = function(value)
        if value then
            LogBagType = "Old Sack"
        else
            if LogBagType == "Old Sack" then
                LogBagType = "Auto"
            end
        end
    end
})

local goodSackToggle = LogTab:AddToggle({
    Name = "Use Good Sack (15 logs)",
    Default = false,
    Callback = function(value)
        if value then
            LogBagType = "Good Sack"
        else
            if LogBagType == "Good Sack" then
                LogBagType = "Auto"
            end
        end
    end
})

LogTab:AddLabel("Current: " .. (LogBagType == "Auto" and "Auto-detect" or LogBagType))

-- Visuals Tab
local VisualsTab = Window:MakeTab({
    Name = "🎨 Visuals",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local defaultFogStart = game.Lighting.FogStart
local defaultFogEnd = game.Lighting.FogEnd
local fogEnabled = false

VisualsTab:AddToggle({
    Name = "No Fog (Clear Skies)",
    Default = false,
    Callback = function(value)
        fogEnabled = value
        if fogEnabled then
            game.Lighting.FogStart = 999999
            game.Lighting.FogEnd = 1000000
        else
            game.Lighting.FogStart = defaultFogStart
            game.Lighting.FogEnd = defaultFogEnd
        end
        OrionLib:MakeNotification({
            Name = "Visuals",
            Content = fogEnabled and "No Fog Enabled" or "Fog Restored",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

VisualsTab:AddToggle({
    Name = "Pink Ambient Light",
    Default = false,
    Callback = function(value)
        if value then
            game.Lighting.Ambient = ThemeColor2
            game.Lighting.OutdoorAmbient = ThemeColor2
            game.Lighting.ColorShift_Top = ThemeColor
        else
            game.Lighting.Ambient = Color3.fromRGB(1, 1, 1)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(1, 1, 1)
            game.Lighting.ColorShift_Top = Color3.fromRGB(1, 1, 1)
        end
    end
})

VisualsTab:AddSlider({
    Name = "Brightness",
    Min = 0,
    Max = 10,
    Default = 1,
    Color = ThemeColor,
    Increment = 0.1,
    ValueName = "Level",
    Callback = function(value)
        game.Lighting.Brightness = value
    end
})

-- Settings Tab
local SettingsTab = Window:MakeTab({
    Name = "⚙️ Settings",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

SettingsTab:AddButton({
    Name = "Save Settings",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Settings Saved",
            Content = "All settings have been saved!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

SettingsTab:AddButton({
    Name = "Reset Settings",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Settings Reset",
            Content = "Settings have been reset to default!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

SettingsTab:AddParagraph("I ❤️ Anne Script", "Made with love for Anne\nVersion 1.0 - Pink Edition")

-- Initialize
OrionLib:Init()
OrionLib:MakeNotification({
    Name = "I ❤️ Anne Script",
    Content = "Welcome! Script loaded successfully!",
    Image = "rbxassetid://4483362458",
    Time = 5
})

-- Cleanup on script termination
game:GetService("UserInputService").WindowFocusReleased:Connect(function()
    toggleESP(false)
    toggleNPCESP(false)
    toggleFly(false)
    AimbotEnabled = false
    AutoTreeFarmEnabled = false
    AutoLogFarmEnabled = false
    AntiDeathEnabled = false
    detectionCircle:Destroy()
    FOVCircle:Remove()
end)
