-- ====================================
-- \Core\UpdateBus.lua
-- ====================================

local addonName, ns = ...
ns = ns or {}
_G[addonName] = ns

local _flags = {
  bagsDirty = false,
  rosterDirty = false,
  enchantsDirty = false,
  optionsDirty = false,
  gatesDirty = false,
}
local _aurasDirty = {}
local _dirtyBags = {}

local _updateArmed = false
local _renderPending = false
local _renderDelay = 0.05
local _updateDelay = 0.02
local _lockedRetryArmed = false
local _lockedRetryDelay = 0.10
local _deferredBagTimerArmed = false
local _deferredRaidTimerArmed = false
local _deferredUserTimerArmed = false
local _nextBagScanAt = 0
local _nextRaidScanAt = 0
local _nextUserScanAt = 0
local _forceBagScan = false
local _forceRaidScan = false

local function _getConfiguredInterval(key, fallback)
  local ddb = (ns.GetDB and ns.GetDB()) or _G.ClickableRaidBuffsDB or {}
  local raw = ddb and ddb[key]
  if raw == nil and ddb then
    raw = ddb.scanIntervalSeconds
  end
  local n = tonumber(raw)
  if n == nil then
    n = fallback
  end
  if n < 0 then
    n = 0
  end
  return n
end

local function _getBagScanInterval()
  return _getConfiguredInterval("bagRefreshSeconds", 5)
end

local function _getRaidScanInterval()
  return _getConfiguredInterval("raidRefreshSeconds", 5)
end

local function _getUserScanInterval()
  return _getConfiguredInterval("userRefreshSeconds", 1)
end

local function _armDeferredScan(kind, delay)
  local d = math.max(0.01, delay or 0.01)
  if kind == "bags" then
    if _deferredBagTimerArmed then
      return
    end
    _deferredBagTimerArmed = true
    C_Timer.After(d, function()
      _deferredBagTimerArmed = false
      if type(ns.MarkBagsDirty) == "function" then
        ns.MarkBagsDirty()
      end
      ns.PokeUpdateBus()
    end)
    return
  end
  if kind == "raid" then
    if _deferredRaidTimerArmed then
      return
    end
    _deferredRaidTimerArmed = true
    C_Timer.After(d, function()
      _deferredRaidTimerArmed = false
      if type(ns.MarkRosterDirty) == "function" then
        ns.MarkRosterDirty()
      end
      ns.PokeUpdateBus()
    end)
    return
  end
  if kind == "user" then
    if _deferredUserTimerArmed then
      return
    end
    _deferredUserTimerArmed = true
    C_Timer.After(d, function()
      _deferredUserTimerArmed = false
      if type(ns.MarkAurasDirty) == "function" then
        ns.MarkAurasDirty("player")
      end
      ns.PokeUpdateBus()
    end)
  end
end

function ns.RequestImmediateRescan(opts)
  opts = opts or {}
  local bags = (opts.bags ~= false)
  local raid = (opts.raid ~= false)
  local immediate = (opts.immediate == true)

  if bags then
    _forceBagScan = true
    if type(ns.MarkBagsDirty) == "function" then
      ns.MarkBagsDirty()
    end
  end
  if raid then
    _forceRaidScan = true
    if type(ns.MarkRosterDirty) == "function" then
      ns.MarkRosterDirty()
    end
    if type(ns.MarkAurasDirty) == "function" then
      ns.MarkAurasDirty("player")
    end
  end

  if immediate and type(ns.PokeUpdateBusImmediate) == "function" then
    ns.PokeUpdateBusImmediate()
  else
    ns.PokeUpdateBus()
  end
end

function ns.RequestImmediateGateRefresh(opts)
  opts = opts or {}
  if type(ns.MarkGatesDirty) == "function" then
    ns.MarkGatesDirty()
  end
  ns.RequestImmediateRescan({
    bags = (opts.bags ~= false),
    raid = (opts.raid ~= false),
    immediate = (opts.immediate ~= false),
  })
end

function ns.RequestImmediatePlayerAuraRefresh(opts)
  opts = opts or {}
  ns.RequestImmediateRescan({
    bags = (opts.bags == true),
    raid = (opts.raid ~= false),
    immediate = (opts.immediate ~= false),
  })
end

function ns.MarkBagsDirty(bagID)
  _flags.bagsDirty = true
  if type(bagID) == "number" then
    _dirtyBags[bagID] = true
  end
end
function ns.MarkRosterDirty()
  _flags.rosterDirty = true
end
function ns.MarkEnchantsDirty()
  _flags.enchantsDirty = true
end
function ns.MarkOptionsDirty()
  _flags.optionsDirty = true
end
function ns.MarkGatesDirty()
  _flags.gatesDirty = true
end
function ns.MarkAurasDirty(unit)
  if unit and type(unit) == "string" then
    _aurasDirty[unit] = true
  end
end

function ns.ConsumeDirtyBags(out)
  if not _flags.bagsDirty then
    return 0
  end
  local n = 0
  for b in pairs(_dirtyBags) do
    out[b] = true
    _dirtyBags[b] = nil
    n = n + 1
  end
  return n
