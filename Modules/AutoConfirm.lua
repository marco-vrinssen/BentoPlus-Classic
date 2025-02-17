-- Auto Confirm Loot Dialogs
local frame = CreateFrame("FRAME")
frame:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
	if event == "CONFIRM_LOOT_ROLL" then
		ConfirmLootRoll(arg1, arg2)
		StaticPopup_Hide("CONFIRM_LOOT_ROLL")
	elseif event == "LOOT_BIND_CONFIRM" then
		ConfirmLootSlot(arg1, arg2)
		StaticPopup_Hide("LOOT_BIND", ...)
	elseif event == "MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL" then
		SellCursorItem()
	elseif event == "MAIL_LOCK_SEND_ITEMS" then
		RespondMailLockSendItem(arg1, true)
	end
end)

local AutoConfirmConfig = { noConfirmLoot = true }  -- generic configuration

local function SetEvent()
	if AutoConfirmConfig.noConfirmLoot then
		frame:RegisterEvent("CONFIRM_LOOT_ROLL")
		frame:RegisterEvent("LOOT_BIND_CONFIRM")
		frame:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
		frame:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
	else
		frame:UnregisterEvent("CONFIRM_LOOT_ROLL")
		frame:UnregisterEvent("LOOT_BIND_CONFIRM")
		frame:UnregisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
		frame:UnregisterEvent("MAIL_LOCK_SEND_ITEMS")
	end
end

if AutoConfirmConfig.noConfirmLoot then SetEvent() end
NoConfirmLootButton:HookScript("OnClick", SetEvent)  -- assuming a generic UI button exists

-- Auto Confirm Delete Dialogs
local typeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
local _, typeDeleteLineParsed = strsplit("@", typeDeleteLine, 2)

RunScript("StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkEnter = function(self, link, text, region, boundsLeft, boundsBottom, boundsWidth, boundsHeight) GameTooltip:SetOwner(self, \"ANCHOR_PRESERVE\") GameTooltip:ClearAllPoints() local cursorClearance = 30 GameTooltip:SetPoint(\"TOPLEFT\", region, \"BOTTOMLEFT\", boundsLeft, boundsBottom - cursorClearance) GameTooltip:SetHyperlink(link) end")
RunScript("StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkLeave = function(self) GameTooltip:Hide() end")
RunScript("StaticPopupDialogs[\"DELETE_ITEM\"].OnHyperlinkEnter = StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkEnter")
RunScript("StaticPopupDialogs[\"DELETE_ITEM\"].OnHyperlinkLeave = StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkLeave")
RunScript("StaticPopupDialogs[\"DELETE_QUEST_ITEM\"].OnHyperlinkEnter = StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkEnter")
RunScript("StaticPopupDialogs[\"DELETE_QUEST_ITEM\"].OnHyperlinkLeave = StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkLeave")
RunScript("StaticPopupDialogs[\"DELETE_GOOD_QUEST_ITEM\"].OnHyperlinkEnter = StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkEnter")
RunScript("StaticPopupDialogs[\"DELETE_GOOD_QUEST_ITEM\"].OnHyperlinkLeave = StaticPopupDialogs[\"DELETE_GOOD_ITEM\"].OnHyperlinkLeave")

local easyDelFrame = CreateFrame("FRAME")
easyDelFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
easyDelFrame:SetScript("OnEvent", function()
	if StaticPopup1EditBox:IsShown() then
		StaticPopup1:SetHeight(StaticPopup1:GetHeight() - 10)
		StaticPopup1EditBox:Hide()
		StaticPopup1Button1:Enable()
		local link = select(3, GetCursorInfo())
		if link then
			StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(typeDeleteLineParsed, "@", ""), "") .. "|n" .. link)
		end
	else
		StaticPopup1:SetHeight(StaticPopup1:GetHeight() + 40)
		StaticPopup1EditBox:Hide()
		StaticPopup1Button1:Enable()
		local link = select(3, GetCursorInfo())
		if link then
			StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(typeDeleteLineParsed, "@", ""), "") .. "|n|n" .. link)
		end
	end
end)