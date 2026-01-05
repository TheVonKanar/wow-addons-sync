-- Edit Mode Tweaks Core
local addonName, EMT = ...

-- Initialize addon namespace
EMT = EMT or {}
_G.EditModeTweaks = EMT

-- Default settings
local defaults = {
    nudgeAmount = 1,
    showNudgeFrame = true,
    mouseOverFrames = {}, -- Stores which frames have mouse-over enabled: ["PlayerFrame"] = true
    combatFrames = {}, -- Stores which frames only show in combat
    targetFrames = {}, -- Stores which frames only show with target
    profiles = {
        ["Default"] = {
            mouseOverFrames = {},
            combatFrames = {},
            targetFrames = {},
        }
    },
    currentProfile = "Default",
    specProfiles = {}, -- Maps spec IDs to profile names: [1] = "Default", [2] = "DPS Profile"
    autoSwitchSpec = true, -- Whether to auto-switch profiles on spec change
}

-- Session state for unsaved changes
EMT.sessionState = {
    mouseOverFrames = {},
    combatFrames = {},
    targetFrames = {},
    hasUnsavedChanges = false,
}

-- Initialize saved variables
function EMT:InitDB()
    if not EditModeTweaksDB then
        EditModeTweaksDB = {}
    end
    
    for k, v in pairs(defaults) do
        if EditModeTweaksDB[k] == nil then
            EditModeTweaksDB[k] = v
        end
    end
    
    self.db = EditModeTweaksDB
end

-- Selected frame tracking
EMT.selectedFrame = nil
EMT.selectedFrameName = nil

-- Click detector frame
local clickDetector = CreateFrame("Frame")
clickDetector:Hide()
local lastMouseOverFrame = nil

-- Enable click detection when Edit Mode is active
function EMT:EnableClickDetection()
    clickDetector:Show()
    clickDetector:SetScript("OnUpdate", function(self, elapsed)
        -- Check for mouse button press
        if IsMouseButtonDown("LeftButton") then
            local frames = GetMouseFoci()
            if frames and #frames > 0 then
                local frame = frames[1]
                if frame and frame ~= WorldFrame and frame ~= lastMouseOverFrame then
                    lastMouseOverFrame = frame
                    EMT:SelectFrame(frame)
                end
            end
        else
            lastMouseOverFrame = nil
        end
    end)
end

-- Disable click detection when Edit Mode is inactive
function EMT:DisableClickDetection()
    clickDetector:Hide()
    clickDetector:SetScript("OnUpdate", nil)
    lastMouseOverFrame = nil
    EMT:ClearSelectedFrame()
end

-- Select a frame for nudging
function EMT:SelectFrame(frame)
    if not frame then return end
    
    -- Walk up the frame hierarchy to find a named frame
    local namedFrame = frame
    local maxDepth = 10 -- Prevent infinite loops
    local depth = 0
    
    -- Root frames we should never select and should stop at
    local rootFrames = {
        UIParent = true,
        WorldFrame = true,
        GlueParent = true,
    }
    
    while namedFrame and depth < maxDepth do
        local frameName = namedFrame:GetName()
        
        -- Stop if we hit a root frame
        if frameName and rootFrames[frameName] then
            -- If we haven't found a better frame yet, this means we only found root frames
            -- In that case, use the original frame even if unnamed
            if depth == 0 then
                break
            else
                -- Use the last valid frame before the root
                break
            end
        end
        
        if frameName and not rootFrames[frameName] then
            -- Found a named, non-root frame, use this
            frame = namedFrame
            break
        end
        
        -- Try to get the parent
        local parent = namedFrame:GetParent()
        if not parent or parent == namedFrame then
            break
        end
        namedFrame = parent
        depth = depth + 1
    end
    
    local frameName = frame:GetName()
    
    -- Filter out frames we don't want to select
    if frameName == "EMT_NudgeFrame" or 
       frameName == "EditModeManagerFrame" or
       rootFrames[frameName] or
       frame == self.nudgeFrame or
       frame == EditModeManagerFrame then
        return -- Don't select these frames
    end
    
    -- Store the selected frame
    self.selectedFrame = frame
    self.selectedFrameName = frameName or "Anonymous Frame"
    
    -- Update the nudge panel (always call, let UpdateInfo decide whether to show/hide)
    if self.nudgeFrame then
        self.nudgeFrame:UpdateInfo()
    end
