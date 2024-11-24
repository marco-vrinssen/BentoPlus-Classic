-- As default combo points are hidden, this is a custom combo points display for rogues and druids.

-- Check if the player is a rogue or druid
local _, ClassIdentifier = UnitClass("player")
if ClassIdentifier ~= "ROGUE" and ClassIdentifier ~= "DRUID" then
    return
end

-- Constants for combo points display
local PointSize = 24
local PointMargin = 4
local PointsTotalWidth = 5 * PointSize + 4 * PointMargin

-- Create the main frame for combo points
local ComboPointsFrame = CreateFrame("Frame", "ComboPointsFrame", UIParent)
ComboPointsFrame:SetSize(PointsTotalWidth, PointSize)
ComboPointsFrame:SetPoint("BOTTOM", CastingBarFrame, "TOP", 0, 4)

local ComboPoints = {}

-- Function to create a single combo point frame
local function CreateComboPoint()
    local ComboPoint = CreateFrame("Frame", nil, ComboPointsFrame, "BackdropTemplate")
    ComboPoint:SetSize(PointSize, PointSize)
    ComboPoint:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = false,
        tileSize = 16,
        edgeSize = 12,
        insets = {left = 2, right = 2, top = 2, bottom = 2}
    })
    ComboPoint:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    ComboPoint:SetBackdropColor(0, 0, 0, 0.5)
    return ComboPoint
end

-- Function to update the texture of a combo point based on its active state
local function ComboPointTextures(ComboPoint, ActiveState)
    if ActiveState then
        ComboPoint:SetBackdropColor(0.75, 0, 0, 1)
    else
        ComboPoint:SetBackdropColor(0, 0, 0, 0.5)
    end
end

-- Create and initialize combo point frames
for i = 1, 5 do
    local ComboPoint = CreateComboPoint()
    ComboPointTextures(ComboPoint, false)
    ComboPoints[i] = ComboPoint
end

-- Set the position of each combo point frame
ComboPointsFrame:SetWidth(PointSize * 5 + PointMargin * 4)
for i, ComboPoint in ipairs(ComboPoints) do
    ComboPoint:SetPoint("LEFT", ComboPointsFrame, "LEFT", PointSize * (i - 1) + PointMargin * (i - 1), 0)
end

-- Function to update the combo points display
local function ComboPointsUpdate()
    ComboFrame:UnregisterAllEvents()
    ComboFrame:Hide()

    local ComboPointsCount = GetComboPoints("player", "target") or 0
    if ComboPointsCount > 0 then
        ComboPointsFrame:Show()
        for i = 1, 5 do
            ComboPointTextures(ComboPoints[i], i <= ComboPointsCount)
        end
    else
        ComboPointsFrame:Hide()
    end
end

-- Register events to update combo points display
local ComboPointsEvents = CreateFrame("Frame")
ComboPointsEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
ComboPointsEvents:RegisterEvent("PLAYER_TARGET_CHANGED")
ComboPointsEvents:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
ComboPointsEvents:SetScript("OnEvent", ComboPointsUpdate)