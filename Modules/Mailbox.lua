local function TriggerCheckInbox()
    CheckInbox()
end

local function CreateCheckButton()
    local CheckInboxButton = CreateFrame("Button", "GetMailButton", InboxFrame, "UIPanelButtonTemplate")
    CheckInboxButton:SetSize(120, 20)
    CheckInboxButton:SetText("Get Mail")
    CheckInboxButton:SetPoint("TOPRIGHT", MailFrame, "BOTTOMRIGHT", 0, -4)
    CheckInboxButton:SetScript("OnClick", TriggerCheckInbox)
end

local MailEvents = CreateFrame("Frame")
MailEvents:RegisterEvent("MAIL_SHOW")
MailEvents:SetScript("OnEvent", function(_, event)
    if event == "MAIL_SHOW" then
        CreateCheckButton()
    end
end)