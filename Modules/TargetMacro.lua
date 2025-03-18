-- REGISTER SLASH COMMANDS

SLASH_TARGETMACRO1 = "/fm"
SlashCmdList["TARGETMACRO"] = function(msg)
    local macroName = "FIND"
    local macroBody

    if msg and msg ~= "" then
        macroBody = "/cleartarget\n/target " .. msg
    else
        local targetName = UnitName("target")
        if targetName then
            macroBody = "/cleartarget\n/target " .. targetName
        else
            print("No target selected and no name provided.")
            return
        end
    end

    macroBody = macroBody .. "\n/run if UnitExists(\"target\") and not GetRaidTargetIndex(\"target\") then SetRaidTarget(\"target\",8) end"

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_Hunter_SniperShot", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    local targets = {}
    for target in macroBody:gmatch("/target ([^\n]+)") do
        table.insert(targets, target)
    end

    print("Macro '" .. macroName .. "' has been updated with " .. table.concat(targets, ", ") .. ".")
end

SLASH_TARGETMACROADD1 = "/fm+"
SlashCmdList["TARGETMACROADD"] = function(msg)
    local macroName = "FIND"
    local macroIndex = GetMacroIndexByName(macroName)
    local macroBody = macroIndex > 0 and GetMacroBody(macroName) or ""
    local targetName

    if msg and msg ~= "" then
        targetName = msg
    else
        targetName = UnitName("target")
        if not targetName then
            print("No target selected and no name provided.")
            return
        end
    end

    -- Extract existing targets
    local existingTargets = {}
    for target in macroBody:gmatch("/target ([^\n]+)") do
        table.insert(existingTargets, target)
    end

    -- Check for duplicates
    for _, target in ipairs(existingTargets) do
        if target == targetName then
            print(targetName .. " is already in the target list.")
            return
        end
    end

    if #existingTargets >= 2 then
        print("Cannot add more than 2 targets. Use '/fmclear' to reset the list.")
        return
    end

    if macroBody == "" or not macroBody:find("/cleartarget") then
        macroBody = "/cleartarget\n/target " .. targetName
        macroBody = macroBody .. "\n/run if UnitExists(\"target\") and not GetRaidTargetIndex(\"target\") then SetRaidTarget(\"target\",8) end"
    else
        macroBody = macroBody:gsub("\n/run .+", "")
        macroBody = macroBody .. "\n/target " .. targetName
        
        local markerScript = "\n/run "
        markerScript = markerScript .. "local t1,t2=UnitName(\"target\"),\"\"; "
        markerScript = markerScript .. "TargetLastTarget(); "
        markerScript = markerScript .. "if UnitExists(\"target\") then t2=UnitName(\"target\"); end; "
        markerScript = markerScript .. "TargetByName(t1); "
        markerScript = markerScript .. "if UnitExists(\"target\") and not GetRaidTargetIndex(\"target\") then SetRaidTarget(\"target\",8); end; "
        markerScript = markerScript .. "if t2~=\"\" then TargetByName(t2); if UnitExists(\"target\") and not GetRaidTargetIndex(\"target\") then SetRaidTarget(\"target\",7); end; end"
        
        macroBody = macroBody .. markerScript
    end

    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_Hunter_SniperShot", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    local targets = {}
    for target in macroBody:gmatch("/target ([^\n]+)") do
        table.insert(targets, target)
    end

    print("Macro '" .. macroName .. "' has been updated with " .. table.concat(targets, ", ") .. ".")
end

SLASH_TARGETMACROCLEAR1 = "/fmclear"
SlashCmdList["TARGETMACROCLEAR"] = function(msg)
    local macroName = "FIND"
    local macroIndex = GetMacroIndexByName(macroName)
    
    if macroIndex > 0 then
        DeleteMacro(macroIndex)
        print("Macro '" .. macroName .. "' has been cleared.")
    else
        print("Macro '" .. macroName .. "' doesn't exist.")
    end
end


-- CREATE ADDITIONAL MACRO FOR SECOND TARGET

SLASH_TARGETMACROSECOND1 = "/fm2"
SlashCmdList["TARGETMACROSECOND"] = function(msg)
    local macroName = "FIND2"
    local macroBody

    if msg and msg ~= "" then
        macroBody = "/cleartarget\n/target " .. msg
    else
        local targetName = UnitName("target")
        if targetName then
            macroBody = "/cleartarget\n/target " .. targetName
        else
            print("No target selected and no name provided.")
            return
        end
    end

    macroBody = macroBody .. "\n/run if UnitExists(\"target\") and not GetRaidTargetIndex(\"target\") then SetRaidTarget(\"target\",7) end"

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_Hunter_SniperShot", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    print("Macro '" .. macroName .. "' has been updated with cross marker.")
end