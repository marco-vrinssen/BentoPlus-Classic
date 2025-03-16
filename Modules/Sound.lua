-- MUTE SOUNDS

local mutedSounds = {
    555124,
    548067,
    567677,
    567675,
    567676,
    567719,
    567720,
    567723,
    567721,
}

local function applySoundConfiguration()
    for _, soundId in ipairs(mutedSounds) do
        MuteSoundFile(soundId)
    end
end

local soundFrame = CreateFrame("Frame")
soundFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
soundFrame:SetScript("OnEvent", applySoundConfiguration)