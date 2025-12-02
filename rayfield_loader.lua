-- Rayfield Loader for Universal GUI
-- This will convert Mercury calls to Rayfield automatically

-- First, load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Store the original loadstring function
local originalLoadstring = loadstring

-- Override loadstring to intercept Mercury GUI creation
loadstring = function(code)
    -- Convert Mercury calls to Rayfield calls
    local modifiedCode = code
    
    -- Replace Mercury GUI creation
    modifiedCode = modifiedCode:gsub(
        'local UniversalGUI = loadstring%(game%.HttpGet%("https://raw%.githubusercontent%.com/deeeity/mercury%-lib/master/src%.lua"%))%(%)',
        '-- Mercury replaced with Rayfield'
    )
    
    modifiedCode = modifiedCode:gsub(
        'local GUI = UniversalGUI:Create{',
        'local GUI = Rayfield:CreateWindow{'
    )
    
    -- Replace Mercury tab creation
    modifiedCode = modifiedCode:gsub('GUI:Tab{', 'GUI:CreateTab(')
    modifiedCode = modifiedCode:gsub('Name = "([^"]+)",', '"%1",')
    modifiedCode = modifiedCode:gsub('Icon = nil', '')
    modifiedCode = modifiedCode:gsub('HomeTab:Toggle{', 'HomeTab:CreateToggle(')
    modifiedCode = modifiedCode:gsub('HomeTab:Button{', 'HomeTab:CreateButton(')
    modifiedCode = modifiedCode:gsub('HomeTab:Slider{', 'HomeTab:CreateSlider(')
    
    -- Execute modified code
    return originalLoadstring(modifiedCode)
end

-- Now load the main script
loadstring(game:HttpGet('https://raw.githubusercontent.com/Cry0xene/UniversalGUI/main/main.lua'))()
