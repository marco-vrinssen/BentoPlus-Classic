local function AddScanButtonToAuctionFrame()
    if not IsAddOnLoaded("Auctionator") then
        return
    end

    if not AuctionFrame then
        return
    end

    local ScanButton = AuctionatorConfigFrame.ScanButton
    ScanButton:SetParent(AuctionFrame)
    ScanButton:ClearAllPoints()
    ScanButton:SetPoint("TOPRIGHT", AuctionFrame, "BOTTOMRIGHT", 0, 8)
    ScanButton:SetWidth(240)

    if AuctionatorConfigFrame.OptionsButton then
        AuctionatorConfigFrame.OptionsButton:Hide()
    end
end

local function OnAuctionHouseShow()
    AddScanButtonToAuctionFrame()
end

local AuctionatorEvents = CreateFrame("Frame")
AuctionatorEvents:RegisterEvent("AUCTION_HOUSE_SHOW")
AuctionatorEvents:SetScript("OnEvent", OnAuctionHouseShow)