-- Porter.lua
-- Main entry point. Handles addon initialization, event registration,
-- slash command, and minimap button setup.

local addonName, Porter = ...
-- Expose globally so /run macros can access Porter
_G.Porter = Porter

-----------------------------------------------------------------------
-- EVENT FRAME
-- A hidden frame that listens for WoW events to trigger addon logic.
-----------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
eventFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
eventFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
eventFrame:RegisterEvent("PLAYER_HOUSE_LIST_UPDATED")

eventFrame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        -- Initialize saved variables (merges defaults into PorterDB)
        Porter:InitDB()

        -- Create the main UI frame
        Porter:CreateMainFrame()

        -- Register settings panel with WoW's AddOns options
        Porter:CreateSettingsPanel()

        -- Set up the minimap button
        Porter:SetupMinimapButton()

        -- Create named secure buttons for /click macros
        Porter:CreateSecureButtons()

        -- Refresh existing Porter macros (icon + hearthstone body)
        Porter:RefreshMacros()

        -- Unregister since we only need this once
        self:UnregisterEvent("ADDON_LOADED")

    elseif event == "SPELL_UPDATE_COOLDOWN" or event == "BAG_UPDATE_COOLDOWN" then
        if Porter.frame and Porter.frame:IsShown() and not InCombatLockdown() then
            Porter:UpdateAllCooldowns()
        end

    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        if Porter.frame and Porter.frame:IsShown() and not InCombatLockdown() then
            Porter:UpdateEquipStatus()
        end

        -- Detect when a Porter equippable item gets equipped — save the displaced item
        if Porter.pendingReequip and not Porter.reequipData then
            local pending = Porter.pendingReequip
            -- Compare snapshot to find which slot now has the Porter item
            for slotID, oldData in pairs(pending.slots) do
                local equippedNow = GetInventoryItemID("player", slotID)
                if equippedNow and equippedNow == pending.porterItemID and equippedNow ~= oldData.id then
                    Porter.pendingReequip = nil
                    -- Save the exact item link for re-equip (preserves ilvl/enchants/gems)
                    Porter.reequipData = { link = oldData.link, itemID = oldData.id }
                    break
                end
            end
        end

    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        if arg1 == "player" and Porter.reequipData then
            Porter:DoReequip()
        end

    elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
        if arg1 == "player" and Porter.reequipData and not Porter.reequipTimer then
            local reequip = Porter.reequipData
            local name = C_Item.GetItemInfo(reequip.itemID)
            print("|cff9966ffPorter:|r Cast interrupted. Re-equipping " .. (name or "previous item") .. " in 12 seconds.")
            Porter.reequipTimer = C_Timer.NewTimer(12, function()
                Porter:DoReequip()
            end)
        end

    elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        if Porter.frame and Porter.frame:IsShown() and not InCombatLockdown() then
            Porter:BuildLayout()
            Porter:UpdateAllCooldowns()
            Porter:UpdateEquipStatus()
        end

        -- Show changelog on first login (not on every zone change)
        if event == "PLAYER_ENTERING_WORLD" and not Porter.changelogChecked then
            Porter.changelogChecked = true
            Porter:CheckChangelog()
            -- Request player housing data (response comes via PLAYER_HOUSE_LIST_UPDATED)
            if C_Housing and C_Housing.GetPlayerOwnedHouses then
                C_Housing.GetPlayerOwnedHouses()
            end
        end

        -- Re-equip previous item after zone change (teleport completed)
        if Porter.reequipData then
            Porter:DoReequip()
        end

    elseif event == "PLAYER_HOUSE_LIST_UPDATED" then
        Porter:PopulateHousingData(arg1)
    end
end)

-----------------------------------------------------------------------
-- RE-EQUIP HELPER
-- Cancels the fallback timer and re-equips the saved item after 1s.
-----------------------------------------------------------------------
function Porter:DoReequip()
    local reequip = self.reequipData
    if not reequip then return end
    self.reequipData = nil
    if self.reequipTimer then
        self.reequipTimer:Cancel()
        self.reequipTimer = nil
    end
    C_Timer.After(1, function()
        if not InCombatLockdown() then
            EquipItemByName(reequip.link or reequip.itemID)
            local name = C_Item.GetItemInfo(reequip.itemID)
            print("|cff9966ffPorter:|r Re-equipped " .. (name or "previous item") .. ".")
        end
    end)
