-- Edit Mode Tweaks Profile Window
local addonName, EMT = ...

local ProfileWindow = CreateFrame("Frame", "EMT_ProfileWindow", UIParent, "BackdropTemplate")
EMT.profileWindow = ProfileWindow

-- Frame properties
ProfileWindow:SetSize(350, 380)
ProfileWindow:SetFrameStrata("DIALOG")
ProfileWindow:SetClampedToScreen(true)
ProfileWindow:EnableMouse(true)
ProfileWindow:SetMovable(true)
ProfileWindow:RegisterForDrag("LeftButton")
ProfileWindow:Hide()

-- Function to position docked to nudge frame
function ProfileWindow:UpdatePosition()
    if EMT.nudgeFrame and EMT.nudgeFrame:IsShown() then
        self:ClearAllPoints()
        self:SetPoint("RIGHT", EMT.nudgeFrame, "LEFT", 0, 0)
    else
        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
end

-- Backdrop
ProfileWindow:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})

-- Make frame draggable
ProfileWindow:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)

ProfileWindow:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

-- Title text
local title = ProfileWindow:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -12)
title:SetText("Profile Manager")

-- Close button
local closeButton = CreateFrame("Button", nil, ProfileWindow, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", -5, -5)

-- Profile dropdown/selector
local profileLabel = ProfileWindow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
profileLabel:SetPoint("TOPLEFT", 20, -40)
profileLabel:SetText("Current Profile:")

local profileDropdown = CreateFrame("Frame", "EMT_ProfileDropdown", ProfileWindow, "UIDropDownMenuTemplate")
profileDropdown:SetPoint("TOPLEFT", profileLabel, "BOTTOMLEFT", -15, -5)
ProfileWindow.profileDropdown = profileDropdown

-- Initialize dropdown
UIDropDownMenu_SetWidth(profileDropdown, 200)

-- Create new profile button
local createButton = CreateFrame("Button", nil, ProfileWindow, "UIPanelButtonTemplate")
createButton:SetSize(80, 22)
createButton:SetPoint("TOPLEFT", profileDropdown, "BOTTOMLEFT", 15, -10)
createButton:SetText("Create")
ProfileWindow.createButton = createButton

-- Save profile button
local saveButton = CreateFrame("Button", nil, ProfileWindow, "UIPanelButtonTemplate")
saveButton:SetSize(80, 22)
saveButton:SetPoint("LEFT", createButton, "RIGHT", 5, 0)
saveButton:SetText("Save")
ProfileWindow.saveButton = saveButton

-- Delete profile button
local deleteButton = CreateFrame("Button", nil, ProfileWindow, "UIPanelButtonTemplate")
deleteButton:SetSize(80, 22)
deleteButton:SetPoint("LEFT", saveButton, "RIGHT", 5, 0)
deleteButton:SetText("Delete")
ProfileWindow.deleteButton = deleteButton

-- Auto-switch checkbox
local autoSwitchButton = CreateFrame("CheckButton", nil, ProfileWindow, "UICheckButtonTemplate")
autoSwitchButton:SetPoint("TOPLEFT", createButton, "BOTTOMLEFT", 0, -15)
autoSwitchButton:SetSize(24, 24)
ProfileWindow.autoSwitchButton = autoSwitchButton

local autoSwitchLabel = ProfileWindow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
autoSwitchLabel:SetPoint("LEFT", autoSwitchButton, "RIGHT", 5, 0)
autoSwitchLabel:SetText("Auto-switch on spec change")

-- Spec assignments section
local specLabel = ProfileWindow:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
specLabel:SetPoint("TOPLEFT", autoSwitchButton, "BOTTOMLEFT", 0, -20)
specLabel:SetText("Spec Assignments")

-- Create spec assignment dropdowns
ProfileWindow.specDropdowns = {}
for i = 1, 4 do
    local specFrame = CreateFrame("Frame", nil, ProfileWindow)
    specFrame:SetSize(300, 30)
    if i == 1 then
        specFrame:SetPoint("TOPLEFT", specLabel, "BOTTOMLEFT", 0, -10)
    else
        specFrame:SetPoint("TOPLEFT", ProfileWindow.specDropdowns[i-1], "BOTTOMLEFT", 0, -5)
    end
    
    local specText = specFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    specText:SetPoint("LEFT", 5, 0)
    specText:SetText("Spec " .. i .. ":")
    specFrame.label = specText
    
    local dropdown = CreateFrame("Frame", "EMT_SpecDropdown" .. i, specFrame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", specText, "RIGHT", 0, 0)
    UIDropDownMenu_SetWidth(dropdown, 150)
    specFrame.dropdown = dropdown
    specFrame.specID = i
    
    ProfileWindow.specDropdowns[i] = specFrame
end

-- Function to update dropdown lists
function ProfileWindow:UpdateProfileDropdown()
    local function OnClick(self)
        UIDropDownMenu_SetSelectedID(profileDropdown, self:GetID())
        local currentProfile = EMT.db.currentProfile
        if self.value ~= currentProfile then
            -- Switching to a different profile
            local success, err = EMT:SwitchProfile(self.value)
            if not success then
                print("|cffff0000Edit Mode Tweaks|r: " .. (err or "Failed to switch profile"))
            else
                -- Show reload confirmation
                StaticPopup_Show("EMT_RELOAD_UI_PROFILE", self.value)
            end
        end
        ProfileWindow:Update()
    end
    
    UIDropDownMenu_Initialize(profileDropdown, function(self, level)
        local info = UIDropDownMenu_CreateInfo()
        local profileName = EMT.db.currentProfile
        
        for name in pairs(EMT.db.profiles) do
            info.text = name
            info.value = name
            info.func = OnClick
            info.checked = (name == profileName)
            UIDropDownMenu_AddButton(info, level)
        end
    end)
    
    UIDropDownMenu_SetText(profileDropdown, EMT.db.currentProfile)
end

-- Function to update spec dropdowns
function ProfileWindow:UpdateSpecDropdowns()
    for i = 1, 4 do
        local specFrame = self.specDropdowns[i]
        local specID = i
        local specInfo = specID and select(2, GetSpecializationInfo(specID))
        
        if specInfo then
            specFrame.label:SetText(specInfo .. ":")
            specFrame:Show()
            
            local function OnClick(self)
                UIDropDownMenu_SetSelectedID(specFrame.dropdown, self:GetID())
                EMT:AssignProfileToSpec(specID, self.value)
                ProfileWindow:UpdateSpecDropdowns()
            end
            
            UIDropDownMenu_Initialize(specFrame.dropdown, function(self, level)
                local info = UIDropDownMenu_CreateInfo()
                local currentAssignment = EMT.db.specProfiles[specID]
                
                -- Add "None" option
                info.text = "None"
                info.value = nil
                info.func = OnClick
                info.checked = (currentAssignment == nil)
                UIDropDownMenu_AddButton(info, level)
                
                -- Add all profiles
                for name in pairs(EMT.db.profiles) do
                    info.text = name
                    info.value = name
                    info.func = OnClick
                    info.checked = (name == currentAssignment)
                    UIDropDownMenu_AddButton(info, level)
                end
            end)
            
            UIDropDownMenu_SetText(specFrame.dropdown, EMT.db.specProfiles[specID] or "None")
        else
            specFrame:Hide()
        end
    end
end

-- Update all UI elements
function ProfileWindow:Update()
    self:UpdateProfileDropdown()
    self:UpdateSpecDropdowns()
    autoSwitchButton:SetChecked(EMT.db.autoSwitchSpec)
    
    -- Disable delete button for Default profile
    if EMT.db.currentProfile == "Default" then
        deleteButton:Disable()
    else
        deleteButton:Enable()
    end
    
    -- Enable/disable save button based on unsaved changes
    if EMT.sessionState.hasUnsavedChanges then
        saveButton:Enable()
        saveButton:SetText("Save*")
    else
        saveButton:Disable()
        saveButton:SetText("Save")
    end
end

-- Create button handler
createButton:SetScript("OnClick", function()
    StaticPopup_Show("EMT_CREATE_PROFILE")
end)

-- Save button handler
saveButton:SetScript("OnClick", function()
    if EMT:SaveProfileChanges() then
        print("|cff00ff00Edit Mode Tweaks|r: Profile saved")
        ProfileWindow:Update()
    else
        print("|cffff0000Edit Mode Tweaks|r: Failed to save profile")
    end
end)

-- Delete button handler
deleteButton:SetScript("OnClick", function()
    StaticPopup_Show("EMT_DELETE_PROFILE", EMT.db.currentProfile)
end)

-- Auto-switch button handler
autoSwitchButton:SetScript("OnClick", function(self)
    EMT.db.autoSwitchSpec = self:GetChecked()
end)

-- Update on show
ProfileWindow:SetScript("OnShow", function(self)
    self:UpdatePosition()
    self:Update()
end)

-- Static popups
StaticPopupDialogs["EMT_CREATE_PROFILE"] = {
    text = "Enter a name for the new profile:",
    button1 = "Create",
    button2 = "Cancel",
    hasEditBox = true,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self)
        local text = (self.EditBox and self.EditBox:GetText()) or (self.editBox and self.editBox:GetText()) or ""
        if text and text ~= "" then
            local success, err = EMT:CreateProfile(text)
            if success then
                EMT:SwitchProfile(text)
                ProfileWindow:Update()
                print("|cff00ff00Edit Mode Tweaks|r: Created profile '" .. text .. "'")
            else
                print("|cffff0000Edit Mode Tweaks|r: " .. (err or "Failed to create profile"))
            end
        end
    end,
    EditBoxOnEnterPressed = function(self)
        local parent = self:GetParent()
        local text = self:GetText() or ""
        if text and text ~= "" then
            local success, err = EMT:CreateProfile(text)
            if success then
                EMT:SwitchProfile(text)
                ProfileWindow:Update()
                print("|cff00ff00Edit Mode Tweaks|r: Created profile '" .. text .. "'")
            else
                print("|cffff0000Edit Mode Tweaks|r: " .. (err or "Failed to create profile"))
            end
        end
        parent:Hide()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
}

StaticPopupDialogs["EMT_DELETE_PROFILE"] = {
    text = "Are you sure you want to delete the profile '%s'?",
    button1 = "Delete",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self)
        local success, err = EMT:DeleteProfile(EMT.db.currentProfile)
        if success then
            ProfileWindow:Update()
            print("|cff00ff00Edit Mode Tweaks|r: Deleted profile")
        else
            print("|cffff0000Edit Mode Tweaks|r: " .. (err or "Failed to delete profile"))
        end
    end,
}

