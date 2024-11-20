-- Update position and appearance of the MicroMenu buttons

local function ButtonUpdate()
    local frame = EnumerateFrames()
    while frame do
        local name = frame:GetName()
        if name and name:find("MicroButton") then
            frame:SetAlpha(0.5)
            frame:SetScale(0.75)
            frame:SetScript("OnEnter", nil)
            frame:SetScript("OnLeave", nil)
        end
        frame = EnumerateFrames(frame)
    end

    CharacterMicroButton:ClearAllPoints()
    CharacterMicroButton:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 16, 0)
end

local MicroMenuEvents = CreateFrame("Frame")
MicroMenuEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
MicroMenuEvents:SetScript("OnEvent", ButtonUpdate)