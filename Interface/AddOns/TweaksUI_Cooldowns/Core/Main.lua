-- ============================================================================
-- TweaksUI: Cooldowns - Main
-- Core addon initialization and slash commands
-- ============================================================================

local ADDON_NAME, TUICD = ...

-- ============================================================================
-- CMT COEXISTENCE DETECTION
-- ============================================================================

-- Track whether CMT is running (we will defer to it if so)
TUICD.CMT_COEXISTENCE_MODE = false

local function IsCMTLoaded()
    -- Check if CooldownManagerTweaks addon is loaded
    local loaded = C_AddOns.IsAddOnLoaded("CooldownManagerTweaks")
    -- Also check for CMT's global tables which indicate it's actually running
    local cmtRunning = _G.CMT_DB ~= nil or _G.CMT_CharDB ~= nil
    return loaded or cmtRunning
end

-- ============================================================================
-- PRINT HELPERS
-- ============================================================================

function TUICD:Print(message)
    print(self.CHAT_PREFIX .. message)
end

function TUICD:PrintError(message)
    print(self.CHAT_PREFIX .. "|cffff3333" .. message .. "|r")
end

function TUICD:PrintDebug(message)
    if self.debugMode then
        print(self.CHAT_PREFIX .. "|cff888888[DEBUG]|r " .. message)
    end
end

-- Debug mode
TUICD.debugMode = false

function TUICD:SetDebugMode(enabled)
    self.debugMode = enabled
    self.Database:SetGlobal("debugMode", enabled)
    self:Print("Debug mode " .. (enabled and "enabled" or "disabled"))
end

-- ============================================================================
-- WHAT'S NEW POPUP
-- ============================================================================

local patchNotesPopup = nil

local function ShowWhatsNewPopup()
    if patchNotesPopup then
        patchNotesPopup:Show()
        return
    end
    
    -- Create the popup frame
    local frame = CreateFrame("Frame", "TUICD_WhatsNewPopup", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(520, 450)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    
    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -5)
    frame.title:SetText("TweaksUI: Cooldowns - What's New")
    
    -- Version
    local versionText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    versionText:SetPoint("TOP", 0, -28)
    versionText:SetText("|cff00ff00Version " .. TUICD.VERSION .. "|r")
    
    -- Scroll frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 12, -50)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 55)
    
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local current = self:GetVerticalScroll()
        local maxScroll = self:GetVerticalScrollRange()
        local step = 60
        if delta > 0 then
            self:SetVerticalScroll(math.max(0, current - step))
        else
            self:SetVerticalScroll(math.min(maxScroll, current + step))
        end
    end)
    
    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(460, 800)
    scrollFrame:SetScrollChild(scrollChild)
    
    -- Content
    local content = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    content:SetPoint("TOPLEFT", 5, -5)
    content:SetWidth(450)
    content:SetJustifyH("LEFT")
    content:SetSpacing(3)
    
    local patchNotesText = [[
|cffFFD700Version 1.5.0|r

|cffFF6600IMPORTANT - READ THIS:|r

If you had a custom pattern before this update,
you must enable it once per character/profile:

  |cffFF6600 1.|r Go to the |cff00FF00Layout|r tab
  |cffFF6600 2.|r Check |cff00FF00"Enable Custom Grid Pattern"|r
  |cffFF6600 3.|r Your existing pattern is preserved

|cff00FF00NEW: Custom Grid System Redesigned|r

  |cff87CEEB-|r "Enable Custom Grid Pattern" checkbox
  |cff87CEEB-|r Mode: Row (right then down) or Column (down then right)
  |cff87CEEB-|r Alignment: Start/Center/End for each row or column
  |cff87CEEB-|r Overflow icons properly continue with alignment
  |cff87CEEB-|r Use 0 for gaps (e.g., "3,0,3" = gap in middle)


|cffFFD700Version 1.3.0|r

|cff00FF00Combat-Based Opacity|r

  |cff87CEEB-|r Separate "Out of Combat" and "In Combat" opacity
  |cff87CEEB-|r Found in Appearance tab for all trackers


|cffFFD700Version 1.2.0|r

|cff00FF00Profile System|r

  |cff87CEEB-|r Save and load tracker settings profiles
  |cff87CEEB-|r Automatic spec-switching for profiles
  |cff87CEEB-|r Import/export profiles with compressed strings


|cffFFD700Version 1.1.x|r

|cff00FF00Features|r

  |cff87CEEB-|r Per-icon custom labels
  |cff87CEEB-|r Clickthrough option
  |cff87CEEB-|r Enhanced Layout Mode with nudging
  |cff87CEEB-|r Masque skinning support


|cffFFD700Version 1.0.0|r

|cff00FF00Initial Release as TweaksUI: Cooldowns|r

Formerly Cooldown Manager Tweaks (CMT):
  |cff87CEEB-|r Custom grid layouts for all cooldown trackers
  |cff87CEEB-|r Per-tracker appearance settings (size, spacing, aspect ratio)
  |cff87CEEB-|r Visibility controls (combat, group, target, instance)
  |cff87CEEB-|r Layout Mode for easy frame positioning
  |cff87CEEB-|r Automatic migration from CMT settings
  |cff87CEEB-|r Per-Icon Highlights for proc alerts


|cff888888/tuicd patchnotes - Show this again|r
]]
    
    content:SetText(patchNotesText)
    
    local textHeight = content:GetStringHeight()
    scrollChild:SetHeight(math.max(400, textHeight + 20))
    
    -- Scroll hint
    local scrollHint = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    scrollHint:SetPoint("BOTTOM", 0, 38)
    scrollHint:SetText("|cff888888Scroll down to read more|r")
    
    -- Buttons
    local openSettingsBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    openSettingsBtn:SetSize(120, 25)
    openSettingsBtn:SetPoint("BOTTOMLEFT", 15, 12)
    openSettingsBtn:SetText("Open Settings")
    openSettingsBtn:SetScript("OnClick", function()
        frame:Hide()
        TUICD:ToggleSettings()
    end)
    
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    closeBtn:SetSize(100, 25)
    closeBtn:SetPoint("BOTTOMRIGHT", -15, 12)
    closeBtn:SetText("Close")
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    frame.CloseButton:SetScript("OnClick", function()
        frame:Hide()
    end)
    
    tinsert(UISpecialFrames, "TUICD_WhatsNewPopup")
    patchNotesPopup = frame
    frame:Show()
