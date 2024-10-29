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
local prefixes = {
    "- Tp-Movement", "- Create Tp-Movement Toggle", "- Movement Speed", "- Fly Helper V1", "- Fly Helper V2", 
    "- Mob Godmode", "- Mob Godmode Helper", "- Anti Knockback", "- Collect", 
    "- Remove DamageIndicators", "- Attack Aura", "- Attack Speed | Default : 0.25", "- Mobs Limit", "- Attack Multiplier",
    "- Locate Mobs", "- Location Distance", "- Mob Filter | Write 'All' to select all", 
    "- Farm selected Mob", "- Farm Filter | Write 'All' to select all",
    "- Mobile Toggle", "- Kill Gui + Toggle Buttons", "- Anti Idle", "- Copy Discord Invite"
}
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
