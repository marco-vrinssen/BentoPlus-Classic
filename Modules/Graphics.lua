-- UPDATE GRAPHICS CONFIG

local function updateCVars()
    SetCVar("cameraDistanceMaxZoomFactor", 2.4)
    SetCVar("HardwareCursor", 1)

    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)

    SetCVar("WorldTextScale", 1.5)

    SetCVar("UnitNameNPC", 1)
    SetCVar("UnitNameHostleNPC", 0)
    SetCVar("UnitNameInteractiveNPC", 0)

    SetCVar("UnitNamePlayerGuild", 1)
    SetCVar("UnitNamePlayerPVPTitle", 0)
end

local graphicsFrame = CreateFrame("Frame")
graphicsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
graphicsFrame:SetScript("OnEvent", updateCVars)