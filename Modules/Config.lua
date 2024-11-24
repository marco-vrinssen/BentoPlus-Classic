local function ConfigUpdate()
    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)

    SetCVar("WorldTextScale", 1.5)
    SetCVar("cameraDistanceMaxZoomFactor", 3)

    SetCVar("rawMouseEnable", 1)
end

local ConfigEvents = CreateFrame("Frame")
ConfigEvents:RegisterEvent("PLAYER_LOGIN")
ConfigEvents:SetScript("OnEvent", ConfigUpdate)