end

-- Clear selected frame
function EMT:ClearSelectedFrame()
    self.selectedFrame = nil
    self.selectedFrameName = nil
    
    if self.nudgeFrame then
        self.nudgeFrame:UpdateInfo()
    end
end

-- Get the currently selected frame (replaces GetSelectedSystem)
function EMT:GetSelectedFrame()
    return self.selectedFrame, self.selectedFrameName
end

-- Old function kept for compatibility but redirects to new system
function EMT:GetSelectedSystem()
    return self:GetSelectedFrame()
end

-- Profile Management Functions

-- Load current profile settings into session state
function EMT:LoadSessionState()
    local profile = self:GetCurrentProfile()
    if profile then
        -- Deep copy the profile data into session state
        self.sessionState.mouseOverFrames = {}
        self.sessionState.combatFrames = {}
        self.sessionState.targetFrames = {}
        
        for k, v in pairs(profile.mouseOverFrames or {}) do
            self.sessionState.mouseOverFrames[k] = v
        end
        for k, v in pairs(profile.combatFrames or {}) do
            self.sessionState.combatFrames[k] = v
        end
        for k, v in pairs(profile.targetFrames or {}) do
            self.sessionState.targetFrames[k] = v
        end
        
        self.sessionState.hasUnsavedChanges = false
        
        -- Update working db references to point to session state
        self.db.mouseOverFrames = self.sessionState.mouseOverFrames
        self.db.combatFrames = self.sessionState.combatFrames
        self.db.targetFrames = self.sessionState.targetFrames
    end
end

-- Save session state to current profile
function EMT:SaveProfileChanges()
    local profile = self:GetCurrentProfile()
    if profile then
        profile.mouseOverFrames = {}
        profile.combatFrames = {}
        profile.targetFrames = {}
        
        for k, v in pairs(self.sessionState.mouseOverFrames) do
            profile.mouseOverFrames[k] = v
        end
        for k, v in pairs(self.sessionState.combatFrames) do
            profile.combatFrames[k] = v
        end
        for k, v in pairs(self.sessionState.targetFrames) do
            profile.targetFrames[k] = v
        end
        
        self.sessionState.hasUnsavedChanges = false
        return true
    end
    return false
end

-- Discard session changes and reload from profile
function EMT:DiscardProfileChanges()
    self:LoadSessionState()
    -- Reapply all visibility settings
    self:ReapplyAllVisibility()
end

-- Reapply all visibility settings from session state
function EMT:ReapplyAllVisibility()
    -- Build a list of all frame names we need to clear
    local allFrameNames = {}
    for frameName in pairs(self.sessionState.mouseOverFrames) do
        allFrameNames[frameName] = true
    end
    for frameName in pairs(self.sessionState.combatFrames) do
        allFrameNames[frameName] = true
    end
    for frameName in pairs(self.sessionState.targetFrames) do
        allFrameNames[frameName] = true
    end
    
    -- Clear all existing visibility first (only for frames that exist)
    for frameName in pairs(allFrameNames) do
        if _G[frameName] then
            self:DisableMouseOverForFrame(frameName)
            self:DisableCombatVisibilityForFrame(frameName)
            self:DisableTargetVisibilityForFrame(frameName)
        end
    end
    
    -- Reapply from session state (only for frames that exist)
    for frameName, enabled in pairs(self.sessionState.mouseOverFrames) do
        if enabled and _G[frameName] then
            self:EnableMouseOverForFrame(frameName)
        end
    end
    for frameName, enabled in pairs(self.sessionState.combatFrames) do
        if enabled and _G[frameName] then
            self:EnableCombatVisibilityForFrame(frameName)
        end
    end
    for frameName, enabled in pairs(self.sessionState.targetFrames) do
        if enabled and _G[frameName] then
            self:EnableTargetVisibilityForFrame(frameName)
        end
    end
end

