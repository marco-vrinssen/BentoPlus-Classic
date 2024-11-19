local function UpdateStatusBarSize(self)
    GameTooltipStatusBar:SetSize(self:GetWidth() - 4, 12)
end

local function UnitTooltipUpdate(GameTooltip)
    if GameTooltip:GetAnchorType() ~= "ANCHOR_CURSOR" then
        GameTooltip:ClearAllPoints()
        GameTooltip:SetPoint("TOPLEFT", TargetFramePortrait, "BOTTOMRIGHT", 8, -8)

        GameTooltipStatusBar:ClearAllPoints()
        GameTooltipStatusBar:SetPoint("TOP", GameTooltip, "BOTTOM", 0, 4)
        GameTooltipStatusBar:SetStatusBarTexture("Interface/RaidFrame/Raid-Bar-HP-Fill.blp")
        GameTooltipStatusBar:SetFrameLevel(GameTooltip:GetFrameLevel() -1)
    end
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", UnitTooltipUpdate)
GameTooltip:HookScript("OnTooltipSetUnit", UnitTooltipUpdate)
GameTooltip:HookScript("OnSizeChanged", UpdateStatusBarSize)