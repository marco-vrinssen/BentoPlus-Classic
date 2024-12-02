local function handleConfirmLootRoll(arg1, arg2)
	ConfirmLootRoll(arg1, arg2)
	StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end

local function handleLootBindConfirm(arg1, arg2, ...)
	ConfirmLootSlot(arg1, arg2)
	StaticPopup_Hide("LOOT_BIND", ...)
end

local function handleMerchantConfirmTradeTimerRemoval()
	SellCursorItem()
end

local function handleMailLockSendItems(arg1)
	RespondMailLockSendItem(arg1, true)
end

local RollEvents = CreateFrame("FRAME")
RollEvents:RegisterEvent("CONFIRM_LOOT_ROLL")
RollEvents:RegisterEvent("LOOT_BIND_CONFIRM")
RollEvents:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
RollEvents:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
RollEvents:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
	if event == "CONFIRM_LOOT_ROLL" then
		handleConfirmLootRoll(arg1, arg2)
	elseif event == "LOOT_BIND_CONFIRM" then
		handleLootBindConfirm(arg1, arg2, ...)
	elseif event == "MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL" then
		handleMerchantConfirmTradeTimerRemoval()
	elseif event == "MAIL_LOCK_SEND_ITEMS" then
		handleMailLockSendItems(arg1)
	end
end)