local function AutoDismount(_, event)
    if event == "TAXIMAP_OPENED" then
        if IsMounted() then
            Dismount()
        end
    end
end

local taxiFrame = CreateFrame("FRAME")
taxiFrame:RegisterEvent("TAXIMAP_OPENED")
taxiFrame:SetScript("OnEvent", AutoDismount)