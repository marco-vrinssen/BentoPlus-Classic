--- Hides the specified bar and its textures.
-- @param bar The bar to hide.
-- @param textures A table of textures to hide.
local function HideBar(bar, textures)
    bar:Hide()
    for _, texture in ipairs(textures) do
        texture:Hide()
    end
end

--- Hides the experience bar and its textures.
local function ExperienceBarHide()
    HideBar(MainMenuExpBar, {
        MainMenuXPBarTexture0,
        MainMenuXPBarTexture1,
        MainMenuXPBarTexture2,
        MainMenuXPBarTexture3
    })
    MainMenuExpBar:SetAlpha(0)
end

--- Hides the reputation bar and its textures.
local function ReputationBarHide()
    HideBar(ReputationWatchBar.StatusBar, {
        ReputationWatchBar.StatusBar.WatchBarTexture0,
        ReputationWatchBar.StatusBar.WatchBarTexture1,
        ReputationWatchBar.StatusBar.WatchBarTexture2,
        ReputationWatchBar.StatusBar.WatchBarTexture3
    })
    ReputationWatchBar.OverlayFrame:Hide()
end

MainMenuExpBar:HookScript("OnShow", ExperienceBarHide)
ReputationWatchBar.StatusBar:HookScript("OnShow", ReputationBarHide)

local BarEvents = CreateFrame("Frame")
BarEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
BarEvents:RegisterEvent("PLAYER_LEVEL_UP")
BarEvents:RegisterEvent("PLAYER_XP_UPDATE")
BarEvents:RegisterEvent("UPDATE_EXHAUSTION")
BarEvents:RegisterEvent("UPDATE_FACTION")
BarEvents:SetScript("OnEvent", function(self, event)
    ExperienceBarHide()
    ReputationBarHide()
end)