-- UPDATE GRAPHICS CONFIG

local function updateCVars()
    SetCVar("cameraDistanceMaxZoomFactor", 2.4)
    SetCVar("HardwareCursor", 1)

    SetCVar("WorldTextScale", 1.25)

    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)
    SetCVar("farclip", 4000)
    SetCVar("WeatherDensity", 0)
end


-- INITIALIZE GRAPHICS FRAME AND REGISTER EVENT

local graphicsFrame = CreateFrame("Frame")
graphicsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
graphicsFrame:SetScript("OnEvent", updateCVars)