local _, ClassIdentifier = UnitClass("player")
if ClassIdentifier ~= "ROGUE" and ClassIdentifier ~= "DRUID" then
    return
end

local PointSize = 24
local PointMargin = 4
local PointsTotalWidth = 5 * PointSize + 4 * PointMargin

local ComboPointsFrame = CreateFrame("Frame", "ComboPointsFrame", UIParent)
ComboPointsFrame:SetSize(PointsTotalWidth, PointSize)
ComboPointsFrame:SetPoint("BOTTOM", CastingBarFrame, "TOP", 0, 4)

local ComboPoints = {}

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

local function ComboPointTextures(ComboPoint, ActiveState)
    if ActiveState then
        ComboPoint:SetBackdropColor(0.75, 0, 0, 1)
    else
        ComboPoint:SetBackdropColor(0, 0, 0, 0.5)
    end
end

for i = 1, 5 do
    local ComboPoint = CreateComboPoint()
    ComboPointTextures(ComboPoint, false)
    ComboPoints[i] = ComboPoint
end

ComboPointsFrame:SetWidth(PointSize * 5 + PointMargin * 4)
for i, ComboPoint in ipairs(ComboPoints) do
    ComboPoint:SetPoint("LEFT", ComboPointsFrame, "LEFT", PointSize * (i - 1) + PointMargin * (i - 1), 0)
end

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

local ComboPointsEvents = CreateFrame("Frame")
ComboPointsEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
ComboPointsEvents:RegisterEvent("PLAYER_TARGET_CHANGED")
ComboPointsEvents:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
ComboPointsEvents:SetScript("OnEvent", ComboPointsUpdate)