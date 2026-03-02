-- ═══════════════════════════════════════════════════════════════════════════
-- ArcUI_Glows.lua — Unified glow module for ArcUI
--
-- Single API for all glow types across CDMEnhance and ArcAurasCooldown.
--
-- SUPPORTED GLOW TYPES:
--   LCG (LibCustomGlow):
--     "pixel"     — marching dots around frame edge
--     "autocast"  — spinning particle sparkles
--     "button"    — classic WoW action button glow
--     "proc"      — Blizzard-style proc flipbook (burst intro → loop)
--                    Also accepted as "blizzard" for backwards compat
--
--   Blizzard Templates (ArcUI-owned frames):
--     "ants"      — ActionBarButtonAssistedCombatHighlightTemplate
--     "ach_proc"  — ActionButtonSpellAlertTemplate (loop only, no burst)
--
--   CDM Native (passthrough):
--     "default"   — CDM's own SpellActivationAlert (managed by CDM, not us)
--
-- USAGE:
--   ns.Glows.Start(frame, "ready", "pixel", { color = {1,0.8,0,1}, lines = 8 })
--   ns.Glows.Stop(frame, "ready")
--   ns.Glows.StopAll(frame)
--
-- KEYS:
--   Each key ("ready", "usable", "proc", "aura", etc.) is independent.
--   Multiple keys can be active on the same frame simultaneously.
--   LCG supports per-key storage natively. Blizzard templates are cached
--   on the frame by composite key (e.g. frame._arcGlow_ants_ready).
--
-- OPTIONS SUPPORT MATRIX (queried via ns.Glows.GetSupportedOpts):
--   Option      | pixel | autocast | button | proc  | ants  | ach_proc
--   ------------|-------|----------|--------|-------|-------|----------
--   color       |  yes  |   yes    |  yes   |  yes  |  yes  |   yes
--   intensity   |  yes  |   yes    |   —    |  yes  |  yes  |   yes
--   scale       | thick |  native  | frame  | frame |  yes  |   yes
--   speed       |  yes  |   yes    |  yes   |   —   |   —   |    —
--   lines       |  yes  |    —     |   —    |   —   |   —   |    —
--   thickness   |  yes  |    —     |   —    |   —   |   —   |    —
--   length      |  yes  |    —     |   —    |   —   |   —   |    —
--   border      |  yes  |    —     |   —    |   —   |   —   |    —
--   particles   |   —   |   yes    |   —    |   —   |   —   |    —
--   xOffset     |  yes  |   yes    |   —    |  yes  |  yes  |   yes
--   yOffset     |  yes  |   yes    |   —    |  yes  |  yes  |   yes
--   frameLevel  |  yes  |   yes    |  yes   |  yes  |  yes  |   yes
--   strata      |  yes  |   yes    |  yes   |  yes  |  yes  |   yes
--
-- Scale behavior:
--   pixel    → baked into thickness (thickness * scale), not SetScale
--   autocast → LCG native particle scale param, not SetScale
--   button/proc → SetScale on glow frame
--   ants/ach_proc → direct sizing in template code
-- ═══════════════════════════════════════════════════════════════════════════

local _, ns = ...

ns.Glows = {}

-- ── Lazy references ──────────────────────────────────────────────────────

local LCG
local function GetLCG()
    if not LCG then
        LCG = LibStub and LibStub("LibCustomGlow-1.0", true)
    end
    return LCG
end

-- ── State tracking ───────────────────────────────────────────────────────
-- activeGlows[frame][key] = { type = glowType, opts = opts }
-- Caches opts so Resize can re-call Start (WeakAuras pattern).
-- Weak keys: if a frame is destroyed without StopAll, it gets GC'd.

local activeGlows = setmetatable({}, { __mode = "k" })

-- ── Constants ────────────────────────────────────────────────────────────

-- Sizing ratios from Blizzard's ActionButtonSpellAlertTemplate XML:
--   Default icon = 45x45, container ~66x66
local BLIZZ_CONTAINER_RATIO = 66 / 45   -- ~1.467

-- Default glow frame level offset above parent
local GLOW_LEVEL_OFFSET = 8

-- Shallow copy for opts caching (prevents stale data if caller reuses table)
local function ShallowCopy(t)
    if not t then return {} end
    local copy = {}
    for k, v in pairs(t) do copy[k] = v end
    return copy
end

-- Get storage key for a Blizzard template glow on a frame
local function BlizzKey(glowType, key)
    return "_arcGlow_" .. glowType .. "_" .. (key or "")
end

