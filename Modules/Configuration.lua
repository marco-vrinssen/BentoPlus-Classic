-- APPLY GRAPHICS CONFIGURATION

local function applyGraphicsConfiguration()
    local graphicsCVars = {
        cameraDistanceMaxZoomFactor = 2.4,
        HardwareCursor = 1,
        WorldTextScale = 1.25,
        ffxGlow = 0,
        ffxDeath = 0,
        ffxNether = 0,
        farclip = 0,
        WeatherDensity = 0,
    }

    for cvar, value in pairs(graphicsCVars) do
        SetCVar(cvar, value)
    end
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