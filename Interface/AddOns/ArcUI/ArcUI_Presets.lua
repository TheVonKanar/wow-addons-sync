-- =====================================================================
-- ArcUI_Presets.lua — Skin snapshot, copy/paste, save/load, auto-switch
-- =====================================================================
local _, ns = ...
ns.Presets = ns.Presets or {}
local Presets = ns.Presets

-- =====================================================================
-- SKIN KEY DEFINITIONS
-- cfg.display: snapshot everything EXCEPT excluded keys.
-- cfg top-level: snapshot specific visual keys that live outside display.
-- This "exclude" approach on display is future-proof: new display
-- settings automatically get included without updating the list.
-- =====================================================================
local EXCLUDED_DISPLAY_KEYS = {
  -- Position only (size IS saved as part of the skin)
  barPosition = true,
  barMovable = true,
  textMovable = true,
  anchorPoint = true,
  anchorGroupName = true,
  anchorToGroup = true,
  anchorOffsetX = true,
  anchorOffsetY = true,
  matchGroupWidth = true,
  matchWidthAdjust = true,
  -- Frame layering (layout, not visual)
  barFrameLevel = true,
  barFrameStrata = true,
  -- State toggles (not skin)
  enabled = true,
  -- Per-icon positional data (layout, not skin)
  iconsPositions = true,
  -- Text position (layout)
  textPosition = true,
  textLocked = true,
  readyTextLocked = true,
  iconStackLocked = true,
  -- Text strata/level (frame layering)
  textLevel = true,
  textStrata = true,
  nameTextLevel = true,
  nameTextStrata = true,
  stackTextLevel = true,
  stackTextStrata = true,
  durationTextLevel = true,
  durationTextStrata = true,
  readyTextLevel = true,
  readyTextStrata = true,
}

-- Top-level (cfg.*) visual keys that live outside cfg.display
-- These are appearance-related and must be included in skin snapshots
local TOP_LEVEL_VISUAL_KEYS = {
  "thresholds",         -- Color thresholds array
  "colorRanges",        -- Segmented mode color ranges
  "abilityThresholds",  -- Ability cost threshold markers
}

-- =====================================================================
-- DEEP COPY UTILITY
-- Handles nested tables (colors, fragmentedColors, activeCountColors)
-- =====================================================================
local function DeepCopy(src)
  if type(src) ~= "table" then return src end
  local copy = {}
  for k, v in pairs(src) do
    if type(v) == "table" then
      copy[k] = DeepCopy(v)
    else
      copy[k] = v
    end
  end
  return copy
end
Presets.DeepCopy = DeepCopy

-- =====================================================================
-- SNAPSHOT: Extract skin data from a bar config
-- Returns { display = { ... }, topLevel = { ... } }
-- =====================================================================
function Presets.SnapshotSkin(barConfig)
  if not barConfig or not barConfig.display then return nil end
  local skin = { display = {}, topLevel = {} }
  -- Capture cfg.display.* (minus excluded keys)
  for k, v in pairs(barConfig.display) do
    if not EXCLUDED_DISPLAY_KEYS[k] then
      skin.display[k] = DeepCopy(v)
    end
  end
  -- Capture top-level visual keys
  for _, key in ipairs(TOP_LEVEL_VISUAL_KEYS) do
    if barConfig[key] ~= nil then
      skin.topLevel[key] = DeepCopy(barConfig[key])
    end
  end
  return skin
end

-- =====================================================================
-- APPLY: Write skin data onto a bar config
-- Only overwrites keys present in the skin; excluded keys untouched.
-- =====================================================================
function Presets.ApplySkin(barConfig, skinData)
  if not barConfig or not barConfig.display or not skinData then return false end
  -- Apply cfg.display.* keys
  local displayData = skinData.display or skinData  -- Backward compat: old snapshots were flat
  for k, v in pairs(displayData) do
    if not EXCLUDED_DISPLAY_KEYS[k] then
      barConfig.display[k] = DeepCopy(v)
    end
  end
  -- Apply top-level visual keys
  if skinData.topLevel then
    for _, key in ipairs(TOP_LEVEL_VISUAL_KEYS) do
      if skinData.topLevel[key] ~= nil then
        barConfig[key] = DeepCopy(skinData.topLevel[key])
      end
    end
  end
  -- Bust caches that depend on display settings
  barConfig.display.stackColors = nil  -- Force segmented mode rebuild
  barConfig.stackColors = nil          -- Also at top level
  return true
end

