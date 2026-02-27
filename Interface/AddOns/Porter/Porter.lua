-- Porter.lua
-- Main entry point. Handles addon initialization, event registration,
-- slash command, and minimap button setup.

local addonName, Porter = ...

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
-- SLASH COMMAND
-- /porter toggles the main window.
-----------------------------------------------------------------------
SLASH_PORTER1 = "/porter"
SlashCmdList["PORTER"] = function()
    Porter:Toggle()
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
