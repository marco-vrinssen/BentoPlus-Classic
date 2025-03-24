-- FUNCTION TO AUTO JOIN CHANNELS IN SPECIFIC ORDER
local function autoJoinChannels()
    local channels = { "General", "Trade", "Services", "World", "LookingForGroup" }
    for _, channel in ipairs(channels) do
        JoinChannelByName(channel) -- Join the channel
    end
end

-- REGISTER EVENTS TO AUTO JOIN CHANNELS
local channelEvents = CreateFrame("Frame")
channelEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
channelEvents:SetScript("OnEvent", autoJoinChannels)