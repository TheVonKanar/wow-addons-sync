--[[
##############################################################################
# Talent Loadout Display
# Author: Buffyflewbs-EU-Azuremyst
# Version: 1.0
#
# Description:
#   This lightweight addon displays your currently selected
#   talent loadout name on screen in a small draggable frame.
#   If no named loadout is active, it falls back to displaying the spec name.
#
# Features:
#   - Displays the name of the last selected talent loadout (from Dragonflight+ talent trees)
#   - Automatically updates on spec or talent changes
#   - Draggable and clamped to screen
#
# File: TalentLoadoutDisplay.lua
##############################################################################
]]

local addonName, addonTable = ...
TalentLoadoutDisplayDB = TalentLoadoutDisplayDB or {}

-- Create frame
local frame = CreateFrame("Frame", "TalentLoadoutDisplayFrame", UIParent)
frame:SetSize(250, 30)

-- Set saved position or default
local function RestorePosition()
    local pos = TalentLoadoutDisplayDB.position
    if pos then
        frame:ClearAllPoints()
        frame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.xOfs, pos.yOfs)
    else
        frame:SetPoint("TOP", UIParent, "TOP", 0, -100) -- default position
    end
end

-- Save current position
local function SavePosition()
    local point, _, relativePoint, xOfs, yOfs = frame:GetPoint()
    TalentLoadoutDisplayDB.position = {
        point = point,
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs
    }
end

-- Make the frame draggable
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetClampedToScreen(true)

frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)

frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    SavePosition()
end)

-- Background
frame.bg = frame:CreateTexture(nil, "BACKGROUND")
frame.bg:SetAllPoints(true)
frame.bg:SetColorTexture(0, 0, 0, 0.5)

-- Font string
frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
frame.text:SetPoint("CENTER")

-- Update logic
local function UpdateLoadoutDisplay()
    local specID = GetSpecialization() and select(1, GetSpecializationInfo(GetSpecialization()))
    local savedConfigID = C_ClassTalents.GetLastSelectedSavedConfigID(specID)
    if savedConfigID then
        local info = C_Traits.GetConfigInfo(savedConfigID)
        if info and info.name and info.name ~= "" then
            frame.text:SetText(info.name)
            return
        end
    end

    local activeConfigID = C_ClassTalents.GetActiveConfigID()
    if activeConfigID then
        local activeInfo = C_Traits.GetConfigInfo(activeConfigID)
        if activeInfo and activeInfo.name and activeInfo.name ~= "" then
            frame.text:SetText(activeInfo.name)
            return
        end
    end

    local _, specName = GetSpecializationInfo(GetSpecialization())
    frame.text:SetText("Spec: " .. (specName or "Unknown"))
end

-- Events
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("TRAIT_CONFIG_LIST_UPDATED")
frame:RegisterEvent("TRAIT_CONFIG_UPDATED")
frame:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        RestorePosition()
        UpdateLoadoutDisplay()
    else
        C_Timer.After(0.2, UpdateLoadoutDisplay)
    end
end)
