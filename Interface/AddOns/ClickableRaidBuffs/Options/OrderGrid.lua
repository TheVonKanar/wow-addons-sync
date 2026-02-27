-- ====================================
-- \Options\OrderGrid.lua
-- ====================================

local addonName, ns = ...
ns.Options = ns.Options or {}
ns.Options.OrderGrid = ns.Options.OrderGrid or {}

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local O = ns.Options
local OE = ns.OptionElements

local ORDER_KNOBS = {
  ROW_TOP_PAD = 10,
  BOX_PAD_L = 6,
  BOX_PAD_R = 6,
  GRID_COLS = 6,
  GRID_GAP = 5,
  CELL_HEIGHT_RATIO = 0.75,
  HEADER_TOP_PAD = 48,
  BOTTOM_PAD = 8,
  TITLE_TOP_OFFSET = 12,
  MIN_CONTENT_W = 300,
  MIN_CELL_W = 64,
}

local CATEGORY_LABELS = {
  EATING = L["Eating"],
  FOOD = L["Food"],
  FLASK = L["Flask"],
  MAIN_HAND = L["Main Hand"],
  OFF_HAND = L["Off Hand"],
  CASTABLE_WEAPON_ENCHANTS = L["Castable Weapon Enchants"],
  DK_WEAPON_ENCHANTS = L["DK Enchants"],
  ROGUE_POISONS = L["Poisons"],
  AUGMENT_RUNE = L["Runes"],
  RAID_BUFFS = L["Raid Buffs"],
  CUSTOM_AURAS = (L["Custom Buffs"] or L["Custom Spells"]),
  SHAMAN_SHIELDS = L["Shaman Shields"],
  PET_ASSIST = L["Pets"],
  PETS = L["Pets"],
  DURABILITY = L["Durability"],
  HEALTHSTONE = L["Healthstone"],
  COSMETIC = L["Cosmetic"],
  TRINKETS = L["Trinkets"],
}

local ORDER_GROUPS = {
  RAIDBUFFS_GROUP = {
    label = L["Raid Buffs"],
    cats = { "RAID_BUFFS", "CUSTOM_AURAS", "ROGUE_POISONS", "CASTABLE_WEAPON_ENCHANTS", "SHAMAN_SHIELDS" },
  },
  FOOD_GROUP = {
    label = L["Food"],
    cats = { "EATING", "FOOD" },
  },
  WEP_ENCH_GROUP = {
    label = L["Weapon Enchants"],
    cats = { "MAIN_HAND", "OFF_HAND" },
  },
  FLASK_GROUP = {
    label = L["Flasks"],
    cats = { "FLASK" },
  },
  UTILITY_GROUP = {
    label = L["Utility"],
    cats = { "DK_WEAPON_ENCHANTS", "DURABILITY", "HEALTHSTONE", "RECUPERATE" },
  },
  RUNES_GROUP = {
    label = L["Augment Runes"],
    cats = { "AUGMENT_RUNE" },
  },
  PETS_GROUP = {
    label = L["Pets"],
    cats = { "PETS", "PET_ASSIST" },
  },
  COSMETIC_GROUP = {
    label = L["Cosmetic"],
    cats = { "COSMETIC" },
  },
  TRINKETS_GROUP = {
    label = L["Trinkets"],
    cats = { "TRINKETS" },
  },
  CUSTOM_GROUP = {
    label = (L["Custom Buffs"] or L["Custom Spells"]),
    cats = { "CUSTOM_AURAS" },
  },
}

local function DB()
  return (ns.GetDB and ns.GetDB()) or ClickableRaidBuffsDB or {}
end

local function _order_catToGroup(cat)
  for gid, def in pairs(ORDER_GROUPS) do
    for _, c in ipairs(def.cats) do
      if c == cat then
        return gid
      end
    end
  end
  return cat
end

