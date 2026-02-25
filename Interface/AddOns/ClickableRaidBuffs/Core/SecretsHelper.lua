-- ====================================
-- \Core\SecretsHelper.lua
-- ====================================

local addonName, ns = ...

local ShouldAurasBeSecret = C_Secrets and C_Secrets.ShouldAurasBeSecret
local IsSecret = ns.Compat and ns.Compat.IsSecret

function ns.AurasAreSecret()
  return ShouldAurasBeSecret and ShouldAurasBeSecret()
end

function ns.SafeAuraSpellID(aura)
  if not aura then
    return nil
  end
  local v = aura.spellId
  if type(v) ~= "number" then
    return nil
  end
  if IsSecret and IsSecret(v) then
    return nil
  end
  return v
end

function ns.SafeAuraName(aura)
  if not aura then
    return nil
  end
  local v = aura.name
  if type(v) ~= "string" then
    return nil
  end
  if IsSecret and IsSecret(v) then
    return nil
  end
  return v
end

function ns.SafeAuraExpiration(aura, infinite)
  if not aura then
    return nil
  end
  local v = aura.expirationTime
  if type(v) ~= "number" then
    return nil
  end
  if IsSecret and IsSecret(v) then
    return nil
  end
  if infinite or v == 0 then
    return math.huge
  end
  return v
end

function ns.SafeAuraSourceUnit(aura)
  if not aura then
    return nil
  end
  local v = aura.sourceUnit
  if not v then
    return nil
  end
  if IsSecret and IsSecret(v) then
    return nil
  end
  return v
end