local function MinimapLFGUpdate()
    if LFGMinimapFrameBorder then
        LFGMinimapFrameBorder:Hide()
    end
    if LFGMinimapFrame then
        LFGMinimapFrame:SetParent(Minimap)
        LFGMinimapFrame:ClearAllPoints()
        LFGMinimapFrame:SetSize(44, 44)
        LFGMinimapFrame:SetPoint("RIGHT", CharacterMicroButton, "LEFT", 0, -8)
    end
    if LFGMinimapFrameIcon then
        LFGMinimapFrameIcon:SetSize(40, 40)
        LFGMinimapFrameIcon:SetPoint("CENTER", LFGMinimapFrame, "CENTER", 0, 0)
    end
end

local MinimapLFGEvents = CreateFrame("Frame")
MinimapLFGEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
MinimapLFGEvents:SetScript("OnEvent", MinimapLFGUpdate)