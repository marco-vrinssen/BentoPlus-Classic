-- Update position and appearance of the MicroMenu buttons

local function UpdateMicroMenuButtons()
    local checkedFrames = EnumerateFrames()
    while checkedFrames do
        local microButtonFrame = checkedFrames:GetName()
        if microButtonFrame and microButtonFrame:find("MicroButton") then
            checkedFrames:SetAlpha(0.5)
            checkedFrames:SetScale(0.75)
        end
        checkedFrames = EnumerateFrames(checkedFrames)
    end

    CharacterMicroButton:ClearAllPoints()
    CharacterMicroButton:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 16, 0)
end

local microMenuEventFrame = CreateFrame("Frame")
microMenuEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
microMenuEventFrame:SetScript("OnEvent", UpdateMicroMenuButtons)