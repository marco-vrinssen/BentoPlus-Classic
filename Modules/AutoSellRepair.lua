-- FUNCTION TO AUTO REPAIR ITEMS

local function repairItems()
  if CanMerchantRepair() then
      local repairCost, canRepair = GetRepairAllCost()
      if canRepair and repairCost > 0 then
          RepairAllItems()
          print("Items repaired for " .. GetCoinText(repairCost, " "))
      end
  end
end

-- FUNCTION TO SELL GREY (JUNK) ITEMS

local function sellGreyItems()
  local totalEarnings = 0
  for bag = 0, 4 do
      for slot = 1, C_Container.GetContainerNumSlots(bag) do
          local itemLink = C_Container.GetContainerItemLink(bag, slot)
          if itemLink then
              local _, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(itemLink)
              local itemCount = select(2, C_Container.GetContainerItemInfo(bag, slot)) or 0
              if itemRarity == 0 and itemSellPrice > 0 then
                  totalEarnings = totalEarnings + (itemSellPrice * itemCount)
                  C_Container.UseContainerItem(bag, slot)
              end
          end
      end
  end

  if totalEarnings > 0 then
      print("Items sold for " .. GetCoinText(totalEarnings, " "))
  end
end

local function autoSellRepair()
  repairItems()
  sellGreyItems()
end

local merchantEvents = CreateFrame("Frame")
merchantEvents:RegisterEvent("MERCHANT_SHOW")
merchantEvents:SetScript("OnEvent", autoSellRepair)
