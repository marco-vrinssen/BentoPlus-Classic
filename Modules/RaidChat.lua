-- FUNCTION TO CHANGE /P TO /RAID IN RAID

local function ChangePartyToRaidChat(msg, editBox)
    if IsInRaid() and msg:sub(1, 2) == "/p" then
        msg = "/raid" .. msg:sub(3)
    end
    return msg
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", function(_, _, msg, ...)
    return false, ChangePartyToRaidChat(msg), ...
end)
