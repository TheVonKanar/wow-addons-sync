-- ============================================================================
-- TweaksUI: Cooldowns - Settings UI
-- Main settings hub and panels for configuring cooldown trackers
-- ============================================================================

local ADDON_NAME, TUICD = ...

TUICD.Settings = {}
local Settings = TUICD.Settings

-- ============================================================================
-- LOCAL VARIABLES
-- ============================================================================

local settingsHub = nil
local settingsPanels = {}
local currentOpenPanel = nil
local initialized = false

-- ============================================================================
-- UI HELPERS
-- ============================================================================

local function CreateBackdrop(frame)
    if frame.SetBackdrop then
        frame:SetBackdrop(TUICD.BACKDROP_DARK)
    elseif BackdropTemplateMixin then
        Mixin(frame, BackdropTemplateMixin)
        frame:SetBackdrop(TUICD.BACKDROP_DARK)
    end
end

local function CreateButton(parent, text, width, height)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(width or 120, height or 24)
    button:SetText(text)
    return button
end

local function CreateCheckbox(parent, text, tooltip)
    local check = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    check.Text:SetText(text)
    if tooltip then
        check.tooltipText = tooltip
    end
    return check
end

local function CreateSlider(parent, label, min, max, step, width)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(width or 200, 45)
    
    local slider = CreateFrame("Slider", nil, container, "OptionsSliderTemplate")
    slider:SetPoint("TOP", 0, -15)
    slider:SetSize((width or 200) - 20, 17)
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step or 1)
    slider:SetObeyStepOnDrag(true)
    
    slider.Low:SetText(tostring(min))
    slider.High:SetText(tostring(max))
    
    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("BOTTOM", slider, "TOP", 0, 3)
    title:SetText(label)
    
    local value = container:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    value:SetPoint("TOP", slider, "BOTTOM", 0, -2)
    
    slider:SetScript("OnValueChanged", function(self, val)
        value:SetText(string.format("%.2f", val))
    end)
    
    container.slider = slider
    container.value = value
    
    return container
end

