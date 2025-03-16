-- FUNCTION TO RELOAD MAIL FRAME AND CHECK FOR NEW MAIL

local function refreshMailFrame()
    for i = 1, 10 do
        C_Timer.After(i * 0.1, function()
            CheckInbox()
        end)
    end
end

local mailEvents = CreateFrame("Frame")
mailEvents:RegisterEvent("MAIL_SHOW")
mailEvents:SetScript("OnEvent", refreshMailFrame)