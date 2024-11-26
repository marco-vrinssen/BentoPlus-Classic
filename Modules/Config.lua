local function ConfigUpdate()
    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)

    SetCVar("WorldTextScale", 1.25)
    SetCVar("cameraDistanceMaxZoomFactor", 2.2)

    SetCVar("rawMouseEnable", 1)
end

local ConfigEvents = CreateFrame("Frame")
ConfigEvents:RegisterEvent("PLAYER_LOGIN")
ConfigEvents:SetScript("OnEvent", ConfigUpdate)