-- =====================================================================
-- BAR TYPE CLASSIFICATION
-- Groups bar types for same-type-only copy/paste.
-- =====================================================================
local BAR_TYPE_GROUPS = {
  resource = "resource",
  buff     = "buff",
  cooldown = "cooldown",  -- legacy
  timer    = "timer",
  cd_cooldown = "cooldown_system",
  cd_charge   = "cooldown_system",
  cd_resource = "cooldown_system",
}

function Presets.GetBarTypeGroup(barType)
  return BAR_TYPE_GROUPS[barType] or barType
end

function Presets.AreBarTypesCompatible(typeA, typeB)
  if not typeA or not typeB then return false end
  return Presets.GetBarTypeGroup(typeA) == Presets.GetBarTypeGroup(typeB)
end

-- =====================================================================
-- CLIPBOARD (in-memory only, not saved to DB)
-- =====================================================================
Presets.clipboard = nil  -- { data = skinTable, barType = "resource", barName = "Bar 1" }

function Presets.CopySkin(barConfig, barType, barName)
  local skin = Presets.SnapshotSkin(barConfig)
  if not skin then return false end
  Presets.clipboard = {
    data = skin,
    barType = barType or "unknown",
    barName = barName or "Unknown Bar",
  }
  return true
end

function Presets.PasteSkin(barConfig, targetBarType)
  if not Presets.clipboard then return false, "Nothing copied" end
  local sourceGroup = Presets.GetBarTypeGroup(Presets.clipboard.barType)
  local targetGroup = Presets.GetBarTypeGroup(targetBarType)
  if sourceGroup ~= targetGroup then
    return false, ("Incompatible bar types: %s → %s"):format(
      Presets.clipboard.barType, targetBarType or "unknown")
  end
  return Presets.ApplySkin(barConfig, Presets.clipboard.data), nil
end

function Presets.HasClipboard()
  return Presets.clipboard ~= nil
end

function Presets.GetClipboardInfo()
  if not Presets.clipboard then return nil end
  return Presets.clipboard.barType, Presets.clipboard.barName
end

-- =====================================================================
-- SKIN LIBRARY (saved to DB global)
-- =====================================================================
local function GetSkinLibrary()
  if not ns.db or not ns.db.global then return nil end
  if not ns.db.global.skinLibrary then
    ns.db.global.skinLibrary = {}
  end
  return ns.db.global.skinLibrary
end
Presets.GetSkinLibrary = GetSkinLibrary

function Presets.SaveSkin(name, barConfig, barType)
  local lib = GetSkinLibrary()
  if not lib then return false end
  local skin = Presets.SnapshotSkin(barConfig)
  if not skin then return false end
  lib[name] = {
    data = skin,
    barType = barType or "unknown",
    savedAt = time(),
  }
  return true
end

function Presets.LoadSkin(name, barConfig, targetBarType)
  local lib = GetSkinLibrary()
  if not lib or not lib[name] then return false, "Skin not found: " .. (name or "nil") end
  local entry = lib[name]
  local sourceGroup = Presets.GetBarTypeGroup(entry.barType)
  local targetGroup = Presets.GetBarTypeGroup(targetBarType)
  if sourceGroup ~= targetGroup then
    return false, ("Incompatible: saved as %s, target is %s"):format(entry.barType, targetBarType)
  end
  return Presets.ApplySkin(barConfig, entry.data), nil
end

function Presets.DeleteSkin(name)
  local lib = GetSkinLibrary()
  if not lib then return false end
  lib[name] = nil
  return true
end

function Presets.GetSkinNames(barType)
  local lib = GetSkinLibrary()
  if not lib then return {} end
  local names = {}
  local targetGroup = barType and Presets.GetBarTypeGroup(barType) or nil
  for name, entry in pairs(lib) do
    if not targetGroup or Presets.GetBarTypeGroup(entry.barType) == targetGroup then
      names[name] = name
    end
  end
  return names
end

function Presets.GetSkinCount()
  local lib = GetSkinLibrary()
  if not lib then return 0 end
  local count = 0
  for _ in pairs(lib) do count = count + 1 end
  return count
end

-- =====================================================================
-- AUTO-SWITCH ENGINE
-- Spec-first, then talent conditions refine.
-- Rules stored per-bar in cfg.presets.autoSwitch
-- Rule format: { specIndices = {1,2}, skinName, talentConditions (optional), talentMatchMode (optional) }
-- specIndices empty/nil = any spec. Otherwise array of spec indices (1-4).
-- =====================================================================

