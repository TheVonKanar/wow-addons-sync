-- ====================================
-- \Options\Tabs\Customize_Tab.lua
-- ====================================

local addonName, ns = ...
ns.Options = ns.Options or {}
ns.NumberSelect = ns.NumberSelect or {}
local O = ns.Options
local NS = ns.NumberSelect
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)


local ORDER_BOX_BG = { 0.08, 0.09, 0.12, 1.00 }
local TILE_BG = { 0.10, 0.115, 0.16, 1.00 }
local BORDER_COL = { 0.20, 0.22, 0.28, 1.00 }

local THEME = {
  fontPath = function()
    if O and O.ResolvePanelFont then
      return O.ResolvePanelFont()
    end
    return "Fonts\\FRIZQT__.TTF"
  end,
  sizeLabel = function()
    return (O and O.SIZE_LABEL) or 14
  end,
  cardBG = { 0.09, 0.10, 0.14, 0.95 },
  cardBR = BORDER_COL,
  wellBG = ORDER_BOX_BG,
  wellBR = BORDER_COL,
  rowBG = TILE_BG,
  rowBR = BORDER_COL,
  tickTint = { 0.35, 0.80, 1.00, 1 },
  checkboxBox = function()
    return (O and O.TEXT_CHECKBOX_W) or 20
  end,
  tabH = 24,
  tabGap = 6,
  cardSidePad = 6,
}

local function PaintBackdrop(frame, bg, br)
  frame:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
  frame:SetBackdropColor(unpack(bg))
  frame:SetBackdropBorderColor(unpack(br))
end

local function DB()
  return (ns.GetDB and ns.GetDB()) or _G.ClickableRaidBuffsDB or {}
end
local defaults = (O and O.DEFAULTS) or {}

local function NewCheckbox(parent, label, initial, onToggle)
  local cb = CreateFrame("CheckButton", nil, parent, "BackdropTemplate")
  cb:SetSize(THEME.checkboxBox(), THEME.checkboxBox())
  PaintBackdrop(cb, THEME.wellBG, THEME.wellBR)
  local tick = cb:CreateTexture(nil, "ARTWORK")
  tick:SetAtlas("common-icon-checkmark", true)
  tick:SetPoint("CENTER")
  tick:SetSize(THEME.checkboxBox() - 4, THEME.checkboxBox() - 4)
  tick:SetVertexColor(unpack(THEME.tickTint))
  tick:Hide()
  cb._tick = tick
  local fs = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  fs:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
  fs:SetText(label or "")
  local rawSetChecked = getmetatable(cb).__index.SetChecked
  function cb:SetChecked(state)
    rawSetChecked(self, state and true or false)
    if self._tick then
      self._tick:SetShown(state and true or false)
    end
  end
  cb:SetScript("OnClick", function(self)
    local v = self:GetChecked()
    if self._tick then
      self._tick:SetShown(v)
    end
    if onToggle then
      onToggle(self, v)
    end
  end)
  cb:SetChecked(initial and true or false)
  return cb, fs
end

local function MakeMiniTab(parent, label)
  local b = CreateFrame("Button", nil, parent, "BackdropTemplate")
  PaintBackdrop(b, THEME.rowBG, THEME.rowBR)
  b:SetHeight(THEME.tabH)
  local fs = b:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  fs:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
  fs:SetPoint("CENTER")
  fs:SetText(label or "")
  b:SetFontString(fs)
  b._fs = fs
  b._basePad = 10
  b:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(0.45, 0.85, 1, 1)
  end)
  b:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(unpack(THEME.rowBR))
  end)
  return b
end

local function StyleTabSelected(b)
  if not b then
    return
  end
  b:SetBackdropColor(0.14, 0.18, 0.24, 1)
  b:SetBackdropBorderColor(0.35, 0.60, 1.0, 1)
end

local function StyleTabNormal(b)
  if not b then
    return
  end
  b:SetBackdropColor(unpack(THEME.rowBG))
  b:SetBackdropBorderColor(unpack(THEME.rowBR))