StaticPopupDialogs["EMT_RESET_ALL"] = {
    text = "WARNING: This will delete ALL profiles and visibility settings!\n\nThis cannot be undone. Are you sure?",
    button1 = "Reset Everything",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self)
        -- Clear all saved data
        EditModeTweaksDB = nil
        -- Reinitialize with defaults
        EMT:InitDB()
        EMT:LoadSessionState()
        -- Clear all active visibility
        for frameName in pairs(_G) do
            if type(_G[frameName]) == "table" and _G[frameName].EMT_MouseOverDetector then
                EMT:DisableMouseOverForFrame(frameName)
                EMT:DisableCombatVisibilityForFrame(frameName)
                EMT:DisableTargetVisibilityForFrame(frameName)
            end
        end
        print("|cff00ff00Edit Mode Tweaks|r: All data reset. Please /reload to complete the reset.")
    end,
}

StaticPopupDialogs["EMT_RELOAD_UI_PROFILE"] = {
    text = "Switched to profile '%s'.\n\nReload UI to apply all visibility settings?",
    button1 = "Reload",
    button2 = "Later",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self)
        ReloadUI()
    end,
}

StaticPopupDialogs["EMT_RELOAD_UI_SPEC"] = {
    text = "Switched to profile '%s' for spec %s.\n\nReload UI to apply all visibility settings?",
    button1 = "Reload",
    button2 = "Later",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self)
        ReloadUI()
    end,
}
