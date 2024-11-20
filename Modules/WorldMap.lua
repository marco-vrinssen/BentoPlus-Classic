local function worldMapUpdate()
    local newMapScale = 0.8
    WorldMapFrame:ClearAllPoints()
    WorldMapFrame:SetScale(newMapScale)

    local worldMapElements = {
        WorldMapFrame.BlackoutFrame,
        WorldMapTitleButton,
        WorldMapZoomOutButton,
        WorldMapZoneDropDown,
        WorldMapContinentDropDown,
        WorldMapZoneMinimapDropDown,
        WorldMapMagnifyingGlassButton
    }

    for _, worldMapElement in ipairs(worldMapElements) do
        worldMapElement.Show = function()
            worldMapElement:Hide()
        end
    end

    WorldMapFrame.ScrollContainer.GetCursorPosition = function()
        local width, height = MapCanvasScrollControllerMixin.GetCursorPosition()
        return width / newMapScale, height / newMapScale
    end
end

local worldMapEvents = CreateFrame("Frame")
worldMapEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
worldMapEvents:SetScript("OnEvent", worldMapUpdate)