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