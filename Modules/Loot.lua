-- FASTER AUTO LOOTING

local lootStart = 0
local lootDelay = 0.1

local function autoLooting()
	if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
		if (GetTime() - lootStart) >= lootDelay then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
			lootStart = GetTime()
		end
	end
end

local fasterLootEvents = CreateFrame("Frame")
fasterLootEvents:RegisterEvent("LOOT_READY")
fasterLootEvents:SetScript("OnEvent", autoLooting)