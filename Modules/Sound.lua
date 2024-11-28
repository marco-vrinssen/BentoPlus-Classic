local MutedSounds = {
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

local function MuteSounds()
    for _, SoundID in ipairs(MutedSounds) do
        MuteSoundFile(SoundID)
    end
end

local MuteSoundEvents = CreateFrame("Frame")
MuteSoundEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
MuteSoundEvents:SetScript("OnEvent", MuteSounds)


SetCVar("Sound_OutputDriverIndex", "0")
local ResetSoundEvents = CreateFrame("FRAME")
ResetSoundEvents:RegisterEvent("VOICE_CHAT_OUTPUT_DEVICES_UPDATED")
ResetSoundEvents:SetScript("OnEvent", function()
    SetCVar("Sound_OutputDriverIndex", "0")
    Sound_GameSystem_RestartSoundSystem()
end)