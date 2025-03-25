-- FUNCTION TO AUTO JOIN SPECIFIC CHANNELS IF NOT ALREADY JOINED

local function autoJoinChannels()
    local channels = { "World", "LookingForGroup" }
    local channelList = { GetChannelList() }
    for _, channel in ipairs(channels) do
        local alreadyInChannel = false
        for i = 1, #channelList, 3 do
            if channelList[i+1] == channel then
                alreadyInChannel = true
                break
            end
        end
        if not alreadyInChannel then
            JoinChannelByName(channel)
        end
    end
end

local channelEvents = CreateFrame("Frame")
channelEvents:RegisterEvent("PLAYER_LOGIN")
channelEvents:SetScript("OnEvent", autoJoinChannels)