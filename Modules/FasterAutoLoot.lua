-- Function to handle fast auto-looting
local function FasterLoot()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        local lootMethod, masterLooter = GetLootMethod()
        if lootMethod == "master" and masterLooter == UnitName("player") then
            return
        end
        local numLoot = GetNumLootItems()
        if not numLoot then return end
        LootFrame:Hide()
        LootFrame:SetAlpha(0)
        for i = numLoot, 1, -1 do
            LootSlot(i)
        end
        LootFrame:Show()
        LootFrame:SetAlpha(1)
    end
end

-- Create a frame to handle loot events
local LootEvents = CreateFrame("Frame")
LootEvents:RegisterEvent("LOOT_READY")
LootEvents:SetScript("OnEvent", FasterLoot)