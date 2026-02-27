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
Porter.searchText = ""
-- Porter.expandedRegions removed — regions are always expanded in zone view
Porter.activeViewMode = nil  -- tracks current view during search auto-switching

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
    f:SetFrameStrata("HIGH")
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

    f:SetScript("OnShow", function()
        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
        Porter.searchText = ""
        if Porter.searchBox then Porter.searchBox:SetText("") end
    end)
    f:SetScript("OnHide", function()
        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
        Porter.searchText = ""
        if Porter.searchBox then Porter.searchBox:SetText("") end
    end)
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

    -- View mode toggle tabs (Type / Zone) — order based on defaultView setting
    local TAB_W, TAB_H = 42, 22
    local viewToggle = CreateFrame("Frame", nil, headerBar, "BackdropTemplate")
    viewToggle:SetSize(TAB_W * 2, TAB_H)
    viewToggle:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        tile     = false,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    viewToggle:SetBackdropColor(0.08, 0.08, 0.08, 1)
    viewToggle:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.6)

    -- Create two tab buttons inside the toggle frame
    local tabButtons = {}
    for i = 1, 2 do
        local tab = CreateFrame("Button", nil, viewToggle, "BackdropTemplate")
        tab:SetSize(TAB_W, TAB_H)
        tab:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
        })
        local tabText = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        tabText:SetAllPoints()
        tabText:SetJustifyH("CENTER")
        tabText:SetJustifyV("MIDDLE")
        tab.text = tabText
        tab.mode = nil  -- set dynamically
        tabButtons[i] = tab
    end
    tabButtons[1]:SetPoint("LEFT", 1, 0)
    tabButtons[2]:SetPoint("RIGHT", -1, 0)

    local function UpdateViewToggleTabs()
        local defaultView = (Porter.db and Porter.db.settings.defaultView) or "category"
        local currentMode = Porter.activeViewMode or (Porter.db and Porter.db.settings.viewMode) or "category"
        -- Tab order: default view first
        if defaultView == "zone" then
            tabButtons[1].mode = "zone"
            tabButtons[1].text:SetText("Zone")
            tabButtons[2].mode = "category"
            tabButtons[2].text:SetText("Type")
        else
            tabButtons[1].mode = "category"
            tabButtons[1].text:SetText("Type")
            tabButtons[2].mode = "zone"
            tabButtons[2].text:SetText("Zone")
        end
        -- Highlight the active tab: purple background, white text
        for _, tab in ipairs(tabButtons) do
            if tab.mode == currentMode then
                tab:SetBackdropColor(0.6, 0.3, 0.9, 1)
                tab.text:SetTextColor(1, 1, 1, 1)
            else
                tab:SetBackdropColor(0.08, 0.08, 0.08, 0)
                tab.text:SetTextColor(0.5, 0.5, 0.5, 1)
            end
        end
    end
    UpdateViewToggleTabs()

    for _, tab in ipairs(tabButtons) do
        tab:SetScript("OnEnter", function(self)
            local currentMode = Porter.activeViewMode or (Porter.db and Porter.db.settings.viewMode) or "category"
            if self.mode ~= currentMode then
                self.text:SetTextColor(0.8, 0.8, 0.8, 1)
            end
        end)
        tab:SetScript("OnLeave", function()
            UpdateViewToggleTabs()
        end)
        tab:SetScript("OnClick", function(self)
            if InCombatLockdown() then return end
            local settings = Porter.db.settings
            if settings.viewMode ~= self.mode then
                settings.viewMode = self.mode
                Porter.activeViewMode = nil
                Porter._userPickedView = true
                UpdateViewToggleTabs()
                Porter:RefreshMainFrame()
            end
        end)
    end

    self.viewToggle = viewToggle
    self.updateViewToggleText = UpdateViewToggleTabs

    -- Search box
    local searchBox = CreateFrame("EditBox", nil, headerBar, "BackdropTemplate")
    searchBox:SetSize(120, 22)
    searchBox:SetPoint("RIGHT", closeBtn, "LEFT", -8, 0)
    viewToggle:SetPoint("CENTER", headerBar, "CENTER", 0, 0)
    searchBox:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        tile     = false,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    searchBox:SetBackdropColor(0.08, 0.08, 0.08, 1)
    searchBox:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.6)
    searchBox:SetFontObject(GameFontNormalSmall)
    searchBox:SetTextColor(1, 1, 1, 1)
    searchBox:SetTextInsets(6, 6, 0, 0)
    searchBox:SetAutoFocus(false)
    searchBox:SetMaxLetters(30)

    local placeholder = searchBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    placeholder:SetPoint("LEFT", 6, 0)
    placeholder:SetText("Search...")
    placeholder:SetTextColor(0.4, 0.4, 0.4, 1)

    searchBox:SetScript("OnTextChanged", function(self)
        local text = self:GetText()
        placeholder:SetShown(text == "")
        Porter.searchText = text
        Porter:ApplySearch()
    end)
    searchBox:SetScript("OnEscapePressed", function(self)
        self:SetText("")
        self:ClearFocus()
    end)
    searchBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
    self.searchBox = searchBox

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
        if type(entry.raceReq) == "table" then
            local found = false
            for _, r in ipairs(entry.raceReq) do
                if raceFile == r then found = true; break end
            end
            if not found then return false end
        elseif raceFile ~= entry.raceReq then
            return false
        end
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
-- CHECK IF ITEM IS IN BANK ONLY (not in bags or equipped)
-- Called after IsAvailable, so we know the player owns the item.
-----------------------------------------------------------------------
function Porter:IsInBankOnly(entry)
    if entry.type ~= "item" then return false end
    if C_Item.GetItemCount(entry.id, false) > 0 then return false end
    if self:IsEquipped(entry.id) then return false end
    return true
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

    -- Bank-only items: desaturate icon and add "Bank" label
    local inBank = self:IsInBankOnly(entry)
    if inBank then
        icon:SetDesaturated(true)
        icon:SetAlpha(0.5)
        local bankText = btn:CreateFontString(nil, "OVERLAY")
        bankText:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
        bankText:SetPoint("BOTTOM", 0, 2)
        bankText:SetText("Bank")
        bankText:SetTextColor(1, 0.4, 0.4, 1)
        btn.bankText = bankText
    end
    btn.inBank = inBank

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
        if inBank then
            GameTooltip:AddLine("Item is in your bank", 1, 0.4, 0.4)
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
    btn.flyoutEntries = flyoutEntries
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
        if btn.inBank then
            label:SetTextColor(0.5, 0.5, 0.5, 1)
        else
            label:SetTextColor(1, 1, 1, 1)
        end

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
            if btn.inBank then
                GameTooltip:AddLine("Item is in your bank", 1, 0.4, 0.4)
            end
            GameTooltip:Show()
        end)
        labelBtn:SetScript("OnLeave", function()
            if btn.inBank then
                label:SetTextColor(0.5, 0.5, 0.5, 1)
            else
                label:SetTextColor(1, 1, 1, 1)
            end
            GameTooltip:Hide()
        end)

        labelBtn.entry = entry
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
    local specificChoice = self.db.settings.hearthstoneMode == "Specific" and self.db.settings.hearthstoneChoice
    for _, entry in ipairs(entries) do
        if entry.cosmetic and not showCosmetic then
            -- skip cosmetic hearthstones when setting is off
        elseif entry.cosmetic and specificChoice and entry.id == specificChoice then
            -- skip the chosen cosmetic hearthstone (already shown as the main Hearthstone button)
        elseif self:IsAvailable(entry) then
            tinsert(available, entry)
        end
    end
    return available
