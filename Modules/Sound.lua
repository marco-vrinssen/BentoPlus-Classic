-- Mute bow, gun, and Mechastrider mount sounds

local function SoundUpdate()
    local soundIDsToMute = {
        567677, -- Bow Pullback 1
        567675, -- Bow Pullback 2
        567676, -- Bow Pullback 3
        567719, -- Gun Loading 1
        567720, -- Gun Loading 2
        567723, -- Gun Loading 3
        555124, -- Mechastrider Loop
        548067, -- Core Hound Fire Loop
        567721, -- Gun 1
        567718, -- Gun 2
        567722, -- Gun 3
        567674, -- Bow 1
        567682  -- Bow 3
    }
    for _, soundID in ipairs(soundIDsToMute) do
        MuteSoundFile(soundID)
    end
end

local soundEvents = CreateFrame("Frame")
soundEvents:RegisterEvent("PLAYER_LOGIN")
soundEvents:SetScript("OnEvent", function()
    SoundUpdate()
end)