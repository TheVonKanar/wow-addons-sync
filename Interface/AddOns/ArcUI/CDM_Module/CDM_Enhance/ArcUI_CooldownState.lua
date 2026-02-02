-- ===================================================================
-- ArcUI_CooldownState.lua
-- Consolidated cooldown state visual system
--
-- Replaces the 1050-line ApplyCooldownStateVisuals with clean,
-- deduplicated logic and proper error handling.
--
-- KEY FIX: Fallback alpha/desat when curve evaluation fails.
-- Previously, failed pcall silently did nothing, leaving icons
-- stuck at the wrong alpha until leaving combat.
-- ===================================================================

local ADDON, ns = ...

ns.CooldownState = ns.CooldownState or {}

-- ═══════════════════════════════════════════════════════════════════
-- DEPENDENCY REFERENCES (resolved lazily on first call)
-- ═══════════════════════════════════════════════════════════════════
local CDM  -- ns.CDMEnhance
local CooldownCurves
local InitCooldownCurves
local GetTwoStateAlphaCurve
local GetSpellCooldownState
local GetEffectiveStateVisuals
local GetEffectiveReadyAlpha
local GetGlowThresholdCurve
local ShowReadyGlow
local HideReadyGlow
local SetGlowAlpha
local ShouldShowReadyGlow
local ApplyBorderDesaturation
local ApplyBorderDesaturationFromDuration

local resolved = false

local function ResolveDependencies()
  CDM = ns.CDMEnhance
  if not CDM then return false end

  CooldownCurves              = CDM.CooldownCurves
  InitCooldownCurves          = CDM.InitCooldownCurves
  GetTwoStateAlphaCurve       = CDM.GetTwoStateAlphaCurve
  GetSpellCooldownState       = CDM.GetSpellCooldownState
  GetEffectiveStateVisuals    = CDM.GetEffectiveStateVisuals
  GetEffectiveReadyAlpha      = CDM.GetEffectiveReadyAlpha
  GetGlowThresholdCurve       = CDM.GetGlowThresholdCurve
  ShowReadyGlow               = CDM.ShowReadyGlow
  HideReadyGlow               = CDM.HideReadyGlow or function() end
  SetGlowAlpha                = CDM.SetGlowAlpha
  ShouldShowReadyGlow         = CDM.ShouldShowReadyGlow
  ApplyBorderDesaturation     = CDM.ApplyBorderDesaturation
  ApplyBorderDesaturationFromDuration = CDM.ApplyBorderDesaturationFromDuration

  resolved = true
  return true
end

-- ═══════════════════════════════════════════════════════════════════
-- SMALL HELPERS
-- ═══════════════════════════════════════════════════════════════════

-- Resolve the actual icon texture (handles bar-style icons where
-- frame.Icon is a Frame container with an Icon child texture)
local function ResolveIconTexture(frame)
  local iconTex = frame.Icon or frame.icon
  if not iconTex then return nil end
  if not iconTex.SetDesaturated and iconTex.Icon then
    iconTex = iconTex.Icon
  end
  return iconTex
end

-- Set desaturation - SetDesaturation accepts secret values directly
local function SetDesat(iconTex, value)
  if not iconTex then return end
  if iconTex.SetDesaturation then
    iconTex:SetDesaturation(value or 0)
  end
end

-- Reset duration text elements to follow parent alpha
local function ResetDurationText(frame)
  local skip = frame._arcSwipeWaitForNoCharges
  if frame._arcCooldownText and frame._arcCooldownText.SetIgnoreParentAlpha then
    if not skip then frame._arcCooldownText:SetIgnoreParentAlpha(false) end
  end
  if frame._arcChargeText and frame._arcChargeText.SetIgnoreParentAlpha then
    if not skip then frame._arcChargeText:SetIgnoreParentAlpha(false) end
  end
  if frame.Cooldown and frame.Cooldown.Text and frame.Cooldown.Text.SetIgnoreParentAlpha then
    if not skip then frame.Cooldown.Text:SetIgnoreParentAlpha(false) end
  end
end