-- ═══════════════════════════════════════════════════════════════════════════
-- MASQUE SHAPE MATCHING
-- If Masque is skinning an icon with a non-square shape (circle, diamond,
-- hexagon), glow textures must match. This queries Masque's public API
-- and swaps flipbook textures on our Blizzard-template and LCG glows.
-- No-op when Masque is absent or using default square skin.
-- ═══════════════════════════════════════════════════════════════════════════

local MasqueLib  -- cached on first use

local function GetMasqueLib()
    if MasqueLib ~= nil then return MasqueLib end  -- false = checked, not found
    MasqueLib = LibStub and LibStub("Masque", true) or false
    return MasqueLib
end

local function GetMasqueShape(frame)
    if not frame then return nil end
    -- Respect user toggle: disable Masque shape-matching for glows
    if ns.db and ns.db.profile and ns.db.profile.cdmEnhance
        and ns.db.profile.cdmEnhance.glowUseMasqueShapes == false then
        return nil
    end
    local mcfg = frame._MSQ_CFG
    if not mcfg then return nil end
    if not mcfg.Enabled or mcfg.BaseSkin then return nil end
    return mcfg.Shape
end

-- Find the FlipBook animation child from an AnimationGroup
local function GetFlipBookAnim(animGroup)
    if not animGroup then return nil end
    for _, child in pairs({ animGroup:GetAnimations() }) do
        if child and child.SetFlipBookFrameWidth then return child end
    end
    return nil
end

-- Apply Masque shape textures to a Blizzard-template glow (ach_proc uses this)
local function ApplyMasqueShapeToTemplateProc(frame, glow)
    local shape = GetMasqueShape(frame)
    if not shape then return end
    local lib = GetMasqueLib()
    if not lib or not lib.GetSpellAlertFlipBook then return end

    local ok, flipData = pcall(lib.GetSpellAlertFlipBook, lib, "Modern", shape)
    if not ok or not flipData then
        ok, flipData = pcall(lib.GetSpellAlertFlipBook, lib, "Classic", shape)
    end
    if not ok or not flipData then return end

    -- Loop texture
    if flipData.LoopTexture and glow.ProcLoopFlipbook then
        glow.ProcLoopFlipbook:SetTexture(flipData.LoopTexture)
    end

    -- Start texture — ach_proc hides start, but guard for safety
    if glow.ProcStartFlipbook then
        if flipData.StartTexture then
            glow.ProcStartFlipbook:SetTexture(flipData.StartTexture)
            glow._Loop_Only = nil
        else
            glow._Loop_Only = true
            glow.ProcStartFlipbook:Hide()
            if glow.ProcStartAnim then
                local anim = GetFlipBookAnim(glow.ProcStartAnim)
                if anim then anim:SetDuration(0) end
            end
        end
    end

    -- Animation dimensions — ProcLoop
    local loopGroup = glow.ProcLoopAnim or glow.ProcLoop
    if loopGroup and flipData.FrameWidth then
        local anim = GetFlipBookAnim(loopGroup)
        if anim then
            anim:SetFlipBookFrameWidth(flipData.FrameWidth)
            anim:SetFlipBookFrameHeight(flipData.FrameHeight or 0)
        end
    end

    -- Animation dimensions — ProcStart
    if glow.ProcStartAnim and flipData.FrameWidth then
        local anim = GetFlipBookAnim(glow.ProcStartAnim)
        if anim then
            anim:SetFlipBookFrameWidth(flipData.FrameWidth)
            anim:SetFlipBookFrameHeight(flipData.FrameHeight or 0)
        end
    end

    -- AltGlow texture (some shapes provide it)
    if glow.ProcAltGlow and shape then
        local altPath = [[Interface\AddOns\Masque\Textures\]] .. shape .. [[\SpellAlert-AltGlow]]
        glow.ProcAltGlow:SetTexture(altPath)
    end
end