end


local _scanWrapRetryArmed = false

local function _installScanWrappers()
  if ns._scanWrappersInstalled then
    return true
  end

  local bagFn = _G.scanAllBags
  local raidFn = _G.scanRaidBuffs
  if type(bagFn) ~= "function" or type(raidFn) ~= "function" then
    return false
  end

  ns._scanAllBagsInner = bagFn
  ns._scanRaidBuffsInner = raidFn

  _G.scanAllBags = function(...)
    if ns._allowDirectScanPassThrough and type(ns._scanAllBagsInner) == "function" then
      return ns._scanAllBagsInner(...)
    end
    if type(ns.MarkBagsDirty) == "function" then
      ns.MarkBagsDirty()
    end
    if type(ns.PokeUpdateBus) == "function" then
      ns.PokeUpdateBus()
    end
  end

  _G.scanRaidBuffs = function(...)
    if ns._allowDirectScanPassThrough and type(ns._scanRaidBuffsInner) == "function" then
      return ns._scanRaidBuffsInner(...)
    end
    if type(ns.MarkRosterDirty) == "function" then
      ns.MarkRosterDirty()
    end
    if type(ns.MarkAurasDirty) == "function" then
      ns.MarkAurasDirty("player")
    end
    if type(ns.PokeUpdateBus) == "function" then
      ns.PokeUpdateBus()
    end
  end

  ns._scanWrappersInstalled = true
  return true
end

local function _ensureScanWrappersSoon()
  if ns._scanWrappersInstalled or _scanWrapRetryArmed then
    return
  end
  _scanWrapRetryArmed = true
  C_Timer.After(0.20, function()
    _scanWrapRetryArmed = false
    if not _installScanWrappers() then
      _ensureScanWrappersSoon()
    end
  end)
end

local function _runBagScanNow()
  local fn = ns._scanAllBagsInner or _G.scanAllBags
  if type(fn) == "function" then
    return fn()
  end
end

local function _runRaidScanNow()
  local fn = ns._scanRaidBuffsInner or _G.scanRaidBuffs
  if type(fn) == "function" then
    return fn()
  end
end

local function _handleRaidScanWindow(now, raidInterval, userInterval, doRoster, doGates, hadAuras, hadNonPlayerAura, hadPlayerAura)
  if not (doRoster or hadAuras or doGates) then
    return
  end
  if type(ns._scanRaidBuffsInner or _G.scanRaidBuffs) ~= "function" then
    return
  end

  local needsRaidWindow = (doRoster or doGates or hadNonPlayerAura)
  local needsUserWindow = (hadPlayerAura and not needsRaidWindow)

  if _forceRaidScan then
    _runRaidScanNow()
    _nextRaidScanAt = now + raidInterval
    _nextUserScanAt = now + userInterval
    _forceRaidScan = false
    return
  end

  if needsRaidWindow then
    if now >= (_nextRaidScanAt or 0) then
      _runRaidScanNow()
      _nextRaidScanAt = now + raidInterval
      _nextUserScanAt = now + userInterval
    else
      _armDeferredScan("raid", (_nextRaidScanAt or now) - now)
      if type(ns.MarkRosterDirty) == "function" then
        ns.MarkRosterDirty()
      end
    end
    return
  end

  if needsUserWindow then
    if now >= (_nextUserScanAt or 0) then
      _runRaidScanNow()
      _nextUserScanAt = now + userInterval
    else
      _armDeferredScan("user", (_nextUserScanAt or now) - now)
      if type(ns.MarkAurasDirty) == "function" then
        ns.MarkAurasDirty("player")
      end
    end
  end
end

local function _callRenderNow()
  if type(ns._RenderAllInner) == "function" then
    ns._RenderAllInner()
    return
  end
  if type(ns.RenderAll) == "function" then
    ns.RenderAll()
  end
end

function ns.PushRender()
  if _renderPending then
    return
  end
  _renderPending = true
  C_Timer.After(_renderDelay, function()
    _renderPending = false
    _callRenderNow()
  end)
end

if type(ns.RenderAll) == "function" and type(ns._RenderAllInner) ~= "function" then
  ns._RenderAllInner = ns.RenderAll
  ns.RenderAll = function()
    return ns.PushRender()
  end
end

if type(ns.RequestRebuild) ~= "function" then
  function ns.RequestRebuild()
    ns.MarkOptionsDirty()
    ns.PokeUpdateBus()
  end
end

local function _recomputeGates()
  if type(getPlayerLevel) == "function" then
    getPlayerLevel()
  end
  if type(restedXPGate) == "function" then
    restedXPGate()
  else
    clickableRaidBuffCache = clickableRaidBuffCache or { playerInfo = {} }
    clickableRaidBuffCache.playerInfo.restedXPArea = IsResting()
  end
  if type(instanceGate) == "function" then
    instanceGate()
  else
    clickableRaidBuffCache = clickableRaidBuffCache or { playerInfo = {} }
    local inInst = select(1, IsInInstance())
    clickableRaidBuffCache.playerInfo.inInstance = inInst and true or false
  end
end

