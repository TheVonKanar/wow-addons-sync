-- ====================================
-- \UI\Timer.lua
-- ====================================

local addonName, ns = ...
ns = ns or {}
local IsSecret = ns.Compat and ns.Compat.IsSecret

local function now()
  return GetTimePreciseSec()
end

local function fmt_bottom(remaining)
  remaining = math.max(0, remaining)
  local m = math.floor(remaining / 60)
  local s = math.floor(remaining % 60)
  if m <= 0 then
    return ("0:%02d"):format(s)
  else
    return ("%d:%02d"):format(m, s)
  end
end

local function updateBottomTimer(btn, entry, tNow)
  local tt = btn and btn.timerText
  if not (tt and entry) then
    return
  end

  local function ensureAnchor()
    local bt = btn.bottomText
    local hasBottom = bt and bt:IsShown() and (bt:GetText() or "") ~= ""

    if hasBottom then
      if tt._crb_anchor_mode ~= "under_bottom" then
        tt:ClearAllPoints()
        tt:SetPoint("TOP", bt, "BOTTOM", 0, -2)
        tt._crb_anchor_mode = "under_bottom"
      end
    else
      if tt._crb_anchor_mode ~= "under_button" then
        tt:ClearAllPoints()
        tt:SetPoint("TOP", btn, "BOTTOM", 0, -5)
        tt._crb_anchor_mode = "under_button"
      end
    end
  end

  if IsSecret and entry.expireTime and IsSecret(entry.expireTime) then
    if tt:IsShown() then
      tt:Hide()
    end
    return
  end
  if entry.category ~= "EATING" and entry.expireTime and entry.expireTime ~= math.huge then
    local remaining = entry.expireTime - tNow

    if entry.category == "AUGMENT_RUNE" then
      if remaining > 0 then
        ensureAnchor()
        local formatted = fmt_bottom(remaining)
        if tt:GetText() ~= formatted then
          local db = (ns.GetDB and ns.GetDB()) or {}
          ns.UpdateFontString(
            tt,
            formatted,
            db.fontName or "Fonts\\FRIZQT__.TTF",
            db.timerBottomSize or 14,
            db.timerBottomOutline ~= false,
            db.timerBottomColor or { r = 1, g = 1, b = 1, a = 1 }
          )
        end
        if not tt:IsShown() then
          tt:Show()
        end
        return
      end
    else
      if remaining > -1 then
        ensureAnchor()
        local formatted = fmt_bottom(remaining)
        if tt:GetText() ~= formatted then
          local db = (ns.GetDB and ns.GetDB()) or {}
          ns.UpdateFontString(
            tt,
            formatted,
            db.fontName or "Fonts\\FRIZQT__.TTF",
            db.timerBottomSize or 12,
            db.timerBottomOutline ~= false,
            db.timerBottomColor or { r = 1, g = 1, b = 1, a = 1 }
          )
        end
        if not tt:IsShown() then
          tt:Show()
        end
        return
      end
    end
  end

  if tt:IsShown() then
    tt:Hide()
  end
end

local _ticker

local function stopTicker()
  if _ticker and _ticker.Cancel then
    _ticker:Cancel()
  end
  _ticker = nil
end

local function processPendingShowAt(catTable, tNow, markFired)
  if type(catTable) ~= "table" then
    return false
  end

  local hasPending = false
  for _, e in pairs(catTable) do
    if e and e.showAt then
      if e.showAt > tNow then
        e._crb_showAt_fired = nil
        hasPending = true
      elseif not e._crb_showAt_fired then
        hasPending = true
        if markFired then
          e._crb_showAt_fired = true
        end
      end
    end
  end

  return hasPending
end

local function anyActive(tNow)
  local frames = ns.RenderFrames
  if not (frames and #frames > 0) then
    return false
  end
  for i = 1, #frames do
    local btn = frames[i]
    if btn and btn:IsShown() then
      if btn._crb_cd_start and btn._crb_cd_dur then
        local endsAt = btn._crb_cd_start + btn._crb_cd_dur
        if endsAt - tNow > 0 then
          return true
        end
      end
      local e = btn._crb_entry
      if e and e.category ~= "EATING" and e.expireTime and e.expireTime ~= math.huge then
        if IsSecret and IsSecret(e.expireTime) then
        else
          local rem = e.expireTime - tNow
          if e.category == "AUGMENT_RUNE" then
            if rem > 0 then
              return true
            end
          else
            if rem > -1 then
              return true
            end
          end
        end
      end
    end
  end
  local disp = _G.clickableRaidBuffCache and _G.clickableRaidBuffCache.displayable
  if processPendingShowAt(disp and disp.AUGMENT_RUNE, tNow, false) then
    return true
  end
  if processPendingShowAt(disp and disp.CUSTOM_AURAS, tNow, false) then
    return true
  end
  return false
end

local function tick()
  if
    ns._inCombat
    or (IsEncounterInProgress and IsEncounterInProgress())
    or (UnitIsDeadOrGhost and UnitIsDeadOrGhost("player"))
    or InCombatLockdown()
  then
    stopTicker()
    return
  end

  local t2 = now()

  local disp = _G.clickableRaidBuffCache and _G.clickableRaidBuffCache.displayable
  if processPendingShowAt(disp and disp.AUGMENT_RUNE, t2, true) and type(ns.UpdateAugmentRunes) == "function" then
    ns.UpdateAugmentRunes()
  end

  if processPendingShowAt(disp and disp.CUSTOM_AURAS, t2, true) and type(ns.RenderAll) == "function" then
    ns.RenderAll()
  end

  local frames = ns.RenderFrames
  if frames then
    for i = 1, #frames do
      local btn = frames[i]
      if btn and btn:IsShown() then
        if ns.CooldownTick and btn._crb_cd_start and btn._crb_cd_dur then
          ns.CooldownTick(btn)
        end
        local e = btn._crb_entry
        if e then
          updateBottomTimer(btn, e, t2)
          if e.category ~= "EATING" and e.expireTime and e.expireTime ~= math.huge then
            if IsSecret and IsSecret(e.expireTime) then
              -- Skip secret values.
            else
              if e.category == "AUGMENT_RUNE" then
                if (t2 - e.expireTime) >= 0 then
                  if type(ns.UpdateAugmentRunes) == "function" then
                    ns.UpdateAugmentRunes()
                  end
                end
              else
                if (t2 - e.expireTime) >= 1.0 then
                  btn:Hide()
                end
              end
            end
          end
        end
      end
    end
  end

  if not anyActive(now()) then
    stopTicker()
  end
end

function ns.Timer_RecomputeSchedule()
  if
    ns._inCombat
    or (IsEncounterInProgress and IsEncounterInProgress())
    or (UnitIsDeadOrGhost and UnitIsDeadOrGhost("player"))
    or InCombatLockdown()
  then
    stopTicker()
    return
  end
  if not _ticker then
    if anyActive(now()) then
      _ticker = C_Timer.NewTicker(0.2, tick)
    end
  end
end

function ns.Timer_Stop()
  stopTicker()
end

do
  if type(ns.Cooldown_RefreshAll) == "function" and not ns._crb_cd_refresh_wrapped then
    local _orig = ns.Cooldown_RefreshAll
    ns.Cooldown_RefreshAll = function(...)
      local r = _orig(...)
      if ns.Timer_RecomputeSchedule then
        ns.Timer_RecomputeSchedule()
      end
      return r
    end
    ns._crb_cd_refresh_wrapped = true
  end
end
