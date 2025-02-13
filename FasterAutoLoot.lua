
-- Faster Auto Loot
function FastLoot()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        LootFrame:Hide()
        for NumLoot = GetNumLootItems(), 1, -1 do
            LootSlot(NumLoot)
        end
        LootFrame:Show()
        CloseLoot()
    end
end

local LootEvents = CreateFrame("Frame")
LootEvents:RegisterEvent("LOOT_READY")
LootEvents:SetScript("OnEvent", FastLoot)