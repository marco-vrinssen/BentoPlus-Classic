-- Function to move the Scan button to the desired position
local function AddScanButtonToAuctionFrame()
    -- Ensure Auctionator addon is loaded
    if not IsAddOnLoaded("Auctionator") then
        return
    end

    -- Ensure AuctionFrame and AuctionatorConfigFrame.ScanButton are loaded
    if not AuctionFrame then
        return
    end

    -- Move the Scan button to the top right corner of AuctionFrameBotRight
    local ScanButton = AuctionatorConfigFrame.ScanButton
    ScanButton:SetParent(AuctionFrame)
    ScanButton:ClearAllPoints()
    ScanButton:SetPoint("TOPRIGHT", AuctionFrame, "BOTTOMRIGHT", 0, 8)
    ScanButton:SetWidth(240)

    -- Hide the Options button if it exists
    if AuctionatorConfigFrame.OptionsButton then
        AuctionatorConfigFrame.OptionsButton:Hide()
    end
end

-- Event handler for AUCTION_HOUSE_SHOW
local function OnAuctionHouseShow()
    AddScanButtonToAuctionFrame()
end

-- Register event and set script
local AuctionatorEvents = CreateFrame("Frame")
AuctionatorEvents:RegisterEvent("AUCTION_HOUSE_SHOW")
AuctionatorEvents:SetScript("OnEvent", OnAuctionHouseShow)