end

-- Check if we should show the What's New popup
local function CheckVersionAndShowPopup()
    local lastSeen = TUICD.Database:GetGlobal("lastSeenVersion")
    
    if lastSeen ~= TUICD.VERSION then
        TUICD.Database:SetGlobal("lastSeenVersion", TUICD.VERSION)
        -- Delay popup slightly so UI is fully loaded
        C_Timer.After(1.5, function()
            ShowWhatsNewPopup()
        end)
    end
end

-- Expose for slash command
function TUICD:ShowPatchNotes()
    ShowWhatsNewPopup()
end

-- ============================================================================
-- SETTINGS HUB TOGGLE
-- ============================================================================

function TUICD:ToggleSettings()
    -- In CMT coexistence mode, show the migration dialog instead
    if self.CMT_COEXISTENCE_MODE then
        if self.Migration and self.Migration.ShowMigrationCompleteDialog then
            self.Migration:ShowMigrationCompleteDialog()
        else
            self:PrintError("CMT is running. Disable CMT and reload to use TweaksUI: Cooldowns.")
        end
        return
    end
    
    if self.Settings and self.Settings.Toggle then
        self.Settings:Toggle()
    else
        self:PrintError("Settings UI not ready yet.")
    end
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:RegisterEvent("PLAYER_LOGIN")

local addonLoaded = false
local playerLoggedIn = false

local function InitializeNormally()
    -- Initialize database first
    TUICD.Database:Initialize()
    
    -- Restore debug mode
    TUICD.debugMode = TUICD.Database:GetGlobal("debugMode") or false
    
    -- Initialize profiles system
    if TUICD.Profiles and TUICD.Profiles.Initialize then
        TUICD.Profiles:Initialize()
    end
    
    -- Run startup migration check (for first-time welcome, etc.)
    if TUICD.Migration and TUICD.Migration.RunStartupMigration then
        TUICD.Migration:RunStartupMigration()
    end
    
    -- Initialize minimap button
    if TUICD.MinimapButton and TUICD.MinimapButton.Initialize then
        TUICD.MinimapButton:Initialize()
    end
    
    -- Initialize cooldowns module
    if TUICD.Cooldowns and TUICD.Cooldowns.Initialize then
        TUICD.Cooldowns:Initialize()
    end
    
    -- Initialize layout mode (after cooldowns so frames exist)
    if TUICD.LayoutMode and TUICD.LayoutMode.Initialize then
        TUICD.LayoutMode:Initialize()
    end
    
    -- Initialize highlights modules
    if TUICD.BuffHighlights and TUICD.BuffHighlights.Initialize then
        TUICD.BuffHighlights:Initialize()
    end
    if TUICD.CooldownHighlights and TUICD.CooldownHighlights.Initialize then
        TUICD.CooldownHighlights:Initialize()
    end
    
    -- Initialize settings UI
    if TUICD.Settings and TUICD.Settings.Initialize then
        TUICD.Settings:Initialize()
    end
    
    -- Print load message
    TUICD:Print("Loaded - /tuicd to configure")
    
    TUICD:PrintDebug("TweaksUI: Cooldowns initialized")
    
    -- Check if we should show What's New popup
    CheckVersionAndShowPopup()
    
    -- Fire loaded event
    TUICD.Events:Fire(TUICD.EVENTS.ADDON_LOADED)
