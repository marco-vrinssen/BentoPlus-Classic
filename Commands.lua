-- Initialize KeywordTable and get player name
local KeywordTable = {}
local playerName = UnitName("player")

-- Function to match keywords in messages
local function KeywordMatch(msg, senderName)
    local playerLink = "|Hplayer:" .. senderName .. "|h|cFFFFD500[" .. senderName .. "]: |r|h"
    print(playerLink .. msg)
    PlaySound(3175, "Master", true)
end

-- Function to filter messages based on keywords
local function KeywordFilter(msg)
    for _, keywordSet in ipairs(KeywordTable) do
        if type(keywordSet) == "string" then
            local pattern = strlower(keywordSet)
            if strfind(strlower(msg), pattern) then
                return true
            end
        elseif type(keywordSet) == "table" then
            local allMatch = true
            for _, keyword in ipairs(keywordSet) do
                local pattern = strlower(keyword)
                if not strfind(strlower(msg), pattern) then
                    allMatch = false
                    break
                end
            end
            if allMatch then
                return true
            end
        end
    end
    return false
end

-- Function to validate keywords in chat messages
local function KeywordValidation(self, event, msg, senderName, languageName, channelName, ...)
    if next(KeywordTable) and strmatch(channelName, "%d+") then
        local channelNumber = tonumber(strmatch(channelName, "%d+"))
        if channelNumber and channelNumber >= 1 and channelNumber <= 20 and KeywordFilter(msg) then
            KeywordMatch(msg, senderName)
        end
    end
end

-- Create frame to filter events
local FilterEvents = CreateFrame("Frame")
FilterEvents:SetScript("OnEvent", KeywordValidation)

-- Slash command to manage keyword filters
SLASH_FILTER1 = "/f"
SlashCmdList["FILTER"] = function(msg)
    if msg == "" then
        wipe(KeywordTable)
        print("|cFFFFD500Filter:|r Cleared.")
        FilterEvents:UnregisterEvent("CHAT_MSG_CHANNEL")
    else
        if not FilterEvents:IsEventRegistered("CHAT_MSG_CHANNEL") then
            FilterEvents:RegisterEvent("CHAT_MSG_CHANNEL")
        end

        if strfind(msg, "+") then
            local keywordSets = {strsplit(" ", msg)}
            for _, set in ipairs(keywordSets) do
                if strfind(set, "+") then
                    local compoundSet = {}
                    for keyword in string.gmatch(set, "[^+]+") do
                        table.insert(compoundSet, keyword)
                    end
                    table.insert(KeywordTable, compoundSet)
                else
                    table.insert(KeywordTable, set)
                end
            end
        else
            table.insert(KeywordTable, msg)
        end

        local newKeywordsStr = ""
        for i, keywordSet in ipairs(KeywordTable) do
            if type(keywordSet) == "string" then
                newKeywordsStr = newKeywordsStr .. "\"" .. keywordSet .. "\""
            elseif type(keywordSet) == "table" then
                local compoundStr = table.concat(keywordSet, " + ")
                newKeywordsStr = newKeywordsStr .. "\"" .. compoundStr .. "\""
            end
            if i ~= #KeywordTable then
                newKeywordsStr = newKeywordsStr .. ", "
            end
        end
        print("|cFFFFD500Filtering:|r " .. newKeywordsStr:gsub('"', '') .. ".")
    end
end