-- Evaluate auto-switch rules for a single bar config
-- Returns the skin name to apply, or nil if no match
-- Priority: talent-specific rules before spec-only, first match wins
function Presets.EvaluateAutoSwitch(barConfig)
  if not barConfig or not barConfig.presets then return nil end
  local as = barConfig.presets.autoSwitch
  if not as or not as.enabled or not as.rules then return nil end

  local currentSpec = GetSpecialization and GetSpecialization() or nil
  if not currentSpec then return nil end

  -- Helper: does this rule's specIndices include the current spec?
  local function SpecMatches(rule)
    if not rule.specIndices or #rule.specIndices == 0 then return true end -- empty = any
    for _, si in ipairs(rule.specIndices) do
      if si == currentSpec then return true end
    end
    return false
  end

  -- Phase 1: find talent-specific match (highest priority)
  for _, rule in ipairs(as.rules) do
    if rule.skinName and SpecMatches(rule) then
      if rule.talentConditions and #rule.talentConditions > 0 then
        if ns.TalentPicker and ns.TalentPicker.CheckTalentConditions then
          if ns.TalentPicker.CheckTalentConditions(rule.talentConditions, rule.talentMatchMode or "all") then
            return rule.skinName
          end
        end
      end
    end
  end

  -- Phase 2: spec-only fallback (no talent conditions)
  for _, rule in ipairs(as.rules) do
    if rule.skinName and SpecMatches(rule) then
      if not rule.talentConditions or #rule.talentConditions == 0 then
        return rule.skinName
      end
    end
  end

  return nil
end

-- Run auto-switch for a single bar, applying the matched skin
-- Returns true if a skin was applied
function Presets.RunAutoSwitch(barConfig, barType)
  local skinName = Presets.EvaluateAutoSwitch(barConfig)
  if not skinName then return false end
  local ok, err = Presets.LoadSkin(skinName, barConfig, barType)
  if ok then
    -- Bust caches
    barConfig.display.stackColors = nil
    return true
  else
    if ns.Debug then
      ns.Debug("Presets: auto-switch failed for skin '%s': %s", skinName, err or "unknown")
    end
    return false
  end
end

-- Run auto-switch for ALL bars (called on spec/talent change)
function Presets.RunAutoSwitchAll()
  local changed = false

  -- Resource bars
  if ns.db and ns.db.char and ns.db.char.resourceBars then
    for i, cfg in ipairs(ns.db.char.resourceBars) do
      if cfg and cfg.presets then
        if Presets.RunAutoSwitch(cfg, "resource") then
          changed = true
        end
      end
    end
  end

  -- Buff bars
  if ns.db and ns.db.char and ns.db.char.bars then
    for i, cfg in ipairs(ns.db.char.bars) do
      if cfg and cfg.presets then
        if Presets.RunAutoSwitch(cfg, "buff") then
          changed = true
        end
      end
    end
  end

  -- Cooldown bars
  if ns.db and ns.db.char and ns.db.char.cooldownBarConfigs then
    for spellID, configs in pairs(ns.db.char.cooldownBarConfigs) do
      for barType, cfg in pairs(configs) do
        if cfg and cfg.presets then
          local cdType = "cd_" .. barType
          if Presets.RunAutoSwitch(cfg, cdType) then
            changed = true
          end
        end
      end
    end
  end

  -- Timer bars
  if ns.db and ns.db.char and ns.db.char.timerBarConfigs then
    for timerID, cfg in pairs(ns.db.char.timerBarConfigs) do
      if cfg and cfg.presets then
        if Presets.RunAutoSwitch(cfg, "timer") then
          changed = true
        end
      end
    end
  end

  -- Trigger full refresh if anything changed
  if changed and ns.Resources and ns.Resources.RefreshAllBars then
    ns.Resources.RefreshAllBars()
  end
end

-- =====================================================================
-- EVENT REGISTRATION (for auto-switch triggers)
-- =====================================================================
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "PLAYER_LOGIN" then
    -- Register spec/talent change events after login
    self:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")
    self:RegisterEvent("PLAYER_TALENT_UPDATE")
    self:RegisterEvent("TRAIT_CONFIG_UPDATED")
  elseif event == "ACTIVE_PLAYER_SPECIALIZATION_CHANGED"
      or event == "PLAYER_TALENT_UPDATE"
      or event == "TRAIT_CONFIG_UPDATED" then
    -- Throttle: only run once per batch of events
    if not Presets._autoSwitchPending then
      Presets._autoSwitchPending = true
      C_Timer.After(0.2, function()
        Presets._autoSwitchPending = false
        Presets.RunAutoSwitchAll()
      end)
    end
  end
end)