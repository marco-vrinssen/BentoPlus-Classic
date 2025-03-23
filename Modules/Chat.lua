-- FUNCTION TO JOIN CHANNELS IF NOT ALREADY JOINED

local function joinChannels()
    local channels = { "World", "LookingForGroup", "Services" }
    for _, channel in ipairs(channels) do
        local id = GetChannelName(channel)
        if id == 0 then
            JoinChannelByName(channel)
        end
    end
end


-- REGISTER EVENT TO CHECK CHANNELS ON PLAYER LOGIN

local channelEvents = CreateFrame("Frame")
channelEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
channelEvents:SetScript("OnEvent", joinChannels)