end

-----------------------------------------------------------------------
-- HELPER: Check if an entry matches the current search text
-----------------------------------------------------------------------
function Porter:IsSearchMatch(entry)
    if self.searchText == "" then return true end
    local query = self.searchText:lower()
    if entry.name and entry.name:lower():find(query, 1, true) then return true end
    local displayName = self:GetDisplayName(entry)
    if displayName and displayName:lower():find(query, 1, true) then return true end
    if entry.zone and entry.zone:lower():find(query, 1, true) then return true end
    if entry.region and entry.region:lower():find(query, 1, true) then return true end
    return false
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
    local activeSeason = self.db and self.db.settings.currentSeason or "tww"
    local available = {}
    for _, entry in ipairs(entries) do
        if entry.season == activeSeason and self:IsAvailable(entry) then
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
            local activeSeason = self.db and self.db.settings.currentSeason or "tww"
            for _, entry in ipairs(entries) do
                -- Skip entries that belong to the active season (they show in Current tab)
                local isActiveSeason = entry.season and entry.season == activeSeason
                if entry.expansion == expacName and not isActiveSeason and self:IsAvailable(entry) then
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

    -- Dispatch to zone view if active
    local currentViewMode = self.activeViewMode or (self.db and self.db.settings.viewMode) or "category"
    if currentViewMode == "zone" then
        return self:BuildZoneLayout()
    end

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
-- ZONE VIEW LAYOUT
-- Groups all available teleports by region → zone, rendered as list rows
-- across multiple columns with collapsible region headers.
-----------------------------------------------------------------------
function Porter:BuildZoneLayout()
    if not self.frame then return end

    local contentTop = -(HEADER_BAR_HEIGHT + 4)
    local ZONE_HEADER_HEIGHT = 16
    local ZONE_INDENT = 8

    -- Gather all available entries across all categories
    -- Skip cosmetic hearthstones and deduplicate by spell ID (e.g. Tazavesh wings share one teleport)
    local allEntries = {}
    local seenSpellIDs = {}
    for _, category in ipairs(self.Categories) do
        local available = self:GetAvailable(category)
        for _, entry in ipairs(available) do
            if entry.region and not entry.cosmetic then
                local key = (entry.type == "spell") and entry.id or nil
                if not key or not seenSpellIDs[key] then
                    tinsert(allEntries, entry)
                    if key then seenSpellIDs[key] = true end
                end
            end
        end
    end

    -- Group by region → zone
    local regionData = {}  -- regionName → { zones = { zoneName → {entries} }, zoneOrder = {} }
    for _, entry in ipairs(allEntries) do
        local r = entry.region
        local z = entry.zone or "Unknown"
        if not regionData[r] then
            regionData[r] = { zones = {}, zoneOrder = {} }
        end
        if not regionData[r].zones[z] then
            regionData[r].zones[z] = {}
            tinsert(regionData[r].zoneOrder, z)
        end
        tinsert(regionData[r].zones[z], entry)
    end

    -- Sort zones alphabetically within each region
    for _, rData in pairs(regionData) do
        table.sort(rData.zoneOrder)
    end

    -- Determine region display order
    local orderedRegions = {}
    local regionOrder = self.RegionOrder
    if self.db.settings.zoneOrder == "alpha" then
        -- Keep Hearthstone first and Other last, alphabetise the rest
        local middle = {}
        for rName in pairs(regionData) do
            if rName ~= "Hearthstone" and rName ~= "Other" then
                tinsert(middle, rName)
            end
        end
        table.sort(middle)
        if regionData["Hearthstone"] then tinsert(orderedRegions, "Hearthstone") end
        for _, r in ipairs(middle) do tinsert(orderedRegions, r) end
        if regionData["Other"] then tinsert(orderedRegions, "Other") end
    else
        for _, r in ipairs(regionOrder) do
            if regionData[r] then
                tinsert(orderedRegions, r)
            end
        end
    end

    -- Estimate height per region for column balancing
    local regionHeights = {}
    for _, rName in ipairs(orderedRegions) do
        local rData = regionData[rName]
        local h = EXPAC_BTN_HEIGHT  -- region header
        for _, zName in ipairs(rData.zoneOrder) do
            h = h + ZONE_HEADER_HEIGHT
            h = h + #rData.zones[zName] * (LIST_ROW_HEIGHT + 4)
            h = h + 6  -- zone group margin
        end
        regionHeights[rName] = h
    end

    -- Determine column count (3-7) so no column exceeds ~10 entries worth of height
    local MAX_COL_HEIGHT = 10 * (LIST_ROW_HEIGHT + 4) + 4 * EXPAC_BTN_HEIGHT + 4 * CATEGORY_PADDING
    local totalHeight = 0
    for _, rName in ipairs(orderedRegions) do
        totalHeight = totalHeight + regionHeights[rName] + CATEGORY_PADDING
    end
    local NUM_ZONE_COLS = math.max(3, math.min(7, math.ceil(totalHeight / MAX_COL_HEIGHT)))
    local targetColHeight = totalHeight / NUM_ZONE_COLS

    -- Distribute regions across columns sequentially (vertical reading order)
    local colRegions = {}
    local colHeights = {}
    for i = 1, NUM_ZONE_COLS do
        colRegions[i] = {}
        colHeights[i] = 0
    end
    local curCol = 1
    for _, rName in ipairs(orderedRegions) do
        tinsert(colRegions[curCol], rName)
        colHeights[curCol] = colHeights[curCol] + regionHeights[rName] + CATEGORY_PADDING
        -- Move to next column if we've exceeded the target and there are more columns
        if colHeights[curCol] >= targetColHeight and curCol < NUM_ZONE_COLS then
            curCol = curCol + 1
        end
    end

    -- Remove empty trailing columns
    local numColumns = NUM_ZONE_COLS
    while numColumns > 1 and #colRegions[numColumns] == 0 do
        numColumns = numColumns - 1
    end

    local buttonIndex = 0
    local columnBottoms = {}

    for col = 1, numColumns do
        local colX = FRAME_PADDING + (col - 1) * (COLUMN_WIDTH + COLUMN_SPACING)
        local colY = contentTop

        for _, rName in ipairs(colRegions[col]) do
            local rData = regionData[rName]

            colY = colY - CATEGORY_PADDING

            -- Region header (static, not collapsible)
            local regionHeader = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            regionHeader:SetPoint("TOPLEFT", self.frame, "TOPLEFT", colX, colY)
            regionHeader:SetText(rName)
            regionHeader:SetTextColor(0.4, 0.55, 0.85, 1)
            regionHeader.regionName = rName
            tinsert(self.headers, regionHeader)
            colY = colY - EXPAC_BTN_HEIGHT

            -- Render zone contents
            for _, zName in ipairs(rData.zoneOrder) do
                local zEntries = rData.zones[zName]

                -- Zone subheader
                local zoneHeader = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                zoneHeader:SetPoint("TOPLEFT", self.frame, "TOPLEFT", colX + ZONE_INDENT, colY)
                zoneHeader:SetText(zName)
                zoneHeader:SetTextColor(0.6, 0.3, 0.9, 1)
                zoneHeader.regionName = rName
                zoneHeader.zoneName = zName
                tinsert(self.headers, zoneHeader)
                colY = colY - ZONE_HEADER_HEIGHT

                -- Entries as list rows (icon + name)
                colY, buttonIndex = self:LayoutList(zEntries, colX + ZONE_INDENT, colY, buttonIndex)
                colY = colY - 6  -- margin under each zone group
            end
        end

        tinsert(columnBottoms, colY)
    end

    -- Resize frame
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
            if btn.inBank then
                btn.equipStatus:SetText("")
            else
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
        if self.searchText and self.searchText ~= "" then
            self:ApplySearch()
        else
            self:BuildLayout()
            self:UpdateAllCooldowns()
            self:UpdateEquipStatus()
            self:HighlightKeystone()
        end
    end
