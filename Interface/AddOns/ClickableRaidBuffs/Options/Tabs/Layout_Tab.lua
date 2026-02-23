-- ====================================
-- \Options\Tabs\Layout_Tab.lua
-- ====================================

local addonName, ns = ...
ns.Options = ns.Options or {}
ns.OptionElements = ns.OptionElements or {}
ns.NumberSelect = ns.NumberSelect or {}
ns.ScrollBar = ns.ScrollBar or {}
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local O = ns.Options
local OE = ns.OptionElements









local NS = ns.NumberSelect
local SB = ns.ScrollBar

local SCROLLBAR_X_OFFSET = 0
local SCROLLBAR_WIDTH = 14
local SCROLLBAR_INSET_PAD = 5

local function DB()
  return (ns.GetDB and ns.GetDB()) or ClickableRaidBuffsDB or {}
end

local function SyncCenterColorKeys()
  local d = DB()
  if type(d) ~= "table" then
    return
  end
  local src = d.timerTextColor or d.centerTextColor
  if not src then
    return
  end
  local r, g, b, a = src.r or 1, src.g or 1, src.b or 1, (src.a ~= nil and src.a or 1)
  d.timerTextColor = { r = r, g = g, b = b, a = a }
  d.centerTextColor = { r = r, g = g, b = b, a = a }
end

local function ApplyAllFonts()
  local d = DB()
  local top = d.topSize or (O.GetDefault and O.GetDefault("topSize"))
  local bottom = d.bottomSize or (O.GetDefault and O.GetDefault("bottomSize"))
  local center = d.timerSize or (O.GetDefault and O.GetDefault("timerSize"))
  local fname = d.fontName or (O.GetDefault and O.GetDefault("fontName"))
  local topOutline = (d.topOutline ~= nil) and d.topOutline or (O.GetDefault and O.GetDefault("topOutline"))
  local bottomOutline = (d.bottomOutline ~= nil) and d.bottomOutline or (O.GetDefault and O.GetDefault("bottomOutline"))
  local timerOutline = (d.timerOutline ~= nil) and d.timerOutline or (O.GetDefault and O.GetDefault("timerOutline"))

  if ns.SetFontName then
    ns.SetFontName(fname)
  end
  if ns.SetFontSizes then
    ns.SetFontSizes(top, bottom, center)
  end
  if ns.SetFontOutlines then
    ns.SetFontOutlines(topOutline, bottomOutline, timerOutline)
  end

  if ns.RenderAll then
    ns.RenderAll()
  elseif ns.RefreshFonts then
    ns.RefreshFonts()
  end
end


local function ApplyGlowFromDB()
  if ns.RequestRebuild then
    ns.RequestRebuild()
  elseif ns.RenderAll then
    ns.RenderAll()
  elseif ns.RefreshGlow then
    ns.RefreshGlow()
  end
end


local function ApplyTextColors()
  if ns.SetTextColors then
    local d = DB()
    ns.SetTextColors(
      d.topTextColor,
      d.timerTextColor or d.centerTextColor,
      d.bottomTextColor
    )
  end

  if ns.RenderAll then
    ns.RenderAll()
  elseif ns.RefreshFonts then
    ns.RefreshFonts()
  end
end


local function ApplyAllFontsPreservingCenterColor()
  local d = DB()
  local c = d.centerTextColor or d.timerTextColor
  local r, g, b, a
  if type(c) == "table" then
    r = c.r or 1
    g = c.g or 1
    b = c.b or 1
    a = (c.a ~= nil and c.a or 1)
  end

  if r then
    d.timerTextColor = { r = r, g = g, b = b, a = a }
    d.centerTextColor = { r = r, g = g, b = b, a = a }
    if ns.RenderAll then
      ns.RenderAll()
    elseif ns.RefreshFonts then
      ns.RefreshFonts()
    end
  end

  ApplyAllFonts()
end


