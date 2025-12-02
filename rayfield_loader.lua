-- Rayfield Loader for Universal GUI
-- Single line: loadstring(game:HttpGet('https://raw.githubusercontent.com/Cry0xene/UniversalGUI/main/rayfield_loader.lua'))()

print("Universal GUI - Loading with Rayfield interface...")

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create a fake Mercury library for compatibility
local fakeMercury = {}

-- Add themes
fakeMercury.Themes = {
    Dark = "Dark",
    Light = "Light"
}

-- Create a Create function that works with Rayfield
function fakeMercury:Create(options)
    -- Actually create Rayfield window
    local window = Rayfield:CreateWindow({
        Name = options.Name or "Universal GUI",
        LoadingTitle = "Universal GUI",
        LoadingSubtitle = "Loading 100+ features...",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "UniversalGUI",
            FileName = "Settings"
        },
        Theme = options.Theme == fakeMercury.Themes.Dark and "Dark" or "Light",
        Discord = {
            Enabled = false
        },
        KeySystem = false
    })
    
    -- Store original window for method overriding
    local originalWindow = window
    
    -- Create a wrapper with Mercury-like methods
    local wrappedWindow = {}
    
    -- Tab creation
    function wrappedWindow:Tab(options)
        if type(options) == "table" then
            return originalWindow:CreateTab(options.Name or "Tab", options.Icon)
        else
            return originalWindow:CreateTab(options, nil)
        end
    end
    
    -- For compatibility with :CreateTab syntax too
    wrappedWindow.CreateTab = wrappedWindow.Tab
    
    -- ScrollingFrame for tabs
    function wrappedWindow:ScrollingFrame(options)
        -- Rayfield doesn't have direct ScrollingFrame, so we'll skip this
        -- The main script will handle this differently
        return {
            Add = function(self, child)
                return child
            end,
            CanvasSize = UDim2.new(0, 0, 0, 0)
        }
    end
    
    -- Notification
    function wrappedWindow:Notification(options)
        Rayfield:Notify({
            Title = options.Title or "Notification",
            Content = options.Text or "",
            Duration = options.Duration or 3,
            Image = nil
        })
    end
    
    return wrappedWindow
end

-- Set global variable before loading main script
UniversalGUI = fakeMercury

-- Now load your main script
local success, errorMessage = pcall(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Cry0xene/UniversalGUI/main/main.lua'))()
end)

if not success then
    warn("Failed to load Universal GUI:", errorMessage)
    Rayfield:Notify({
        Title = "Load Error",
        Content = "Failed to load script: " .. tostring(errorMessage),
        Duration = 5
    })
else
    Rayfield:Notify({
        Title = "Universal GUI",
        Content = "Successfully loaded 100+ features!",
        Duration = 3
    })
end
-- Now load the main script
loadstring(game:HttpGet('https://raw.githubusercontent.com/Cry0xene/UniversalGUI/main/main.lua'))()
