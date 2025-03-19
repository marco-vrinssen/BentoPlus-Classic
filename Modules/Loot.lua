-- FASTER AUTO LOOTING

local lootStart = 0
local lootDelay = 0.1


-- AUTO LOOTING FUNCTION

local function autoLooting()
	if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
		if (GetTime() - lootStart) >= lootDelay then
			local allLooted = true
			for i = GetNumLootItems(), 1, -1 do
				if not LootSlot(i) then
					allLooted = false
				end
			end
			if not allLooted then
				LootFrame:Show()
			end
			lootStart = GetTime()
		end
	end
end


-- REGISTER LOOT EVENTS

local fasterLootEvents = CreateFrame("Frame")
fasterLootEvents:RegisterEvent("LOOT_READY")
fasterLootEvents:SetScript("OnEvent", autoLooting)