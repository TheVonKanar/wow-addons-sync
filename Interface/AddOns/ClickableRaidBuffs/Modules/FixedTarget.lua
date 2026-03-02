-- ====================================
-- \Modules\FixedTarget.lua
-- ====================================

local addonName, ns = ...
local IsSecret = ns.Compat and ns.Compat.IsSecret

local function IsNonSecretNumber(v)
  return type(v) == "number" and not (IsSecret and IsSecret(v))
end

local function IsNonSecretString(v)
  return type(v) == "string" and not (IsSecret and IsSecret(v))
end

local function DB()
  local d = (ns.GetDB and ns.GetDB()) or _G.ClickableRaidBuffsDB
  if type(d) ~= "table" then
    _G.ClickableRaidBuffsDB = _G.ClickableRaidBuffsDB or {}
    d = _G.ClickableRaidBuffsDB
  end
  d.fixedTargets = d.fixedTargets or {}
  return d
end

local function MigrateLegacyCache()
  if type(_G.clickableRaidBuffCache) == "table" and type(_G.clickableRaidBuffCache.fixedTargets) == "table" then
    local dst = DB().fixedTargets
    local src = _G.clickableRaidBuffCache.fixedTargets
    for k, v in pairs(src) do
      if dst[k] == nil and type(k) == "number" and type(v) == "string" and v ~= "" then
        dst[k] = v
      end
    end
    _G.clickableRaidBuffCache.fixedTargets = nil
  end
end

local TRUNCATE_N = 6

local function ShortNameFromUnit(unit)
  local name = UnitName(unit)
  if not name or name == "" then
    return nil
  end
  return name
end

local function TruncatedShort(name)
  if not name then
    return nil
  end
  if TRUNCATE_N and TRUNCATE_N > 0 then
    return name:sub(1, TRUNCATE_N)
  end
  return name
end

local _trackedByClassID, _trackedTableRef, _trackedSpellList

local function BuildTrackedSpellList()
  local classID = _G.clickableRaidBuffCache
    and _G.clickableRaidBuffCache.playerInfo
    and _G.clickableRaidBuffCache.playerInfo.playerClassId
  if not classID and type(ns.getPlayerClass) == "function" then
    classID = ns.getPlayerClass()
  end

  local tbl = classID and _G.ClickableRaidData and _G.ClickableRaidData[classID]
  if not tbl then
    _trackedByClassID, _trackedTableRef, _trackedSpellList = nil, nil, nil
    return {}
  end

  if _trackedSpellList and _trackedByClassID == classID and _trackedTableRef == tbl then
    return _trackedSpellList
  end

  local out = {}
  for spellID, data in pairs(tbl) do
    if type(spellID) == "number" and type(data) == "table" and data.count and data.type ~= "trinket" then
      if not data.nameMode then
        local lookup = data._crbFixedTargetIdLookup
        if type(lookup) ~= "table" then
          lookup = {}
          if data.buffID then
            for _, id in ipairs(data.buffID) do
              lookup[id] = true
            end
          end
          data._crbFixedTargetIdLookup = lookup
        end
      else
        local name = data._crbFixedTargetName
        if not name then
          local info = C_Spell.GetSpellInfo(data.buffID and data.buffID[1])
          name = info and info.name or false
          data._crbFixedTargetName = name
        end
      end
      out[spellID] = data
    end
  end

  _trackedByClassID, _trackedTableRef, _trackedSpellList = classID, tbl, out
  return out
end

local function InvalidateTrackedSpellListCache()
  _trackedByClassID, _trackedTableRef, _trackedSpellList = nil, nil, nil
end

local function UnitHasMyAuraForRow(unit, row)
  if not unit or not row then
    return false
  end
  local wantByName, idLookup
  if row.nameMode then
    wantByName = row._crbFixedTargetName
    if wantByName == false then
      return false
    end
    if not wantByName then
      local info = C_Spell.GetSpellInfo(row.buffID and row.buffID[1])
      wantByName = info and info.name or false
      row._crbFixedTargetName = wantByName
      if wantByName == false then
        return false
      end
    end
  else
    idLookup = row._crbFixedTargetIdLookup
    if type(idLookup) ~= "table" then
      idLookup = {}
      if row.buffID then
        for _, id in ipairs(row.buffID) do
          idLookup[id] = true
        end
      end
      row._crbFixedTargetIdLookup = idLookup
    end
  end
  local i = 1
  while true do
    local aura = C_UnitAuras.GetAuraDataByIndex(unit, i, "HELPFUL")
    if not aura then
      break
    end
    local sourceUnit = aura.sourceUnit
    if sourceUnit and not (IsSecret and IsSecret(sourceUnit)) and UnitIsUnit(sourceUnit, "player") then
      if wantByName then
        if IsNonSecretString(aura.name) and aura.name == wantByName then
          return true
        end
      else
        local sid = aura.spellId
        if IsNonSecretNumber(sid) and idLookup[sid] then
          return true
        end
      end
    end
    i = i + 1
  end
  return false
