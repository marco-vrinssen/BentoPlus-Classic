-- Graphics COnfiguration

local function ConfigUpdate()
    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)

    SetCVar("WorldTextScale", 1.25)
    
    SetCVar("cameraDistanceMaxZoomFactor", 2.4)
end

local ConfigEvents = CreateFrame("Frame")
ConfigEvents:RegisterEvent("PLAYER_LOGIN")
ConfigEvents:SetScript("OnEvent", ConfigUpdate)




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

local function MuteSounds()
    for _, SoundID in ipairs(MutedSounds) do
        MuteSoundFile(SoundID)
    end
end

local function SetSystemSound()
    SetCVar("Sound_OutputDriverIndex", "0")
    Sound_GameSystem_RestartSoundSystem()
end

local SoundEvents = CreateFrame("Frame")
SoundEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
SoundEvents:SetScript("OnEvent", function()
    MuteSounds()
    SetSystemSound()
end)

hooksecurefunc("SetCVar", function(cvar, value)
    if cvar == "Sound_OutputDriverIndex" and value ~= "0" then
        SetSystemSound()
    end
end)