end

-----------------------------------------------------------------------
-- HOUSING DATA
-- Populates TeleportData["House"] from C_Housing API responses.
-- Each owned house becomes an entry with type = "housing".
-----------------------------------------------------------------------
function Porter:PopulateHousingData(houseInfos)
    if not houseInfos then return end

    local houseData = {}
    for _, house in ipairs(houseInfos) do
        tinsert(houseData, {
            type = "housing",
            name = house.neighborhoodName or house.houseName or "My House",
            neighborhoodGUID = house.neighborhoodGUID,
            houseGUID = house.houseGUID,
            plotID = house.plotID,
            region = "Other",
            zone = "House",
        })
    end

    self.TeleportData["House"] = houseData

    -- Refresh UI if the window is open
    if self.frame and self.frame:IsShown() and not InCombatLockdown() then
        self:BuildLayout()
        self:UpdateAllCooldowns()
    end
end

-----------------------------------------------------------------------
-- SECURE BUTTONS
-- Named secure buttons that can be triggered via /click macros.
-- PorterToggle: opens/closes the Porter window.
-- PorterHearthstone: uses a random cosmetic hearthstone (or normal).
-----------------------------------------------------------------------
function Porter:CreateSecureButtons()
    -- Toggle button
    local toggle = CreateFrame("Button", "PorterToggle", UIParent, "SecureActionButtonTemplate")
    toggle:SetSize(1, 1)
    toggle:SetAlpha(0)
    toggle:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
    toggle:RegisterForClicks("AnyDown")
    toggle:SetAttribute("type", "macro")
    toggle:SetAttribute("macrotext", "/porter")
    toggle:Show()

    -- Hearthstone button — hidden but clickable via Porter:Click()
    local hs = CreateFrame("Button", "PorterHearthstone", UIParent, "SecureActionButtonTemplate")
    hs:SetSize(1, 1)
    hs:SetAlpha(0)
    hs:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
    hs:RegisterForClicks("AnyDown")
    hs:SetAttribute("type", "macro")
    local ok, macro = pcall(function() return self:GetHearthstoneMacro() end)
    hs:SetAttribute("macrotext", ok and macro or self:WrapMacro("/cast Hearthstone"))
    hs:SetScript("PreClick", function()
        if not InCombatLockdown() then
            local ok2, macro2 = pcall(function() return Porter:GetHearthstoneMacro() end)
            if ok2 and macro2 then
                hs:SetAttribute("macrotext", macro2)
            end
        end
    end)
    hs:Show()
    self.hearthstoneSecureBtn = hs
end

-----------------------------------------------------------------------
-- MACRO HELPERS
-- Porter macros are only created when the user clicks the drag buttons
-- in Settings. On login, we only update the icon and hearthstone body
-- if our macros already exist (verified by checking the macro body).
-----------------------------------------------------------------------
local TOGGLE_NAME = "Porter"
local HS_NAME = "Porter HS"

function Porter:GetPorterIcon()
    return GetFileIDFromPath("Interface\\AddOns\\Porter\\macro_porter")
        or "Spell_Arcane_PortalStormwind"
end

function Porter:GetHSIcon()
    return GetFileIDFromPath("Interface\\AddOns\\Porter\\macro_hearthstone")
        or "Spell_Nature_Hearthstone"
end

-- Check if a macro is ours by verifying the body
function Porter:IsPorterMacro(idx)
    if idx == 0 then return false end
    local _, _, body = GetMacroInfo(idx)
    return body and body:find("/porter") ~= nil
end

function Porter:IsPorterHSMacro(idx)
    if idx == 0 then return false end
    local _, _, body = GetMacroInfo(idx)
    if not body then return false end
    return body:find("/cast Hearthstone") ~= nil or body:find("/use item:") ~= nil
end

