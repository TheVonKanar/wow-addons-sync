-- Edit Mode Tweaks Nudge Frame
local addonName, EMT = ...

local NudgeFrame = CreateFrame("Frame", "EMT_NudgeFrame", UIParent, "BackdropTemplate")
EMT.nudgeFrame = NudgeFrame

-- Frame properties
NudgeFrame:SetSize(180, 430)
NudgeFrame:SetFrameStrata("DIALOG")
NudgeFrame:SetClampedToScreen(true)
NudgeFrame:EnableMouse(true)
NudgeFrame:SetMovable(false) -- Not draggable when docked
NudgeFrame:Hide()

-- Backdrop
NudgeFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})

-- Position the frame docked to the left of Edit Mode frame
function NudgeFrame:UpdatePosition()
    if EditModeManagerFrame then
        self:ClearAllPoints()
        self:SetPoint("RIGHT", EditModeManagerFrame, "LEFT", 0, 0)
    end
end

-- Title text
local title = NudgeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -12)
title:SetText("EMT Nudge")

-- Info text showing current selection
local infoText = NudgeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
infoText:SetPoint("TOP", title, "BOTTOM", 0, -8)
infoText:SetText("No selection")
infoText:SetTextColor(0.7, 0.7, 0.7)
infoText:SetWidth(160)
infoText:SetWordWrap(true)
NudgeFrame.infoText = infoText

-- Helper function to create arrow buttons (using TOP anchor for predictable positioning)
local function CreateArrowButton(parent, direction, x, yFromTop)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(32, 32)
    button:SetPoint("TOP", parent, "TOP", x, yFromTop)
    
    -- Button background
    button:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
    button:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
    button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    
    -- Rotate texture based on direction
    local texture = button:GetNormalTexture()
    if direction == "UP" then
        texture:SetRotation(math.rad(90))
        button:GetPushedTexture():SetRotation(math.rad(90))
    elseif direction == "DOWN" then
        texture:SetRotation(math.rad(270))
        button:GetPushedTexture():SetRotation(math.rad(270))
    elseif direction == "LEFT" then
        texture:SetRotation(math.rad(180))
        button:GetPushedTexture():SetRotation(math.rad(180))
    elseif direction == "RIGHT" then
        texture:SetRotation(math.rad(0))
        button:GetPushedTexture():SetRotation(math.rad(0))
    end
    
    button:SetScript("OnClick", function()
        local frame, frameName = EMT:GetSelectedFrame()
        if frame then
            if EMT:NudgeFrame(frame, direction) then
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
                NudgeFrame:UpdateInfo()
            else
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
            end
        end
    end)
    
    -- Tooltip
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Nudge " .. direction:lower())
        GameTooltip:AddLine("Move selected element 1 pixel " .. direction:lower(), 1, 1, 1)
        GameTooltip:Show()
    end)
    
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    return button
end

-- Create directional buttons - positioned from TOP of frame
-- Frame is 400px tall, title is at -12, info at -20
-- Place buttons at around -60 to -120 from top (in the middle empty area)
NudgeFrame.upButton = CreateArrowButton(NudgeFrame, "UP", 0, -60)
NudgeFrame.downButton = CreateArrowButton(NudgeFrame, "DOWN", 0, -120)
NudgeFrame.leftButton = CreateArrowButton(NudgeFrame, "LEFT", -25, -90)
NudgeFrame.rightButton = CreateArrowButton(NudgeFrame, "RIGHT", 25, -90)

-- Close button
local closeButton = CreateFrame("Button", nil, NudgeFrame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", -5, -5)
closeButton:SetScript("OnClick", function()
    -- Just hide temporarily, don't change the setting
    -- Frame will show again next time Edit Mode is entered
    NudgeFrame:Hide()
end)

-- Profiles button - positioned below arrow buttons
local profilesButton = CreateFrame("Button", nil, NudgeFrame, "UIPanelButtonTemplate")
profilesButton:SetSize(120, 22)
profilesButton:SetPoint("TOP", 0, -160)
profilesButton:SetText("Profiles")
NudgeFrame.profilesButton = profilesButton

profilesButton:SetScript("OnClick", function()
    if EMT.profileWindow then
        if EMT.profileWindow:IsShown() then
            EMT.profileWindow:Hide()
        else
            EMT.profileWindow:Show()
        end
    end
end)

-- Tooltip for profiles button
profilesButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Profile Manager")
    GameTooltip:AddLine("Manage visibility profiles and spec assignments.", 1, 1, 1, true)
    GameTooltip:Show()
end)

profilesButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Nudge amount slider - positioned above Mouse Over checkbox
local amountSlider = CreateFrame("Slider", nil, NudgeFrame, "OptionsSliderTemplate")
amountSlider:SetPoint("BOTTOM", 0, 180)
amountSlider:SetMinMaxValues(1, 5)
amountSlider:SetValueStep(1)
amountSlider:SetObeyStepOnDrag(true)
amountSlider:SetWidth(140)
amountSlider:SetHeight(15)
NudgeFrame.amountSlider = amountSlider

-- Slider label
local amountLabel = NudgeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
amountLabel:SetPoint("BOTTOM", amountSlider, "TOP", 0, 2)
amountLabel:SetText("Nudge Amount: 1px")
NudgeFrame.amountLabel = amountLabel

-- Slider min/max labels
amountSlider.Low:SetText("1")
amountSlider.High:SetText("5")

-- Slider value change handler
amountSlider:SetScript("OnValueChanged", function(self, value)
    value = math.floor(value + 0.5) -- Round to nearest integer
    EMT.db.nudgeAmount = value
    amountLabel:SetText("Nudge Amount: " .. value .. "px")
end)

-- Mouse-over toggle button - positioned with better spacing
local mouseOverButton = CreateFrame("CheckButton", nil, NudgeFrame, "UICheckButtonTemplate")
mouseOverButton:SetPoint("BOTTOM", -50, 140)
mouseOverButton:SetSize(24, 24)
NudgeFrame.mouseOverButton = mouseOverButton

-- Mouse-over label - positioned to the right of the checkbox
local mouseOverLabel = NudgeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
mouseOverLabel:SetPoint("LEFT", mouseOverButton, "RIGHT", 5, 0)
mouseOverLabel:SetText("Only visible\nwith mouseover")
mouseOverLabel:SetTextColor(1, 1, 1)
mouseOverLabel:SetJustifyH("LEFT")

-- Combat visibility toggle button
local combatButton = CreateFrame("CheckButton", nil, NudgeFrame, "UICheckButtonTemplate")
combatButton:SetPoint("BOTTOM", -50, 95)
combatButton:SetSize(24, 24)
NudgeFrame.combatButton = combatButton

-- Combat visibility label
local combatLabel = NudgeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
combatLabel:SetPoint("LEFT", combatButton, "RIGHT", 5, 0)
combatLabel:SetText("Hide when\nnot in combat")
combatLabel:SetTextColor(1, 1, 1)
combatLabel:SetJustifyH("LEFT")

-- Target visibility toggle button
local targetButton = CreateFrame("CheckButton", nil, NudgeFrame, "UICheckButtonTemplate")
targetButton:SetPoint("BOTTOM", -50, 50)
targetButton:SetSize(24, 24)
NudgeFrame.targetButton = targetButton

-- Target visibility label
local targetLabel = NudgeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
targetLabel:SetPoint("LEFT", targetButton, "RIGHT", 5, 0)
targetLabel:SetText("Show only\nwith target")
targetLabel:SetTextColor(1, 1, 1)
targetLabel:SetJustifyH("LEFT")

-- Explanatory note
local noteLabel = NudgeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
noteLabel:SetPoint("BOTTOM", 0, 10)
noteLabel:SetWidth(165)
noteLabel:SetText("UI element will show if any\ncondition is met.")
noteLabel:SetTextColor(0.7, 0.7, 0.7)
noteLabel:SetJustifyH("CENTER")

-- Mouse-over button click handler
mouseOverButton:SetScript("OnClick", function(self)
    local frame, frameName = EMT:GetSelectedFrame()
    if frame and frameName and frameName ~= "Anonymous Frame" then
        local enabled = self:GetChecked()
        EMT:SetMouseOverEnabled(frameName, enabled)
        PlaySound(enabled and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        -- Update profile window to show unsaved changes
        if EMT.profileWindow and EMT.profileWindow:IsShown() then
            EMT.profileWindow:Update()
        end
    end
end)

-- Tooltip for mouse-over button
mouseOverButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Only Visible With Mouseover")
    GameTooltip:AddLine("When enabled, this UI element will only appear when you mouse over it.", 1, 1, 1, true)
    GameTooltip:Show()
end)

mouseOverButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Combat button click handler
combatButton:SetScript("OnClick", function(self)
    local frame, frameName = EMT:GetSelectedFrame()
    if frame and frameName and frameName ~= "Anonymous Frame" then
        local enabled = self:GetChecked()
        EMT:SetCombatVisibilityEnabled(frameName, enabled)
        PlaySound(enabled and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        -- Update profile window to show unsaved changes
        if EMT.profileWindow and EMT.profileWindow:IsShown() then
            EMT.profileWindow:Update()
        end
    end
end)

-- Tooltip for combat button
combatButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Hide When Not In Combat")
    GameTooltip:AddLine("When enabled, this UI element will be hidden when you're out of combat.", 1, 1, 1, true)
    GameTooltip:Show()
end)

combatButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Target button click handler
targetButton:SetScript("OnClick", function(self)
    local frame, frameName = EMT:GetSelectedFrame()
    if frame and frameName and frameName ~= "Anonymous Frame" then
        local enabled = self:GetChecked()
        EMT:SetTargetVisibilityEnabled(frameName, enabled)
        PlaySound(enabled and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        -- Update profile window to show unsaved changes
        if EMT.profileWindow and EMT.profileWindow:IsShown() then
            EMT.profileWindow:Update()
        end
    end
end)

-- Tooltip for target button
targetButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Show Only With Target")
    GameTooltip:AddLine("When enabled, this UI element will only appear when you have a target.", 1, 1, 1, true)
    GameTooltip:Show()
end)

targetButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Update amount slider
function NudgeFrame:UpdateAmountSlider()
    local amount = EMT.db.nudgeAmount
    self.amountSlider:SetValue(amount)
    self.amountLabel:SetText("Nudge Amount: " .. amount .. "px")
end

-- Update info about selected element
function NudgeFrame:UpdateInfo()
    local frame, frameName = EMT:GetSelectedFrame()
    if frame and frameName then
        if frameName == "Anonymous Frame" then
            -- Hide the frame for anonymous selections
            self:Hide()
        else
            -- Show and update for named frames
            if EditModeManagerFrame and EditModeManagerFrame.editModeActive and EMT.db.showNudgeFrame then
                if not self:IsShown() then
                    self:UpdatePosition()
                    self:Show()
                end
            end
            
            self.infoText:SetText(frameName)
            self.infoText:SetTextColor(0, 1, 0)
            
            -- Update all visibility button states
            local mouseOverEnabled = EMT:IsMouseOverEnabled(frameName)
            local combatEnabled = EMT:IsCombatVisibilityEnabled(frameName)
            local targetEnabled = EMT:IsTargetVisibilityEnabled(frameName)
            
            self.mouseOverButton:SetChecked(mouseOverEnabled)
            self.combatButton:SetChecked(combatEnabled)
            self.targetButton:SetChecked(targetEnabled)
            
            self.mouseOverButton:Enable()
            self.combatButton:Enable()
            self.targetButton:Enable()
        end
    else
        self.infoText:SetText("Click a frame")
        self.infoText:SetTextColor(0.7, 0.7, 0.7)
        self.mouseOverButton:SetChecked(false)
        self.combatButton:SetChecked(false)
        self.targetButton:SetChecked(false)
        self.mouseOverButton:Disable()
        self.combatButton:Disable()
        self.targetButton:Disable()
    end
end

-- Update visibility based on Edit Mode state and settings
function NudgeFrame:UpdateVisibility()
    if EditModeManagerFrame and EditModeManagerFrame.editModeActive and EMT.db.showNudgeFrame then
        -- Always show when Edit Mode opens
        self:UpdatePosition()
        self:Show()
        self:UpdateInfo()
        self:UpdateAmountSlider()
    else
        self:Hide()
    end
end

-- Update on show
NudgeFrame:SetScript("OnShow", function(self)
    self:UpdatePosition()
    self:UpdateInfo()
    self:UpdateAmountSlider()
end)

-- Hook into Edit Mode to show/hide the nudge frame
if EditModeManagerFrame then
    hooksecurefunc(EditModeManagerFrame, "EnterEditMode", function()
        NudgeFrame:UpdateVisibility()
    end)
    
    hooksecurefunc(EditModeManagerFrame, "ExitEditMode", function()
        NudgeFrame:Hide()
    end)
else
    -- If Edit Mode frame doesn't exist yet, wait for it
    local waitFrame = CreateFrame("Frame")
    waitFrame:RegisterEvent("ADDON_LOADED")
    waitFrame:SetScript("OnEvent", function(self, event, arg1)
        if EditModeManagerFrame then
            hooksecurefunc(EditModeManagerFrame, "EnterEditMode", function()
                NudgeFrame:UpdateVisibility()
            end)
            
            hooksecurefunc(EditModeManagerFrame, "ExitEditMode", function()
                NudgeFrame:Hide()
            end)
            
            self:UnregisterAllEvents()
        end
    end)
end