end

local function PingMythicPlus()
  if ns and ns.MythicPlus_Recompute then
    ns.MythicPlus_Recompute()
  end
  if _G.updateWeaponEnchants then
    _G.updateWeaponEnchants()
  end
  local suppress = (ns and ns.MPlus_DisableConsumablesActive and ns.MPlus_DisableConsumablesActive()) or false
  if suppress then
    _G.clickableRaidBuffCache = _G.clickableRaidBuffCache or {}
    _G.clickableRaidBuffCache.displayable = _G.clickableRaidBuffCache.displayable or {}
    local d = _G.clickableRaidBuffCache.displayable
    d.FOOD, d.FLASK, d.MAIN_HAND, d.OFF_HAND = {}, {}, {}, {}
    if ns and ns.RenderAll then
      ns.RenderAll()
    end
    return
  end
  if ns and ns.MarkBagsDirty then
    ns.MarkBagsDirty()
  end
  if ns and ns.PokeUpdateBus then
    ns.PokeUpdateBus()
  end
  if ns and ns.UpdateAugmentRunes then
    ns.UpdateAugmentRunes()
  end
  if ns and ns.RequestRebuild then
    ns.RequestRebuild()
  end
  if ns and ns.RenderAll then
    ns.RenderAll()
  end
end

local function BuildMythicPlusPanel(parent)
  local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
  holder:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)

  local col = CreateFrame("Frame", nil, holder)
  col:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, 0)
  col:SetPoint("TOPRIGHT", holder, "TOPRIGHT", 0, 0)
  col:SetHeight(160)

  local d = DB()
  local enabled = (d.mplusThresholdEnabled ~= false)

  local enableCB, enableLabel = NewCheckbox(col, L["Enable Mythic+ Threshold"], enabled, function(_, v)
    d.mplusThresholdEnabled = v and true or false
    if col._nsHolder then
      col._nsHolder:SetEnabled(v)
    end
    PingMythicPlus()
  end)
  enableCB:SetPoint("TOPLEFT", col, "TOPLEFT", 0, -4)
  enableLabel:SetPoint("LEFT", enableCB, "RIGHT", 8, 0)

  local defV = defaults.mplusThreshold or 45
  local curV = (d.mplusThreshold ~= nil) and d.mplusThreshold or defV

  local nsHolder = NS.Create(col, {
    label = L["Mythic+ Buffs (Minutes)"],
    min = 1,
    max = 120,
    step = 0.5,
    value = curV,
    default = defV,
    onChange = function(v)
      d.mplusThreshold = v
      PingMythicPlus()
    end,
  })
  nsHolder:SetPoint("TOPLEFT", enableCB, "BOTTOMLEFT", 0, -12)
  nsHolder:SetEnabled(enabled)
  col._nsHolder = nsHolder

  local cb, lab = NewCheckbox(
    col,
    L["Disable Consumables after Key Starts"],
    d.mplusDisableConsumables == true,
    function(_, v)
      d.mplusDisableConsumables = v and true or false
      PingMythicPlus()
    end
  )
  cb:SetPoint("TOPLEFT", nsHolder, "BOTTOMLEFT", 0, -14)
  lab:SetPoint("LEFT", cb, "RIGHT", 8, 0)

  return holder
end

