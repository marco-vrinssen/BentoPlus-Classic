local function UpdateAutoLoot(self, event)
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        local NumItems = GetNumLootItems()
        for CurrentItem = NumItems, 1, -1 do
            LootSlot(CurrentItem)
        end
    end
end