local function CreateDropdown(parent, label, width)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(width or 180, 45)
    
    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 0, 0)
    title:SetText(label)
    
    local dropdown = CreateFrame("Frame", nil, container, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", -16, -15)
    UIDropDownMenu_SetWidth(dropdown, (width or 180) - 40)
    
    container.dropdown = dropdown
    
    return container
end

-- ============================================================================
-- SETTINGS HUB
-- ============================================================================

local function CreateSettingsHub()
    if settingsHub then return settingsHub end
    
    local frame = CreateFrame("Frame", "TUICD_SettingsHub", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(TUICD.UI.HUB_WIDTH, TUICD.UI.HUB_HEIGHT)
    frame:SetPoint("CENTER", -200, 0)
    frame:SetFrameStrata("HIGH")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetClampedToScreen(true)
    frame:Hide()
    
    -- Register for ESC to close
    tinsert(UISpecialFrames, "TUICD_SettingsHub")
    
    -- Lock layout mode when hub is closed (ESC or close button)
    frame:SetScript("OnHide", function()
        if TUICD.LayoutMode and TUICD.LayoutMode:IsUnlocked() then
            TUICD.LayoutMode:Lock()
        end
        -- Also close any open panels
        if currentOpenPanel and settingsPanels[currentOpenPanel] then
            settingsPanels[currentOpenPanel]:Hide()
        end
    end)
    
    -- Title
    frame.TitleText:SetText("TweaksUI: Cooldowns")
    
    -- Version
    local version = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    version:SetPoint("TOP", frame.TitleText, "BOTTOM", 0, -2)
    version:SetText("|cff00ff00v" .. TUICD.VERSION .. "|r")
    
    -- Content area starts below title bar
    local contentTop = -50
    local yOffset = contentTop
    local buttonWidth = TUICD.UI.HUB_WIDTH - 50
    
    -- Tracker buttons
    local trackerOrder = { "essential", "utility", "buffs", "customTrackers" }
    local trackerNames = {
        essential = "Essential Cooldowns",
        utility = "Utility Cooldowns",
        buffs = "Buff Tracker",
        customTrackers = "Custom Trackers",
    }
    
    for _, trackerKey in ipairs(trackerOrder) do
        -- Settings button (full width, no checkbox)
        local settingsBtn = CreateButton(frame, trackerNames[trackerKey], buttonWidth, TUICD.UI.BUTTON_HEIGHT)
        settingsBtn:SetPoint("TOP", frame, "TOP", 0, yOffset)
        settingsBtn.trackerKey = trackerKey
        
        settingsBtn:SetScript("OnClick", function()
            Settings:OpenTrackerPanel(trackerKey)
        end)
        
        frame["tracker_" .. trackerKey] = settingsBtn
        
        yOffset = yOffset - (TUICD.UI.BUTTON_HEIGHT + TUICD.UI.BUTTON_SPACING)
    end
    
    -- Divider
    local divider = frame:CreateTexture(nil, "ARTWORK")
    divider:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, yOffset - 5)
    divider:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, yOffset - 5)
    divider:SetHeight(1)
    divider:SetColorTexture(0.4, 0.4, 0.4, 0.8)
    
    yOffset = yOffset - 15
    
    -- Unlock/Lock Frames button
    local layoutBtn = CreateButton(frame, "Unlock Frames", buttonWidth, 28)
    layoutBtn:SetPoint("TOP", frame, "TOP", 0, yOffset)
    layoutBtn:SetScript("OnClick", function()
        if TUICD.LayoutMode then
            TUICD.LayoutMode:Toggle()
            if TUICD.LayoutMode:IsUnlocked() then
                layoutBtn:SetText("|cff00ff00Lock Frames|r")
            else
                layoutBtn:SetText("Unlock Frames")
            end
        end
    end)
    frame.layoutBtn = layoutBtn
    yOffset = yOffset - 34
    
    -- Import / Export button
    local profilesBtn = CreateButton(frame, "Profiles", buttonWidth, 28)
    profilesBtn:SetPoint("TOP", frame, "TOP", 0, yOffset)
    profilesBtn:SetScript("OnClick", function()
        if TUICD.ProfilesUI then
            TUICD.ProfilesUI:Toggle()
        end
    end)
    yOffset = yOffset - 34
    
    -- Patch Notes button
    local patchNotesBtn = CreateButton(frame, "Patch Notes", buttonWidth, 28)
    patchNotesBtn:SetPoint("TOP", frame, "TOP", 0, yOffset)
    patchNotesBtn:SetScript("OnClick", function()
        Settings:ShowPatchNotes()
    end)
    yOffset = yOffset - 34
    
    -- About / Discord button
    local aboutBtn = CreateButton(frame, "About / Discord", buttonWidth, 28)
    aboutBtn:SetPoint("TOP", frame, "TOP", 0, yOffset)
    aboutBtn:SetScript("OnClick", function()
        if TUICD.Migration and TUICD.Migration.ShowWelcome then
            TUICD.Migration:ShowWelcome()
        end
    end)
    yOffset = yOffset - 40
    
    -- Minimap button toggle
    local minimapCB = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    minimapCB:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, yOffset)
    minimapCB:SetSize(24, 24)
    minimapCB.text = minimapCB:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    minimapCB.text:SetPoint("LEFT", minimapCB, "RIGHT", 2, 0)
    minimapCB.text:SetText("Show Minimap Button")
    
    minimapCB:SetScript("OnClick", function(self)
        if TUICD.MinimapButton then
            TUICD.MinimapButton:SetShown(self:GetChecked())
        end
    end)
    frame.minimapCB = minimapCB
    
    -- Full TweaksUI promo
    local promoText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    promoText:SetPoint("BOTTOM", frame, "BOTTOM", 0, 45)
    promoText:SetWidth(TUICD.UI.HUB_WIDTH - 30)
    promoText:SetJustifyH("CENTER")
    promoText:SetText("|cff888888Want UnitFrames, CastBars,\nNameplates & more?|r")
    
    local promoLink = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    promoLink:SetPoint("TOP", promoText, "BOTTOM", 0, -4)
    promoLink:SetText("|cff00ccffCheck out the full TweaksUI suite!|r")
    
    settingsHub = frame
    return frame
end

-- ============================================================================
-- PANEL MANAGEMENT
-- ============================================================================

function Settings:RefreshHub()
    if not settingsHub then return end
    
    -- Update layout button text
    if settingsHub.layoutBtn and TUICD.LayoutMode then
        if TUICD.LayoutMode:IsUnlocked() then
            settingsHub.layoutBtn:SetText("|cff00ff00Lock Frames|r")
        else
            settingsHub.layoutBtn:SetText("Unlock Frames")
        end
    end
    
    -- Update minimap button checkbox
    if settingsHub.minimapCB then
        local showMinimap = TUICD.Database:GetGlobal("showMinimapButton")
        settingsHub.minimapCB:SetChecked(showMinimap ~= false)
    end
