local function ReloadMailUI()
    ReloadUI()
end

local function LootAllMail()
    for i = 1, GetInboxNumItems() do
        AutoLootMailItem(i)
    end
end

local function OverwriteOpenAllMailButton()
    if OpenAllMail then
        OpenAllMail:SetScript("OnClick", LootAllMail)
    end
end

local function CreateCheckButton()
    local ReloadUIButton = CreateFrame("Button", "ReloadMailUIButton", InboxFrame, "UIPanelButtonTemplate")
    ReloadUIButton:SetSize(120, 20)
    ReloadUIButton:SetText("Reload")
    ReloadUIButton:SetPoint("TOPRIGHT", MailFrame, "BOTTOMRIGHT", 0, -4)
    ReloadUIButton:SetScript("OnClick", ReloadMailUI)
end

local MailEvents = CreateFrame("Frame")
MailEvents:RegisterEvent("MAIL_SHOW")
MailEvents:SetScript("OnEvent", function(_, event)
    if event == "MAIL_SHOW" then
        CreateCheckButton()
        OverwriteOpenAllMailButton()
    end
end)