local function BuildHunterPetsPanel(parent)
  local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
  holder:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)

  local d = DB()
  d.hunterPets = d.hunterPets or {}
  local hp = d.hunterPets

  local function refresh()
    if ns.Pets_Rebuild then
      ns.Pets_Rebuild()
    end
    if ns.RenderAll then
      ns.RenderAll()
    end
  end

  local cb1, lab1 = NewCheckbox(holder, L["Reverse Pet Order"], hp.reverseOrder == true, function(_, v)
    hp.reverseOrder = v and true or false
    refresh()
  end)
  cb1:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, -4)
  lab1:SetPoint("LEFT", cb1, "RIGHT", 8, 0)

  local cb2, lab2 = NewCheckbox(holder, L["Use Pet Ability Icon"], hp.useAbilityIcon == true, function(_, v)
    hp.useAbilityIcon = v and true or false
    refresh()
  end)
  cb2:SetPoint("TOPLEFT", cb1, "BOTTOMLEFT", 0, -12)
  lab2:SetPoint("LEFT", cb2, "RIGHT", 8, 0)

  local cb3, lab3 = NewCheckbox(holder, L["Display Pet Talents Symbol"], hp.displayTalentsSymbol ~= false, function(_, v)
    hp.displayTalentsSymbol = v and true or false
    refresh()
  end)
  cb3:SetPoint("TOPLEFT", cb2, "BOTTOMLEFT", 0, -12)
  lab3:SetPoint("LEFT", cb3, "RIGHT", 8, 0)

  local cb4, lab4 = NewCheckbox(
    holder,
    L["Show Pet Ability on Mouseover"],
    hp.showAbilityOnMouseover ~= false,
    function(_, v)
      hp.showAbilityOnMouseover = v and true or false
      refresh()
    end
  )
  cb4:SetPoint("TOPLEFT", cb3, "BOTTOMLEFT", 0, -12)
  lab4:SetPoint("LEFT", cb4, "RIGHT", 8, 0)

  return holder
end

local function BuildTooltipsPanel(parent)
  local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
  holder:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)

  local d = DB()
  d.tooltips = d.tooltips or {}
  local tt = d.tooltips

  local cb, lab = NewCheckbox(holder, HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_SHOW_TOOLTIPS, tt.enabled ~= false, function(_, v)
    tt.enabled = v and true or false
  end)
  cb:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, -4)
  lab:SetPoint("LEFT", cb, "RIGHT", 8, 0)

  return holder
end

local function RefreshExpansionFilters()
  if ns and ns.ApplyExpansionMetadata then
    ns.ApplyExpansionMetadata()
  end
  if ns and ns.MarkBagsDirty then
    ns.MarkBagsDirty()
  end
  if ns and ns.PokeUpdateBus then
    ns.PokeUpdateBus()
  end
  if ns and ns.UpdateAugmentRunes then
    ns.UpdateAugmentRunes()
  end
  if ns and ns.RequestRebuild then
    ns.RequestRebuild()
  end
  if ns and ns.RenderAll then
    ns.RenderAll()
  end
end

local function BuildExpansionsPanel(parent)
  local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
  holder:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)

  local d = DB()
  d.expansions = d.expansions or {}
  if d.expansions[10] == nil then
    d.expansions[10] = true
  end
  if d.expansions[11] == nil then
    d.expansions[11] = true
  end

  local cbMid, labMid = NewCheckbox(holder, EXPANSION_NAME11, d.expansions[11] ~= false, function(_, v)
    if ns.SetExpansionEnabled then
      ns.SetExpansionEnabled(11, v)
    else
      d.expansions[11] = v and true or false
    end
    RefreshExpansionFilters()
  end)
  cbMid:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, -4)
  labMid:SetPoint("LEFT", cbMid, "RIGHT", 8, 0)

  local cbTWW, labTWW = NewCheckbox(holder, EXPANSION_NAME10, d.expansions[10] ~= false, function(_, v)
    if ns.SetExpansionEnabled then
      ns.SetExpansionEnabled(10, v)
    else
      d.expansions[10] = v and true or false
    end
    RefreshExpansionFilters()
  end)
  cbTWW:SetPoint("TOPLEFT", cbMid, "BOTTOMLEFT", 0, -12)
  labTWW:SetPoint("LEFT", cbTWW, "RIGHT", 8, 0)

  return holder
end

local function BuildDelvesPanel(parent)
  local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
  holder:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)

  local d = DB()

  local cb, lab = NewCheckbox(
    holder,
    L["Disable Consumables in Delves"],
    d.delvesDisableConsumables == true,
    function(_, v)
      d.delvesDisableConsumables = v and true or false
      if ns.Delves_Recompute then
        ns.Delves_Recompute()
      end
    end
  )
  cb:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, -4)
  lab:SetPoint("LEFT", cb, "RIGHT", 8, 0)

  return holder