-- Apply Masque shape to LCG ProcGlow (uses .ProcStart/.ProcLoop, not Flipbook names)
local function ApplyMasqueShapeToLCGProc(frame, glowFrame)
    local shape = GetMasqueShape(frame)
    if not shape then return end
    local lib = GetMasqueLib()
    if not lib or not lib.GetSpellAlertFlipBook then return end

    local ok, flipData = pcall(lib.GetSpellAlertFlipBook, lib, "Modern", shape)
    if not ok or not flipData then
        ok, flipData = pcall(lib.GetSpellAlertFlipBook, lib, "Classic", shape)
    end
    if not ok or not flipData then return end

    -- LCG naming: .ProcLoop / .ProcStart (not .ProcLoopFlipbook)
    if flipData.LoopTexture and glowFrame.ProcLoop then
        glowFrame.ProcLoop:SetTexture(flipData.LoopTexture)
    end
    if glowFrame.ProcStart then
        glowFrame.ProcStart:SetTexture(flipData.StartTexture or flipData.LoopTexture or "")
    end

    -- Animation dimensions
    if glowFrame.ProcLoopAnim and flipData.FrameWidth then
        local anim = glowFrame.ProcLoopAnim.FlipAnim or GetFlipBookAnim(glowFrame.ProcLoopAnim)
        if anim then
            anim:SetFlipBookFrameWidth(flipData.FrameWidth)
            anim:SetFlipBookFrameHeight(flipData.FrameHeight or 0)
        end
    end
    if glowFrame.ProcStartAnim and flipData.FrameWidth then
        local anim = glowFrame.ProcStartAnim.FlipAnim or GetFlipBookAnim(glowFrame.ProcStartAnim)
        if anim then
            anim:SetFlipBookFrameWidth(flipData.FrameWidth)
            anim:SetFlipBookFrameHeight(flipData.FrameHeight or 0)
        end
    end
end

-- Apply Masque shape to ants (AssistedCombatHighlight) glow
local function ApplyMasqueShapeToAnts(frame, glow)
    if not glow or not glow.Flipbook then return end
    local shape = GetMasqueShape(frame)
    if not shape then return end
    local lib = GetMasqueLib()
    if not lib or not lib.GetAssistedCombatHighlightStyle then return end

    local ok, styleData = pcall(lib.GetAssistedCombatHighlightStyle, lib, shape)
    if not ok or not styleData then return end

    if styleData.Texture then
        glow.Flipbook:SetTexture(styleData.Texture)
    end
    if styleData.TexCoords then
        local tc = styleData.TexCoords
        glow.Flipbook:SetTexCoord(tc[1] or 0, tc[2] or 1, tc[3] or 0, tc[4] or 1)
    end
    if glow.Flipbook.Anim and styleData.FrameWidth then
        local anim = GetFlipBookAnim(glow.Flipbook.Anim)
        if anim then
            anim:SetFlipBookFrameWidth(styleData.FrameWidth)
            anim:SetFlipBookFrameHeight(styleData.FrameHeight or 0)
        end
        -- Reinitialize to pick up new texture/frame dimensions.
        -- If the glow is currently visible, restart the animation instead of stopping it.
        if glow:IsShown() then
            glow.Flipbook.Anim:Stop()
            glow.Flipbook.Anim:Play()
        else
            glow.Flipbook.Anim:Play()
            glow.Flipbook.Anim:Stop()
        end
    end
end

-- Apply Masque shape to LCG ButtonGlow via Masque's UpdateSpellAlert API
local function ApplyMasqueShapeToButton(frame, key)
    local shape = GetMasqueShape(frame)
    if not shape then return end
    local lib = GetMasqueLib()
    if not lib or not lib.UpdateSpellAlert then return end

    local glowFrame = frame["_ButtonGlow" .. key]
    if not glowFrame then return end
    pcall(lib.UpdateSpellAlert, lib, frame, glowFrame)
end

-- ── Master dispatcher: call after Start() creates/shows a glow ───────────
local function ApplyMasqueShape(frame, glowType, key)
    if not GetMasqueShape(frame) then return end

    if glowType == "proc" then
        local glowFrame = frame["_ProcGlow" .. key]
        if glowFrame then ApplyMasqueShapeToLCGProc(frame, glowFrame) end

    elseif glowType == "ach_proc" then
        local storageKey = BlizzKey("ach_proc", key)
        local glow = frame[storageKey]
        if glow then ApplyMasqueShapeToTemplateProc(frame, glow) end

    elseif glowType == "ants" then
        local storageKey = BlizzKey("ants", key)
        local glow = frame[storageKey]
        if glow then ApplyMasqueShapeToAnts(frame, glow) end

    elseif glowType == "button" then
        ApplyMasqueShapeToButton(frame, key)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- LCG POST-START HELPERS
-- After LCG creates/shows a glow frame, apply options that LCG doesn't
-- handle natively: intensity (alpha), strata override, scale.
-- ═══════════════════════════════════════════════════════════════════════════

-- Map glowType+key → LCG frame reference on parent
local function GetLCGFrame(frame, glowType, key)
    if glowType == "pixel" then
        return frame["_PixelGlow" .. key]
    elseif glowType == "autocast" then
        return frame["_AutoCastGlow" .. key]
    elseif glowType == "button" then
        return frame._ButtonGlow
    elseif glowType == "proc" then
        return frame["_ProcGlow" .. key]
    end
    return nil