end

function Settings:OpenTrackerPanel(trackerKey)
    -- Delegate to Cooldowns module which has the full tabbed panels
    if TUICD.Cooldowns and TUICD.Cooldowns.TogglePanel then
        TUICD.Cooldowns:TogglePanel(trackerKey)
    end
end

function Settings:OpenHighlightsPanel()
    TUICD:Print("Proc & Buff Alerts panel coming soon!")
    -- TODO: Implement highlights configuration panel
end

function Settings:ShowPatchNotes()
    -- Create patch notes frame if it doesn't exist
    if _G["TUICD_PatchNotesFrame"] then
        _G["TUICD_PatchNotesFrame"]:Show()
        return
    end
    
    local frame = CreateFrame("Frame", "TUICD_PatchNotesFrame", UIParent, "BackdropTemplate")
    frame:SetSize(500, 450)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    frame:SetBackdropColor(0, 0, 0, 1)
    
    -- Title
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("|cff00ccffTweaksUI: Cooldowns - Patch Notes|r")
    
    -- Version
    local version = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    version:SetPoint("TOP", title, "BOTTOM", 0, -5)
    version:SetText("|cff00ff00v" .. TUICD.VERSION .. "|r")
    
    -- Scroll frame for notes
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 15, -55)
    scrollFrame:SetPoint("BOTTOMRIGHT", -35, 50)
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(440, 600)
    scrollFrame:SetScrollChild(content)
    
    local notesText = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    notesText:SetPoint("TOPLEFT", 5, -5)
    notesText:SetWidth(430)
    notesText:SetJustifyH("LEFT")
    notesText:SetSpacing(2)
    
    -- Patch notes content
    local notes = [[
|cffffcc00Version 1.5.0|r - Custom Grid Mode & Alignment

|cffff6600IMPORTANT:|r If you had a custom pattern before,
you must enable it once per character/profile:
  1. Go to Layout tab
  2. Check "Enable Custom Grid Pattern"
  3. Your pattern is preserved, just needs enabling

|cff00ff00New Features:|r
• Custom Grid system redesigned
  - Enable checkbox to activate
  - Row Mode or Column Mode
  - Start/Center/End alignment
  - Proper overflow handling
• Pattern edit box with Apply button
• Use 0 for gaps (e.g., "3,0,3")

|cffffcc00Version 1.3.0|r - Combat Opacity & Fixes

|cff00ff00New Features:|r
• Combat-based opacity settings
• Custom layout blank rows

|cffffcc00Version 1.2.0|r - Profile System

|cff00ff00New Features:|r
• Save/load settings profiles
• Automatic spec-switching
• Import/export profiles

|cff888888Slash Commands:|r
• /tuicd - Open settings
• /tuicdlayout - Toggle Layout Mode
]]
    
    notesText:SetText(notes)
    content:SetHeight(notesText:GetStringHeight() + 20)
    
    -- Close button
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    closeBtn:SetSize(100, 24)
    closeBtn:SetPoint("BOTTOM", 0, 15)
    closeBtn:SetText("Close")
    closeBtn:SetScript("OnClick", function() frame:Hide() end)
    
    -- X button
    local xBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    xBtn:SetPoint("TOPRIGHT", -5, -5)
    
    tinsert(UISpecialFrames, "TUICD_PatchNotesFrame")
    frame:Show()
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

function Settings:Toggle()
    if not settingsHub then
        CreateSettingsHub()
    end
    
    if settingsHub:IsShown() then
        settingsHub:Hide()
        if currentOpenPanel and settingsPanels[currentOpenPanel] then
            settingsPanels[currentOpenPanel]:Hide()
        end
    else
        self:RefreshHub()
        settingsHub:Show()
    end
end

function Settings:Show()
    if not settingsHub then
        CreateSettingsHub()
    end
    self:RefreshHub()
    settingsHub:Show()
end

function Settings:Hide()
    if settingsHub then
        settingsHub:Hide()
    end
    if currentOpenPanel and settingsPanels[currentOpenPanel] then
        settingsPanels[currentOpenPanel]:Hide()
    end
end

function Settings:Initialize()
    initialized = true
    TUICD:PrintDebug("Settings UI initialized")
end
