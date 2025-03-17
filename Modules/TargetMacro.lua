-- REGISTER SLASH COMMANDS

SLASH_TARGETMACRO1 = "/fm"
SlashCmdList["TARGETMACRO"] = function(msg)
    local macroName = "FIND"
    local macroBody

    -- HANDLE NO TARGET CASE

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

    -- CREATE OR UPDATE MACRO IN GENERAL TAB WITH RED ARROW ICON

    macroBody = macroBody .. "\n/run local m=8; if UnitExists(\"target\") and GetRaidTargetIndex(\"target\")~=m then SetRaidTarget(\"target\",m) end"

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

-- REGISTER SLASH COMMAND FOR ADDING TARGETS

SLASH_TARGETMACROADD1 = "/fm+"
SlashCmdList["TARGETMACROADD"] = function(msg)
    local macroName = "FIND"
    local macroBody = GetMacroBody(macroName) or ""
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

    local count = select(2, macroBody:gsub("/target", ""))
    if count >= 3 then
        print("Cannot add more than 3 targets.")
        return
    end

    macroBody = macroBody:gsub("\n/run .+", "") -- Remove existing run command
    macroBody = macroBody .. "\n/target " .. targetName

    macroBody = macroBody .. "\n/run local m=8; if UnitExists(\"target\") and GetRaidTargetIndex(\"target\")~=m then SetRaidTarget(\"target\",m) end"

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