-- FUNCTION TO AUTO JOIN SPECIFIC CHANNELS IF NOT ALREADY JOINED

local function autoJoinChannels()
    local channels = { "World", "LookingForGroup" }
    local channelList = { GetChannelList() }
    local channelsToJoin = {}

    for _, channel in ipairs(channels) do
        local alreadyInChannel = false
        for i = 1, #channelList, 3 do
            if channelList[i+1] == channel then
                alreadyInChannel = true
                break
            end
        end
        if not alreadyInChannel then
            table.insert(channelsToJoin, channel)
        end
    end

    if #channelsToJoin > 0 then
        for _, channel in ipairs(channelsToJoin) do
            JoinChannelByName(channel)
        end
    end
end

local channelEvents = CreateFrame("Frame")
channelEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
channelEvents:SetScript("OnEvent", autoJoinChannels)