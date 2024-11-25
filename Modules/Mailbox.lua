local function CreateGetMailButton()
    local reloadButton = CreateFrame("Button", "GetMailButton", InboxFrame, "UIPanelButtonTemplate")
    reloadButton:SetSize(120, 20)
    reloadButton:SetText("Get Mail")
    reloadButton:SetPoint("TOPRIGHT", MailFrame, "BOTTOMRIGHT", 0, -4)
    reloadButton:SetScript("OnClick", CheckInbox)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("MAIL_SHOW")
eventFrame:SetScript("OnEvent", function(_, event)
    if event == "MAIL_SHOW" then
        CreateGetMailButton()
    end
end)