-- Get current profile data
function EMT:GetCurrentProfile()
    local profileName = self.db.currentProfile or "Default"
    if not self.db.profiles[profileName] then
        profileName = "Default"
        self.db.currentProfile = profileName
    end
    return self.db.profiles[profileName], profileName
end

-- Create a new profile
function EMT:CreateProfile(profileName)
    if not profileName or profileName == "" then
        return false, "Profile name cannot be empty"
    end
    
    if self.db.profiles[profileName] then
        return false, "Profile already exists"
    end
    
    self.db.profiles[profileName] = {
        mouseOverFrames = {},
        combatFrames = {},
        targetFrames = {},
    }
    
    return true
end

-- Delete a profile
function EMT:DeleteProfile(profileName)
    if profileName == "Default" then
        return false, "Cannot delete Default profile"
    end
    
    if not self.db.profiles[profileName] then
        return false, "Profile does not exist"
    end
    
    -- Remove from spec assignments
    for specID, assignedProfile in pairs(self.db.specProfiles) do
        if assignedProfile == profileName then
            self.db.specProfiles[specID] = nil
        end
    end
    
    -- If it's the current profile, switch to Default
    if self.db.currentProfile == profileName then
        self:SwitchProfile("Default")
    end
    
    self.db.profiles[profileName] = nil
    return true
end

-- Switch to a different profile
function EMT:SwitchProfile(profileName)
    if not self.db.profiles[profileName] then
        return false, "Profile does not exist"
    end
    
    -- Don't save current settings - they're in session state
    -- Just switch the profile reference
    self.db.currentProfile = profileName
    
    -- Load new profile into session state
    self:LoadSessionState()
    
    -- Apply the loaded settings
    self:ReapplyAllVisibility()
    
    return true
end

-- Load profile settings and apply them (now uses session state)
function EMT:LoadProfileSettings(profileName)
    self.db.currentProfile = profileName
    self:LoadSessionState()
    self:ReapplyAllVisibility()
end

-- Assign a profile to a spec
function EMT:AssignProfileToSpec(specID, profileName)
    if profileName == nil or profileName == "" then
        self.db.specProfiles[specID] = nil
    else
        if not self.db.profiles[profileName] then
            return false, "Profile does not exist"
        end
        self.db.specProfiles[specID] = profileName
    end
    return true
end

-- Handle spec change
function EMT:OnSpecChanged()
    if not self.db.autoSwitchSpec then return end
    
    local specID = GetSpecialization()
    if not specID then return end
    
    local assignedProfile = self.db.specProfiles[specID]
    if assignedProfile and self.db.profiles[assignedProfile] and assignedProfile ~= self.db.currentProfile then
        self:SwitchProfile(assignedProfile)
        -- Show reload popup
        StaticPopup_Show("EMT_RELOAD_UI_SPEC", assignedProfile, specID)
    end
end

-- Check if a frame has mouse-over enabled
function EMT:IsMouseOverEnabled(frameName)
    if not frameName or not self.db.mouseOverFrames then
        return false
    end
    return self.db.mouseOverFrames[frameName] == true
end

-- Check if a frame has combat visibility enabled
function EMT:IsCombatVisibilityEnabled(frameName)
    if not frameName or not self.db.combatFrames then
        return false
    end
    return self.db.combatFrames[frameName] == true
end

-- Check if a frame has target visibility enabled
function EMT:IsTargetVisibilityEnabled(frameName)
    if not frameName or not self.db.targetFrames then
        return false
    end
    return self.db.targetFrames[frameName] == true
end

-- Set mouse-over state for a frame
function EMT:SetMouseOverEnabled(frameName, enabled)
    if not frameName then
        return
    end
    
    self.db.mouseOverFrames[frameName] = enabled
    self.sessionState.hasUnsavedChanges = true
    
    -- Apply or remove mouse-over behavior
    if enabled then
        self:EnableMouseOverForFrame(frameName)
    else
        self:DisableMouseOverForFrame(frameName)
    end
end

-- Set combat visibility state for a frame
function EMT:SetCombatVisibilityEnabled(frameName, enabled)
    if not frameName then
        return
    end
    
    self.db.combatFrames[frameName] = enabled
    self.sessionState.hasUnsavedChanges = true
    
    -- Apply or remove combat visibility behavior
    if enabled then
        self:EnableCombatVisibilityForFrame(frameName)
    else
        self:DisableCombatVisibilityForFrame(frameName)
    end
