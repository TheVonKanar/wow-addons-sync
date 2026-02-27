-- ====================================
-- \Modules\CustomSpells.lua
-- ====================================

local addonName, ns = ...

clickableRaidBuffCache = clickableRaidBuffCache or {}
clickableRaidBuffCache.displayable = clickableRaidBuffCache.displayable or {}

local CAT = "CUSTOM_AURAS"

local function DB()
  local d = (ns.GetDB and ns.GetDB()) or _G.ClickableRaidBuffsDB or {}
  d.customSpells = d.customSpells or {}
  return d
end

local function normalizeID(v)
  local n = tonumber(v)
  if not n or n <= 0 then
    return nil
  end
  return math.floor(n)
end

local function normalizeType(v)
  if v == "item" or v == "spell" or v == "weaponEnchant" then
    return v
  end
  return "spell"
end

local function normalizeUseKind(v)
  if v == "item" then
    return "item"
  end
  return "spell"
end

local function normalizeHand(v)
  if v == "off" or v == "offhand" then
    return "off"
  end
  return "main"
end

local function normalizeGates(entry)
  local g = {}
  local src = entry and entry.gates
  if type(src) == "table" then
    for i = 1, #src do
      local name = src[i]
      if name == "instance" or name == "group" or name == "evenRested" then
        g[#g + 1] = name
      end
    end
  end

  if #g == 0 then
    local mode = entry and entry.showMode
    if mode == "instance" then
      g[1] = "instance"
    elseif mode == "group" then
      g[1] = "group"
    elseif mode == "always" then
      g[1] = "evenRested"
    end
  end

  return g
end

local function asLegacyRecord(key, data)
  local useID = normalizeID(data and data.useID) or normalizeID(key)
  local buffID = normalizeID(data and data.buffID)
  if not useID or not buffID then
    return nil
  end

  local kind = normalizeType(data and data.type)

  local label = data and data.label
  if type(label) ~= "string" then
    label = ""
  end

  local out = {
    id = tostring(kind) .. ":" .. tostring(useID) .. ":" .. tostring(buffID),
    enabled = (data and data.enabled ~= false) and true or false,
    type = kind,
    useID = useID,
    buffID = buffID,
    icon = tonumber(data and data.icon) or nil,
    label = label,
    glow = (data and data.glow == "special") and "special" or "general",
    thresholdMinutes = tonumber(data and data.thresholdMinutes),
    useKind = normalizeUseKind(data and data.useKind),
    hand = normalizeHand(data and data.hand),
  }
  out.gates = normalizeGates(data)
  return out
end

local function normalizeRecord(entry, fallbackKey)
  if type(entry) ~= "table" then
    return nil
  end

  if not (entry.id and entry.useID and (entry.type == "spell" or entry.type == "item" or entry.type == "weaponEnchant")) then
    return asLegacyRecord(fallbackKey, entry)
  end

  entry.type = normalizeType(entry.type)
  entry.useID = normalizeID(entry.useID)
  entry.buffID = normalizeID(entry.buffID)
  if not entry.useID then
    return nil
  end
  if entry.type ~= "weaponEnchant" and not entry.buffID then
    return nil
  end

  entry.enabled = (entry.enabled ~= false)
  entry.icon = tonumber(entry.icon) or nil
  entry.label = type(entry.label) == "string" and entry.label or ""
  entry.glow = (entry.glow == "special") and "special" or "general"
  entry.thresholdMinutes = tonumber(entry.thresholdMinutes)
  entry.useKind = normalizeUseKind(entry.useKind)
  entry.hand = normalizeHand(entry.hand)
  entry.gates = normalizeGates(entry)
  entry.showMode = nil
  return entry
end

local function sanitizeCustomSpellStorage()
  local d = DB()
  local src = d.customSpells
  local out = {}

  if type(src) == "table" then
    if #src > 0 then
      for i = 1, #src do
        local e = normalizeRecord(src[i])
        if e then
          out[#out + 1] = e
        end
      end
    else
      for k, v in pairs(src) do
        local e = normalizeRecord(v, k)
        if e then
          out[#out + 1] = e
        end
      end
    end
  end

  d.customSpells = out
  return out
end

function ns.CustomSpells_GetAll()
  return sanitizeCustomSpellStorage()
end

local function defaultThresholdSeconds(kind, db)
  if kind == "item" then
    local baseMin = tonumber(db.itemThreshold) or 15
    if ns.MPlus_GetEffectiveThresholdSecs then
      return ns.MPlus_GetEffectiveThresholdSecs("item", baseMin)
    end
    return baseMin * 60
  end

  local baseMin = tonumber(db.spellThreshold) or 15
  if ns.MPlus_GetEffectiveThresholdSecs then
    return ns.MPlus_GetEffectiveThresholdSecs("spell", baseMin)
  end
  return baseMin * 60
end

local function resolveThresholdSeconds(entry, db)
  local customMin = tonumber(entry and entry.thresholdMinutes)
  if customMin and customMin >= 0 then
    return customMin * 60
  end
  return defaultThresholdSeconds(entry and entry.type, db)
end

local function resolveIcon(entry)
  local icon = tonumber(entry.icon)
  if icon and icon > 0 then
    return icon
  end

  local useKind = (entry.type == "weaponEnchant") and normalizeUseKind(entry.useKind) or entry.type

  if useKind == "item" and C_Item and C_Item.GetItemInfoInstant then
    return select(5, C_Item.GetItemInfoInstant(entry.useID))
  end
  if C_Spell and C_Spell.GetSpellInfo then
    local info = C_Spell.GetSpellInfo(entry.useID)
    return info and info.iconID
  end
  return nil
end

local function resolveName(entry)
  local useKind = (entry.type == "weaponEnchant") and normalizeUseKind(entry.useKind) or entry.type

  if useKind == "item" and C_Item and C_Item.GetItemInfo then
    local info = C_Item.GetItemInfo(entry.useID)
    if type(info) == "table" then
      return info.itemName
    end
    return info
  end
  if C_Spell and C_Spell.GetSpellInfo then
    local info = C_Spell.GetSpellInfo(entry.useID)
    return info and info.name
  end
  return nil
end

local function isSpellUsableKnown(spellID)
  if not spellID then
    return false
  end
  if C_SpellBook and C_SpellBook.IsSpellKnown then
    local ok = C_SpellBook.IsSpellKnown(spellID)
    if ok ~= nil then
      return ok and true or false
    end
  end
  if IsPlayerSpell and IsPlayerSpell(spellID) then
    return true
  end
  if IsSpellKnown and IsSpellKnown(spellID) then
    return true
  end
  if IsSpellKnownOrOverridesKnown and IsSpellKnownOrOverridesKnown(spellID) then
    return true
  end
  return false
end

local function hasItemOrToy(itemID)
  if not itemID then
    return false
  end
  local n = 0
  if C_Item and C_Item.GetItemCount then
    n = C_Item.GetItemCount(itemID, false, true) or 0
  elseif GetItemCount then
    n = GetItemCount(itemID, false) or 0
  end
  if n > 0 then
    return true
  end
  if PlayerHasToy and PlayerHasToy(itemID) then
    return true
  end
  return false
end

local function professionRankForItem(itemID)
  if not itemID or not (C_Item and C_Item.GetItemInfo) then
    return nil
  end

  local itemInfo = itemID
  local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType,
    itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType,
    expansionID, setID, isCraftingReagent, itemDescription = C_Item.GetItemInfo(itemInfo)

  if type(itemLink) ~= "string" or itemLink == "" then
    return nil
  end

  local atlas = itemLink:match("|A:([^:]+):")
  if atlas == "Professions-ChatIcon-Quality-Tier1" then
    return 1
  elseif atlas == "Professions-ChatIcon-Quality-Tier2" then
    return 2
  elseif atlas == "Professions-ChatIcon-Quality-Tier3" then
    return 3
  elseif atlas == "Professions-ChatIcon-Quality-12-Tier1" then
    return 121
  elseif atlas == "Professions-ChatIcon-Quality-12-Tier2" then
    return 122
  end

  return nil
end

local function isConsumableItem(itemID)
  if not itemID then
    return false
  end
  local classID
  if C_Item and C_Item.GetItemInfoInstant then
    classID = select(6, C_Item.GetItemInfoInstant(itemID))
  elseif GetItemInfoInstant then
    classID = select(6, GetItemInfoInstant(itemID))
  end

  local consumableClass = Enum and Enum.ItemClass and Enum.ItemClass.Consumable or 0
  return classID == consumableClass
end

local function itemCountForDisplay(itemID)
  if not itemID then
    return 0
  end
  if C_Item and C_Item.GetItemCount then
    return C_Item.GetItemCount(itemID, false, false, false, false) or 0
  end
  if GetItemCount then
    return GetItemCount(itemID, false) or 0
  end
  return 0
end

local function weaponEnchantExpireForHand(hand)
  local hasMH, mhMs, _, _, hasOH, ohMs = GetWeaponEnchantInfo()
  if hand == "off" then
    if hasOH and type(ohMs) == "number" and ohMs > 0 then
      return GetTime() + (ohMs / 1000)
    end
    return nil
  end
  if hasMH and type(mhMs) == "number" and mhMs > 0 then
    return GetTime() + (mhMs / 1000)
  end
  return nil
end

local function resolveUseMinLevel(entry, useKind)
  if not entry or not entry.useID then
    return nil
  end

  if useKind == "item" then
    if C_Item and C_Item.GetItemInfo then
      local _, _, _, _, itemMinLevel = C_Item.GetItemInfo(entry.useID)
      itemMinLevel = tonumber(itemMinLevel)
      if itemMinLevel and itemMinLevel > 0 then
        return itemMinLevel
      end
    end
    return nil
  end

  local lvl
  if C_Spell and C_Spell.GetSpellLevelLearned then
    lvl = C_Spell.GetSpellLevelLearned(entry.useID)
  elseif GetSpellLevelLearned then
    lvl = GetSpellLevelLearned(entry.useID)
  end
  lvl = tonumber(lvl)
  if lvl and lvl > 0 then
    return lvl
  end
  return nil
end

local function buildGateData(entry, useKind)
  local out = {
    gates = {},
    minLevel = resolveUseMinLevel(entry, useKind),
  }

  local hasAlive, hasEvenDead = false, false
  if type(entry and entry.gates) == "table" then
    for i = 1, #entry.gates do
      local g = entry.gates[i]
      if type(g) == "string" and g ~= "" then
        out.gates[#out.gates + 1] = g
        if g == "alive" then
          hasAlive = true
        elseif g == "evenDead" then
          hasEvenDead = true
        end
      end
    end
  end

  if not hasAlive and not hasEvenDead then
    out.gates[#out.gates + 1] = "alive"
  end

  return out
end

local function buildOne(entry, db, playerLevel, inInstance, rested)
  if not entry.enabled then
    return nil
  end

  local useKind = (entry.type == "weaponEnchant") and normalizeUseKind(entry.useKind) or entry.type

  if useKind == "spell" then
    if not isSpellUsableKnown(entry.useID) then
      return nil
    end
  elseif useKind == "item" then
    if not hasItemOrToy(entry.useID) then
      return nil
    end
  end

  local rowData = buildGateData(entry, useKind)
  if not ns.PassesGates(rowData, playerLevel, inInstance, rested) then
    return nil
  end

  local expire
  if entry.type == "weaponEnchant" then
    local pi = clickableRaidBuffCache.playerInfo or {}
    local hand = normalizeHand(entry.hand)
    if hand == "off" then
      if not pi.offHand then
        return nil
      end
    else
      if not pi.mainHand then
        return nil
      end
    end
    expire = weaponEnchantExpireForHand(hand)
  else
    expire = ns.GetPlayerBuffExpire and ns.GetPlayerBuffExpire({ entry.buffID }, false, false) or nil
  end

  local out = {
    category = CAT,
    type = entry.type,
    buffID = entry.buffID and { entry.buffID } or nil,
    useID = entry.useID,
    spellID = (useKind == "spell") and entry.useID or nil,
    itemID = (useKind == "item") and entry.useID or nil,
    icon = resolveIcon(entry),
    name = resolveName(entry),
    expireTime = expire,
    gates = entry.gates,
    customEntryID = entry.id,
    topLbl = entry.label,
    glow = entry.glow,
    useKind = useKind,
  }

  if entry.type == "weaponEnchant" then
    local hand = normalizeHand(entry.hand)
    local slot = (hand == "off") and 17 or 16
    out.cornerText = (hand == "off") and "OH" or "MH"
    if useKind == "item" then
      out.macro = "/use item:" .. tostring(entry.useID) .. "\n/use " .. tostring(slot)
      out.rank = professionRankForItem(entry.useID)
      if isConsumableItem(entry.useID) then
        out.quantity = itemCountForDisplay(entry.useID)
      end
    else
      local info = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(entry.useID)
      local spellName = (info and info.name) or tostring(entry.useID)
      out.macro = "/use " .. tostring(spellName) .. "\n/use " .. tostring(slot)
    end
  elseif entry.type == "item" then
    out.macro = "/use item:" .. tostring(entry.useID)
    out.rank = professionRankForItem(entry.useID)
    if isConsumableItem(entry.useID) then
      out.quantity = itemCountForDisplay(entry.useID)
    end
  else
    -- Use native spell click attributes for spell entries to match the raid-buff
    -- click pathway. Prefer localized spell name when available.
    out.macro = nil
    local info = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(entry.useID)
    out.spellToCast = (info and info.name) or entry.useID
    out.selfCast = true
    out.target = "player"
  end

  local threshold = resolveThresholdSeconds(entry, db)
  if expire and expire ~= math.huge then
    out.showAt = expire - threshold
  end

  return out
end

function ns.CustomSpells_RebuildDisplayables()
  local disp = clickableRaidBuffCache.displayable
  disp[CAT] = {}

  local db = DB()
  local list = sanitizeCustomSpellStorage()
  if #list == 0 then
    return
  end

  local playerLevel = clickableRaidBuffCache.playerInfo.playerLevel or UnitLevel("player") or 0
  local inInstance = clickableRaidBuffCache.playerInfo.inInstance
  local rested = clickableRaidBuffCache.playerInfo.restedXPArea

  for i = 1, #list do
    local e = buildOne(list[i], db, playerLevel, inInstance, rested)
    if e then
      disp[CAT][list[i].id] = e
    end
  end
end

local function wrapRaidScan()
  if ns._customSpellsWrapped then
    return
  end

  local inner = ns._scanRaidBuffsInner or _G.scanRaidBuffs
  if type(inner) ~= "function" then
    return
  end

  ns._scanRaidBuffsInner = function(...)
    inner(...)
    if type(ns.CustomSpells_RebuildDisplayables) == "function" then
      ns.CustomSpells_RebuildDisplayables()
    end
  end

  ns._customSpellsWrapped = true
end

wrapRaidScan()
C_Timer.After(0.05, wrapRaidScan)
C_Timer.After(0.50, wrapRaidScan)

local function wrapRebuildDisplayables()
  if ns._customSpellsRebuildWrapped then
    return
  end
  if type(ns.RebuildDisplayables) ~= "function" then
    return
  end

  local orig = ns.RebuildDisplayables
  ns.RebuildDisplayables = function(...)
    local ret = orig(...)
    if type(ns.CustomSpells_RebuildDisplayables) == "function" then
      ns.CustomSpells_RebuildDisplayables()
    end
    return ret
  end
  ns._customSpellsRebuildWrapped = true
end

wrapRebuildDisplayables()
C_Timer.After(0.05, wrapRebuildDisplayables)
C_Timer.After(0.50, wrapRebuildDisplayables)