-- Make duration text elements ignore parent alpha (stay visible when dimmed)
local function PreserveDurationText(frame)
  if frame._arcCooldownText and frame._arcCooldownText.SetIgnoreParentAlpha then
    frame._arcCooldownText:SetIgnoreParentAlpha(true)
    frame._arcCooldownText:SetAlpha(1)
  end
  if frame._arcChargeText and frame._arcChargeText.SetIgnoreParentAlpha then
    frame._arcChargeText:SetIgnoreParentAlpha(true)
    frame._arcChargeText:SetAlpha(1)
  end
  if frame.Cooldown and frame.Cooldown.Text and frame.Cooldown.Text.SetIgnoreParentAlpha then
    frame.Cooldown.Text:SetIgnoreParentAlpha(true)
    frame.Cooldown.Text:SetAlpha(1)
  end
end

-- ═══════════════════════════════════════════════════════════════════
-- CONSOLIDATED: Apply ready state visuals
-- Replaces 6+ duplicated ready-state blocks across the original
-- ═══════════════════════════════════════════════════════════════════
local function ApplyReadyState(frame, iconTex, stateVisuals)
  local effectiveReadyAlpha = GetEffectiveReadyAlpha(stateVisuals)

  -- Alpha: clear curve enforcement, set ready enforcement if needed
  frame._arcTargetAlpha = nil
  if effectiveReadyAlpha < 1.0 then
    frame._arcEnforceReadyAlpha = true
    frame._arcReadyAlphaValue = effectiveReadyAlpha
  else
    frame._arcEnforceReadyAlpha = false
    frame._arcReadyAlphaValue = nil
  end

  frame._arcBypassFrameAlphaHook = true
  frame:SetAlpha(effectiveReadyAlpha)
  frame._arcBypassFrameAlphaHook = false

  -- Desaturation: force colored
  frame._arcBypassDesatHook = true
  frame._arcForceDesatValue = nil
  SetDesat(iconTex, 0)
  frame._arcBypassDesatHook = false

  -- Border
  ApplyBorderDesaturation(frame, 0)

  -- Show frame
  frame:Show()

  -- Reset duration text
  ResetDurationText(frame)
end

-- ═══════════════════════════════════════════════════════════════════
-- CONSOLIDATED: Apply curve-based alpha from a Duration object
--
-- KEY FIX: Falls back to direct cooldownAlpha on curve failure.
-- Previously, a failed pcall left _arcTargetAlpha unset and
-- _arcEnforceReadyAlpha cleared, so CDM could override freely →
-- icon stuck at wrong alpha until leaving combat.
-- ═══════════════════════════════════════════════════════════════════
local function ApplyCurveAlpha(frame, durObj, stateVisuals, isChargeSpell)
  -- Disable ready alpha enforcement — curve handles transitions
  frame._arcEnforceReadyAlpha = false
  frame._arcReadyAlphaValue = nil

  local effectiveReadyAlpha = GetEffectiveReadyAlpha(stateVisuals)
  local alphaCurve = GetTwoStateAlphaCurve(effectiveReadyAlpha, stateVisuals.cooldownAlpha)

  if alphaCurve and durObj then
    local ok, alphaResult = pcall(function()
      return durObj:EvaluateRemainingPercent(alphaCurve)
    end)

    if ok and alphaResult ~= nil then
      -- Curve succeeded — store and apply
      frame._arcTargetAlpha = alphaResult
      frame._arcBypassFrameAlphaHook = true
      frame:SetAlpha(alphaResult)
      frame._arcBypassFrameAlphaHook = false

      -- Cooldown frame alpha (skip for charge spells with noGCDSwipe)
      local skipCooldownAlpha = isChargeSpell and frame._arcNoGCDSwipeEnabled
      if frame.Cooldown and not skipCooldownAlpha then
        if stateVisuals.preserveDurationText then
          frame.Cooldown:SetAlpha(1)
        else
          frame.Cooldown:SetAlpha(alphaResult)
        end
      end

      -- Duration text handling
      if stateVisuals.preserveDurationText then
        PreserveDurationText(frame)
      else
        ResetDurationText(frame)
      end

      return true  -- Success
    end
  end

  -- ═════════════════════════════════════════════════════════════════
  -- FALLBACK: Curve evaluation failed — apply cooldownAlpha directly
  -- This is the critical bug fix for "some spells not getting
  -- opacity changes until leaving combat"
  -- ═════════════════════════════════════════════════════════════════
  local fallbackAlpha = stateVisuals.cooldownAlpha
  frame._arcTargetAlpha = fallbackAlpha
  frame._arcBypassFrameAlphaHook = true
  frame:SetAlpha(fallbackAlpha)
  frame._arcBypassFrameAlphaHook = false

  if frame.Cooldown then
    if stateVisuals.preserveDurationText then
      frame.Cooldown:SetAlpha(1)
    else
      frame.Cooldown:SetAlpha(fallbackAlpha)
    end
  end

  if stateVisuals.preserveDurationText then
    PreserveDurationText(frame)
  else
    ResetDurationText(frame)
  end

  return false  -- Curve failed, used fallback