local function ConfirmReset(run, what)
  if O and O.ConfirmReset then
    return O.ConfirmReset(run, what)
  end
  local msg = L["Reset "] .. (what or L["setting"]) .. L[" to default?"]

  StaticPopup_Show(POPUP_KEY, msg, nil, { run = run })
end

local GLOW_CHECKBOX_YOFFSET = (O and O.GLOW_CHECKBOX_YOFFSET) or -8
local ROW_H_TOP = 90

local function HidePageHeader(content)
  local page = content and content.GetParent and content:GetParent()
  if not page then
    return
  end
  for _, reg in ipairs { page:GetRegions() } do
    if reg and reg.GetObjectType and reg:GetObjectType() == "FontString" then
      reg:Hide()
    end
  end
end







local KNOB = {
  ROW_H_TOP = 90,
  ROW_H_TOGGLES = 36,
  BTN_H = 28,
  BTN_MIN_W = 168,
  BTN_GAP = 8,
  ICON_MIN = 24,
  ICON_MAX = 128,
  ICON_STEP = 1,
  MAXROW_MIN = 1,
  MAXROW_MAX = 40,
  MAXROW_STEP = 1,
  SPACE_MIN = 0,
  SPACE_MAX = 50,
  SPACE_STEP = 1,
}
local BORDER_SEL = { 0.32, 0.80, 0.90, 1 }
local BORDER_NRM = { 0.22, 0.24, 0.30, 1 }
local BG_NRM = { 0.10, 0.11, 0.15, 1 }
local BG_SEL = { 0.14, 0.15, 0.20, 1 }
local TXT_NRM = { 0.85, 0.90, 1.00, 1 }
local TXT_SEL = { 1, 1, 1, 1 }

local function _Face()
  return (O and O.ResolvePanelFont and O.ResolvePanelFont()) or "Fonts\\FRIZQT__.TTF"
end
local function _SetFS(fs, size, flags)
  if fs and fs.SetFont then
    fs:SetFont(_Face(), size or (O.SIZE_LABEL or 14), flags or "")
  end
end

local function _NewSelButton(parent, text)
  local b = CreateFrame("Button", nil, parent, "BackdropTemplate")
  b:SetHeight(KNOB.BTN_H)
  b:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
  b:SetBackdropColor(unpack(BG_NRM))
  b:SetBackdropBorderColor(unpack(BORDER_NRM))
  b.txt = b:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  b.txt:SetPoint("CENTER")
  _SetFS(b.txt, O.SIZE_LABEL or 14, "")
  b.txt:SetText(text or "")
  function b:SetSelected(on)
    if on then
      self:SetBackdropColor(unpack(BG_SEL))
      self:SetBackdropBorderColor(unpack(BORDER_SEL))
      self.txt:SetTextColor(unpack(TXT_SEL))
    else
      self:SetBackdropColor(unpack(BG_NRM))
      self:SetBackdropBorderColor(unpack(BORDER_NRM))
      self.txt:SetTextColor(unpack(TXT_NRM))
    end
  end
  return b
end

