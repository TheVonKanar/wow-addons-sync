-- ====================================
-- \Core\Buffs.lua
-- ====================================

local addonName, ns = ...

local function HasStringKey(t, k)
  return type(t) == "table" and type(k) == "string" and t[k] == true
end

local function HasNumberKey(t, k)
  return type(t) == "table" and type(k) == "number" and t[k] == true
end

function ns.GetLocalizedBuffName(spellID)
  local info = C_Spell.GetSpellInfo(spellID)
  return info and info.name or nil
end

local NAME_MODE_EXCLUDE = { [442522] = true }

local function BuildNameLookup(spellIDs)
  local t = {}
  for _, id in ipairs(spellIDs or {}) do
    local name = ns.GetLocalizedBuffName(id)
    if type(name) == "string" then
      t[name] = true
    end
  end
  return next(t) and t or nil
end

function ns.BuildSpellIDSet(spellIDs)
  local t = {}
  if type(spellIDs) ~= "table" then
    return t
  end
  for _, id in ipairs(spellIDs) do
    if type(id) == "number" then
      t[id] = true
    end
  end
  return t
end

function ns.BuildBuffNameSet(spellIDs)
  local t = {}
  if type(spellIDs) ~= "table" then
    return t
  end
  for _, id in ipairs(spellIDs) do
    local name = ns.GetLocalizedBuffName(id)
    if type(name) == "string" then
      t[name] = true
    end
  end
  return t
end

