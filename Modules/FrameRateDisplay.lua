local function FramerateUpdate()
    FramerateLabel:SetAlpha(0)
    FramerateText:ClearAllPoints()
    FramerateText:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 16, -16)
end

local FramerateEvents = CreateFrame("Frame")
FramerateEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
FramerateEvents:SetScript("OnEvent", FramerateUpdate)