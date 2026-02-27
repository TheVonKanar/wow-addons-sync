-- ====================================
-- \Options\Tabs\CustomSpells.lua
-- ====================================

local addonName, ns = ...
ns.Options = ns.Options or {}
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
  rowSelectedBR = { 0.22, 0.58, 0.92, 1 },
  tickTint = { 0.35, 0.80, 1.00, 1 },
}

local POPUP_DELETE_KEY = "CRB_CONFIRM_DELETE_CUSTOM_SPELL"
if not StaticPopupDialogs[POPUP_DELETE_KEY] then
  StaticPopupDialogs[POPUP_DELETE_KEY] = {
    text = DELETE .. " %s?",
    button1 = YES,
    button2 = NO,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
      if data and type(data.run) == "function" then
        data.run()
      end
    end,
  }
end

local function PaintBackdrop(frame, bg, br)
  frame:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
  frame:SetBackdropColor(unpack(bg))
  frame:SetBackdropBorderColor(unpack(br))
end

local function DB()
  local d = (ns.GetDB and ns.GetDB()) or _G.ClickableRaidBuffsDB or {}
  d.customSpells = d.customSpells or {}
  return d
end

local function Notify(immediate)
  if type(ns.CustomSpells_RebuildDisplayables) == "function" then
    ns.CustomSpells_RebuildDisplayables()
  end
  if ns.RequestRebuild then
    ns.RequestRebuild()
  end
  if ns.MarkAurasDirty then
    ns.MarkAurasDirty("player")
  end
  if immediate and ns.PokeUpdateBusImmediate then
    ns.PokeUpdateBusImmediate()
  elseif ns.PokeUpdateBus then
    ns.PokeUpdateBus()
  elseif ns.RenderAll then
    ns.RenderAll()
  end
  if immediate and ns.PushRender then
    ns.PushRender()
  end
end

local function NewCheckbox(parent, initial, onToggle)
  local cb = CreateFrame("CheckButton", nil, parent, "BackdropTemplate")
  cb:SetSize(20, 20)
  PaintBackdrop(cb, THEME.wellBG, THEME.wellBR)

  local tick = cb:CreateTexture(nil, "ARTWORK")
  tick:SetAtlas("common-icon-checkmark", true)
  tick:SetPoint("CENTER")
  tick:SetSize(16, 16)
  tick:SetVertexColor(unpack(THEME.tickTint))
  tick:Hide()
  cb._tick = tick

  local rawSetChecked = getmetatable(cb).__index.SetChecked
  function cb:SetChecked(state)
    rawSetChecked(self, state and true or false)
    self._tick:SetShown(state and true or false)
  end

  cb:SetScript("OnClick", function(self)
    local v = self:GetChecked()
    self._tick:SetShown(v)
    if onToggle then
      onToggle(self, v)
    end
  end)

  cb:SetChecked(initial and true or false)
  return cb
end

local function MakeCheckbox(parent, label)
  local cb = CreateFrame("CheckButton", nil, parent, "BackdropTemplate")
  PaintBackdrop(cb, THEME.wellBG, THEME.wellBR)
  cb:SetSize(18, 18)

  local tick = cb:CreateTexture(nil, "ARTWORK")
  tick:SetAtlas("common-icon-checkmark", true)
  tick:SetSize(14, 14)
  tick:SetPoint("CENTER")
  tick:SetVertexColor(unpack(THEME.tickTint))
  tick:Hide()
  cb._tick = tick

  local rawSetChecked = getmetatable(cb).__index.SetChecked
  function cb:SetChecked(state)
    rawSetChecked(self, state and true or false)
    self._tick:SetShown(state and true or false)
  end

  cb:SetScript("OnClick", function(self)
    self._tick:SetShown(self:GetChecked())
  end)

  local txt = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  txt:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
  txt:SetText(label)

  return cb, txt
end

local function GetSpellName(id)
  if not id or not C_Spell then
    return nil
  end
  local info = C_Spell.GetSpellInfo(id)
  return info and info.name
end

local function GetItemName(id)
  if not id or not C_Item then
    return nil
  end
  local info = C_Item.GetItemInfo(id)
  if type(info) == "table" then
    return info.itemName
  end
  return info
end

