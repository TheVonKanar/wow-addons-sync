-- ====================================
-- \Modules\PetAssist.lua
-- ====================================

local addonName, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
clickableRaidBuffCache = clickableRaidBuffCache or {}
clickableRaidBuffCache.displayable = clickableRaidBuffCache.displayable or {}
clickableRaidBuffCache.playerInfo = clickableRaidBuffCache.playerInfo or {}

local CAT = "PET_ASSIST"
local ICON_PASSIVE = 132311

local function InCombat()
  return InCombatLockdown()
end

local function ensureDisplayCat()
  clickableRaidBuffCache.displayable[CAT] =
    clickableRaidBuffCache.displayable[CAT] or {}
  return clickableRaidBuffCache.displayable[CAT]
end

local function clearDisplayCat()
  if clickableRaidBuffCache.displayable[CAT] then
    wipe(clickableRaidBuffCache.displayable[CAT])
  end
end

local function HasUsablePet()
  if not UnitExists("pet") then
    return false
  end
  if UnitIsDeadOrGhost and UnitIsDeadOrGhost("pet") then
    return false
  end
  return true
end

local function IsPetInPassiveStance()
  if not UnitExists("pet") then
    return false
  end

  for i = 1, NUM_PET_ACTION_SLOTS do
    local name, _, _, isActive = GetPetActionInfo(i)
    if name and isActive and string.find(name, "PASSIVE") then
      return true
    end
  end

  return false
end

local function Build()
  if InCombat() then
    return
  end

  clearDisplayCat()

  if not HasUsablePet() then
    return
  end

  if not IsPetInPassiveStance() then
    return
  end

  local entry = {
    id = -9104,
    spellID = -9104,
    category = CAT,
    isItem = false,
    name = "Pet is Passive",
    icon = ICON_PASSIVE,
    macro = "/petassist",
    topLbl = L["Passive"],
    btmLbl = "",
    orderHint = 10,
    gates = { "alive", "not_mounted", "rested" },
  }

  local pi = clickableRaidBuffCache.playerInfo or {}
  local playerLevel = pi.playerLevel or UnitLevel("player") or 0
  local inInstance = pi.inInstance
  local rested = pi.restedXPArea

  if not ns.PassesGates or not ns.PassesGates(entry, playerLevel, inInstance, rested) then
    return
  end

  local out = ensureDisplayCat()
  out["pet:assist"] = entry
end

function ns.PetAssist_Rebuild()
  if InCombat() then
    return
  end

  Build()

  if type(ns.MarkGatesDirty) == "function" then
    ns.MarkGatesDirty()
  end

  if type(ns.PokeUpdateBus) == "function" then
    ns.PokeUpdateBus()
  end
end

function ns.PetAssist_OnPEW()
  ns.PetAssist_Rebuild()
  return true
end

function ns.PetAssist_OnUnitPet(unit)
  if unit ~= "player" then
    return false
  end
  ns.PetAssist_Rebuild()
  return true
end

function ns.PetAssist_OnPetBarUpdate()
  ns.PetAssist_Rebuild()
  return true
end

function ns.PetAssist_OnRegenEnabled()
  ns.PetAssist_Rebuild()
  return true
end

function ns.PetAssist_OnRegenDisabled()
  clearDisplayCat()
  if type(ns.MarkGatesDirty) == "function" then
    ns.MarkGatesDirty()
  end
  return true
end