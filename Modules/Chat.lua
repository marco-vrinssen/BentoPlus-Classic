-- Enable class colors in chat messages
SetCVar("chatClassColorOverride", "0")

local chatTypes = {
    "SAY", "EMOTE", "YELL", "GUILD", "OFFICER", "WHISPER",
    "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING",
    "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "VOICE_TEXT"
}

for _, v in ipairs(chatTypes) do
    SetChatColorNameByClass(v, true)
end

for i = 1, 50 do
    SetChatColorNameByClass("CHANNEL" .. i, true)
end




-- URL patterns for detecting and formatting clickable links
URL_PATTERNS = {
    "^(%a[%w+.-]+://%S+)", -- X://Y most urls
    "%f[%S](%a[%w+.-]+://%S+)",
    "^(www%.[-%w_%%]+%.(%a%a+)/%S+)", -- www.X.Y domain and path
    "%f[%S](www%.[-%w_%%]+%.(%a%a+)/%S+)",
    "^(www%.[-%w_%%]+%.(%a%a+))", -- www.X.Y domain
    "%f[%S](www%.[-%w_%%]+%.(%a%a+))",
    "(%S+@[%w_.-%%]+%.(%a%a+))", -- email addresses
    "^(https?://discord%.gg/%S*)", -- Discord-specific links
    "%f[%S](https?://discord%.gg/%S*)",
    "^(discord%.gg/%S*)",
    "%f[%S](discord%.gg/%S*)",
    "^(https?://twitch%.tv/%S*)", -- Twitch-specific links
    "%f[%S](https?://%twitch.tv/%S*)",
    "^(twitch%.tv/%S*)",
    "%f[%S](twitch%.tv/%S*)",
}

-- Function to format URLs as clickable links
function formatURL(url)
    return "|cff149bfd|Hurl:"..url.."|h["..url.."]|h|r "
end

-- Function to make URLs in chat messages clickable
function makeClickable(self, event, msg, ...)    
    for _, pattern in ipairs(URL_PATTERNS) do
        if string.find(msg, pattern) then
            msg = string.gsub(msg, pattern, formatURL("%1"))
        end
    end
    return false, msg, ...
end

-- Popup dialog for copying URLs
StaticPopupDialogs["CLICK_LINK_CLICKURL"] = {
    text = "Copy & Paste the link into your browser\n\nPress CTRL + C key to copy",
    button1 = "Close",
    OnAccept = function() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnShow = function (self, data)
        self.editBox:SetText(data.url)
        self.editBox:HighlightText()
    end,
    hasEditBox = true
}

-- Override the SetHyperlink function to handle URL links
local SetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link)
    if (string.sub(link, 1, 3) == "url") then
        local url = string.sub(link, 5)
        StaticPopup_Show("CLICK_LINK_CLICKURL", "", "", { url = url })
    else
        SetHyperlink(self, link)
    end
end

-- Add message event filters to make URLs clickable in chat messages
local CHAT_TYPES = {
    "AFK", "BATTLEGROUND_LEADER", "BATTLEGROUND", "BN_WHISPER", "BN_WHISPER_INFORM",
    "CHANNEL", "COMMUNITIES_CHANNEL", "DND", "EMOTE", "GUILD", "OFFICER",
    "PARTY_LEADER", "PARTY", "RAID_LEADER", "RAID_WARNING", "RAID",
    "SAY", "WHISPER", "WHISPER_INFORM", "YELL", "SYSTEM"
}

for _, type in ipairs(CHAT_TYPES) do
    ChatFrame_AddMessageEventFilter("CHAT_MSG_" .. type, makeClickable)
end




-- Function to setup the combat log tab
local function SetupCombatLogTab()
    ChatFrame2Tab:EnableMouse(false)
    ChatFrame2Tab:SetText(" ") -- Needs to be something for chat settings to function
    ChatFrame2Tab:SetScale(0.01)
    ChatFrame2Tab:SetWidth(0.01)
    ChatFrame2Tab:SetHeight(0.01)
end

local frame = CreateFrame("FRAME")
frame:SetScript("OnEvent", SetupCombatLogTab)

-- Ensure combat log is docked
if ChatFrame2.isDocked then
    -- Set combat log attributes when chat windows are updated
    frame:RegisterEvent("UPDATE_CHAT_WINDOWS")
    -- Set combat log tab placement when tabs are assigned by the client
    hooksecurefunc("FCF_SetTabPosition", function()
        ChatFrame2Tab:SetPoint("BOTTOMLEFT", ChatFrame1Tab, "BOTTOMRIGHT", 0, 0)
    end)
    SetupCombatLogTab()
else
    -- If combat log is undocked, do nothing but show warning
    C_Timer.After(1, function()
        LeaPlusLC:Print("Combat log cannot be hidden while undocked.")
    end)
end