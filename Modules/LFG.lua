local function MinimapLFGUpdate()
    LFGMinimapFrameBorder:Hide()
    LFGMinimapFrame:SetParent(Minimap)
    LFGMinimapFrame:ClearAllPoints()
    LFGMinimapFrame:SetSize(44, 44)
    LFGMinimapFrame:SetPoint("RIGHT", CharacterMicroButton, "LEFT", 0, -8)
    LFGMinimapFrameIcon:SetSize(40, 40)
    LFGMinimapFrameIcon:SetPoint("CENTER", LFGMinimapFrame, "CENTER", 0, 0)
end

local MinimapLFGEvents = CreateFrame("Frame")
MinimapLFGEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
MinimapLFGEvents:SetScript("OnEvent", MinimapLFGUpdate)