end

local function ApplyPostStartOpts(frame, glowType, key, opts)
    local glowFrame = GetLCGFrame(frame, glowType, key)
    if not glowFrame then return end

    -- Enforce glow frame dimensions to match parent frame.
    -- The old CDMEnhance overlay called SetSize(frameW, frameH) before every
    -- LCG call. Without this, Masque-skinned frames can report stale layout
    -- dimensions to LCG at creation time, causing undersized glows.
    local pw, ph = frame:GetWidth(), frame:GetHeight()
    if pw and ph and pw > 1 and ph > 1 and glowType ~= "button" then
        -- Button glow manages its own internal texture sizing
        glowFrame:SetSize(pw, ph)
    end

    -- Intensity (alpha override) — skip button, it has own fade animations
    if opts.intensity and glowType ~= "button" then
        glowFrame:SetAlpha(opts.intensity)
    end

    -- Scale via SetScale — skip pixel (baked into thickness) and autocast (native param)
    if glowType ~= "autocast" and glowType ~= "pixel" then
        if opts.scale and opts.scale ~= 1 then
            glowFrame:SetScale(opts.scale)
            glowFrame._arcGlowScaleOverride = opts.scale
        elseif glowFrame._arcGlowScaleOverride then
            glowFrame:SetScale(1)
            glowFrame._arcGlowScaleOverride = nil
        end
    end

    -- Strata override
    if opts.strata and opts.strata ~= "inherit" then
        pcall(glowFrame.SetFrameStrata, glowFrame, opts.strata)
        glowFrame._arcGlowStrataOverride = opts.strata
    elseif glowFrame._arcGlowStrataOverride then
        local parentStrata = frame:GetFrameStrata() or "MEDIUM"
        pcall(glowFrame.SetFrameStrata, glowFrame, parentStrata)
        glowFrame._arcGlowStrataOverride = nil
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- BLIZZARD TEMPLATE GLOW HELPERS
-- Ants and ACH-Proc use Blizzard XML templates (not LCG).
-- Cached on the frame by composite key to avoid re-creation.
-- ═══════════════════════════════════════════════════════════════════════════

local function GetOrCreateACHGlow(frame, style, key)
    local storageKey = BlizzKey(style, key)
    if frame[storageKey] then return frame[storageKey] end

    local glow
    if style == "ants" then
        glow = CreateFrame("Frame", nil, frame, "ActionBarButtonAssistedCombatHighlightTemplate")
        if not glow then return nil end
        glow._achStyle = "ants"
        if glow.Flipbook and glow.Flipbook.Anim then
            glow.Flipbook.Anim:Play()
            glow.Flipbook.Anim:Stop()
        end
    elseif style == "ach_proc" then
        glow = CreateFrame("Frame", nil, frame, "ActionButtonSpellAlertTemplate")
        if not glow then return nil end
        glow._achStyle = "ach_proc"
        if glow.ProcLoopFlipbook then
            glow.ProcLoopFlipbook:SetAlpha(1)
            glow.ProcLoopFlipbook:Show()
        end
        if glow.ProcLoop then
            glow.ProcLoop:Play()
            glow.ProcLoop:Stop()
        end
    else
        return nil
    end

    glow:SetPoint("CENTER")
    glow:Hide()
    frame[storageKey] = glow

    -- Apply Masque shape BEFORE first show (prevents square→circle flash)
    if style == "ants" then
        ApplyMasqueShapeToAnts(frame, glow)
    elseif style == "ach_proc" then
        ApplyMasqueShapeToTemplateProc(frame, glow)
    end

    return glow
end

