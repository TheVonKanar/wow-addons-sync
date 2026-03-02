-- ====================================
-- \Gates\Vehicle_Gate.lua
-- ====================================

local addonName, ns = ...

local function IsPlayerInVehicle()
  if UnitInVehicle and UnitInVehicle("player") then
    return true
  end
  if UnitHasVehicleUI and UnitHasVehicleUI("player") then
    return true
  end
  return false
end

function ns.Gate_NotInVehicle()
  return not IsPlayerInVehicle()
end

ns.RegisterGate("not_vehicle", function()
  return ns.Gate_NotInVehicle()
end)
