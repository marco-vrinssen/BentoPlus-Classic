-- Intro message and command to check out available commands

local function CommandsIntro()
    print("|cFFFFFF00Type /bentocmd for available commands.|r")
end

local IntroEvents = CreateFrame("Frame")
IntroEvents:RegisterEvent("PLAYER_LOGIN")
IntroEvents:SetScript("OnEvent", CommandsIntro)

SLASH_BENTOCMD1 = "/bentocmd"
SlashCmdList["BENTOCMD"] = function(msg, editBox)
    if msg == "" then
        print("|cFFFFFF00/f KEYWORD|r: Filters all active channels for KEYWORD and reposts matching messages.")
        print("|cFFFFFF00/f KEYWORD1+KEYWORD2|r: Filters all active channels for the combination of KEYWORD1 and KEYWORD2 and reposts matching messages.")
        print("|cFFFFFF00/f|r: Clears and stops the filtering.")

        print("|cFFFFFF00/bc MESSAGE|r: Broadcasts the MESSAGE across all joined channels.")
        print("|cFFFFFF00/bc N1-N2 MESSAGE|r: Broadcasts the MESSAGE across all specified channels, where N1 and N2 are indicating the inclusive range of channels to be targeted.")

        print("|cFFFFFF00/ww MESSAGE|r: Sends the MESSAGE to all players in a currently open /who instance.")
        print("|cFFFFFF00/ww N MESSAGE|r: Sends the MESSAGE to the first N count of players in a currently open /who instance.")
        print("|cFFFFFF00/ww -CLASS MESSAGE|r: Sends the MESSAGE to all players who are not of the specified CLASS in a currently open /who instance.")
        print("|cFFFFFF00/ww N -CLASS MESSAGE|r: Sends the MESSAGE to the first N count of players who are not of the specified CLASS in a currently open /who instance.")
        print("|cFFFFFF00/wl N MESSAGE|r: Sends the MESSAGE to the last N players who whispered you.")

        print("|cFFFFFF00/rc|r: Perform a ready check.")
        print("|cFFFFFF00/q|r: Leaves the current party or raid.")
        print("|cFFFFFF00/ui|r: Reloads the user interface.")
        print("|cFFFFFF00/gx|r: Restarts the graphics engine.")
        print("|cFFFFFF00/rl|r: Reloads the user interface and the graphics engine.")
        print("|cFFFFFF00/lua|r: Toggles the display of LUA errors.")

        print("|cFFFFFF00CTRL + P / CMD + P while hovering over an Item|r: Generates a URL for Auction Goblin for that item.")
        print("|cFFFFFF00Right click a player name or portrait|r: Have two menu entries to generate an armory or warcraft logs link for that player.")
    end
end