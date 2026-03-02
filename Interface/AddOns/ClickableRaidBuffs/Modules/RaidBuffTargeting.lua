-- ====================================
-- \Modules\RaidBuffTargeting.lua
-- ====================================

local addonName, ns = ...

local NAME_TRUNCATE = 6

local function DB()
  return (ns.GetDB and ns.GetDB()) or ClickableRaidBuffsDB or {}
end

clickableRaidBuffCache = clickableRaidBuffCache or {}
clickableRaidBuffCache.targetedRaid = clickableRaidBuffCache.targetedRaid or {}

local function ShortNameNoRealm(name)
  if not name then
    return ""
  end
  local base = name:gsub("%-.+$", "")
  if #base <= NAME_TRUNCATE then
    return base
  end
  return base:sub(1, NAME_TRUNCATE)
end

local function InMyGroup(unitOrName)
  if not unitOrName then
    return false
  end
  if UnitExists(unitOrName) then
    return UnitInParty(unitOrName) or UnitInRaid(unitOrName) or UnitIsUnit(unitOrName, "player")
  end
  for i = 1, 40 do
    local u = (IsInRaid() and ("raid" .. i)) or ("party" .. i)
    if UnitExists(u) and UnitName(u) == unitOrName then
      return true
    end
  end
  return (UnitName("player") == unitOrName)
end

local function CloneOverlay(baseEntry, macroText, label)
  local e = {}
  for k, v in pairs(baseEntry) do
    e[k] = v
  end
  e.category = "RAID_BUFFS"
  e.bottomText = label
  e.macro = macroText
  e.targeted = true
  return e
end

local function GetSpellName(spellID)
  local name = spellID and C_Spell and C_Spell.GetSpellName and C_Spell.GetSpellName(spellID)
  if name then
    return name
  end
  if C_Spell and C_Spell.GetSpellInfo then
    local info = C_Spell.GetSpellInfo(spellID)
    return info and info.name or nil
  end
  return nil
end

local function RequestRaidRefresh()
  if ns.MarkRosterDirty then
    ns.MarkRosterDirty()
  end
  if ns.PokeUpdateBus then
    ns.PokeUpdateBus()
  end
end

local function OnRosterChanged()
  RequestRaidRefresh()
  if InCombatLockdown() or UnitIsDeadOrGhost("player") then
    return
  end
  if ns.PushRender then
    ns.PushRender()
  elseif ns.RenderAll then
    ns.RenderAll()
  end
end

local function OnPEW()
  RequestRaidRefresh()
  if ns.PushRender then
    ns.PushRender()
  elseif ns.RenderAll then
    ns.RenderAll()
  end
end

local WatchedSpell = {}

local function IsRaidAuraUnit(unit)
  if unit == "player" then
    return true
  end
  if type(unit) ~= "string" then
    return false
  end
  return unit:match("^party%d+$") or unit:match("^raid%d+$")
end

local function OnUnitAura(unit, updateInfo)
  if not unit or not updateInfo or not IsRaidAuraUnit(unit) then
    return
  end
  -- Fast path: no watched spells means there is nothing to rebuild from aura churn.
  if not next(WatchedSpell) then
    return
  end
  if not updateInfo.addedAuras and not updateInfo.removedAuraInstanceIDs and not updateInfo.updatedAuraInstanceIDs then
    return
  end

  local raid = ClickableRaidData and ClickableRaidData["RAID_BUFFS"]
  if type(raid) ~= "table" then
    return
  end

  local changed = false
  for castSpellID in pairs(WatchedSpell) do
    local baseEntry = raid[castSpellID]
    if baseEntry and baseEntry.count then
      local key = "fixed:" .. tostring(castSpellID)
      local who = clickableRaidBuffCache.targetedRaid[castSpellID]
      if who and InMyGroup(who) then
        local sName = GetSpellName(castSpellID)
        if sName then
          local macroP = "/use [@" .. who .. ",help,nodead] " .. sName
          local prev = raid[key]
          local nextEntry = CloneOverlay(baseEntry, macroP, ShortNameNoRealm(who))
          if not prev or prev.macro ~= nextEntry.macro or prev.bottomText ~= nextEntry.bottomText then
            raid[key] = nextEntry
            changed = true
          end
        end
      end
    end
  end

  if not changed then
    return
  end
  if ns.PushRender then
    ns.PushRender()
  elseif ns.RenderAll then
    ns.RenderAll()
  end
end

function ns.RaidBuffTargeting_OnRosterChanged()
  OnRosterChanged()
end

function ns.RaidBuffTargeting_OnPEW()
  OnPEW()
end

function ns.RaidBuffTargeting_OnUnitAura(unit, updateInfo)
  OnUnitAura(unit, updateInfo)
end
