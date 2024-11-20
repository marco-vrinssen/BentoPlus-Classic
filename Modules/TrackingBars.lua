-- Function to hide the experience bar
local function ExperienceBarHide()
    MainMenuExpBar:Hide()
    MainMenuExpBar:SetAlpha(0)
    MainMenuXPBarTexture0:Hide()
    MainMenuXPBarTexture1:Hide()
    MainMenuXPBarTexture2:Hide()
    MainMenuXPBarTexture3:Hide()
end

-- Hook the experience bar hide function to the OnShow event
MainMenuExpBar:HookScript("OnShow", ExperienceBarHide)

-- Create a frame to handle experience bar related events
local ExperienceBarEvents = CreateFrame("Frame")
ExperienceBarEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
ExperienceBarEvents:RegisterEvent("PLAYER_LEVEL_UP")
ExperienceBarEvents:RegisterEvent("PLAYER_XP_UPDATE")
ExperienceBarEvents:RegisterEvent("UPDATE_EXHAUSTION")
ExperienceBarEvents:SetScript("OnEvent", ExperienceBarHide)




-- Function to hide the reputation bar
local function ReputationBarHide()
    ReputationWatchBar.StatusBar:Hide()
    ReputationWatchBar.OverlayFrame:Hide()
    ReputationWatchBar.StatusBar.WatchBarTexture0:Hide()
    ReputationWatchBar.StatusBar.WatchBarTexture1:Hide()
    ReputationWatchBar.StatusBar.WatchBarTexture2:Hide()
    ReputationWatchBar.StatusBar.WatchBarTexture3:Hide()
end

-- Hook the reputation bar hide function to the OnShow event
ReputationWatchBar.StatusBar:HookScript("OnShow", ReputationBarHide)

-- Create a frame to handle reputation bar related events
local ReputationBarEvents = CreateFrame("Frame")
ReputationBarEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
ReputationBarEvents:RegisterEvent("UPDATE_FACTION")
ReputationBarEvents:SetScript("OnEvent", ReputationBarHide)