function ns.GetGroupUnits(opts)
  opts = opts or {}

  local includePlayer = (opts.includePlayer ~= false)
  local onlyExisting = (opts.onlyExisting == true)
  local units = {}

  if IsInRaid() then
    for i = 1, GetNumGroupMembers() do
      local u = "raid" .. i
      if (not onlyExisting) or UnitExists(u) then
        units[#units + 1] = u
      end
    end

  elseif IsInGroup() then
    for i = 1, GetNumSubgroupMembers() do
      local u = "party" .. i
      if (not onlyExisting) or UnitExists(u) then
        units[#units + 1] = u
      end
    end

    if includePlayer then
      units[#units + 1] = "player"
    end

  else
    if includePlayer then
      units[#units + 1] = "player"
    end
  end

  return units
end

function ns.UnitHasAnyBuffByIDs(unit, ids)
  if ns.AurasAreSecret and ns.AurasAreSecret() then
    return false
  end
  if not unit or type(ids) ~= "table" then
    return false
  end
  local idx = 1
  while true do
    local aura = C_UnitAuras.GetAuraDataByIndex(unit, idx, "HELPFUL")
    if not aura then
      break
    end
    local sid = ns.SafeAuraSpellID(aura)
    if HasNumberKey(ids, sid) then
      return true
    end
    idx = idx + 1
  end
  return false
end

function ns.UnitHasAnyBuffByNames(unit, names)
  if ns.AurasAreSecret and ns.AurasAreSecret() then
    return false
  end
  if not unit or type(names) ~= "table" then
    return false
  end
  local idx = 1
  while true do
    local aura = C_UnitAuras.GetAuraDataByIndex(unit, idx, "HELPFUL")
    if not aura then
      break
    end
    local name = ns.SafeAuraName(aura)
    if HasStringKey(names, name) then
      local sid = ns.SafeAuraSpellID(aura)
      if not HasNumberKey(NAME_MODE_EXCLUDE, sid) then
        return true
      end
    end
    idx = idx + 1
  end
  return false
end

function ns.GetPlayerBuffExpire(spellIDs, nameMode, infinite)
  if ns.AurasAreSecret and ns.AurasAreSecret() then
    return nil
  end
  local function safeExpiration(aura)
    return ns.SafeAuraExpiration(aura, infinite)
  end

  if nameMode then
    local nameLookup = BuildNameLookup(spellIDs)
    if not nameLookup then
      return nil
    end
    local index = 1
    while true do
      local aura = C_UnitAuras.GetAuraDataByIndex("player", index, "HELPFUL")
      if not aura then
        break
      end

      if
        HasStringKey(nameLookup, ns.SafeAuraName(aura))
        and ns.SafeAuraSpellID(aura)
        and not HasNumberKey(NAME_MODE_EXCLUDE, ns.SafeAuraSpellID(aura))
      then
        return safeExpiration(aura)
      end

      index = index + 1
    end
  else
    local spellLookup = {}
    for _, id in ipairs(spellIDs or {}) do
      spellLookup[id] = true
    end

    local index = 1
    while true do
      local aura = C_UnitAuras.GetAuraDataByIndex("player", index, "HELPFUL")
      if not aura then
        break
      end

      local sid = ns.SafeAuraSpellID(aura)
      if HasNumberKey(spellLookup, sid) then
        return safeExpiration(aura)
      end

      index = index + 1
    end
  end

  return nil
end

function ns.GetRaidBuffExpire(spellIDs, nameMode, infinite)
  if ns.AurasAreSecret and ns.AurasAreSecret() then
    return nil
  end
  local spellLookup, nameLookup
  if nameMode then
    nameLookup = BuildNameLookup(spellIDs)
    if not nameLookup then
      return nil
    end
  else
    spellLookup = ns.BuildSpellIDSet(spellIDs or {})
  end

  local earliest = nil
  for _, unit in ipairs(ns.GetGroupUnits({ includePlayer = true })) do
    local found = false
    local idx = 1
    while true do
      local aura = C_UnitAuras.GetAuraDataByIndex(unit, idx, "HELPFUL")
      if not aura then
        break
      end

      local sid = ns.SafeAuraSpellID(aura)
      if sid then
        if nameMode then
          if HasStringKey(nameLookup, ns.SafeAuraName(aura)) and not HasNumberKey(NAME_MODE_EXCLUDE, sid) then
            found = true
              local exp = ns.SafeAuraExpiration(aura, infinite)
              if not exp then
                return nil
              end
            if not earliest or exp < earliest then
              earliest = exp
            end
            break
          end
        else
          if HasNumberKey(spellLookup, sid) then
            found = true
            local exp = ns.SafeAuraExpiration(aura, infinite)
            if not exp then
              return nil
            end
            if not earliest or exp < earliest then
              earliest = exp
            end
            break
          end
        end
      end

      idx = idx + 1
    end

    if not found then
      return nil
    end
  end

  return earliest
end

function ns.GetRaidBuffExpireMine(spellIDs, nameMode, infinite)
  if ns.AurasAreSecret and ns.AurasAreSecret() then
    return nil
  end
  local playerGUID = UnitGUID("player")
  local units = ns.GetGroupUnits({ includePlayer = true })

  local spellLookup, nameLookup
  if nameMode then
    nameLookup = BuildNameLookup(spellIDs)
    if not nameLookup then
      return nil
    end
  else
    spellLookup = ns.BuildSpellIDSet(spellIDs or {})
  end

  for _, unit in ipairs(units) do
    local idx = 1
    while true do
      local aura = C_UnitAuras.GetAuraDataByIndex(unit, idx, "HELPFUL")
      if not aura then
        break
      end

      local sid = ns.SafeAuraSpellID(aura)
      local sourceUnit = ns.SafeAuraSourceUnit(aura)
        if sid and sourceUnit and UnitGUID(sourceUnit) == playerGUID then
          if nameMode then
            if HasStringKey(nameLookup, ns.SafeAuraName(aura)) and not HasNumberKey(NAME_MODE_EXCLUDE, sid) then
              local exp = ns.SafeAuraExpiration(aura, infinite)
              if not exp then
                return nil
              end
              return exp
            end
          else
            if HasNumberKey(spellLookup, sid) then
              local exp = ns.SafeAuraExpiration(aura, infinite)
              if not exp then
                return nil
              end
              return exp
            end
          end
        end

      idx = idx + 1
    end
  end

  return nil
end
