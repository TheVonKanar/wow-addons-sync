-- ====================================
-- \Gates\Range_Gate.lua
-- ====================================

local addonName, ns = ...
ns = ns or {}
local IsSecret = ns.Compat and ns.Compat.IsSecret

local function GetSpellRange(spellID)
  local info = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(spellID)
  if info and info.maxRange and info.maxRange > 0 then
    return info.maxRange, info.name
  end
  return 0, info and info.name or nil
end

local function UnitRangeKey(unit)
  return (UnitGUID and UnitGUID(unit)) or unit
end

local function IsUnitEligibleForRange(unit)
  if not unit then
    return false
  end
  if UnitExists and not UnitExists(unit) then
    return false
  end
  if UnitIsConnected and not UnitIsConnected(unit) then
    return false
  end
  if UnitIsDeadOrGhost and UnitIsDeadOrGhost(unit) then
    return false
  end
  if UnitInPhase and not UnitInPhase(unit) then
    return false
  end
  return true
end

local function IsUnitInSpellRange(spellID, unit)
  local function normalizeRangeFlag(v)
    if IsSecret and IsSecret(v) then
      return nil
    end
    if v == true then
      return true
    end
    if v == false then
      return false
    end
    return nil
  end

  local spellFlag, unitFlag = nil, nil

  if C_Spell and C_Spell.IsSpellInRange then
    spellFlag = normalizeRangeFlag(C_Spell.IsSpellInRange(spellID, unit))
  end

  if UnitInRange then
    unitFlag = normalizeRangeFlag(UnitInRange(unit))
  end

  if spellFlag == true or unitFlag == true then
    return true
  end

  if spellFlag == false and unitFlag == false then
    return false
  end

  -- Unknown range is treated as out of range.
  return false
end

local function UnitHasAnyBuffFromIDs(unit, ids)
  if ns.UnitHasAnyBuffByIDs then
    return ns.UnitHasAnyBuffByIDs(unit, ids)
  end
  return false
end

local function ResolveBuffIDsForData(data)
  if not data then
    return {}
  end
  local list = data.buffID or data.buffIDs
  if not list then
    if data.spellID then
      local s = {}
      s[data.spellID] = true
      return s
    end
    return {}
  end
  local ids = {}
  if type(list) == "table" then
    if ns.BuildSpellIDSet then
      ids = ns.BuildSpellIDSet(list)
    else
      for i = 1, #list do
        local v = list[i]
        if v then
          ids[v] = true
        end
      end
    end
  elseif type(list) == "number" then
    ids[list] = true
  end
  return ids
end

local RangeState = {
  ticker = nil,
  lastSummary = nil,
  inactivityTicks = 0,
  spellCursor = 1,
  maxUnitsPerTick = 5,
  minRescanSecs = 5,
}

function ns.IsRangeTickerRunning()
  return RangeState.ticker ~= nil
end

local function IsTickerEligible()
  if type(ns.locked) == "function" and ns.locked() then
    return false
  end
  if ns._inCombat or (InCombatLockdown and InCombatLockdown()) then
    return false
  end
  if ns._isDead or (UnitIsDeadOrGhost and UnitIsDeadOrGhost("player")) then
    return false
  end
  if not (IsInGroup() or IsInRaid()) then
    return false
  end
  return true
end

local function StopTicker()
  if RangeState.ticker then
    RangeState.ticker:Cancel()
    RangeState.ticker = nil
  end
end