-- Slash command to whisper players from the /who list
SLASH_WHISPERWHO1 = "/ww"
SlashCmdList["WHISPERWHO"] = function(msg)
    local limit, classExclusion, message

    limit, classExclusion, message = msg:match("^(%d+)%s*-%s*(%w+)%s+(.+)$")
    if not limit then
        limit, message = msg:match("^(%d+)%s+(.+)$")
        if not limit then
            classExclusion, message = msg:match("^%-(%w+)%s+(.+)$")
            if not classExclusion then
                message = msg
            end
        end
    end

    local numWhos = C_FriendList.GetNumWhoResults()

    if limit then
        limit = tonumber(limit)
    else
        limit = numWhos
    end

    if classExclusion then
        classExclusion = classExclusion:lower()
    end

    if message and message ~= "" and numWhos and numWhos > 0 then
        local count = 0
        for i = 1, numWhos do
            if count >= limit then break end
            local info = C_FriendList.GetWhoInfo(i)
            if info and info.fullName then
                if classExclusion then
                    if info.classStr:lower() ~= classExclusion then
                        SendChatMessage(message, "WHISPER", nil, info.fullName)
                        count = count + 1
                    end
                else
                    SendChatMessage(message, "WHISPER", nil, info.fullName)
                    count = count + 1
                end
            end
        end
    end
end

-- Track recent whispers
local recentWhispers = {}

-- Slash command to whisper the last N players
SLASH_WHISPERLASTN1 = "/wl"
SlashCmdList["WHISPERLASTN"] = function(msg)
    local num, message = msg:match("^(%d+) (.+)$")

    if not num then
        message = msg
        num = #recentWhispers
    else
        num = tonumber(num)
    end

    if num and message and message ~= "" then
        local whispered = {}
        for i = math.max(#recentWhispers - num + 1, 1), #recentWhispers do
            local playerName = recentWhispers[i]
            if playerName and not whispered[playerName] then
                SendChatMessage(message, "WHISPER", nil, playerName)
                whispered[playerName] = true
            end
        end
    end
end

-- Function to track whispers
local function TrackWhispers(_, _, msg, playerName)
    table.insert(recentWhispers, playerName)
    if #recentWhispers > 100 then
        table.remove(recentWhispers, 1)
    end
end

-- Create frame to track whisper events
local WhisperLastEvents = CreateFrame("Frame")
WhisperLastEvents:RegisterEvent("CHAT_MSG_WHISPER")
WhisperLastEvents:SetScript("OnEvent", TrackWhispers)

-- Slash command to close temporary chat tabs
SLASH_CLOSETABS1 = "/c"
SlashCmdList["CLOSETABS"] = function()
    for _, chatFrameName in pairs(CHAT_FRAMES) do
        local chatFrame = _G[chatFrameName]
        if chatFrame and chatFrame.isTemporary then
            FCF_Close(chatFrame)
        end
    end
end

-- Slash command to initiate a ready check
SLASH_READYCHECK1 = "/rc"
SlashCmdList["READYCHECK"] = function()
    DoReadyCheck()
end

-- Slash command to leave the party
SLASH_QUITPARTY1 = "/q"
SlashCmdList["QUITPARTY"] = function()
    if IsInGroup() then
        LeaveParty()
    end
end

-- Function to toggle Lua errors
local function ToggleLuaErrors()
    local currentSetting = GetCVar("scriptErrors")
    if currentSetting == "1" then
        SetCVar("scriptErrors", 0)
        print("LUA Errors Off")
    else
        SetCVar("scriptErrors", 1)
        print("LUA Errors On")
    end
end

-- Slash command to toggle Lua errors
SLASH_TOGGLELUA1 = "/lua"
SlashCmdList["TOGGLELUA"] = ToggleLuaErrors

-- Function to reload the UI
local function CustomReloadUI()
    ReloadUI()
end

-- Slash command to reload the UI
SLASH_RELOADUI1 = "/ui"
SlashCmdList["RELOADUI"] = CustomReloadUI

-- Function to restart graphics engine
local function CustomGXRestart()
    ConsoleExec("gxRestart")
end

-- Slash command to restart graphics engine
SLASH_GXRESTART1 = "/gx"
SlashCmdList["GXRESTART"] = CustomGXRestart

-- Function to reload UI and restart graphics engine
local function CustomReloadAndRestart()
    ConsoleExec("gxRestart")
    ReloadUI()
end

-- Slash command to reload UI and restart graphics engine
SLASH_RELOADANDRESTART1 = "/rl"
SlashCmdList["RELOADANDRESTART"] = CustomReloadAndRestart