end

function Porter:ApplySearch()
    if InCombatLockdown() then return end
    if not self.frame or not self.frame:IsShown() then return end

    local hasSearch = self.searchText ~= ""

    if hasSearch then
        -- Determine whether search matches are better served by zone or category view
        local query = self.searchText:lower()
        local nameMatches = 0
        local zoneRegionMatches = 0

        -- Count matches by type across all available entries
        for _, category in ipairs(self.Categories) do
            local entries = self.TeleportData[category]
            if entries then
                for _, entry in ipairs(entries) do
                    if self:IsAvailable(entry) then
                        local nameHit = false
                        if entry.name and entry.name:lower():find(query, 1, true) then nameHit = true end
                        if not nameHit then
                            local displayName = self:GetDisplayName(entry)
                            if displayName and displayName:lower():find(query, 1, true) then nameHit = true end
                        end
                        local geoHit = false
                        if entry.zone and entry.zone:lower():find(query, 1, true) then geoHit = true end
                        if entry.region and entry.region:lower():find(query, 1, true) then geoHit = true end

                        if nameHit then nameMatches = nameMatches + 1 end
                        if geoHit and not nameHit then zoneRegionMatches = zoneRegionMatches + 1 end
                    end
                end
            end
        end

        -- Also check if query matches a category name (favours category view)
        local categoryNameMatch = false
        for _, cat in ipairs(self.Categories) do
            if cat:lower():find(query, 1, true) then
                categoryNameMatch = true
                break
            end
        end

        -- Auto-switch view mode based on match distribution (skip if user manually picked a tab)
        if not self._userPickedView then
            local settingsMode = self.db.settings.viewMode
            if zoneRegionMatches > 0 and nameMatches == 0 and not categoryNameMatch then
                self.activeViewMode = "zone"
            elseif categoryNameMatch and zoneRegionMatches == 0 then
                self.activeViewMode = "category"
            else
                self.activeViewMode = nil  -- use settings default
            end
        end

        -- In category view, auto-switch dungeon/raid tabs
        local activeView = self.activeViewMode or self.db.settings.viewMode
        if activeView == "category" then
            for _, category in ipairs({"Dungeons", "Raids"}) do
                local entries = self.TeleportData[category]
                if entries then
                    local currentMatches, legacyMatches = false, false
                    local legacyExpansion = nil
                    local activeSeason = self.db and self.db.settings.currentSeason or "tww"
                    for _, entry in ipairs(entries) do
                        if self:IsAvailable(entry) and self:IsSearchMatch(entry) then
                            if entry.season == activeSeason then
                                currentMatches = true
                            elseif entry.expansion then
                                legacyMatches = true
                                legacyExpansion = legacyExpansion or entry.expansion
                            end
                        end
                    end

                    local activeTab = self.activeTab[category] or "Current"
                    if activeTab == "Current" and not currentMatches and legacyMatches then
                        self.activeTab[category] = "Legacy"
                        self.activeExpansion[category] = legacyExpansion
                    elseif activeTab == "Legacy" and not legacyMatches and currentMatches then
                        self.activeTab[category] = "Current"
                        self.activeExpansion[category] = nil
                    elseif activeTab == "Legacy" and legacyMatches and legacyExpansion then
                        self.activeExpansion[category] = legacyExpansion
                    end
                end
            end
        end
    else
        -- Search cleared: revert to settings default
        self.activeViewMode = nil
        self._userPickedView = nil
    end

    -- Update toggle button text to reflect active view
    if self.updateViewToggleText then self.updateViewToggleText() end

    -- Rebuild layout (picks up tab/view changes)
    self:BuildLayout()
    self:UpdateAllCooldowns()
    self:UpdateEquipStatus()
    self:HighlightKeystone()

    -- Apply visual dimming to non-matching entries
    if hasSearch then
        for _, btn in ipairs(self.buttons) do
            if btn.entry then
                local matches = self:IsSearchMatch(btn.entry)
                -- For flyout triggers, match if ANY flyout entry matches
                if not matches and btn.flyoutEntries then
                    for _, fEntry in ipairs(btn.flyoutEntries) do
                        if self:IsSearchMatch(fEntry) then
                            matches = true
                            break
                        end
                    end
                end
                if matches then
                    btn:SetAlpha(1)
                    if btn.nameLabel then
                        btn.nameLabel:SetTextColor(1, 1, 1, 1)
                    end
                else
                    btn:SetAlpha(0.15)
                    if btn.nameLabel then
                        btn.nameLabel:SetTextColor(0.35, 0.35, 0.35, 0.5)
                    end
                end
            end
        end

        -- Dim name label buttons (list view clickable area) for non-matches
        for _, labelBtn in ipairs(self.nameLabels) do
            if labelBtn.entry then
                labelBtn:SetAlpha(self:IsSearchMatch(labelBtn.entry) and 1 or 0.15)
            end
        end

        -- Build set of matching regions and zones for header dimming
        local matchingRegions = {}
        local matchingZones = {}  -- key = "region|zone"
        for _, category in ipairs(self.Categories) do
            local entries = self.TeleportData[category]
            if entries then
                for _, entry in ipairs(entries) do
                    if entry.region and self:IsAvailable(entry) and self:IsSearchMatch(entry) then
                        matchingRegions[entry.region] = true
                        if entry.zone then
                            matchingZones[entry.region .. "|" .. entry.zone] = true
                        end
                    end
                end
            end
        end

        -- Dim zone/region headers (font strings) — grey out non-matching ones
        local currentViewMode = self.activeViewMode or self.db.settings.viewMode
        if currentViewMode == "zone" then
            for _, header in ipairs(self.headers) do
                if header.regionName then
                    if header.zoneName then
                        -- Zone subheader: check if this specific zone has matches
                        local key = header.regionName .. "|" .. header.zoneName
                        if matchingZones[key] then
                            header:SetTextColor(0.6, 0.3, 0.9, 1)
                        else
                            header:SetTextColor(0.3, 0.3, 0.3, 0.5)
                        end
                    else
                        -- Region header: check if region has any matches
                        if matchingRegions[header.regionName] then
                            header:SetTextColor(0.4, 0.55, 0.85, 1)
                        else
                            header:SetTextColor(0.2, 0.25, 0.35, 0.5)
                        end
                    end
                end
            end
        end

        -- Dim expansion/region buttons that have no matches
        for _, expBtn in ipairs(self.expacButtons) do
            expBtn:SetAlpha(0.15)
        end
        -- Re-brighten those that contain matches
        if currentViewMode == "zone" then
            for _, expBtn in ipairs(self.expacButtons) do
                local children = { expBtn:GetRegions() }
                for _, rgn in ipairs(children) do
                    if rgn.GetText then
                        local text = rgn:GetText() or ""
                        for rName in pairs(matchingRegions) do
                            if text:find(rName, 1, true) then
                                expBtn:SetAlpha(1)
                                break
                            end
                        end
                    end
                end
            end
        else
            -- In category view, brighten expansion buttons containing matches
            for _, category in ipairs({"Dungeons", "Raids"}) do
                local entries = self.TeleportData[category]
                if entries then
                    local matchesByExpac = {}
                    for _, entry in ipairs(entries) do
                        if entry.expansion and self:IsAvailable(entry) and self:IsSearchMatch(entry) then
                            matchesByExpac[entry.expansion] = true
                        end
                    end
                    for _, expBtn in ipairs(self.expacButtons) do
                        local children = { expBtn:GetRegions() }
                        for _, rgn in ipairs(children) do
                            if rgn.GetText then
                                local text = rgn:GetText() or ""
                                for expac in pairs(matchesByExpac) do
                                    if text:find(expac, 1, true) then
                                        expBtn:SetAlpha(1)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Porter:RefreshSettingsPanel()
    local w = self.settingsWidgets
    if not w then return end

    -- Cosmetic hearthstones checkbox
    if w.cosmeticCB then
        w.cosmeticCB:SetChecked(self.db.settings.showCosmeticHearthstones)
    end

    -- Mode radio buttons
    if w.modeButtons and w.modes then
        for i, rb in ipairs(w.modeButtons) do
            rb:SetChecked(self.db.settings.hearthstoneMode == w.modes[i])
        end
    end

    -- Specific choice button visibility and display
    if w.choiceBtn then
        if self.db.settings.hearthstoneMode == "Specific" then
            w.choiceBtn:Show()
        else
            w.choiceBtn:Hide()
        end
    end
    if w.updateChoiceDisplay then
        w.updateChoiceDisplay()
    end

    -- Category checkboxes
    if w.categoryCBs then
        for category, catCB in pairs(w.categoryCBs) do
            catCB:SetChecked(self.db.settings.categoryVisibility[category] ~= false)
        end
    end

    -- Minimap checkbox
    if w.minimapCB then
        w.minimapCB:SetChecked(self.db.minimap.hide)
    end

    -- Default view radio buttons
    if w.defaultViewButtons and w.defaultViewModes then
        for i, rb in ipairs(w.defaultViewButtons) do
            rb:SetChecked(self.db.settings.defaultView == w.defaultViewModes[i])
        end
    end

    -- Zone order radio buttons
    if w.zoneOrderButtons and w.zoneOrderModes then
        for i, rb in ipairs(w.zoneOrderButtons) do
            rb:SetChecked(self.db.settings.zoneOrder == w.zoneOrderModes[i])
        end
    end

    -- Current season radio buttons
    if w.seasonButtons and w.seasonModes then
        for i, rb in ipairs(w.seasonButtons) do
            rb:SetChecked(self.db.settings.currentSeason == w.seasonModes[i])
        end
    end

    -- Global profile checkbox and copy-from visibility
    if w.globalCB then
        w.globalCB:SetChecked(self:IsUsingGlobalProfile())
    end
    if w.profDesc then
        if self:IsUsingGlobalProfile() then
            w.profDesc:SetText("Current: |cff9966ffGlobal|r")
        else
            w.profDesc:SetText("Current: |cff9966ff" .. self:GetProfileKey() .. "|r")
        end
    end
    if w.copyLabel and w.copyBtn then
        if self:IsUsingGlobalProfile() then
            w.copyLabel:Hide()
            w.copyBtn:Hide()
            if w.copyDropdown then w.copyDropdown:Hide() end
        else
            w.copyLabel:Show()
            w.copyBtn:Show()
        end
    end
