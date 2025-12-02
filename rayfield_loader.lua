-- Universal GUI - Rayfield Edition
-- Single line: loadstring(game:HttpGet('https://raw.githubusercontent.com/Cry0xene/UniversalGUI/main/rayfield_loader.lua'))()

print("🔄 Loading Universal GUI with Rayfield...")

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- First, let's load your main script
local mainScript = game:HttpGet('https://raw.githubusercontent.com/Cry0xene/UniversalGUI/main/main.lua')

-- Create a COMPATIBLE Mercury wrapper
local Mercury = {}
Mercury.Themes = {
    Dark = "Dark",
    Light = "Light"
}

-- Create the main window
function Mercury:Create(options)
    local window = Rayfield:CreateWindow({
        Name = options.Name or "Universal GUI",
        LoadingTitle = "Universal GUI",
        LoadingSubtitle = "Loading 100+ features...",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "UniversalGUI",
            FileName = "Settings"
        },
        Theme = options.Theme == "Dark" and "Dark" or "Light",
        Discord = {
            Enabled = false
        },
        KeySystem = false
    })
    
    -- Add Mercury-compatible methods
    function window:Tab(tabOptions)
        -- Handle both string and table input
        if type(tabOptions) == "string" then
            return window:CreateTab(tabOptions, nil)
        else
            return window:CreateTab(tabOptions.Name or "Tab", tabOptions.Icon)
        end
    end
    
    function window:ScrollingFrame(options)
        -- Return a dummy scrolling frame
        return {
            Size = options.Size or UDim2.new(1, 0, 1, 0),
            CanvasSize = options.CanvasSize or UDim2.new(0, 0, 0, 0),
            Add = function(self, childOptions)
                -- Handle different element types
                if childOptions.Type == "Frame" then
                    local frame = {
                        BackgroundTransparency = childOptions.BackgroundTransparency or 0,
                        Size = childOptions.Size or UDim2.new(1, 0, 1, 0),
                        Position = childOptions.Position or UDim2.new(0, 0, 0, 0),
                        LayoutOrder = childOptions.LayoutOrder or 1
                    }
                    
                    function frame:Label(labelOptions)
                        return {
                            Text = labelOptions.Text or "",
                            Size = labelOptions.Size or UDim2.new(1, 0, 1, 0),
                            Position = labelOptions.Position or UDim2.new(0, 0, 0, 0)
                        }
                    end
                    
                    function frame:Button(buttonOptions)
                        local btn = {
                            Text = buttonOptions.Text or "Button",
                            Size = buttonOptions.Size or UDim2.new(1, 0, 1, 0),
                            Position = buttonOptions.Position or UDim2.new(0, 0, 0, 0),
                            Callback = buttonOptions.Callback or function() end
                        }
                        return btn
                    end
                    
                    return frame
                end
                return {}
            end
        }
    end
    
    function window:Notification(notifOptions)
        Rayfield:Notify({
            Title = notifOptions.Title or "Notification",
            Content = notifOptions.Text or "",
            Duration = notifOptions.Duration or 3,
            Image = nil
        })
    end
    
    return window
end

-- Set global variables BEFORE executing main script
_G.UniversalGUI = Mercury

-- Now execute the main script
local success, err = pcall(function()
    loadstring(mainScript)()
end)

if success then
    Rayfield:Notify({
        Title = "✅ Success!",
        Content = "Universal GUI loaded with 100+ features!",
        Duration = 5
    })
    print("✅ Universal GUI loaded successfully!")
else
    warn("❌ Universal GUI failed to load:", err)
    Rayfield:Notify({
        Title = "❌ Error",
        Content = "Failed to load: " .. tostring(err),
        Duration = 5
    })
end
