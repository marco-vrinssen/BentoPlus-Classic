-- Function to speed up auto looting while hiding the loot frame during the looting
local function UpdateAutoLoot()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        local NumItems = GetNumLootItems()
        if NumItems and NumItems > 0 then
            LootFrame:Hide()
            for CurrentItem = NumItems, 1, -1 do
                LootSlot(CurrentItem)
            end
            LootFrame:Show()
        end
    end
end

local LootEvents = CreateFrame("Frame")
LootEvents:RegisterEvent("LOOT_READY")
LootEvents:SetScript("OnEvent", UpdateAutoLoot)


-- Automatically sells grey items and repairs gear when visiting a merchant

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