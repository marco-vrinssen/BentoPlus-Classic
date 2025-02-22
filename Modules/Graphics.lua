local function UpdateCVars()
    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)
    SetCVar("WorldTextScale", 1.25)
    SetCVar("cameraDistanceMaxZoomFactor", 2.2)
    SetCVar("HardwareCursor", 1)
end

local GraphicsEvents = CreateFrame("Frame")
GraphicsEvents:RegisterEvent("PLAYER_LOGIN")
GraphicsEvents:SetScript("OnEvent", UpdateCVars)