local desccolorSuccess, desccolorValue = pcall(function()
    return loadstring(game:HttpGet("https://pastebin.com/raw/G7VYABUZ"))()
end)
local desccolorHex = desccolorSuccess and desccolorValue or "#FF6805"
local function hexToColor3(hex)
    return Color3.fromRGB(
        tonumber("0x" .. hex:sub(2, 3)),
        tonumber("0x" .. hex:sub(4, 5)),
        tonumber("0x" .. hex:sub(6, 7))
    )
end
local desccolor = hexToColor3(desccolorHex)
local tabFolder = game:GetService("CoreGui").ywxoscripts.Main.TabFolder
local function findTextLabelWithTextPrefix(parent, prefix)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("TextLabel") and child.Text:sub(1, #prefix) == prefix then
            return child
        elseif #child:GetChildren() > 0 then
            local result = findTextLabelWithTextPrefix(child, prefix)
            if result then return result end
        end
    end
    return nil
end

local gameIdToPrefixes = {
    [833209132] = { 
        "- Tp-Movement", "- Create Tp-Movement Toggle", "- Movement Speed  |  Default : 2", "- Fly Helper V1", "- Fly Helper V2", 
        "- Mob Godmode", "- Mob Godmode Helper", "- Anti Knockback", "- Collect", 
        "- Remove DamageIndicators", "- Attack Aura", "- Attack Cooldown | Default : 0.25", "- Max Attack Mobs Limit | Default : 2", "- Attack Multiplier",
        "- Locate Mobs", "- Location Distance", "- Mob Filter  |  Write 'All' to select all", 
        "- Farm selected Mob", "- Farm Filter  |  Write 'All' to select all",
        "- Mobile Toggle", "- Mobile Toggle Size", "- Button ImageTransparency", "- Kill Gui + Toggle Buttons", "- Anti Idle", "- Copy Discord Invite"
    },
    [5719123726] = { 
        "- ZoomDistance", "- Camera ZoomDistance", "- Fly", "- Select FlySpeed", "- WalkSpeed", "- Select WalkSpeed", 
        "- TP Walk", "- Select TP-WalkSpeed", "- Infinite Jump", "- Noclip", "- Sprinting", "- Select SprintSpeed", 
        "- Create Sprint Button", "- Smash", "- Rebirth", "- Gifts", "- Aura", "- Popups", "- Farm selected", 
        "- Test multiplier", "- Tests", "- Hatch selected", "- Eggs", "- Zone 1", "- Zone 2", "- Zone 3", "- Zone 4", 
        "- Zone 5", "- Zone 6", "- Zone 7", "- Zone 8", "- Mobile Toggle", "- Mobile Toggle Size", 
        "- Button ImageTransparency", "- Kill Gui + Toggle Buttons", "- Anti Idle", "- Copy Discord Invite"
     },
    [6475810089] = {
        "- ZoomDistance", "- Camera ZoomDistance", "- Fly", "- Select FlySpeed", "- WalkSpeed", "- Select WalkSpeed", "- TP Walk", "- Select TP-WalkSpeed", "- Infinite Jump", "- Noclip", "- Sprinting", "- Select SprintSpeed", "- Create Sprint Button",
        "- Train", "- Train Multiplier", "- Open Gacha", "- Gachas",
        "- Mobile Toggle", "- Mobile Toggle Size", "- Button ImageTransparency", "- Kill Gui + Toggle Buttons", "- Anti Idle", "- Copy Discord Invite"
    }
}
local currentGameId = game.GameId
local prefixes = gameIdToPrefixes[currentGameId] or {}

getgenv().DesignUpdater = false
local function applyTextFormatting()
    for _, prefix in ipairs(prefixes) do
        local foundTextLabel = findTextLabelWithTextPrefix(tabFolder, prefix)
        if foundTextLabel then
            local restText = foundTextLabel.Text:sub(#prefix + 1)
            foundTextLabel.RichText = true
            local originalFontSize = foundTextLabel.TextSize
            foundTextLabel.Text = string.format(
                '<b><font size="%d">%s</font></b><font size="%d" color="#%s" face="Jura">%s</font>',
                originalFontSize, prefix, originalFontSize - 1, desccolorHex:sub(2), restText
            )
        end
        task.wait()
    end
end

local function updateItemTextButtons(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("TextButton") and child.Name == "Item" then
            if child.Parent and child.Parent.Name == "DropItemHolder" then
                child.TextColor3 = desccolor
            end
        end
        
        if #child:GetChildren() > 0 then
            updateItemTextButtons(child)
        end
    end
end

if not getgenv().DesignUpdater then
    getgenv().DesignUpdater = true
    while getgenv().DesignUpdater do
        wait(0.25)
        applyTextFormatting()
        updateItemTextButtons(tabFolder)
    end
end
