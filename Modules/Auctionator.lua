local function AddScanButtonToAuctionFrame()
    if not IsAddOnLoaded("Auctionator") then
        return
    end

    local ScanButton = AuctionatorConfigFrame.ScanButton
    ScanButton:SetParent(AuctionFrame)
    ScanButton:ClearAllPoints()
    ScanButton:SetPoint("TOPRIGHT", AuctionFrame, "BOTTOMRIGHT", 0, 8)
    ScanButton:SetPoint("LEFT", AuctionFrameTab7, "RIGHT", 0, 0)
    ScanButton:SetHeight(24)

    if AuctionatorConfigFrame.OptionsButton then
        AuctionatorConfigFrame.OptionsButton:Hide()
    end
end

local function ClickScanButton()
    if AuctionatorConfigFrame and AuctionatorConfigFrame.ScanButton then
        AuctionatorConfigFrame.ScanButton:Click()
    end
end

local function OnAuctionHouseShow()
    AddScanButtonToAuctionFrame()
    C_Timer.After(0.5, ClickScanButton)
end

local AuctionatorEvents = CreateFrame("Frame")
AuctionatorEvents:RegisterEvent("AUCTION_HOUSE_SHOW")
AuctionatorEvents:SetScript("OnEvent", OnAuctionHouseShow)