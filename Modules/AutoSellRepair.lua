-- Function to repair all items if the merchant can repair
local function RepairItems()
    if CanMerchantRepair() then
        RepairAllItems()
    end
end

-- Function to sell all grey (poor quality) items in the player's bags
local function SellGreyItems()
    for NumBags = 0, 4 do
        for NumSlots = 1, C_Container.GetContainerNumSlots(NumBags) do
            local ItemLink = C_Container.GetContainerItemLink(NumBags, NumSlots)
            if ItemLink then
                local _, _, ItemRarity = GetItemInfo(ItemLink)
                if ItemRarity == 0 then
                    UseContainerItem(NumBags, NumSlots)
                end
            end
        end
    end
end

-- Function to repair items and sell grey items when the merchant window is opened
local function AutoSellRepair()
    RepairItems()
    SellGreyItems()
    C_Timer.After(0, SellGreyItems)
end

-- Create a frame to handle merchant events
local MerchantEvents = CreateFrame("Frame")
MerchantEvents:RegisterEvent("MERCHANT_SHOW")
MerchantEvents:SetScript("OnEvent", AutoSellRepair)