end

local function InitializeInCoexistenceMode()
    -- CMT is running - we'll let it handle the cooldown trackers
    -- But we WILL initialize our database and run migration
    TUICD.CMT_COEXISTENCE_MODE = true
    
    -- Initialize database (needed for migration to work)
    TUICD.Database:Initialize()
    
    -- Restore debug mode
    TUICD.debugMode = TUICD.Database:GetGlobal("debugMode") or false
    
    -- Initialize minimap button (so users can click it to see the migration dialog)
    if TUICD.MinimapButton and TUICD.MinimapButton.Initialize then
        TUICD.MinimapButton:Initialize()
    end
    
    -- Now run migration from CMT
    if TUICD.Migration then
        -- Check if we've already migrated
        local alreadyMigrated = TUICD.Migration:HasMigrated()
        
        if not alreadyMigrated and TUICD.Migration:IsCMTDataAvailable() then
            -- Run migration
            local success, trackers, entries = TUICD.Migration:DoMigration()
            if success then
                TUICD:Print("|cff00ff00Settings migrated from CMT!|r")
                TUICD:Print("Migrated " .. (trackers or 0) .. " tracker(s) and " .. (entries or 0) .. " custom entries.")
            end
        end
        
        -- Show the migration complete dialog (tells user to disable CMT)
        C_Timer.After(2, function()
            if TUICD.Migration.ShowMigrationCompleteDialog then
                TUICD.Migration:ShowMigrationCompleteDialog()
            end
        end)
    end
    
    -- Print coexistence notice
    TUICD:Print("|cffffcc00CMT detected.|r Running in migration mode. Your settings have been imported.")
    TUICD:Print("Disable CMT and reload to activate TweaksUI: Cooldowns.")
    
    -- DO NOT initialize the cooldowns module, layout mode, highlights, etc.
    -- CMT will handle those - we're just sitting here ready to take over after reload
end

local function OnAddonLoaded()
    if not addonLoaded or not playerLoggedIn then return end
    
    -- Check if CMT is loaded
    if IsCMTLoaded() then
        -- CMT is running - go into coexistence/migration mode
        InitializeInCoexistenceMode()
    else
        -- CMT is not running - initialize normally
        InitializeNormally()
    end
end

initFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 == "TweaksUI_Cooldowns" then
            addonLoaded = true
            OnAddonLoaded()
        end
    elseif event == "PLAYER_LOGIN" then
        playerLoggedIn = true
        OnAddonLoaded()
    end
end)

-- ============================================================================
-- SLASH COMMANDS
-- ============================================================================

