-- Mute bow, gun, and Mechastrider mount sounds

local function SoundUpdate()
    local soundIDsToMute = {
        555124, -- Mechastrider Loop
        548067, -- Core Hound Fire Loop

        567677, -- Bow Pullback 1
        567675, -- Bow Pullback 2
        567676, -- Bow Pullback 3
        567719, -- Gun Loading 1
        567720, -- Gun Loading 2
        567723, -- Gun Loading 3

        567721, -- Gun Release 1
    }

    for _, soundID in ipairs(soundIDsToMute) do
        MuteSoundFile(soundID)
    end
end

local soundEvents = CreateFrame("Frame")
soundEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
soundEvents:SetScript("OnEvent", function()
    SoundUpdate()
end)