-- Create a Porter macro (called from settings drag buttons)
function Porter:EnsurePorterMacro()
    if InCombatLockdown() then return false end
    local idx = GetMacroIndexByName(TOGGLE_NAME)
    if idx > 0 and self:IsPorterMacro(idx) then
        -- Refresh existing macro
        EditMacro(idx, nil, self:GetPorterIcon(), "/porter")
        return true
    end
    if idx > 0 then return false end -- name taken by user macro
    local maxMacros = MAX_ACCOUNT_MACROS or 120
    local numGlobal = GetNumMacros()
    if numGlobal < maxMacros then
        CreateMacro(TOGGLE_NAME, self:GetPorterIcon(), "/porter", false)
        return true
    end
    return false
end

function Porter:EnsureHSMacro()
    if InCombatLockdown() then return false end
    local ok, hsMacro = pcall(function() return self:GetHearthstoneMacro() end)
    local hsBody = ok and hsMacro or "/cast Hearthstone"
    local idx = GetMacroIndexByName(HS_NAME)
    if idx > 0 and self:IsPorterHSMacro(idx) then
        -- Refresh existing macro
        EditMacro(idx, nil, self:GetHSIcon(), hsBody)
        return true
    end
    if idx > 0 then return false end -- name taken by user macro
    local maxMacros = MAX_ACCOUNT_MACROS or 120
    local numGlobal = GetNumMacros()
    if numGlobal < maxMacros then
        CreateMacro(HS_NAME, self:GetHSIcon(), hsBody, false)
        return true
    end
    return false
end

-- Update existing Porter macros on login (icon + hearthstone body only)
function Porter:RefreshMacros()
    C_Timer.After(2, function()
        if InCombatLockdown() then return end

        -- Update toggle macro icon (temporary file IDs change on restart)
        local toggleIdx = GetMacroIndexByName(TOGGLE_NAME)
        if toggleIdx > 0 and Porter:IsPorterMacro(toggleIdx) then
            EditMacro(toggleIdx, nil, Porter:GetPorterIcon(), nil)
        end

        -- Update hearthstone macro icon + body
        Porter:UpdateHearthstoneMacro()
    end)
end

-- Update the hearthstone macro body and icon to match current mode
function Porter:UpdateHearthstoneMacro()
    local idx = GetMacroIndexByName(HS_NAME)
    if idx == 0 or not self:IsPorterHSMacro(idx) then return end
    if InCombatLockdown() then return end
    local ok, macro = pcall(function() return self:GetHearthstoneMacro() end)
    if ok and macro then
        EditMacro(idx, nil, self:GetHSIcon(), macro)
        local itemID = macro:match("/use item:(%d+)")
        self.lastHearthID = itemID and tonumber(itemID) or nil
    end
end


-----------------------------------------------------------------------
-- SLASH COMMAND
-- /porter toggles the main window.
-----------------------------------------------------------------------
SLASH_PORTER1 = "/porter"
SlashCmdList["PORTER"] = function(msg)
    if msg == "rr" then
        Porter:UpdateHearthstoneMacro()
    else
        Porter:Toggle()
    end
end



-----------------------------------------------------------------------
-- MINIMAP BUTTON
-- Uses LibDataBroker + LibDBIcon to create a minimap icon.
-- Left-click toggles the Porter window.
-- Right-click opens settings.
-----------------------------------------------------------------------
function Porter:SetupMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1")
    local LDBIcon = LibStub("LibDBIcon-1.0")

    -- Create a data broker object (defines the icon, tooltip, and click behavior)
    local porterBroker = LDB:NewDataObject("Porter", {
        type = "launcher",
        text = "Porter",
        icon = "Interface\\AddOns\\Porter\\porter",
        OnClick = function(_, button)
            if button == "LeftButton" then
                Porter:Toggle()
            elseif button == "RightButton" then
                Porter:ToggleSettings()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("Porter")
            tooltip:AddLine("Left-click to toggle teleport window.", 1, 1, 1)
            tooltip:AddLine("Right-click for settings.", 1, 1, 1)
        end,
    })

    -- Register with LibDBIcon to render it on the minimap
    LDBIcon:Register("Porter", porterBroker, self.db.minimap)
end