local function ShowACHGlow(frame, style, key, opts)
    local glow = GetOrCreateACHGlow(frame, style, key)
    if not glow then return end

    local w, h = frame:GetWidth(), frame:GetHeight()
    if w <= 0 or h <= 0 then return end

    local scale = opts.scale or 1.0
    -- Square Masque skins make ach_proc oversized — default to 0.8 if user hasn't set scale
    if style == "ach_proc" and not opts.scale and GetMasqueShape(frame) == "Square" then
        scale = 0.8
    end
    local xOff = opts.xOffset or 0
    local yOff = opts.yOffset or 0
    local containerW = w * BLIZZ_CONTAINER_RATIO * scale
    local containerH = h * BLIZZ_CONTAINER_RATIO * scale

    if style == "ants" then
        -- ACH pattern: container = icon size, flipbook texture = expanded beyond
        local iconW = w * scale
        local iconH = h * scale
        glow:SetSize(iconW, iconH)
        if glow.Flipbook then
            glow.Flipbook:SetSize(iconW * BLIZZ_CONTAINER_RATIO, iconH * BLIZZ_CONTAINER_RATIO)
        end
    elseif style == "ach_proc" then
        glow:SetSize(containerW, containerH)
        if glow.ProcStartFlipbook then glow.ProcStartFlipbook:Hide() end
    end

    -- Position with offset (only re-anchor if offset is non-zero)
    if xOff ~= 0 or yOff ~= 0 then
        glow:ClearAllPoints()
        glow:SetPoint("CENTER", frame, "CENTER", xOff, yOff)
    end

    glow:SetFrameLevel(frame:GetFrameLevel() + (opts.frameLevel or GLOW_LEVEL_OFFSET))

    -- Color
    local color = opts.color
    if color then
        local r = color[1] or color.r or 1
        local g = color[2] or color.g or 1
        local b = color[3] or color.b or 1
        local a = color[4] or color.a or 1

        if style == "ants" and glow.Flipbook then
            local hasCustomColor = not (r >= 0.99 and g >= 0.99 and b >= 0.99)
            glow.Flipbook:SetDesaturated(hasCustomColor)
            glow.Flipbook:SetVertexColor(r, g, b, a)
        elseif style == "ach_proc" then
            local hasCustomColor = not (r >= 0.99 and g >= 0.99 and b >= 0.99)
            if glow.ProcLoopFlipbook then
                glow.ProcLoopFlipbook:SetDesaturated(hasCustomColor)
                glow.ProcLoopFlipbook:SetVertexColor(r, g, b, a)
            end
            if glow.ProcAltGlow then
                glow.ProcAltGlow:SetDesaturated(hasCustomColor)
                glow.ProcAltGlow:SetVertexColor(r, g, b, a)
            end
        end
    end

    -- Intensity (alpha)
    glow:SetAlpha(opts.intensity or 1.0)

    -- Strata override
    if opts.strata and opts.strata ~= "inherit" then
        pcall(glow.SetFrameStrata, glow, opts.strata)
        glow._arcGlowStrataOverride = opts.strata
    elseif glow._arcGlowStrataOverride then
        local parentStrata = frame:GetFrameStrata() or "MEDIUM"
        pcall(glow.SetFrameStrata, glow, parentStrata)
        glow._arcGlowStrataOverride = nil
    end

    -- Show + play
    glow:Show()
    if style == "ants" and glow.Flipbook and glow.Flipbook.Anim then
        if not glow.Flipbook.Anim:IsPlaying() then
            glow.Flipbook.Anim:Play()
        end
    elseif style == "ach_proc" then
        if glow.ProcLoopFlipbook then
            glow.ProcLoopFlipbook:Show()
            glow.ProcLoopFlipbook:SetAlpha(1)
        end
        if glow.ProcLoop and not glow.ProcLoop:IsPlaying() then
            glow.ProcLoop:Play()
        end
    end
end

local function HideACHGlow(frame, style, key)
    local storageKey = BlizzKey(style, key)
    local glow = frame[storageKey]
    if not glow then return end

    if style == "ants" then
        if glow.Flipbook and glow.Flipbook.Anim and glow.Flipbook.Anim:IsPlaying() then
            glow.Flipbook.Anim:Stop()
        end
    elseif style == "ach_proc" then
        if glow.ProcLoop and glow.ProcLoop:IsPlaying() then
            glow.ProcLoop:Stop()
        end
        if glow.ProcLoopFlipbook then glow.ProcLoopFlipbook:Hide() end
    end

    glow:Hide()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- PUBLIC API
-- ═══════════════════════════════════════════════════════════════════════════

