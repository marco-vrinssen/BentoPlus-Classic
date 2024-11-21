-- Update position and appearance of chat frames

-- Hide a UI element and prevent it from being shown again
local function HideUIElement(element)
    if element then
        element:Hide()
        element:SetScript("OnShow", element.Hide)
    end
end

-- Hide specified child elements of a parent frame
local function HideChildUIElements(parentFrame, childElementNames)
    for _, childName in ipairs(childElementNames) do
        local childElement = _G[parentFrame:GetName() .. childName] or parentFrame[childName]
        HideUIElement(childElement)
    end
end

-- Hide all texture regions of a frame
local function HideFrameTextures(frame)
    for _, region in ipairs({frame:GetRegions()}) do
        if region:IsObjectType("Texture") then
            HideUIElement(region)
        end
    end
end

-- Customize the appearance of a chat tab
local function CustomizeChatTab(chatFrame)
    local chatTab = _G[chatFrame:GetName() .. "Tab"]
    local chatTabText = _G[chatFrame:GetName() .. "TabText"]
    
    HideFrameTextures(chatTab)
    if chatTabText then
        chatTabText:SetFont(STANDARD_TEXT_FONT, 14)
        chatTabText:ClearAllPoints()
        chatTabText:SetPoint("LEFT", chatTab, "LEFT", 4, 0)
    end
end

-- Customize the appearance of a chat frame
local function CustomizeChatFrame(chatFrame)
    HideFrameTextures(chatFrame)
    
    local elementsToHide = {
        "ButtonFrame", "EditBoxLeft", "EditBoxMid", "EditBoxRight",
        "EditBoxHeaderSuffix", "TabUpButton", "TabDownButton",
        "TabBottomButton", "TabMinimizeButton"
    }
    
    HideChildUIElements(chatFrame, elementsToHide)
    CustomizeChatTab(chatFrame)
end

-- Align the header of the edit box for all chat frames
local function AlignEditBoxHeaders()
    for i = 1, NUM_CHAT_WINDOWS do
        local editBox = _G["ChatFrame" .. i .. "EditBox"]
        local editBoxHeader = _G["ChatFrame" .. i .. "EditBoxHeader"]
        if editBox and editBoxHeader then
            editBoxHeader:ClearAllPoints()
            editBoxHeader:SetPoint("LEFT", editBox, "LEFT", 6, 0)
        end
    end
end

-- Update all chat frames to apply customizations
local function UpdateAllChatFrames()
    for i = 1, NUM_CHAT_WINDOWS do
        CustomizeChatFrame(_G["ChatFrame" .. i])
    end
    
    HideUIElement(ChatFrameMenuButton)
    HideUIElement(ChatFrameChannelButton)
    if CombatLogQuickButtonFrame_Custom then
        CombatLogQuickButtonFrame_Custom:SetAlpha(0)
    end
    
    AlignEditBoxHeaders()
end

-- Hook chat tab click to scroll to bottom
local function HookChatTabScroll(chatFrameID)
    local chatTab = _G["ChatFrame" .. chatFrameID .. "Tab"]
    if not chatTab.scrollHooked then
        chatTab:HookScript("OnClick", function() _G["ChatFrame" .. chatFrameID]:ScrollToBottom() end)
        chatTab.scrollHooked = true
    end
end

-- Update scroll behavior for all chat frames
local function UpdateChatScrollBehavior()
    for i = 1, NUM_CHAT_WINDOWS do
        HookChatTabScroll(i)
    end
end

-- Event handler for updating chat frames and scroll behavior
local function OnChatEvent()
    UpdateAllChatFrames()
    UpdateChatScrollBehavior()
end

-- Register events for updating chat frames
local chatEvents = CreateFrame("Frame")
chatEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
chatEvents:RegisterEvent("UPDATE_FLOATING_CHAT_WINDOWS")
chatEvents:RegisterEvent("CHAT_MSG_WHISPER")
chatEvents:RegisterEvent("UI_SCALE_CHANGED")
chatEvents:SetScript("OnEvent", OnChatEvent)

-- Hook function to customize temporary chat windows
hooksecurefunc("FCF_OpenTemporaryWindow", function()
    local currentChatFrame = FCF_GetCurrentChatFrame()
    if currentChatFrame then
        CustomizeChatFrame(currentChatFrame)
        HookChatTabScroll(currentChatFrame:GetID())
        AlignEditBoxHeaders()
    end
end)