end

-- Set target visibility state for a frame
function EMT:SetTargetVisibilityEnabled(frameName, enabled)
    if not frameName then
        return
    end
    
    self.db.targetFrames[frameName] = enabled
    self.sessionState.hasUnsavedChanges = true
    
    -- Apply or remove target visibility behavior
    if enabled then
        self:EnableTargetVisibilityForFrame(frameName)
    else
        self:DisableTargetVisibilityForFrame(frameName)
    end
end

-- Enable mouse-over behavior for a specific frame
function EMT:EnableMouseOverForFrame(frameName)
    local frame = _G[frameName]
    if not frame then
        return
    end
    
    -- Store original alpha if not already stored - MUST be done before changing alpha!
    if not frame.EMT_OriginalAlpha then
        local currentAlpha = frame:GetAlpha()
        -- Make sure we don't store 0 as the original
        frame.EMT_OriginalAlpha = (currentAlpha > 0) and currentAlpha or 1
    end
    
    -- Store original mouse-enabled state
    if frame.EMT_MouseWasEnabled == nil then
        frame.EMT_MouseWasEnabled = frame:IsMouseEnabled()
    end
    
    -- Set to hidden initially but keep mouse enabled for the frame
    frame:SetAlpha(0)
    
    -- Create or reuse mouse-over detector frame
    if not frame.EMT_MouseOverDetector then
        local detector = CreateFrame("Frame", nil, frame)
        detector:SetAllPoints(frame)
        detector:EnableMouse(false) -- Don't block clicks
        detector:SetMouseClickEnabled(false) -- Don't capture clicks
        detector:SetFrameStrata("BACKGROUND")
        
        -- Use OnUpdate to constantly check mouse position
        detector:SetScript("OnUpdate", function(self, elapsed)
            if not self.updateThrottle then
                self.updateThrottle = 0
            end
            self.updateThrottle = self.updateThrottle + elapsed
            
            -- Check every 0.1 seconds
            if self.updateThrottle >= 0.1 then
                self.updateThrottle = 0
                
                local mouseOver = frame:IsMouseOver()
                
                if mouseOver and not frame.EMT_IsMouseOver then
                    -- Mouse entered
                    frame.EMT_IsMouseOver = true
                    EMT:FadeIn(frame)
                elseif not mouseOver and frame.EMT_IsMouseOver then
                    -- Mouse left
                    frame.EMT_IsMouseOver = false
                    EMT:FadeOut(frame)
                end
            end
        end)
        
        frame.EMT_MouseOverDetector = detector
    end
    
    frame.EMT_MouseOverDetector:Show()
end

-- Disable mouse-over behavior for a specific frame
function EMT:DisableMouseOverForFrame(frameName)
    local frame = _G[frameName]
    if not frame then
        return
    end
    
    -- Hide detector and stop update
    if frame.EMT_MouseOverDetector then
        frame.EMT_MouseOverDetector:SetScript("OnUpdate", nil)
        frame.EMT_MouseOverDetector:Hide()
    end
    
    -- Clear mouse over state
    frame.EMT_IsMouseOver = nil
    
    -- Restore original alpha
    if frame.EMT_OriginalAlpha then
        frame:SetAlpha(frame.EMT_OriginalAlpha)
    else
        frame:SetAlpha(1)
    end
    
    -- Restore original mouse-enabled state
    if frame.EMT_MouseWasEnabled ~= nil then
        frame:EnableMouse(frame.EMT_MouseWasEnabled)
        frame.EMT_MouseWasEnabled = nil
    end
    
    -- Stop any active fade
    if frame.EMT_FadeTimer then
        frame.EMT_FadeTimer = nil
    end
    frame.EMT_FadeDirection = nil
end