--- Start a glow on a frame.
-- @param frame     The icon frame to glow
-- @param key       Glow slot: "ready", "usable", "proc", "aura", etc.
-- @param glowType  One of: "pixel", "autocast", "button", "proc",
--                  "blizzard" (alias for proc), "ants", "ach_proc", "default"
-- @param opts      Table of glow parameters (all optional):
--   color       {r, g, b, a} or {[1]=r, [2]=g, [3]=b, [4]=a}
--   intensity   alpha override 0-1, default 1 (not button — has own fade)
--   scale       size multiplier, default 1 (all types)
--   lines       (pixel) number of lines, default 8
--   frequency   (pixel/autocast/button) speed, default 0.25
--   length      (pixel) line length
--   thickness   (pixel) line thickness, default 2
--   particles   (autocast) particle groups, default 4
--   xOffset     offset from frame edge, default 0 (not button)
--   yOffset     offset from frame edge, default 0 (not button)
--   frameLevel  override frame level offset (default GLOW_LEVEL_OFFSET)
--   strata      frame strata override, "inherit" or "LOW"/"MEDIUM"/"HIGH"/"DIALOG"
--   startAnim   (proc only) play burst intro, default false
--   duration    (proc only) loop duration, default 1
function ns.Glows.Start(frame, key, glowType, opts)
    if not frame or not key or not glowType then return end
    opts = opts or {}

    -- Normalize "blizzard" → "proc" (merged — both use LCG ProcGlow)
    if glowType == "blizzard" then glowType = "proc" end

    -- If this key already has a DIFFERENT type active, stop it first
    local current = activeGlows[frame] and activeGlows[frame][key]
    if current and current.type ~= glowType then
        ns.Glows.Stop(frame, key)
    end

    -- Normalize color to array format for LCG
    local color = opts.color
    local colorArray
    if color then
        if color.r then
            colorArray = { color.r, color.g or 1, color.b or 1, color.a or 1 }
        else
            colorArray = color
        end
    end

    local lvl = opts.frameLevel or GLOW_LEVEL_OFFSET

    -- ── LCG types ────────────────────────────────────────────────────
    if glowType == "pixel" then
        local lib = GetLCG()
        if not lib then return end
        -- Bake scale into thickness (old CDMEnhance pattern) rather than SetScale
        -- SetScale would expand the entire glow frame including offsets
        local scale = opts.scale or 1
        local t = opts.thickness or 2
        if scale ~= 1 then t = math.max(1, math.floor(t * scale)) end
        lib.PixelGlow_Start(
            frame, colorArray,
            opts.lines or 8,
            opts.frequency or 0.25,
            opts.length,
            t,
            opts.xOffset or 0,
            opts.yOffset or 0,
            opts.border ~= false,  -- default true: lines orbit frame edges
            key,
            lvl
        )
        ApplyPostStartOpts(frame, glowType, key, opts)

    elseif glowType == "autocast" then
        local lib = GetLCG()
        if not lib then return end
        lib.AutoCastGlow_Start(
            frame, colorArray,
            opts.particles or 4,
            opts.frequency or 0.25,
            opts.scale or 1,  -- native particle scale (orbit radius stays at frame edge)
            opts.xOffset or 0,
            opts.yOffset or 0,
            key,
            lvl
        )
        ApplyPostStartOpts(frame, glowType, key, opts)

    elseif glowType == "button" then
        local lib = GetLCG()
        if not lib then return end
        lib.ButtonGlow_Start(
            frame, colorArray,
            opts.frequency or 0.125,
            lvl,
            key
        )
        ApplyPostStartOpts(frame, glowType, key, opts)

    elseif glowType == "proc" then
        local lib = GetLCG()
        if not lib then return end
        lib.ProcGlow_Start(frame, {
            key        = key,
            frameLevel = lvl,
            color      = colorArray,
            startAnim  = opts.startAnim or false,
            duration   = opts.duration or 1,
            xOffset    = opts.xOffset or 0,
            yOffset    = opts.yOffset or 0,
        })
        ApplyPostStartOpts(frame, glowType, key, opts)

    -- ── Blizzard template types ──────────────────────────────────────
    elseif glowType == "ants" then
        ShowACHGlow(frame, "ants", key, opts)

    elseif glowType == "ach_proc" then
        ShowACHGlow(frame, "ach_proc", key, opts)

    elseif glowType == "default" then
        -- "default" = CDM's own SpellActivationAlert, not managed by us.
        -- Caller is responsible for CDM interaction. This is a no-op marker
        -- so StopAll knows a glow context is active.

    else
        return  -- Unknown type, don't track
    end

    -- Track (cache opts for Resize)
    if not activeGlows[frame] then
        activeGlows[frame] = {}
    end
    activeGlows[frame][key] = { type = glowType, opts = ShallowCopy(opts) }

    -- Apply Masque shape textures if Masque is skinning this frame.
    ApplyMasqueShape(frame, glowType, key)

    -- Auto-hook OnSizeChanged once per frame (WeakAuras pattern).
    if not frame._arcGlowSizeHooked then
        frame._arcGlowSizeHooked = true
        local throttle = 0
        frame:HookScript("OnSizeChanged", function(self)
            if not activeGlows[self] then return end
            local now = GetTime()
            if now == throttle then return end
            throttle = now
            if self:GetWidth() < 1 or self:GetHeight() < 1 then return end
            ns.Glows.ResizeAll(self)
        end)
    end
