-- UI.lua
-- 3-column horizontal layout: General | Dungeons | Raids

local addonName, Porter = ...

local BUTTON_SIZE = 40
local BUTTON_SPACING = 6
local ICONS_PER_ROW = 4        -- icons per row in column 1 (General)
local HEADER_HEIGHT = 20
local CATEGORY_PADDING = 12
local FRAME_PADDING = 16
local TAB_HEIGHT = 20
local EXPAC_BTN_HEIGHT = 22
local LIST_ROW_HEIGHT = 28     -- height of each icon+name row in current view
local COLUMN_WIDTH = 200
local COLUMN_SPACING = 16
local HEADER_BAR_HEIGHT = 50   -- top bar with logo/title/close
-- Min height: header bar + padding + column header + tabs + 8 dungeon rows
local MIN_CONTENT_HEIGHT = HEADER_BAR_HEIGHT + 4 + CATEGORY_PADDING + HEADER_HEIGHT + TAB_HEIGHT + 10 + 8 * (LIST_ROW_HEIGHT + 4) + FRAME_PADDING

Porter.buttons = {}
Porter.activeTab = {}
Porter.activeExpansion = {}

-- Reusable UI element pools
Porter.headers = {}
Porter.tabs = {}
Porter.expacButtons = {}
Porter.nameLabels = {}
Porter.flyouts = {}
Porter.flyoutTimer = nil

-----------------------------------------------------------------------
-- MAIN FRAME
-----------------------------------------------------------------------
function Porter:CreateMainFrame()
    local totalWidth = FRAME_PADDING * 2 + 3 * COLUMN_WIDTH + 2 * COLUMN_SPACING
    local f = CreateFrame("Frame", "PorterFrame", UIParent, "BackdropTemplate")
    f:SetSize(totalWidth, 400)
    f:SetPoint(
        self.db.position.point,
        UIParent,
        self.db.position.point,
        self.db.position.x,
        self.db.position.y
    )
    f:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        tile     = false,
    })
    f:SetBackdropColor(0.1, 0.1, 0.1, 0.97)

    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", function(frame)
        frame:StopMovingOrSizing()
        Porter:SavePosition(frame)
    end)

    f:SetScript("OnShow", function() PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN) end)
    f:SetScript("OnHide", function() PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE) end)
    tinsert(UISpecialFrames, "PorterFrame")

    -- Header bar background
    local headerBar = CreateFrame("Frame", nil, f, "BackdropTemplate")
    headerBar:SetPoint("TOPLEFT", 6, -6)
    headerBar:SetPoint("TOPRIGHT", -6, -6)
    headerBar:SetHeight(HEADER_BAR_HEIGHT - 12)
    headerBar:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        tile     = false,
    })
    headerBar:SetBackdropColor(0.14, 0.14, 0.14, 1)

    local logo = headerBar:CreateTexture(nil, "ARTWORK")
    logo:SetSize(40, 40)
    logo:SetPoint("LEFT", 10, 0)
    logo:SetTexture("Interface\\AddOns\\Porter\\porter")

    local title = headerBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", logo, "RIGHT", 8, 0)
    title:SetText("Porter")
    title:SetTextColor(1, 1, 1, 1)

    -- Custom close button
    local closeBtn = CreateFrame("Button", nil, headerBar)
    closeBtn:SetSize(24, 24)
    closeBtn:SetPoint("RIGHT", -4, 0)
    local closeTxt = closeBtn:CreateFontString(nil, "OVERLAY")
    closeTxt:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    closeTxt:SetAllPoints()
    closeTxt:SetJustifyH("CENTER")
    closeTxt:SetJustifyV("MIDDLE")
    closeTxt:SetText("X")
    closeTxt:SetTextColor(1, 1, 1, 1)
    closeBtn:SetScript("OnEnter", function() closeTxt:SetTextColor(1, 0.2, 0.2, 1) end)
    closeBtn:SetScript("OnLeave", function() closeTxt:SetTextColor(1, 1, 1, 1) end)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    f:Hide()
    self.frame = f
    return f
end

-----------------------------------------------------------------------
-- AVAILABILITY CHECK
-----------------------------------------------------------------------
function Porter:IsAvailable(entry)
    if entry.alwaysAvailable then return true end

    -- Housing entries are always available once populated
    if entry.type == "housing" then return true end

    if entry.classReq then
        local _, playerClass = UnitClass("player")
        if playerClass ~= entry.classReq then return false end
    end
    if entry.raceReq then
        local _, raceFile = UnitRace("player")
        if raceFile ~= entry.raceReq then return false end
    end

    if entry.type == "spell" then
        if IsPlayerSpell(entry.id) then return true end
        if IsSpellKnown(entry.id) then return true end
        return false
    elseif entry.type == "item" then
        -- Check bags, bank, AND equipped items
        if C_Item.GetItemCount(entry.id, true) > 0 then return true end
        -- Check all equipped slots (1-19)
        for slot = 1, 19 do
            local itemID = GetInventoryItemID("player", slot)
            if itemID and itemID == entry.id then return true end
        end
        return false
    elseif entry.type == "toy" then
        if not PlayerHasToy(entry.id) then return false end
        if entry.profReq and not C_ToyBox.IsToyUsable(entry.id) then return false end
        return true
    end
    return false
end

-----------------------------------------------------------------------
-- GET ICON
-----------------------------------------------------------------------
function Porter:GetIcon(entry)
    if entry.type == "housing" then
        return 4549198  -- Housing icon (inv_misc_key_15)
    elseif entry.type == "spell" then
        local info = C_Spell.GetSpellInfo(entry.id)
        return info and info.iconID or 134400
    elseif entry.type == "item" then
        local _, _, _, _, icon = C_Item.GetItemInfoInstant(entry.id)
        return icon or 134400
    elseif entry.type == "toy" then
        local _, name, icon = C_ToyBox.GetToyInfo(entry.id)
        if not icon then
            icon = C_Item.GetItemIconByID(entry.id)
        end
        return icon or 134400
    end
    return 134400
end

-----------------------------------------------------------------------
-- GET DISPLAY NAME
-----------------------------------------------------------------------
function Porter:GetDisplayName(entry)
    if entry.type == "spell" then
        local info = C_Spell.GetSpellInfo(entry.id)
        return info and info.name or entry.name
    elseif entry.type == "item" then
        local name = C_Item.GetItemInfo(entry.id)
        return name or entry.name
    elseif entry.type == "toy" then
        local _, name = C_ToyBox.GetToyInfo(entry.id)
        return name or entry.name
    end
    return entry.name
end

-----------------------------------------------------------------------
-- UPDATE COOLDOWN
-----------------------------------------------------------------------
function Porter:UpdateCooldown(button, entry)
    if not button.cooldown then return end
    if entry.type == "housing" then return end
    local ok = pcall(function()
        local start, duration, enabled = 0, 0, 1
        if entry.type == "spell" then
            local cdInfo = C_Spell.GetSpellCooldown(entry.id)
            if cdInfo then
                start = cdInfo.startTime or 0
                duration = cdInfo.duration or 0
            end
        elseif entry.cosmetic then
            -- Cosmetic hearthstones share the Hearthstone spell cooldown (respects guild perk)
            local cdInfo = C_Spell.GetSpellCooldown(8690)
            if cdInfo then
                start = cdInfo.startTime or 0
                duration = cdInfo.duration or 0
            end
        elseif entry.type == "item" or entry.type == "toy" then
            start, duration, enabled = C_Item.GetItemCooldown(entry.id)
        end
        if start and duration then
            CooldownFrame_Set(button.cooldown, start, duration, enabled)
        end
    end)
    -- If tainted (instanced content), just leave the cooldown as-is.
    -- The existing spinner state remains valid until SPELL_UPDATE_COOLDOWN
    -- fires again (e.g. after final boss kill resets the cooldown).
