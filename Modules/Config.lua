-- APPLY GRAPHICS CONFIGURATION

local function applyGraphicsConfiguration()
    SetCVar("cameraDistanceMaxZoomFactor", 2.4)
    SetCVar("HardwareCursor", 1)
    SetCVar("WorldTextScale", 1.25)
    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)
end

-- APPLY SOUND CONFIGURATION

local function applySoundConfiguration()
    local mutedSounds = {
        555124, -- MechaStriderLoop
        567719, -- GunLoad01
        567720, -- GunLoad02
        567723, -- GunLoad03
        567670, -- BowPreCastLoop
        567677, -- BowPullback
        567675, -- BowPullback02
        567676, -- BowPullback03
        569429, -- PetScreech
    }

    for _, soundId in ipairs(mutedSounds) do
        MuteSoundFile(soundId)
    end
end

-- INITIALIZE CONFIGEVENTS FRAME AND REGISTER EVENT

local configEvents = CreateFrame("Frame")
configEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
configEvents:SetScript("OnEvent", function()
    applyGraphicsConfiguration()
    applySoundConfiguration()
end)