end

--- Stop a glow on a frame by key.
function ns.Glows.Stop(frame, key)
    if not frame or not key then return end

    local frameGlows = activeGlows[frame]
    if not frameGlows then return end

    local entry = frameGlows[key]
    if not entry then return end

    local glowType = entry.type

    local lib = GetLCG()
    if glowType == "pixel" and lib then
        lib.PixelGlow_Stop(frame, key)
    elseif glowType == "autocast" and lib then
        lib.AutoCastGlow_Stop(frame, key)
    elseif glowType == "button" and lib then
        lib.ButtonGlow_Stop(frame, key)
    elseif glowType == "proc" and lib then
        if lib.ProcGlow_Stop then
            lib.ProcGlow_Stop(frame, key)
        end
    elseif glowType == "ants" then
        HideACHGlow(frame, "ants", key)
    elseif glowType == "ach_proc" then
        HideACHGlow(frame, "ach_proc", key)
    end

    frameGlows[key] = nil
    -- Clear forced alpha state if it was set for this key
    if frame._arcForcedGlowAlpha ~= nil then
        frame._arcForcedGlowAlpha = nil
    end
    if not next(frameGlows) then
        activeGlows[frame] = nil
    end
end

--- Stop ALL glows on a frame (all keys).
function ns.Glows.StopAll(frame)
    if not frame then return end
    local frameGlows = activeGlows[frame]
    if not frameGlows then return end

    local keys = {}
    for key in pairs(frameGlows) do
        keys[#keys + 1] = key
    end
    for _, key in ipairs(keys) do
        ns.Glows.Stop(frame, key)
    end
end

--- Check if a specific glow key is active on a frame.
function ns.Glows.IsActive(frame, key)
    if not frame or not key then return nil end
    local frameGlows = activeGlows[frame]
    local entry = frameGlows and frameGlows[key]
    return entry and entry.type
end

--- Get all active glow keys on a frame.
function ns.Glows.GetActive(frame)
    if not frame then return nil end
    local frameGlows = activeGlows[frame]
    if not frameGlows then return nil end
    local result = {}
    for key, entry in pairs(frameGlows) do
        result[key] = entry.type
    end
    return result
end

--- Get the actual LCG child frame for a glow key.
--- Use this to drive secret-safe SetAlpha() from curve evaluators.
--- Returns the LCG glow frame (or ACH template frame), or nil if not active.
function ns.Glows.GetGlowFrame(frame, key)
    if not frame or not key then return nil end
    local frameGlows = activeGlows[frame]
    local entry = frameGlows and frameGlows[key]
    if not entry then return nil end
    local t = entry.type
    if t == "pixel" then
        return frame["_PixelGlow" .. key]
    elseif t == "autocast" then
        return frame["_AutoCastGlow" .. key]
    elseif t == "button" then
        return frame._ButtonGlow
    elseif t == "proc" then
        return frame["_ProcGlow" .. key]
    elseif t == "ants" then
        return frame["_AchAnts" .. key]
    elseif t == "ach_proc" then
        return frame["_AchProc" .. key]
    end
    return nil
end

--- Set a forced alpha on a glow frame (secret-safe).
--- Hooks the glow frame's SetAlpha so LCG animations can't override the forced value.
--- Used by CooldownState's threshold curve to drive glow visibility with secret values.
--- @param frame Frame The icon frame that owns the glow
--- @param key string The glow key (e.g. "ArcUI_ReadyGlow")
--- @param alpha number|secret The forced alpha value (0 = hidden, 1 = visible)
function ns.Glows.SetForcedAlpha(frame, key, alpha)
    if not frame or not key then return end
    local gf = ns.Glows.GetGlowFrame(frame, key)
    if not gf then return end
    -- Hook SetAlpha once to enforce forced value over LCG animation callbacks
    if not gf._arcForcedAlphaHooked then
        gf._arcForcedAlphaHooked = true
        local origSetAlpha = gf.SetAlpha
        gf.SetAlpha = function(self, a)
            local owner = self._arcForcedAlphaOwner
            if owner and owner._arcForcedGlowAlpha ~= nil then
                origSetAlpha(self, owner._arcForcedGlowAlpha)
            else
                origSetAlpha(self, a)
            end
        end
    end
    gf._arcForcedAlphaOwner = frame
    frame._arcForcedGlowAlpha = alpha
    gf:SetAlpha(alpha)
end

--- Clear forced alpha on a glow, restoring normal LCG alpha control.
function ns.Glows.ClearForcedAlpha(frame, key)
    if not frame then return end
    frame._arcForcedGlowAlpha = nil
    local gf = ns.Glows.GetGlowFrame(frame, key)
    if gf then
        gf._arcForcedAlphaOwner = nil
    end
end

--- Resize a specific glow after the parent frame changed size.
function ns.Glows.Resize(frame, key)
    if not frame or not key then return end
    local frameGlows = activeGlows[frame]
    if not frameGlows then return end
    local entry = frameGlows[key]
    if not entry then return end
    ns.Glows.Start(frame, key, entry.type, entry.opts)
end

--- Resize ALL active glows on a frame.
function ns.Glows.ResizeAll(frame)
    if not frame then return end
    local frameGlows = activeGlows[frame]
    if not frameGlows then return end
    for key, entry in pairs(frameGlows) do
        ns.Glows.Start(frame, key, entry.type, entry.opts)
    end
end

--- Force-hide a glow frame instantly (bypasses ButtonGlow fade animation).
function ns.Glows.ForceHide(frame, key)
    if not frame or not key then return end

    local frameGlows = activeGlows[frame]
    if not frameGlows then return end

    local entry = frameGlows[key]
    if not entry then return end

    -- For LCG types, find and instantly hide the glow frame
    local glowFrame = GetLCGFrame(frame, entry.type, key)
    if glowFrame then
        glowFrame:Hide()
    end

    ns.Glows.Stop(frame, key)
end

--- Force-hide ALL glows on a frame instantly.
function ns.Glows.ForceHideAll(frame)
    if not frame then return end
    local frameGlows = activeGlows[frame]
    if not frameGlows then return end

    local keys = {}
    for key in pairs(frameGlows) do
        keys[#keys + 1] = key
    end
    for _, key in ipairs(keys) do
        ns.Glows.ForceHide(frame, key)
    end
end

--- Refresh Masque shapes on all active glows (called when user toggles shape setting).
-- Destroys cached template glows (ants/ach_proc) so they get recreated with correct textures,
-- then restarts all active glows. No reload needed.
function ns.Glows.RefreshMasqueShapes()
    -- Collect active entries first (we'll modify activeGlows during iteration)
    local toRestart = {}
    for frame, frameGlows in pairs(activeGlows) do
        for key, entry in pairs(frameGlows) do
            toRestart[#toRestart + 1] = { frame = frame, key = key, type = entry.type, opts = entry.opts }
        end
    end

    -- Destroy cached template glows so they recreate with fresh textures
    for _, info in ipairs(toRestart) do
        local gt = info.type
        if gt == "ants" or gt == "ach_proc" then
            local storageKey = "_arcGlow_" .. gt .. "_" .. (info.key or "")
            local cached = info.frame[storageKey]
            if cached then
                cached:Hide()
                cached:ClearAllPoints()
                cached:SetParent(nil)
                info.frame[storageKey] = nil
            end
        end
        -- Stop all types so LCG recreates frames with fresh textures
        ns.Glows.Stop(info.frame, info.key)
    end

    -- Restart all glows (template types will be recreated, LCG types just refresh)
    for _, info in ipairs(toRestart) do
        ns.Glows.Start(info.frame, info.key, info.type, info.opts)
    end
end

--- Returns the options support matrix for a given glow type.
-- Used by options UI to show/hide the correct sliders per type.
-- @param glowType  string glow type
-- @return table of option name → boolean
function ns.Glows.GetSupportedOpts(glowType)
    if glowType == "blizzard" then glowType = "proc" end
    local SUPPORT = {
        pixel    = { color=true, intensity=true, scale=true, speed=true, lines=true, thickness=true, length=true, border=true, xOffset=true, yOffset=true, frameLevel=true, strata=true },
        autocast = { color=true, intensity=true, scale=true, speed=true, particles=true, xOffset=true, yOffset=true, frameLevel=true, strata=true },
        button   = { color=true, scale=true, speed=true, frameLevel=true, strata=true },
        proc     = { color=true, intensity=true, scale=true, xOffset=true, yOffset=true, frameLevel=true, strata=true },
        ants     = { color=true, intensity=true, scale=true, xOffset=true, yOffset=true, frameLevel=true, strata=true },
        ach_proc = { color=true, intensity=true, scale=true, xOffset=true, yOffset=true, frameLevel=true, strata=true },
        default  = {},
    }
    return SUPPORT[glowType] or {}
end

-- Debug bridge: expose Glows API for standalone debugger addons
_G.ArcUI_Glows = ns.Glows