local function _order_expandGroup(gid, out)
  local g = ORDER_GROUPS[gid]
  if g then
    for _, c in ipairs(g.cats) do
      out[#out + 1] = c
    end
  else
    out[#out + 1] = gid
  end
end

local function _order_NormalizeOrder(saved, defaults)
  local allowed = {}
  if type(defaults) == "table" then
    for i = 1, #defaults do
      allowed[tostring(defaults[i])] = true
    end
  end
  local seen, out = {}, {}
  if type(saved) == "table" then
    for i = 1, #saved do
      local c = tostring(saved[i])
      if (next(allowed) == nil or allowed[c]) and not seen[c] then
        seen[c] = true
        out[#out + 1] = c
      end
    end
  end
  for i = 1, #defaults do
    local c = defaults[i]
    if not seen[c] then
      seen[c] = true
      out[#out + 1] = c
    end
  end
  return out
end

local function _order_ToGroupedOrder(catOrder)
  local seen, gout = {}, {}
  for _, c in ipairs(catOrder) do
    local gid = _order_catToGroup(c)
    if not seen[gid] then
      seen[gid] = true
      gout[#gout + 1] = gid
    end
  end
  return gout
end


local function _order_moveGroupToEnd(order, gid)
  if type(order) ~= "table" then
    return order
  end
  local out, found = {}, false
  for i = 1, #order do
    local v = order[i]
    if v == gid then
      found = true
    else
      out[#out + 1] = v
    end
  end
  if found then
    out[#out + 1] = gid
    return out
  end
  return order
end

local function _order_SaveGroupedOrder(gorder)
  local out = {}
  for _, gid in ipairs(gorder) do
    _order_expandGroup(gid, out)
  end
  DB().categoryOrder = out
  if ns.SetCategoryOrder then
    ns.SetCategoryOrder(out)
  end
  if ns.RequestRebuild then
    ns.RequestRebuild()
  end
end

local function _order_groupText(gid)
  local g = ORDER_GROUPS[gid]
  if g and g.label then
    return g.label
  end
  if not g then
    return CATEGORY_LABELS[gid] or gid
  end
  local ex = {}
  for _, c in ipairs(g.cats) do
    ex[#ex + 1] = (CATEGORY_LABELS[c] or c)
  end
  return table.concat(ex, " + ")
end

local POPUP_KEY = "CRB_ORDER_RESET"

if not StaticPopupDialogs[POPUP_KEY] then
  StaticPopupDialogs[POPUP_KEY] = {
    text = L["Reset icon order to defaults?"],
    button1 = YES,
    button2 = NO,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
      if data and data.doReset then
        data.doReset()
      end
    end,
  }
end

function ns.Options.OrderGrid.Build(content, Row)
  local K = ORDER_KNOBS

  local def = (ns.GetCategoryOrderDefaults and ns.GetCategoryOrderDefaults()) or ORDER_DEFAULTS
  if not def or type(def) ~= "table" then
    def = {}
    local orderedGroups = {
      "RAIDBUFFS_GROUP",
      "FOOD_GROUP",
      "WEP_ENCH_GROUP",
      "FLASK_GROUP",
      "UTILITY_GROUP",
      "RUNES_GROUP",
      "PETS_GROUP",
      "COSMETIC_GROUP",
      "TRINKETS_GROUP",
      "CUSTOM_GROUP",
    }
    for _, gid in ipairs(orderedGroups) do
      _order_expandGroup(gid, def)
    end
  end

  local seenRT = false
  for i = 1, #def do
    if def[i] == "TRINKETS" then
      seenRT = true
      break
    end
  end
  if not seenRT then
    def[#def + 1] = "TRINKETS"
  end

  if not DB().categoryOrder then
    DB().categoryOrder = def
  end

  local defaults = def

  local atomicOrder = _order_NormalizeOrder(DB().categoryOrder, defaults)
  local gorder = _order_ToGroupedOrder(atomicOrder)
  gorder = _order_moveGroupToEnd(gorder, "CUSTOM_GROUP")

  for i = #gorder, 1, -1 do
    if gorder[i] == "TRINKETS_GROUP" then
      table.remove(gorder, i)
    end
  end
  local usableW = (content:GetWidth() or 600) - (K.BOX_PAD_L + K.BOX_PAD_R)
  if usableW < K.MIN_CONTENT_W then
    usableW = K.MIN_CONTENT_W
  end

  local initCellW = (usableW - (K.GRID_COLS - 1) * K.GRID_GAP) / K.GRID_COLS
  if initCellW < K.MIN_CELL_W then
    initCellW = K.MIN_CELL_W
  end

  local CELL_H = initCellW * K.CELL_HEIGHT_RATIO
  local initRows = math.max(1, math.ceil(#gorder / K.GRID_COLS))
  local initGridH = initRows * CELL_H + (initRows - 1) * K.GRID_GAP

  local row = Row(K.ROW_TOP_PAD + K.HEADER_TOP_PAD + initGridH + K.BOTTOM_PAD)

  local box = CreateFrame("Frame", nil, row, "BackdropTemplate")
  box:SetPoint("TOPLEFT", 0, -K.ROW_TOP_PAD)
  box:SetPoint("BOTTOMRIGHT", 0, 0)
  box:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
  box:SetBackdropColor(0.08, 0.09, 0.12, 1)
  box:SetBackdropBorderColor(0.20, 0.22, 0.28, 1)

  local title = box:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

  local function Face()
    return (O and O.ResolvePanelFont and O.ResolvePanelFont()) or "Fonts\\FRIZQT__.TTF"
  end

  local function FS(fs, size, flags)
    if fs and fs.SetFont then
      fs:SetFont(Face(), size or (O.SIZE_LABEL or 14), flags or "")
    end
  end

  FS(title, O.SIZE_LABEL or 14, "")
  title:SetPoint("TOPLEFT", K.BOX_PAD_L, -K.TITLE_TOP_OFFSET)
  title:SetText(L["Icon Order"])

  local grid = CreateFrame("Frame", nil, box)
  grid:SetPoint("TOPLEFT", K.BOX_PAD_L, -K.HEADER_TOP_PAD)
  grid:SetPoint("RIGHT", -K.BOX_PAD_R, 0)
  grid:SetHeight(initGridH)

  local widths, xofs = {}, {}
  local tilesByGroup, tileList = {}, {}
  local draggingGid, draggingTile, hoverIdx
  local preview, anims = {}, {}

  local ghost = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
  ghost:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
  ghost:SetBackdropColor(0.10, 0.115, 0.16, 0.95)
  ghost:SetBackdropBorderColor(0.20, 0.22, 0.28, 1)
  ghost:SetFrameStrata("TOOLTIP")

  ghost.num = ghost:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  ghost.label = ghost:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

  FS(ghost.num, 16, "")
  FS(ghost.label, O.SIZE_LABEL or 12, "")

  ghost.num:SetPoint("TOPLEFT", ghost, "TOPLEFT", 4, -4)
  ghost.label:SetPoint("TOPLEFT", ghost, "TOPLEFT", 6, -6)
  ghost.label:SetPoint("BOTTOMRIGHT", ghost, "BOTTOMRIGHT", -6, 6)

  ghost:Hide()

  local function updateGhost()
    if not draggingTile then
      return
    end

    local w, h = draggingTile:GetSize()
    ghost:SetSize(w, h)

    local idx = hoverIdx or 0
    ghost.num:SetText(tostring(idx))
    ghost.label:SetText(_order_groupText(draggingGid))

    local scale = UIParent:GetEffectiveScale()
    local cx, cy = GetCursorPosition()
    cx, cy = cx / scale, cy / scale

    ghost:ClearAllPoints()
    ghost:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cx, cy)
  end

  local function computeGeometry()
    local w
    if grid:GetRight() and grid:GetLeft() then
      w = grid:GetRight() - grid:GetLeft()
    else
      w = (content:GetWidth() or 600) - (K.BOX_PAD_L + K.BOX_PAD_R)
    end

    if w < K.MIN_CONTENT_W then
      w = K.MIN_CONTENT_W
    end

    local totalGaps = (K.GRID_COLS - 1) * K.GRID_GAP
    local base = math.floor((w - totalGaps) / K.GRID_COLS)
    if base < K.MIN_CELL_W then
      base = K.MIN_CELL_W
    end

    local rem = math.floor(w - (base * K.GRID_COLS + totalGaps) + 0.5)
    if rem < 0 then
      rem = 0
    end

    wipe(widths)
    wipe(xofs)

    local x = 0
    for c = 1, K.GRID_COLS do
      local add = (rem > 0) and 1 or 0
      local cw = base + add
      widths[c] = cw
      xofs[c] = x
      x = x + cw + (c < K.GRID_COLS and K.GRID_GAP or 0)
      if rem > 0 then
        rem = rem - 1
      end
    end

    local CELL_H2 = math.floor(widths[1] * K.CELL_HEIGHT_RATIO + 0.5)

    local count = #gorder
    local rowsNow = math.max(1, math.ceil(count / K.GRID_COLS))
    local gridH = rowsNow * CELL_H2 + (rowsNow - 1) * K.GRID_GAP
    grid:SetHeight(gridH)

    local total = K.ROW_TOP_PAD + K.HEADER_TOP_PAD + gridH + K.BOTTOM_PAD
    row:SetHeight(total)
  end

  local function indexToRC(i)
    local r = math.floor((i - 1) / K.GRID_COLS)
    local c = ((i - 1) % K.GRID_COLS) + 1
    return r, c
  end

  local function coordsForIndex(i)
    local r, c = indexToRC(i)
    local x = xofs[c] or 0
    local y = -r * (math.floor(widths[1] * K.CELL_HEIGHT_RATIO + 0.5) + K.GRID_GAP)
    return x, y, c
  end

  local function animateTo(t, tx, ty, dur)
    local p, rel, rp, x, y = t:GetPoint(1)

    if rel ~= grid then
      t:ClearAllPoints()
      t:SetPoint("TOPLEFT", grid, "TOPLEFT", tx, ty)
      return
    end

    x, y = x or tx, y or ty

    if math.abs((tx - x)) < 0.5 and math.abs((ty - y)) < 0.5 then
      t:ClearAllPoints()
      t:SetPoint("TOPLEFT", grid, "TOPLEFT", tx, ty)
      anims[t] = nil
      return
    end

    local now = GetTime()
    anims[t] = { sx = x, sy = y, tx = tx, ty = ty, t0 = now, dur = dur or 0.10 }
  end

  local function tickAnimations()
    if not next(anims) then
      return
    end

    local now = GetTime()

    for t, a in pairs(anims) do
      local f = (now - a.t0) / a.dur

      if f >= 1 then
        t:ClearAllPoints()
        t:SetPoint("TOPLEFT", grid, "TOPLEFT", a.tx, a.ty)
        anims[t] = nil
      else
        local u = (f * f * (3 - 2 * f))
        local x = a.sx + (a.tx - a.sx) * u
        local y = a.sy + (a.ty - a.sy) * u
        t:ClearAllPoints()
        t:SetPoint("TOPLEFT", grid, "TOPLEFT", x, y)
      end
    end
  end
  local function rebuildPreview(insertIdx)
    wipe(preview)

    if draggingGid then
      local tmp = {}
      for i = 1, #gorder do
        local gid = gorder[i]
        if gid ~= draggingGid then
          tmp[#tmp + 1] = gid
        end
      end

      local target = (insertIdx and math.max(1, math.min(#tmp + 1, insertIdx))) or 1

      for i = 1, target - 1 do
        preview[#preview + 1] = tmp[i]
      end

      preview[#preview + 1] = draggingGid

      for i = target, #tmp do
        preview[#preview + 1] = tmp[i]
      end
    else
      for i = 1, #gorder do
        preview[i] = gorder[i]
      end
    end
  end

  local function applyPreview(animated)
    for i = 1, #preview do
      local gid = preview[i]
      local t = tilesByGroup[gid]

      if t then
        t.num:SetText(tostring(i))
        t.label:SetText(_order_groupText(gid))

        local tx, ty, col = coordsForIndex(i)
        local w = widths[col] or widths[1] or K.MIN_CELL_W
        t:SetSize(w, math.floor(widths[1] * K.CELL_HEIGHT_RATIO + 0.5))

        if animated and t ~= draggingTile then
          animateTo(t, tx, ty, 0.10)
        else
          t:ClearAllPoints()
          t:SetPoint("TOPLEFT", grid, "TOPLEFT", tx, ty)
        end
      end
    end
  end

  local function cursorToIndex()
    local scale = UIParent:GetEffectiveScale()
    local cx, cy = GetCursorPosition()
    cx, cy = cx / scale, cy / scale

    local left = grid:GetLeft() or 0
    local top = grid:GetTop() or 0
    local lx = cx - left
    local ly = top - cy

    local col, accum = 1, 0
    for c = 1, K.GRID_COLS do
      local w = widths[c] or 0
      if lx <= accum + w + (c < K.GRID_COLS and K.GRID_GAP or 0) then
        col = c
        break
      end
      accum = accum + w + (c < K.GRID_COLS and K.GRID_GAP or 0)
    end

    local CELL_H2 = math.floor(widths[1] * K.CELL_HEIGHT_RATIO + 0.5)
    local rowIdx = math.floor(ly / (CELL_H2 + K.GRID_GAP)) + 1

    if rowIdx < 1 then
      rowIdx = 1
    end

    local maxRows = math.max(1, math.ceil(#gorder / K.GRID_COLS))
    if rowIdx > maxRows then
      rowIdx = maxRows
    end

    local idx = (rowIdx - 1) * K.GRID_COLS + col

    if idx > #gorder then
      idx = #gorder
    end
    if idx < 1 then
      idx = 1
    end

    return idx
  end

  local function makeTile(gid)
    local t = CreateFrame("Button", nil, grid, "BackdropTemplate")
    t.groupId = gid

    t:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
    t:SetBackdropColor(0.10, 0.115, 0.16, 1)
    t:SetBackdropBorderColor(0.20, 0.22, 0.28, 1)

    t.num = t:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    t.label = t:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

    local function FS2(fs, size, flags)
      if fs and fs.SetFont then
        local Face = (O and O.ResolvePanelFont and O.ResolvePanelFont()) or "Fonts\\FRIZQT__.TTF"
        fs:SetFont(Face, size or (O.SIZE_LABEL or 14), flags or "")
      end
    end

    FS2(t.num, 16, "")
    t.num:SetPoint("TOPLEFT", t, "TOPLEFT", 4, -4)

    FS2(t.label, O.SIZE_LABEL or 12, "")
    t.label:SetPoint("TOPLEFT", t, "TOPLEFT", 6, -6)
    t.label:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", -6, 6)
    t.label:SetJustifyH("CENTER")
    t.label:SetJustifyV("MIDDLE")

    if t.label.SetNonSpaceWrap then
      t.label:SetNonSpaceWrap(true)
    end

    if t.label.SetMaxLines then
      t.label:SetMaxLines(3)
    end

    t:SetSize((widths[1] or K.MIN_CELL_W), math.floor((widths[1] or K.MIN_CELL_W) * K.CELL_HEIGHT_RATIO + 0.5))

    t:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:AddLine(_order_groupText(self.groupId), 1, 0.82, 0)
      GameTooltip:Show()
    end)

    t:SetScript("OnLeave", function()
      GameTooltip:Hide()
    end)

    t:RegisterForDrag("LeftButton")

    t:SetScript("OnDragStart", function(self)
      draggingGid = self.groupId
      draggingTile = self
      self:SetAlpha(0.05)
      ghost:Show()

      hoverIdx = cursorToIndex()
      rebuildPreview(hoverIdx)
      applyPreview(true)
    end)

    t:SetScript("OnDragStop", function(self)
      if draggingTile ~= self then
        return
      end

      self:SetAlpha(1)
      ghost:Hide()

      local newOrder = {}
      for i = 1, #preview do
        newOrder[i] = preview[i]
      end

      gorder = _order_moveGroupToEnd(newOrder, "CUSTOM_GROUP")
    newOrder = gorder
      _order_SaveGroupedOrder(newOrder)

      draggingGid, draggingTile, hoverIdx = nil, nil, nil
      rebuildPreview(nil)
      applyPreview(false)
    end)

    return t
  end
  local function clearTiles()
    if tileList then
      for i = #tileList, 1, -1 do
        local t = tileList[i]
        anims[t] = nil
        t:Hide()
        t:SetParent(nil)
        tileList[i] = nil
      end
    end

    wipe(tilesByGroup)
    wipe(preview)
    draggingGid, draggingTile, hoverIdx = nil, nil, nil
    ghost:Hide()
  end

  local function buildTiles()
    clearTiles()

    for i = 1, #gorder do
      local gid = gorder[i]

      if gid ~= "TRINKETS_GROUP" and gid ~= "TRINKETS" then
        local t = makeTile(gid)
        tilesByGroup[gid] = t
        tileList[#tileList + 1] = t
      end
    end

    computeGeometry()
    rebuildPreview(nil)
    applyPreview(false)
  end

  grid:HookScript("OnSizeChanged", function()
    computeGeometry()
    rebuildPreview(hoverIdx)
    applyPreview(false)
  end)

  grid:SetScript("OnUpdate", function()
    if draggingTile then
      local idx = cursorToIndex()

      if idx ~= hoverIdx then
        hoverIdx = idx
        rebuildPreview(hoverIdx)
        applyPreview(true)
      end

      updateGhost()
    end

    tickAnimations()
  end)

  local function doReset()
    local defR = (ns.GetCategoryOrderDefaults and ns.GetCategoryOrderDefaults()) or def

    local hasRT2 = false
    for i = 1, #defR do
      if defR[i] == "TRINKETS" then
        hasRT2 = true
        break
      end
    end

    if not hasRT2 then
      defR[#defR + 1] = "TRINKETS"
    end

    local gorderNew = _order_ToGroupedOrder(defR)
    gorderNew = _order_moveGroupToEnd(gorderNew, "CUSTOM_GROUP")

    for i = #gorderNew, 1, -1 do
      if gorderNew[i] == "TRINKETS_GROUP" then
        table.remove(gorderNew, i)
      end
    end

    gorder = gorderNew

    _order_SaveGroupedOrder(gorderNew)
    buildTiles()
  end

  local reset = OE.AttachResetTo(
    box,
    "BOTTOMRIGHT",
    box,
    "BOTTOMRIGHT",
    -10,
    10,
    function()
      StaticPopup_Show(POPUP_KEY, nil, nil, { doReset = doReset })
    end
  )

  reset:Show()

  box._buildTiles = function()
    buildTiles()
  end

  box._reflow = function()
    computeGeometry()
    rebuildPreview(hoverIdx)
    applyPreview(false)
  end

  buildTiles()
end