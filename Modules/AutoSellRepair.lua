local LootEvents = CreateFrame("Frame")
LootEvents:RegisterEvent("LOOT_READY")
LootEvents:SetScript("OnEvent", UpdateAutoLoot)

local function RepairItems()
    if CanMerchantRepair() then
        RepairAllItems()
    end
end

local function SellGreyItems()
    for NumBags = 0, 4 do
        for NumSlots = 1, C_Container.GetContainerNumSlots(NumBags) do
            local ItemLink = C_Container.GetContainerItemLink(NumBags, NumSlots)
            if ItemLink then
                local _, _, ItemRarity = GetItemInfo(ItemLink)
                if ItemRarity == 0 then
                    C_Container.UseContainerItem(NumBags, NumSlots)
                end
            end
        end
    end
end

local function AutoSellRepair()
    RepairItems()
    SellGreyItems()
    C_Timer.After(0, SellGreyItems)
end

local MerchantEvents = CreateFrame("Frame")
MerchantEvents:RegisterEvent("MERCHANT_SHOW")
MerchantEvents:SetScript("OnEvent", AutoSellRepair)