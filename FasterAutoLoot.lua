-- Function to handle fast auto-looting
local function FasterLoot()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        LootFrame:Hide()
        for NumLoot = GetNumLootItems(), 1, -1 do
            LootSlot(NumLoot)
        end
        LootFrame:Show()
    end
end

-- Create a frame to handle loot events
local LootEvents = CreateFrame("Frame")
LootEvents:RegisterEvent("LOOT_READY")
LootEvents:SetScript("OnEvent", FasterLoot)