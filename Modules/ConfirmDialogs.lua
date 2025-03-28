-- AUTO CONFIRM DIALOGS

local StaticPopup_Hide = StaticPopup_Hide


-- DIALOG HANDLERS

local eventHandlers = {
    CONFIRM_LOOT_ROLL = function(lootRollID, rollType)
        ConfirmLootRoll(lootRollID, rollType)
        StaticPopup_Hide("CONFIRM_LOOT_ROLL")
    end,

    LOOT_BIND_CONFIRM = function(slotID, bindType, ...)
        ConfirmLootSlot(slotID, bindType)
        StaticPopup_Hide("LOOT_BIND", ...)
    end,

    MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL = SellCursorItem,

    MAIL_LOCK_SEND_ITEMS = function(mailItemID)
        RespondMailLockSendItem(mailItemID, true)
    end,

    EQUIP_BIND_CONFIRM = function(itemID)
        EquipPendingItem(itemID)
        StaticPopup_Hide("EQUIP_BIND")
    end,

    EQUIP_BIND_TRADEABLE_CONFIRM = function(itemID)
        StaticPopupDialogs["EQUIP_BIND_TRADEABLE"]:OnAccept(itemID)
        StaticPopup_Hide("EQUIP_BIND_TRADEABLE")
    end,

    DELETE_ITEM_CONFIRM = DeleteCursorItem
}


-- SETUP EVENT HANDLING

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(_, event, arg1, arg2, ...)
    local eventHandler = eventHandlers[event]
    if eventHandler then
        eventHandler(arg1, arg2, ...)
    end
end)

for eventName in pairs(eventHandlers) do
    frame:RegisterEvent(eventName)
end