SLASH_TUICD1 = "/tuicd"
SLASH_TUICD2 = "/tweaksuicooldowns"
SlashCmdList["TUICD"] = function(msg)
    msg = (msg or ""):lower():trim()
    
    -- In coexistence mode, most commands should show the migration dialog
    if TUICD.CMT_COEXISTENCE_MODE then
        if msg == "debug" then
            TUICD:SetDebugMode(not TUICD.debugMode)
        elseif msg == "help" then
            TUICD:Print("TweaksUI: Cooldowns is in |cffffcc00CMT Coexistence Mode|r")
            TUICD:Print("CMT is handling your cooldown trackers.")
            TUICD:Print("Your settings have been migrated to TweaksUI: Cooldowns.")
            TUICD:Print("|cff00ff00Disable CMT and reload to switch over.|r")
        else
            -- Show migration dialog for any other command
            if TUICD.Migration and TUICD.Migration.ShowMigrationCompleteDialog then
                TUICD.Migration:ShowMigrationCompleteDialog()
            else
                TUICD:Print("CMT is running. Disable CMT and reload to use TweaksUI: Cooldowns.")
            end
        end
        return
    end
    
    -- Normal mode commands
    if msg == "" or msg == "settings" or msg == "config" then
        TUICD:ToggleSettings()
        
    elseif msg == "debug" then
        TUICD:SetDebugMode(not TUICD.debugMode)
        
    elseif msg == "reset" then
        StaticPopupDialogs["TUICD_RESET_CONFIRM"] = {
            text = "Are you sure you want to reset all TweaksUI: Cooldowns settings?\n\nThis cannot be undone.",
            button1 = "Reset",
            button2 = "Cancel",
            OnAccept = function()
                TweaksUI_Cooldowns_CharDB = nil
                TUICD.Database:Initialize()
                ReloadUI()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("TUICD_RESET_CONFIRM")
        
    elseif msg == "help" then
        TUICD:Print("Commands:")
        print("  /tuicd - Open settings")
        print("  /tuicd layout - Toggle layout mode")
        print("  /tuicd profiles - Open profiles panel")
        print("  /tuicd debug - Toggle debug mode")
        print("  /tuicd reset - Reset all settings")
        print("  /tuicd resetpos - Reset all tracker positions")
        print("  /tuicd resettext - Reset text settings to defaults")
        print("  /tuicd patchnotes - Show patch notes")
        print("  /tuicdmigrate - CMT migration commands")
        print("")
        print("  |cff888888Shortcuts:|r")
        print("  /cmt - Same as /tuicd")
        print("  /rl - Reload UI")
        print("  /em - Toggle Edit Mode")
        print("  /cdm - Open Blizzard Cooldown Manager")
        
    elseif msg == "patchnotes" or msg == "whatsnew" then
        TUICD:ShowPatchNotes()
        
    elseif msg == "profiles" then
        if TUICD.ProfilesUI then
            TUICD.ProfilesUI:Toggle()
        end
        
    elseif msg == "resetpos" then
        TUICD.Database:ClearContainerPositions()
        TUICD:Print("All tracker positions reset. Reload UI to apply.")
        
    elseif msg == "resettext" then
        -- Reset all text settings to defaults for all trackers
        local trackerKeys = {"essential", "utility", "buffs", "custom"}
        local textSettings = {
            "cooldownTextScale", "cooldownTextOffsetX", "cooldownTextOffsetY",
            "cooldownTextColorR", "cooldownTextColorG", "cooldownTextColorB", "cooldownTextFont",
            "countTextScale", "countTextOffsetX", "countTextOffsetY",
            "countTextColorR", "countTextColorG", "countTextColorB", "countTextFont"
        }
        local defaults = {
            cooldownTextScale = 1.0, cooldownTextOffsetX = 0, cooldownTextOffsetY = 0,
            cooldownTextColorR = 1.0, cooldownTextColorG = 1.0, cooldownTextColorB = 1.0, cooldownTextFont = "Default",
            countTextScale = 1.0, countTextOffsetX = 0, countTextOffsetY = 0,
            countTextColorR = 1.0, countTextColorG = 1.0, countTextColorB = 1.0, countTextFont = "Default"
        }
        
        for _, trackerKey in ipairs(trackerKeys) do
            local settings = TUICD.Database:GetTrackerSettings(trackerKey)
            if settings then
                for _, key in ipairs(textSettings) do
                    settings[key] = defaults[key]
                end
            end
        end
        
        TUICD:Print("Text settings reset to defaults for all trackers.")
        TUICD:Print("Reload UI to apply changes: /rl")
        
    elseif msg == "layout" then
        if TUICD.LayoutMode and TUICD.LayoutMode.Toggle then
            TUICD.LayoutMode:Toggle()
        else
            TUICD:PrintError("Layout Mode not available.")
        end
        
    else
        TUICD:Print("Unknown command. Type /tuicd help for available commands.")
    end
end

-- ============================================================================
-- CONVENIENCE SLASH COMMANDS
-- ============================================================================

-- /cmt - Alias for /tuicd (familiar for CMT users)
SLASH_CMT1 = "/cmt"
SlashCmdList["CMT"] = function(msg)
    SlashCmdList["TUICD"](msg)
end

-- /rl - Reload UI (common convenience command)
SLASH_TUICDRL1 = "/rl"
SlashCmdList["TUICDRL"] = function()
    ReloadUI()
end

-- /em - Open Edit Mode
SLASH_TUICDEM1 = "/em"
SlashCmdList["TUICDEM"] = function()
    if EditModeManagerFrame and EditModeManagerFrame.Show then
        if EditModeManagerFrame:IsShown() then
            EditModeManagerFrame:Hide()
        else
            EditModeManagerFrame:Show()
        end
    else
        TUICD:PrintError("Edit Mode not available.")
    end
end

-- /cdm - Open Blizzard's Cooldown Manager settings
SLASH_TUICDCDM1 = "/cdm"
SlashCmdList["TUICDCDM"] = function()
    -- CooldownViewerSettings is Blizzard's Cooldown Settings frame
    local cooldownFrame = CooldownViewerSettings or _G["CooldownViewerSettings"]
    
    if cooldownFrame then
        if cooldownFrame:IsShown() then
            cooldownFrame:Hide()
        else
            cooldownFrame:Show()
        end
    else
        TUICD:PrintError("Cooldown Settings not available.")
    end
end
