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

local function MuteSounds()
    for _, soundID in ipairs(soundIDsToMute) do
        MuteSoundFile(soundID)
    end
end

local function InitializeSoundSettings()
    SetCVar("Sound_OutputDriverIndex", "0")
    Sound_GameSystem_RestartSoundSystem()
end

local function OnEvent(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        MuteSounds()
    elseif event == "VOICE_CHAT_OUTPUT_DEVICES_UPDATED" then
        InitializeSoundSettings()
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("VOICE_CHAT_OUTPUT_DEVICES_UPDATED")
eventFrame:SetScript("OnEvent", OnEvent)