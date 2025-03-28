-- MUTE SOUNDS BY ID

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


-- SOUND CONFIGURATION APPLICATION

local function applySoundConfiguration()
    for _, soundId in ipairs(mutedSounds) do
        MuteSoundFile(soundId)
    end
end

local soundFrame = CreateFrame("Frame")
soundFrame:RegisterEvent("PLAYER_LOGIN")
soundFrame:SetScript("OnEvent", applySoundConfiguration)