local function _isConsumablesSuppressed()
  if type(ns.MPlus_DisableConsumablesActive) == "function" and ns.MPlus_DisableConsumablesActive() then
    return true
  end
  local inInst = select(1, IsInInstance())
  if inInst then
    local _, _, diffID = GetInstanceInfo()
    if diffID == 8 then
      local ddb = (ns.GetDB and ns.GetDB()) or _G.ClickableRaidBuffsDB or {}
      if ddb and ddb.mplusDisableConsumables == true then
        return true
      end
    end
  end
  return false
end

local function _applyConsumableSuppressionIfActive()
  if not _isConsumablesSuppressed() then
    return false
  end
  clickableRaidBuffCache = clickableRaidBuffCache or {}
  clickableRaidBuffCache.displayable = clickableRaidBuffCache.displayable or {}
  local d = clickableRaidBuffCache.displayable
  d.FOOD, d.FLASK, d.MAIN_HAND, d.OFF_HAND = {}, {}, {}, {}
  return true
end

local function _runOnce()
  local function _hasPendingWork()
    if _flags.bagsDirty or _flags.rosterDirty or _flags.enchantsDirty or _flags.optionsDirty or _flags.gatesDirty then
      return true
    end
    return next(_aurasDirty) ~= nil
  end

  local function _armLockedRetry()
    if _lockedRetryArmed then
      return
    end
    _lockedRetryArmed = true
    C_Timer.After(_lockedRetryDelay, function()
      _lockedRetryArmed = false
      if _hasPendingWork() then
        ns.PokeUpdateBus()
      end
    end)
  end

  if
    ns
    and (
      ns._inCombat
      or (IsEncounterInProgress and IsEncounterInProgress())
      or (UnitIsDeadOrGhost and UnitIsDeadOrGhost("player"))
      or InCombatLockdown()
    )
  then
    _updateArmed = false
    _armLockedRetry()
    return
  end

  _updateArmed = false

  if not _installScanWrappers() then
    _ensureScanWrappersSoon()
  end

  local hadAuras = false
  local hadPlayerAura = false
  local hadNonPlayerAura = false
  for unit in pairs(_aurasDirty) do
    hadAuras = true
    if unit == "player" then
      hadPlayerAura = true
    else
      hadNonPlayerAura = true
    end
  end
  wipe(_aurasDirty)

  local doBags = _flags.bagsDirty
  local doRoster = _flags.rosterDirty
  local doEnchants = _flags.enchantsDirty
  local doOptions = _flags.optionsDirty
  local doGates = _flags.gatesDirty

  _flags.bagsDirty = false
  _flags.rosterDirty = false
  _flags.enchantsDirty = false
  _flags.optionsDirty = false
  _flags.gatesDirty = false

  if doGates or doRoster or doOptions or hadAuras then
    _recomputeGates()
  end

  local suppressed = _isConsumablesSuppressed()
  local now = GetTime()
  local bagInterval = _getBagScanInterval()
  local raidInterval = _getRaidScanInterval()
  local userInterval = _getUserScanInterval()

  if not suppressed and doBags and type(ns._scanAllBagsInner or _G.scanAllBags) == "function" then
    if _forceBagScan or now >= (_nextBagScanAt or 0) then
      _runBagScanNow()
      _nextBagScanAt = now + bagInterval
      _forceBagScan = false
    else
      _armDeferredScan("bags", (_nextBagScanAt or now) - now)
      if type(ns.MarkBagsDirty) == "function" then
        ns.MarkBagsDirty()
      end
    end
  end

  if (hadAuras or doOptions) and type(ns.ReapplyBagThresholds) == "function" then
    ns.ReapplyBagThresholds()
  end

  _handleRaidScanWindow(now, raidInterval, userInterval, doRoster, doGates, hadAuras, hadNonPlayerAura, hadPlayerAura)

  if (doRoster or hadAuras or doGates) and type(ns.PetAssist_Rebuild) == "function" then
    ns.PetAssist_Rebuild()
  end
  if doOptions and type(ns.UpdateAugmentRunes) == "function" then
    ns.UpdateAugmentRunes()
  end

  if doOptions then
    if type(ns.RebuildDisplayables) == "function" then
      ns.RebuildDisplayables()
    end
    if type(ns.RefreshEverything) == "function" then
      ns.RefreshEverything()
    end
  end

  ns.PushRender()

  if ns.Timer_RecomputeSchedule then
    ns.Timer_RecomputeSchedule()
  end
end

function ns.PokeUpdateBus()
  if _updateArmed then
    return
  end
  _updateArmed = true
  C_Timer.After(_updateDelay, _runOnce)
end

function ns.PokeUpdateBusImmediate()
  if _updateArmed then
    return
  end
  _updateArmed = true
  C_Timer.After(0, _runOnce)
end

if not _installScanWrappers() then
  _ensureScanWrappersSoon()
end

do
  if not ns._render_wrapped and type(ns.PushRender) == "function" and type(ns.RenderAll) == "function" then
    local _orig = ns.RenderAll
    ns.RenderAll = function(...)
      return ns.PushRender(...)
    end
    ns._render_wrapped = true
  end
end