end

-----------------------------------------------------------------------
-- KEYSTONE DETECTION
-----------------------------------------------------------------------
function Porter:GetKeystoneInfo()
    local mapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local level = C_MythicPlus.GetOwnedKeystoneLevel()
    return mapID, level
end

-----------------------------------------------------------------------
-- CHECK IF ITEM IS EQUIPPED
-----------------------------------------------------------------------
function Porter:IsEquipped(itemID)
    for slot = 1, 19 do
        local equippedID = GetInventoryItemID("player", slot)
        if equippedID and equippedID == itemID then return true end
    end
    return false
end

-----------------------------------------------------------------------
-- EQUIP SLOT MAPPING
-----------------------------------------------------------------------
local EQUIP_SLOT_MAP = {
    INVTYPE_CLOAK  = { 15 },
    INVTYPE_TABARD = { 19 },
    INVTYPE_FINGER = { 11, 12 },
}

function Porter:GetEquipSlots(itemID)
    local _, _, _, equipLoc = C_Item.GetItemInfoInstant(itemID)
    return equipLoc and EQUIP_SLOT_MAP[equipLoc] or nil
end

-----------------------------------------------------------------------
-- CREATE BUTTON
-----------------------------------------------------------------------
function Porter:CreateButton(parent, entry, index)
    local btn = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
    btn:SetSize(BUTTON_SIZE, BUTTON_SIZE)
    btn:RegisterForClicks("AnyUp", "AnyDown")

    if entry.type == "housing" then
        btn:SetAttribute("type", "teleporthome")
        btn:SetAttribute("house-neighborhood-guid", entry.neighborhoodGUID or "")
        btn:SetAttribute("house-guid", entry.houseGUID or "")
        btn:SetAttribute("house-plot-id", entry.plotID or 0)
    else
        local spellName = self:GetDisplayName(entry)
        btn:SetAttribute("type", "macro")
        if entry.type == "spell" then
            btn:SetAttribute("macrotext", "/cast " .. spellName)
        elseif entry.type == "item" or entry.type == "toy" then
            if entry.equippable then
                btn:SetAttribute("macrotext", "/equip item:" .. entry.id .. "\n/use item:" .. entry.id)
            else
                btn:SetAttribute("macrotext", "/use item:" .. entry.id)
            end
        end
    end

    -- Override base Hearthstone with cosmetic hearthstone mode
    if entry.id == 8690 and entry.type == "spell" then
        local mode = self.db.settings.hearthstoneMode
        if mode == "Specific" then
            local choiceID = self.db.settings.hearthstoneChoice
            if choiceID and PlayerHasToy(choiceID) then
                btn:SetAttribute("macrotext", "/use item:" .. choiceID)
            end
        elseif mode == "Random" then
            btn:SetAttribute("macrotext", self:GetHearthstoneMacro())
            -- Re-roll on each click via PreClick
            btn:SetScript("PreClick", function()
                if not InCombatLockdown() then
                    btn:SetAttribute("macrotext", Porter:GetHearthstoneMacro())
                end
            end)
        end
    end

    local icon = btn:CreateTexture(nil, "BACKGROUND")
    icon:SetAllPoints()
    -- Show the chosen cosmetic hearthstone icon in Specific mode
    if entry.id == 8690 and entry.type == "spell" and self.db.settings.hearthstoneMode == "Specific" then
        local choiceID = self.db.settings.hearthstoneChoice
        if choiceID and PlayerHasToy(choiceID) then
            icon:SetTexture(self:GetIcon({ type = "toy", id = choiceID }))
        else
            icon:SetTexture(self:GetIcon(entry))
        end
    else
        icon:SetTexture(self:GetIcon(entry))
    end
    btn.icon = icon

    -- Hover highlight
    local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    highlight:SetBlendMode("ADD")
    highlight:SetAlpha(0.3)

    local cooldown = CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
    cooldown:SetAllPoints()
    btn.cooldown = cooldown

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if entry.type == "housing" then
            GameTooltip:AddLine("Teleport Home")
            GameTooltip:AddLine(entry.name, 1, 1, 1)
        elseif entry.type == "spell" then
            GameTooltip:SetSpellByID(entry.id)
        elseif entry.type == "item" then
            GameTooltip:SetItemByID(entry.id)
        elseif entry.type == "toy" then
            GameTooltip:SetToyByItemID(entry.id)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    local keyText = btn:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall")
    keyText:SetPoint("BOTTOMRIGHT", -2, 2)
    keyText:SetTextColor(0, 1, 0)
    keyText:Hide()
    btn.keyText = keyText

    -- Equip status indicator and re-equip tracking for equippable items
    if entry.equippable then
        local statusText = btn:CreateFontString(nil, "OVERLAY")
        statusText:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
        statusText:SetPoint("BOTTOM", 0, 2)
        btn.equipStatus = statusText

        -- Save a snapshot of all candidate slots before the secure action fires
        btn:SetScript("PreClick", function()
            local slots = Porter:GetEquipSlots(entry.id)
            if not slots then return end
            local snapshot = {}
            for _, slot in ipairs(slots) do
                snapshot[slot] = {
                    id = GetInventoryItemID("player", slot),
                    link = GetInventoryItemLink("player", slot),
                }
            end
            Porter.pendingReequip = {
                slots = snapshot,
                porterItemID = entry.id,
            }
        end)
    end

    btn.entry = entry
    return btn
end

-----------------------------------------------------------------------
-- STYLE TAB
-----------------------------------------------------------------------
function Porter:StyleTab(tab, isActive)
    tab:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        tile     = false,
    })
    if isActive then
        tab.text:SetTextColor(1, 1, 1, 1)
        tab:SetBackdropColor(0.6, 0.3, 0.9, 0.4)
    else
        tab.text:SetTextColor(0.5, 0.5, 0.5, 1)
        tab:SetBackdropColor(0.2, 0.2, 0.2, 0.3)
    end
end

-----------------------------------------------------------------------
-- FLYOUT: Hover popup for mage teleports/portals
-----------------------------------------------------------------------
local FLYOUT_ROW_HEIGHT = 24
local FLYOUT_ICON_SIZE = 20
local FLYOUT_WIDTH = 200
local FLYOUT_PADDING = 8