end

local function BuildMountsPanel(parent)
  local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
  holder:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)

  local d = DB()
  d.mounts = d.mounts or {}

  local faction = select(1, UnitFactionGroup("player"))
  local ttm = (faction == "Alliance") and 280 or ((faction == "Horde") and 284 or nil)
  local ids = { 1039, 460, 2237, ttm }

  local selected = tonumber(d.mounts.selectedMount or ns.SelectedMount or 0) or 0
  local cbs = {}

  local function setSelected(id)
    d.mounts.selectedMount = id
    ns.SelectedMount = id
    for _, cb in ipairs(cbs) do
      cb:SetChecked(cb._crb_id == id)
    end
    if ns.Durability_SetSelectedMount then
      ns.Durability_SetSelectedMount(id)
    end
  end

  local prevCB

  for _, id in ipairs(ids) do
    if id then
      local name = (
        C_MountJournal
        and C_MountJournal.GetMountInfoByID
        and select(1, C_MountJournal.GetMountInfoByID(id))
      ) or (L["Mount"] .. " " .. id)
      local cb, lab = NewCheckbox(holder, name, selected == id, function(cb, v)
        if v then
          setSelected(id)
        else
          if d.mounts.selectedMount == id then
            cb:SetChecked(true)
          end
        end
      end)
      cb._crb_id = id
      if not prevCB then
        cb:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, -4)
      else
        cb:SetPoint("TOPLEFT", prevCB, "BOTTOMLEFT", 0, -12)
      end
      lab:SetPoint("LEFT", cb, "RIGHT", 8, 0)
      table.insert(cbs, cb)
      prevCB = cb
    end
  end

  return holder
end

local function BuildShamanPanel(parent)
  local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  holder:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
  holder:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)

local d = DB()

d.earthShieldOverride = d.earthShieldOverride or {
  showPlayerIcon = true,
  showTargetIcon = true,
  disableTargetWhenSolo = true,
}

  local es = d.earthShieldOverride

  local function refresh()
    if ns and ns.ShamanShields_Rebuild then
      ns.ShamanShields_Rebuild()
    end
    if ns and ns.RenderAll then
      ns.RenderAll()
    end
  end

  local cb1, lab1 = NewCheckbox(holder, L["Show Earth Shield icon to cast at Player"], es.showPlayerIcon ~= false, function(_, v)
    es.showPlayerIcon = v and true or false
    refresh()
  end)
  cb1:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, -4)
  lab1:SetPoint("LEFT", cb1, "RIGHT", 8, 0)

  local cb2, lab2 = NewCheckbox(holder, L["Show Earth Shield icon to cast at Target"], es.showTargetIcon ~= false, function(_, v)
    es.showTargetIcon = v and true or false
    refresh()
  end)
  cb2:SetPoint("TOPLEFT", cb1, "BOTTOMLEFT", 0, -12)
  lab2:SetPoint("LEFT", cb2, "RIGHT", 8, 0)

  local cb3, lab3 = NewCheckbox(holder, L["Disable Earth Shield icon to cast at Target when not in a group"], es.disableTargetWhenSolo ~= false, function(_, v)
    es.disableTargetWhenSolo = v and true or false
    refresh()
  end)
  cb3:SetPoint("TOPLEFT", cb2, "BOTTOMLEFT", 0, -12)
  lab3:SetPoint("LEFT", cb3, "RIGHT", 8, 0)

  return holder
end