-- Fade in a frame
function EMT:FadeIn(frame)
    if not frame then return end
    
    frame.EMT_FadeTimer = nil
    frame.EMT_FadeDirection = "in"
    frame.EMT_FadeElapsed = 0
    frame.EMT_FadeDuration = 0.2
    
    if not frame.EMT_FadeUpdate then
        frame.EMT_FadeUpdate = frame:CreateAnimationGroup()
        frame:SetScript("OnUpdate", function(self, elapsed)
            if not self.EMT_FadeDirection then return end
            
            self.EMT_FadeElapsed = (self.EMT_FadeElapsed or 0) + elapsed
            local progress = math.min(self.EMT_FadeElapsed / self.EMT_FadeDuration, 1)
            
            if self.EMT_FadeDirection == "in" then
                self:SetAlpha(progress * (self.EMT_OriginalAlpha or 1))
            else
                self:SetAlpha((1 - progress) * (self.EMT_OriginalAlpha or 1))
            end
            
            if progress >= 1 then
                self.EMT_FadeDirection = nil
                self.EMT_FadeElapsed = 0
            end
        end)
    end
end

-- Fade out a frame
function EMT:FadeOut(frame)
    if not frame then return end
    
    frame.EMT_FadeTimer = nil
    frame.EMT_FadeDirection = "out"
    frame.EMT_FadeElapsed = 0
    frame.EMT_FadeDuration = 0.2
end

-- Enable combat visibility for a specific frame
function EMT:EnableCombatVisibilityForFrame(frameName)
    local frame = _G[frameName]
    if not frame then return end
    
    -- Store original alpha if not already stored - MUST be done before changing alpha!
    if not frame.EMT_OriginalAlpha then
        local currentAlpha = frame:GetAlpha()
        -- Make sure we don't store 0 as the original
        frame.EMT_OriginalAlpha = (currentAlpha > 0) and currentAlpha or 1
    end
    
    -- Check current combat state and show/hide accordingly
    self:UpdateFrameVisibility(frameName)
end

-- Disable combat visibility for a specific frame
function EMT:DisableCombatVisibilityForFrame(frameName)
    local frame = _G[frameName]
    if not frame then return end
    
    -- Restore visibility
    self:UpdateFrameVisibility(frameName)
end

-- Enable target visibility for a specific frame
function EMT:EnableTargetVisibilityForFrame(frameName)
    local frame = _G[frameName]
    if not frame then return end
    
    -- Store original alpha if not already stored - MUST be done before changing alpha!
    if not frame.EMT_OriginalAlpha then
        local currentAlpha = frame:GetAlpha()
        -- Make sure we don't store 0 as the original
        frame.EMT_OriginalAlpha = (currentAlpha > 0) and currentAlpha or 1
    end
    
    -- Check current target state and show/hide accordingly
    self:UpdateFrameVisibility(frameName)
end

-- Disable target visibility for a specific frame
function EMT:DisableTargetVisibilityForFrame(frameName)
    local frame = _G[frameName]
    if not frame then return end
    
    -- Restore visibility
    self:UpdateFrameVisibility(frameName)
end

-- Update frame visibility based on all enabled conditions (OR logic)
function EMT:UpdateFrameVisibility(frameName)
    local frame = _G[frameName]
    if not frame then return end
    
    local mouseOverEnabled = self:IsMouseOverEnabled(frameName)
    local combatEnabled = self:IsCombatVisibilityEnabled(frameName)
    local targetEnabled = self:IsTargetVisibilityEnabled(frameName)
    
    -- If no special visibility modes are enabled, ensure frame is visible and interactive
    if not mouseOverEnabled and not combatEnabled and not targetEnabled then
        if frame.EMT_OriginalAlpha then
            frame:SetAlpha(frame.EMT_OriginalAlpha)
        else
            frame:SetAlpha(1)
        end
        -- Restore mouse interaction
        -- Note: EnableMouse is protected and cannot be called by addons
        if frame.EMT_MouseWasEnabled ~= nil then
            frame.EMT_MouseWasEnabled = nil
        end
        return
    end
    
    -- Check each condition (OR logic - show if ANY condition is met)
    local showDueToCombat = combatEnabled and UnitAffectingCombat("player")
    local showDueToTarget = targetEnabled and (UnitGUID("target") ~= nil)
    local showDueToMouseOver = mouseOverEnabled and frame.EMT_IsMouseOver
    
    -- Determine if frame should be visible
    local shouldShow = showDueToCombat or showDueToTarget or showDueToMouseOver
    
    if shouldShow then
        -- Frame should be visible
        if frame.EMT_OriginalAlpha then
            frame:SetAlpha(frame.EMT_OriginalAlpha)
        else
            frame:SetAlpha(1)
        end
        -- Don't mess with mouse settings if mouse-over is managing it
        if not mouseOverEnabled then
            -- Note: EnableMouse is protected and cannot be called by addons
            if frame.EMT_MouseWasEnabled ~= nil then
                frame.EMT_MouseWasEnabled = nil
            end
        end
    else
        -- Frame should be hidden
        -- But if mouse-over is enabled, let it handle alpha during fade
        if not mouseOverEnabled then
            frame:SetAlpha(0)
            -- Note: EnableMouse is protected and cannot be called by addons
            -- Track that mouse was enabled but don't try to disable it
            if frame.EMT_MouseWasEnabled == nil then
                frame.EMT_MouseWasEnabled = frame:IsMouseEnabled()
            end
        else
            -- Mouse-over will handle showing/hiding
            -- Just make sure it starts hidden if mouse isn't over
            if not frame.EMT_IsMouseOver then
                frame:SetAlpha(0)
            end
        end
    end
