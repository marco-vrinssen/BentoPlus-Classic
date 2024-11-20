local function HideStatusBar()
    GameTooltipStatusBar:Hide()
end

local function UpdateTooltipPosition(tooltip)
    if tooltip:GetAnchorType() ~= "ANCHOR_CURSOR" then
        tooltip:ClearAllPoints()
        tooltip:SetPoint("TOPLEFT", TargetFramePortrait, "BOTTOMRIGHT", 8, -8)

        GameTooltipStatusBar:ClearAllPoints()
        GameTooltipStatusBar:SetPoint("TOP", tooltip, "BOTTOM", 0, 4)
        GameTooltipStatusBar:SetStatusBarTexture("Interface/RaidFrame/Raid-Bar-HP-Fill.blp")
        GameTooltipStatusBar:SetFrameLevel(tooltip:GetFrameLevel() - 1)
    end
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", UpdateTooltipPosition)
GameTooltip:HookScript("OnTooltipSetUnit", UpdateTooltipPosition)
GameTooltip:HookScript("OnSizeChanged", HideStatusBar)