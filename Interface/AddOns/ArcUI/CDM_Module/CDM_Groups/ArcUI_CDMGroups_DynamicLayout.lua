-- ═══════════════════════════════════════════════════════════════════════════
-- ArcUI_CDMGroups_DynamicLayout.lua
-- DYNAMIC AURAS: Compacts aura icons based on active aura state
-- 
-- TWO MODES OF OPERATION:
--
-- 1. REFLOW MODE (DL.ReflowGroup, called by group:ReflowIcons):
--    - Cooldowns MOVE to fill gaps
--    - Active auras MOVE to fill gaps
--    - Inactive auras = empty spaces (gaps) when dynamic ON
--    - Result: Compact layout with CDs and active auras together
--
-- 2. DYNAMIC POSITIONING MODE (CalculateDynamicSlots, used by Layout):
--    - Cooldowns = WALLS (stay at their REFLOWED position)
--    - Active auras = flow dynamically around CD walls
--    - Inactive auras = hidden at saved positions
--    - CDs don't move when auras come/go - only auras animate
--
-- When enabled on a group:
--   - CDMEnhance handles actual visibility/alpha separately
--   - Only active when options panel is CLOSED
--
-- v1.5: Moved reflow logic from CDMGroups.lua to DL.ReflowGroup()
--       Clear separation between reflow mode and dynamic positioning
--
-- LOAD ORDER: After CDMGroups.lua main body
-- ═══════════════════════════════════════════════════════════════════════════

local ADDON, ns = ...

ns.CDMGroups = ns.CDMGroups or {}
ns.CDMGroups.DynamicLayout = ns.CDMGroups.DynamicLayout or {}

local DL = ns.CDMGroups.DynamicLayout

-- Shared helper for DB access
local Shared = ns.CDMShared

-- ═══════════════════════════════════════════════════════════════════════════
-- MODULE-LEVEL CACHED ENABLED STATE
-- Direct boolean check - NO function call overhead in OnUpdate
-- ═══════════════════════════════════════════════════════════════════════════
local _cdmGroupsEnabled = true  -- Assume enabled until refreshed

local function RefreshCachedEnabledState()
    local db = Shared and Shared.GetCDMGroupsDB and Shared.GetCDMGroupsDB()
    _cdmGroupsEnabled = db and db.enabled ~= false
end

-- Export for other modules to call when settings change
DL.RefreshCachedEnabledState = RefreshCachedEnabledState

-- ═══════════════════════════════════════════════════════════════════════════
-- CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════

local CONFIG = {
    -- How often to check for visibility changes (seconds)
    CHECK_INTERVAL = 0.5,  -- 2Hz (was 0.25 = 4Hz) - cut in half
    
    -- How often to check for grid mismatches (more expensive, do less often)
    MISMATCH_CHECK_INTERVAL = 2.0,  -- 0.5Hz (was 1Hz) - cut in half
    
    -- Threshold: alpha at or below this is considered "invisible"
    INVISIBLE_THRESHOLD = 0.01,
    
    -- Delay after talent change before resuming normal operation
    POST_TALENT_DELAY = 0.3,
}

-- ═══════════════════════════════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════════════════════════════

local state = {
    -- Track visibility state per icon to detect changes
    -- [cdID] = isVisible (boolean)
    iconVisibility = {},
    
    -- Groups pending reflow (batch changes)
    pendingReflows = {},
    
    -- Debug tracking (accessible by debugger)
    lastReflowTime = {},     -- [groupName] = GetTime() of last reflow
    reflowCount = {},        -- [groupName] = count of reflows triggered
    lastMismatchDetected = {},  -- [groupName] = GetTime() when mismatch was detected
    
    -- Event log (circular buffer, max 50 entries)
    eventLog = {},
    eventLogMax = 50,
    
    -- Talent change tracking
    talentChangeTime = 0,         -- GetTime() when last talent change detected
    pendingPostTalentRefresh = false,
    
    -- Options panel state tracking for center-align restore
    optionsPanelWasOpen = false,
    
    -- PERFORMANCE: Per-tick cache for IsIconInvisible results
    -- Cleared at start of each tick, avoids duplicate API calls
    tickInvisibleCache = {},  -- [cdID] = result (true/false/nil)
    
    -- PERFORMANCE: Throttle HasGridMismatch checks (expensive)
    lastMismatchCheckTime = 0,  -- GetTime() of last mismatch check
}

-- Add event to log
local function LogEvent(eventType, groupName, details)
    local entry = {
        time = GetTime(),
        type = eventType,
        group = groupName or "?",
        details = details or "",
    }
    table.insert(state.eventLog, entry)
    -- Keep only last N entries
    while #state.eventLog > state.eventLogMax do
        table.remove(state.eventLog, 1)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- CENTER ALIGNMENT: IMMEDIATE LAYOUT TRIGGER
-- For center-aligned groups, we need instant response when auras change.
-- This hooks aura event methods to trigger immediate Layout().
-- ═══════════════════════════════════════════════════════════════════════════

-- Track which frames we've hooked for center alignment
local centerAlignHookedFrames = {}