local function _MakeButtonRow(parent, labels, onPick, getKey)
  local row = CreateFrame("Frame", nil, parent)
  row:SetAllPoints()
  local buttons, order = {}, {}

  local function visibleCount()
    local n = 0
    for i = 1, #order do
      if order[i] then
        n = n + 1
      end
    end
    return n
  end
  local function placeButtons()
    local count = visibleCount()
    if count == 0 then
      return
    end
    local w = math.max(KNOB.BTN_MIN_W, (row:GetWidth() or 480) / count - KNOB.BTN_GAP)
    local prev
    for i = 1, #order do
      local key = order[i]
      if key then
        local b = buttons[key]
        if b then
          b:SetWidth(w)
          b:ClearAllPoints()
          if not prev then
            b:SetPoint("LEFT", row, "LEFT", 0, 0)
          else
            b:SetPoint("LEFT", prev, "RIGHT", KNOB.BTN_GAP, 0)
          end
          b:Show()
          prev = b
        end
      end
    end
  end

  function row:SetLabels(newLabels)
    wipe(order)
    local present = {}
    for i = 1, #newLabels do
      local key = newLabels[i].key
      local text = newLabels[i].text
      local b = buttons[key]
      if not b then
        b = _NewSelButton(row, text)
        buttons[key] = b
      else
        b.txt:SetText(text)
      end
      local thisKey = key
      b:SetScript("OnClick", function()
        for k, ob in pairs(buttons) do
          ob:SetSelected(k == thisKey)
        end
        if onPick then
          onPick(thisKey)
        end
      end)
      b:SetSelected(false)
      b:Show()
      order[#order + 1] = key
      present[key] = true
    end
    for k, b in pairs(buttons) do
      if not present[k] then
        b:Hide()
        b:SetSelected(false)
      end
    end
    placeButtons()
    if row.Refresh then
      row:Refresh()
    end
  end

  row:HookScript("OnSizeChanged", placeButtons)
  function row:Refresh()
    local cur = getKey and getKey() or nil
    for k, b in pairs(buttons) do
      b:SetSelected(cur and (k == cur) or false)
    end
  end

  row:SetLabels(labels)
  return row
end

local function BuildLayoutSection(content, Row)
  local d = DB()
  if d.iconSize == nil then
    d.iconSize = 50
  end
  if d.maxPerRow == nil then
    d.maxPerRow = 7
  end
  if d.useMaxPerRow == nil then
    d.useMaxPerRow = false
  end
  if d.hSpace == nil then
    d.hSpace = 10
  end
  if d.vSpace == nil then
    d.vSpace = 35
  end
  if d.style == nil then
    d.style = "HORIZONTAL"
  end
  if d.alignment == nil then
    d.alignment = "CENTER"
  end
  if d.growV == nil then
    d.growV = "DOWN"
  end
  if d.growH == nil then
    d.growH = "RIGHT"
  end
  if d.gridLTR == nil then
    d.gridLTR = true
  end

  local rowA = Row(KNOB.ROW_H_TOP)
  do
    local left = CreateFrame("Frame", nil, rowA)
    left:SetPoint("LEFT")
    left:SetPoint("RIGHT", rowA, "CENTER")
    left:SetPoint("TOP")
    left:SetPoint("BOTTOM")
    local ns1 = NS.Create(left, {
      label = L["Icon Size"],

      min = KNOB.ICON_MIN,
      max = KNOB.ICON_MAX,
      step = KNOB.ICON_STEP,
      value = d.iconSize,
      default = 50,
      onChange = function(v)
        d.iconSize = v
        if ns.RequestRebuild then
          ns.RequestRebuild()
        end
      end,
    })
    ns1:SetPoint("CENTER")
  end
  do
    local right = CreateFrame("Frame", nil, rowA)
    right:SetPoint("LEFT", rowA, "CENTER")
    right:SetPoint("RIGHT")
    right:SetPoint("TOP")
    right:SetPoint("BOTTOM")
    local holder = CreateFrame("Frame", nil, right)
    holder:SetAllPoints()

    local cb = CreateFrame("CheckButton", nil, holder, "BackdropTemplate")
    cb:SetSize(20, 20)
    cb:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
    cb:SetBackdropColor(0.05, 0.06, 0.08, 1)
    cb:SetBackdropBorderColor(unpack(BORDER_NRM))
    local tick = cb:CreateTexture(nil, "ARTWORK")
    tick:SetAtlas("common-icon-checkmark", true)
    tick:SetPoint("CENTER")
    tick:SetSize(16, 16)
    tick:SetVertexColor(0.35, 0.80, 1, 1)
    cb._tick = tick

    local ns2 = NS.Create(holder, {
      label = L["Max Icons Per Tier"],

      min = KNOB.MAXROW_MIN,
      max = KNOB.MAXROW_MAX,
      step = KNOB.MAXROW_STEP,
      value = d.maxPerRow or 7,
      default = 7,
      onChange = function(v)
        d.maxPerRow = v
        d.maxPerTier = v
        if ns.RequestRebuild then
          ns.RequestRebuild()
        end
      end,
    })
    ns2:SetPoint("CENTER", holder, "CENTER", 20, 0)
    cb:SetPoint("RIGHT", ns2, "LEFT", -12, 0)

    local function applyUseMax(on)
      d.useMaxPerRow = on and true or false
      d.layoutMode = d.useMaxPerRow and "GRID" or "ROW"
      ns2:SetEnabled(d.useMaxPerRow)
      if ns.RequestRebuild then
        ns.RequestRebuild()
      end
    end

    cb:SetChecked(d.useMaxPerRow and true or false)
    cb._tick:SetShown(d.useMaxPerRow and true or false)
    cb:SetScript("OnClick", function(self)
      local on = not not self:GetChecked()
      self._tick:SetShown(on)
      applyUseMax(on)
    end)
    applyUseMax(d.useMaxPerRow)
  end

  local rowB = Row(KNOB.ROW_H_TOP)
  do
    local left = CreateFrame("Frame", nil, rowB)
    left:SetPoint("LEFT")
    left:SetPoint("RIGHT", rowB, "CENTER")
    left:SetPoint("TOP")
    left:SetPoint("BOTTOM")
    local ns3 = NS.Create(left, {
      label = L["Horizontal Spacing"],

      min = KNOB.SPACE_MIN,
      max = KNOB.SPACE_MAX,
      step = KNOB.SPACE_STEP,
      value = d.hSpace or 10,
      default = 10,
      onChange = function(v)
        d.hSpace = v
        if ns.RequestRebuild then
          ns.RequestRebuild()
        end
      end,
    })
    ns3:SetPoint("CENTER")
  end
  do
    local right = CreateFrame("Frame", nil, rowB)
    right:SetPoint("LEFT", rowB, "CENTER")
    right:SetPoint("RIGHT")
    right:SetPoint("TOP")
    right:SetPoint("BOTTOM")
    local ns4 = NS.Create(right, {
      label = L["Vertical Spacing"],

      min = KNOB.SPACE_MIN,
      max = KNOB.SPACE_MAX,
      step = KNOB.SPACE_STEP,
      value = d.vSpace or 45,
      default = 45,
      onChange = function(v)
        d.vSpace = v
        if ns.RequestRebuild then
          ns.RequestRebuild()
        end
      end,
    })
    ns4:SetPoint("CENTER")
  end

  Row(12)

  local rowStyle = Row(KNOB.ROW_H_TOGGLES)
  local styleRow = _MakeButtonRow(rowStyle, {
    { key = "HORIZONTAL", text = L["Horizontal Tiers"] },

    { key = "VERTICAL", text = L["Vertical Tiers"] },

  }, function(key)
    d.style = key
    if ns.RequestRebuild then
      ns.RequestRebuild()
    end
    if content and content.RefreshSelectors then
      content:RefreshSelectors()
    end
  end, function()
    return (DB().style or "HORIZONTAL")
  end)

  local rowAlign = Row(KNOB.ROW_H_TOGGLES)
  local alignLabelsH = {
    { key = "LEFT", text = L["Left Align"] },

    { key = "CENTER", text = L["Center Align"] },

    { key = "RIGHT", text = L["Right Align"] },

  }
local alignLabelsV = {
  { key = "LEFT", text = L["Align Top"] },
  { key = "CENTER", text = L["Align Center"] },
  { key = "RIGHT", text = L["Align Bottom"] },
}

  local alignRow = _MakeButtonRow(rowAlign, alignLabelsH, function(key)
    d.alignment = key
    if ns.RequestRebuild then
      ns.RequestRebuild()
    end
  end, function()
    return (DB().alignment or "CENTER")
  end)

  local rowGrow = Row(KNOB.ROW_H_TOGGLES)
  local growRow = _MakeButtonRow(rowGrow, {
    { key = "UP", text = L["Grow Upward"] },

    { key = "DOWN", text = L["Grow Downward"] },

  }, function(key)
    if (d.style or "HORIZONTAL") == "VERTICAL" then
      if key == "LEFT" or key == "RIGHT" then
        d.growH = key
        d.gridLTR = (key == "RIGHT")
      end
    else
      d.growV = key
      d.gridDown = (key == "DOWN")
    end
    if ns.RequestRebuild then
      ns.RequestRebuild()
    end
  end, function()
    if (DB().style or "HORIZONTAL") == "VERTICAL" then
      local gh = DB().growH
      if gh == "LEFT" or gh == "RIGHT" then
        return gh
      else
        return (DB().gridLTR == false) and "LEFT" or "RIGHT"
      end
    else
      return (DB().growV or "DOWN")
    end
  end)

  function content:RefreshSelectors()
    local curStyle = DB().style or "HORIZONTAL"
    if curStyle == "VERTICAL" then
      alignRow:SetLabels(alignLabelsV)
      growRow:SetLabels({
        { key = "UP", text = L["Grow Upward"] },
        { key = "DOWN", text = L["Grow Downward"] },
      })


    else
      alignRow:SetLabels(alignLabelsH)
      growRow:SetLabels({
        { key = "UP", text = L["Grow Upward"] },
        { key = "DOWN", text = L["Grow Downward"] },
      })
    end
    styleRow:Refresh()
    alignRow:Refresh()
    growRow:Refresh()
  end

  content:HookScript("OnShow", function()
    content:RefreshSelectors()
  end)
end


local function BuildAppearanceSection(content, Row)

  local bounds = {
    tMin = O.SIZE_TOP_MIN or 8,
    tMax = O.SIZE_TOP_MAX or 48,
    bMin = O.SIZE_BOTTOM_MIN or 8,
    bMax = O.SIZE_BOTTOM_MAX or 48,
    cMin = O.SIZE_CENTER_MIN or 8,
    cMax = O.SIZE_CENTER_MAX or 64,
  }

  local d = DB()

  local function ForceRefresh()
    if ns.RefreshFonts then
      ns.RefreshFonts()
    end
    if ns.RenderAll then
      ns.RenderAll()
    end
  end

  local rowFont = Row(72)
  OE.TripleColumn(rowFont, function(UI)

    UI:FontPicker({
      key = "fontName",
      label = L["Font"],
      col = 1,
      span = 3,
      onChange = function()
        if ns.SetFontName then
          ns.SetFontName(d.fontName)
        end
        ForceRefresh()
      end,
    })

  end)

  local rowSizes = Row(ROW_H_TOP)
  OE.TripleColumn(rowSizes, function(UI)

    local cell1 = UI:Blank({ col = 1, rowH = ROW_H_TOP })
    local ns1 = NS.Create(cell1, {
      label = L["Top Text Size"],
      min = bounds.tMin,
      max = bounds.tMax,
      step = 1,
      value = d.topSize,
      default = 12,
      onChange = function(v)
        d.topSize = v
        if ns.SetFontSizes then
          ns.SetFontSizes(d.topSize, d.bottomSize, d.timerSize)
        end
        ForceRefresh()
      end,
    })
    ns1:SetPoint("CENTER", cell1)

    local cell2 = UI:Blank({ col = 2, rowH = ROW_H_TOP })
    local ns2 = NS.Create(cell2, {
      label = L["Center Text Size"],
      min = bounds.cMin,
      max = bounds.cMax,
      step = 1,
      value = d.timerSize,
      default = 18,
      onChange = function(v)
        d.timerSize = v
        if ns.SetFontSizes then
          ns.SetFontSizes(d.topSize, d.bottomSize, d.timerSize)
        end
        ForceRefresh()
      end,
    })
    ns2:SetPoint("CENTER", cell2)

    local cell3 = UI:Blank({ col = 3, rowH = ROW_H_TOP })
    local ns3 = NS.Create(cell3, {
      label = L["Bottom Text Size"],
      min = bounds.bMin,
      max = bounds.bMax,
      step = 1,
      value = d.bottomSize,
      default = 12,
      onChange = function(v)
        d.bottomSize = v
        if ns.SetFontSizes then
          ns.SetFontSizes(d.topSize, d.bottomSize, d.timerSize)
        end
        ForceRefresh()
      end,
    })
    ns3:SetPoint("CENTER", cell3)

  end)

  local rowColors = Row(ROW_H_TOP)
  OE.TripleColumn(rowColors, function(UI)

    UI:TextColor({
      colorKey = "topTextColor",
      label = L["Top Text Color"],
      which = "top",
      col = 1,
      onChange = ForceRefresh,
    })

    UI:TextColor({
      colorKey = "timerTextColor",
      label = L["Center Text Color"],
      which = "center",
      col = 2,
      onChange = ForceRefresh,
    })

    UI:TextColor({
      colorKey = "bottomTextColor",
      label = L["Bottom Text Color"],
      which = "bottom",
      col = 3,
      onChange = ForceRefresh,
    })

  end)

end




local function BuildGlowSection(content, Row)

  local d = DB()

  local rowMain = Row(80)

  OE.TripleColumn(rowMain, function(UI)

    UI:Checkbox({
      key = "glowEnabled",
      label = L["Enable Icon Glow"],
      col = 1,
      onChange = ApplyGlowFromDB,
    })

    UI:TextColor({
      colorKey = "glowColor",
      label = L["General Glow Color"],
      col = 2,
      onChange = ApplyGlowFromDB,
    })

    UI:TextColor({
      colorKey = "specialGlowColor",
      label = L["Special Glow Color"],
      col = 3,
      onChange = ApplyGlowFromDB,
    })

  end)

  local rowStyle = Row(40)

  local styleRow = _MakeButtonRow(rowStyle, {
    { key = "PIXEL", text = L["Pixel Glow"] },
    { key = "AUTOCAST", text = L["AutoCast Glow"] },
    { key = "BUTTON", text = L["Button Glow"] },
  },
  function(key)
    d.glowStyle = key
    ApplyGlowFromDB()
  end,
  function()
    return d.glowStyle or "PIXEL"
  end)

  styleRow:SetPoint("TOPLEFT", rowStyle, "TOPLEFT", 0, 0)
  styleRow:SetPoint("BOTTOMRIGHT", rowStyle, "BOTTOMRIGHT", 0, 0)

end




function OE.ScrollContainer(parent)

  local scroll = CreateFrame("ScrollFrame", nil, parent)
  scroll:SetAllPoints()

  local inner = CreateFrame("Frame", nil, scroll)
  inner:SetPoint("TOPLEFT")
  inner:SetSize(1, 1)
  scroll:SetScrollChild(inner)

  local rows = {}
  local VSPACE = (O and O.ROW_V_GAP) or 10

  local function Relayout()
    local y = 0
    local w = (scroll:GetWidth() or parent:GetWidth() or 600)
    inner:SetWidth(w)
    for i = 1, #rows do
      local f = rows[i]
      f:ClearAllPoints()
      f:SetPoint("TOPLEFT", inner, "TOPLEFT", 0, -y)
      f:SetPoint("TOPRIGHT", inner, "TOPRIGHT", 0, -y)
      y = y + (f:GetHeight() or 0) + VSPACE
    end
    inner:SetHeight(math.max(y, 1))
  end

  local function Row(h)
    local f = CreateFrame("Frame", nil, inner)
    f:SetHeight(h or 0)
    f:HookScript("OnSizeChanged", Relayout)
    rows[#rows + 1] = f
    Relayout()
    return f
  end

  scroll:HookScript("OnSizeChanged", Relayout)

  return {
    scroll = scroll,
    inner = inner,
    Row = Row,
  }
end

O.RegisterSection(function(AddSection)

  AddSection(ns.LayoutTabName, function(content, Row)

    HidePageHeader(content)
    SyncCenterColorKeys()

    local row = Row(385)

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
      cardBR = { 0.20, 0.22, 0.28, 1.00 },
      wellBG = { 0.08, 0.09, 0.12, 1.00 },
      wellBR = { 0.20, 0.22, 0.28, 1.00 },
      rowBG = { 0.10, 0.115, 0.16, 1.00 },
      rowBR = { 0.20, 0.22, 0.28, 1.00 },
      tabH = 24,
      tabGap = 6,
      cardSidePad = 6,
    }

    local function PaintBackdrop(frame, bg, br)
      frame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
      })
      frame:SetBackdropColor(unpack(bg))
      frame:SetBackdropBorderColor(unpack(br))
    end

    local function MakeMiniTab(parent, label)
      local b = CreateFrame("Button", nil, parent, "BackdropTemplate")
      PaintBackdrop(b, THEME.rowBG, THEME.rowBR)
      b:SetHeight(THEME.tabH)

      local fs = b:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
      fs:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
      fs:SetPoint("CENTER")
      fs:SetText(label or "")
      b._fs = fs

      b:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(0.45, 0.85, 1, 1)
      end)

      b:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(unpack(THEME.rowBR))
      end)

      return b
    end

    local function StyleTabSelected(b)
      b:SetBackdropColor(0.14, 0.18, 0.24, 1)
      b:SetBackdropBorderColor(0.35, 0.60, 1.0, 1)
    end

    local function StyleTabNormal(b)
      b:SetBackdropColor(unpack(THEME.rowBG))
      b:SetBackdropBorderColor(unpack(THEME.rowBR))
    end

    local card = CreateFrame("Frame", nil, row, "BackdropTemplate")
    PaintBackdrop(card, THEME.cardBG, THEME.cardBR)
    card:SetPoint("TOPLEFT", 0, -8)
    card:SetPoint("BOTTOMRIGHT", 0, 0)

    local tabsArea = CreateFrame("Frame", nil, card)
    tabsArea:SetPoint("TOPLEFT", THEME.cardSidePad, -12)
    tabsArea:SetPoint("TOPRIGHT", -THEME.cardSidePad, -12)
    tabsArea:SetHeight(THEME.tabH)

    local inner = CreateFrame("Frame", nil, card, "BackdropTemplate")
    inner:SetPoint("TOPLEFT", tabsArea, "BOTTOMLEFT", 0, -6)
    inner:SetPoint("BOTTOMRIGHT", -THEME.cardSidePad, 6)
    PaintBackdrop(inner, THEME.wellBG, THEME.wellBR)

    local SIDE_PAD = 10
    local TOP_PAD = 8
    local BAR_WIDTH = 16
    local RIGHT_GAP = 8

    local scroll = CreateFrame("ScrollFrame", nil, inner)
    scroll:SetPoint("TOPLEFT", inner, "TOPLEFT", SIDE_PAD, -TOP_PAD)
    scroll:SetPoint("BOTTOMRIGHT", inner, "BOTTOMRIGHT", -(SIDE_PAD + BAR_WIDTH + RIGHT_GAP), SIDE_PAD)

    local contentFrame = CreateFrame("Frame", nil, scroll)
    contentFrame:SetSize(1, 1)
    scroll:SetScrollChild(contentFrame)

    local bar = ns.ScrollBar.Create(inner, {
      width = BAR_WIDTH,
      sliderWidth = BAR_WIDTH - 2,
      minThumbH = 24
    })
    bar:SetPoint("TOPRIGHT", inner, "TOPRIGHT", -SIDE_PAD, -TOP_PAD)
    bar:SetPoint("BOTTOMRIGHT", inner, "BOTTOMRIGHT", -SIDE_PAD, SIDE_PAD)
    bar:BindToScroll(scroll, contentFrame)

    local function ResetScroll()
      scroll:SetVerticalScroll(0)
      bar:SetValue(0)
      scroll:UpdateScrollChildRect()
      bar:UpdateThumb(scroll:GetHeight(), contentFrame:GetHeight())
    end

    local function CreateScrollLayout()
      local rows = {}
      local VSPACE = (O and O.ROW_V_GAP) or 10

      local function Relayout()
        local y = 0
        local w = scroll:GetWidth() or 600
        contentFrame:SetWidth(w)
        for i = 1, #rows do
          local f = rows[i]
          f:ClearAllPoints()
          f:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, -y)
          f:SetPoint("TOPRIGHT", contentFrame, "TOPRIGHT", 0, -y)
          y = y + (f:GetHeight() or 0) + VSPACE
        end
        contentFrame:SetHeight(math.max(y, 1))
        bar:UpdateThumb(scroll:GetHeight(), contentFrame:GetHeight())
      end

      local function RowFunc(h)
        local f = CreateFrame("Frame", nil, contentFrame)
        f:SetHeight(h or 0)
        f:HookScript("OnSizeChanged", Relayout)
        rows[#rows + 1] = f
        Relayout()
        return f
      end

      scroll:HookScript("OnSizeChanged", Relayout)

      return RowFunc
    end

    local orderBtn      = MakeMiniTab(tabsArea, L["Order"])
    local layoutBtn     = MakeMiniTab(tabsArea, L["Icons"])
    local appearanceBtn = MakeMiniTab(tabsArea, L["Text"])
    local glowBtn       = MakeMiniTab(tabsArea, L["Glow"])

    local function LayoutTabs()
      local totalWidth = tabsArea:GetWidth()
      if not totalWidth or totalWidth <= 0 then return end

      local gap = THEME.tabGap
      local count = 4
      local w = (totalWidth - (gap * (count - 1))) / count

      orderBtn:ClearAllPoints()
      layoutBtn:ClearAllPoints()
      appearanceBtn:ClearAllPoints()
      glowBtn:ClearAllPoints()

      orderBtn:SetPoint("LEFT", tabsArea, "LEFT", 0, 0)
      orderBtn:SetWidth(w)

      layoutBtn:SetPoint("LEFT", orderBtn, "RIGHT", gap, 0)
      layoutBtn:SetWidth(w)

      appearanceBtn:SetPoint("LEFT", layoutBtn, "RIGHT", gap, 0)
      appearanceBtn:SetWidth(w)

      glowBtn:SetPoint("LEFT", appearanceBtn, "RIGHT", gap, 0)
      glowBtn:SetWidth(w)
    end

    tabsArea:HookScript("OnSizeChanged", LayoutTabs)
    C_Timer.After(0, LayoutTabs)

    local function SelectTab(key)

      StyleTabNormal(orderBtn)
      StyleTabNormal(layoutBtn)
      StyleTabNormal(appearanceBtn)
      StyleTabNormal(glowBtn)

      if key == "ORDER" then StyleTabSelected(orderBtn) end
      if key == "LAYOUT" then StyleTabSelected(layoutBtn) end
      if key == "APPEARANCE" then StyleTabSelected(appearanceBtn) end
      if key == "GLOW" then StyleTabSelected(glowBtn) end

      contentFrame:Hide()
      contentFrame = CreateFrame("Frame", nil, scroll)
      contentFrame:SetSize(1,1)
      scroll:SetScrollChild(contentFrame)

      local RowFunc = CreateScrollLayout()

      if key == "ORDER" then
        ns.Options.OrderGrid.Build(contentFrame, RowFunc)
      elseif key == "LAYOUT" then
        BuildLayoutSection(contentFrame, RowFunc)
      elseif key == "APPEARANCE" then
        BuildAppearanceSection(contentFrame, RowFunc)
      elseif key == "GLOW" then
        BuildGlowSection(contentFrame, RowFunc)
      end

      ResetScroll()
    end

    orderBtn:SetScript("OnClick", function() SelectTab("ORDER") end)
    layoutBtn:SetScript("OnClick", function() SelectTab("LAYOUT") end)
    appearanceBtn:SetScript("OnClick", function() SelectTab("APPEARANCE") end)
    glowBtn:SetScript("OnClick", function() SelectTab("GLOW") end)

    card:SetScript("OnShow", function()
      SelectTab("ORDER")
    end)

  end)

end)
