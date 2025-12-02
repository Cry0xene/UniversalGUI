local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local UniversalGUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local GUI = UniversalGUI:Create{
    Name = "Universal GUI",
    Size = UDim2.fromOffset(600, 500),
    Theme = UniversalGUI.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

local UniversalFeatures = {}

UniversalFeatures.Watermark = Drawing.new("Text")
UniversalFeatures.Watermark.Text = "Universal GUI"
UniversalFeatures.Watermark.Size = 40
UniversalFeatures.Watermark.Font = 2
UniversalFeatures.Watermark.Outline = true
UniversalFeatures.Watermark.Center = true
RunService.RenderStepped:Connect(function()
    UniversalFeatures.Watermark.Position = Vector2.new(camera.ViewportSize.X/2, 15)
    UniversalFeatures.Watermark.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
end)

UniversalFeatures.EspEnabled = false
UniversalFeatures.NpcEspEnabled = false
UniversalFeatures.PlayerEspEnabled = false
UniversalFeatures.AimbotEnabled = false
UniversalFeatures.Flying = false
UniversalFeatures.SpeedEnabled = false
UniversalFeatures.NoClipEnabled = false
UniversalFeatures.InfiniteJump = false
UniversalFeatures.AutoClicker = false
UniversalFeatures.XrayEnabled = false
UniversalFeatures.Fullbright = false
UniversalFeatures.NightVision = false
UniversalFeatures.NoFallDamage = false
UniversalFeatures.AntiAfk = false
UniversalFeatures.AntiVoid = false
UniversalFeatures.ForceField = false
UniversalFeatures.AutoCollect = false
UniversalFeatures.AutoFarm = false
UniversalFeatures.SpinBot = false
UniversalFeatures.WallWalk = false
UniversalFeatures.Gravity = workspace.Gravity
UniversalFeatures.FlySpeed = 60
UniversalFeatures.WalkSpeed = 16
UniversalFeatures.JumpPower = 50
UniversalFeatures.JumpHeight = 7
UniversalFeatures.HipHeight = 0
UniversalFeatures.CameraFov = 70
UniversalFeatures.FovRadius = 100
UniversalFeatures.AimbotKey = Enum.UserInputType.MouseButton2
UniversalFeatures.FlyKey = Enum.KeyCode.Q
UniversalFeatures.Smoothness = 0.2
UniversalFeatures.EspBoxes = {}
UniversalFeatures.PlayerBoxes = {}
UniversalFeatures.NpcBoxes = {}
UniversalFeatures.FlyConnection = nil
UniversalFeatures.NoClipLoop = nil
UniversalFeatures.AutoClickLoop = nil
UniversalFeatures.AntiAfkLoop = nil
UniversalFeatures.SpinBotLoop = nil
UniversalFeatures.WallWalkLoop = nil

UniversalFeatures.VirtualInputManager = game:GetService("VirtualInputManager")
function UniversalFeatures.Mouse1Click()
    UniversalFeatures.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    UniversalFeatures.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

UniversalFeatures.FOVCircle = Drawing.new("Circle")
UniversalFeatures.FOVCircle.Color = Color3.fromRGB(255, 105, 180)
UniversalFeatures.FOVCircle.Thickness = 1
UniversalFeatures.FOVCircle.Radius = UniversalFeatures.FovRadius
UniversalFeatures.FOVCircle.Transparency = 0.5
UniversalFeatures.FOVCircle.Filled = false
UniversalFeatures.FOVCircle.Visible = false

RunService.RenderStepped:Connect(function()
    if UniversalFeatures.AimbotEnabled then
        local mousePos = UserInputService:GetMouseLocation()
        UniversalFeatures.FOVCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        UniversalFeatures.FOVCircle.Visible = true
    else
        UniversalFeatures.FOVCircle.Visible = false
    end
end)

function UniversalFeatures.CreateEsp(item, color, text)
    if not item:IsA("BasePart") and not item:IsA("Model") then return end
    
    local adorneePart
    if item:IsA("Model") then
        adorneePart = item:FindFirstChildWhichIsA("BasePart")
    else
        adorneePart = item
    end
    
    if not adorneePart then return end
    
    if not item:FindFirstChild("ESP_Billboard") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Billboard"
        billboard.Adornee = adorneePart
        billboard.Size = UDim2.new(0, 50, 0, 20)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        
        local label = Instance.new("TextLabel", billboard)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Text = text or item.Name
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeTransparency = 0
        label.TextScaled = true
        billboard.Parent = item
    end
    
    if not item:FindFirstChild("ESP_Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = color or Color3.fromRGB(255, 85, 0)
        highlight.OutlineColor = Color3.fromRGB(0, 100, 0)
        highlight.FillTransparency = 0.25
        highlight.OutlineTransparency = 0
        highlight.Adornee = item:IsA("Model") and item or adorneePart
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = item
    end
end

function UniversalFeatures.ToggleEsp(state)
    UniversalFeatures.EspEnabled = state
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Model") and not item:FindFirstChildWhichIsA("Humanoid") then
            if UniversalFeatures.EspEnabled then
                UniversalFeatures.CreateEsp(item)
            else
                if item:FindFirstChild("ESP_Billboard") then item.ESP_Billboard:Destroy() end
                if item:FindFirstChild("ESP_Highlight") then item.ESP_Highlight:Destroy() end
            end
        end
    end
end

function UniversalFeatures.CreatePlayerEsp(player)
    if not player.Character then return end
    if UniversalFeatures.PlayerBoxes[player] then return end
    
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Transparency = 1
    box.Color = Color3.fromRGB(0, 255, 0)
    box.Filled = false
    
    local nameText = Drawing.new("Text")
    nameText.Text = player.Name
    nameText.Color = Color3.fromRGB(255, 255, 255)
    nameText.Size = 16
    nameText.Center = true
    nameText.Outline = true
    
    local healthText = Drawing.new("Text")
    healthText.Text = "100 HP"
    healthText.Color = Color3.fromRGB(255, 0, 0)
    healthText.Size = 14
    healthText.Center = true
    healthText.Outline = true
    
    UniversalFeatures.PlayerBoxes[player] = {box = box, name = nameText, health = healthText}
    
    player.CharacterAdded:Connect(function()
        if UniversalFeatures.PlayerEspEnabled then
            UniversalFeatures.CreatePlayerEsp(player)
        end
    end)
end

function UniversalFeatures.TogglePlayerEsp(state)
    UniversalFeatures.PlayerEspEnabled = state
    if not state then
        for player, visuals in pairs(UniversalFeatures.PlayerBoxes) do
            if visuals.box then visuals.box:Remove() end
            if visuals.name then visuals.name:Remove() end
            if visuals.health then visuals.health:Remove() end
        end
        UniversalFeatures.PlayerBoxes = {}
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                UniversalFeatures.CreatePlayerEsp(player)
            end
        end
    end
end

function UniversalFeatures.ToggleNpcEsp(state)
    UniversalFeatures.NpcEspEnabled = state
    if not state then
        for npc, visuals in pairs(UniversalFeatures.NpcBoxes) do
            if visuals.box then visuals.box:Remove() end
            if visuals.name then visuals.name:Remove() end
        end
        UniversalFeatures.NpcBoxes = {}
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChildWhichIsA("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
                local box = Drawing.new("Square")
                box.Thickness = 2
                box.Transparency = 1
                box.Color = Color3.fromRGB(255, 85, 0)
                box.Filled = false
                
                local nameText = Drawing.new("Text")
                nameText.Text = obj.Name
                nameText.Color = Color3.fromRGB(255, 255, 255)
                nameText.Size = 16
                nameText.Center = true
                nameText.Outline = true
                
                UniversalFeatures.NpcBoxes[obj] = {box = box, name = nameText}
            end
        end
    end
end

UniversalFeatures.LastAimbotCheck = 0
UniversalFeatures.AimbotCheckInterval = 0.02

RunService.RenderStepped:Connect(function()
    if not UniversalFeatures.AimbotEnabled or not UserInputService:IsMouseButtonPressed(UniversalFeatures.AimbotKey) then
        UniversalFeatures.FOVCircle.Visible = false
        return
    end
    
    local currentTime = tick()
    if currentTime - UniversalFeatures.LastAimbotCheck < UniversalFeatures.AimbotCheckInterval then return end
    UniversalFeatures.LastAimbotCheck = currentTime
    
    local mousePos = UserInputService:GetMouseLocation()
    local closestTarget, shortestDistance = nil, math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortestDistance and dist <= UniversalFeatures.FovRadius then
                        shortestDistance = dist
                        closestTarget = head
                    end
                end
            end
        end
    end
    
    if closestTarget then
        local currentCF = camera.CFrame
        local targetCF = CFrame.new(camera.CFrame.Position, closestTarget.Position)
        camera.CFrame = currentCF:Lerp(targetCF, UniversalFeatures.Smoothness)
        UniversalFeatures.FOVCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        UniversalFeatures.FOVCircle.Visible = true
    else
        UniversalFeatures.FOVCircle.Visible = false
    end
end)

function UniversalFeatures.StartFlying()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local bodyGyro = Instance.new("BodyGyro", hrp)
    local bodyVelocity = Instance.new("BodyVelocity", hrp)
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = hrp.CFrame
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    
    UniversalFeatures.FlyConnection = RunService.RenderStepped:Connect(function()
        local moveVec = Vector3.zero
        local camCF = camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec += camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec -= camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec -= camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec += camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec += camCF.UpVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec -= camCF.UpVector end
        bodyVelocity.Velocity = moveVec.Magnitude > 0 and moveVec.Unit * UniversalFeatures.FlySpeed or Vector3.zero
        bodyGyro.CFrame = camCF
    end)
end

function UniversalFeatures.StopFlying()
    if UniversalFeatures.FlyConnection then UniversalFeatures.FlyConnection:Disconnect() end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, v in pairs(hrp:GetChildren()) do
            if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end
        end
    end
end

function UniversalFeatures.ToggleFly(state)
    UniversalFeatures.Flying = state
    if UniversalFeatures.Flying then UniversalFeatures.StartFlying() else UniversalFeatures.StopFlying() end
end

function UniversalFeatures.ToggleSpeed(state)
    UniversalFeatures.SpeedEnabled = state
    RunService.RenderStepped:Connect(function()
        if UniversalFeatures.SpeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = UniversalFeatures.WalkSpeed
        end
    end)
end

function UniversalFeatures.ToggleNoClip(state)
    UniversalFeatures.NoClipEnabled = state
    if UniversalFeatures.NoClipLoop then UniversalFeatures.NoClipLoop:Disconnect() end
    
    if UniversalFeatures.NoClipEnabled then
        UniversalFeatures.NoClipLoop = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

function UniversalFeatures.ToggleInfiniteJump(state)
    UniversalFeatures.InfiniteJump = state
    if state then
        UserInputService.JumpRequest:Connect(function()
            if UniversalFeatures.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

function UniversalFeatures.ToggleAutoClicker(state)
    UniversalFeatures.AutoClicker = state
    if UniversalFeatures.AutoClickLoop then UniversalFeatures.AutoClickLoop:Disconnect() end
    
    if UniversalFeatures.AutoClicker then
        UniversalFeatures.AutoClickLoop = RunService.RenderStepped:Connect(function()
            if UniversalFeatures.AutoClicker then
                UniversalFeatures.Mouse1Click()
                wait(0.1)
            end
        end)
    end
end

function UniversalFeatures.ToggleXray(state)
    UniversalFeatures.XrayEnabled = state
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
            if UniversalFeatures.XrayEnabled then
                part.LocalTransparencyModifier = 0.5
            else
                part.LocalTransparencyModifier = 0
            end
        end
    end
end

function UniversalFeatures.ToggleFullbright(state)
    UniversalFeatures.Fullbright = state
    if UniversalFeatures.Fullbright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
end

function UniversalFeatures.ToggleNightVision(state)
    UniversalFeatures.NightVision = state
    if UniversalFeatures.NightVision then
        if not LocalPlayer.Character then return end
        local head = LocalPlayer.Character:FindFirstChild("Head")
        if head then
            local highlight = Instance.new("Highlight")
            highlight.Name = "NightVision"
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.9
            highlight.OutlineTransparency = 0.9
            highlight.Adornee = head
            highlight.Parent = head
        end
    else
        if LocalPlayer.Character then
            local head = LocalPlayer.Character:FindFirstChild("Head")
            if head and head:FindFirstChild("NightVision") then
                head.NightVision:Destroy()
            end
        end
    end
end

function UniversalFeatures.ToggleNoFallDamage(state)
    UniversalFeatures.NoFallDamage = state
    if UniversalFeatures.NoFallDamage and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    end
end

function UniversalFeatures.ToggleAntiAfk(state)
    UniversalFeatures.AntiAfk = state
    if UniversalFeatures.AntiAfkLoop then UniversalFeatures.AntiAfkLoop:Disconnect() end
    
    if UniversalFeatures.AntiAfk then
        UniversalFeatures.AntiAfkLoop = RunService.Heartbeat:Connect(function()
            if UniversalFeatures.AntiAfk then
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end
        end)
    end
end

function UniversalFeatures.ToggleForceField(state)
    UniversalFeatures.ForceField = state
    if LocalPlayer.Character then
        if UniversalFeatures.ForceField then
            local forceField = Instance.new("ForceField")
            forceField.Name = "PlayerForceField"
            forceField.Parent = LocalPlayer.Character
        else
            local forceField = LocalPlayer.Character:FindFirstChild("PlayerForceField")
            if forceField then forceField:Destroy() end
        end
    end
end

function UniversalFeatures.ToggleSpinBot(state)
    UniversalFeatures.SpinBot = state
    if UniversalFeatures.SpinBotLoop then UniversalFeatures.SpinBotLoop:Disconnect() end
    
    if UniversalFeatures.SpinBot then
        UniversalFeatures.SpinBotLoop = RunService.RenderStepped:Connect(function()
            if UniversalFeatures.SpinBot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0)
            end
        end)
    end
end

function UniversalFeatures.ToggleWallWalk(state)
    UniversalFeatures.WallWalk = state
    if UniversalFeatures.WallWalkLoop then UniversalFeatures.WallWalkLoop:Disconnect() end
    
    if UniversalFeatures.WallWalk then
        UniversalFeatures.WallWalkLoop = RunService.RenderStepped:Connect(function()
            if UniversalFeatures.WallWalk and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Climbing)
            end
        end)
    end
end

function UniversalFeatures.TeleportToPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:PivotTo(targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
        end
    end
end

function UniversalFeatures.SitOnHead(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:PivotTo(targetPlayer.Character.Head.CFrame + Vector3.new(0, 3, 0))
        end
    end
end

function UniversalFeatures.BringPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer.Character:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
        end
    end
end

function UniversalFeatures.KillPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
        targetPlayer.Character.Humanoid.Health = 0
    end
end

function UniversalFeatures.FreezePlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character then
        for _, part in pairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
            end
        end
    end
end

function UniversalFeatures.UnfreezePlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character then
        for _, part in pairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
            end
        end
    end
end

function UniversalFeatures.ExplodePlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local explosion = Instance.new("Explosion")
        explosion.Position = targetPlayer.Character.HumanoidRootPart.Position
        explosion.BlastRadius = 10
        explosion.BlastPressure = 100000
        explosion.DestroyJointRadiusPercent = 0
        explosion.Parent = workspace
    end
end

function UniversalFeatures.TeleportToPosition(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:PivotTo(CFrame.new(position))
    end
end

function UniversalFeatures.TeleportToSpawn()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local spawn = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChild("Spawn")
        if spawn then
            LocalPlayer.Character:PivotTo(spawn.CFrame + Vector3.new(0, 5, 0))
        else
            LocalPlayer.Character:PivotTo(CFrame.new(0, 100, 0))
        end
    end
end

function UniversalFeatures.ChangeServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end

function UniversalFeatures.RejoinServer()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end

function UniversalFeatures.ServerHop()
    local servers = {}
    local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100")
    local data = game:GetService("HttpService"):JSONDecode(req)
    
    for _, server in pairs(data.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server.id)
        end
    end
    
    if #servers > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
    end
end

function UniversalFeatures.CopyDiscord()
    setclipboard("https://discord.gg/example")
end

function UniversalFeatures.CopyGameId()
    setclipboard(tostring(game.PlaceId))
end

function UniversalFeatures.CopyJobId()
    setclipboard(game.JobId)
end

function UniversalFeatures.CopyPlayerUserId(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer then
        setclipboard(tostring(targetPlayer.UserId))
    end
end

function UniversalFeatures.CopyPlayerUsername(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer then
        setclipboard(targetPlayer.Name)
    end
end

function UniversalFeatures.ViewPlayerProfile(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Profile",
            Text = "Opening " .. targetPlayer.Name .. "'s profile",
            Duration = 3
        })
        game:GetService("GuiService"):OpenBrowserWindow("https://www.roblox.com/users/" .. targetPlayer.UserId .. "/profile")
    end
end

function UniversalFeatures.TpToTool()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local tool = LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") or LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
        if tool and tool:FindFirstChildWhichIsA("BasePart") then
            LocalPlayer.Character:PivotTo(tool:FindFirstChildWhichIsA("BasePart").CFrame)
        end
    end
end

function UniversalFeatures.TpToRandomPlayer()
    local players = Players:GetPlayers()
    if #players > 1 then
        local randomPlayer = players[math.random(1, #players)]
        while randomPlayer == LocalPlayer do
            randomPlayer = players[math.random(1, #players)]
        end
        UniversalFeatures.TeleportToPlayer(randomPlayer.Name)
    end
end

function UniversalFeatures.TpBehindPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:PivotTo(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5))
        end
    end
end

function UniversalFeatures.TpInFrontOfPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:PivotTo(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5))
        end
    end
end

function UniversalFeatures.LoopTpToPlayer(playerName)
    _G.LoopTp = true
    spawn(function()
        while _G.LoopTp do
            UniversalFeatures.TeleportToPlayer(playerName)
            wait(0.1)
        end
    end)
end

function UniversalFeatures.StopLoopTp()
    _G.LoopTp = false
end

function UniversalFeatures.LoopKillPlayer(playerName)
    _G.LoopKill = true
    spawn(function()
        while _G.LoopKill do
            UniversalFeatures.KillPlayer(playerName)
            wait(0.5)
        end
    end)
end

function UniversalFeatures.StopLoopKill()
    _G.LoopKill = false
end

function UniversalFeatures.LoopBringPlayer(playerName)
    _G.LoopBring = true
    spawn(function()
        while _G.LoopBring do
            UniversalFeatures.BringPlayer(playerName)
            wait(0.1)
        end
    end)
end

function UniversalFeatures.StopLoopBring()
    _G.LoopBring = false
end

function UniversalFeatures.FollowPlayer(playerName)
    _G.FollowPlayer = true
    spawn(function()
        while _G.FollowPlayer do
            local targetPlayer = Players:FindFirstChild(playerName)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character:PivotTo(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10))
                end
            end
            wait(0.1)
        end
    end)
end

function UniversalFeatures.StopFollowPlayer()
    _G.FollowPlayer = false
end

function UniversalFeatures.OrbitPlayer(playerName)
    _G.OrbitPlayer = true
    local angle = 0
    spawn(function()
        while _G.OrbitPlayer do
            local targetPlayer = Players:FindFirstChild(playerName)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local radius = 10
                    local x = math.cos(angle) * radius
                    local z = math.sin(angle) * radius
                    LocalPlayer.Character:PivotTo(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(x, 0, z))
                    angle = angle + 0.1
                end
            end
            wait(0.05)
        end
    end)
end

function UniversalFeatures.StopOrbitPlayer()
    _G.OrbitPlayer = false
end

function UniversalFeatures.FloatPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.MaxForce = Vector3.new(0, 9e9, 0)
        bodyVelocity.Parent = targetPlayer.Character.HumanoidRootPart
        wait(2)
        bodyVelocity:Destroy()
    end
end

function UniversalFeatures.LaunchPlayer(playerName, power)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, power or 100, 0)
        bodyVelocity.MaxForce = Vector3.new(0, 9e9, 0)
        bodyVelocity.Parent = targetPlayer.Character.HumanoidRootPart
        wait(0.5)
        bodyVelocity:Destroy()
    end
end

function UniversalFeatures.PushPlayer(playerName, power)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local direction = (targetPlayer.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * (power or 100)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = targetPlayer.Character.HumanoidRootPart
        wait(0.5)
        bodyVelocity:Destroy()
    end
end

function UniversalFeatures.PullPlayer(playerName, power)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local direction = (LocalPlayer.Character.HumanoidRootPart.Position - targetPlayer.Character.HumanoidRootPart.Position).Unit
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * (power or 100)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = targetPlayer.Character.HumanoidRootPart
        wait(0.5)
        bodyVelocity:Destroy()
    end
end

function UniversalFeatures.GodMode()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.MaxHealth = math.huge
        LocalPlayer.Character.Humanoid.Health = math.huge
    end
end

function UniversalFeatures.InfiniteYield()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

function UniversalFeatures.ChatSpam(message, times)
    for i = 1, (times or 10) do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        wait(0.5)
    end
end

function UniversalFeatures.SpamPlayer(playerName, message, times)
    for i = 1, (times or 10) do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w " .. playerName .. " " .. message, "All")
        wait(0.5)
    end
end

function UniversalFeatures.AnnoyPlayer(playerName)
    _G.AnnoyPlayer = true
    spawn(function()
        while _G.AnnoyPlayer do
            UniversalFeatures.TeleportToPlayer(playerName)
            wait(0.1)
            UniversalFeatures.BringPlayer(playerName)
            wait(0.1)
        end
    end)
end

function UniversalFeatures.StopAnnoyPlayer()
    _G.AnnoyPlayer = false
end

function UniversalFeatures.CloneCharacter()
    if LocalPlayer.Character then
        local clone = LocalPlayer.Character:Clone()
        clone.Parent = workspace
        clone:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(10, 0, 0))
    end
end

function UniversalFeatures.Invisible()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            elseif part:IsA("Decal") then
                part.Transparency = 1
            end
        end
    end
end

function UniversalFeatures.Visible()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            elseif part:IsA("Decal") then
                part.Transparency = 0
            end
        end
    end
end

function UniversalFeatures.Naked()
    if LocalPlayer.Character then
        for _, clothing in pairs(LocalPlayer.Character:GetDescendants()) do
            if clothing:IsA("ShirtGraphic") or clothing:IsA("Pants") or clothing:IsA("Shirt") then
                clothing:Destroy()
            end
        end
    end
end

function UniversalFeatures.BigHead()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
        LocalPlayer.Character.Head.Mesh.Scale = Vector3.new(5, 5, 5)
    end
end

function UniversalFeatures.NormalHead()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
        LocalPlayer.Character.Head.Mesh.Scale = Vector3.new(1, 1, 1)
    end
end

function UniversalFeatures.BigCharacter()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * 2
            end
        end
    end
end

function UniversalFeatures.SmallCharacter()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Size = part.Size / 2
            end
        end
    end
end

function UniversalFeatures.Shrek()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.BrickColor = BrickColor.new("Bright green")
            end
        end
    end
end

function UniversalFeatures.ResetCharacter()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end

function UniversalFeatures.HealCharacter()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
    end
end

function UniversalFeatures.MaxHealth()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.MaxHealth = 1000
        LocalPlayer.Character.Humanoid.Health = 1000
    end
end

function UniversalFeatures.NoClipCharacter()
    UniversalFeatures.ToggleNoClip(true)
end

function UniversalFeatures.FlyCharacter()
    UniversalFeatures.ToggleFly(true)
end

function UniversalFeatures.SpeedCharacter()
    UniversalFeatures.ToggleSpeed(true)
end

function UniversalFeatures.JumpCharacter()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 200
    end
end

function UniversalFeatures.SwimSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.SwimSpeed = 100
    end
end

function UniversalFeatures.AnchorCharacter()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
            end
        end
    end
end

function UniversalFeatures.UnanchorCharacter()
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
            end
        end
    end
end

function UniversalFeatures.FireCharacter()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local fire = Instance.new("Fire")
        fire.Size = 10
        fire.Heat = 10
        fire.Parent = LocalPlayer.Character.HumanoidRootPart
    end
end

function UniversalFeatures.SmokeCharacter()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local smoke = Instance.new("Smoke")
        smoke.Size = 10
        smoke.Opacity = 0.5
        smoke.RiseVelocity = 5
        smoke.Parent = LocalPlayer.Character.HumanoidRootPart
    end
end

function UniversalFeatures.SparklesCharacter()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local sparkles = Instance.new("Sparkles")
        sparkles.SparkleColor = Color3.fromRGB(255, 105, 180)
        sparkles.Parent = LocalPlayer.Character.HumanoidRootPart
    end
end

function UniversalFeatures.ResetWorkspace()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("BasePart") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.LowGravity()
    workspace.Gravity = 10
end

function UniversalFeatures.NormalGravity()
    workspace.Gravity = 196.2
end

function UniversalFeatures.ZeroGravity()
    workspace.Gravity = 0
end

function UniversalFeatures.HighGravity()
    workspace.Gravity = 500
end

function UniversalFeatures.TimeDay()
    Lighting.ClockTime = 14
end

function UniversalFeatures.TimeNight()
    Lighting.ClockTime = 0
end

function UniversalFeatures.TimeStop()
    Lighting.ClockTime = 12
end

function UniversalFeatures.FogOff()
    Lighting.FogEnd = 100000
end

function UniversalFeatures.FogOn()
    Lighting.FogEnd = 100
end

function UniversalFeatures.AmbientLight(color)
    Lighting.Ambient = Color3.fromRGB(color.R, color.G, color.B)
end

function UniversalFeatures.OutdoorAmbientLight(color)
    Lighting.OutdoorAmbient = Color3.fromRGB(color.R, color.G, color.B)
end

function UniversalFeatures.ColorShiftTop(color)
    Lighting.ColorShift_Top = Color3.fromRGB(color.R, color.G, color.B)
end

function UniversalFeatures.ColorShiftBottom(color)
    Lighting.ColorShift_Bottom = Color3.fromRGB(color.R, color.G, color.B)
end

function UniversalFeatures.Brightness(value)
    Lighting.Brightness = value
end

function UniversalFeatures.GlobalShadowsOff()
    Lighting.GlobalShadows = false
end

function UniversalFeatures.GlobalShadowsOn()
    Lighting.GlobalShadows = true
end

function UniversalFeatures.Saturation(value)
    Lighting.Saturation = value
end

function UniversalFeatures.Contrast(value)
    Lighting.Contrast = value
end

function UniversalFeatures.ExposureCompensation(value)
    Lighting.ExposureCompensation = value
end

function UniversalFeatures.RemoveTools()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            for _, tool in pairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Destroy()
                end
            end
            for _, tool in pairs(player.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Destroy()
                end
            end
        end
    end
end

function UniversalFeatures.RemoveWeapons()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj.Name:lower():find("sword") or obj.Name:lower():find("gun") or obj.Name:lower():find("weapon") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveParts()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and not obj:IsDescendantOf(LocalPlayer.Character) then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveNPCs()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildWhichIsA("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveVehicles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") or obj.Name:lower():find("car") or obj.Name:lower():find("vehicle") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveDoors()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("door") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveWindows()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("window") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveWalls()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("wall") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveFloors()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("floor") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveCeilings()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("ceiling") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveStairs()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("stair") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveLights()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("PointLight") or obj:IsA("SurfaceLight") or obj:IsA("SpotLight") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveSounds()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveParticles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveScripts()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveDecals()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveMeshes()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("SpecialMesh") or obj:IsA("MeshPart") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveUnions()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("UnionOperation") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveWeldConstraints()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("WeldConstraint") or obj:IsA("Weld") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveBodyMovers()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") or obj:IsA("BodyForce") or obj:IsA("BodyThrust") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveForceFields()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ForceField") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveExplosions()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Explosion") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveFire()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Fire") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveSmoke()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Smoke") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveSparkles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sparkles") then
            obj:Destroy()
        end
    end
end

function UniversalFeatures.RemoveAll()
    UniversalFeatures.RemoveTools()
    UniversalFeatures.RemoveWeapons()
    UniversalFeatures.RemoveParts()
    UniversalFeatures.RemoveNPCs()
    UniversalFeatures.RemoveVehicles()
    UniversalFeatures.RemoveDoors()
    UniversalFeatures.RemoveWindows()
    UniversalFeatures.RemoveWalls()
    UniversalFeatures.RemoveFloors()
    UniversalFeatures.RemoveCeilings()
    UniversalFeatures.RemoveStairs()
    UniversalFeatures.RemoveLights()
    UniversalFeatures.RemoveSounds()
    UniversalFeatures.RemoveParticles()
    UniversalFeatures.RemoveScripts()
    UniversalFeatures.RemoveDecals()
    UniversalFeatures.RemoveMeshes()
    UniversalFeatures.RemoveUnions()
    UniversalFeatures.RemoveWeldConstraints()
    UniversalFeatures.RemoveBodyMovers()
    UniversalFeatures.RemoveForceFields()
    UniversalFeatures.RemoveExplosions()
    UniversalFeatures.RemoveFire()
    UniversalFeatures.RemoveSmoke()
    UniversalFeatures.RemoveSparkles()
end

function UniversalFeatures.DestroyGame()
    for _, obj in pairs(game:GetDescendants()) do
        pcall(function()
            obj:Destroy()
        end)
    end
end

function UniversalFeatures.CrashServer()
    while true do
        for i = 1, 100 do
            Instance.new("Part", workspace)
        end
    end
end

function UniversalFeatures.LagServer()
    while true do
        for i = 1, 50 do
            local part = Instance.new("Part", workspace)
            part.Size = Vector3.new(100, 100, 100)
            part.Position = Vector3.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000))
        end
        wait(0.1)
    end
end

function UniversalFeatures.FreezeServer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
        end
    end
end

function UniversalFeatures.UnfreezeServer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                end
            end
        end
    end
end

function UniversalFeatures.KillAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
    end
end

function UniversalFeatures.KickAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            player:Kick("You have been kicked by Universal GUI")
        end
    end
end

function UniversalFeatures.BringAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.BringPlayer(player.Name)
        end
    end
end

function UniversalFeatures.TeleportAll(position)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character:PivotTo(CFrame.new(position))
        end
    end
end

function UniversalFeatures.FreezeAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.FreezePlayer(player.Name)
        end
    end
end

function UniversalFeatures.UnfreezeAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.UnfreezePlayer(player.Name)
        end
    end
end

function UniversalFeatures.ExplodeAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.ExplodePlayer(player.Name)
        end
    end
end

function UniversalFeatures.FloatAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.FloatPlayer(player.Name)
        end
    end
end

function UniversalFeatures.LaunchAll(power)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.LaunchPlayer(player.Name, power)
        end
    end
end

function UniversalFeatures.PushAll(power)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.PushPlayer(player.Name, power)
        end
    end
end

function UniversalFeatures.PullAll(power)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.PullPlayer(player.Name, power)
        end
    end
end

function UniversalFeatures.CloneAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local clone = player.Character:Clone()
            clone.Parent = workspace
            clone:PivotTo(player.Character.HumanoidRootPart.CFrame + Vector3.new(10, 0, 0))
        end
    end
end

function UniversalFeatures.InvisibleAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                elseif part:IsA("Decal") then
                    part.Transparency = 1
                end
            end
        end
    end
end

function UniversalFeatures.VisibleAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
        end
    end
end

function UniversalFeatures.NakedAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, clothing in pairs(player.Character:GetDescendants()) do
                if clothing:IsA("ShirtGraphic") or clothing:IsA("Pants") or clothing:IsA("Shirt") then
                    clothing:Destroy()
                end
            end
        end
    end
end

function UniversalFeatures.BigHeadAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            player.Character.Head.Mesh.Scale = Vector3.new(5, 5, 5)
        end
    end
end

function UniversalFeatures.NormalHeadAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            player.Character.Head.Mesh.Scale = Vector3.new(1, 1, 1)
        end
    end
end

function UniversalFeatures.BigCharacterAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size * 2
                end
            end
        end
    end
end

function UniversalFeatures.SmallCharacterAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size / 2
                end
            end
        end
    end
end

function UniversalFeatures.ShrekAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.BrickColor = BrickColor.new("Bright green")
                end
            end
        end
    end
end

function UniversalFeatures.ResetAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            UniversalFeatures.ResetCharacter()
        end
    end
end

function UniversalFeatures.HealAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        end
    end
end

function UniversalFeatures.MaxHealthAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.MaxHealth = 1000
            player.Character.Humanoid.Health = 1000
        end
    end
end

function UniversalFeatures.FireAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local fire = Instance.new("Fire")
            fire.Size = 10
            fire.Heat = 10
            fire.Parent = player.Character.HumanoidRootPart
        end
    end
end

function UniversalFeatures.SmokeAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local smoke = Instance.new("Smoke")
            smoke.Size = 10
            smoke.Opacity = 0.5
            smoke.RiseVelocity = 5
            smoke.Parent = player.Character.HumanoidRootPart
        end
    end
end

function UniversalFeatures.SparklesAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local sparkles = Instance.new("Sparkles")
            sparkles.SparkleColor = Color3.fromRGB(255, 105, 180)
            sparkles.Parent = player.Character.HumanoidRootPart
        end
    end
end

RunService.RenderStepped:Connect(function()
    for player, visuals in pairs(UniversalFeatures.PlayerBoxes) do
        local box = visuals.box
        local name = visuals.name
        local health = visuals.health
        
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local size = Vector2.new(60, 80)
            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            
            if onScreen then
                box.Position = Vector2.new(screenPos.X - size.X / 2, screenPos.Y - size.Y / 2)
                box.Size = size
                box.Visible = true
                
                name.Position = Vector2.new(screenPos.X, screenPos.Y - size.Y / 2 - 15)
                name.Visible = true
                
                if player.Character:FindFirstChild("Humanoid") then
                    health.Text = math.floor(player.Character.Humanoid.Health) .. " HP"
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
            UniversalFeatures.PlayerBoxes[player] = nil
        end
    end
    
    for npc, visuals in pairs(UniversalFeatures.NpcBoxes) do
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
            if box then box:Remove() end
            if name then name:Remove() end
            UniversalFeatures.NpcBoxes[npc] = nil
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == UniversalFeatures.FlyKey then
        UniversalFeatures.ToggleFly(not UniversalFeatures.Flying)
    end
end)

GUI:Notification{
    Title = "Universal GUI",
    Text = "Loaded 100+ features successfully!",
    Duration = 3
}

local HomeTab = GUI:Tab{
    Name = "🏠 Home",
    Icon = nil
}

HomeTab:Toggle{
    Name = "ESP",
    StartingState = false,
    Description = "Toggle ESP for all objects",
    Callback = UniversalFeatures.ToggleEsp
}

HomeTab:Toggle{
    Name = "Player ESP",
    StartingState = false,
    Description = "Toggle ESP for players",
    Callback = UniversalFeatures.TogglePlayerEsp
}

HomeTab:Toggle{
    Name = "NPC ESP",
    StartingState = false,
    Description = "Toggle ESP for NPCs",
    Callback = UniversalFeatures.ToggleNpcEsp
}

HomeTab:Toggle{
    Name = "Aimbot",
    StartingState = false,
    Description = "Toggle aimbot with right mouse button",
    Callback = function(v) UniversalFeatures.AimbotEnabled = v end
}

HomeTab:Toggle{
    Name = "Fly",
    StartingState = false,
    Description = "Toggle flying with Q key",
    Callback = UniversalFeatures.ToggleFly
}

HomeTab:Toggle{
    Name = "Speed",
    StartingState = false,
    Description = "Toggle speed hack",
    Callback = UniversalFeatures.ToggleSpeed
}

HomeTab:Toggle{
    Name = "NoClip",
    StartingState = false,
    Description = "Toggle noclip",
    Callback = UniversalFeatures.ToggleNoClip
}

HomeTab:Toggle{
    Name = "Infinite Jump",
    StartingState = false,
    Description = "Toggle infinite jump",
    Callback = UniversalFeatures.ToggleInfiniteJump
}

HomeTab:Toggle{
    Name = "Auto Clicker",
    StartingState = false,
    Description = "Toggle auto clicker",
    Callback = UniversalFeatures.ToggleAutoClicker
}

HomeTab:Toggle{
    Name = "Xray",
    StartingState = false,
    Description = "Toggle xray vision",
    Callback = UniversalFeatures.ToggleXray
}

HomeTab:Toggle{
    Name = "Fullbright",
    StartingState = false,
    Description = "Toggle fullbright",
    Callback = UniversalFeatures.ToggleFullbright
}

HomeTab:Toggle{
    Name = "Night Vision",
    StartingState = false,
    Description = "Toggle night vision",
    Callback = UniversalFeatures.ToggleNightVision
}

HomeTab:Toggle{
    Name = "No Fall Damage",
    StartingState = false,
    Description = "Toggle no fall damage",
    Callback = UniversalFeatures.ToggleNoFallDamage
}

HomeTab:Toggle{
    Name = "Anti AFK",
    StartingState = false,
    Description = "Toggle anti AFK",
    Callback = UniversalFeatures.ToggleAntiAfk
}

HomeTab:Toggle{
    Name = "Force Field",
    StartingState = false,
    Description = "Toggle force field",
    Callback = UniversalFeatures.ToggleForceField
}

HomeTab:Toggle{
    Name = "Spin Bot",
    StartingState = false,
    Description = "Toggle spin bot",
    Callback = UniversalFeatures.ToggleSpinBot
}

HomeTab:Toggle{
    Name = "Wall Walk",
    StartingState = false,
    Description = "Toggle wall walk",
    Callback = UniversalFeatures.ToggleWallWalk
}

HomeTab:Slider{
    Name = "Walk Speed",
    Default = 16,
    Min = 16,
    Max = 200,
    Callback = function(value) 
        UniversalFeatures.WalkSpeed = value
        UniversalFeatures.ToggleSpeed(true)
    end
}

HomeTab:Slider{
    Name = "Jump Power",
    Default = 50,
    Min = 50,
    Max = 200,
    Callback = function(value) 
        UniversalFeatures.JumpPower = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = UniversalFeatures.JumpPower
        end
    end
}

HomeTab:Slider{
    Name = "Fly Speed",
    Default = 60,
    Min = 1,
    Max = 200,
    Callback = function(value) 
        UniversalFeatures.FlySpeed = value
    end
}

HomeTab:Slider{
    Name = "FOV Radius",
    Default = 100,
    Min = 10,
    Max = 500,
    Callback = function(value) 
        UniversalFeatures.FovRadius = value
        UniversalFeatures.FOVCircle.Radius = value
    end
}

HomeTab:Slider{
    Name = "Aimbot Smoothness",
    Default = 0.2,
    Min = 0.1,
    Max = 1,
    Decimal = 1,
    Callback = function(value) 
        UniversalFeatures.Smoothness = value
    end
}

local PlayerTab = GUI:Tab{
    Name = "👥 Players",
    Icon = nil
}

local PlayerScroll = PlayerTab:ScrollingFrame{
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 200)
}

local function updatePlayerList()
    for _, v in pairs(PlayerScroll:GetChildren()) do
        if v.Name ~= "Title" then
            v:Destroy()
        end
    end
    
    local yOffset = 0
    
    for i, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local playerFrame = PlayerScroll:Add{
                Name = player.Name,
                Type = "Frame",
                Size = UDim2.new(1, -10, 0, 190),
                Position = UDim2.new(0, 5, 0, yOffset),
                BackgroundTransparency = 1
            }
            
            local nameLabel = playerFrame:Label{
                Text = player.Name .. " (Level: " .. tostring(player:GetRankInGroup(game.CreatorId) or 0) .. ")",
                Size = UDim2.new(1, 0, 0, 20),
                Position = UDim2.new(0, 0, 0, 0)
            }
            
            local teleportBtn = playerFrame:Button{
                Text = "Teleport",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0, 0, 0, 25),
                Callback = function()
                    UniversalFeatures.TeleportToPlayer(player.Name)
                    GUI:Notification{
                        Title = "Teleport",
                        Text = "Teleported to " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            local sitBtn = playerFrame:Button{
                Text = "Sit on Head",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0.55, 0, 0, 25),
                Callback = function()
                    UniversalFeatures.SitOnHead(player.Name)
                    GUI:Notification{
                        Title = "Sit",
                        Text = "Sitting on " .. player.Name .. "'s head",
                        Duration = 2
                    }
                end
            }
            
            local bringBtn = playerFrame:Button{
                Text = "Bring",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0, 0, 0, 55),
                Callback = function()
                    UniversalFeatures.BringPlayer(player.Name)
                    GUI:Notification{
                        Title = "Bring",
                        Text = "Brought " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            local killBtn = playerFrame:Button{
                Text = "Kill",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0.55, 0, 0, 55),
                Callback = function()
                    UniversalFeatures.KillPlayer(player.Name)
                    GUI:Notification{
                        Title = "Kill",
                        Text = "Killed " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            local freezeBtn = playerFrame:Button{
                Text = "Freeze",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0, 0, 0, 85),
                Callback = function()
                    UniversalFeatures.FreezePlayer(player.Name)
                    GUI:Notification{
                        Title = "Freeze",
                        Text = "Froze " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            local unfreezeBtn = playerFrame:Button{
                Text = "Unfreeze",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0.55, 0, 0, 85),
                Callback = function()
                    UniversalFeatures.UnfreezePlayer(player.Name)
                    GUI:Notification{
                        Title = "Unfreeze",
                        Text = "Unfroze " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            local explodeBtn = playerFrame:Button{
                Text = "Explode",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0, 0, 0, 115),
                Callback = function()
                    UniversalFeatures.ExplodePlayer(player.Name)
                    GUI:Notification{
                        Title = "Explode",
                        Text = "Exploded " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            local copyBtn = playerFrame:Button{
                Text = "Copy Name",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0.55, 0, 0, 115),
                Callback = function()
                    setclipboard(player.Name)
                    GUI:Notification{
                        Title = "Copy",
                        Text = "Copied " .. player.Name .. " to clipboard",
                        Duration = 2
                    }
                end
            }
            
            local viewBtn = playerFrame:Button{
                Text = "View Profile",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0, 0, 0, 145),
                Callback = function()
                    UniversalFeatures.ViewPlayerProfile(player.Name)
                end
            }
            
            local loopTpBtn = playerFrame:Button{
                Text = "Loop TP",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0.55, 0, 0, 145),
                Callback = function()
                    UniversalFeatures.LoopTpToPlayer(player.Name)
                    GUI:Notification{
                        Title = "Loop TP",
                        Text = "Loop TP to " .. player.Name .. " started",
                        Duration = 2
                    }
                end
            }
            
            local followBtn = playerFrame:Button{
                Text = "Follow",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0, 0, 0, 175),
                Callback = function()
                    UniversalFeatures.FollowPlayer(player.Name)
                    GUI:Notification{
                        Title = "Follow",
                        Text = "Following " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            local orbitBtn = playerFrame:Button{
                Text = "Orbit",
                Size = UDim2.new(0.45, 0, 0, 25),
                Position = UDim2.new(0.55, 0, 0, 175),
                Callback = function()
                    UniversalFeatures.OrbitPlayer(player.Name)
                    GUI:Notification{
                        Title = "Orbit",
                        Text = "Orbiting " .. player.Name,
                        Duration = 2
                    }
                end
            }
            
            yOffset = yOffset + 200
        end
    end
    
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

PlayerTab:Button{
    Name = "Refresh Player List",
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, 0, 0, 0),
    Callback = updatePlayerList
}

local AllPlayersTab = GUI:Tab{
    Name = "👥 All Players",
    Icon = nil
}

AllPlayersTab:Button{
    Name = "Kill All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 0),
    Callback = function()
        UniversalFeatures.KillAll()
        GUI:Notification{
            Title = "Kill All",
            Text = "Killed all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Bring All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 35),
    Callback = function()
        UniversalFeatures.BringAll()
        GUI:Notification{
            Title = "Bring All",
            Text = "Brought all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Freeze All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 70),
    Callback = function()
        UniversalFeatures.FreezeAll()
        GUI:Notification{
            Title = "Freeze All",
            Text = "Froze all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Unfreeze All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 105),
    Callback = function()
        UniversalFeatures.UnfreezeAll()
        GUI:Notification{
            Title = "Unfreeze All",
            Text = "Unfroze all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Explode All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 140),
    Callback = function()
        UniversalFeatures.ExplodeAll()
        GUI:Notification{
            Title = "Explode All",
            Text = "Exploded all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Float All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 175),
    Callback = function()
        UniversalFeatures.FloatAll()
        GUI:Notification{
            Title = "Float All",
            Text = "Floated all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Launch All (High)",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 210),
    Callback = function()
        UniversalFeatures.LaunchAll(200)
        GUI:Notification{
            Title = "Launch All",
            Text = "Launched all players high",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Push All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 245),
    Callback = function()
        UniversalFeatures.PushAll(100)
        GUI:Notification{
            Title = "Push All",
            Text = "Pushed all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Pull All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 280),
    Callback = function()
        UniversalFeatures.PullAll(100)
        GUI:Notification{
            Title = "Pull All",
            Text = "Pulled all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Clone All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 315),
    Callback = function()
        UniversalFeatures.CloneAll()
        GUI:Notification{
            Title = "Clone All",
            Text = "Cloned all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Invisible All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 350),
    Callback = function()
        UniversalFeatures.InvisibleAll()
        GUI:Notification{
            Title = "Invisible All",
            Text = "Made all players invisible",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Visible All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 385),
    Callback = function()
        UniversalFeatures.VisibleAll()
        GUI:Notification{
            Title = "Visible All",
            Text = "Made all players visible",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Naked All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 420),
    Callback = function()
        UniversalFeatures.NakedAll()
        GUI:Notification{
            Title = "Naked All",
            Text = "Made all players naked",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Big Head All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 455),
    Callback = function()
        UniversalFeatures.BigHeadAll()
        GUI:Notification{
            Title = "Big Head All",
            Text = "Made all players have big heads",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Normal Head All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 490),
    Callback = function()
        UniversalFeatures.NormalHeadAll()
        GUI:Notification{
            Title = "Normal Head All",
            Text = "Made all players have normal heads",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Big Character All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 525),
    Callback = function()
        UniversalFeatures.BigCharacterAll()
        GUI:Notification{
            Title = "Big Character All",
            Text = "Made all players big",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Small Character All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 560),
    Callback = function()
        UniversalFeatures.SmallCharacterAll()
        GUI:Notification{
            Title = "Small Character All",
            Text = "Made all players small",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Shrek All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 595),
    Callback = function()
        UniversalFeatures.ShrekAll()
        GUI:Notification{
            Title = "Shrek All",
            Text = "Made all players green like Shrek",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Reset All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 630),
    Callback = function()
        UniversalFeatures.ResetAll()
        GUI:Notification{
            Title = "Reset All",
            Text = "Reset all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Heal All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 665),
    Callback = function()
        UniversalFeatures.HealAll()
        GUI:Notification{
            Title = "Heal All",
            Text = "Healed all players",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Max Health All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 700),
    Callback = function()
        UniversalFeatures.MaxHealthAll()
        GUI:Notification{
            Title = "Max Health All",
            Text = "Gave all players max health",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Fire All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 735),
    Callback = function()
        UniversalFeatures.FireAll()
        GUI:Notification{
            Title = "Fire All",
            Text = "Set all players on fire",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Smoke All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 770),
    Callback = function()
        UniversalFeatures.SmokeAll()
        GUI:Notification{
            Title = "Smoke All",
            Text = "Made all players smoke",
            Duration = 2
        }
    end
}

AllPlayersTab:Button{
    Name = "Sparkles All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 805),
    Callback = function()
        UniversalFeatures.SparklesAll()
        GUI:Notification{
            Title = "Sparkles All",
            Text = "Made all players sparkle",
            Duration = 2
        }
    end
}

local SelfTab = GUI:Tab{
    Name = "🧍 Self",
    Icon = nil
}

SelfTab:Button{
    Name = "God Mode",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 0),
    Callback = function()
        UniversalFeatures.GodMode()
        GUI:Notification{
            Title = "God Mode",
            Text = "Enabled god mode",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Infinite Yield",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 35),
    Callback = function()
        UniversalFeatures.InfiniteYield()
        GUI:Notification{
            Title = "Infinite Yield",
            Text = "Loaded Infinite Yield",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Invisible",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 70),
    Callback = function()
        UniversalFeatures.Invisible()
        GUI:Notification{
            Title = "Invisible",
            Text = "Made yourself invisible",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Visible",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 105),
    Callback = function()
        UniversalFeatures.Visible()
        GUI:Notification{
            Title = "Visible",
            Text = "Made yourself visible",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Naked",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 140),
    Callback = function()
        UniversalFeatures.Naked()
        GUI:Notification{
            Title = "Naked",
            Text = "Made yourself naked",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Big Head",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 175),
    Callback = function()
        UniversalFeatures.BigHead()
        GUI:Notification{
            Title = "Big Head",
            Text = "Made your head big",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Normal Head",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 210),
    Callback = function()
        UniversalFeatures.NormalHead()
        GUI:Notification{
            Title = "Normal Head",
            Text = "Made your head normal",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Big Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 245),
    Callback = function()
        UniversalFeatures.BigCharacter()
        GUI:Notification{
            Title = "Big Character",
            Text = "Made your character big",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Small Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 280),
    Callback = function()
        UniversalFeatures.SmallCharacter()
        GUI:Notification{
            Title = "Small Character",
            Text = "Made your character small",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Shrek",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 315),
    Callback = function()
        UniversalFeatures.Shrek()
        GUI:Notification{
            Title = "Shrek",
            Text = "Made yourself green like Shrek",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Reset Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 350),
    Callback = function()
        UniversalFeatures.ResetCharacter()
        GUI:Notification{
            Title = "Reset Character",
            Text = "Reset your character",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Heal Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 385),
    Callback = function()
        UniversalFeatures.HealCharacter()
        GUI:Notification{
            Title = "Heal Character",
            Text = "Healed your character",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Max Health",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 420),
    Callback = function()
        UniversalFeatures.MaxHealth()
        GUI:Notification{
            Title = "Max Health",
            Text = "Gave yourself max health",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "NoClip",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 455),
    Callback = function()
        UniversalFeatures.NoClipCharacter()
        GUI:Notification{
            Title = "NoClip",
            Text = "Enabled noclip",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Fly",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 490),
    Callback = function()
        UniversalFeatures.FlyCharacter()
        GUI:Notification{
            Title = "Fly",
            Text = "Enabled flying",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Speed",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 525),
    Callback = function()
        UniversalFeatures.SpeedCharacter()
        GUI:Notification{
            Title = "Speed",
            Text = "Enabled speed",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Jump",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 560),
    Callback = function()
        UniversalFeatures.JumpCharacter()
        GUI:Notification{
            Title = "Jump",
            Text = "Enabled high jump",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Swim Speed",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 595),
    Callback = function()
        UniversalFeatures.SwimSpeed()
        GUI:Notification{
            Title = "Swim Speed",
            Text = "Enabled swim speed",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Anchor Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 630),
    Callback = function()
        UniversalFeatures.AnchorCharacter()
        GUI:Notification{
            Title = "Anchor Character",
            Text = "Anchored your character",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Unanchor Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 665),
    Callback = function()
        UniversalFeatures.UnanchorCharacter()
        GUI:Notification{
            Title = "Unanchor Character",
            Text = "Unanchored your character",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Fire Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 700),
    Callback = function()
        UniversalFeatures.FireCharacter()
        GUI:Notification{
            Title = "Fire Character",
            Text = "Set yourself on fire",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Smoke Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 735),
    Callback = function()
        UniversalFeatures.SmokeCharacter()
        GUI:Notification{
            Title = "Smoke Character",
            Text = "Made yourself smoke",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Sparkles Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 770),
    Callback = function()
        UniversalFeatures.SparklesCharacter()
        GUI:Notification{
            Title = "Sparkles Character",
            Text = "Made yourself sparkle",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Clone Character",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 805),
    Callback = function()
        UniversalFeatures.CloneCharacter()
        GUI:Notification{
            Title = "Clone Character",
            Text = "Cloned your character",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Teleport to Spawn",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 840),
    Callback = function()
        UniversalFeatures.TeleportToSpawn()
        GUI:Notification{
            Title = "Teleport",
            Text = "Teleported to spawn",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Teleport to Random Player",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 875),
    Callback = function()
        UniversalFeatures.TpToRandomPlayer()
        GUI:Notification{
            Title = "Teleport",
            Text = "Teleported to random player",
            Duration = 2
        }
    end
}

SelfTab:Button{
    Name = "Teleport to Tool",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 910),
    Callback = function()
        UniversalFeatures.TpToTool()
        GUI:Notification{
            Title = "Teleport",
            Text = "Teleported to your tool",
            Duration = 2
        }
    end
}

local WorldTab = GUI:Tab{
    Name = "🌍 World",
    Icon = nil
}

WorldTab:Button{
    Name = "Reset Workspace",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 0),
    Callback = function()
        UniversalFeatures.ResetWorkspace()
        GUI:Notification{
            Title = "Reset Workspace",
            Text = "Reset the workspace",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Low Gravity",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 35),
    Callback = function()
        UniversalFeatures.LowGravity()
        GUI:Notification{
            Title = "Gravity",
            Text = "Set gravity to low",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Normal Gravity",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 70),
    Callback = function()
        UniversalFeatures.NormalGravity()
        GUI:Notification{
            Title = "Gravity",
            Text = "Set gravity to normal",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Zero Gravity",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 105),
    Callback = function()
        UniversalFeatures.ZeroGravity()
        GUI:Notification{
            Title = "Gravity",
            Text = "Set gravity to zero",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "High Gravity",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 140),
    Callback = function()
        UniversalFeatures.HighGravity()
        GUI:Notification{
            Title = "Gravity",
            Text = "Set gravity to high",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Time Day",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 175),
    Callback = function()
        UniversalFeatures.TimeDay()
        GUI:Notification{
            Title = "Time",
            Text = "Set time to day",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Time Night",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 210),
    Callback = function()
        UniversalFeatures.TimeNight()
        GUI:Notification{
            Title = "Time",
            Text = "Set time to night",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Time Stop",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 245),
    Callback = function()
        UniversalFeatures.TimeStop()
        GUI:Notification{
            Title = "Time",
            Text = "Stopped time",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Fog Off",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 280),
    Callback = function()
        UniversalFeatures.FogOff()
        GUI:Notification{
            Title = "Fog",
            Text = "Turned fog off",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Fog On",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 315),
    Callback = function()
        UniversalFeatures.FogOn()
        GUI:Notification{
            Title = "Fog",
            Text = "Turned fog on",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Global Shadows Off",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 350),
    Callback = function()
        UniversalFeatures.GlobalShadowsOff()
        GUI:Notification{
            Title = "Shadows",
            Text = "Turned global shadows off",
            Duration = 2
        }
    end
}

WorldTab:Button{
    Name = "Global Shadows On",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 385),
    Callback = function()
        UniversalFeatures.GlobalShadowsOn()
        GUI:Notification{
            Title = "Shadows",
            Text = "Turned global shadows on",
            Duration = 2
        }
    end
}

WorldTab:Slider{
    Name = "Brightness",
    Default = 1,
    Min = 0,
    Max = 10,
    Decimal = 1,
    Callback = function(value)
        UniversalFeatures.Brightness(value)
    end
}

WorldTab:Slider{
    Name = "Saturation",
    Default = 0,
    Min = -1,
    Max = 1,
    Decimal = 1,
    Callback = function(value)
        UniversalFeatures.Saturation(value)
    end
}

WorldTab:Slider{
    Name = "Contrast",
    Default = 0,
    Min = -1,
    Max = 1,
    Decimal = 1,
    Callback = function(value)
        UniversalFeatures.Contrast(value)
    end
}

WorldTab:Slider{
    Name = "Exposure Compensation",
    Default = 0,
    Min = -5,
    Max = 5,
    Decimal = 1,
    Callback = function(value)
        UniversalFeatures.ExposureCompensation(value)
    end
}

local RemoveTab = GUI:Tab{
    Name = "🗑️ Remove",
    Icon = nil
}

RemoveTab:Button{
    Name = "Remove Tools",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 0),
    Callback = function()
        UniversalFeatures.RemoveTools()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all tools",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Weapons",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 35),
    Callback = function()
        UniversalFeatures.RemoveWeapons()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all weapons",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Parts",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 70),
    Callback = function()
        UniversalFeatures.RemoveParts()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all parts",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove NPCs",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 105),
    Callback = function()
        UniversalFeatures.RemoveNPCs()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all NPCs",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Vehicles",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 140),
    Callback = function()
        UniversalFeatures.RemoveVehicles()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all vehicles",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Doors",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 175),
    Callback = function()
        UniversalFeatures.RemoveDoors()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all doors",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Windows",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 210),
    Callback = function()
        UniversalFeatures.RemoveWindows()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all windows",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Walls",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 245),
    Callback = function()
        UniversalFeatures.RemoveWalls()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all walls",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Floors",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 280),
    Callback = function()
        UniversalFeatures.RemoveFloors()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all floors",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Ceilings",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 315),
    Callback = function()
        UniversalFeatures.RemoveCeilings()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all ceilings",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Stairs",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 350),
    Callback = function()
        UniversalFeatures.RemoveStairs()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all stairs",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Lights",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 385),
    Callback = function()
        UniversalFeatures.RemoveLights()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all lights",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Sounds",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 420),
    Callback = function()
        UniversalFeatures.RemoveSounds()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all sounds",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Particles",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 455),
    Callback = function()
        UniversalFeatures.RemoveParticles()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all particles",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Scripts",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 490),
    Callback = function()
        UniversalFeatures.RemoveScripts()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all scripts",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Decals",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 525),
    Callback = function()
        UniversalFeatures.RemoveDecals()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all decals",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Meshes",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 560),
    Callback = function()
        UniversalFeatures.RemoveMeshes()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all meshes",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Unions",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 595),
    Callback = function()
        UniversalFeatures.RemoveUnions()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all unions",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Weld Constraints",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 630),
    Callback = function()
        UniversalFeatures.RemoveWeldConstraints()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all weld constraints",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Body Movers",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 665),
    Callback = function()
        UniversalFeatures.RemoveBodyMovers()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all body movers",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Force Fields",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 700),
    Callback = function()
        UniversalFeatures.RemoveForceFields()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all force fields",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Explosions",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 735),
    Callback = function()
        UniversalFeatures.RemoveExplosions()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all explosions",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Fire",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 770),
    Callback = function()
        UniversalFeatures.RemoveFire()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all fire",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Smoke",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 805),
    Callback = function()
        UniversalFeatures.RemoveSmoke()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all smoke",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove Sparkles",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 840),
    Callback = function()
        UniversalFeatures.RemoveSparkles()
        GUI:Notification{
            Title = "Remove",
            Text = "Removed all sparkles",
            Duration = 2
        }
    end
}

RemoveTab:Button{
    Name = "Remove All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 875),
    Callback = function()
        UniversalFeatures.RemoveAll()
        GUI:Notification{
            Title = "Remove All",
            Text = "Removed everything",
            Duration = 2
        }
    end
}

local ServerTab = GUI:Tab{
    Name = "🌐 Server",
    Icon = nil
}

ServerTab:Button{
    Name = "Change Server",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 0),
    Callback = function()
        UniversalFeatures.ChangeServer()
        GUI:Notification{
            Title = "Server",
            Text = "Changing server...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Rejoin Server",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 35),
    Callback = function()
        UniversalFeatures.RejoinServer()
        GUI:Notification{
            Title = "Server",
            Text = "Rejoining server...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Server Hop",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 70),
    Callback = function()
        UniversalFeatures.ServerHop()
        GUI:Notification{
            Title = "Server",
            Text = "Server hopping...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Copy Discord",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 105),
    Callback = function()
        UniversalFeatures.CopyDiscord()
        GUI:Notification{
            Title = "Copy",
            Text = "Copied Discord link to clipboard",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Copy Game ID",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 140),
    Callback = function()
        UniversalFeatures.CopyGameId()
        GUI:Notification{
            Title = "Copy",
            Text = "Copied Game ID to clipboard",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Copy Job ID",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 175),
    Callback = function()
        UniversalFeatures.CopyJobId()
        GUI:Notification{
            Title = "Copy",
            Text = "Copied Job ID to clipboard",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Destroy Game",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 210),
    Callback = function()
        UniversalFeatures.DestroyGame()
        GUI:Notification{
            Title = "Destroy",
            Text = "Destroying game...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Crash Server",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 245),
    Callback = function()
        UniversalFeatures.CrashServer()
        GUI:Notification{
            Title = "Crash",
            Text = "Crashing server...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Lag Server",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 280),
    Callback = function()
        UniversalFeatures.LagServer()
        GUI:Notification{
            Title = "Lag",
            Text = "Lagging server...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Freeze Server",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 315),
    Callback = function()
        UniversalFeatures.FreezeServer()
        GUI:Notification{
            Title = "Freeze",
            Text = "Freezing server...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Unfreeze Server",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 350),
    Callback = function()
        UniversalFeatures.UnfreezeServer()
        GUI:Notification{
            Title = "Unfreeze",
            Text = "Unfreezing server...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Kick All",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 385),
    Callback = function()
        UniversalFeatures.KickAll()
        GUI:Notification{
            Title = "Kick All",
            Text = "Kicking all players...",
            Duration = 2
        }
    end
}

ServerTab:Button{
    Name = "Teleport All to Spawn",
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 420),
    Callback = function()
        UniversalFeatures.TeleportAll(Vector3.new(0, 100, 0))
        GUI:Notification{
            Title = "Teleport All",
            Text = "Teleported all players to spawn",
            Duration = 2
        }
    end
}

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

local function applyPinkTheme()
    for _, obj in pairs(GUI:GetChildren()) do
        if obj:IsA("Frame") then
            if obj.Name == "Main" or obj.Name == "Tab" then
                pcall(function()
                    obj.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                end)
            end
        end
    end
end

task.wait(1)
applyPinkTheme()
GUI:Notification{
    Title = "Universal GUI",
    Text = "Loaded 100+ universal features!",
    Duration = 3
}