function Porter:CreateFlyout(triggerBtn, entries, label)
    local flyout = CreateFrame("Frame", nil, self.frame, "BackdropTemplate")
    flyout:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        tile     = false,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    flyout:SetBackdropColor(0.1, 0.1, 0.1, 1)
    flyout:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
    flyout:SetFrameStrata("DIALOG")

    local contentHeight = FLYOUT_PADDING * 2 + #entries * FLYOUT_ROW_HEIGHT
    flyout:SetSize(FLYOUT_WIDTH, contentHeight)
    flyout:SetPoint("TOPLEFT", triggerBtn, "TOPRIGHT", 4, 0)

    for i, entry in ipairs(entries) do
        local row = CreateFrame("Button", nil, flyout, "SecureActionButtonTemplate")
        row:SetSize(FLYOUT_WIDTH - FLYOUT_PADDING * 2, FLYOUT_ROW_HEIGHT)
        row:SetPoint("TOPLEFT", flyout, "TOPLEFT", FLYOUT_PADDING, -FLYOUT_PADDING - (i - 1) * FLYOUT_ROW_HEIGHT)
        row:RegisterForClicks("AnyUp", "AnyDown")

        local spellName = self:GetDisplayName(entry)
        row:SetAttribute("type", "macro")
        row:SetAttribute("macrotext", "/cast " .. spellName)

        local icon = row:CreateTexture(nil, "ARTWORK")
        icon:SetSize(FLYOUT_ICON_SIZE, FLYOUT_ICON_SIZE)
        icon:SetPoint("LEFT", 0, 0)
        icon:SetTexture(self:GetIcon(entry))

        -- Strip "Teleport: " or "Portal: " prefix for cleaner display
        local displayName = entry.name:gsub("^Teleport: ", ""):gsub("^Portal: ", "")
        local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        nameText:SetPoint("LEFT", icon, "RIGHT", 6, 0)
        nameText:SetText(displayName)
        nameText:SetTextColor(1, 1, 1, 1)

        local hl = row:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.05)

        row:SetScript("OnEnter", function()
            nameText:SetTextColor(0.6, 0.3, 0.9, 1)
            GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
            GameTooltip:SetSpellByID(entry.id)
            GameTooltip:Show()
            self:CancelFlyoutHide()
        end)
        row:SetScript("OnLeave", function()
            nameText:SetTextColor(1, 1, 1, 1)
            GameTooltip:Hide()
            self:ScheduleFlyoutHide(flyout)
        end)
    end

    flyout:SetScript("OnEnter", function()
        self:CancelFlyoutHide()
    end)
    flyout:SetScript("OnLeave", function()
        self:ScheduleFlyoutHide(flyout)
    end)

    flyout:Hide()
    tinsert(self.flyouts, flyout)
    return flyout
end

function Porter:ScheduleFlyoutHide(flyout)
    self:CancelFlyoutHide()
    self.flyoutTimer = C_Timer.NewTimer(0.15, function()
        flyout:Hide()
        self.flyoutTimer = nil
    end)
end

function Porter:CancelFlyoutHide()
    if self.flyoutTimer then
        self.flyoutTimer:Cancel()
        self.flyoutTimer = nil
    end
end

function Porter:CreateFlyoutTrigger(entry, xOffset, yOffset, buttonIndex, flyoutEntries, label)
    buttonIndex = buttonIndex + 1
    local btn = self:CreateButton(self.frame, entry, buttonIndex)
    btn:SetPoint("TOPLEFT", self.frame, "TOPLEFT", xOffset, yOffset)
    btn:Show()
    tinsert(self.buttons, btn)

    -- Override the default OnEnter/OnLeave to show/hide flyout
    local flyout = self:CreateFlyout(btn, flyoutEntries, label)

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(label)
        GameTooltip:Show()
        Porter:CancelFlyoutHide()
        -- Hide all other flyouts before showing this one
        for _, f in ipairs(Porter.flyouts) do
            if f ~= flyout then f:Hide() end
        end
        flyout:Show()
    end)
    btn:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        Porter:ScheduleFlyoutHide(flyout)
    end)

    return buttonIndex
end