local function BuildShowText(gates)
  local has = {}
  if type(gates) == "table" then
    for i = 1, #gates do
      has[gates[i]] = true
    end
  end
  if has.evenRested then
    return L["Always"]
  end
  local bits = {}
  if has.instance then
    bits[#bits + 1] = L["Only in Instances"]
  end
  if has.group then
    bits[#bits + 1] = L["Only in Groups"]
  end
  if has.instance and has.group then
    return L["Only in Instances when in a Group"] or "Only in Instances when in a Group"
  end
  if #bits == 0 then
    return L["None"] or "None"
  end
  return table.concat(bits, " • ")
end

local function ResolveDisplayIcon(data)
  local tex = tonumber(data.icon)
  if tex then
    return tex
  end
  if (data.type == "item" or (data.type == "weaponEnchant" and data.useKind == "item")) and C_Item then
    return select(5, C_Item.GetItemInfoInstant(data.useID))
  end
  if C_Spell then
    local info = C_Spell.GetSpellInfo(data.useID)
    return info and info.iconID
  end
  return nil
end

local function TooltipsEnabled()
  local d = DB()
  local tt = d.tooltips
  if type(tt) == "table" then
    return tt.enabled ~= false
  end
  return tt ~= false
end

O.RegisterSection(function(AddSection)
  AddSection((L["Custom Buffs"] or L["Custom Spells"]), function(content, Row)
    local row = Row()
    row:SetPoint("BOTTOMLEFT", content, "BOTTOMLEFT", 0, 0)
    row:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)

    local card = CreateFrame("Frame", nil, row, "BackdropTemplate")
    PaintBackdrop(card, THEME.cardBG, THEME.cardBR)
    card:SetPoint("TOPLEFT", 0, -8)
    card:SetPoint("BOTTOMRIGHT", 0, 0)

    local inner = CreateFrame("Frame", nil, card, "BackdropTemplate")
    inner:SetPoint("TOPLEFT", card, "TOPLEFT", 8, -12)
    inner:SetPoint("TOPRIGHT", card, "TOPRIGHT", -8, -12)
    inner:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 8, 8)
    inner:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -8, 8)
    PaintBackdrop(inner, THEME.wellBG, THEME.wellBR)

    local toolbar = CreateFrame("Frame", nil, inner, "BackdropTemplate")
    PaintBackdrop(toolbar, THEME.cardBG, THEME.cardBR)
    toolbar:SetPoint("TOPLEFT", inner, "TOPLEFT", 10, -10)
    toolbar:SetPoint("TOPRIGHT", inner, "TOPRIGHT", -10, -10)
    toolbar:SetHeight(40)

    local addBtn = CreateFrame("Button", nil, toolbar, "BackdropTemplate")
    PaintBackdrop(addBtn, THEME.rowBG, THEME.rowBR)
    addBtn:SetHeight(24)
    addBtn:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 10, -8)
    local addTxt = addBtn:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    addTxt:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    addTxt:SetPoint("CENTER")
    addTxt:SetText(L["Add Custom Spell or Item"] or ADD)
    do
      local w = math.ceil((addTxt:GetUnboundedStringWidth() or 110) + 20)
      addBtn:SetWidth(math.max(110, w))
    end

    local listCard = CreateFrame("Frame", nil, inner, "BackdropTemplate")
    PaintBackdrop(listCard, THEME.cardBG, THEME.cardBR)
    listCard:SetPoint("TOPLEFT", toolbar, "BOTTOMLEFT", 0, -8)
    listCard:SetPoint("TOPRIGHT", inner, "TOPRIGHT", -10, -8)
    listCard:SetPoint("BOTTOMLEFT", inner, "BOTTOMLEFT", 10, 10)
    listCard:SetPoint("BOTTOMRIGHT", inner, "BOTTOMRIGHT", -10, 10)

    local scroll = CreateFrame("ScrollFrame", nil, listCard, "BackdropTemplate")
    scroll:SetPoint("TOPLEFT", listCard, "TOPLEFT", 8, -8)
    scroll:SetPoint("BOTTOMRIGHT", listCard, "BOTTOMRIGHT", -20, 8)

    local contentFrame = CreateFrame("Frame", nil, scroll)
    scroll:SetScrollChild(contentFrame)

    local bar = ns.ScrollBar.Create(listCard, { width = 16, sliderWidth = 14, minThumbH = 24 })
    bar:SetPoint("TOPRIGHT", listCard, "TOPRIGHT", -4, -8)
    bar:SetPoint("BOTTOMRIGHT", listCard, "BOTTOMRIGHT", -4, 8)
    bar:BindToScroll(scroll, contentFrame)

    local popup = CreateFrame("Frame", addonName .. "CustomSpellEditor", UIParent, "BackdropTemplate")
    popup:SetFrameStrata("FULLSCREEN_DIALOG")
    popup:SetFrameLevel(300)
    popup:SetToplevel(true)
    popup:SetClampedToScreen(true)
    popup:EnableMouse(true)
    popup:SetMovable(true)
    popup:SetSize(700, 560)
    PaintBackdrop(popup, THEME.cardBG, THEME.cardBR)
    popup:Hide()

    local drag = CreateFrame("Frame", nil, popup)
    drag:SetPoint("TOPLEFT", popup, "TOPLEFT", 8, -8)
    drag:SetPoint("TOPRIGHT", popup, "TOPRIGHT", -34, -8)
    drag:SetHeight(24)
    drag:EnableMouse(true)
    drag:RegisterForDrag("LeftButton")
    drag:SetScript("OnDragStart", function()
      popup:StartMoving()
    end)
    drag:SetScript("OnDragStop", function()
      popup:StopMovingOrSizing()
    end)

    local closeBtn = CreateFrame("Button", nil, popup, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", popup, "TOPRIGHT", -4, -4)

    local popupTitle = popup:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    popupTitle:SetFont(THEME.fontPath(), 18, "")
    popupTitle:SetPoint("TOPLEFT", popup, "TOPLEFT", 14, -14)

    local form = CreateFrame("Frame", nil, popup, "BackdropTemplate")
    PaintBackdrop(form, THEME.wellBG, THEME.wellBR)
    form:SetPoint("TOPLEFT", popup, "TOPLEFT", 10, -40)
    form:SetPoint("BOTTOMRIGHT", popup, "BOTTOMRIGHT", -10, 10)

    local function ShowEditorPopup()
      popup:ClearAllPoints()
      if ns.OptionsFrame and ns.OptionsFrame:IsShown() then
        popup:SetPoint("CENTER", ns.OptionsFrame, "CENTER", 0, 0)
      else
        popup:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
      end
      popup:Show()
    end

    local function MakeLabeledBox(parent, labelText, width)
      local holder = CreateFrame("Frame", nil, parent)
      holder:SetSize(width, 52)

      local label = holder:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
      label:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
      label:SetText(labelText)
      label:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, 0)

      local box = CreateFrame("EditBox", nil, holder, "BackdropTemplate")
      PaintBackdrop(box, THEME.wellBG, THEME.wellBR)
      box:SetSize(width, 24)
      box:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
      box:SetTextInsets(6, 6, 4, 4)
      box:SetAutoFocus(false)
      box:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -6)
      holder._label = label
      return holder, box
    end

    local typeLabel = form:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    typeLabel:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    typeLabel:SetText(L["Type"])
    typeLabel:SetPoint("TOPLEFT", form, "TOPLEFT", 14, -14)

    local spellCB, spellTxt = MakeCheckbox(form, L["Spell"])
    spellCB:SetPoint("LEFT", typeLabel, "RIGHT", 12, 0)
    spellTxt:SetPoint("LEFT", spellCB, "RIGHT", 6, 0)

    local itemCB, itemTxt = MakeCheckbox(form, L["Item"])
    itemCB:SetPoint("LEFT", spellTxt, "RIGHT", 24, 0)
    itemTxt:SetPoint("LEFT", itemCB, "RIGHT", 6, 0)

    local weCB, weTxt = MakeCheckbox(form, (L["Weapon Enchant"] or "Weapon Enchant"))
    weCB:SetPoint("LEFT", itemTxt, "RIGHT", 24, 0)
    weTxt:SetPoint("LEFT", weCB, "RIGHT", 6, 0)

    local buffHolder, buffBox = MakeLabeledBox(form, L["Buff ID"], 170)
    buffHolder:SetPoint("TOPLEFT", typeLabel, "BOTTOMLEFT", 0, -16)
    buffBox:SetNumeric(true)

    local useHolder, useBox = MakeLabeledBox(form, L["Spell or Item to Use"], 220)
    useHolder:SetPoint("LEFT", buffHolder, "RIGHT", 16, 0)
    useBox:SetNumeric(true)

    local weUseSpellCB, weUseSpellTxt = MakeCheckbox(form, (L["Use Weapon Enchant Spell"] or "Use Weapon Enchant Spell"))
    weUseSpellCB:SetPoint("TOPLEFT", useHolder, "BOTTOMLEFT", 0, -8)
    weUseSpellTxt:SetPoint("LEFT", weUseSpellCB, "RIGHT", 6, 0)

    local weUseItemCB, weUseItemTxt = MakeCheckbox(form, (L["Use Weapon Enchant Item"] or "Use Weapon Enchant Item"))
    weUseItemCB:SetPoint("LEFT", weUseSpellTxt, "RIGHT", 16, 0)
    weUseItemTxt:SetPoint("LEFT", weUseItemCB, "RIGHT", 6, 0)

    local weMainCB, weMainTxt = MakeCheckbox(form, (L["Main Hand"] or "Main Hand"))
    weMainCB:SetPoint("TOPLEFT", weUseSpellCB, "BOTTOMLEFT", 0, -6)
    weMainTxt:SetPoint("LEFT", weMainCB, "RIGHT", 6, 0)

    local weOffCB, weOffTxt = MakeCheckbox(form, (L["Off Hand"] or "Off Hand"))
    weOffCB:SetPoint("LEFT", weMainTxt, "RIGHT", 16, 0)
    weOffTxt:SetPoint("LEFT", weOffCB, "RIGHT", 6, 0)

    local function selectedType()
      if weCB:GetChecked() then
        return "weaponEnchant"
      end
      if itemCB:GetChecked() then
        return "item"
      end
      return "spell"
    end

    local weSource = "spell"
    local weHand = "main"

    local function setWESource(k)
      local v = (k == "item") and "item" or "spell"
      weSource = v
      weUseSpellCB:SetChecked(v ~= "item")
      weUseSpellCB._tick:SetShown(v ~= "item")
      weUseItemCB:SetChecked(v == "item")
      weUseItemCB._tick:SetShown(v == "item")
    end

    local function getWESource()
      return weSource
    end

    local function setWEHand(k)
      local v = (k == "off") and "off" or "main"
      weHand = v
      weMainCB:SetChecked(v ~= "off")
      weMainCB._tick:SetShown(v ~= "off")
      weOffCB:SetChecked(v == "off")
      weOffCB._tick:SetShown(v == "off")
    end

    local function getWEHand()
      return weHand
    end

    local labelHolder, labelBox

    local function updateTypeUI()
      local t = selectedType()
      local isWE = (t == "weaponEnchant")
      if useHolder and useHolder._label then
        if t == "item" then
          useHolder._label:SetText(L["Item ID to Use"] or "Item ID to Use")
        elseif t == "weaponEnchant" then
          useHolder._label:SetText(L["Spell or Item to Use"])
        else
          useHolder._label:SetText(L["Spell ID to Cast"] or "Spell ID to Cast")
        end
      end
      buffHolder:SetShown(not isWE)
      if isWE then
        useHolder:ClearAllPoints()
        useHolder:SetPoint("TOPLEFT", typeLabel, "BOTTOMLEFT", 0, -16)
      else
        useHolder:ClearAllPoints()
        useHolder:SetPoint("LEFT", buffHolder, "RIGHT", 16, 0)
      end
      weUseSpellCB:SetShown(isWE)
      weUseSpellTxt:SetShown(isWE)
      weUseItemCB:SetShown(isWE)
      weUseItemTxt:SetShown(isWE)
      weMainCB:SetShown(isWE)
      weMainTxt:SetShown(isWE)
      weOffCB:SetShown(isWE)
      weOffTxt:SetShown(isWE)

      if labelHolder then
        labelHolder:ClearAllPoints()
        if isWE then
          labelHolder:SetPoint("TOPLEFT", weMainCB, "BOTTOMLEFT", 0, -24)
        else
          labelHolder:SetPoint("TOPLEFT", buffHolder, "BOTTOMLEFT", 0, -24)
        end
      end
    end

    local function setType(t)
      spellCB:SetChecked(t == "spell")
      spellCB._tick:SetShown(t == "spell")
      itemCB:SetChecked(t == "item")
      itemCB._tick:SetShown(t == "item")
      weCB:SetChecked(t == "weaponEnchant")
      weCB._tick:SetShown(t == "weaponEnchant")
      updateTypeUI()
    end

    spellCB:SetScript("OnClick", function() setType("spell") end)
    itemCB:SetScript("OnClick", function() setType("item") end)
    weCB:SetScript("OnClick", function() setType("weaponEnchant") end)
    weUseSpellCB:SetScript("OnClick", function() setWESource("spell") end)
    weUseItemCB:SetScript("OnClick", function() setWESource("item") end)
    weMainCB:SetScript("OnClick", function() setWEHand("main") end)
    weOffCB:SetScript("OnClick", function() setWEHand("off") end)

    setType("spell")
    setWESource("spell")
    setWEHand("main")

    local iconHolder, iconBox = MakeLabeledBox(form, (L["Icon ID"] or "Icon ID"), 150)
    iconHolder:SetPoint("LEFT", useHolder, "RIGHT", 16, 0)
    iconBox:SetNumeric(true)

    labelHolder, labelBox = MakeLabeledBox(form, (L["Icon Label"] or "Icon Label"), 260)
    labelHolder:SetPoint("TOPLEFT", buffHolder, "BOTTOMLEFT", 0, -24)
    updateTypeUI()

    local showLabel = form:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    showLabel:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    showLabel:SetText((L["Show"] or "Show") .. ":")
    showLabel:SetPoint("TOPLEFT", labelHolder, "BOTTOMLEFT", 0, -12)

    local alwaysCB, alwaysTxt = MakeCheckbox(form, L["Always"])
    alwaysCB:SetPoint("TOPLEFT", showLabel, "BOTTOMLEFT", 0, -8)
    alwaysTxt:SetPoint("LEFT", alwaysCB, "RIGHT", 6, 0)

    local instCB, instTxt = MakeCheckbox(form, L["Only in Instances"])
    instCB:SetPoint("TOPLEFT", alwaysCB, "BOTTOMLEFT", 0, -6)
    instTxt:SetPoint("LEFT", instCB, "RIGHT", 6, 0)

    local groupCB, groupTxt = MakeCheckbox(form, L["Only in Groups"])
    groupCB:SetPoint("TOPLEFT", instCB, "BOTTOMLEFT", 0, -6)
    groupTxt:SetPoint("LEFT", groupCB, "RIGHT", 6, 0)

    local glowLabel = form:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    glowLabel:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    glowLabel:SetText(L["Glow Color"])
    glowLabel:SetPoint("TOPLEFT", groupCB, "BOTTOMLEFT", 0, -14)

    local glowGeneralCB, glowGeneralTxt = MakeCheckbox(form, L["General"])
    glowGeneralCB:SetPoint("LEFT", glowLabel, "RIGHT", 12, 0)
    glowGeneralTxt:SetPoint("LEFT", glowGeneralCB, "RIGHT", 6, 0)

    local glowSpecialCB, glowSpecialTxt = MakeCheckbox(form, L["Special"])
    glowSpecialCB:SetPoint("LEFT", glowGeneralTxt, "RIGHT", 22, 0)
    glowSpecialTxt:SetPoint("LEFT", glowSpecialCB, "RIGHT", 6, 0)

    local thresholdWrap = CreateFrame("Frame", nil, form)
    thresholdWrap:SetPoint("TOPLEFT", glowLabel, "BOTTOMLEFT", 0, -10)
    thresholdWrap:SetSize(260, 84)

    local thresholdHolder = NS and NS.Create and NS.Create(thresholdWrap, {
      label = (L["Time"] or "Time") .. ":",
      min = 0,
      max = 120,
      step = 0.5,
      value = 15,
      default = 15,
      onChange = function() end,
    })
    if thresholdHolder then
      thresholdHolder:SetPoint("LEFT", thresholdWrap, "LEFT", 0, 0)
      thresholdHolder:SetValue(15)
    end

    local saveBtn = CreateFrame("Button", nil, form, "BackdropTemplate")
    PaintBackdrop(saveBtn, THEME.rowBG, THEME.rowBR)
    saveBtn:SetSize(120, 24)
    saveBtn:SetPoint("BOTTOMRIGHT", form, "BOTTOMRIGHT", -12, 12)
    local saveTxt = saveBtn:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    saveTxt:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    saveTxt:SetPoint("CENTER")
    saveTxt:SetText(SAVE)

    local clearBtn = CreateFrame("Button", nil, form, "BackdropTemplate")
    PaintBackdrop(clearBtn, THEME.rowBG, THEME.rowBR)
    clearBtn:SetSize(120, 24)
    clearBtn:SetPoint("RIGHT", saveBtn, "LEFT", -8, 0)
    local clearTxt = clearBtn:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    clearTxt:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    clearTxt:SetPoint("CENTER")


    local editingId
    local clearForm

    popup:SetScript("OnHide", function()
      clearForm()
    end)

    local function sortedEntries()
      local d = DB()
      local src = (ns.CustomSpells_GetAll and ns.CustomSpells_GetAll()) or d.customSpells or {}
      local out = {}
      for i = 1, #src do
        out[#out + 1] = src[i]
      end
      table.sort(out, function(a, b)
        if a.type ~= b.type then
          return tostring(a.type) < tostring(b.type)
        end
        if a.useID ~= b.useID then
          return (a.useID or 0) < (b.useID or 0)
        end
        return (a.buffID or 0) < (b.buffID or 0)
      end)
      return out
    end

    local function refreshScrollMetrics()
      contentFrame:SetWidth(math.max(1, scroll:GetWidth() or 1))
      C_Timer.After(0, function()
        local max = math.max(0, scroll:GetVerticalScrollRange())
        bar:SetMinMaxValues(0, max)
        bar:UpdateThumb(scroll:GetHeight(), contentFrame:GetHeight())
        bar:SetEnabledState(max > 0)
      end)
    end

    local function setShowMode(gates)
      local has = {}
      if type(gates) == "table" then
        for i = 1, #gates do
          if gates[i] then
            has[gates[i]] = true
          end
        end
      end

      local always = has.evenRested and true or false
      local inst = (not always) and (has.instance and true or false)
      local grouped = (not always) and (has.group and true or false)

      alwaysCB:SetChecked(always)
      instCB:SetChecked(inst)
      groupCB:SetChecked(grouped)

      local disableOthers = always
      instCB:SetEnabled(not disableOthers)
      groupCB:SetEnabled(not disableOthers)
      instTxt:SetAlpha(disableOthers and 0.45 or 1)
      groupTxt:SetAlpha(disableOthers and 0.45 or 1)
      if disableOthers then
        instCB:SetChecked(false)
        groupCB:SetChecked(false)
      end
    end

    local function setGlowMode(mode)
      glowGeneralCB:SetChecked(mode ~= "special")
      glowSpecialCB:SetChecked(mode == "special")
    end

    local function setMode(isEdit)
      clearTxt:SetText(isEdit and CANCEL or (L["Clear"] or "Clear"))
      popupTitle:SetText(isEdit and (L["Edit Custom Entry"] or L["Edit Custom Spell"] or "Edit Custom Entry") or (L["New Custom Entry"] or L["New Custom Spell"] or "New Custom Entry"))
    end

    clearForm = function()
      buffBox:SetText("")
      useBox:SetText("")
      iconBox:SetText("")
      labelBox:SetText("")
      setType("spell")
      setWESource("spell")
      setWEHand("main")
      setShowMode(nil)
      setGlowMode("general")
      if thresholdHolder and thresholdHolder.SetValue then
        thresholdHolder:SetValue(15)
      end
      editingId = nil
      setMode(false)
    end

    local function getFormData()
      local useID = tonumber(useBox:GetText())
      local kind = selectedType()
      local buffID = tonumber(buffBox:GetText())
      if not useID or useID <= 0 then
        return nil
      end
      if kind ~= "weaponEnchant" and (not buffID or buffID <= 0) then
        return nil
      end

      local thresholdMinutes
      if thresholdHolder and thresholdHolder.GetValue then
        thresholdMinutes = tonumber(thresholdHolder:GetValue())
      end

      local useKind, hand
      if kind == "weaponEnchant" then
        useKind = getWESource()
        hand = getWEHand()
      end

      return {
        type = kind,
        useID = useID,
        buffID = buffID,
        useKind = useKind,
        hand = hand,
        icon = tonumber(iconBox:GetText()),
        gates = (function()
          local g = {}
          if alwaysCB:GetChecked() then
            g[#g + 1] = "evenRested"
            return g
          end
          if instCB:GetChecked() then g[#g + 1] = "instance" end
          if groupCB:GetChecked() then g[#g + 1] = "group" end
          return g
        end)(),
        label = labelBox:GetText() or "",
        glow = glowSpecialCB:GetChecked() and "special" or "general",
        thresholdMinutes = thresholdMinutes,
      }
    end

    local function setFormFromEntry(e)
      if not e then
        return
      end
      buffBox:SetText(tostring(e.buffID or ""))
      useBox:SetText(tostring(e.useID or ""))
      iconBox:SetText(e.icon and tostring(e.icon) or "")
      labelBox:SetText(e.label or "")

      setType(e.type or "spell")
      if e.type == "weaponEnchant" then
        setWESource((e.useKind == "item") and "item" or "spell")
        setWEHand((e.hand == "off") and "off" or "main")
      else
        setWESource("spell")
        setWEHand("main")
      end

      setShowMode(e.gates)
      setGlowMode(e.glow or "general")
      if thresholdHolder and thresholdHolder.SetValue then
        thresholdHolder:SetValue(tonumber(e.thresholdMinutes) or 15)
      end

      editingId = e.id
      setMode(true)
    end

    local function collectShowGates()
      local g = {}
      if alwaysCB:GetChecked() then
        g[#g + 1] = "evenRested"
        return g
      end
      if instCB:GetChecked() then
        g[#g + 1] = "instance"
      end
      if groupCB:GetChecked() then
        g[#g + 1] = "group"
      end
      return g
    end

    alwaysCB:SetScript("OnClick", function(self)
      if self:GetChecked() then
        instCB:SetChecked(false)
        groupCB:SetChecked(false)
      end
      setShowMode(collectShowGates())
    end)
    instCB:SetScript("OnClick", function()
      if not instCB:IsEnabled() then
        return
      end
      setShowMode(collectShowGates())
    end)
    groupCB:SetScript("OnClick", function()
      if not groupCB:IsEnabled() then
        return
      end
      setShowMode(collectShowGates())
    end)

    glowGeneralCB:SetScript("OnClick", function()
      setGlowMode("general")
    end)
    glowSpecialCB:SetScript("OnClick", function()
      setGlowMode("special")
    end)

    local RebuildList
    RebuildList = function()
      for i = contentFrame:GetNumChildren(), 1, -1 do
        select(i, contentFrame:GetChildren()):Hide()
      end

      local entries = sortedEntries()
      local y = -4

      if #entries == 0 then
        local empty = CreateFrame("Frame", nil, contentFrame, "BackdropTemplate")
        PaintBackdrop(empty, THEME.rowBG, THEME.rowBR)
        empty:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 4, y)
        empty:SetPoint("TOPRIGHT", contentFrame, "TOPRIGHT", -4, y)
        empty:SetHeight(34)

        local txt = empty:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        txt:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
        txt:SetPoint("LEFT", 10, 0)
        txt:SetText(L["No custom spells yet."])
        y = y - 38
      end

      local d = DB()
      for i = 1, #entries do
        local data = entries[i]

        local rowF = CreateFrame("Frame", nil, contentFrame, "BackdropTemplate")
        PaintBackdrop(rowF, THEME.rowBG, (editingId == data.id) and THEME.rowSelectedBR or THEME.rowBR)
        rowF:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 4, y)
        rowF:SetPoint("TOPRIGHT", contentFrame, "TOPRIGHT", -4, y)

        local iconFrame = CreateFrame("Frame", nil, rowF, "BackdropTemplate")
        PaintBackdrop(iconFrame, { 0, 0, 0, 1 }, { 0, 0, 0, 1 })
        iconFrame:SetSize(32, 32)
        iconFrame:SetPoint("LEFT", 8, 0)

        local icon = iconFrame:CreateTexture(nil, "ARTWORK")
        icon:SetPoint("TOPLEFT", 1, -1)
        icon:SetPoint("BOTTOMRIGHT", -1, 1)
        icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        local tex = ResolveDisplayIcon(data)
        icon:SetTexture(tex or 136243)

        local textBlock = CreateFrame("Frame", nil, rowF)
        textBlock:SetPoint("LEFT", iconFrame, "RIGHT", 8, 0)
        textBlock:SetPoint("RIGHT", rowF, "RIGHT", -78, 0)

        local title = textBlock:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        title:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
        title:SetJustifyH("LEFT")
        title:SetWordWrap(true)
        if title.SetNonSpaceWrap then
          title:SetNonSpaceWrap(true)
        end
        title:SetPoint("TOPLEFT", textBlock, "TOPLEFT", 0, -1)
        title:SetPoint("TOPRIGHT", textBlock, "TOPRIGHT", 0, -1)

        local typeTxt = (data.type == "item") and L["Item"] or ((data.type == "weaponEnchant") and (L["Weapon Enchant"] or "Weapon Enchant") or L["Spell"])
        local useName
        if data.type == "item" then
          useName = GetItemName(data.useID)
        elseif data.type == "weaponEnchant" and data.useKind == "item" then
          useName = GetItemName(data.useID)
        else
          useName = GetSpellName(data.useID)
        end
        local buffPart = ""
        if data.buffID then
          buffPart = ("   %s: %d"):format(L["Buff ID"], data.buffID or 0)
        end
        local iconPart = ("   %s: %s"):format((L["Icon ID"] or "Icon ID"), tostring(data.icon or tex or "-"))
        title:SetText(("%s |cff8fd3ff%s|r  |cffffffff#%d|r%s%s"):format(typeTxt, useName or L["Unknown"], data.useID or 0, buffPart, iconPart))

        local sub = textBlock:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        sub:SetFont(THEME.fontPath(), THEME.sizeLabel() - 2, "")
        sub:SetJustifyH("LEFT")
        sub:SetWordWrap(true)
        if sub.SetNonSpaceWrap then
          sub:SetNonSpaceWrap(true)
        end
        sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -1)
        sub:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT", 0, -1)

        local glowText = (data.glow == "special") and L["Special"] or L["General"]
        local lblText = (type(data.label) == "string" and data.label ~= "") and data.label or "-"
        local thText = tostring(tonumber(data.thresholdMinutes) or "-")
        sub:SetText(("%s: %s  •  %s  •  %s: %s"):format(
          L["Label"],
          lblText,
          (L["Time"] or "Time") .. ": " .. thText .. "  •  " .. (L["Show"] or "Show") .. ": " .. BuildShowText(data.gates),
          L["Glow Color"],
          glowText
        ))

        local titleH = math.max(14, title:GetStringHeight() or 14)
        local subH = math.max(12, sub:GetStringHeight() or 12)
        local textH = titleH + subH + 6
        local rowH = math.max(46, math.ceil(textH + 10))
        rowF:SetHeight(rowH)
        textBlock:SetHeight(textH)
        textBlock:ClearAllPoints()
        textBlock:SetPoint("LEFT", iconFrame, "RIGHT", 8, 0)
        textBlock:SetPoint("RIGHT", rowF, "RIGHT", -78, 0)
        textBlock:SetPoint("CENTER", rowF, "CENTER", 0, 0)

        local pick = CreateFrame("Button", nil, rowF)
        pick:SetPoint("TOPLEFT", rowF, "TOPLEFT", 0, 0)
        pick:SetPoint("BOTTOMRIGHT", rowF, "BOTTOMRIGHT", -74, 0)
        pick:SetScript("OnClick", function()
          setFormFromEntry(data)
          ShowEditorPopup()
          RebuildList()
        end)

        pick:SetScript("OnEnter", function(self)
          if not TooltipsEnabled() then
            return
          end
          GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
          if (data.type == "item" or (data.type == "weaponEnchant" and data.useKind == "item")) and data.useID then
            GameTooltip:SetItemByID(data.useID)
          elseif data.useID then
            GameTooltip:SetSpellByID(data.useID)
          end
          GameTooltip:Show()
        end)
        pick:SetScript("OnLeave", function()
          GameTooltip:Hide()
        end)

        local enabled = NewCheckbox(rowF, data.enabled ~= false, function(_, v)
          data.enabled = v and true or false
          Notify(true)
        end)
        enabled:SetPoint("RIGHT", rowF, "RIGHT", -48, 0)

        local remove = CreateFrame("Button", nil, rowF)
        remove:SetSize(18, 18)
        remove:SetPoint("RIGHT", rowF, "RIGHT", -16, 0)
        local x = remove:CreateTexture(nil, "ARTWORK")
        x:SetAllPoints()
        x:SetAtlas("common-icon-redx", true)

        remove:SetScript("OnClick", function()
          local payload = {
            run = function()
              for idx = #d.customSpells, 1, -1 do
                if d.customSpells[idx] and d.customSpells[idx].id == data.id then
                  table.remove(d.customSpells, idx)
                end
              end
              if editingId == data.id then
                clearForm()
                popup:Hide()
              end
              RebuildList()
              Notify(true)
            end
          }
          StaticPopup_Show(POPUP_DELETE_KEY, useName or tostring(data.useID), nil, payload)
        end)

        y = y - (rowH + 4)
      end

      contentFrame:SetHeight(math.max(1, -y))
      refreshScrollMetrics()
    end

    saveBtn:SetScript("OnClick", function()
      local d = DB()
      local formData = getFormData()
      if not formData then
        return
      end

      local idBuff = formData.buffID or 0
      local newID = formData.type .. ":" .. tostring(formData.useID) .. ":" .. tostring(idBuff)
      if formData.type == "weaponEnchant" then
        newID = newID .. ":" .. tostring(formData.useKind or "spell") .. ":" .. tostring(formData.hand or "main")
      end
      local newEntry = {
        id = newID,
        enabled = true,
        type = formData.type,
        useID = formData.useID,
        buffID = formData.buffID,
        useKind = formData.useKind,
        hand = formData.hand,
        icon = formData.icon,
        gates = formData.gates,
        label = formData.label,
        glow = formData.glow,
        thresholdMinutes = formData.thresholdMinutes,
      }

      if editingId then
        local editIndex
        for i = 1, #d.customSpells do
          if d.customSpells[i] and d.customSpells[i].id == editingId then
            editIndex = i
            break
          end
        end
        if editIndex then
          d.customSpells[editIndex] = newEntry
        else
          d.customSpells[#d.customSpells + 1] = newEntry
        end
        for i = #d.customSpells, 1, -1 do
          if i ~= editIndex and d.customSpells[i] and d.customSpells[i].id == newID then
            table.remove(d.customSpells, i)
          end
        end
      else
        local replaced = false
        for i = 1, #d.customSpells do
          local e = d.customSpells[i]
          if e and e.id == newID then
            d.customSpells[i] = newEntry
            replaced = true
            break
          end
        end
        if not replaced then
          d.customSpells[#d.customSpells + 1] = newEntry
        end
      end

      clearForm()
      popup:Hide()
      RebuildList()
      Notify(true)
    end)

    clearBtn:SetScript("OnClick", function()
      if editingId then
        clearForm()
        popup:Hide()
      else
        clearForm()
      end
    end)

    addBtn:SetScript("OnClick", function()
      clearForm()
      setMode(false)
      ShowEditorPopup()
    end)

    if ns.OptionsFrame and not ns.OptionsFrame._crb_custom_popup_hooked then
      ns.OptionsFrame:HookScript("OnHide", function()
        clearForm()
        popup:Hide()
      end)
      ns.OptionsFrame._crb_custom_popup_hooked = true
    end

    listCard:SetScript("OnShow", RebuildList)
    listCard:HookScript("OnSizeChanged", RebuildList)
    scroll:HookScript("OnSizeChanged", refreshScrollMetrics)

    clearForm()
    RebuildList()
  end)
end)
