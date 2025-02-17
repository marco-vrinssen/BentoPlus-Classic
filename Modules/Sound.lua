-- Sound Configuration
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

local function ApplySoundConfiguration()
    -- Mute configured sounds
    for _, SoundID in ipairs(MutedSounds) do
        MuteSoundFile(SoundID)
    end
    -- Reset system sound output if needed
    if GetCVar("Sound_OutputDriverIndex") ~= "0" then
        SetCVar("Sound_OutputDriverIndex", "0")
        Sound_GameSystem_RestartSoundSystem()
    end
end

local SoundEvents = CreateFrame("Frame")
SoundEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
SoundEvents:SetScript("OnEvent", ApplySoundConfiguration)

hooksecurefunc("SetCVar", function(cvar, value)
    if cvar == "Sound_OutputDriverIndex" and value ~= "0" then
        ApplySoundConfiguration()
    end
end)