end

-- Get the frame for a system (now just returns what's passed since GetSelectedSystem returns the frame)
function EMT:GetSystemFrame(frame)
    return frame
end

-- Nudge a frame in a specific direction
function EMT:NudgeFrame(frame, direction, amount)
    if not frame then
        return false
    end

    amount = amount or self.db.nudgeAmount or 1

    -- Must be in Edit Mode
    if not EditModeManagerFrame or not EditModeManagerFrame.editModeActive then
        return false
    end

    -- The frame we selected in Edit Mode *is* the system frame (MinimapCluster, PlayerFrame, etc.)
    local systemFrame = frame

    -- Sanity check that this is actually an Edit Mode system
    if not systemFrame.systemInfo then
        return false
    end

    local systemInfo = systemFrame.systemInfo
    -- Edit Mode stores its offsets in anchorInfo
    local anchor = systemInfo.anchorInfo or {}

    local xOffset = anchor.offsetX or 0
    local yOffset = anchor.offsetY or 0

    -- Apply the nudge
    if direction == "UP" then
        yOffset = yOffset + amount
    elseif direction == "DOWN" then
        yOffset = yOffset - amount
    elseif direction == "LEFT" then
        xOffset = xOffset - amount
    elseif direction == "RIGHT" then
        xOffset = xOffset + amount
    end

    -- Write back into anchorInfo so it saves properly
    anchor.offsetX = xOffset
    anchor.offsetY = yOffset
    systemInfo.anchorInfo = anchor
    systemFrame.systemInfo = systemInfo

    -- Flag the system/layout as dirty so the Save button lights up
    systemFrame.hasActiveChanges = true
    if EditModeManagerFrame.SetHasActiveChanges then
        EditModeManagerFrame:SetHasActiveChanges(true)
    end

    -- Directly reposition the frame
    local numPoints = systemFrame:GetNumPoints()
    if numPoints > 0 then
        local point, relativeTo, relativePoint = systemFrame:GetPoint(1)
        
        -- Use the anchor point from anchorInfo if available, otherwise use current
        local anchorPoint = anchor.point or point or "CENTER"
        local relativeFrame = anchor.relativeTo or relativeTo or UIParent
        local relativeAnchor = anchor.relativePoint or relativePoint or "CENTER"
        
        systemFrame:ClearAllPoints()
        systemFrame:SetPoint(anchorPoint, relativeFrame, relativeAnchor, xOffset, yOffset)
    end

    return true
end

-- Event handler
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Entering combat
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Leaving combat
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED") -- Target changed
eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED") -- Spec changed

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        EMT:InitDB()
        print("|cff00ff00Edit Mode Tweaks|r loaded. Open Edit Mode to use nudge controls.")
        
        -- Hook Edit Mode enter/exit after it's loaded
        if EditModeManagerFrame then
            hooksecurefunc(EditModeManagerFrame, "EnterEditMode", function()
                EMT:EnableClickDetection()
            end)
            
            hooksecurefunc(EditModeManagerFrame, "ExitEditMode", function()
                EMT:DisableClickDetection()
            end)
            
        end
    elseif event == "PLAYER_LOGIN" then
        -- Load current profile into session state
        EMT:LoadSessionState()
        
        -- Restore visibility states from session (with delay for frame loading)
        -- Increased delay to ensure all frames are loaded
        C_Timer.After(2, function()
            EMT:ReapplyAllVisibility()
        end)
    elseif event == "EDIT_MODE_LAYOUTS_UPDATED" then
        -- Handle layout updates if needed
    elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
        -- Combat state changed, update all frames with combat visibility
        if EMT.db.combatFrames then
            for frameName, enabled in pairs(EMT.db.combatFrames) do
                if enabled then
                    EMT:UpdateFrameVisibility(frameName)
                end
            end
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        -- Target changed, update all frames with target visibility
        if EMT.db.targetFrames then
            for frameName, enabled in pairs(EMT.db.targetFrames) do
                if enabled then
                    EMT:UpdateFrameVisibility(frameName)
                end
            end
        end
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        -- Spec changed, check if we should auto-switch profiles
        EMT:OnSpecChanged()
    end
end)

