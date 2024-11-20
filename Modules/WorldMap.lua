-- Function to update the world map scale and disable blackout frame
local function WorldMapUpdate()
    local newMapScale = 0.8
    WorldMapFrame:ClearAllPoints()
    WorldMapFrame:SetScale(newMapScale)
    
    -- Center the world map in the middle of the screen
    WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

    -- Disable the blackout frame
    WorldMapFrame.BlackoutFrame.Show = function()
        WorldMapFrame.BlackoutFrame:Hide()
    end

    -- Adjust cursor position based on the new map scale
    WorldMapFrame.ScrollContainer.GetCursorPosition = function()
        local width, height = MapCanvasScrollControllerMixin.GetCursorPosition()
        return width / newMapScale, height / newMapScale
    end
end

-- Function to fade out the world map based on player movement
local function FadeOutMap()
    local targetAlpha = IsPlayerMoving() and 0.25 or 1
    UIFrameFadeOut(WorldMapFrame, 0.25, WorldMapFrame:GetAlpha(), targetAlpha)
end

-- Event handler function
local function OnEvent(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        WorldMapUpdate()
    else
        FadeOutMap()
    end
end

-- Create a frame to handle world map events
local worldMapEvents = CreateFrame("Frame")
worldMapEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
worldMapEvents:RegisterEvent("PLAYER_STARTED_MOVING")
worldMapEvents:RegisterEvent("PLAYER_STOPPED_MOVING")
worldMapEvents:SetScript("OnEvent", OnEvent)