end

-- ═══════════════════════════════════════════════════════════════════
-- CONSOLIDATED: Apply curve-based desaturation
-- Handles cooldownDesaturate, noDesaturate, and CDM passthrough
-- ═══════════════════════════════════════════════════════════════════
local function ApplyCurveDesat(frame, iconTex, durObj, stateVisuals)
  if stateVisuals.noDesaturate then
    -- Force colored (block CDM's default desaturation)
    frame._arcForceDesatValue = 0
    frame._arcBypassDesatHook = true
    SetDesat(iconTex, 0)
    frame._arcBypassDesatHook = false
    ApplyBorderDesaturation(frame, 0)
    return true
  end

  if not stateVisuals.cooldownDesaturate then
    -- Let CDM handle desaturation (clear our forced value)
    frame._arcForceDesatValue = nil
    return true
  end

  -- cooldownDesaturate is enabled — apply curve
  if durObj and CooldownCurves and CooldownCurves.Binary then
    local ok, desatResult = pcall(function()
      return durObj:EvaluateRemainingPercent(CooldownCurves.Binary)
    end)

    if ok and desatResult ~= nil then
      frame._arcForceDesatValue = nil  -- Let curve drive it
      frame._arcBypassDesatHook = true
      SetDesat(iconTex, desatResult)
      frame._arcBypassDesatHook = false
      ApplyBorderDesaturationFromDuration(frame, durObj)
      return true
    end
  end

  -- FALLBACK: Curve failed or no durObj — force desaturated directly
  frame._arcForceDesatValue = 1
  frame._arcBypassDesatHook = true
  SetDesat(iconTex, 1)
  frame._arcBypassDesatHook = false
  ApplyBorderDesaturation(frame, 1)
  return false
end

-- ═══════════════════════════════════════════════════════════════════
-- CONSOLIDATED: Apply glow based on cooldown state
-- Handles normal spells, charge spells, glowWhileChargesAvailable
-- ═══════════════════════════════════════════════════════════════════
local function ApplyGlow(frame, stateVisuals, effectiveDurObj, isChargeSpell, durationObj, chargeDurObj, isOnGCD)
  if not ShouldShowReadyGlow(stateVisuals, frame) then
    HideReadyGlow(frame)
    return
  end

  -- Preview mode: always show
  local isPreview = ns.CDMEnhanceOptions and ns.CDMEnhanceOptions.IsGlowPreviewActive
                    and frame.cooldownID and ns.CDMEnhanceOptions.IsGlowPreviewActive(frame.cooldownID)
  if isPreview then
    ShowReadyGlow(frame, stateVisuals)
    return
  end

  if not CooldownCurves or not CooldownCurves.BinaryInv then
    HideReadyGlow(frame)
    return
  end

  -- Determine which duration object to use for glow
  local glowDurObj = effectiveDurObj
  local needsGCDFilter = false

  if isChargeSpell and stateVisuals.glowWhileChargesAvailable then
    -- Use durationObj (any charge available = glow on)
    glowDurObj = durationObj
    needsGCDFilter = true  -- durationObj includes GCD
  end

  -- GCD filter: keep glow during GCD
  if needsGCDFilter and isOnGCD then
    SetGlowAlpha(frame, 1.0, stateVisuals)
    return
  end

  -- Apply curve
  if glowDurObj then
    local ok, glowAlpha = pcall(function()
      return glowDurObj:EvaluateRemainingPercent(CooldownCurves.BinaryInv)
    end)
    if ok and glowAlpha ~= nil then
      SetGlowAlpha(frame, glowAlpha, stateVisuals)
      return
    end
  end

  -- No duration object or curve failed
  HideReadyGlow(frame)
end

-- Show/hide ready glow based on state
local function ApplyReadyGlow(frame, stateVisuals)
  if ShouldShowReadyGlow(stateVisuals, frame) then
    ShowReadyGlow(frame, stateVisuals)
  else
    HideReadyGlow(frame)
  end
end


-- ═══════════════════════════════════════════════════════════════════
-- PATH A: Ignore Aura Override
-- Shows spell cooldown state instead of aura duration.
-- Handles alpha, desaturation, glow — then returns.
-- ═══════════════════════════════════════════════════════════════════
local function HandleIgnoreAuraOverride(frame, iconTex, cfg, stateVisuals)
  local spellID = cfg._spellID
  if not spellID and frame.cooldownInfo then
    spellID = frame.cooldownInfo.overrideSpellID or frame.cooldownInfo.spellID
  end

  if not spellID then
    frame._arcReadyForGlow = false
    HideReadyGlow(frame)
    return
  end

  local isOnGCD, durationObj, isChargeSpell, chargeDurObj = GetSpellCooldownState(spellID)

  -- effectiveDurObj: chargeDurObj for charge spells, durationObj for normal
  local effectiveDurObj = isChargeSpell and chargeDurObj or durationObj
  -- desatDurObj: always durationObj (tracks "any charge on CD" for charge spells)
  local desatDurObj = durationObj

  frame:Show()

  -- GCD filter for normal spells: show as ready during GCD
  if not isChargeSpell and isOnGCD then
    ApplyReadyState(frame, iconTex, stateVisuals)
    ApplyReadyGlow(frame, stateVisuals)
    return
  end

  -- ALPHA: curve on effectiveDurObj
  ApplyCurveAlpha(frame, effectiveDurObj, stateVisuals, isChargeSpell)

  -- DURATION TEXT: Explicit handling for ignoreAuraOverride path
  -- ApplyCurveAlpha's ResetDurationText can be blocked by _arcSwipeWaitForNoCharges,
  -- so we force the correct state here regardless
  if stateVisuals.preserveDurationText then
    if frame.Cooldown then frame.Cooldown:SetAlpha(1) end
    PreserveDurationText(frame)
  else
    if frame.Cooldown and frame._arcTargetAlpha then
      frame.Cooldown:SetAlpha(frame._arcTargetAlpha)
    end
    -- Force reset — don't check _arcSwipeWaitForNoCharges
    if frame._arcCooldownText and frame._arcCooldownText.SetIgnoreParentAlpha then
      frame._arcCooldownText:SetIgnoreParentAlpha(false)
    end
    if frame._arcChargeText and frame._arcChargeText.SetIgnoreParentAlpha then
      frame._arcChargeText:SetIgnoreParentAlpha(false)
    end
    if frame.Cooldown and frame.Cooldown.Text and frame.Cooldown.Text.SetIgnoreParentAlpha then
      frame.Cooldown.Text:SetIgnoreParentAlpha(false)
    end
  end

  -- DESATURATION: For ignoreAuraOverride, the aura being active is EXPECTED
  -- (selfAura buffs, totem frames, buff icon frames). Unlike HandleCooldownLogic
  -- where hasActiveAuraDisplay skips desat for target debuffs like Kidney Shot,
  -- here we always base desat on the COOLDOWN state since that's what we're showing.
  -- ApplyCurveDesat handles: noDesaturate → cooldownDesaturate → curve → fallback
  ApplyCurveDesat(frame, iconTex, desatDurObj, stateVisuals)
  -- Border sync: charge spell GCD = no desat, otherwise follow duration
  if isChargeSpell and isOnGCD then
    ApplyBorderDesaturation(frame, 0)
  elseif not stateVisuals.noDesaturate then
    ApplyBorderDesaturationFromDuration(frame, desatDurObj)
  end

  -- GLOW
  ApplyGlow(frame, stateVisuals, effectiveDurObj, isChargeSpell, durationObj, chargeDurObj, isOnGCD)
end


-- ═══════════════════════════════════════════════════════════════════
-- PATH B: Aura Logic (buffs / debuffs / totems)
-- Uses event-driven caching from OptimizedApplyIconVisuals.
-- Skips recalculation when _arcTarget* flags are already set.
-- ═══════════════════════════════════════════════════════════════════
local function HandleAuraLogic(frame, iconTex, cfg, stateVisuals)
  local auraID = frame.auraInstanceID
  local isReady = (auraID and type(auraID) == "number" and auraID > 0)
                  or (frame.totemData ~= nil)

  -- ALPHA (skip if OptimizedApplyIconVisuals already set it)
  if frame._arcTargetAlpha == nil then
    local targetAlpha
    if isReady then
      local effectiveReadyAlpha = GetEffectiveReadyAlpha(stateVisuals)
      targetAlpha = effectiveReadyAlpha
      if effectiveReadyAlpha < 1.0 then
        frame._arcEnforceReadyAlpha = true
        frame._arcReadyAlphaValue = effectiveReadyAlpha
      else
        frame._arcEnforceReadyAlpha = false
      end
    else
      frame._arcEnforceReadyAlpha = false
      local cdAlpha = stateVisuals.cooldownAlpha
      if cdAlpha <= 0 then
        if ns.CDMEnhance.IsOptionsPanelOpen and ns.CDMEnhance.IsOptionsPanelOpen() then
          targetAlpha = 0.35
        else
          targetAlpha = 0
        end
      else
        targetAlpha = cdAlpha
      end
    end

    frame._arcTargetAlpha = targetAlpha
    frame._arcBypassFrameAlphaHook = true
    frame:SetAlpha(targetAlpha)
    if frame.Cooldown then frame.Cooldown:SetAlpha(targetAlpha) end
    frame._arcBypassFrameAlphaHook = false

    if not frame:IsShown() then frame:Show() end
  end

  -- DESATURATION (skip if already set)
  if frame._arcTargetDesat == nil then
    local targetDesat
    if isReady then
      targetDesat = 0
    else
      targetDesat = stateVisuals.cooldownDesaturate and 1 or 0
    end

    frame._arcBypassDesatHook = true
    SetDesat(iconTex, targetDesat)
    frame._arcBypassDesatHook = false
    frame._arcTargetDesat = targetDesat
    ApplyBorderDesaturation(frame, targetDesat)
  end

  -- TINT (skip if already set)
  if frame._arcTargetTint == nil then
    local tR, tG, tB = 1, 1, 1
    if not isReady and stateVisuals.cooldownTint and stateVisuals.cooldownTintColor then
      local col = stateVisuals.cooldownTintColor
      tR, tG, tB = col.r or 0.5, col.g or 0.5, col.b or 0.5
    end
    frame._arcTargetTint = string.format("%.2f,%.2f,%.2f", tR, tG, tB)
    if iconTex then iconTex:SetVertexColor(tR, tG, tB) end
  end

  -- GLOW (skip if already handled)
  if frame._arcTargetGlow == nil then
    if ShouldShowReadyGlow(stateVisuals, frame) and isReady then
      local threshold = stateVisuals.glowThreshold or 1.0

      if threshold < 1.0 and auraID then
        -- Threshold glow: use curve
        local auraType = stateVisuals.glowAuraType or "auto"
        local unit = "player"
        if auraType == "debuff" then
          unit = "target"
        elseif auraType == "auto" then
          local cat = frame.category
          if cat == 3 then unit = "target" end
        end

        local auraDurObj = C_UnitAuras and C_UnitAuras.GetAuraDuration
                           and C_UnitAuras.GetAuraDuration(unit, auraID)
        if auraDurObj then
          local thresholdCurve = GetGlowThresholdCurve(threshold)
          if thresholdCurve then
            local ok, glowAlpha = pcall(function()
              return auraDurObj:EvaluateRemainingPercent(thresholdCurve)
            end)
            if ok and glowAlpha ~= nil then
              SetGlowAlpha(frame, glowAlpha, stateVisuals)
            else
              ShowReadyGlow(frame, stateVisuals)
            end
          else
            ShowReadyGlow(frame, stateVisuals)
          end
        else
          ShowReadyGlow(frame, stateVisuals)
        end
      else
        ShowReadyGlow(frame, stateVisuals)
      end
    else
      HideReadyGlow(frame)
    end
    frame._arcTargetGlow = true
  end
end


-- ═══════════════════════════════════════════════════════════════════
-- PATH C: Cooldown Logic (spells with cooldowns)
-- ═══════════════════════════════════════════════════════════════════
local function HandleCooldownLogic(frame, iconTex, cfg, stateVisuals)
  local spellID = cfg._spellID
  if not spellID and frame.cooldownInfo then
    spellID = frame.cooldownInfo.overrideSpellID or frame.cooldownInfo.spellID
  end

  -- C1: No spell ID → ready state
  if not spellID then
    ApplyReadyState(frame, iconTex, stateVisuals)
    ApplyReadyGlow(frame, stateVisuals)
    return
  end

  -- Get cooldown state
  local isOnGCD, durationObj, isChargeSpell, chargeDurObj = GetSpellCooldownState(spellID)
  local effectiveDurObj = isChargeSpell and chargeDurObj or durationObj

  -- Check if an aura is actively displaying on this cooldown frame
  -- (e.g. Kidney Shot on CD but its stun debuff is active on target)
  -- When the spell's effect is visually active, don't desaturate the icon
  local auraID = frame.auraInstanceID
  local hasActiveAuraDisplay = (auraID and type(auraID) == "number" and auraID > 0)
                               or (frame.totemData ~= nil)

  InitCooldownCurves()

  -- C2: GCD filter for normal spells — treat as ready during GCD
  if not isChargeSpell and isOnGCD then
    ApplyReadyState(frame, iconTex, stateVisuals)
    -- Hide swipe during GCD if noGCDSwipe enabled
    if frame.Cooldown and frame._arcNoGCDSwipeEnabled then
      frame._arcBypassSwipeHook = true
      frame.Cooldown:SetDrawSwipe(false)
      frame.Cooldown:SetDrawEdge(false)
      frame._arcBypassSwipeHook = false
    end
    ApplyReadyGlow(frame, stateVisuals)
    return
  end

  -- C3: GCD filter for charge spells with glowWhileChargesAvailable
  if isChargeSpell and isOnGCD and stateVisuals.glowWhileChargesAvailable then
    ApplyReadyState(frame, iconTex, stateVisuals)
    ApplyReadyGlow(frame, stateVisuals)
    return
  end

  -- C4: waitForNoCharges mode
  if isChargeSpell and stateVisuals.waitForNoCharges then
    if isOnGCD then
      -- FREEZE during GCD: show as ready (hides phantom CD flicker)
      ApplyReadyState(frame, iconTex, stateVisuals)

      -- Glow: conditional on glowWhileChargesAvailable
      if ShouldShowReadyGlow(stateVisuals, frame) then
        if stateVisuals.glowWhileChargesAvailable then
          ShowReadyGlow(frame, stateVisuals)
        elseif chargeDurObj and CooldownCurves and CooldownCurves.BinaryInv then
          local ok, glowAlpha = pcall(function()
            return chargeDurObj:EvaluateRemainingPercent(CooldownCurves.BinaryInv)
          end)
          if ok and glowAlpha ~= nil then
            SetGlowAlpha(frame, glowAlpha, stateVisuals)
          else
            HideReadyGlow(frame)
          end
        else
          HideReadyGlow(frame)
        end
      else
        HideReadyGlow(frame)
      end
      return
    else
      -- Not on GCD: apply curves using durationObj (not chargeDurObj!)
      frame:Show()
      ApplyCurveAlpha(frame, durationObj, stateVisuals, isChargeSpell)

      -- Skip desat if aura is actively displayed (spell effect is visually happening)
      if hasActiveAuraDisplay then
        frame._arcForceDesatValue = 0
        frame._arcBypassDesatHook = true
        SetDesat(iconTex, 0)
        frame._arcBypassDesatHook = false
        ApplyBorderDesaturation(frame, 0)
      else
        ApplyCurveDesat(frame, iconTex, durationObj, stateVisuals)
      end

      -- Border sync (ApplyCurveDesat may have synced already, but this
      -- handles the "let CDM handle" case where border still needs update)
      ApplyBorderDesaturationFromDuration(frame, durationObj)

      -- Glow for waitForNoCharges
      ApplyGlow(frame, stateVisuals, chargeDurObj, isChargeSpell, durationObj, chargeDurObj, isOnGCD)
      return
    end
  end

  -- C5: Normal cooldown curve path
  if effectiveDurObj and CooldownCurves and CooldownCurves.initialized then
    frame:Show()
    ApplyCurveAlpha(frame, effectiveDurObj, stateVisuals, isChargeSpell)

    -- Skip desat if aura is actively displayed (spell effect is visually happening)
    if hasActiveAuraDisplay then
      frame._arcForceDesatValue = 0
      frame._arcBypassDesatHook = true
      SetDesat(iconTex, 0)
      frame._arcBypassDesatHook = false
      ApplyBorderDesaturation(frame, 0)
    else
      ApplyCurveDesat(frame, iconTex, effectiveDurObj, stateVisuals)

      -- Border sync (skip if noDesaturate already handled it in ApplyCurveDesat)
      if not stateVisuals.noDesaturate then
        ApplyBorderDesaturationFromDuration(frame, effectiveDurObj)
      end
    end

    -- Glow
    ApplyGlow(frame, stateVisuals, effectiveDurObj, isChargeSpell, durationObj, chargeDurObj, isOnGCD)
    return
  end

  -- C6: Fallback — no data, assume ready
  ApplyReadyState(frame, iconTex, stateVisuals)
  ApplyReadyGlow(frame, stateVisuals)
end


-- ═══════════════════════════════════════════════════════════════════
-- MAIN DISPATCHER
-- Drop-in replacement for ApplyCooldownStateVisuals
-- Same signature: (frame, cfg, normalAlpha, stateVisuals)
-- ═══════════════════════════════════════════════════════════════════
local function NewApplyCooldownStateVisuals(frame, cfg, normalAlpha, stateVisuals)
  if not frame then return end

  -- Lazy-init dependencies on first call
  if not resolved then
    if not ResolveDependencies() then return end
  end

  -- Arc Auras handles its own cooldown state visuals
  if frame._arcConfig or frame._arcAuraID then return end

  local iconTex = ResolveIconTexture(frame)
  if not iconTex then return end

  -- Get state visuals if not passed (caller may pass for perf)
  if not stateVisuals then
    stateVisuals = GetEffectiveStateVisuals(cfg)
  end

  -- Check glow preview
  local cdID = frame.cooldownID
  local isGlowPreview = cdID and ns.CDMEnhanceOptions
                        and ns.CDMEnhanceOptions.IsGlowPreviewActive
                        and ns.CDMEnhanceOptions.IsGlowPreviewActive(cdID)

  -- Check ignoreAuraOverride
  local ignoreAuraOverride = (cfg.auraActiveState and cfg.auraActiveState.ignoreAuraOverride)
                          or (cfg.cooldownSwipe and cfg.cooldownSwipe.ignoreAuraOverride)

  -- No state visuals + no preview + no ignoreAuraOverride → let CDM handle
  if not stateVisuals and not isGlowPreview and not ignoreAuraOverride then
    frame._arcForceDesatValue = nil
    frame._arcReadyForGlow = false
    HideReadyGlow(frame)

    -- Reset desaturation (CDM doesn't always push desat=0)
    SetDesat(iconTex, 0)
    iconTex:SetVertexColor(1, 1, 1)
    ApplyBorderDesaturation(frame, 0)
    return
  end

  -- Build default stateVisuals if needed (for preview / ignoreAuraOverride)
  if not stateVisuals then
    local rs = cfg.cooldownStateVisuals and cfg.cooldownStateVisuals.readyState or {}
    stateVisuals = {
      readyAlpha          = 1.0,
      readyGlow           = isGlowPreview and true or (rs.glow == true),
      readyGlowType       = rs.glowType or "button",
      readyGlowColor      = rs.glowColor,
      readyGlowIntensity  = rs.glowIntensity or 1.0,
      readyGlowScale      = rs.glowScale or 1.0,
      readyGlowSpeed      = rs.glowSpeed or 0.25,
      readyGlowLines      = rs.glowLines or 8,
      readyGlowThickness  = rs.glowThickness or 2,
      readyGlowParticles  = rs.glowParticles or 4,
      readyGlowXOffset    = rs.glowXOffset or 0,
      readyGlowYOffset    = rs.glowYOffset or 0,
      cooldownAlpha       = 1.0,
    }
  end

  -- Preview mode: show glow immediately
  if isGlowPreview then
    ShowReadyGlow(frame, stateVisuals)
    return
  end

  -- Ensure curves are initialized
  InitCooldownCurves()

  -- Detect what kind of icon this is
  local useAuraLogic = cfg._isAura or false
  -- Route based on what CDM is CURRENTLY doing with this frame:
  --   wasSetFromAura = CDM actively showing aura duration (runtime flag)
  --   totemData      = totem frame (always aura logic)
  -- NOTE: cooldownInfo.hasAura means "spell CAN produce auras" (e.g. Kidney Shot's
  --   target stun), NOT that CDM is showing aura data. Using it for routing incorrectly
  --   sends cooldown-tracked frames (wasSetFromCooldown=true) through aura logic.
  if not useAuraLogic then
    if frame.totemData ~= nil then
      useAuraLogic = true
    elseif frame.wasSetFromAura == true then
      useAuraLogic = true
    end
  end

  -- Update ignoreAuraOverride flag on frame
  frame._arcIgnoreAuraOverride = ignoreAuraOverride or false

  -- ═════════════════════════════════════════════════════════════════
  -- DISPATCH to the appropriate handler
  -- ═════════════════════════════════════════════════════════════════
  if ignoreAuraOverride then
    -- Smart ignoreAuraOverride: only apply when CDM would actually show
    -- aura duration for this frame. The override is meaningless for frames
    -- that CDM already tracks via cooldown.
    --   hasAura = true   → CDM shows aura duration (self-buff OR target debuff)
    --   selfAura = true  → subset of hasAura (Icy Veins, etc.)
    --   cfg._isAura      → ArcUI buff icon frame
    --   totemData         → totem frame
    -- hasAura covers both selfAura (self-buffs like Icy Veins) and target
    -- debuffs (Kidney Shot, Rupture) where CDM switches to aura display
    -- when the effect is active. Pure cooldown-only spells have hasAura=false.
    local cooldownInfo = frame.cooldownInfo
    local cdmWouldShowAura = cfg._isAura
                             or (frame.totemData ~= nil)
                             or (cooldownInfo and cooldownInfo.hasAura == true)
    if cdmWouldShowAura then
      HandleIgnoreAuraOverride(frame, iconTex, cfg, stateVisuals)
    elseif useAuraLogic then
      HandleAuraLogic(frame, iconTex, cfg, stateVisuals)
    else
      HandleCooldownLogic(frame, iconTex, cfg, stateVisuals)
    end
  elseif useAuraLogic then
    HandleAuraLogic(frame, iconTex, cfg, stateVisuals)
  else
    HandleCooldownLogic(frame, iconTex, cfg, stateVisuals)
  end
end


-- ═══════════════════════════════════════════════════════════════════
-- INSTALL: Override the CDMEnhance function
-- Because CDMEnhance makes its local a relay (see CDMEnhance changes),
-- all internal call sites now route through this new implementation.
-- ═══════════════════════════════════════════════════════════════════
ns.CDMEnhance.ApplyCooldownStateVisuals = NewApplyCooldownStateVisuals

-- Export sub-functions for testing / external use
ns.CooldownState.Apply              = NewApplyCooldownStateVisuals
ns.CooldownState.ApplyReadyState    = ApplyReadyState
ns.CooldownState.ApplyCurveAlpha    = ApplyCurveAlpha
ns.CooldownState.ApplyCurveDesat    = ApplyCurveDesat
ns.CooldownState.ApplyGlow          = ApplyGlow
ns.CooldownState.ApplyReadyGlow     = ApplyReadyGlow
ns.CooldownState.ResolveIconTexture = ResolveIconTexture