-- Slash command
SLASH_EDITMODETWEAKS1 = "/emt"
SLASH_EDITMODETWEAKS2 = "/editmodetweaks"

SlashCmdList["EDITMODETWEAKS"] = function(msg)
    msg = msg:lower():trim()
    
    if msg == "" or msg == "help" then
        print("|cff00ff00Edit Mode Tweaks|r commands:")
        print("/emt toggle - Toggle the nudge frame")
        print("/emt amount <number> - Set nudge amount (1-5, default: 1)")
        print("/emt debug - Show current profile and visibility settings")
        print("/emt reset - Reset all saved data (WARNING: deletes all profiles)")
    elseif msg == "toggle" then
        EMT.db.showNudgeFrame = not EMT.db.showNudgeFrame
        if EMT.nudgeFrame then
            EMT.nudgeFrame:UpdateVisibility()
        end
        print("|cff00ff00Edit Mode Tweaks|r: Nudge frame " .. (EMT.db.showNudgeFrame and "enabled" or "disabled"))
    elseif msg:match("^amount%s+(%d+)") then
        local amount = tonumber(msg:match("^amount%s+(%d+)"))
        if amount and amount > 0 and amount <= 5 then
            EMT.db.nudgeAmount = amount
            -- Update slider if nudge frame exists and is shown
            if EMT.nudgeFrame and EMT.nudgeFrame:IsShown() then
                EMT.nudgeFrame:UpdateAmountSlider()
            end
            print("|cff00ff00Edit Mode Tweaks|r: Nudge amount set to " .. amount)
        else
            print("|cff00ff00Edit Mode Tweaks|r: Invalid amount. Must be between 1 and 5.")
        end
    elseif msg == "debug" then
        print("|cff00ff00Edit Mode Tweaks|r Debug Info:")
        print("Current Profile: " .. (EMT.db.currentProfile or "None"))
        print("Unsaved Changes: " .. tostring(EMT.sessionState.hasUnsavedChanges))
        print("\nSession State:")
        local mouseCount, combatCount, targetCount = 0, 0, 0
        for k, v in pairs(EMT.sessionState.mouseOverFrames or {}) do
            if v then 
                print("  Mouseover: " .. k)
                mouseCount = mouseCount + 1
            end
        end
        for k, v in pairs(EMT.sessionState.combatFrames or {}) do
            if v then 
                print("  Combat: " .. k)
                combatCount = combatCount + 1
            end
        end
        for k, v in pairs(EMT.sessionState.targetFrames or {}) do
            if v then 
                print("  Target: " .. k)
                targetCount = targetCount + 1
            end
        end
        print("Total: " .. mouseCount .. " mouseover, " .. combatCount .. " combat, " .. targetCount .. " target")
    elseif msg == "reset" then
        StaticPopup_Show("EMT_RESET_ALL")
    else
        print("|cff00ff00Edit Mode Tweaks|r: Unknown command. Type /emt help for commands.")
    end
end
