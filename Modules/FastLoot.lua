-- AUTO LOOT ITEMS WHEN LOOT WINDOW OPENS

local function autoLooting()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        for i = GetNumLootItems(), 1, -1 do
            LootSlot(i)
        end
    end
end

local autoLootEvents = CreateFrame("Frame")
autoLootEvents:RegisterEvent("LOOT_READY")
autoLootEvents:SetScript("OnEvent", autoLooting)




-- -- DELAYED LOOTING TO PREVENT DISCONNECTS

-- local function delayedLoot(slotIndex)
--     if slotIndex < 1 then return end
--     LootSlot(slotIndex)
--     C_Timer.After(0.05, function()
--         delayedLoot(slotIndex - 1)
--     end)
-- end

-- local function autoLooting()
--     if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
--         local totalLootSlots = GetNumLootItems()
--         if totalLootSlots > 0 then
--             delayedLoot(totalLootSlots)
--         end
--     end
-- end

-- local autoLootEvents = CreateFrame("Frame")
-- autoLootEvents:RegisterEvent("LOOT_READY")
-- autoLootEvents:SetScript("OnEvent", autoLooting)