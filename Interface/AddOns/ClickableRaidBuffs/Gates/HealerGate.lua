-- ====================================
-- \Gates\HealerGate.lua
-- ====================================

local addonName, ns = ...

local HEALER_ROLES = {
  HEALER = true
}

local function UnitIsOtherHealer(unit)
  if not unit or not UnitExists(unit) then
    return false
  end

  if UnitIsUnit(unit, "player") then
    return false
  end

  if UnitIsDeadOrGhost(unit) then
    return false
  end

  local role = UnitGroupRolesAssigned(unit)
  if HEALER_ROLES[role] then
    return true
  end

  return false
end

function ns.PassesHealerGate()
  if not (IsInGroup() or IsInRaid()) then
    return false
  end

  if IsInRaid() then
    for i = 1, GetNumGroupMembers() do
      local unit = "raid" .. i
      if UnitIsOtherHealer(unit) then
        return true
      end
    end
  else
    for i = 1, GetNumSubgroupMembers() do
      local unit = "party" .. i
      if UnitIsOtherHealer(unit) then
        return true
      end
    end
  end

  return false
end

ns.RegisterGate("healerOnly", function()
  return ns.PassesHealerGate()
end)