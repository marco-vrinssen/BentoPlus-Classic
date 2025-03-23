-- FUNCTION TO JOIN CHANNELS IF NOT ALREADY JOINED

local function joinChannels()
    local channels = { "World", "LookingForGroup" }
    for _, channel in ipairs(channels) do
        local id = GetChannelName(channel)
        if id == 0 then
            JoinChannelByName(channel)
        end
    end
end


-- REGISTER EVENT TO CHECK CHANNELS ON PLAYER LOGIN

local channelEvents = CreatechannelEvents("channelEvents")
channelEvents:RegisterEvent("PLAYER_LOGIN")
channelEvents:SetScript("OnEvent", joinChannels)