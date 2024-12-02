local function ReloadMailUI()
    local function ToggleInboxFrame(count)
        if count > 0 then
            InboxFrame:Hide()
            C_Timer.After(0, function()
                InboxFrame:Show()
                ToggleInboxFrame(count - 1)
            end)
        end
    end
    ToggleInboxFrame(10)
end

local function ClickOpenAllMailButton()
    if OpenAllMail then
        C_Timer.After(0, function()
            OpenAllMail:Click()
        end)
    end
end

local function CreateCheckButton()
    local ReloadUIButton = CreateFrame("Button", "ReloadMailUIButton", InboxFrame, "UIPanelButtonTemplate")
    ReloadUIButton:SetSize(120, 20)
    ReloadUIButton:SetText("Reload Inbox")
    ReloadUIButton:SetPoint("TOPRIGHT", MailFrame, "BOTTOMRIGHT", 0, -4)
    ReloadUIButton:SetScript("OnClick", ReloadMailUI)
end

local MailEvents = CreateFrame("Frame")
MailEvents:RegisterEvent("MAIL_SHOW")
MailEvents:SetScript("OnEvent", function(_, event)
    if event == "MAIL_SHOW" then
        CreateCheckButton()
        ClickOpenAllMailButton()
    end
end)