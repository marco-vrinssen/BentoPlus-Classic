local URL_PATTERNS = {
    "^(%a[%w+.-]+://%S+)",
    "%f[%S](%a[%w+.-]+://%S+)",
    "^(www%.[-%w_%%]+%.(%a%a+)/%S+)",
    "%f[%S](www%.[-%w_%%]+%.(%a%a+)/%S+)",
    "^(www%.[-%w_%%]+%.(%a%a+))",
    "%f[%S](www%.[-%w_%%]+%.(%a%a+))",
    "(%S+@[%w_.-%%]+%.(%a%a+))",
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d/%S+)",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d/%S+)",
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d)%f[%D]",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d)%f[%D]",
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%/%S+)",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%/%S+)",
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d)%f[%D]",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d)%f[%D]",
}

local function formatURL(url)
    return "|cff149bfd|Hurl:" .. url .. "|h[" .. url .. "]|h|r "
end

local function makeClickable(self, event, msg, ...)
    for _, pattern in pairs(URL_PATTERNS) do
        if string.find(msg, pattern) then
            msg = string.gsub(msg, pattern, formatURL("%1"))
        end
    end
    return false, msg, ...
end

StaticPopupDialogs["CLICK_LINK_CLICKURL"] = {
    text = "",
    button1 = "Close",
    OnAccept = function() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnShow = function(self, data)
        self.editBox:SetText(data.url)
        self.editBox:HighlightText()
        self.editBox:SetScript("OnKeyDown", function(_, key)
            local isMac = IsMacClient()
            if key == "ESCAPE" then
                self:Hide()
            elseif (isMac and IsMetaKeyDown() or IsControlKeyDown()) and key == "C" then
                self:Hide()
            end
        end)
    end,
    hasEditBox = true
}

local SetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link)
    if string.sub(link, 1, 3) == "url" then
        local url = string.sub(link, 5)
        StaticPopup_Show("CLICK_LINK_CLICKURL", "", "", { url = url })
    else
        SetHyperlink(self, link)
    end
end

local CHAT_TYPES = {
    "AFK", "BATTLEGROUND_LEADER", "BATTLEGROUND", "BN_WHISPER", "BN_WHISPER_INFORM",
    "CHANNEL", "COMMUNITIES_CHANNEL", "DND", "EMOTE", "GUILD", "OFFICER", "PARTY_LEADER",
    "PARTY", "RAID_LEADER", "RAID_WARNING", "RAID", "SAY", "WHISPER", "WHISPER_INFORM", "YELL", "SYSTEM"
}

for _, type in pairs(CHAT_TYPES) do
    ChatFrame_AddMessageEventFilter("CHAT_MSG_" .. type, makeClickable)
end
