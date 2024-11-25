local function UpdateWorldMapFrame()
    WorldMapFrame:ClearAllPoints()
    WorldMapFrame:SetScale(0.75)
    WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    WorldMapFrame.BlackoutFrame.Show = function()
        WorldMapFrame.BlackoutFrame:Hide()
    end
    WorldMapFrame.ScrollContainer.GetCursorPosition = function()
        local width, height = MapCanvasScrollControllerMixin.GetCursorPosition()
        return width / newMapScale, height / newMapScale
    end
end

local function RepositionWorldMap()
    if GetCVar("miniWorldMap") ~= "1" then
        WorldMapFrame:ClearAllPoints()
        WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
end

local function FadeOutMap()
    if WorldMapFrame:IsShown() then
        local targetAlpha = IsPlayerMoving() and 0.25 or 1
        UIFrameFadeOut(WorldMapFrame, 0.25, WorldMapFrame:GetAlpha(), targetAlpha)
    end
end

local function OnWorldMapShow()
    if GetCVar("miniWorldMap") ~= "1" then
        C_Timer.After(0, RepositionWorldMap)
    end
end

local function OnEvent(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        UpdateWorldMapFrame()
    else
        FadeOutMap()
    end
    RepositionWorldMap()
end

local function InitializeWorldMapEvents()
    local worldMapEvents = CreateFrame("Frame")
    worldMapEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
    worldMapEvents:RegisterEvent("PLAYER_STARTED_MOVING")
    worldMapEvents:RegisterEvent("PLAYER_STOPPED_MOVING")
    worldMapEvents:SetScript("OnEvent", OnEvent)
    WorldMapFrame:HookScript("OnShow", OnWorldMapShow)
end