end

local function IterateGroupUnits()
  local units = {}
  if IsInRaid() then
    for i = 1, GetNumGroupMembers() do
      units[#units + 1] = "raid" .. i
    end
  elseif IsInGroup() then
    for i = 1, GetNumSubgroupMembers() do
      units[#units + 1] = "party" .. i
    end
    units[#units + 1] = "player"
  else
    units[#units + 1] = "player"
  end
  return units
end

local function CleanCacheForRoster()
  local present = {}
  for _, unit in ipairs(IterateGroupUnits()) do
    local short = ShortNameFromUnit(unit)
    if short then
      present[short] = true
    end
  end
  local ft = DB().fixedTargets
  local changed = false
  for spellID, short in pairs(ft) do
    if short and not present[short] then
      ft[spellID] = nil
      changed = true
    end
  end
  return changed
end

local function RebuildFixedTargetCacheFromAuras()
  local tracked = BuildTrackedSpellList()
  if not next(tracked) then
    return false
  end
  local units = IterateGroupUnits()
  local ft = DB().fixedTargets
  local changed = false
  for spellID, row in pairs(tracked) do
    local remembered = ft[spellID]
    local foundShort
    for _, unit in ipairs(units) do
      if UnitHasMyAuraForRow(unit, row) then
        foundShort = ShortNameFromUnit(unit)
        break
      end
    end
    if foundShort and foundShort ~= remembered then
      ft[spellID] = foundShort
      changed = true
    end
  end
  return changed
end

function ns.FixedTarget_InjectIcons()
  local display = _G.clickableRaidBuffCache and _G.clickableRaidBuffCache.displayable
  if not display then
    return
  end
  local rb = display.RAID_BUFFS
  if not rb then
    return
  end
  local tracked = BuildTrackedSpellList()
  if not next(tracked) then
    for spellID in pairs(DB().fixedTargets) do
      rb["fixed:" .. spellID] = nil
    end
    return
  end
  for spellID, base in pairs(rb) do
    if tracked[spellID] then
      local short = DB().fixedTargets[spellID]
      if short and short ~= "" then
        local e = ns.copyItemData(base)
        e.isFixed = true
        local spellName = (C_Spell.GetSpellInfo(spellID) or {}).name or ""
        e.macro = "/use [@" .. short .. "] " .. spellName
        e.btmLbl = TruncatedShort(short)
        e.texture = base.icon
        e.expireTime = base.expireTime
        e.showAt = base.showAt
        rb["fixed:" .. spellID] = e
      else
        rb["fixed:" .. spellID] = nil
      end
    end
  end
end

local function EnsureRenderHook()
  if ns._fixedTargetWrapped then
    return
  end
  if type(ns.RenderAll) == "function" then
    local orig = ns.RenderAll
    ns.RenderAll = function(...)
      if ns.FixedTarget_InjectIcons then
        ns.FixedTarget_InjectIcons()
      end
      return orig(...)
    end
    ns._fixedTargetWrapped = true
  end
end

function ns.FixedTarget_Init()
  InvalidateTrackedSpellListCache()
  MigrateLegacyCache()
  EnsureRenderHook()
  local c1 = RebuildFixedTargetCacheFromAuras()
  local c2 = CleanCacheForRoster()
  ns.FixedTarget_InjectIcons()
  return (c1 or c2) and true or false
end

function ns.FixedTarget_OnRosterChanged()
  InvalidateTrackedSpellListCache()
  EnsureRenderHook()
  local c1 = CleanCacheForRoster()
  local c2 = RebuildFixedTargetCacheFromAuras()
  ns.FixedTarget_InjectIcons()
  return (c1 or c2) and true or false
end

function ns.FixedTarget_OnUnitAura(unit, updateInfo)
  if not unit or (unit ~= "player" and not unit:match("^party%d") and not unit:match("^raid%d")) then
    return false
  end
  local tracked = BuildTrackedSpellList()
  if not next(tracked) then
    return false
  end
  local ft = DB().fixedTargets
  local changed = false
  for spellID, row in pairs(tracked) do
    if UnitHasMyAuraForRow(unit, row) then
      local who = ShortNameFromUnit(unit)
      if who and who ~= ft[spellID] then
        ft[spellID] = who
        changed = true
      end
    end
  end
  if changed then
    ns.FixedTarget_InjectIcons()
  end
  return changed
end
