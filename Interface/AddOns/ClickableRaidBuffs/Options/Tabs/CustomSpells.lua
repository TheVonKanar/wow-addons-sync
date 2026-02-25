-- ====================================
-- \Options\Tabs\CustomSpells.lua
-- ====================================

local addonName, ns = ...
ns.Options = ns.Options or {}
local O = ns.Options
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
  sizeHead = function()
    return (O and O.SIZE_SECTION_HEAD) or 20
  end,
  cardBG = { 0.09, 0.10, 0.14, 0.95 },
  cardBR = BORDER_COL,
  wellBG = ORDER_BOX_BG,
  wellBR = BORDER_COL,
  rowBG = TILE_BG,
  rowBR = BORDER_COL,
  tickTint = { 0.35, 0.80, 1.00, 1 },
}

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

local function Notify()
  if ns.RequestRebuild then
    ns.RequestRebuild()
  end
  if ns.PushRender then
    ns.PushRender()
  elseif ns.RenderAll then
    ns.RenderAll()
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

O.RegisterSection(function(AddSection)
  AddSection(L["Custom Spells"], function(content, Row)

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





















    local addCard = CreateFrame("Frame", nil, inner, "BackdropTemplate")
    PaintBackdrop(addCard, THEME.cardBG, THEME.cardBR)
    addCard:SetPoint("TOPLEFT", inner, "TOPLEFT", 10, -14)
    addCard:SetPoint("TOPRIGHT", inner, "TOPRIGHT", -10, -14)
    addCard:SetHeight(170)

    local addTitle = addCard:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    addTitle:SetFont(THEME.fontPath(), THEME.sizeHead(), "")
    addTitle:SetPoint("TOPLEFT", 12, -10)
    addTitle:SetText(L["Add Custom Spell"])

    local function MakeCheckbox(parent, label)
        local cb = CreateFrame("CheckButton", nil, parent, "BackdropTemplate")
        PaintBackdrop(cb, THEME.wellBG, THEME.wellBR)
        cb:SetSize(18,18)

        local tick = cb:CreateTexture(nil, "ARTWORK")
        tick:SetAtlas("common-icon-checkmark", true)
        tick:SetSize(14,14)
        tick:SetPoint("CENTER")
        tick:SetVertexColor(unpack(THEME.tickTint))
        tick:Hide()
        cb._tick = tick

        cb:SetScript("OnClick", function(self)
            self._tick:SetShown(self:GetChecked())
        end)

        local txt = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        txt:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
        txt:SetText(label)

        return cb, txt
    end

    local yBase = addTitle

    -- TYPE ROW
    local typeLabel = addCard:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    typeLabel:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    typeLabel:SetText(L["Type"])
    typeLabel:SetPoint("TOPLEFT", yBase, "BOTTOMLEFT", 0, -18)

    local spellCB, spellTxt = MakeCheckbox(addCard, L["Spell"])
    spellCB:SetPoint("LEFT", typeLabel, "RIGHT", 12, 0)
    spellTxt:SetPoint("LEFT", spellCB, "RIGHT", 6, 0)

    local itemCB, itemTxt = MakeCheckbox(addCard, L["Item"])
    itemCB:SetPoint("LEFT", spellTxt, "RIGHT", 24, 0)
    itemTxt:SetPoint("LEFT", itemCB, "RIGHT", 6, 0)

    spellCB:SetChecked(true)
    spellCB._tick:Show()

    spellCB:SetScript("OnClick", function()
        spellCB:SetChecked(true)
        spellCB._tick:Show()
        itemCB:SetChecked(false)
        itemCB._tick:Hide()
    end)

    itemCB:SetScript("OnClick", function()
        itemCB:SetChecked(true)
        itemCB._tick:Show()
        spellCB:SetChecked(false)
        spellCB._tick:Hide()
    end)

    -- ID ROW
    local idRowY = typeLabel

    local function MakeLabeledBox(labelText, anchorFrame, width, xOffset)
        local label = addCard:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        label:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
        label:SetText(labelText)
        label:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", xOffset or 0, -18)

        local box = CreateFrame("EditBox", nil, addCard, "BackdropTemplate")
        PaintBackdrop(box, THEME.wellBG, THEME.wellBR)
        box:SetSize(width, 24)
        box:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
        box:SetTextInsets(6,6,4,4)
        box:SetAutoFocus(false)
        box:SetNumeric(true)
        box:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -6)

        return label, box
    end

    local buffLabel, buffBox = MakeLabeledBox(L["Buff ID"], typeLabel, 140, 0)
    local useLabel, useBox = MakeLabeledBox(L["Spell or Item to Use"], typeLabel, 180, 220)
    useLabel:SetPoint("LEFT", buffLabel, "RIGHT", 40, 0)
    useBox:SetPoint("TOPLEFT", useLabel, "BOTTOMLEFT", 0, -6)

    local iconLabel, iconBox = MakeLabeledBox(L["Icon (optional)"], typeLabel, 120, 460)
    iconLabel:SetPoint("LEFT", useLabel, "RIGHT", 40, 0)
    iconBox:SetPoint("TOPLEFT", iconLabel, "BOTTOMLEFT", 0, -6)

    -- VISIBILITY ROW
    local visLabel = addCard:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    visLabel:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    visLabel:SetText(L["Visibility"])
    visLabel:SetPoint("TOPLEFT", buffBox, "BOTTOMLEFT", 0, -18)

    local restedCB, restedTxt = MakeCheckbox(addCard, L["Rested Areas"])
    restedCB:SetPoint("LEFT", visLabel, "RIGHT", 12, 0)
    restedTxt:SetPoint("LEFT", restedCB, "RIGHT", 6, 0)

    local instCB, instTxt = MakeCheckbox(addCard, L["Instances"])
    instCB:SetPoint("LEFT", restedTxt, "RIGHT", 24, 0)
    instTxt:SetPoint("LEFT", instCB, "RIGHT", 6, 0)

    local groupCB, groupTxt = MakeCheckbox(addCard, L["While in a Group"])
    groupCB:SetPoint("LEFT", instTxt, "RIGHT", 24, 0)
    groupTxt:SetPoint("LEFT", groupCB, "RIGHT", 6, 0)

    local addBtn = CreateFrame("Button", nil, addCard, "BackdropTemplate")
    PaintBackdrop(addBtn, THEME.rowBG, THEME.rowBR)
    addBtn:SetSize(120, 26)
    addBtn:SetPoint("TOPLEFT", visLabel, "BOTTOMLEFT", 0, -18)

    local addTxt = addBtn:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    addTxt:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
    addTxt:SetPoint("CENTER")
    addTxt:SetText(L["Add"])

    addBtn:SetScript("OnClick", function()
        local d = DB()
        local useID = tonumber(useBox:GetText())
        local buffID = tonumber(buffBox:GetText())
        if not useID or not buffID then return end

        local isSpell = spellCB:GetChecked()

        local iconID = tonumber(iconBox:GetText())
        if not iconID then
            if isSpell and C_Spell then
                local info = C_Spell.GetSpellInfo(useID)
                iconID = info and info.iconID
            elseif C_Item then
                iconID = select(5, C_Item.GetItemInfoInstant(useID))
            end
        end

        d.customSpells[useID] = {
            type = isSpell and "spell" or "item",
            buffID = buffID,
            useID = useID,
            icon = iconID,
            gates = {
                rested = restedCB:GetChecked(),
                instance = instCB:GetChecked(),
                grouped = groupCB:GetChecked(),
            },
            enabled = true,
        }

        Notify()
    end)





































    local listCard = CreateFrame("Frame", nil, inner, "BackdropTemplate")
    PaintBackdrop(listCard, THEME.cardBG, THEME.cardBR)
    listCard:ClearAllPoints()
    listCard:SetPoint("TOPLEFT", addCard, "BOTTOMLEFT", 0, -18)
    listCard:SetPoint("TOPRIGHT", inner, "TOPRIGHT", -10, -18)
    listCard:SetPoint("BOTTOMLEFT", inner, "BOTTOMLEFT", 10, 10)
    listCard:SetPoint("BOTTOMRIGHT", inner, "BOTTOMRIGHT", -10, 10)

    local listTitle = listCard:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    listTitle:SetFont(THEME.fontPath(), THEME.sizeHead(), "")
    listTitle:SetPoint("TOPLEFT", 12, -10)
    listTitle:SetText(L["Custom Spell List"])

    local scroll = CreateFrame("ScrollFrame", nil, listCard, "BackdropTemplate")
    scroll:SetPoint("TOPLEFT", listTitle, "BOTTOMLEFT", 0, -10)
    scroll:SetPoint("BOTTOMRIGHT", listCard, "BOTTOMRIGHT", -20, 10)

    local contentFrame = CreateFrame("Frame", nil, scroll)
    scroll:SetScrollChild(contentFrame)

    local bar = ns.ScrollBar.Create(listCard, { width = 16, sliderWidth = 14, minThumbH = 24 })
    bar:SetPoint("TOPRIGHT", listCard, "TOPRIGHT", -4, -36)
    bar:SetPoint("BOTTOMRIGHT", listCard, "BOTTOMRIGHT", -4, 10)
    bar:BindToScroll(scroll, contentFrame)

    local function RebuildList()
      for i = contentFrame:GetNumChildren(), 1, -1 do
        select(i, contentFrame:GetChildren()):Hide()
      end

      local d = DB()
      local y = -4
      local index = 0

      for spellID, data in pairs(d.customSpells) do
        index = index + 1

        local rowF = CreateFrame("Frame", nil, contentFrame, "BackdropTemplate")
        PaintBackdrop(rowF, THEME.rowBG, THEME.rowBR)
        rowF:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 4, y)
        rowF:SetPoint("TOPRIGHT", contentFrame, "TOPRIGHT", -4, y)
        rowF:SetHeight(38)

        local icon = rowF:CreateTexture(nil, "ARTWORK")
        icon:SetSize(28, 28)
        icon:SetPoint("LEFT", 6, 0)
        icon:SetTexture(data.icon or 136243)

        local name = rowF:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        name:SetFont(THEME.fontPath(), THEME.sizeLabel(), "")
        name:SetPoint("LEFT", icon, "RIGHT", 10, 0)
        name:SetText(data.name or ("Spell " .. spellID))

        local cb = NewCheckbox(rowF, data.enabled, function(_, v)
          data.enabled = v and true or false
          Notify()
        end)
        cb:SetPoint("LEFT", name, "RIGHT", 20, 0)

        local remove = CreateFrame("Button", nil, rowF, "BackdropTemplate")
        PaintBackdrop(remove, THEME.wellBG, THEME.wellBR)
        remove:SetSize(70, 22)
        remove:SetPoint("RIGHT", -8, 0)

        local rTxt = remove:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        rTxt:SetFont(THEME.fontPath(), THEME.sizeLabel() - 2, "")
        rTxt:SetPoint("CENTER")
        rTxt:SetText(DELETE)

        remove:SetScript("OnClick", function()
          d.customSpells[spellID] = nil
          RebuildList()
          Notify()
        end)

        y = y - 42
      end

      contentFrame:SetSize(scroll:GetWidth(), math.max(0, -y))
      C_Timer.After(0, function()
        local max = math.max(0, scroll:GetVerticalScrollRange())
        bar:SetMinMaxValues(0, max)
        bar:UpdateThumb(scroll:GetHeight(), contentFrame:GetHeight())
        bar:SetEnabledState(max > 0)
      end)
    end

    listCard:SetScript("OnShow", RebuildList)
    RebuildList()

  end)
end)