end

function Porter:CreateSettingsPanel()
    if self.settingsCategory then return end

    local f = CreateFrame("Frame", "PorterSettingsFrame")
    self.settingsWidgets = {}  -- store references for RefreshSettingsPanel

    -- Scrollable content area (settings panel can be taller than the WoW options canvas)
    local scrollFrame = CreateFrame("ScrollFrame", nil, f)
    scrollFrame:SetPoint("TOPLEFT", 0, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", 0, 0)
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local current = self:GetVerticalScroll()
        local range = self:GetVerticalScrollRange()
        local newScroll = math.max(0, math.min(range, current - delta * 40))
        self:SetVerticalScroll(newScroll)
    end)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetWidth(f:GetWidth() or 600)
    scrollFrame:SetScrollChild(content)

    -- Update content width when the settings canvas resizes
    f:SetScript("OnSizeChanged", function(self, w, h)
        content:SetWidth(w)
        scrollFrame:SetWidth(w)
        scrollFrame:SetHeight(h)
    end)

    local yPos = -16

    -- Settings layout constants
    local SECTION_GAP = 40      -- space between sections
    local HEADER_GAP = 24       -- section header to first item
    local ITEM_GAP = 26         -- between checkboxes / radio buttons
    local LABEL_GAP = 20        -- descriptor label to its content
    local SUBGROUP_GAP = 10     -- between sub-groups within a section

    -----------------------------------------------------------------
    -- SECTION: Character Profile
    -----------------------------------------------------------------
    local profHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    profHeader:SetPoint("TOPLEFT", 12, yPos)
    profHeader:SetText("Character Profile")
    yPos = yPos - HEADER_GAP

    local profDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    profDesc:SetPoint("TOPLEFT", 14, yPos)
    if self:IsUsingGlobalProfile() then
        profDesc:SetText("Current: |cff9966ffGlobal|r")
    else
        profDesc:SetText("Current: |cff9966ff" .. self:GetProfileKey() .. "|r")
    end
    profDesc:SetTextColor(0.7, 0.7, 0.7, 1)
    self.settingsWidgets.profDesc = profDesc
    yPos = yPos - LABEL_GAP

    -- Global profile checkbox
    local globalCB = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    globalCB:SetPoint("TOPLEFT", 10, yPos)
    globalCB:SetChecked(self:IsUsingGlobalProfile())
    local globalLabel = globalCB:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    globalLabel:SetPoint("LEFT", globalCB, "RIGHT", 4, 0)
    globalLabel:SetText("Use global profile (shared across all characters)")
    globalLabel:SetTextColor(1, 1, 1, 1)
    globalCB:SetScript("OnClick", function(cb)
        Porter:SetUseGlobalProfile(cb:GetChecked())
        Porter:RefreshSettingsPanel()
        Porter:RefreshMainFrame()
    end)
    self.settingsWidgets.globalCB = globalCB
    yPos = yPos - SECTION_GAP

    -- "Copy from" label (hidden when using global profile)
    local copyLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    copyLabel:SetPoint("TOPLEFT", 14, yPos)
    copyLabel:SetText("Copy settings from another character:")
    copyLabel:SetTextColor(1, 1, 1, 1)
    yPos = yPos - LABEL_GAP

    -- Copy-from dropdown button
    local copyBtn = CreateFrame("Button", nil, content, "BackdropTemplate")
    copyBtn:SetSize(248, 28)
    copyBtn:SetPoint("TOPLEFT", 14, yPos)
    copyBtn:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        tile     = false,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    copyBtn:SetBackdropColor(0.15, 0.15, 0.15, 1)
    copyBtn:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)

    local copyBtnText = copyBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    copyBtnText:SetPoint("LEFT", 8, 0)
    copyBtnText:SetText("Select character...")
    copyBtnText:SetTextColor(1, 1, 1, 1)

    -- Dropdown for profile list
    local copyDropdown = CreateFrame("Frame", nil, content, "BackdropTemplate")
    copyDropdown:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        tile     = false,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    copyDropdown:SetBackdropColor(0.12, 0.12, 0.12, 1)
    copyDropdown:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
    copyDropdown:SetFrameStrata("TOOLTIP")
    copyDropdown:Hide()

    copyBtn:SetScript("OnClick", function()
        if copyDropdown:IsShown() then
            copyDropdown:Hide()
            return
        end

        -- Clear old rows
        for _, child in ipairs({ copyDropdown:GetChildren() }) do
            child:Hide()
            child:SetParent(nil)
        end

        local profiles = Porter:GetProfileList()
        local myKey = Porter:GetProfileKey()
        local rowHeight = 24

        -- Filter out current character
        local others = {}
        for _, key in ipairs(profiles) do
            if key ~= myKey then
                tinsert(others, key)
            end
        end

        if #others == 0 then
            copyBtnText:SetText("No other characters found")
            return
        end

        copyDropdown:SetSize(248, #others * rowHeight + 4)
        copyDropdown:SetPoint("TOPLEFT", copyBtn, "BOTTOMLEFT", 0, -2)

        for i, key in ipairs(others) do
            local row = CreateFrame("Button", nil, copyDropdown)
            row:SetSize(244, rowHeight)
            row:SetPoint("TOPLEFT", 2, -(2 + (i - 1) * rowHeight))

            local rName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            rName:SetPoint("LEFT", 8, 0)
            rName:SetText(key)
            rName:SetTextColor(1, 1, 1, 1)

            local hl = row:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(1, 1, 1, 0.05)

            row:SetScript("OnClick", function()
                Porter:CopyProfileFrom(key)
                Porter:RefreshSettingsPanel()
                Porter:RefreshMainFrame()
                copyDropdown:Hide()
                copyBtnText:SetText("Copied from " .. key)
            end)
        end

        copyDropdown:Show()
    end)

    -- Store copy-from widgets for visibility toggling
    self.settingsWidgets.copyLabel = copyLabel
    self.settingsWidgets.copyBtn = copyBtn
    self.settingsWidgets.copyDropdown = copyDropdown

    -- Hide copy-from controls when using global profile
    if self:IsUsingGlobalProfile() then
        copyLabel:Hide()
        copyBtn:Hide()
        copyDropdown:Hide()
    end

    -- Hide copy dropdown when settings panel hides
    f:HookScript("OnHide", function()
        copyDropdown:Hide()
    end)

    -----------------------------------------------------------------
    -- SECTION: Hearthstone
    -----------------------------------------------------------------
    yPos = yPos - SECTION_GAP

    local hsHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    hsHeader:SetPoint("TOPLEFT", 12, yPos)
    hsHeader:SetText("Hearthstone")
    yPos = yPos - HEADER_GAP

    -- Cosmetic hearthstones checkbox
    local cb = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
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
    self.settingsWidgets.cosmeticCB = cb
    yPos = yPos - ITEM_GAP - SUBGROUP_GAP

    -- Hearthstone Mode label
    local modeLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    modeLabel:SetPoint("TOPLEFT", 14, yPos)
    modeLabel:SetText("Hearthstone mode:")
    modeLabel:SetTextColor(0.7, 0.7, 0.7, 1)
    yPos = yPos - LABEL_GAP

    -- Mode radio buttons
    local modes = { "Normal", "Random", "Specific" }
    local modeButtons = {}
    local choiceBtn -- forward ref for the specific choice button

    for i, mode in ipairs(modes) do
        local rb = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
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

        yPos = yPos - ITEM_GAP
    end
    self.settingsWidgets.modeButtons = modeButtons
    self.settingsWidgets.modes = modes

    -- Specific hearthstone chooser button
    choiceBtn = CreateFrame("Button", nil, content, "BackdropTemplate")
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
        if choiceID then
            local _, name, toyIcon = C_ToyBox.GetToyInfo(choiceID)
            -- Toy info may not be cached yet at login; fall back to item API
            local icon = toyIcon or C_Item.GetItemIconByID(choiceID) or 134400
            if not name or name == "" then
                name = C_Item.GetItemNameByID(choiceID)
            end
            choiceIcon:SetTexture(icon)
            choiceText:SetText(name or "Loading...")
            -- If name wasn't available yet, retry once item data arrives
            if not name or name == "" then
                C_Item.RequestLoadItemDataByID(choiceID)
                C_Timer.After(1, function()
                    if Porter.settingsWidgets and Porter.settingsWidgets.updateChoiceDisplay then
                        Porter.settingsWidgets.updateChoiceDisplay()
                    end
                end)
            end
        else
            choiceIcon:SetTexture(134400)
            choiceText:SetText("Click to choose...")
        end
    end
    UpdateChoiceDisplay()

    self.settingsWidgets.choiceBtn = choiceBtn
    self.settingsWidgets.updateChoiceDisplay = UpdateChoiceDisplay

    if self.db.settings.hearthstoneMode ~= "Specific" then
        choiceBtn:Hide()
    end

    -- Dropdown list for picking a specific cosmetic hearthstone
    local dropdown = CreateFrame("Frame", nil, content, "BackdropTemplate")
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
        local iconSize = 18
        local padding = 4 + iconSize + 6 + 8  -- left + icon + gap + right padding

        -- Measure the widest name to size the dropdown
        local maxTextWidth = 0
        for _, entry in ipairs(owned) do
            local tempFS = dropdown:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            tempFS:SetText(entry.name)
            local w = tempFS:GetStringWidth()
            if w > maxTextWidth then maxTextWidth = w end
            tempFS:Hide()
        end
        local ddWidth = math.max(248, maxTextWidth + padding + 4)

        dropdown:SetSize(ddWidth, #owned * rowHeight + 4)
        dropdown:SetPoint("TOPLEFT", choiceBtn, "BOTTOMLEFT", 0, -2)

        for i, entry in ipairs(owned) do
            local row = CreateFrame("Button", nil, dropdown)
            row:SetSize(ddWidth - 4, rowHeight)
            row:SetPoint("TOPLEFT", 2, -(2 + (i - 1) * rowHeight))

            local rIcon = row:CreateTexture(nil, "ARTWORK")
            rIcon:SetSize(iconSize, iconSize)
            rIcon:SetPoint("LEFT", 4, 0)
            rIcon:SetTexture(Porter:GetIcon(entry))

            local rName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            rName:SetPoint("LEFT", rIcon, "RIGHT", 6, 0)
            rName:SetPoint("RIGHT", row, "RIGHT", -4, 0)
            rName:SetJustifyH("LEFT")
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

    -- Account for choice button height (28px) only when visible
    if self.db.settings.hearthstoneMode == "Specific" then
        yPos = yPos - 28
    end

    -- Hide dropdown when settings panel hides
    f:SetScript("OnHide", function()
        if Porter.hearthstoneDropdown then
            Porter.hearthstoneDropdown:Hide()
        end
    end)

    -----------------------------------------------------------------
    -- SECTION: Portal Types
    -----------------------------------------------------------------
    yPos = yPos - SECTION_GAP

    local catHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    catHeader:SetPoint("TOPLEFT", 12, yPos)
    catHeader:SetText("Portal Types")
    yPos = yPos - LABEL_GAP

    local catDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    catDesc:SetPoint("TOPLEFT", 14, yPos)
    catDesc:SetText("Use the below to control what types of portals you want to see in Porter")
    catDesc:SetTextColor(0.7, 0.7, 0.7, 1)
    yPos = yPos - HEADER_GAP

    self.settingsWidgets.categoryCBs = {}
    for _, category in ipairs(self.Categories) do
        local catCB = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
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

        self.settingsWidgets.categoryCBs[category] = catCB
        yPos = yPos - ITEM_GAP
    end

    -----------------------------------------------------------------
    -- SECTION: Minimap
    -----------------------------------------------------------------
    yPos = yPos - SECTION_GAP

    local mmHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    mmHeader:SetPoint("TOPLEFT", 12, yPos)
    mmHeader:SetText("Minimap")
    yPos = yPos - HEADER_GAP

    local mmCB = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
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
    self.settingsWidgets.minimapCB = mmCB
    yPos = yPos - ITEM_GAP

    -----------------------------------------------------------------
    -- SECTION: Zone View
    -----------------------------------------------------------------
    yPos = yPos - SECTION_GAP

    local zoneHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    zoneHeader:SetPoint("TOPLEFT", 12, yPos)
    zoneHeader:SetText("Sorting and Categorisation")
    yPos = yPos - HEADER_GAP

    local defaultViewDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    defaultViewDesc:SetPoint("TOPLEFT", 14, yPos)
    defaultViewDesc:SetText("Default categorisation:")
    defaultViewDesc:SetTextColor(0.7, 0.7, 0.7, 1)
    yPos = yPos - LABEL_GAP

    local defaultViewModes = { "category", "zone" }
    local defaultViewLabels = { "By Type", "By Zone" }
    local defaultViewButtons = {}
    for i, mode in ipairs(defaultViewModes) do
        local rb = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
        rb:SetSize(24, 24)
        rb:SetPoint("TOPLEFT", 14, yPos)
        rb:SetChecked(self.db.settings.defaultView == mode)

        local rbLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        rbLabel:SetPoint("LEFT", rb, "RIGHT", 4, 0)
        rbLabel:SetText(defaultViewLabels[i])
        rbLabel:SetTextColor(1, 1, 1, 1)

        rb:SetScript("OnClick", function()
            Porter.db.settings.defaultView = mode
            Porter.db.settings.viewMode = mode
            for _, otherRb in ipairs(defaultViewButtons) do
                otherRb:SetChecked(false)
            end
            rb:SetChecked(true)
            if Porter.updateViewToggleText then
                Porter.updateViewToggleText()
            end
            Porter:RefreshMainFrame()
        end)

        tinsert(defaultViewButtons, rb)
        yPos = yPos - ITEM_GAP
    end
    self.settingsWidgets.defaultViewButtons = defaultViewButtons
    self.settingsWidgets.defaultViewModes = defaultViewModes

    yPos = yPos - SUBGROUP_GAP

    local zoneDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    zoneDesc:SetPoint("TOPLEFT", 14, yPos)
    zoneDesc:SetText("Region ordering (in zone view):")
    zoneDesc:SetTextColor(0.7, 0.7, 0.7, 1)
    yPos = yPos - LABEL_GAP

    local zoneOrderModes = { "recent", "alpha" }
    local zoneOrderLabels = { "Most Recent First", "Alphabetical" }
    local zoneOrderButtons = {}
    for i, mode in ipairs(zoneOrderModes) do
        local rb = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
        rb:SetSize(24, 24)
        rb:SetPoint("TOPLEFT", 14, yPos)
        rb:SetChecked(self.db.settings.zoneOrder == mode)

        local rbLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        rbLabel:SetPoint("LEFT", rb, "RIGHT", 4, 0)
        rbLabel:SetText(zoneOrderLabels[i])
        rbLabel:SetTextColor(1, 1, 1, 1)

        rb:SetScript("OnClick", function()
            Porter.db.settings.zoneOrder = mode
            for _, otherRb in ipairs(zoneOrderButtons) do
                otherRb:SetChecked(false)
            end
            rb:SetChecked(true)
            Porter:RefreshMainFrame()
        end)

        tinsert(zoneOrderButtons, rb)
        yPos = yPos - ITEM_GAP
    end
    self.settingsWidgets.zoneOrderButtons = zoneOrderButtons
    self.settingsWidgets.zoneOrderModes = zoneOrderModes

    yPos = yPos - SUBGROUP_GAP

    local seasonDesc = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    seasonDesc:SetPoint("TOPLEFT", 14, yPos)
    seasonDesc:SetText("Current dungeons/raids:")
    seasonDesc:SetTextColor(0.7, 0.7, 0.7, 1)
    yPos = yPos - LABEL_GAP

    local seasonModes = { "tww", "midnight" }
    local seasonLabels = { "The War Within: Season 3", "Midnight: Season 1" }
    local seasonButtons = {}
    for i, mode in ipairs(seasonModes) do
        local rb = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
        rb:SetSize(24, 24)
        rb:SetPoint("TOPLEFT", 14, yPos)
        rb:SetChecked(self.db.settings.currentSeason == mode)

        local rbLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        rbLabel:SetPoint("LEFT", rb, "RIGHT", 4, 0)
        rbLabel:SetText(seasonLabels[i])
        rbLabel:SetTextColor(1, 1, 1, 1)

        rb:SetScript("OnClick", function()
            Porter.db.settings.currentSeason = mode
            for _, otherRb in ipairs(seasonButtons) do
                otherRb:SetChecked(false)
            end
            rb:SetChecked(true)
            Porter:RefreshMainFrame()
        end)

        tinsert(seasonButtons, rb)
        yPos = yPos - ITEM_GAP
    end
    self.settingsWidgets.seasonButtons = seasonButtons
    self.settingsWidgets.seasonModes = seasonModes

    -- Refresh choice display when settings panel is shown (toy data may not be cached at login)
    f:HookScript("OnShow", function()
        if Porter.settingsWidgets and Porter.settingsWidgets.updateChoiceDisplay then
            Porter.settingsWidgets.updateChoiceDisplay()
        end
    end)

    -- Padding below last section
    yPos = yPos - SECTION_GAP

    -- Set content height so scroll frame knows total size
    content:SetHeight(math.abs(yPos) + 20)

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

    local lastSeen = PorterDB.lastSeenVersion
    if lastSeen ~= currentVersion then
        PorterDB.lastSeenVersion = currentVersion
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