-----------------------------------------------------------------------
-- LAYOUT: Icon grid (for General column)
-- xOffset = left edge of this column relative to frame
-----------------------------------------------------------------------
function Porter:LayoutGrid(entries, xOffset, yOffset, buttonIndex)
    for i, entry in ipairs(entries) do
        buttonIndex = buttonIndex + 1
        local btn = self:CreateButton(self.frame, entry, buttonIndex)
        local col = (i - 1) % ICONS_PER_ROW
        local row = math.floor((i - 1) / ICONS_PER_ROW)
        btn:SetPoint("TOPLEFT", self.frame, "TOPLEFT",
            xOffset + col * (BUTTON_SIZE + BUTTON_SPACING),
            yOffset - row * (BUTTON_SIZE + BUTTON_SPACING))
        btn:Show()
        tinsert(self.buttons, btn)
    end
    if #entries > 0 then
        local totalRows = math.ceil(#entries / ICONS_PER_ROW)
        yOffset = yOffset - totalRows * (BUTTON_SIZE + BUTTON_SPACING)
    end
    return yOffset, buttonIndex
end

-----------------------------------------------------------------------
-- LAYOUT: List with icon + name (for current dungeons/raids)
-----------------------------------------------------------------------
function Porter:LayoutList(entries, xOffset, yOffset, buttonIndex)
    for _, entry in ipairs(entries) do
        buttonIndex = buttonIndex + 1
        local btn = self:CreateButton(self.frame, entry, buttonIndex)
        btn:SetSize(LIST_ROW_HEIGHT, LIST_ROW_HEIGHT)
        btn:SetPoint("TOPLEFT", self.frame, "TOPLEFT", xOffset, yOffset)
        btn:Show()
        tinsert(self.buttons, btn)

        -- Clickable name label to the right of the icon
        local labelBtn = CreateFrame("Button", nil, self.frame, "SecureActionButtonTemplate")
        labelBtn:SetSize(COLUMN_WIDTH - LIST_ROW_HEIGHT - 10, LIST_ROW_HEIGHT)
        labelBtn:SetPoint("LEFT", btn, "RIGHT", 6, 0)
        labelBtn:RegisterForClicks("AnyUp", "AnyDown")
        if entry.type == "housing" then
            labelBtn:SetAttribute("type", "teleporthome")
            labelBtn:SetAttribute("house-neighborhood-guid", entry.neighborhoodGUID or "")
            labelBtn:SetAttribute("house-guid", entry.houseGUID or "")
            labelBtn:SetAttribute("house-plot-id", entry.plotID or 0)
        else
            labelBtn:SetAttribute("type", "macro")
            labelBtn:SetAttribute("macrotext", btn:GetAttribute("macrotext"))
        end

        local label = labelBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetAllPoints()
        label:SetJustifyH("LEFT")
        label:SetJustifyV("MIDDLE")
        label:SetText(entry.name)
        label:SetTextColor(1, 1, 1, 1)

        labelBtn:SetScript("OnEnter", function()
            label:SetTextColor(0.6, 0.3, 0.9, 1)
            GameTooltip:SetOwner(labelBtn, "ANCHOR_RIGHT")
            if entry.type == "housing" then
                GameTooltip:AddLine("Teleport Home")
                GameTooltip:AddLine(entry.name, 1, 1, 1)
            elseif entry.type == "spell" then
                GameTooltip:SetSpellByID(entry.id)
            elseif entry.type == "item" then
                GameTooltip:SetItemByID(entry.id)
            elseif entry.type == "toy" then
                GameTooltip:SetToyByItemID(entry.id)
            end
            GameTooltip:Show()
        end)
        labelBtn:SetScript("OnLeave", function()
            label:SetTextColor(1, 1, 1, 1)
            GameTooltip:Hide()
        end)

        tinsert(self.nameLabels, labelBtn)
        btn.nameLabel = label

        yOffset = yOffset - (LIST_ROW_HEIGHT + 4)
    end
    return yOffset, buttonIndex
end

-----------------------------------------------------------------------
-- HELPER: Get available entries from a category
-----------------------------------------------------------------------
function Porter:GetAvailable(category)
    -- Skip entire category if hidden in settings
    if self.db.settings.categoryVisibility[category] == false then return {} end
    local entries = self.TeleportData[category]
    if not entries then return {} end
    local available = {}
    local showCosmetic = self.db.settings.showCosmeticHearthstones
    for _, entry in ipairs(entries) do
        if entry.cosmetic and not showCosmetic then
            -- skip cosmetic hearthstones when setting is off
        elseif self:IsAvailable(entry) then
            tinsert(available, entry)
        end
    end
    return available
end

-----------------------------------------------------------------------
-- HELPER: Get owned cosmetic hearthstones
-----------------------------------------------------------------------
function Porter:GetOwnedCosmeticHearthstones()
    local owned = {}
    local entries = self.TeleportData["Hearthstones"]
    if not entries then return owned end
    for _, entry in ipairs(entries) do
        if entry.cosmetic and entry.type == "toy" and PlayerHasToy(entry.id) then
            tinsert(owned, entry)
        end
    end
    return owned
end

-----------------------------------------------------------------------
-- HELPER: Get hearthstone macro based on mode setting
-----------------------------------------------------------------------
function Porter:GetHearthstoneMacro()
    local mode = self.db.settings.hearthstoneMode
    if mode == "Specific" then
        local choiceID = self.db.settings.hearthstoneChoice
        if choiceID and PlayerHasToy(choiceID) then
            return "/use item:" .. choiceID
        end
    elseif mode == "Random" then
        local owned = self:GetOwnedCosmeticHearthstones()
        -- Filter to only toys not on cooldown
        local ready = {}
        for _, entry in ipairs(owned) do
            local start = C_Item.GetItemCooldown(entry.id)
            if not start or start == 0 then
                tinsert(ready, entry)
            end
        end
        -- Include the normal Hearthstone spell in the rotation
        local total = #ready + 1
        local roll = math.random(total)
        if roll > #ready then
            return "/cast Hearthstone"
        else
            return "/use item:" .. ready[roll].id
        end
    end
    -- Normal fallback
    return "/cast Hearthstone"
end

-----------------------------------------------------------------------
-- HELPER: Get available current entries
-----------------------------------------------------------------------
function Porter:GetAvailableCurrent(category)
    local entries = self.TeleportData[category]
    if not entries then return {} end
    local available = {}
    for _, entry in ipairs(entries) do
        if entry.current and self:IsAvailable(entry) then
            tinsert(available, entry)
        end
    end
    return available
end

-----------------------------------------------------------------------
-- HELPER: Build a tabbed column (Dungeons or Raids)
-----------------------------------------------------------------------
function Porter:BuildTabbedColumn(category, xOffset, yStart, buttonIndex)
    local yOffset = yStart

    if not self.activeTab[category] then
        self.activeTab[category] = "Current"
    end

    -- Column header
    local header = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT", self.frame, "TOPLEFT", xOffset, yOffset)
    header:SetText(category)
    header:SetTextColor(0.4, 0.55, 0.85, 1)
    tinsert(self.headers, header)
    yOffset = yOffset - HEADER_HEIGHT

    -- Current / Legacy tabs
    local currentTab = CreateFrame("Button", nil, self.frame, "BackdropTemplate")
    currentTab:SetSize(60, TAB_HEIGHT)
    currentTab:SetPoint("TOPLEFT", self.frame, "TOPLEFT", xOffset, yOffset)
    currentTab.text = currentTab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    currentTab.text:SetPoint("CENTER")
    currentTab.text:SetText("Current")
    currentTab:SetScript("OnClick", function()
        self.activeTab[category] = "Current"
        self.activeExpansion[category] = nil
        self:BuildLayout()
        self:UpdateAllCooldowns()
        self:UpdateEquipStatus()
        self:HighlightKeystone()
    end)
    tinsert(self.tabs, currentTab)

    local legacyTab = CreateFrame("Button", nil, self.frame, "BackdropTemplate")
    legacyTab:SetSize(60, TAB_HEIGHT)
    legacyTab:SetPoint("TOPLEFT", self.frame, "TOPLEFT", xOffset + 64, yOffset)
    legacyTab.text = legacyTab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    legacyTab.text:SetPoint("CENTER")
    legacyTab.text:SetText("Legacy")
    legacyTab:SetScript("OnClick", function()
        self.activeTab[category] = "Legacy"
        self.activeExpansion[category] = nil
        self:BuildLayout()
        self:UpdateAllCooldowns()
        self:UpdateEquipStatus()
        self:HighlightKeystone()
    end)
    tinsert(self.tabs, legacyTab)

    self:StyleTab(currentTab, self.activeTab[category] == "Current")
    self:StyleTab(legacyTab, self.activeTab[category] == "Legacy")
    yOffset = yOffset - TAB_HEIGHT - 10

    if self.activeTab[category] == "Current" then
        -- List view: icon + name per row
        local available = self:GetAvailableCurrent(category)
        yOffset, buttonIndex = self:LayoutList(available, xOffset, yOffset, buttonIndex)
    else
        -- Legacy view: collapsible expansion sections
        local activeExpac = self.activeExpansion[category]
        local entries = self.TeleportData[category]
        if not entries then return yOffset, buttonIndex end

        for _, expacName in ipairs(self.ExpansionOrder) do
            local expacEntries = {}
            for _, entry in ipairs(entries) do
                if entry.expansion == expacName and self:IsAvailable(entry) then
                    tinsert(expacEntries, entry)
                end
            end

            if #expacEntries > 0 then
                local expBtn = CreateFrame("Button", nil, self.frame)
                expBtn:SetSize(COLUMN_WIDTH, EXPAC_BTN_HEIGHT)
                expBtn:SetPoint("TOPLEFT", self.frame, "TOPLEFT", xOffset, yOffset)

                local expText = expBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                expText:SetPoint("LEFT", 4, 0)

                local isExpanded = (activeExpac == expacName)
                local arrow = isExpanded and "v " or "> "
                expText:SetText(arrow .. expacName .. " (" .. #expacEntries .. ")")

                local normalR, normalG, normalB
                if isExpanded then
                    normalR, normalG, normalB = 0.4, 0.55, 0.85
                else
                    normalR, normalG, normalB = 0.8, 0.8, 0.8
                end
                expText:SetTextColor(normalR, normalG, normalB, 1)

                expBtn:SetScript("OnEnter", function()
                    expText:SetTextColor(1, 1, 1, 1)
                end)
                expBtn:SetScript("OnLeave", function()
                    expText:SetTextColor(normalR, normalG, normalB, 1)
                end)

                local hl = expBtn:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetColorTexture(1, 1, 1, 0.05)

                expBtn:SetScript("OnClick", function()
                    if self.activeExpansion[category] == expacName then
                        self.activeExpansion[category] = nil
                    else
                        self.activeExpansion[category] = expacName
                    end
                    self:BuildLayout()
                    self:UpdateAllCooldowns()
                    self:UpdateEquipStatus()
                    self:HighlightKeystone()
                end)

                tinsert(self.expacButtons, expBtn)
                yOffset = yOffset - EXPAC_BTN_HEIGHT

                if isExpanded then
                    yOffset = yOffset - 2
                    yOffset, buttonIndex = self:LayoutGrid(expacEntries, xOffset, yOffset, buttonIndex)
                end
            end
        end
    end

    return yOffset, buttonIndex
end

-----------------------------------------------------------------------
-- BUILD LAYOUT — dynamic columns that collapse when categories hidden
-----------------------------------------------------------------------
function Porter:BuildLayout()
    if not self.frame then return end

    -- Clean up old elements
    for _, btn in ipairs(self.buttons) do btn:Hide(); btn:SetParent(nil) end
    wipe(self.buttons)
    if self.headers then for _, h in ipairs(self.headers) do h:Hide() end end
    self.headers = {}
    if self.tabs then for _, t in ipairs(self.tabs) do t:Hide() end end
    self.tabs = {}
    if self.expacButtons then for _, b in ipairs(self.expacButtons) do b:Hide() end end
    self.expacButtons = {}
    if self.nameLabels then for _, l in ipairs(self.nameLabels) do l:Hide() end end
    self.nameLabels = {}
    if self.flyouts then for _, f in ipairs(self.flyouts) do f:Hide() end end
    self.flyouts = {}
    self:CancelFlyoutHide()

    local buttonIndex = 0
    local contentTop = -(HEADER_BAR_HEIGHT + 4)
    local vis = self.db.settings.categoryVisibility

    -- Determine which logical columns have content (enabled AND have available entries)
    local hasGeneral = false
    for _, cat in ipairs({"Hearthstones", "Class & Racial", "Items", "Toys"}) do
        if vis[cat] ~= false and #self:GetAvailable(cat) > 0 then
            hasGeneral = true
            break
        end
    end
    local hasDungeons = vis["Dungeons"] ~= false and #self:GetAvailable("Dungeons") > 0
    local hasRaids = vis["Raids"] ~= false and #self:GetAvailable("Raids") > 0
    local hasDelves = vis["Delves"] ~= false and #self:GetAvailable("Delves") > 0
    local hasHouse = vis["House"] ~= false and #self:GetAvailable("House") > 0
    local hasRaidsDelves = hasRaids or hasDelves or hasHouse

    -- Assign x positions to visible columns, collapsing empty ones
    local columnXPositions = {}
    local numColumns = 0
    if hasGeneral then
        numColumns = numColumns + 1
        columnXPositions.general = FRAME_PADDING + (numColumns - 1) * (COLUMN_WIDTH + COLUMN_SPACING)
    end
    if hasDungeons then
        numColumns = numColumns + 1
        columnXPositions.dungeons = FRAME_PADDING + (numColumns - 1) * (COLUMN_WIDTH + COLUMN_SPACING)
    end
    if hasRaidsDelves then
        numColumns = numColumns + 1
        columnXPositions.raidsDelves = FRAME_PADDING + (numColumns - 1) * (COLUMN_WIDTH + COLUMN_SPACING)
    end
    numColumns = math.max(numColumns, 1)

    local columnBottoms = {}

    -----------------------------------------------------------------
    -- General column (Hearthstones, Class & Racial, Items, Toys)
    -----------------------------------------------------------------
    if hasGeneral then
        local colX = columnXPositions.general
        local colY = contentTop
        local generalCategories = { "Hearthstones", "Class & Racial", "Items", "Toys" }

        for _, category in ipairs(generalCategories) do
            local available = self:GetAvailable(category)
            if #available > 0 then
                local regular = {}
                local mageTeleports = {}
                local magePortals = {}
                for _, entry in ipairs(available) do
                    if entry.mageType == "teleport" then
                        tinsert(mageTeleports, entry)
                    elseif entry.mageType == "portal" then
                        tinsert(magePortals, entry)
                    else
                        tinsert(regular, entry)
                    end
                end

                local hasRegular = #regular > 0
                local hasMage = #mageTeleports > 0 or #magePortals > 0

                if hasRegular or hasMage then
                    colY = colY - CATEGORY_PADDING
                    local header = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                    header:SetPoint("TOPLEFT", self.frame, "TOPLEFT", colX, colY)
                    header:SetText(category)
                    header:SetTextColor(0.4, 0.55, 0.85, 1)
                    tinsert(self.headers, header)
                    colY = colY - HEADER_HEIGHT

                    if hasRegular then
                        colY, buttonIndex = self:LayoutGrid(regular, colX, colY, buttonIndex)
                    end

                    if #mageTeleports > 0 then
                        local triggerCol = hasRegular and (#regular % ICONS_PER_ROW) or 0
                        if triggerCol == 0 and hasRegular then
                        else
                            if hasRegular and triggerCol > 0 then
                                colY = colY + (BUTTON_SIZE + BUTTON_SPACING)
                            end
                        end
                        buttonIndex = self:CreateFlyoutTrigger(
                            mageTeleports[1],
                            colX + triggerCol * (BUTTON_SIZE + BUTTON_SPACING),
                            colY, buttonIndex, mageTeleports, "Teleports"
                        )
                        triggerCol = triggerCol + 1

                        if #magePortals > 0 then
                            if triggerCol >= ICONS_PER_ROW then
                                triggerCol = 0
                                colY = colY - (BUTTON_SIZE + BUTTON_SPACING)
                            end
                            buttonIndex = self:CreateFlyoutTrigger(
                                magePortals[1],
                                colX + triggerCol * (BUTTON_SIZE + BUTTON_SPACING),
                                colY, buttonIndex, magePortals, "Portals"
                            )
                            triggerCol = triggerCol + 1
                        end

                        colY = colY - (BUTTON_SIZE + BUTTON_SPACING)
                    end
                end
            end
        end
        tinsert(columnBottoms, colY)
    end

    -----------------------------------------------------------------
    -- Dungeons column
    -----------------------------------------------------------------
    if hasDungeons then
        local colX = columnXPositions.dungeons
        local colY = contentTop - CATEGORY_PADDING
        colY, buttonIndex = self:BuildTabbedColumn("Dungeons", colX, colY, buttonIndex)
        tinsert(columnBottoms, colY)
    end

    -----------------------------------------------------------------
    -- Raids + Delves column
    -----------------------------------------------------------------
    if hasRaidsDelves then
        local colX = columnXPositions.raidsDelves
        local colY = contentTop - CATEGORY_PADDING

        if vis["Raids"] ~= false then
            colY, buttonIndex = self:BuildTabbedColumn("Raids", colX, colY, buttonIndex)
        end

        if vis["Delves"] ~= false then
            local delvesAvailable = self:GetAvailable("Delves")
            if #delvesAvailable > 0 then
                colY = colY - CATEGORY_PADDING
                local delvesHeader = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                delvesHeader:SetPoint("TOPLEFT", self.frame, "TOPLEFT", colX, colY)
                delvesHeader:SetText("Delves")
                delvesHeader:SetTextColor(0.4, 0.55, 0.85, 1)
                tinsert(self.headers, delvesHeader)
                colY = colY - HEADER_HEIGHT
                colY, buttonIndex = self:LayoutGrid(delvesAvailable, colX, colY, buttonIndex)
            end
        end

        if vis["House"] ~= false then
            local houseAvailable = self:GetAvailable("House")
            if #houseAvailable > 0 then
                colY = colY - CATEGORY_PADDING
                local houseHeader = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                houseHeader:SetPoint("TOPLEFT", self.frame, "TOPLEFT", colX, colY)
                houseHeader:SetText("House")
                houseHeader:SetTextColor(0.4, 0.55, 0.85, 1)
                tinsert(self.headers, houseHeader)
                colY = colY - HEADER_HEIGHT
                colY, buttonIndex = self:LayoutList(houseAvailable, colX, colY, buttonIndex)
            end
        end
        tinsert(columnBottoms, colY)
    end

    -----------------------------------------------------------------
    -- Resize frame to fit visible columns
    -----------------------------------------------------------------
    local totalWidth = FRAME_PADDING * 2 + numColumns * COLUMN_WIDTH + (numColumns - 1) * COLUMN_SPACING
    local maxDepth = 0
    for _, bottom in ipairs(columnBottoms) do
        maxDepth = math.max(maxDepth, math.abs(bottom))
    end
    local totalHeight = math.max(maxDepth + FRAME_PADDING, MIN_CONTENT_HEIGHT)
    self.frame:SetSize(totalWidth, totalHeight)

end

-----------------------------------------------------------------------
-- UPDATE COOLDOWNS
-----------------------------------------------------------------------
function Porter:UpdateAllCooldowns()
    for _, btn in ipairs(self.buttons) do
        if btn.entry then
            self:UpdateCooldown(btn, btn.entry)
        end
    end
end

-----------------------------------------------------------------------
-- UPDATE EQUIP STATUS
-----------------------------------------------------------------------
function Porter:UpdateEquipStatus()
    for _, btn in ipairs(self.buttons) do
        if btn.equipStatus and btn.entry then
            local start = C_Item.GetItemCooldown(btn.entry.id)
            if start and start > 0 then
                btn.equipStatus:SetText("")
            elseif self:IsEquipped(btn.entry.id) then
                btn.equipStatus:SetText("Ready")
                btn.equipStatus:SetTextColor(0, 1, 0, 1)
            else
                btn.equipStatus:SetText("Equip")
                btn.equipStatus:SetTextColor(1, 0.5, 0, 1)
            end
        end
    end
end

-----------------------------------------------------------------------
-- HIGHLIGHT KEYSTONE
-----------------------------------------------------------------------
function Porter:HighlightKeystone()
    local keystoneMapID, keystoneLevel = self:GetKeystoneInfo()
    for _, btn in ipairs(self.buttons) do
        if btn.keystoneGlow then btn.keystoneGlow:Hide() end
        if btn.keyText then btn.keyText:Hide() end

        if keystoneMapID and btn.entry and btn.entry.mapID and btn.entry.mapID == keystoneMapID then
            if not btn.keystoneGlow then
                local glow = btn:CreateTexture(nil, "OVERLAY")
                glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
                glow:SetBlendMode("ADD")
                glow:SetPoint("TOPLEFT", -6, 6)
                glow:SetPoint("BOTTOMRIGHT", 6, -6)
                glow:SetVertexColor(0, 1, 0, 0.7)
                btn.keystoneGlow = glow
            end
            btn.keystoneGlow:Show()
            if keystoneLevel and btn.nameLabel then
                btn.nameLabel:SetText(btn.entry.name .. "  |cff00ff00+" .. keystoneLevel .. "|r")
            end
        end
    end
end

-----------------------------------------------------------------------
-- SETTINGS PANEL
-----------------------------------------------------------------------
function Porter:RefreshMainFrame()
    if self.frame and self.frame:IsShown() and not InCombatLockdown() then
        self:BuildLayout()
        self:UpdateAllCooldowns()
        self:UpdateEquipStatus()
        self:HighlightKeystone()
    end
end

function Porter:CreateSettingsPanel()
    if self.settingsCategory then return end

    local f = CreateFrame("Frame", "PorterSettingsFrame")

    local yPos = -16

    -----------------------------------------------------------------
    -- SECTION: Hearthstone
    -----------------------------------------------------------------
    local hsHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    hsHeader:SetPoint("TOPLEFT", 12, yPos)
    hsHeader:SetText("Hearthstone")
    yPos = yPos - 24

    -- Cosmetic hearthstones checkbox
    local cb = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
    cb:SetSize(26, 26)
    cb:SetPoint("TOPLEFT", 10, yPos)
    cb:SetChecked(self.db.settings.showCosmeticHearthstones)
    local cbLabel = cb:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    cbLabel:SetPoint("LEFT", cb, "RIGHT", 4, 0)
    cbLabel:SetText("Show cosmetic hearthstones")
    cbLabel:SetTextColor(1, 1, 1, 1)
    cb:SetScript("OnClick", function(self)
        Porter.db.settings.showCosmeticHearthstones = self:GetChecked()
        Porter:RefreshMainFrame()
    end)

    yPos = yPos - 32

    -- Hearthstone Mode label
    local modeLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    modeLabel:SetPoint("TOPLEFT", 14, yPos)
    modeLabel:SetText("Hearthstone used:")
    modeLabel:SetTextColor(0.4, 0.55, 0.85, 1)
    yPos = yPos - 20

    -- Mode radio buttons
    local modes = { "Normal", "Random", "Specific" }
    local modeButtons = {}
    local choiceBtn -- forward ref for the specific choice button

    for i, mode in ipairs(modes) do
        local rb = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        rb:SetSize(26, 26)
        rb:SetPoint("TOPLEFT", 10, yPos)
        local rbLabel = rb:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        rbLabel:SetPoint("LEFT", rb, "RIGHT", 4, 0)
        rbLabel:SetText(mode)
        rbLabel:SetTextColor(1, 1, 1, 1)
        rb:SetChecked(self.db.settings.hearthstoneMode == mode)
        modeButtons[i] = rb

        rb:SetScript("OnClick", function()
            Porter.db.settings.hearthstoneMode = mode
            for j, other in ipairs(modeButtons) do
                other:SetChecked(modes[j] == mode)
            end
            if choiceBtn then
                if mode == "Specific" then
                    choiceBtn:Show()
                else
                    choiceBtn:Hide()
                end
            end
            Porter:RefreshMainFrame()
        end)

        yPos = yPos - 26
    end

    -- Specific hearthstone chooser button
    yPos = yPos - 4
    choiceBtn = CreateFrame("Button", nil, f, "BackdropTemplate")
    choiceBtn:SetSize(248, 28)
    choiceBtn:SetPoint("TOPLEFT", 14, yPos)
    choiceBtn:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        tile     = false,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    choiceBtn:SetBackdropColor(0.15, 0.15, 0.15, 1)
    choiceBtn:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)

    local choiceIcon = choiceBtn:CreateTexture(nil, "ARTWORK")
    choiceIcon:SetSize(20, 20)
    choiceIcon:SetPoint("LEFT", 4, 0)

    local choiceText = choiceBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    choiceText:SetPoint("LEFT", choiceIcon, "RIGHT", 6, 0)
    choiceText:SetTextColor(1, 1, 1, 1)

    -- Update the choice button display
    local function UpdateChoiceDisplay()
        local choiceID = Porter.db.settings.hearthstoneChoice
        if choiceID and PlayerHasToy(choiceID) then
            local _, name, toyIcon = C_ToyBox.GetToyInfo(choiceID)
            choiceIcon:SetTexture(toyIcon or C_Item.GetItemIconByID(choiceID) or 134400)
            choiceText:SetText(name or "Unknown")
        else
            choiceIcon:SetTexture(134400)
            choiceText:SetText("Click to choose...")
        end
    end
    UpdateChoiceDisplay()

    if self.db.settings.hearthstoneMode ~= "Specific" then
        choiceBtn:Hide()
    end

    -- Dropdown list for picking a specific cosmetic hearthstone
    local dropdown = CreateFrame("Frame", nil, f, "BackdropTemplate")
    dropdown:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        tile     = false,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    dropdown:SetBackdropColor(0.12, 0.12, 0.12, 1)
    dropdown:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
    dropdown:SetFrameStrata("TOOLTIP")
    dropdown:Hide()
    self.hearthstoneDropdown = dropdown

    choiceBtn:SetScript("OnClick", function()
        if dropdown:IsShown() then
            dropdown:Hide()
            return
        end

        -- Clear old rows
        for _, child in ipairs({ dropdown:GetChildren() }) do
            child:Hide()
            child:SetParent(nil)
        end

        local owned = Porter:GetOwnedCosmeticHearthstones()
        if #owned == 0 then return end

        local rowHeight = 24
        local ddWidth = 248
        dropdown:SetSize(ddWidth, #owned * rowHeight + 4)
        dropdown:SetPoint("TOPLEFT", choiceBtn, "BOTTOMLEFT", 0, -2)

        for i, entry in ipairs(owned) do
            local row = CreateFrame("Button", nil, dropdown)
            row:SetSize(ddWidth - 4, rowHeight)
            row:SetPoint("TOPLEFT", 2, -(2 + (i - 1) * rowHeight))

            local rIcon = row:CreateTexture(nil, "ARTWORK")
            rIcon:SetSize(18, 18)
            rIcon:SetPoint("LEFT", 4, 0)
            rIcon:SetTexture(Porter:GetIcon(entry))

            local rName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            rName:SetPoint("LEFT", rIcon, "RIGHT", 6, 0)
            rName:SetText(entry.name)
            rName:SetTextColor(1, 1, 1, 1)

            local hl = row:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(1, 1, 1, 0.05)

            row:SetScript("OnClick", function()
                Porter.db.settings.hearthstoneChoice = entry.id
                UpdateChoiceDisplay()
                dropdown:Hide()
                Porter:RefreshMainFrame()
            end)
        end

        dropdown:Show()
    end)

    -- Hide dropdown when settings panel hides
    f:SetScript("OnHide", function()
        if Porter.hearthstoneDropdown then
            Porter.hearthstoneDropdown:Hide()
        end
    end)

    -----------------------------------------------------------------
    -- SECTION: Categories
    -----------------------------------------------------------------
    yPos = yPos - 40

    local catHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    catHeader:SetPoint("TOPLEFT", 12, yPos)
    catHeader:SetText("Categories")
    yPos = yPos - 24

    for _, category in ipairs(self.Categories) do
        local catCB = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        catCB:SetSize(26, 26)
        catCB:SetPoint("TOPLEFT", 10, yPos)
        catCB:SetChecked(self.db.settings.categoryVisibility[category] ~= false)

        local catLabel = catCB:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        catLabel:SetPoint("LEFT", catCB, "RIGHT", 4, 0)
        catLabel:SetText(category)
        catLabel:SetTextColor(1, 1, 1, 1)

        catCB:SetScript("OnClick", function(self)
            Porter.db.settings.categoryVisibility[category] = self:GetChecked()
            Porter:RefreshMainFrame()
        end)

        yPos = yPos - 26
    end

    -----------------------------------------------------------------
    -- SECTION: Minimap
    -----------------------------------------------------------------
    yPos = yPos - 40

    local mmHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    mmHeader:SetPoint("TOPLEFT", 12, yPos)
    mmHeader:SetText("Minimap")
    yPos = yPos - 24

    local mmCB = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
    mmCB:SetSize(26, 26)
    mmCB:SetPoint("TOPLEFT", 10, yPos)
    mmCB:SetChecked(self.db.minimap.hide)

    local mmLabel = mmCB:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    mmLabel:SetPoint("LEFT", mmCB, "RIGHT", 4, 0)
    mmLabel:SetText("Hide minimap icon")
    mmLabel:SetTextColor(1, 1, 1, 1)

    mmCB:SetScript("OnClick", function(self)
        local LDBIcon = LibStub("LibDBIcon-1.0")
        Porter.db.minimap.hide = self:GetChecked()
        if Porter.db.minimap.hide then
            LDBIcon:Hide("Porter")
        else
            LDBIcon:Show("Porter")
        end
    end)

    -- Register with WoW's built-in Settings panel (ESC → Options → AddOns)
    local category = Settings.RegisterCanvasLayoutCategory(f, "Porter")
    Settings.RegisterAddOnCategory(category)
    self.settingsCategory = category
end

function Porter:ToggleSettings()
    if not self.settingsCategory then
        self:CreateSettingsPanel()
    end
    Settings.OpenToCategory(self.settingsCategory:GetID())
end

-----------------------------------------------------------------------
-- CHANGELOG POPUP
-----------------------------------------------------------------------
function Porter:ShowChangelog(sinceVersion)
    if self.changelogFrame then
        self.changelogFrame:Show()
        return
    end

    -- Collect versions to display (newer than sinceVersion)
    local entries = {}
    for _, entry in ipairs(self.ChangelogEntries) do
        if sinceVersion and entry.version == sinceVersion then break end
        tinsert(entries, entry)
    end

    if #entries == 0 then return end

    local f = CreateFrame("Frame", "PorterChangelogFrame", UIParent, "BackdropTemplate")
    f:SetSize(440, 400)
    f:SetPoint("CENTER")
    f:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 2,
        tile     = false,
        insets   = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    f:SetBackdropColor(0.1, 0.1, 0.1, 0.97)
    f:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    tinsert(UISpecialFrames, "PorterChangelogFrame")

    -- Header bar (matching Porter style)
    local headerBar = CreateFrame("Frame", nil, f, "BackdropTemplate")
    headerBar:SetPoint("TOPLEFT", 6, -6)
    headerBar:SetPoint("TOPRIGHT", -6, -6)
    headerBar:SetHeight(HEADER_BAR_HEIGHT - 12)
    headerBar:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        tile     = false,
    })
    headerBar:SetBackdropColor(0.14, 0.14, 0.14, 1)

    local logo = headerBar:CreateTexture(nil, "ARTWORK")
    logo:SetSize(40, 40)
    logo:SetPoint("LEFT", 10, 0)
    logo:SetTexture("Interface\\AddOns\\Porter\\porter")

    local title = headerBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", logo, "RIGHT", 8, 0)
    title:SetText("What's new in Porter?")
    title:SetTextColor(1, 1, 1, 1)

    local closeBtn = CreateFrame("Button", nil, headerBar)
    closeBtn:SetSize(24, 24)
    closeBtn:SetPoint("RIGHT", -4, 0)
    local closeTxt = closeBtn:CreateFontString(nil, "OVERLAY")
    closeTxt:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    closeTxt:SetAllPoints()
    closeTxt:SetJustifyH("CENTER")
    closeTxt:SetJustifyV("MIDDLE")
    closeTxt:SetText("X")
    closeTxt:SetTextColor(1, 1, 1, 1)
    closeBtn:SetScript("OnEnter", function() closeTxt:SetTextColor(1, 0.2, 0.2, 1) end)
    closeBtn:SetScript("OnLeave", function() closeTxt:SetTextColor(1, 1, 1, 1) end)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- Scrollable content area (custom thin scrollbar)
    local scrollFrame = CreateFrame("ScrollFrame", nil, f)
    scrollFrame:SetPoint("TOPLEFT", 10, -(HEADER_BAR_HEIGHT + 4))
    scrollFrame:SetPoint("BOTTOMRIGHT", -14, 10)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 1)
    scrollFrame:SetScrollChild(content)

    -- Thin scrollbar track
    local track = CreateFrame("Frame", nil, scrollFrame)
    track:SetWidth(4)
    track:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 0, 0)
    track:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 0)
    local trackBg = track:CreateTexture(nil, "BACKGROUND")
    trackBg:SetAllPoints()
    trackBg:SetColorTexture(0.2, 0.2, 0.2, 0.5)

    -- Thumb
    local thumb = CreateFrame("Frame", nil, track)
    thumb:SetWidth(4)
    thumb:SetPoint("TOPLEFT", track, "TOPLEFT", 0, 0)
    thumb:SetHeight(40)
    thumb:EnableMouse(true)
    local thumbTex = thumb:CreateTexture(nil, "ARTWORK")
    thumbTex:SetAllPoints()
    thumbTex:SetColorTexture(0.6, 0.3, 0.9, 0.8)

    -- Thumb hover effect
    thumb:SetScript("OnEnter", function() thumbTex:SetColorTexture(0.7, 0.4, 1, 1) end)
    thumb:SetScript("OnLeave", function()
        if not thumb.dragging then thumbTex:SetColorTexture(0.6, 0.3, 0.9, 0.8) end
    end)

    -- Update thumb size and visibility based on content
    local function UpdateScrollbar()
        local scrollRange = scrollFrame:GetVerticalScrollRange()
        if scrollRange <= 0 then
            track:Hide()
            return
        end
        track:Show()
        local trackHeight = track:GetHeight()
        local visibleRatio = scrollFrame:GetHeight() / (scrollFrame:GetHeight() + scrollRange)
        local thumbHeight = math.max(20, trackHeight * visibleRatio)
        thumb:SetHeight(thumbHeight)

        local scrollPos = scrollFrame:GetVerticalScroll()
        local thumbRange = trackHeight - thumbHeight
        local thumbOffset = (scrollPos / scrollRange) * thumbRange
        thumb:ClearAllPoints()
        thumb:SetPoint("TOPLEFT", track, "TOPLEFT", 0, -thumbOffset)
    end

    scrollFrame:SetScript("OnScrollRangeChanged", function() UpdateScrollbar() end)
    scrollFrame:SetScript("OnVerticalScroll", function() UpdateScrollbar() end)

    -- Mouse wheel scrolling
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local current = self:GetVerticalScroll()
        local range = self:GetVerticalScrollRange()
        local newScroll = math.max(0, math.min(range, current - delta * 40))
        self:SetVerticalScroll(newScroll)
    end)

    -- Thumb dragging
    thumb:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            self.dragging = true
            self.dragStartY = select(2, GetCursorPosition()) / UIParent:GetEffectiveScale()
            self.dragStartScroll = scrollFrame:GetVerticalScroll()
        end
    end)
    thumb:SetScript("OnMouseUp", function(self)
        self.dragging = false
        if not self:IsMouseOver() then
            thumbTex:SetColorTexture(0.6, 0.3, 0.9, 0.8)
        end
    end)
    thumb:SetScript("OnUpdate", function(self)
        if not self.dragging then return end
        local cursorY = select(2, GetCursorPosition()) / UIParent:GetEffectiveScale()
        local deltaY = self.dragStartY - cursorY
        local trackHeight = track:GetHeight()
        local thumbHeight = self:GetHeight()
        local thumbRange = trackHeight - thumbHeight
        if thumbRange <= 0 then return end
        local scrollRange = scrollFrame:GetVerticalScrollRange()
        local newScroll = self.dragStartScroll + (deltaY / thumbRange) * scrollRange
        newScroll = math.max(0, math.min(scrollRange, newScroll))
        scrollFrame:SetVerticalScroll(newScroll)
    end)

    -- Build content with separate FontStrings for version headers and notes
    local yOff = 0
    for i, entry in ipairs(entries) do
        if i > 1 then yOff = yOff - 12 end  -- space between versions

        -- Version header (larger font)
        local vHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        vHeader:SetPoint("TOPLEFT", 4, yOff)
        vHeader:SetText("v" .. entry.version)
        vHeader:SetTextColor(0.6, 0.4, 1, 1)  -- Porter purple
        yOff = yOff - vHeader:GetStringHeight() - 6

        -- Bullet points
        local notesText = ""
        for j, note in ipairs(entry.notes) do
            notesText = notesText .. "- " .. note
            if j < #entry.notes then notesText = notesText .. "\n" end
        end

        local notes = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        notes:SetPoint("TOPLEFT", 8, yOff)
        notes:SetPoint("RIGHT", content, "RIGHT", -4, 0)
        notes:SetJustifyH("LEFT")
        notes:SetJustifyV("TOP")
        notes:SetTextColor(0.9, 0.9, 0.9, 1)
        notes:SetSpacing(2)
        notes:SetText(notesText)
        yOff = yOff - notes:GetStringHeight()
    end

    content:SetHeight(math.abs(yOff) + 20)

    f:SetScript("OnShow", function() PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN) end)
    f:SetScript("OnHide", function() PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE) end)

    self.changelogFrame = f
end

function Porter:CheckChangelog()
    local currentVersion = C_AddOns.GetAddOnMetadata("Porter", "Version")
    if not currentVersion then return end

    local lastSeen = self.db.settings.lastSeenVersion
    if lastSeen ~= currentVersion then
        self.db.settings.lastSeenVersion = currentVersion
        self:ShowChangelog(lastSeen)
    end
end

-----------------------------------------------------------------------
-- TOGGLE
-----------------------------------------------------------------------
function Porter:Toggle()
    if InCombatLockdown() then
        print("|cff9966ffPorter:|r Cannot open during combat.")
        return
    end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self:BuildLayout()
        self:UpdateAllCooldowns()
        self:UpdateEquipStatus()
        self:HighlightKeystone()
        self.frame:Show()
    end
end
