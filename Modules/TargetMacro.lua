-- REGISTER SLASH COMMANDS

SLASH_TARGETMACRO1 = "/tm"
SlashCmdList["TARGETMACRO"] = function(msg)
    local macroName = "FIND"
    local macroBody

    if msg and msg ~= "" then
        macroBody = "/cleartarget\n/target " .. msg .. "\n/run if UnitExists(\"target\") and GetRaidTargetIndex(\"target\") ~= 8 then SetRaidTarget(\"target\", 8) end"
    else
        local targetName = UnitName("target")
        if targetName then
            macroBody = "/cleartarget\n/target " .. targetName .. "\n/run if UnitExists(\"target\") and GetRaidTargetIndex(\"target\") ~= 8 then SetRaidTarget(\"target\", 8) end"
        else
            print("No target selected and no name provided.")
            return
        end
    end

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "INV_MISC_QUESTIONMARK", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    print("Macro '" .. macroName .. "' has been created/updated.")
end