O.RegisterSection(function(AddSection)
  AddSection(OPTIONS, function(content, Row)
    local row = Row(385)

    local card = CreateFrame("Frame", nil, row, "BackdropTemplate")
    PaintBackdrop(card, THEME.cardBG, THEME.cardBR)
    card:SetPoint("TOPLEFT", 0, -8)
    card:SetPoint("BOTTOMRIGHT", 0, 0)

    local tabsArea = CreateFrame("Frame", nil, card)
    tabsArea:SetPoint("TOPLEFT", THEME.cardSidePad, -12)
    tabsArea:SetPoint("TOPRIGHT", -THEME.cardSidePad, -12)
    tabsArea:SetHeight(THEME.tabH)

    local tabRow = CreateFrame("Frame", nil, tabsArea)
    tabRow:SetAllPoints()

    local inner = CreateFrame("Frame", nil, card, "BackdropTemplate")
    inner:ClearAllPoints()
    inner:SetPoint("TOPLEFT", tabsArea, "BOTTOMLEFT", 0, -4)
    inner:SetPoint("TOPRIGHT", tabsArea, "BOTTOMRIGHT", 0, -4)
    inner:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", THEME.cardSidePad, 6)
    inner:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -THEME.cardSidePad, 6)

    inner:SetPoint("BOTTOMRIGHT", -THEME.cardSidePad, 6)
    PaintBackdrop(inner, THEME.wellBG, THEME.wellBR)

    local mythicBtn = MakeMiniTab(tabRow, PLAYER_DIFFICULTY_MYTHIC_PLUS)
    mythicBtn:SetPoint("LEFT", tabRow, "LEFT", 0, 0)


    local hunterClassName = (C_CreatureInfo.GetClassInfo(3) or {}).className or L["Hunter"]
    local petsTabName = hunterClassName




    local hunterBtn = MakeMiniTab(tabRow, petsTabName)
    hunterBtn:SetPoint("LEFT", mythicBtn, "RIGHT", THEME.tabGap, 0)

    local tipsBtn = MakeMiniTab(tabRow, HUD_EDIT_MODE_SETTING_ENCOUNTER_EVENTS_TOOLTIPS)
    tipsBtn:SetPoint("LEFT", hunterBtn, "RIGHT", THEME.tabGap, 0)

    local delvesBtn = MakeMiniTab(tabRow, DELVES_LABEL)
    delvesBtn:SetPoint("LEFT", tipsBtn, "RIGHT", THEME.tabGap, 0)

    local mountsBtn = MakeMiniTab(tabRow, MOUNTS .. " (" .. MINIMAP_TRACKING_REPAIR .. ")")
    mountsBtn:SetPoint("LEFT", delvesBtn, "RIGHT", THEME.tabGap, 0)

    local expansionsBtn = MakeMiniTab(tabRow, EXPANSION_FILTER_TEXT)
    expansionsBtn:SetPoint("LEFT", mountsBtn, "RIGHT", THEME.tabGap, 0)
    
    local shamanClassName = (C_CreatureInfo.GetClassInfo(7) or {}).className or L["Shaman"]
    local shamanBtn = MakeMiniTab(tabRow, shamanClassName)
    shamanBtn:SetPoint("LEFT", expansionsBtn, "RIGHT", THEME.tabGap, 0)
    
    local tabButtons = {
  mythicBtn,
  tipsBtn,
  delvesBtn,
  mountsBtn,
  expansionsBtn,
  hunterBtn,
  shamanBtn,
}

local function LayoutTabs()
  local availableWidth = tabsArea:GetWidth() or 600
  if availableWidth < 100 then
    return
  end

  local gap = THEME.tabGap
  local rowHeight = THEME.tabH

  local rows = {}
  local currentRow = {}
  local currentWidth = 0

  for _, btn in ipairs(tabButtons) do
    local textWidth = btn._fs:GetStringWidth() or 40
    local minWidth = math.max(50, math.floor(textWidth + 20))

    if currentWidth > 0 and (currentWidth + minWidth + gap) > availableWidth then
      table.insert(rows, currentRow)
      currentRow = {}
      currentWidth = 0
    end

    table.insert(currentRow, { button = btn, minWidth = minWidth })
    currentWidth = (currentWidth == 0) and minWidth or (currentWidth + gap + minWidth)
  end

  if #currentRow > 0 then
    table.insert(rows, currentRow)
  end

  local y = 0

  for _, row in ipairs(rows) do
    local totalMin = 0
    for _, entry in ipairs(row) do
      totalMin = totalMin + entry.minWidth
    end

    local totalGaps = gap * (#row - 1)
    local freeSpace = availableWidth - totalMin - totalGaps
    local extraPerTab = (freeSpace > 0) and (freeSpace / #row) or 0

    local x = 0

    for i, entry in ipairs(row) do
      local btn = entry.button
      local finalWidth = math.floor(entry.minWidth + extraPerTab)

      btn:ClearAllPoints()
      btn:SetPoint("TOPLEFT", tabRow, "TOPLEFT", x, y)
      btn:SetWidth(finalWidth)

      x = x + finalWidth + gap
    end

    y = y - (rowHeight + gap)
  end

  local rowCount = #rows
  tabsArea:SetHeight((rowHeight * rowCount) + (gap * (rowCount - 1)))
  
end


    LayoutTabs()
    tabsArea:HookScript("OnSizeChanged", function()
      LayoutTabs()
    end)

    

    local panels = {}

    local function showPanel(key)
      for _, f in pairs(panels) do
        if f then
          f:Hide()
        end
      end
      if key == "MYTHIC" then
        panels.MYTHIC = panels.MYTHIC or BuildMythicPlusPanel(inner)
        panels.MYTHIC:Show()
      end
      if key == "HUNTER" then
        panels.HUNTER = panels.HUNTER or BuildHunterPetsPanel(inner)
        panels.HUNTER:Show()
      end
      if key == "TIPS" then
        panels.TIPS = panels.TIPS or BuildTooltipsPanel(inner)
        panels.TIPS:Show()
      end
      if key == "DELVES" then
        panels.DELVES = panels.DELVES or BuildDelvesPanel(inner)
        panels.DELVES:Show()
      end
      if key == "MOUNTS" then
        panels.MOUNTS = panels.MOUNTS or BuildMountsPanel(inner)
        panels.MOUNTS:Show()
      end
      if key == "EXPANSIONS" then
        panels.EXPANSIONS = panels.EXPANSIONS or BuildExpansionsPanel(inner)
        panels.EXPANSIONS:Show()
      end
      if key == "SHAMAN" then
        panels.SHAMAN = panels.SHAMAN or BuildShamanPanel(inner)
        panels.SHAMAN:Show()
      end
    end



    local function selectTab(which)
      StyleTabNormal(mythicBtn)
      StyleTabNormal(hunterBtn)
      StyleTabNormal(tipsBtn)
      StyleTabNormal(delvesBtn)
      StyleTabNormal(mountsBtn)
      StyleTabNormal(expansionsBtn)
      StyleTabNormal(shamanBtn)
      if which == "MYTHIC" then
        StyleTabSelected(mythicBtn)
      end
      if which == "HUNTER" then
        StyleTabSelected(hunterBtn)
      end
      if which == "TIPS" then
        StyleTabSelected(tipsBtn)
      end
      if which == "DELVES" then
        StyleTabSelected(delvesBtn)
      end
      if which == "MOUNTS" then
        StyleTabSelected(mountsBtn)
      end
      if which == "EXPANSIONS" then
        StyleTabSelected(expansionsBtn)
      end
      if which == "SHAMAN" then
        StyleTabSelected(shamanBtn)
      end
      showPanel(which)
    end

    mythicBtn:SetScript("OnClick", function()
      selectTab("MYTHIC")
    end)
    hunterBtn:SetScript("OnClick", function()
      selectTab("HUNTER")
    end)
    tipsBtn:SetScript("OnClick", function()
      selectTab("TIPS")
    end)
    delvesBtn:SetScript("OnClick", function()
      selectTab("DELVES")
    end)
    mountsBtn:SetScript("OnClick", function()
      selectTab("MOUNTS")
    end)
    expansionsBtn:SetScript("OnClick", function()
      selectTab("EXPANSIONS")
    end)
    shamanBtn:SetScript("OnClick", function()
      selectTab("SHAMAN")
    end)

    card:SetScript("OnShow", function()
      selectTab("MYTHIC")
    end)
  end)
end)
