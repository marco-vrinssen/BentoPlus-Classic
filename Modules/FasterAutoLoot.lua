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


local LootEvents = CreateFrame("Frame")
LootEvents:RegisterEvent("LOOT_READY")
LootEvents:SetScript("OnEvent", FasterLoot)