local function TickRangeGate()
  if not IsTickerEligible() then
    StopTicker()
    return
  end

  local spells = {}
  local anyMissing = false
  local anyGlowChanged = false
  local anySuppressionChanged = false

  if ns._rangeTracked and next(ns._rangeTracked) then
    local units = (ns.GetGroupUnits and ns.GetGroupUnits({ includePlayer = true, onlyExisting = true })) or {}
    local spellIDs = {}
    for spellID in pairs(ns._rangeTracked) do
      spellIDs[#spellIDs + 1] = spellID
    end

    local budget = RangeState.maxUnitsPerTick
    if #spellIDs > 0 and RangeState.spellCursor > #spellIDs then
      RangeState.spellCursor = 1
    end

    local startIdx = RangeState.spellCursor
    for pass = 1, #spellIDs do
      local idx = ((startIdx + pass - 2) % #spellIDs) + 1
      local spellID = spellIDs[idx]
      local entry = ns._rangeTracked[spellID]

      if entry then
        local maxRange, spellName = GetSpellRange(spellID)
        local ids = entry.ids or {}
        local miss = {}
        local anyMissingOutOfRange = false
        local foundInRange = false
        local playerHas = UnitHasAnyBuffFromIDs("player", ids)

        if not playerHas then
          if entry.lastSuppressed ~= false then
            entry.lastSuppressed = false
            anySuppressionChanged = true
          end
          spells[#spells + 1] = { spellID = spellID, name = spellName, maxRange = maxRange, missing = miss }
        else
          entry._rangeByUnit = entry._rangeByUnit or {}
          entry._unitNextScanAt = entry._unitNextScanAt or {}
          entry._scanCursor = entry._scanCursor or 1

          local missingUnits = {}
          for i = 1, #units do
            local u = units[i]
            if u ~= "player" and IsUnitEligibleForRange(u) and not UnitHasAnyBuffFromIDs(u, ids) then
              missingUnits[#missingUnits + 1] = u
            end
          end

          if #missingUnits > 0 and budget > 0 then
            if entry._scanCursor > #missingUnits then
              entry._scanCursor = 1
            end
            local startUnitIdx = entry._scanCursor
            local now = GetTime and GetTime() or 0
            for unitPass = 1, #missingUnits do
              if budget <= 0 then
                break
              end
              local uIdx = ((startUnitIdx + unitPass - 2) % #missingUnits) + 1
              local u = missingUnits[uIdx]
              local key = UnitRangeKey(u)
              local nextAllowed = entry._unitNextScanAt[key] or 0
              if now >= nextAllowed then
                entry._rangeByUnit[key] = IsUnitInSpellRange(spellID, u)
                entry._unitNextScanAt[key] = now + RangeState.minRescanSecs
                budget = budget - 1
              end
            end
            entry._scanCursor = (startUnitIdx % #missingUnits) + 1
          end

          for i = 1, #missingUnits do
            local u = missingUnits[i]
            local key = UnitRangeKey(u)
            local inRange = entry._rangeByUnit[key] == true
            miss[#miss + 1] = { unit = u, name = UnitName(u), inRange = inRange }
            if inRange then
              foundInRange = true
            else
              anyMissingOutOfRange = true
            end
          end

          local keep = {}
          for i = 1, #missingUnits do
            keep[UnitRangeKey(missingUnits[i])] = true
          end
          for key in pairs(entry._rangeByUnit) do
            if not keep[key] then
              entry._rangeByUnit[key] = nil
              entry._unitNextScanAt[key] = nil
            end
          end

          if #miss > 0 then
            anyMissing = true
          end

          local nowSuppressed = (#miss > 0) and not foundInRange
          if entry.lastSuppressed ~= nowSuppressed then
            entry.lastSuppressed = nowSuppressed
            anySuppressionChanged = true
          end

          local nowAllIn = (#miss > 0) and (foundInRange and not anyMissingOutOfRange) or false
          local desiredGlow = nowAllIn and "special" or nil

          if entry.desiredGlow ~= desiredGlow then
            entry.desiredGlow = desiredGlow
            anyGlowChanged = true
          end

          spells[#spells + 1] = { spellID = spellID, name = spellName, maxRange = maxRange, missing = miss }
        end
      end

      RangeState.spellCursor = (idx % #spellIDs) + 1
      if budget <= 0 then
        break
      end
    end
  end

  RangeState.lastSummary = { spells = spells, anyMissing = anyMissing }

  if anyMissing then
    RangeState.inactivityTicks = 0
  else
    RangeState.inactivityTicks = RangeState.inactivityTicks + 1
    if RangeState.inactivityTicks >= 2 then
      StopTicker()
    end
  end

  if anyGlowChanged and type(ns.RequestRebuild) == "function" then
    ns.RequestRebuild()
  end

  if anySuppressionChanged then
    if type(ns.MarkGatesDirty) == "function" then
      ns.MarkGatesDirty()
    end
    if type(ns.PokeUpdateBus) == "function" then
      ns.PokeUpdateBus()
    end
  end
end

local function StartTicker()
  if RangeState.ticker or not IsTickerEligible() then
    return
  end
  RangeState.inactivityTicks = 0
  RangeState.ticker = C_Timer.NewTicker(1.0, TickRangeGate)
end

function ns.InitRangeGate()
  ns._rangeTracked = ns._rangeTracked or {}
  RangeState.lastSummary = nil
end

function ns.RangeGate_OnRosterOrSpellsChanged()
  if not ns._rangeTracked then
    return
  end

  local shouldRun = false
  if next(ns._rangeTracked) then
    local units = (ns.GetGroupUnits and ns.GetGroupUnits({ includePlayer = true, onlyExisting = true })) or {}
    for _, entry in pairs(ns._rangeTracked) do
      local ids = entry.ids or {}
      if UnitHasAnyBuffFromIDs("player", ids) then
        for i = 1, #units do
          local u = units[i]
          if u ~= "player" and IsUnitEligibleForRange(u) and not UnitHasAnyBuffFromIDs(u, ids) then
            shouldRun = true
            break
          end
        end
      end
      if shouldRun then
        break
      end
    end
  end

  if shouldRun then
    StartTicker()
  else
    StopTicker()
  end
end

local function EnsureTracked(spellID, ids)
  if not ns._rangeTracked then
    ns._rangeTracked = {}
  end
  local t = ns._rangeTracked[spellID]
  if not t then
    ns._rangeTracked[spellID] = { ids = ids }
  else
    t.ids = ids
  end
end

function ns.Gate_Range(ctx, data)
  if not data or not data.spellID then
    return true
  end

  local ids = ResolveBuffIDsForData(data)
  local spellID = data.spellID
  EnsureTracked(spellID, ids)

  local playerHas = UnitHasAnyBuffFromIDs("player", ids)
  if not playerHas then
    StopTicker()
    return true
  end

  local units = (ns.GetGroupUnits and ns.GetGroupUnits({ includePlayer = true, onlyExisting = true })) or {}
  local anyMissing = false
  local anyMissingInRange = false

  for i = 1, #units do
    local u = units[i]
    if u ~= "player" and IsUnitEligibleForRange(u) and not UnitHasAnyBuffFromIDs(u, ids) then
      anyMissing = true
      local inRange = IsUnitInSpellRange(spellID, u)
      if inRange then
        anyMissingInRange = true
        break
      end
    end
  end

  if anyMissing then
    StartTicker()
  else
    StopTicker()
  end

  if not anyMissing then
    return true
  end

  if not anyMissingInRange then
    ctx.suppress = true
    return false
  end

  return true
end

ns.RegisterGate("range", function(ctx, data)
  return ns.Gate_Range(ctx, data)
end)