-- Check if options panel is open (defined here so it's available for TriggerCenterAlignLayout)
local function IsOptionsPanelOpen()
    if ns.CDMGroups.IsOptionsPanelOpen then
        return ns.CDMGroups.IsOptionsPanelOpen()
    end
    local ACD = LibStub("AceConfigDialog-3.0", true)
    return ACD and ACD.OpenFrames and ACD.OpenFrames["ArcUI"]
end

-- Trigger immediate layout for a center-aligned group
-- Helper to add trace if debugger is available
local function Trace(event, cdID, details)
    -- Try multiple ways to access the debugger
    local debugger = ns.DynamicLayoutDebug or (ArcUI_NS and ArcUI_NS.DynamicLayoutDebug)
    if debugger and debugger.IsCenterAlignTraceEnabled and debugger.IsCenterAlignTraceEnabled() then
        debugger.AddCenterAlignTrace(event, cdID, details)
    end
end

local function TriggerCenterAlignLayout(group, reason, triggerFrame)
    if not group or not group.Layout then return end
    
    local cdID = triggerFrame and triggerFrame.cooldownID
    local now = GetTime()
    
    -- TRACE: Hook triggered
    Trace("HOOK_" .. (reason or "UNKNOWN"), cdID, string.format("group=%s frame=%s", group.name or "?", triggerFrame and "yes" or "no"))
    
    -- Guard against recursive calls (Layout calling CalculateDynamicSlots calling hooks)
    if group._centerAlignLayoutInProgress then 
        Trace("LAYOUT_BLOCKED", cdID, "recursive guard")
        return 
    end
    
    -- Check if options panel is open
    local optionsPanelOpen = IsOptionsPanelOpen()
    
    -- If options panel just opened, clear flags and trigger ONE restore layout
    if optionsPanelOpen then
        if group._useCenterAlignPixels then
            -- Clear center align flags so Layout uses grid positions
            group._useCenterAlignPixels = nil
            group._centerAlignPixelOffsets = nil
            group._centerAlignActiveOrder = nil
            group._centerAlignIsVertical = nil
            
            -- CRITICAL: Restore member.row/col to saved positions
            local savedPositions = ns.CDMGroups and ns.CDMGroups.savedPositions or {}
            local groupName = group.name
            if group.members then
                for cdID, member in pairs(group.members) do
                    local saved = savedPositions[cdID]
                    if saved and saved.type == "group" and saved.target == groupName then
                        if saved.row ~= nil and saved.col ~= nil then
                            member.row = saved.row
                            member.col = saved.col
                        end
                    end
                end
            end
            
            -- Trigger one layout to restore grid positions
            group._centerAlignLayoutInProgress = true
            group:Layout()
            group._centerAlignLayoutInProgress = nil
        end
        return
    end
    
    -- SYNCHRONOUS HIDE-POSITION-SHOW:
    -- 1. Hide the triggering frame immediately (alpha=0)
    -- 2. Layout() positions all frames correctly
    -- 3. Show all frames by calling OptimizedApplyIconVisuals
    
    -- Step 1: Hide the triggering frame to prevent flash at wrong position
    local savedAlpha = nil
    if triggerFrame and triggerFrame.SetAlpha then
        savedAlpha = triggerFrame:GetAlpha()
        Trace("ALPHA_HIDE", cdID, string.format("was=%.2f now=0", savedAlpha or 0))
        triggerFrame:SetAlpha(0)
        if triggerFrame.Cooldown then
            triggerFrame.Cooldown:SetAlpha(0)
        end
    end
    
    -- Step 2: Call Layout() to reposition all frames
    Trace("LAYOUT_START", cdID, "calling group:Layout()")
    local layoutStart = GetTime()
    group._centerAlignLayoutInProgress = true
    group:Layout()
    group._centerAlignLayoutInProgress = nil
    local layoutEnd = GetTime()
    Trace("LAYOUT_END", cdID, string.format("took=%.1fms", (layoutEnd - layoutStart) * 1000))
    
    -- Step 3: Restore alpha by calling OptimizedApplyIconVisuals
    -- This ensures proper state-based alpha (ready/cooldown) is applied AFTER positioning
    if triggerFrame and ns.CDMEnhance and ns.CDMEnhance.OptimizedApplyIconVisuals then
        -- Bypass throttle
        triggerFrame._arcLastOptimizedCall = 0
        triggerFrame._arcTargetAlpha = nil  -- Force alpha recalculation
        Trace("OPTIMIZE_VISUALS", cdID, "calling OptimizedApplyIconVisuals")
        ns.CDMEnhance.OptimizedApplyIconVisuals(triggerFrame)
        Trace("ALPHA_SHOW", cdID, string.format("final=%.2f", triggerFrame:GetAlpha()))
    elseif triggerFrame and savedAlpha then
        -- Fallback: restore original alpha if OptimizedApplyIconVisuals not available
        triggerFrame:SetAlpha(savedAlpha)
        if triggerFrame.Cooldown then
            triggerFrame.Cooldown:SetAlpha(savedAlpha)
        end
        Trace("ALPHA_SHOW", cdID, string.format("fallback=%.2f", savedAlpha))
    end
    
    -- Total time for this trigger
    local totalTime = GetTime() - now
    Trace("TRIGGER_COMPLETE", cdID, string.format("total=%.1fms", totalTime * 1000))
end

-- Hook a frame's aura events for center alignment immediate response
local function HookFrameForCenterAlign(frame, group)
    if not frame or centerAlignHookedFrames[frame] then return end
    
    -- Only hook BuffIcon frames (they have these methods)
    if frame.OnActiveStateChanged then
        hooksecurefunc(frame, "OnActiveStateChanged", function(self)
            -- Only trigger for center-aligned groups
            if group._useCenterAlignPixels or (group.layout and group.layout.alignment == "center") then
                TriggerCenterAlignLayout(group, "OnActiveStateChanged", self)
            end
        end)
    end
    if frame.OnUnitAuraAddedEvent then
        hooksecurefunc(frame, "OnUnitAuraAddedEvent", function(self)
            -- Only trigger for center-aligned groups
            if group._useCenterAlignPixels or (group.layout and group.layout.alignment == "center") then
                TriggerCenterAlignLayout(group, "OnUnitAuraAddedEvent", self)
            end
        end)
    end
    if frame.OnUnitAuraRemovedEvent then
        hooksecurefunc(frame, "OnUnitAuraRemovedEvent", function(self)
            -- Always trigger for removals (need to recenter remaining auras)
            if group._useCenterAlignPixels or (group.layout and group.layout.alignment == "center") then
                TriggerCenterAlignLayout(group, "OnUnitAuraRemovedEvent", self)
            end
        end)
    end
    
    centerAlignHookedFrames[frame] = true
end

-- Hook all frames in a center-aligned group for immediate response
function DL.SetupCenterAlignHooks(group)
    if not group or not group.members then return end
    
    -- Check if this group uses center alignment
    local alignment = group.layout and group.layout.alignment
    if alignment ~= "center" then return end
    
    -- Check if dynamic layout is enabled
    if not group.dynamicLayout then return end
    
    -- Hook all aura frames in this group
    for cdID, member in pairs(group.members) do
        if member and member.frame and DL.IsAuraFrame(member) then
            HookFrameForCenterAlign(member.frame, group)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- HELPERS
-- ═══════════════════════════════════════════════════════════════════════════

-- Export IsOptionsPanelOpen to module (defined above in CENTER ALIGNMENT section)
DL.IsOptionsPanelOpen = IsOptionsPanelOpen

-- Check if an icon should be treated as invisible for dynamic layout
-- Only handles AURA icons (including totems) - cooldowns are excluded
-- For auras: invisible when aura is NOT active, visible when aura IS active
-- For totems: invisible when totem is NOT active, visible when totem IS active
-- Returns true if should be treated as a gap (no active aura/totem)
-- Returns nil for non-aura icons (exclude from dynamic layout processing)
--
-- IMPORTANT: This only checks AURA STATE (auraInstanceID, totem active)
-- It does NOT check cooldown state, spell availability, or alpha
-- CDMEnhance handles visibility/alpha separately - this is ONLY for positioning
function DL.IsIconInvisible(member)
    if not member or not member.frame then
        return nil  -- No frame = can't determine, exclude from dynamic layout
    end
    
    -- PER-TICK CACHE: Avoid duplicate API lookups within same tick
    -- Cache key is cdID (stable identifier)
    local cdID = member.cdID or (member.frame and member.frame.cooldownID)
    if cdID and state.tickInvisibleCache[cdID] ~= nil then
        return state.tickInvisibleCache[cdID]
    end
    
    -- Use robust aura check (falls back to CDM category lookup)
    if not DL.IsAuraFrame(member) then
        if cdID then state.tickInvisibleCache[cdID] = nil end  -- Cache: not an aura
        return nil  -- Not an aura = exclude from dynamic layout (cooldowns not affected)
    end
    
    local frame = member.frame
    local result
    
    -- FAST PATH: Check totemData directly (avoids GetTotemState function call overhead)
    -- This runs at 4Hz for every member, so inline check is much faster
    local totemData = frame.totemData
    if totemData then
        local slotVal = totemData.slot
        if slotVal and type(slotVal) == "number" and slotVal > 0 then
            -- Has active totem slot = totem is active = visible
            result = false
        else
            -- Has totemData structure but no valid slot = totem inactive = invisible
            result = true
        end
    else
        -- Second check: Regular aura with auraInstanceID
        -- auraInstanceID is non-secret and works for both buffs and debuffs
        local auraID = frame.auraInstanceID
        
        if auraID and type(auraID) == "number" and auraID > 0 then
            -- Has a valid auraInstanceID = aura is active = include in layout
            result = false
        else
            -- No auraInstanceID and not a totem = aura is not active
            -- Treat as invisible for dynamic layout (don't occupy grid space)
            result = true
        end
    end
    
    -- Cache result for this tick
    if cdID then state.tickInvisibleCache[cdID] = result end
    return result
end

-- Check if a member should be included in reflow for a dynamic layout group
-- Returns true if icon should take up space, false if treated as gap
-- Non-aura icons always return true (included, not affected by dynamic layout)
function DL.ShouldIncludeInReflow(member, cdID, group)
    -- If dynamic layout is disabled, include everything
    if not group or not group.dynamicLayout then
        return true
    end
    
    -- When options panel is open, include all (show saved positions)
    if IsOptionsPanelOpen() then
        return true
    end
    
    -- Placeholders always included
    if member and member.isPlaceholder then
        return true
    end
    
    -- Check if this is an aura and if it's invisible
    local isInvisible = DL.IsIconInvisible(member)
    
    -- nil means not an aura - always include (cooldowns not affected)
    if isInvisible == nil then
        return true
    end
    
    return not isInvisible
end

-- ═══════════════════════════════════════════════════════════════════════════
-- CORE SLOT CALCULATION (Moved from CDMGroups.lua Layout())
-- ═══════════════════════════════════════════════════════════════════════════

-- Check if a member's aura is active (has auraInstanceID or is active totem)
-- Returns: isActive (boolean), reason (string for debugging)
function DL.IsAuraActive(member)
    if not member or not member.frame then
        return false, "no_frame"
    end
    
    -- Use robust check for aura type
    if not DL.IsAuraFrame(member) then
        return false, "not_aura"
    end
    
    local frame = member.frame
    
    -- FAST PATH: Check totemData directly (avoids GetTotemState function call overhead)
    local totemData = frame.totemData
    if totemData then
        local slotVal = totemData.slot
        if slotVal and type(slotVal) == "number" and slotVal > 0 then
            return true, "totem_active"
        end
        return false, "totem_inactive"
    end
    
    -- Check auraInstanceID
    local auraID = frame.auraInstanceID
    if auraID and type(auraID) == "number" and auraID > 0 then
        return true, "has_auraInstanceID"
    end
    
    return false, "no_auraInstanceID"
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ROBUST FRAME TYPE DETECTION
-- viewerType may not be set correctly, so we fall back to CDM category lookup
-- ═══════════════════════════════════════════════════════════════════════════

-- Check if a member is an AURA frame (vs cooldown/utility)
-- Returns true for auras, false for cooldowns/utilities
-- ALWAYS verifies against CDM category lookup (authoritative source)
-- Only falls back to viewerType if CDM lookup fails
function DL.IsAuraFrame(member)
    if not member then return false end
    
    -- FIRST: Use cached viewerType (fast path - no API call)
    if member.viewerType then
        return member.viewerType == "aura"
    end
    
    -- SECOND: Try CDM category lookup only if cache is missing
    local Shared = ns.CDMShared
    local cdID = member.cdID or (member.frame and member.frame.cooldownID)
    if cdID and Shared and Shared.GetViewerTypeFromCooldownID then
        local viewerType = Shared.GetViewerTypeFromCooldownID(cdID)
        if viewerType then
            -- Cache for future calls
            member.viewerType = viewerType
            return viewerType == "aura"
        end
    end
    
    -- Default: assume NOT an aura (safer - treats as wall)
    return false
end

-- Check if a member is a COOLDOWN frame (not aura, not utility - Essential Cooldowns)
function DL.IsCooldownFrame(member)
    if not member then return false end
    
    -- FIRST: Use cached viewerType (fast path - no API call)
    if member.viewerType then
        return member.viewerType == "cooldown"
    end
    
    -- SECOND: Try CDM category lookup only if cache is missing
    local Shared = ns.CDMShared
    local cdID = member.cdID or (member.frame and member.frame.cooldownID)
    if cdID and Shared and Shared.GetViewerTypeFromCooldownID then
        local viewerType = Shared.GetViewerTypeFromCooldownID(cdID)
        if viewerType then
            -- Cache for future calls
            member.viewerType = viewerType
            return viewerType == "cooldown"
        end
    end
    
    return false
end

-- Build list of available slots in alignment order
-- Returns: availableSlots table (ordered list of slot indices)
function DL.BuildAvailableSlots(rows, cols, alignment, blockedSlots)
    local maxSlots = rows * cols
    local availableSlots = {}
    
    if alignment == "right" then
        -- Fill from right to left (last slot first)
        for i = maxSlots - 1, 0, -1 do
            if not blockedSlots[i] then
                table.insert(availableSlots, i)
            end
        end
    elseif alignment == "bottom" then
        -- Fill from bottom to top (last row first)
        for r = rows - 1, 0, -1 do
            for c = 0, cols - 1 do
                local i = r * cols + c
                if not blockedSlots[i] then
                    table.insert(availableSlots, i)
                end
            end
        end
    elseif alignment == "center" then
        -- Fill from center outward (alternating left/right)
        local centerCol = math.floor((cols - 1) / 2)
        local addedCols = {}
        for offset = 0, cols - 1 do
            local targetCol = (offset % 2 == 0) and centerCol - math.floor(offset / 2) or centerCol + math.ceil(offset / 2)
            if targetCol >= 0 and targetCol < cols and not addedCols[targetCol] then
                addedCols[targetCol] = true
                for r = 0, rows - 1 do
                    local i = r * cols + targetCol
                    if not blockedSlots[i] then
                        table.insert(availableSlots, i)
                    end
                end
            end
        end
    else
        -- Default: left/top - fill from first slot (0) forward
        for i = 0, maxSlots - 1 do
            if not blockedSlots[i] then
                table.insert(availableSlots, i)
            end
        end
    end
    
    return availableSlots
end

-- Calculate dynamic slot positions for active auras
-- This is the main function called by CDMGroups.Layout()
-- Returns: dynamicPositions table, activeAuras table
--
-- STABLE SLOT ASSIGNMENT (v1.4):
--   - Existing auras keep their slot unless compaction is needed
--   - Uses cdID as stable tiebreaker to prevent thrashing
--   - Only compacts when actual gaps exist
function DL.CalculateDynamicSlots(group, rows, cols)
    local dynamicPositions = {}  -- [cdID] = {row=, col=}
    local activeAuras = {}       -- [cdID] = true
    
    if not group or not group.members then
        return dynamicPositions, activeAuras
    end
    
    -- Skip dynamic layout when options panel is open - show all icons at saved positions
    if IsOptionsPanelOpen() then
        -- CRITICAL: Clear center align flags so Layout() uses grid-based positioning
        group._useCenterAlignPixels = nil
        group._centerAlignPixelOffsets = nil
        group._centerAlignActiveOrder = nil
        group._centerAlignIsVertical = nil
        
        -- CRITICAL: Restore member.row/col to saved positions
        -- During center alignment, these get updated to dynamic positions
        local savedPositions = ns.CDMGroups and ns.CDMGroups.savedPositions or {}
        local groupName = group.name
        if group.members then
            for cdID, member in pairs(group.members) do
                local saved = savedPositions[cdID]
                if saved and saved.type == "group" and saved.target == groupName then
                    if saved.row ~= nil and saved.col ~= nil then
                        member.row = saved.row
                        member.col = saved.col
                    end
                end
            end
        end
        
        return dynamicPositions, activeAuras
    end
    
    -- Get alignment setting
    local gridShape = ns.CDMGroups.DetectGridShape and ns.CDMGroups.DetectGridShape(rows, cols) or "multi"
    local alignment = group.layout and group.layout.alignment
    if alignment == nil then
        alignment = ns.CDMGroups.GetDefaultAlignment and ns.CDMGroups.GetDefaultAlignment(gridShape) or "left"
    end
    
    -- Build available slots in alignment order (no blocked slots yet)
    local availableSlots = DL.BuildAvailableSlots(rows, cols, alignment, {})
    
    -- Build slot-to-order map for sorting
    local slotOrderMap = {}  -- [slotIndex] = order (1-based)
    for order, slotIdx in ipairs(availableSlots) do
        slotOrderMap[slotIdx] = order
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- COOLDOWNS CLAIM FIRST SLOTS (sorted by alignment order)
    -- CD at rightmost position gets first slot with right alignment, etc.
    -- ═══════════════════════════════════════════════════════════════════════
    local cooldowns = {}
    local usedSlots = {}  -- [slotIndex] = true
    
    for cdID, member in pairs(group.members) do
        if member and member.frame and not member.isPlaceholder then
            member.cdID = cdID
            if not DL.IsAuraFrame(member) then
                local currentSlot = (member.row or 0) * cols + (member.col or 0)
                table.insert(cooldowns, { 
                    cdID = cdID, 
                    member = member,
                    currentSlot = currentSlot,
                    order = slotOrderMap[currentSlot] or 9999,
                })
            end
        end
    end
    
    -- Sort cooldowns by their ORDER in alignment (first in alignment order gets first slot)
    table.sort(cooldowns, function(a, b)
        if a.order ~= b.order then
            return a.order < b.order
        end
        -- Handle mixed types (string Arc Auras vs numeric CDM IDs)
        local aType, bType = type(a.cdID), type(b.cdID)
        if aType ~= bType then
            return aType == "number"
        end
        return a.cdID < b.cdID
    end)
    
    -- Assign cooldowns to first available slots
    local nextSlotIdx = 1
    for _, data in ipairs(cooldowns) do
        if nextSlotIdx <= #availableSlots then
            local slotIndex = availableSlots[nextSlotIdx]
            local dynRow = math.floor(slotIndex / cols)
            local dynCol = slotIndex % cols
            dynamicPositions[data.cdID] = { row = dynRow, col = dynCol }
            data.member._dynamicSlot = slotIndex
            usedSlots[slotIndex] = true
            nextSlotIdx = nextSlotIdx + 1
        end
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- AURAS: First-come-first-serve with compaction
    -- - Existing auras keep their slots (stable)
    -- - New auras get next available slot
    -- - When gaps appear, compact to fill them (train behavior)
    -- ═══════════════════════════════════════════════════════════════════════
    local aurasWithSlot = {}   -- Already have valid _dynamicSlot
    local aurasNeedSlot = {}   -- Need slot assignment
    
    for cdID, member in pairs(group.members) do
        if member and member.frame and not member.isPlaceholder then
            member.cdID = cdID
            
            if DL.IsAuraFrame(member) then
                local isActive, reason = DL.IsAuraActive(member)
                
                if isActive then
                    activeAuras[cdID] = true
                    
                    -- Check if existing slot is still valid (not taken by cooldown)
                    local existingSlot = member._dynamicSlot
                    if existingSlot ~= nil and not usedSlots[existingSlot] and slotOrderMap[existingSlot] then
                        -- Keep this slot for now
                        table.insert(aurasWithSlot, {
                            cdID = cdID,
                            member = member,
                            slot = existingSlot,
                            order = slotOrderMap[existingSlot],
                        })
                    else
                        -- Slot invalid or taken by cooldown - need new assignment
                        member._dynamicSlot = nil
                        table.insert(aurasNeedSlot, { cdID = cdID, member = member })
                    end
                else
                    -- Inactive - clear slot
                    member._dynamicSlot = nil
                end
            end
        end
    end
    
    -- Sort existing auras by their ORDER in alignment (not raw slot number!)
    -- This ensures correct compaction direction
    table.sort(aurasWithSlot, function(a, b)
        return a.order < b.order
    end)
    
    -- ═══════════════════════════════════════════════════════════════════════════
    -- CENTER ALIGNMENT SPECIAL HANDLING
    -- For center alignment, we recalculate ALL aura positions every time
    -- to keep the group of active auras visually centered.
    -- As auras come/go, the whole group shifts to stay centered.
    -- Example with 8 cols (no cooldowns):
    --   1 aura  → col 3 (center)
    --   2 auras → cols 3,4 (centered pair)
    --   3 auras → cols 2,3,4 (centered trio)
    -- ═══════════════════════════════════════════════════════════════════════════
    if alignment == "center" and (gridShape == "horizontal" or rows == 1) then
        -- Setup hooks for immediate response to aura changes
        DL.SetupCenterAlignHooks(group)
        
        -- Combine all active auras (existing + new) into one list
        local allActiveAuras = {}
        for _, data in ipairs(aurasWithSlot) do
            table.insert(allActiveAuras, { cdID = data.cdID, member = data.member })
        end
        for _, data in ipairs(aurasNeedSlot) do
            table.insert(allActiveAuras, { cdID = data.cdID, member = data.member })
        end
        
        -- Get SAVED positions from database
        -- Field is "target" (not "groupName") and must be type == "group"
        local savedPositions = ns.CDMGroups and ns.CDMGroups.savedPositions or {}
        local groupName = group.name
        
        -- Get growth direction - determines ordering of icons
        local horizontalGrowth = group.layout and group.layout.horizontalGrowth or "RIGHT"
        
        -- Build a lookup of saved positions for sorting
        local function getSavedOrder(cdID)
            local saved = savedPositions[cdID]
            -- Must be type="group" and target matches our group name
            if saved and saved.type == "group" and saved.target == groupName then
                if saved.row ~= nil and saved.col ~= nil then
                    return saved.row * cols + saved.col
                end
            end
            -- No saved position in this group - put at end, use cdID as tiebreaker
            return 9999
        end
        
        -- Sort by SAVED grid position (the order user arranged their icons in)
        table.sort(allActiveAuras, function(a, b)
            local aOrder = getSavedOrder(a.cdID)
            local bOrder = getSavedOrder(b.cdID)
            if aOrder ~= bOrder then
                -- Reverse order if growth is LEFT
                if horizontalGrowth == "LEFT" then
                    return aOrder > bOrder
                end
                return aOrder < bOrder
            end
            -- Tie-breaker for items without saved positions: use cdID
            local aCdID, bCdID = a.cdID, b.cdID
            local aType, bType = type(aCdID), type(bCdID)
            if aType ~= bType then return aType == "number" end
            if horizontalGrowth == "LEFT" then
                return aCdID > bCdID
            end
            return aCdID < bCdID
        end)
        
        -- Get layout settings
        local slotW = group.layout and group.layout.slotWidth or 36
        local slotH = group.layout and group.layout.slotHeight or 36
        local spacingX = group.layout and group.layout.spacingX or group.layout and group.layout.spacing or 2
        
        -- Collect actual effective widths for each icon
        local iconWidths = {}
        local totalWidth = 0
        local activeCount = #allActiveAuras
        
        for i, data in ipairs(allActiveAuras) do
            -- Use effective width if set, otherwise slot width
            local effectiveW = data.member._effectiveIconW or slotW
            iconWidths[i] = effectiveW
            totalWidth = totalWidth + effectiveW
        end
        
        -- Add spacing between icons
        if activeCount > 1 then
            totalWidth = totalWidth + (activeCount - 1) * spacingX
        end
        
        -- Calculate positions from CENTER anchor
        -- Start at left edge of the row, work rightward
        local currentX = -totalWidth / 2
        
        -- Store pixel offsets for Layout() to use
        -- These are X offsets from CENTER of container to CENTER of each icon
        group._centerAlignPixelOffsets = {}
        group._centerAlignActiveOrder = {}
        
        for i, data in ipairs(allActiveAuras) do
            local iconW = iconWidths[i]
            -- Offset to center of this icon
            local centerX = currentX + iconW / 2
            group._centerAlignPixelOffsets[data.cdID] = centerX
            group._centerAlignActiveOrder[i] = data.cdID
            
            -- Move to start of next icon (current icon width + spacing)
            currentX = currentX + iconW + spacingX
            
            -- Still set dynamicPositions for compatibility (slot index for tracking)
            dynamicPositions[data.cdID] = { row = 0, col = i - 1 }
            data.member._dynamicSlot = i - 1
        end
        
        -- Mark that we're using pixel centering
        group._useCenterAlignPixels = true
        group._centerAlignIsVertical = false
        
        return dynamicPositions, activeAuras
    end
    
    -- CENTER ALIGNMENT FOR VERTICAL (single column) GRIDS
    if alignment == "center" and (gridShape == "vertical" or cols == 1) then
        -- Setup hooks for immediate response to aura changes
        DL.SetupCenterAlignHooks(group)
        
        -- Combine all active auras into one list
        local allActiveAuras = {}
        for _, data in ipairs(aurasWithSlot) do
            table.insert(allActiveAuras, { cdID = data.cdID, member = data.member })
        end
        for _, data in ipairs(aurasNeedSlot) do
            table.insert(allActiveAuras, { cdID = data.cdID, member = data.member })
        end
        
        -- Get SAVED positions from database
        -- Field is "target" (not "groupName") and must be type == "group"
        local savedPositions = ns.CDMGroups and ns.CDMGroups.savedPositions or {}
        local groupName = group.name
        
        -- Get growth direction - determines ordering of icons
        local verticalGrowth = group.layout and group.layout.verticalGrowth or "DOWN"
        
        -- Build a lookup of saved positions for sorting (vertical: col first, then row)
        local function getSavedOrder(cdID)
            local saved = savedPositions[cdID]
            if saved and saved.type == "group" and saved.target == groupName then
                if saved.row ~= nil and saved.col ~= nil then
                    return saved.col * rows + saved.row
                end
            end
            return 9999
        end
        
        -- Sort by SAVED grid position
        table.sort(allActiveAuras, function(a, b)
            local aOrder = getSavedOrder(a.cdID)
            local bOrder = getSavedOrder(b.cdID)
            if aOrder ~= bOrder then
                -- Reverse order if growth is UP
                if verticalGrowth == "UP" then
                    return aOrder > bOrder
                end
                return aOrder < bOrder
            end
            -- Tie-breaker
            local aCdID, bCdID = a.cdID, b.cdID
            local aType, bType = type(aCdID), type(bCdID)
            if aType ~= bType then return aType == "number" end
            if verticalGrowth == "UP" then
                return aCdID > bCdID
            end
            return aCdID < bCdID
        end)
        
        -- Get layout settings
        local slotW = group.layout and group.layout.slotWidth or 36
        local slotH = group.layout and group.layout.slotHeight or 36
        local spacingY = group.layout and group.layout.spacingY or group.layout and group.layout.spacing or 2
        
        -- Collect actual effective heights for each icon
        local iconHeights = {}
        local totalHeight = 0
        local activeCount = #allActiveAuras
        
        for i, data in ipairs(allActiveAuras) do
            -- Use effective height if set, otherwise slot height
            local effectiveH = data.member._effectiveIconH or slotH
            iconHeights[i] = effectiveH
            totalHeight = totalHeight + effectiveH
        end
        
        -- Add spacing between icons
        if activeCount > 1 then
            totalHeight = totalHeight + (activeCount - 1) * spacingY
        end
        
        -- Calculate positions from CENTER anchor
        -- Start at top edge of the column, work downward
        local currentY = totalHeight / 2
        
        -- Store pixel offsets for Layout() to use
        -- These are Y offsets from CENTER of container to CENTER of each icon
        group._centerAlignPixelOffsets = {}
        group._centerAlignActiveOrder = {}
        
        for i, data in ipairs(allActiveAuras) do
            local iconH = iconHeights[i]
            -- Offset to center of this icon (Y goes down, so subtract)
            local centerY = currentY - iconH / 2
            group._centerAlignPixelOffsets[data.cdID] = centerY
            group._centerAlignActiveOrder[i] = data.cdID
            
            -- Move to start of next icon (downward)
            currentY = currentY - iconH - spacingY
            
            -- Still set dynamicPositions for compatibility
            dynamicPositions[data.cdID] = { row = i - 1, col = 0 }
            data.member._dynamicSlot = i - 1
        end
        
        -- Mark that we're using pixel centering
        group._useCenterAlignPixels = true
        group._centerAlignIsVertical = true
        
        return dynamicPositions, activeAuras
    end
    
    -- NOT using center alignment - clear any pixel centering state from previous Layout
    group._useCenterAlignPixels = nil
    group._centerAlignPixelOffsets = nil
    group._centerAlignActiveOrder = nil
    group._centerAlignIsVertical = nil
    
    -- Mark all existing aura slots as used FIRST (prevents fighting)
    for _, data in ipairs(aurasWithSlot) do
        usedSlots[data.slot] = true
    end
    
    -- Check if compaction is needed (gaps between cooldowns and existing auras)
    local firstAuraSlotIdx = #cooldowns + 1  -- First slot for auras (after CDs)
    local needsCompaction = false
    local expectedSlotIdx = firstAuraSlotIdx
    
    for _, data in ipairs(aurasWithSlot) do
        local expectedSlot = availableSlots[expectedSlotIdx]
        if data.slot ~= expectedSlot then
            needsCompaction = true
            break
        end
        expectedSlotIdx = expectedSlotIdx + 1
    end
    
    -- Assign aura positions
    if needsCompaction then
        -- Compact: reassign all auras to fill gaps (maintains their order)
        nextSlotIdx = firstAuraSlotIdx
        for _, data in ipairs(aurasWithSlot) do
            if nextSlotIdx <= #availableSlots then
                local slotIndex = availableSlots[nextSlotIdx]
                local dynRow = math.floor(slotIndex / cols)
                local dynCol = slotIndex % cols
                dynamicPositions[data.cdID] = { row = dynRow, col = dynCol }
                data.member._dynamicSlot = slotIndex
                nextSlotIdx = nextSlotIdx + 1
            end
        end
    else
        -- No compaction: keep existing assignments stable
        for _, data in ipairs(aurasWithSlot) do
            local slotIndex = data.slot
            local dynRow = math.floor(slotIndex / cols)
            local dynCol = slotIndex % cols
            dynamicPositions[data.cdID] = { row = dynRow, col = dynCol }
        end
        nextSlotIdx = firstAuraSlotIdx + #aurasWithSlot
    end
    
    -- Assign NEW auras to next available slots
    for _, data in ipairs(aurasNeedSlot) do
        -- Find next unused slot
        while nextSlotIdx <= #availableSlots and usedSlots[availableSlots[nextSlotIdx]] do
            nextSlotIdx = nextSlotIdx + 1
        end
        
        if nextSlotIdx <= #availableSlots then
            local slotIndex = availableSlots[nextSlotIdx]
            local dynRow = math.floor(slotIndex / cols)
            local dynCol = slotIndex % cols
            dynamicPositions[data.cdID] = { row = dynRow, col = dynCol }
            data.member._dynamicSlot = slotIndex
            usedSlots[slotIndex] = true
            nextSlotIdx = nextSlotIdx + 1
        end
    end
    
    return dynamicPositions, activeAuras
end

-- ═══════════════════════════════════════════════════════════════════════════
-- LAYOUT HELPERS (Used by CDMGroups.lua Layout())
-- ═══════════════════════════════════════════════════════════════════════════

-- Build processing order for members: cooldowns first (walls), then active auras, then inactive
-- This ensures cooldowns claim their positions FIRST as immovable walls
-- Returns: ordered list of cdIDs
function DL.BuildProcessingOrder(group, activeAuras, dynEnabled)
    local processingOrder = {}
    
    if not group or not group.members then
        return processingOrder
    end
    
    if dynEnabled then
        local cooldownList = {}   -- Cooldowns are WALLS - process first!
        local activeList = {}     -- Active auras get dynamic positions
        local inactiveList = {}   -- Inactive auras get whatever's left
        
        for cdID, member in pairs(group.members) do
            if member and member.frame and member.row ~= nil and member.col ~= nil then
                -- Store cdID on member for fallback lookup
                member.cdID = cdID
                
                -- Use robust IsAuraFrame check
                local isAura = DL.IsAuraFrame(member)
                
                if not isAura then
                    -- Cooldowns/utilities are WALLS - process first!
                    table.insert(cooldownList, cdID)
                elseif isAura and activeAuras[cdID] then
                    table.insert(activeList, cdID)
                else
                    table.insert(inactiveList, cdID)
                end
            end
        end
        
        -- Combine in priority order: COOLDOWNS FIRST (walls), then active auras, then inactive
        for _, cdID in ipairs(cooldownList) do table.insert(processingOrder, cdID) end
        for _, cdID in ipairs(activeList) do table.insert(processingOrder, cdID) end
        for _, cdID in ipairs(inactiveList) do table.insert(processingOrder, cdID) end
    else
        -- No dynamic layout - process in any order
        for cdID, member in pairs(group.members) do
            if member and member.frame and member.row ~= nil and member.col ~= nil then
                table.insert(processingOrder, cdID)
            end
        end
    end
    
    return processingOrder
end

-- Get the position a member should use (dynamic or saved)
-- Returns: row, col, usesDynamicPosition
function DL.GetMemberPosition(member, cdID, activeAuras, dynamicPositions, dynEnabled)
    -- Store cdID for fallback lookup
    if member then member.cdID = cdID end
    
    local usesDynamicPosition = false
    local row, col
    
    if dynEnabled and dynamicPositions[cdID] then
        -- Has dynamic position (cooldowns OR active auras)
        usesDynamicPosition = true
        row = dynamicPositions[cdID].row
        col = dynamicPositions[cdID].col
    else
        -- Inactive auras: use member position
        row = member.row
        col = member.col
    end
    
    return row, col, usesDynamicPosition
end

-- Find next available slot when collision occurs
-- Respects alignment direction for natural-looking fallback
-- Returns: row, col, posKey (or nil if no slot found)
function DL.FindAvailableSlot(occupiedPositions, rows, cols, alignment)
    if alignment == "right" then
        -- Right alignment: search right-to-left
        for r = 0, rows - 1 do
            for c = cols - 1, 0, -1 do
                local checkKey = r .. "," .. c
                if not occupiedPositions[checkKey] then
                    return r, c, checkKey
                end
            end
        end
    elseif alignment == "bottom" then
        -- Bottom alignment: search bottom-to-top
        for r = rows - 1, 0, -1 do
            for c = 0, cols - 1 do
                local checkKey = r .. "," .. c
                if not occupiedPositions[checkKey] then
                    return r, c, checkKey
                end
            end
        end
    else
        -- Left/center alignment: search left-to-right (default)
        for r = 0, rows - 1 do
            for c = 0, cols - 1 do
                local checkKey = r .. "," .. c
                if not occupiedPositions[checkKey] then
                    return r, c, checkKey
                end
            end
        end
    end
    
    return nil, nil, nil  -- No slot found
end

-- ═══════════════════════════════════════════════════════════════════════════
-- VISIBILITY CHANGE DETECTION
-- ═══════════════════════════════════════════════════════════════════════════

-- Check if the grid state has issues that need correction
-- With stable slot assignment, we DON'T force contiguity - only check for actual issues
-- Returns true ONLY if:
--   1. A hidden aura is still occupying a grid slot (needs removal)
--   2. An active aura has no _dynamicSlot assigned (needs slot)
-- Does NOT check contiguity - with stable assignment, non-contiguous is OK
local function HasGridMismatch(group)
    if not group or not group.members or not group.grid then return false end
    
    -- Check 1: Hidden auras should not occupy grid slots
    for cdID, member in pairs(group.members) do
        if not member.isPlaceholder and member.frame then
            local isHidden = DL.IsIconInvisible(member)
            
            -- nil means not an aura - skip
            if isHidden == true and member.row ~= nil and member.col ~= nil then
                -- Hidden aura - check if it's still in the grid
                local gridEntry = group.grid[member.row] and group.grid[member.row][member.col]
                if gridEntry == cdID then
                    -- Hidden aura is in grid - this needs fixing
                    return true
                end
            end
        end
    end
    
    -- Check 2: Active auras should have a _dynamicSlot
    -- (This catches new auras that appeared and need slot assignment)
    for cdID, member in pairs(group.members) do
        if not member.isPlaceholder and member.frame then
            if member.viewerType == "aura" then
                local isHidden = DL.IsIconInvisible(member)
                if isHidden == false and member._dynamicSlot == nil then
                    -- Active aura without a dynamic slot - needs assignment
                    return true
                end
            end
        end
    end
    
    -- NOTE: We do NOT check for contiguity anymore!
    -- With stable slot assignment, slots can be non-contiguous and that's OK.
    -- Layout() will compact when an aura becomes inactive (creating a gap),
    -- but we don't force compaction just because slots aren't sequential.
    
    return false
end

-- Check a group for visibility changes
-- Returns true if any change detected OR if grid state is mismatched
-- NOTE: Caller (OnUpdate) has already verified IsOptionsPanelOpen() == false
-- shouldCheckMismatch: Only check for grid mismatches when true (expensive, throttled by caller)
local function CheckGroupForChanges(group, shouldCheckMismatch)
    if not group or not group.members then return false end
    if not group.dynamicLayout then return false end
    -- REMOVED: IsOptionsPanelOpen() check - caller already verified this
    
    local groupName = group.name or "unknown"
    local anyChanged = false
    local changedIcons = {}
    
    for cdID, member in pairs(group.members) do
        if not member.isPlaceholder and member.frame then
            local isVisible = not DL.IsIconInvisible(member)
            local wasVisible = state.iconVisibility[cdID]
            
            -- First check - just record state
            if wasVisible == nil then
                state.iconVisibility[cdID] = isVisible
                LogEvent("INIT", groupName, string.format("cdID %d initial state: %s", cdID, isVisible and "visible" or "hidden"))
            elseif wasVisible ~= isVisible then
                -- Visibility changed!
                state.iconVisibility[cdID] = isVisible
                anyChanged = true
                table.insert(changedIcons, string.format("%d: %s->%s", cdID, wasVisible and "V" or "H", isVisible and "V" or "H"))
            end
        end
    end
    
    if #changedIcons > 0 then
        LogEvent("VIS_CHANGE", groupName, table.concat(changedIcons, ", "))
    end
    
    -- PERFORMANCE: Only check for grid mismatches when explicitly requested (throttled by caller)
    -- This is expensive because it loops through all members again
    if not anyChanged and shouldCheckMismatch and HasGridMismatch(group) then
        state.lastMismatchDetected[groupName] = GetTime()
        LogEvent("MISMATCH", groupName, "Grid mismatch detected, queuing reflow")
        anyChanged = true
    end
    
    return anyChanged
end

-- Process pending reflows
local function ProcessPendingReflows()
    for groupName, group in pairs(state.pendingReflows) do
        if group and group.ReflowIcons then
            state.reflowCount[groupName] = (state.reflowCount[groupName] or 0) + 1
            state.lastReflowTime[groupName] = GetTime()
            LogEvent("REFLOW_START", groupName, string.format("Calling ReflowIcons (count: %d)", state.reflowCount[groupName]))
            group:ReflowIcons()
            LogEvent("REFLOW_END", groupName, "ReflowIcons returned")
        end
    end
    wipe(state.pendingReflows)
end

-- Expose state for debugger
DL.GetDebugState = function()
    return state
end

-- Get event log (for debugger)
DL.GetEventLog = function()
    return state.eventLog
end

-- Clear event log
DL.ClearEventLog = function()
    wipe(state.eventLog)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- TALENT/SPEC CHANGE INTEGRATION
-- Called by FrameController after reconcile completes
-- ═══════════════════════════════════════════════════════════════════════════

-- Notify DynamicLayout that a talent/spec change is starting
-- This clears stale visibility state that could cause incorrect reflows
function DL.OnTalentChangeStart()
    LogEvent("TALENT", "START", "Clearing visibility tracking for talent change")
    
    -- Clear all visibility tracking - it's now stale
    wipe(state.iconVisibility)
    wipe(state.pendingReflows)
    
    -- Record when this happened
    state.talentChangeTime = GetTime()
    state.pendingPostTalentRefresh = true
end

-- Notify DynamicLayout that reconcile is complete and frames are stable
-- This triggers a full refresh to rebuild visibility tracking
function DL.OnReconcileComplete()
    if not state.pendingPostTalentRefresh then return end
    
    LogEvent("TALENT", "RECONCILE_DONE", "Scheduling post-talent refresh")
    
    -- Schedule refresh after a short delay to let frames fully settle
    C_Timer.After(CONFIG.POST_TALENT_DELAY, function()
        if IsOptionsPanelOpen() then
            state.pendingPostTalentRefresh = false
            return
        end
        
        LogEvent("TALENT", "POST_REFRESH", "Running post-talent reflow on all dynamic groups")
        
        -- Clear and rebuild visibility tracking
        wipe(state.iconVisibility)
        
        -- Force reflow all dynamic groups
        if ns.CDMGroups.groups then
            for groupName, group in pairs(ns.CDMGroups.groups) do
                if group.dynamicLayout and group.ReflowIcons then
                    -- Re-initialize visibility tracking for this group
                    if group.members then
                        for cdID, member in pairs(group.members) do
                            if not member.isPlaceholder and member.frame then
                                local isVisible = not DL.IsIconInvisible(member)
                                state.iconVisibility[cdID] = isVisible
                            end
                        end
                    end
                    
                    LogEvent("REFLOW_START", groupName, "Post-talent ReflowIcons")
                    group:ReflowIcons()
                    LogEvent("REFLOW_END", groupName, "Post-talent ReflowIcons done")
                end
            end
        end
        
        state.pendingPostTalentRefresh = false
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- MAINTAINER
-- ═══════════════════════════════════════════════════════════════════════════

local DynamicMaintainer = CreateFrame("Frame")
local elapsed = 0

DynamicMaintainer:SetScript("OnUpdate", function(self, dt)
    -- Skip if CDMGroups not enabled (direct boolean check - no function call)
    if not _cdmGroupsEnabled then
        return
    end
    
    -- Track options panel state BEFORE throttle (so we don't miss open/close)
    local optionsPanelOpen = IsOptionsPanelOpen()
    local wasOpen = state.optionsPanelWasOpen
    state.optionsPanelWasOpen = optionsPanelOpen
    
    -- When options panel JUST OPENED, reset center-aligned groups to grid positions
    -- This runs immediately without throttle to ensure instant visual feedback
    if optionsPanelOpen and not wasOpen then
        if ns.CDMGroups.groups then
            local savedPositions = ns.CDMGroups.savedPositions or {}
            for groupName, group in pairs(ns.CDMGroups.groups) do
                if group._useCenterAlignPixels then
                    -- Clear center align flags
                    group._useCenterAlignPixels = nil
                    group._centerAlignPixelOffsets = nil
                    group._centerAlignActiveOrder = nil
                    group._centerAlignIsVertical = nil
                    
                    -- CRITICAL: Restore member.row/col to saved positions
                    -- During center alignment, these get updated to dynamic positions
                    if group.members then
                        for cdID, member in pairs(group.members) do
                            local saved = savedPositions[cdID]
                            if saved and saved.type == "group" and saved.target == groupName then
                                if saved.row ~= nil and saved.col ~= nil then
                                    member.row = saved.row
                                    member.col = saved.col
                                end
                            end
                        end
                    end
                    
                    -- Trigger layout to reposition icons to grid
                    if group.Layout then
                        group:Layout()
                    end
                end
            end
        end
    end
    
    -- When options panel JUST CLOSED, trigger reflow/layout to restore proper positions
    if not optionsPanelOpen and wasOpen then
        if ns.CDMGroups.groups then
            for groupName, group in pairs(ns.CDMGroups.groups) do
                -- For autoReflow groups: call ReflowIcons to fill gaps
                -- This handles BOTH dynamicLayout and non-dynamicLayout groups with Fill Gaps enabled
                if group.autoReflow and group.ReflowIcons then
                    group:ReflowIcons()
                elseif group.dynamicLayout and group.Layout then
                    -- For dynamicLayout-only groups (no autoReflow), just trigger layout
                    -- CalculateDynamicSlots will re-enable center alignment
                    group:Layout()
                end
            end
        end
    end
    
    -- Skip all processing when options panel is open
    if optionsPanelOpen then return end
    
    -- Throttle
    elapsed = elapsed + dt
    if elapsed < CONFIG.CHECK_INTERVAL then return end
    elapsed = 0
    
    -- PERFORMANCE: Clear per-tick cache at start of each check cycle
    wipe(state.tickInvisibleCache)
    
    -- Skip during spec changes
    if ns.CDMGroups.specChangeInProgress then return end
    if ns.CDMGroups._pendingSpecChange then return end
    
    -- Skip during restoration
    if ns.CDMGroups._restorationProtectionEnd and GetTime() < ns.CDMGroups._restorationProtectionEnd then
        return
    end
    
    -- Skip if waiting for post-talent refresh (handled by OnReconcileComplete)
    if state.pendingPostTalentRefresh then return end
    
    -- Check all groups with dynamic layout enabled
    if not ns.CDMGroups.groups then return end
    
    -- PERFORMANCE: Only run expensive HasGridMismatch check periodically
    local now = GetTime()
    local shouldCheckMismatch = (now - state.lastMismatchCheckTime) >= CONFIG.MISMATCH_CHECK_INTERVAL
    
    for groupName, group in pairs(ns.CDMGroups.groups) do
        if group.dynamicLayout then
            local changed = CheckGroupForChanges(group, shouldCheckMismatch)
            if changed then
                state.pendingReflows[groupName] = group
            end
        end
    end
    
    -- Update mismatch check timestamp if we did check
    if shouldCheckMismatch then
        state.lastMismatchCheckTime = now
    end
    
    -- Process reflows
    if next(state.pendingReflows) then
        ProcessPendingReflows()
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- GROUP MANAGEMENT
-- ═══════════════════════════════════════════════════════════════════════════

-- Set dynamic layout on/off for a group
function DL.SetEnabled(group, enabled)
    if not group then return end
    
    group.dynamicLayout = enabled
    
    -- Clear visibility tracking for this group
    if group.members then
        for cdID, _ in pairs(group.members) do
            state.iconVisibility[cdID] = nil
        end
    end
    
    -- If enabling, trigger immediate reflow
    if enabled and not IsOptionsPanelOpen() then
        if group.ReflowIcons then
            C_Timer.After(0.1, function()
                if group.ReflowIcons and not IsOptionsPanelOpen() then
                    group:ReflowIcons()
                end
            end)
        end
    end
end

-- Check if dynamic layout is enabled
function DL.IsEnabled(group)
    return group and group.dynamicLayout == true
end

-- ═══════════════════════════════════════════════════════════════════════════
-- UTILITIES
-- ═══════════════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════════════════
-- REFLOW GROUP - Unified reflow logic (moved from CDMGroups.lua)
-- 
-- REFLOW MODE (this function):
--   - Cooldowns MOVE to fill gaps
--   - Active auras MOVE to fill gaps  
--   - Inactive auras = empty spaces (gaps) - skipped
--   - Result: Compact layout with no visual holes
--
-- DYNAMIC POSITIONING MODE (CalculateDynamicSlots, used by Layout):
--   - Cooldowns = WALLS (stay at reflowed positions)
--   - Active auras = flow dynamically around cooldowns
--   - Inactive auras = hidden at saved positions
-- ═══════════════════════════════════════════════════════════════════════════

-- Helper: Check if member has a valid frame
local function HasValidFrame(member, cdID)
    if not member or not member.frame then return false end
    local frame = member.frame
    if not frame.IsShown then return false end
    
    -- Check cooldownID matches
    local frameCdID = frame.cooldownID
    if frameCdID ~= cdID then return false end
    
    return true
end

-- Helper: Get saved position info
local function GetSavedPosition(cdID, groupName)
    local saved = ns.CDMGroups.savedPositions and ns.CDMGroups.savedPositions[cdID]
    if saved and saved.type == "group" and saved.target == groupName then
        return saved
    end
    return nil
end

-- Helper: Save position to savedPositions
-- NOTE: ns.CDMGroups.savedPositions IS profile.savedPositions (direct reference)
-- so writing here writes directly to the Arc Manager profile
local function SavePosition(cdID, groupName, row, col, sortIndex)
    if not ns.CDMGroups.savedPositions then
        -- savedPositions should always be initialized by OnSpecChange
        -- If it's nil, something is wrong - don't create a disconnected table
        return
    end
    ns.CDMGroups.savedPositions[cdID] = {
        type = "group",
        target = groupName,
        row = row,
        col = col,
        sortIndex = sortIndex or (row * 100 + col),
    }
end

-- Collect and categorize group members for reflow
-- Returns: { toReflow = {}, toSkip = {}, toRemove = {} }
--
-- REFLOW MODE (this function feeds ReflowGroup):
--   - Cooldowns -> toReflow (they MOVE to fill gaps)
--   - Active auras -> toReflow (they MOVE to fill gaps)
--   - Inactive auras -> toSkip (treated as gaps, when dynamic ON)
--
-- Note: "Walls" concept only applies in Layout's CalculateDynamicSlots,
-- where CDs stay at their REFLOWED position while auras animate around them.
function DL.CollectMembersForReflow(group)
    local result = {
        toReflow = {},   -- Icons that will be reflowed (cooldowns + active auras)
        toSkip = {},     -- Icons to skip (inactive auras when dynamic ON)
        toRemove = {},   -- Members without valid frames (cleanup)
    }
    
    if not group or not group.members then
        return result
    end
    
    local maxCols = group.layout and group.layout.gridCols or 4
    local dynEnabled = group.dynamicLayout and group.autoReflow
    
    for cdID, member in pairs(group.members) do
        -- Store cdID on member for type detection
        member.cdID = cdID
        
        -- Skip placeholders entirely
        if member.isPlaceholder then
            -- Placeholders don't participate in reflow
        elseif not HasValidFrame(member, cdID) then
            -- No valid frame - mark for removal (but save position first)
            table.insert(result.toRemove, {
                cdID = cdID,
                member = member,
            })
        else
            -- Has valid frame - categorize
            local isAura = DL.IsAuraFrame(member)
            local isActive = true
            
            if isAura then
                isActive = DL.IsAuraActive(member)
            end
            
            -- Get sort index from saved position
            local saved = GetSavedPosition(cdID, group.name)
            local sortIndex
            if saved and saved.sortIndex then
                sortIndex = saved.sortIndex
            elseif member.row ~= nil and member.col ~= nil then
                sortIndex = member.row * maxCols + member.col
            else
                sortIndex = 9999
            end
            
            local iconData = {
                cdID = cdID,
                member = member,
                isAura = isAura,
                isActive = isActive,
                sortIndex = sortIndex,
                row = member.row,
                col = member.col,
            }
            
            -- When dynamic is ON: inactive auras are gaps
            -- When dynamic is OFF: everything reflows
            if dynEnabled and isAura and not isActive then
                -- Inactive aura with dynamic ON = skip (treat as gap)
                table.insert(result.toSkip, iconData)
            else
                -- Cooldown OR active aura = include in reflow
                -- CDs always move during reflow!
                table.insert(result.toReflow, iconData)
            end
        end
    end
    
    -- Sort toReflow by sortIndex (preserves user order)
    table.sort(result.toReflow, function(a, b)
        if a.sortIndex ~= b.sortIndex then
            return a.sortIndex < b.sortIndex
        end
        -- Tiebreaker: cdID for stability
        -- Handle mixed types (string Arc Auras vs numeric CDM IDs)
        local aType, bType = type(a.cdID), type(b.cdID)
        if aType ~= bType then
            -- Numbers sort before strings
            return aType == "number"
        end
        return a.cdID < b.cdID
    end)
    
    return result
end

-- Calculate slot positions for reflow based on grid shape and alignment
-- Returns: list of {row, col} positions in fill order
function DL.BuildReflowSlotOrder(group, count)
    local maxRows = group.layout and group.layout.gridRows or 2
    local maxCols = group.layout and group.layout.gridCols or 4
    local alignment = group.layout and group.layout.alignment
    
    local gridShape = ns.CDMGroups.DetectGridShape and ns.CDMGroups.DetectGridShape(maxRows, maxCols) or "multi"
    if not alignment then
        alignment = ns.CDMGroups.GetDefaultAlignment and ns.CDMGroups.GetDefaultAlignment(gridShape) or "left"
    end
    
    local slots = {}
    local totalSlots = maxRows * maxCols
    
    if gridShape == "horizontal" then
        -- Single row: apply horizontal alignment
        local startCol = 0
        local emptySlots = maxCols - count
        if emptySlots > 0 then
            if alignment == "center" then
                startCol = math.floor(emptySlots / 2)
            elseif alignment == "right" then
                startCol = emptySlots
            end
        end
        for i = 0, count - 1 do
            local col = startCol + i
            if col < maxCols then
                table.insert(slots, { row = 0, col = col })
            end
        end
        
    elseif gridShape == "vertical" then
        -- Single column: apply vertical alignment
        local startRow = 0
        local emptySlots = maxRows - count
        if emptySlots > 0 then
            if alignment == "center" then
                startRow = math.floor(emptySlots / 2)
            elseif alignment == "bottom" then
                startRow = emptySlots
            end
        end
        for i = 0, count - 1 do
            local row = startRow + i
            if row < maxRows then
                table.insert(slots, { row = row, col = 0 })
            end
        end
        
    else
        -- Multi-dimensional: linear fill (left-to-right, top-to-bottom)
        -- Alignment affects where gaps appear
        if alignment == "right" then
            -- Fill from right side of each row
            local idx = 0
            for row = 0, maxRows - 1 do
                local rowStart = maxCols - math.min(count - idx, maxCols)
                for col = rowStart, maxCols - 1 do
                    if idx < count then
                        table.insert(slots, { row = row, col = col })
                        idx = idx + 1
                    end
                end
            end
        elseif alignment == "bottom" then
            -- Fill from bottom
            local startRow = math.max(0, maxRows - math.ceil(count / maxCols))
            local idx = 0
            for row = startRow, maxRows - 1 do
                for col = 0, maxCols - 1 do
                    if idx < count then
                        table.insert(slots, { row = row, col = col })
                        idx = idx + 1
                    end
                end
            end
        else
            -- Default: left/top alignment (linear fill)
            for i = 0, count - 1 do
                local row = math.floor(i / maxCols)
                local col = i % maxCols
                if row < maxRows and col < maxCols then
                    table.insert(slots, { row = row, col = col })
                end
            end
        end
    end
    
    return slots
end

-- Main reflow function - call this instead of group:ReflowIcons() body
-- Handles: compacting cooldowns + active auras together, inactive auras as gaps
-- After reflow, CDs stay at their new positions while auras animate around them
function DL.ReflowGroup(group)
    if not group then return end
    
    local maxRows = group.layout and group.layout.gridRows or 2
    local maxCols = group.layout and group.layout.gridCols or 4
    
    -- Collect and categorize members
    local members = DL.CollectMembersForReflow(group)
    
    -- Handle removals (save position first)
    for _, data in ipairs(members.toRemove) do
        local cdID = data.cdID
        local member = data.member
        
        -- Ensure position is saved before removing
        if not GetSavedPosition(cdID, group.name) then
            local sortIdx = (member.row or 0) * maxCols + (member.col or 0)
            SavePosition(cdID, group.name, member.row or 0, member.col or 0, sortIdx)
        end
        
        -- Clear from grid
        if member.row and member.col and group.grid and group.grid[member.row] then
            group.grid[member.row][member.col] = nil
        end
        
        -- Remove from members
        group.members[cdID] = nil
    end
    
    -- Clear grid
    group.grid = {}
    for row = 0, maxRows - 1 do
        group.grid[row] = {}
    end
    
    -- Get slot order for reflow
    local slots = DL.BuildReflowSlotOrder(group, #members.toReflow)
    
    -- Place icons into slots
    for i, iconData in ipairs(members.toReflow) do
        local slot = slots[i]
        if slot then
            local cdID = iconData.cdID
            local member = iconData.member
            
            -- Update member position
            member.row = slot.row
            member.col = slot.col
            
            -- Update grid
            group.grid[slot.row][slot.col] = cdID
        end
    end
    
    -- Mark grid dirty
    if group.MarkGridDirty then
        group:MarkGridDirty()
    end
    
    -- Log reflow
    state.lastReflowTime[group.name] = GetTime()
    state.reflowCount[group.name] = (state.reflowCount[group.name] or 0) + 1
    
    return #members.toReflow, #members.toSkip, #members.toRemove
end

-- Clear all visibility tracking (call on spec change, profile switch, etc.)
function DL.ClearTracking()
    wipe(state.iconVisibility)
    wipe(state.pendingReflows)
    wipe(state.lastReflowTime)
    wipe(state.reflowCount)
    wipe(state.lastMismatchDetected)
    wipe(state.eventLog)
    state.talentChangeTime = 0
    state.pendingPostTalentRefresh = false
end

-- Force refresh all dynamic groups
function DL.RefreshAll()
    if IsOptionsPanelOpen() then return end
    if not ns.CDMGroups.groups then return end
    
    -- Clear and rebuild visibility tracking
    wipe(state.iconVisibility)
    
    for groupName, group in pairs(ns.CDMGroups.groups) do
        if group.dynamicLayout then
            -- Re-initialize visibility tracking
            if group.members then
                for cdID, member in pairs(group.members) do
                    if not member.isPlaceholder and member.frame then
                        local isVisible = not DL.IsIconInvisible(member)
                        state.iconVisibility[cdID] = isVisible
                    end
                end
            end
            
            if group.ReflowIcons then
                group:ReflowIcons()
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- PLACEHOLDER RESOLUTION NOTIFICATION
-- Called when a placeholder becomes a real frame, so visibility tracking can update
-- ═══════════════════════════════════════════════════════════════════════════

-- Notify that a placeholder was resolved to a real frame
-- This clears stale visibility tracking so the next check will re-evaluate
function DL.OnPlaceholderResolved(cdID, groupName)
    if not cdID then return end
    
    -- Clear visibility tracking for this cdID
    -- Next CheckGroupForChanges will re-evaluate and see the real frame
    state.iconVisibility[cdID] = nil
    
    -- If we know the group, queue it for potential reflow
    if groupName and ns.CDMGroups.groups then
        local group = ns.CDMGroups.groups[groupName]
        if group and group.dynamicLayout then
            state.pendingReflows[groupName] = group
            LogEvent("PLACEHOLDER_RESOLVED", groupName, string.format("cdID %s resolved, queued reflow", tostring(cdID)))
        end
    end
end

-- Notify that a placeholder was created from a real frame
-- This also clears visibility tracking
function DL.OnPlaceholderCreated(cdID, groupName)
    if not cdID then return end
    
    -- Clear visibility tracking
    state.iconVisibility[cdID] = nil
    
    LogEvent("PLACEHOLDER_CREATED", groupName or "unknown", string.format("cdID %s became placeholder", tostring(cdID)))
end

-- ═══════════════════════════════════════════════════════════════════════════
-- EXPORTS
-- ═══════════════════════════════════════════════════════════════════════════

ns.CDMGroups.DynamicLayout = DL