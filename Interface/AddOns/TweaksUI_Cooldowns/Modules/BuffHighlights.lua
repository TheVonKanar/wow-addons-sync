-- ============================================================================
-- TweaksUI BuffHighlights.lua
-- Creates positionable highlight clones for tracked buffs
-- Detects active/inactive state via auraInstanceID (no secret value math)
-- ============================================================================

local addonName, TUICD = ...
TUICD.BuffHighlights = TUICD.BuffHighlights or {}
local BuffHighlights = TUICD.BuffHighlights

-- ============================================================================
-- CONSTANTS
-- ============================================================================

local UPDATE_INTERVAL = 0.05  -- 20 Hz update rate for snappy responsiveness
local DEFAULT_SIZE = 48
local FRAME_PREFIX = "TweaksUI_BuffHighlight_"

-- ============================================================================
-- STATE
-- ============================================================================

local highlightFrames = {}  -- [slotIndex] = frame
local updateTicker = nil
local isInitialized = false

-- Debug mode
local debugMode = false
local function dprint(...)
    if debugMode then
        print("|cff00ccff[BuffHighlights]|r", ...)
    end
end

-- ============================================================================
-- DATABASE
-- ============================================================================

local function GetDB()
    if not TweaksUI_Cooldowns_CharDB then TweaksUI_Cooldowns_CharDB = {} end
    if not TweaksUI_Cooldowns_CharDB.buffHighlights then
        TweaksUI_Cooldowns_CharDB.buffHighlights = {
            hideTracker = false,  -- Hide the main buff tracker
            enabled = {},  -- [slotIndex] = true/false
            positions = {}, -- [slotIndex] = {point, relPoint, x, y}
            -- Active state settings (when buff is present)
            active = {
                size = {},          -- [slotIndex] = size
                opacity = {},       -- [slotIndex] = 0.0-1.0
                saturation = {},    -- [slotIndex] = true/false
                aspectRatio = {},   -- [slotIndex] = "1:1", "custom", etc.
                customAspectW = {}, -- [slotIndex] = width
                customAspectH = {}, -- [slotIndex] = height
                show = {},          -- [slotIndex] = true/false (show when active)
            },
            -- Inactive state settings (when buff is missing)
            inactive = {
                size = {},
                opacity = {},
                saturation = {},
                aspectRatio = {},
                customAspectW = {},
                customAspectH = {},
                show = {},          -- [slotIndex] = true/false (show when inactive)
            },
        }
    end
    -- Ensure all fields exist (for existing databases)
    local db = TweaksUI_Cooldowns_CharDB.buffHighlights
    if not db.enabled then db.enabled = {} end
    if not db.positions then db.positions = {} end
    
    -- Migrate old format to new format
    if db.triggerOn or db.sizes then
        -- Old format detected, migrate
        if not db.active then db.active = {} end
        if not db.inactive then db.inactive = {} end
        
        for _, state in ipairs({"active", "inactive"}) do
            if not db[state].size then db[state].size = {} end
            if not db[state].opacity then db[state].opacity = {} end
            if not db[state].saturation then db[state].saturation = {} end
            if not db[state].aspectRatio then db[state].aspectRatio = {} end
            if not db[state].customAspectW then db[state].customAspectW = {} end
            if not db[state].customAspectH then db[state].customAspectH = {} end
            if not db[state].show then db[state].show = {} end
        end
        
        -- Migrate old settings to active state
        if db.sizes then
            for k, v in pairs(db.sizes) do
                db.active.size[k] = v
                db.inactive.size[k] = v
            end
            db.sizes = nil
        end
        if db.opacity then
            for k, v in pairs(db.opacity) do
                db.active.opacity[k] = v
                db.inactive.opacity[k] = 0.3  -- Default inactive to lower opacity
            end
            db.opacity = nil
        end
        if db.saturation then
            for k, v in pairs(db.saturation) do
                db.active.saturation[k] = v
                db.inactive.saturation[k] = false  -- Default inactive to desaturated
            end
            db.saturation = nil
        end
        if db.aspectRatio then
            for k, v in pairs(db.aspectRatio) do
                db.active.aspectRatio[k] = v
                db.inactive.aspectRatio[k] = v
            end
            db.aspectRatio = nil
        end
        if db.triggerOn then
            for k, v in pairs(db.triggerOn) do
                if v == "active" then
                    db.active.show[k] = true
                    db.inactive.show[k] = false
                else
                    db.active.show[k] = false
                    db.inactive.show[k] = true
                end
            end
            db.triggerOn = nil
        end
    end
    
    -- Ensure nested tables exist
    if not db.active then db.active = {} end
    if not db.inactive then db.inactive = {} end
    for _, state in ipairs({"active", "inactive"}) do
        if not db[state].size then db[state].size = {} end
        if not db[state].opacity then db[state].opacity = {} end
        if not db[state].saturation then db[state].saturation = {} end
        if not db[state].aspectRatio then db[state].aspectRatio = {} end
        if not db[state].customAspectW then db[state].customAspectW = {} end
        if not db[state].customAspectH then db[state].customAspectH = {} end
        if not db[state].show then db[state].show = {} end
    end
    
    return db
end

local function IsHighlightEnabled(slotIndex)
    local db = GetDB()
    return db.enabled[slotIndex] == true
end

local function SetHighlightEnabled(slotIndex, enabled)
    local db = GetDB()
    db.enabled[slotIndex] = enabled
end

-- State-aware getters/setters
local function GetStateSetting(slotIndex, state, key)
    local db = GetDB()
    return db[state] and db[state][key] and db[state][key][slotIndex]
end

local function SetStateSetting(slotIndex, state, key, value)
    local db = GetDB()
    if db[state] and db[state][key] then
        db[state][key][slotIndex] = value
    end
end

local function GetHighlightSize(slotIndex, state)
    return GetStateSetting(slotIndex, state or "active", "size") or DEFAULT_SIZE
end

local function SetHighlightSize(slotIndex, state, size)
    SetStateSetting(slotIndex, state, "size", size)
end

local function GetHighlightOpacity(slotIndex, state)
    local default = (state == "inactive") and 0.4 or 1.0
    return GetStateSetting(slotIndex, state or "active", "opacity") or default
end

local function SetHighlightOpacity(slotIndex, state, opacity)
    SetStateSetting(slotIndex, state, "opacity", opacity)
end

local function GetHighlightSaturation(slotIndex, state)
    local default = (state == "inactive") and false or true
    local val = GetStateSetting(slotIndex, state or "active", "saturation")
    if val == nil then return default end
    return val
end

local function SetHighlightSaturation(slotIndex, state, saturated)
    SetStateSetting(slotIndex, state, "saturation", saturated)
end

local function GetHighlightAspectRatio(slotIndex, state)
    return GetStateSetting(slotIndex, state or "active", "aspectRatio") or "1:1"
end

local function SetHighlightAspectRatio(slotIndex, state, ratio)
    SetStateSetting(slotIndex, state, "aspectRatio", ratio)
end

local function GetShowState(slotIndex, state)
    local val = GetStateSetting(slotIndex, state, "show")
    if val == nil then
        -- Default: show active, hide inactive
        return (state == "active")
    end
    return val
end

local function SetShowState(slotIndex, state, show)
    SetStateSetting(slotIndex, state, "show", show)
end

local function GetHighlightPosition(slotIndex)
    local db = GetDB()
    return db.positions[slotIndex]
end

local function SetHighlightPosition(slotIndex, point, relPoint, x, y)
    local db = GetDB()
    db.positions[slotIndex] = {point = point, relPoint = relPoint, x = x, y = y}
end

local function IsTrackerHidden()
    local db = GetDB()
    return db.hideTracker == true
end

local function SetTrackerHidden(hidden)
    local db = GetDB()
    db.hideTracker = hidden
end

-- ============================================================================
-- BUFF SLOT ACCESS
-- ============================================================================

-- Get the buff viewer frame
local function GetBuffViewer()
    return _G["BuffIconCooldownViewer"]
end

-- Collect all icons from the buff viewer (reuses Cooldowns logic)
-- Note: We collect icons even if they're hidden (alpha 0) because we need their data
local function CollectBuffIcons()
    local viewer = GetBuffViewer()
    if not viewer then return {} end
    
    -- Don't check IsShown because we hide the tracker with alpha 0
    -- The icons still exist and have data even when hidden
    
    local icons = {}
    local numChildren = 0
    pcall(function() numChildren = viewer:GetNumChildren() or 0 end)
    
    for i = 1, numChildren do
        local child = select(i, viewer:GetChildren())
        -- Check if this looks like an icon (don't require IsShown)
        if child then
            local hasIcon = child.Icon or child.icon
            local hasCooldown = child.Cooldown or child.cooldown
            if hasIcon or hasCooldown then
                icons[#icons + 1] = child
            elseif child.GetNumChildren then
                -- Check nested children
                local numNested = 0
                pcall(function() numNested = child:GetNumChildren() or 0 end)
                for j = 1, numNested do
                    local nested = select(j, child:GetChildren())
                    if nested then
                        local nestedHasIcon = nested.Icon or nested.icon
                        local nestedHasCooldown = nested.Cooldown or nested.cooldown
                        if nestedHasIcon or nestedHasCooldown then
                            icons[#icons + 1] = nested
                        end
                    end
                end
            end
        end
    end
    
    -- Sort by visual position (top-to-bottom, left-to-right) to match Cooldowns module order
    table.sort(icons, function(a, b)
        local at, bt = 0, 0
        local al, bl = 0, 0
        pcall(function() at = a:GetTop() or 0 end)
        pcall(function() bt = b:GetTop() or 0 end)
        pcall(function() al = a:GetLeft() or 0 end)
        pcall(function() bl = b:GetLeft() or 0 end)
        
        -- Sort top-to-bottom first (higher Y = higher on screen)
        if math.abs(at - bt) > 5 then return at > bt end
        
        -- Then left-to-right for icons in same row
        return al < bl
    end)
    
    return icons
end

-- Get info about a specific buff slot
local function GetBuffSlotInfo(slotIndex)
    local icons = CollectBuffIcons()
    local icon = icons[slotIndex]
    
    if not icon then return nil end
    
    local info = {
        icon = icon,
        isActive = false,
        auraInstanceID = nil,
        texture = nil,
        name = "Buff Slot " .. slotIndex,
    }
    
    -- Get auraInstanceID safely (this is the key to detecting active state)
    pcall(function()
        info.auraInstanceID = icon.auraInstanceID
        info.isActive = (icon.auraInstanceID ~= nil)
    end)
    
    -- Get texture safely
    local textureObj = icon.Icon or icon.icon
    if textureObj then
        pcall(function()
            info.texture = textureObj:GetTexture()
        end)
    end
    
    return info
end

-- Get count of buff slots
local function GetBuffSlotCount()
    return #CollectBuffIcons()
end

-- ============================================================================
-- HIGHLIGHT FRAME CREATION (Clone-based - we create our own frame and copy data)
-- ============================================================================

local function CreateHighlightFrame(slotIndex)
    if highlightFrames[slotIndex] then
        return highlightFrames[slotIndex]
    end
    
    local frameName = FRAME_PREFIX .. slotIndex
    local size = GetHighlightSize(slotIndex)
    
    -- Check if Masque is enabled for buffs tracker
    local useMasque = TUICD.Cooldowns and TUICD.Cooldowns.IsMasqueAvailable and TUICD.Cooldowns:IsMasqueAvailable()
    local masqueEnabled = useMasque and TUICD.Database and TUICD.Database:GetTrackerSetting("buffs", "useMasque")
    
    local frame = CreateFrame("Button", frameName, UIParent, "BackdropTemplate")
    frame:SetSize(size, size)
    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel(100)
    
    -- CRITICAL: Make frame movable for Layout mode
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(false)  -- Don't eat mouse clicks - Layout overlay handles that
    
    -- Background (hide if Masque is enabled)
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 2,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    
    if masqueEnabled then
        frame:SetBackdropColor(0, 0, 0, 0)
        frame:SetBackdropBorderColor(0, 0, 0, 0)
    else
        frame:SetBackdropColor(0, 0, 0, 0.6)
        frame:SetBackdropBorderColor(0, 0, 0, 1)
    end
    
    -- Icon texture
    frame.icon = frame:CreateTexture(nil, "ARTWORK")
    frame.Icon = frame.icon  -- Masque expects .Icon
    if masqueEnabled then
        frame.icon:SetAllPoints(frame)
        frame.icon:SetTexCoord(0, 1, 0, 1)  -- Let Masque handle texcoords
    else
        frame.icon:SetPoint("TOPLEFT", 2, -2)
        frame.icon:SetPoint("BOTTOMRIGHT", -2, 2)
        frame.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    
    -- Cooldown spiral
    frame.cooldown = CreateFrame("Cooldown", frameName .. "_Cooldown", frame, "CooldownFrameTemplate")
    frame.Cooldown = frame.cooldown  -- Masque expects .Cooldown
    frame.cooldown:SetAllPoints(frame.icon)
    frame.cooldown:SetDrawEdge(not masqueEnabled)  -- Masque handles edge
    frame.cooldown:SetDrawBling(false)
    frame.cooldown:SetDrawSwipe(true)
    frame.cooldown:SetHideCountdownNumbers(false)
    frame.cooldown:SetSwipeColor(0, 0, 0, 0.8)
    
    -- Stack count text (bottom right, larger font)
    frame.count = frame:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    frame.Count = frame.count  -- Masque expects .Count
    frame.count:SetPoint("BOTTOMRIGHT", -2, 2)
    frame.count:SetJustifyH("RIGHT")
    
    -- Border texture for Masque
    frame.Border = frame:CreateTexture(nil, "OVERLAY")
    frame.Border:SetAllPoints(frame)
    frame.Border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
    frame.Border:SetBlendMode("ADD")
    frame.Border:SetAlpha(0)  -- Hidden, Masque controls this
    
    -- Proc glow overlay (using Blizzard's built-in glow style)
    frame.glowFrame = CreateFrame("Frame", frameName .. "_Glow", frame)
    frame.glowFrame:SetAllPoints()
    frame.glowFrame:SetFrameLevel(frame:GetFrameLevel() + 5)
    frame.glowFrame:Hide()
    
    -- Create the glow texture (yellow spell activation border)
    frame.glowTexture = frame.glowFrame:CreateTexture(nil, "OVERLAY")
    frame.glowTexture:SetPoint("TOPLEFT", -8, 8)
    frame.glowTexture:SetPoint("BOTTOMRIGHT", 8, -8)
    frame.glowTexture:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
    frame.glowTexture:SetBlendMode("ADD")
    frame.glowTexture:SetVertexColor(1, 1, 0.6, 0.8)
    
    -- Animated glow ants (the spinning border effect)
    frame.glowAnts = frame.glowFrame:CreateTexture(nil, "OVERLAY")
    frame.glowAnts:SetPoint("TOPLEFT", -4, 4)
    frame.glowAnts:SetPoint("BOTTOMRIGHT", 4, -4)
    frame.glowAnts:SetTexture("Interface\\Cooldown\\star4")
    frame.glowAnts:SetBlendMode("ADD")
    frame.glowAnts:SetVertexColor(1, 1, 0.5, 0.6)
    
    -- Animation group for the glow
    frame.glowAnim = frame.glowAnts:CreateAnimationGroup()
    frame.glowAnim:SetLooping("REPEAT")
    local rotation = frame.glowAnim:CreateAnimation("Rotation")
    rotation:SetDegrees(-360)
    rotation:SetDuration(4)
    
    -- Store slot reference
    frame.slotIndex = slotIndex
    frame.trackerKey = "buffs"
    frame._TUI_useMasque = masqueEnabled
    
    -- Apply saved position or default
    local pos = GetHighlightPosition(slotIndex)
    if pos then
        frame:ClearAllPoints()
        frame:SetPoint(pos.point, UIParent, pos.relPoint, pos.x, pos.y)
    else
        -- Default position - center with offset based on slot
        frame:SetPoint("CENTER", UIParent, "CENTER", -200 + (slotIndex * 60), -100)
    end
    
    -- Initially hidden
    frame:Hide()
    
    highlightFrames[slotIndex] = frame
    
    -- Register with LayoutMode for drag support
    if TUICD.LayoutMode and TUICD.LayoutMode.RegisterPerIconFrame then
        local displayName = "Buff Icon " .. slotIndex
        TUICD.LayoutMode:RegisterPerIconFrame(frame, "buffs", slotIndex, displayName)
    end
    
    -- Add to Masque group if enabled
    if masqueEnabled then
        local masqueGroup = TUICD.Cooldowns:GetMasqueGroup("buffs")
        if masqueGroup then
            masqueGroup:AddButton(frame, {
                Icon = frame.icon,
                Cooldown = frame.cooldown,
                Count = frame.count,
                Border = frame.Border,
            })
            frame._TUI_MasqueGroup = "buffs"
            dprint("Added highlight frame to Masque group:", slotIndex)
        end
    end
    
    dprint("Created highlight frame for slot", slotIndex)
    
    return frame
end

-- ============================================================================
-- HIGHLIGHT FRAME UPDATE
-- ============================================================================

-- Parse aspect ratio string to get width/height multipliers
local function ParseAspectRatio(aspectStr, slotIndex, state)
    if not aspectStr or aspectStr == "1:1" then
        return 1, 1
    end
    
    -- Check for "custom" which uses per-slot custom values
    if aspectStr == "custom" and slotIndex and state then
        local db = GetDB()
        local customW = db[state].customAspectW[slotIndex] or 1
        local customH = db[state].customAspectH[slotIndex] or 1
        return customW, customH
    end
    
    local w, h = aspectStr:match("(%d+):(%d+)")
    if w and h then
        return tonumber(w), tonumber(h)
    end
    return 1, 1
end

-- Apply aspect ratio to frame
local function ApplyAspectRatio(frame, size, aspectStr, slotIndex, state)
    local aspectW, aspectH = ParseAspectRatio(aspectStr, slotIndex, state)
    local width, height = size, size
    
    if aspectW > aspectH then
        -- Wide (e.g., 16:9)
        height = size * aspectH / aspectW
    elseif aspectH > aspectW then
        -- Tall (e.g., 9:16)
        width = size * aspectW / aspectH
    end
    
    frame:SetSize(width, height)
end

local function UpdateHighlightFrame(slotIndex)
    local frame = highlightFrames[slotIndex]
    if not frame then return end
    
    if not IsHighlightEnabled(slotIndex) then
        frame:Hide()
        return
    end
    
    local slotInfo = GetBuffSlotInfo(slotIndex)
    
    -- Check if Layout mode is active
    local isLayoutMode = false
    local layoutContainer = _G["TweaksUI_LayoutContainer"]
    if layoutContainer and layoutContainer:IsShown() then
        isLayoutMode = true
    end
    
    if not slotInfo then
        -- No slot info - show placeholder during layout mode, hide otherwise
        if isLayoutMode then
            local size = GetHighlightSize(slotIndex, "active")
            local aspectRatio = GetHighlightAspectRatio(slotIndex, "active")
            ApplyAspectRatio(frame, size, aspectRatio, slotIndex, "active")
            frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            frame.icon:SetDesaturated(true)
            frame.count:Hide()
            frame.cooldown:Clear()
            if frame.glowFrame then frame.glowFrame:Hide() end
            frame:SetAlpha(0.5)
            frame:Show()
        else
            frame:Hide()
        end
        return
    end
    
    -- Determine current state based on buff activity
    local currentState = slotInfo.isActive and "active" or "inactive"
    local showThisState = GetShowState(slotIndex, currentState)
    
    -- During layout mode, always show (using active state settings)
    if isLayoutMode then
        local size = GetHighlightSize(slotIndex, "active")
        local aspectRatio = GetHighlightAspectRatio(slotIndex, "active")
        ApplyAspectRatio(frame, size, aspectRatio, slotIndex, "active")
        
        if slotInfo.texture then
            frame.icon:SetTexture(slotInfo.texture)
        else
            frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        end
        
        -- Show with slight desaturation if current state wouldn't normally show
        if not showThisState then
            frame.icon:SetDesaturated(true)
            frame:SetAlpha(0.4)
        else
            local saturated = GetHighlightSaturation(slotIndex, currentState)
            local opacity = GetHighlightOpacity(slotIndex, currentState)
            frame.icon:SetDesaturated(not saturated)
            frame:SetAlpha(opacity)
        end
        
        frame.count:Hide()
        frame.cooldown:Clear()
        if frame.glowFrame then frame.glowFrame:Hide() end
        frame:Show()
        return
    end
    
    -- Normal mode: only show if this state is enabled
    if not showThisState then
        frame:Hide()
        return
    end
    
    -- Get state-specific settings
    local size = GetHighlightSize(slotIndex, currentState)
    local opacity = GetHighlightOpacity(slotIndex, currentState)
    local saturated = GetHighlightSaturation(slotIndex, currentState)
    local aspectRatio = GetHighlightAspectRatio(slotIndex, currentState)
    
    -- Apply size and aspect ratio
    ApplyAspectRatio(frame, size, aspectRatio, slotIndex, currentState)
    
    -- Update icon texture
    if slotInfo.texture then
        frame.icon:SetTexture(slotInfo.texture)
    else
        frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    
    -- Apply saturation and opacity
    frame.icon:SetDesaturated(not saturated)
    frame:SetAlpha(opacity)
    
    -- Always try to update count from the source icon's auraInstanceID
    -- No conditionals - just pass through to the API and let it handle everything
    local sourceIcon = slotInfo.icon
    pcall(function()
        local auraID = sourceIcon.auraInstanceID
        local countStr = C_UnitAuras.GetAuraApplicationDisplayCount("player", auraID, 2)
        frame.count:SetText(countStr)
    end)
    frame.count:Show()  -- Always show - empty string displays nothing
    
    -- Copy cooldown sweep from source icon using Duration Object pass-through
    pcall(function()
        local sourceCooldown = sourceIcon.Cooldown or sourceIcon.cooldown
        if sourceCooldown then
            -- Try Duration Object API first (Midnight compatible)
            if sourceCooldown.GetCooldownDuration then
                local durationObj = sourceCooldown:GetCooldownDuration()
                if durationObj and frame.cooldown.SetCooldownFromDurationObject then
                    frame.cooldown:SetCooldownFromDurationObject(durationObj, true)
                end
            else
                -- Fallback to legacy API
                local start, duration = sourceCooldown:GetCooldownTimes()
                if start and duration then
                    frame.cooldown:SetCooldown(start / 1000, duration / 1000)
                end
            end
        end
    end)
    
    -- Copy glow state from source icon (proc/spell activation glow)
    local showGlow = false
    pcall(function()
        -- Check for overlay glow frame (standard Blizzard glow)
        if sourceIcon.overlay and sourceIcon.overlay:IsShown() then
            showGlow = true
        elseif sourceIcon.SpellActivationAlert and sourceIcon.SpellActivationAlert:IsShown() then
            showGlow = true
        elseif sourceIcon.OverlayGlow and sourceIcon.OverlayGlow:IsShown() then
            showGlow = true
        -- Check for children that might be glow frames
        elseif sourceIcon.GetChildren then
            for i = 1, sourceIcon:GetNumChildren() do
                local child = select(i, sourceIcon:GetChildren())
                if child and child:IsShown() then
                    local name = child:GetName() or ""
                    if name:find("Glow") or name:find("Overlay") or name:find("Activation") then
                        showGlow = true
                        break
                    end
                end
            end
        end
    end)
    
    -- Apply glow state to our frame
    if frame.glowFrame then
        if showGlow then
            frame.glowFrame:Show()
            if frame.glowAnim and not frame.glowAnim:IsPlaying() then
                frame.glowAnim:Play()
            end
        else
            frame.glowFrame:Hide()
            if frame.glowAnim and frame.glowAnim:IsPlaying() then
                frame.glowAnim:Stop()
            end
        end
    end
    
    frame:Show()
end

local function UpdateAllHighlights()
    local db = GetDB()
    for slotIndex, enabled in pairs(db.enabled) do
        if enabled then
            -- Ensure frame exists
            if not highlightFrames[slotIndex] then
                pcall(CreateHighlightFrame, slotIndex)
            end
            -- Use pcall to prevent combat errors from breaking the ticker
            local success, err = pcall(UpdateHighlightFrame, slotIndex)
            if not success and debugMode then
                dprint("UpdateHighlightFrame error for slot " .. slotIndex .. ": " .. tostring(err))
            end
        end
    end
end

-- ============================================================================
-- LAYOUT INTEGRATION
-- ============================================================================

local layoutWrappers = {}  -- [slotIndex] = wrapper

local function CreateLayoutWrapper(slotIndex)
    local frame = highlightFrames[slotIndex]
    if not frame then return nil end
    
    local wrapperId = "BuffHighlight_" .. slotIndex
    
    local wrapper = {
        id = wrapperId,
        name = "Buff Highlight " .. slotIndex,
        category = "Cooldowns",
        frame = frame,
        hideSizeMatching = true,  -- Don't show "Match Size to Parent" options for Per-Icon frames
        defaultPosition = {
            point = "CENTER",
            x = -200 + (slotIndex * 60),
            y = -100,
        },
        contentFrames = {},
        
        onPositionChanged = function(self, point, relFrame, relPoint, x, y)
            frame:ClearAllPoints()
            frame:SetPoint(point, UIParent, point, x, y)
            SetHighlightPosition(slotIndex, point, point, x, y)
        end,
        
        -- TUIFrame API
        GetPosition = function(self)
            local point, relTo, relPoint, x, y = frame:GetPoint(1)
            return { point = point, relFrame = relTo, relPoint = relPoint, x = x, y = y }
        end,
        
        SetPosition = function(self, point, relFrame, relPoint, x, y)
            frame:ClearAllPoints()
            frame:SetPoint(point, relFrame or UIParent, relPoint or point, x or 0, y or 0)
            if self.onPositionChanged then
                self:onPositionChanged(point, relFrame, relPoint, x, y)
            end
        end,
        
        LoadSaveData = function(self, data)
            if not data then return end
            local point = data.point or "CENTER"
            self:SetPosition(point, UIParent, point, data.x, data.y)
            if data.scale then
                self:SetScale(data.scale)
            end
        end,
        
        SetScale = function(self, scale)
            if frame and scale then
                frame:SetScale(scale)
            end
        end,
        
        GetScale = function(self)
            return frame:GetScale() or 1
        end,
        
        GetSize = function(self)
            return frame:GetSize()
        end,
        
        SetSize = function(self, width, height)
            -- For buff highlights, size changes should go through aspect ratio
            -- Just apply directly for now
            if frame and width and height then
                frame:SetSize(width, height)
            end
        end,
        
        IsShown = function(self)
            -- Always report as shown during layout mode so overlay appears
            local layoutContainer = _G["TweaksUI_LayoutContainer"]
            if layoutContainer and layoutContainer:IsShown() then
                return true
            end
            return frame and frame:IsShown()
        end,
        
        GetSaveData = function(self)
            local left = frame:GetLeft()
            local bottom = frame:GetBottom()
            if not left or not bottom then
                local point, _, _, x, y = frame:GetPoint(1)
                return {
                    point = point or "CENTER",
                    x = x or 0,
                    y = y or 0,
                    scale = self:GetScale(),
                }
            end
            return {
                point = "BOTTOMLEFT",
                x = left,
                y = bottom,
                scale = self:GetScale(),
            }
        end,
        
        GetSnapTarget = function(self, tolerance)
            local FlyPaper = LibStub and LibStub("LibFlyPaper-2.0", true)
            if not FlyPaper then return nil end
            tolerance = tolerance or 15
            local point, relFrame, relPoint, x, y = FlyPaper.GetBestAnchorForGroup(
                frame,
                "TweaksUI",
                tolerance
            )
            if point and relFrame then
                return relFrame, point, relPoint, x, y
            end
            return nil
        end,
        
        -- Size locking
        sizeLocked = false,
        SetSizeLocked = function(self, locked)
            self.sizeLocked = locked
        end,
        IsSizeLocked = function(self)
            return self.sizeLocked
        end,
        
        -- ForceSetSize - required by SnapLocking for size matching
        ForceSetSize = function(self, width, height)
            if frame and width and height then
                frame:SetSize(width, height)
            end
        end,
        
        -- GetWidth/GetHeight - required for size calculations
        GetWidth = function(self)
            return frame:GetWidth()
        end,
        GetHeight = function(self)
            return frame:GetHeight()
        end,
        SetWidth = function(self, width)
            if frame and width then
                frame:SetWidth(width)
            end
        end,
        SetHeight = function(self, height)
            if frame and height then
                frame:SetHeight(height)
            end
        end,
    }
    
    frame.tuiFrame = wrapper
    layoutWrappers[slotIndex] = wrapper
    
    -- Register with FlyPaper for snap highlighting
    local FlyPaper = LibStub and LibStub("LibFlyPaper-2.0", true)
    if FlyPaper and FlyPaper.AddFrame then
        FlyPaper.AddFrame("TweaksUI", wrapperId, frame)
    end
    
    return wrapper
end

local function RegisterWithLayout(slotIndex)
    if not TUICD.Layout then
        dprint("Layout module not available")
        return false
    end
    
    local Layout = TUICD.Layout
    
    -- Ensure frame and wrapper exist
    local frame = highlightFrames[slotIndex]
    if not frame then return false end
    
    local wrapper = layoutWrappers[slotIndex]
    if not wrapper then
        wrapper = CreateLayoutWrapper(slotIndex)
    end
    
    if not wrapper then return false end
    
    local wrapperId = "BuffHighlight_" .. slotIndex
    
    -- Register with FlyPaper if available
    local FlyPaper = LibStub and LibStub("LibFlyPaper-2.0", true)
    if FlyPaper then
        FlyPaper.AddFrame("TweaksUI", wrapperId, frame)
    end
    
    -- Register with Layout
    Layout:RegisterElement(wrapperId, {
        name = "Buff Highlight " .. slotIndex,
        category = "Cooldowns",
        tuiFrame = wrapper,
        defaultPosition = wrapper.defaultPosition,
    })
    
    dprint("Registered", wrapperId, "with Layout")
    return true
end

local function UnregisterFromLayout(slotIndex)
    if not TUICD.Layout then return end
    
    local wrapperId = "BuffHighlight_" .. slotIndex
    if TUICD.Layout.UnregisterElement then
        TUICD.Layout:UnregisterElement(wrapperId)
    end
    
    -- Remove from FlyPaper
    local FlyPaper = LibStub and LibStub("LibFlyPaper-2.0", true)
    if FlyPaper and FlyPaper.RemoveFrame then
        FlyPaper.RemoveFrame("TweaksUI", wrapperId)
    end
    
    layoutWrappers[slotIndex] = nil
end

local function RegisterAllWithLayout()
    if not TUICD.Layout then
        dprint("Layout module not available")
        return
    end
    
    local db = GetDB()
    for slotIndex, enabled in pairs(db.enabled) do
        if enabled and highlightFrames[slotIndex] then
            RegisterWithLayout(slotIndex)
        end
    end
end

-- ============================================================================
-- UPDATE TICKER
-- ============================================================================

local function StartUpdateTicker()
    if updateTicker then return end
    
    updateTicker = C_Timer.NewTicker(UPDATE_INTERVAL, function()
        pcall(UpdateAllHighlights)
    end)
    
    dprint("Update ticker started")
end

local function StopUpdateTicker()
    if updateTicker then
        updateTicker:Cancel()
        updateTicker = nil
        dprint("Update ticker stopped")
    end
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

function BuffHighlights:EnableHighlight(slotIndex, enabled)
    SetHighlightEnabled(slotIndex, enabled)
    
    if enabled then
        local frame = CreateHighlightFrame(slotIndex)
        
        -- Set default show states if not set
        local db = GetDB()
        if db.active.show[slotIndex] == nil then
            db.active.show[slotIndex] = true
        end
        if db.inactive.show[slotIndex] == nil then
            db.inactive.show[slotIndex] = false
        end
        
        -- Show frame immediately so user can see it
        frame:Show()
        
        -- Do initial update
        UpdateHighlightFrame(slotIndex)
        
        RegisterWithLayout(slotIndex)
        StartUpdateTicker()
        
        -- Open Layout mode so user can position it
        C_Timer.After(0.3, function()
            if TUICD.Layout and TUICD.Layout.Enter then
                TUICD.Layout:Enter()
                print("|cff00ff00TweaksUI:|r Per-Icon #" .. slotIndex .. " created. Position it now!")
            else
                print("|cff00ff00TweaksUI:|r Per-Icon #" .. slotIndex .. " created. Use /tui layout to position.")
            end
        end)
    else
        if highlightFrames[slotIndex] then
            highlightFrames[slotIndex]:Hide()
        end
        UnregisterFromLayout(slotIndex)
    end
end

function BuffHighlights:SetShowState(slotIndex, state, show)
    SetShowState(slotIndex, state, show)
    UpdateHighlightFrame(slotIndex)
end

function BuffHighlights:GetShowState(slotIndex, state)
    return GetShowState(slotIndex, state)
end

function BuffHighlights:SetSize(slotIndex, state, size)
    SetHighlightSize(slotIndex, state, size)
    UpdateHighlightFrame(slotIndex)
end

function BuffHighlights:GetSize(slotIndex, state)
    return GetHighlightSize(slotIndex, state)
end

function BuffHighlights:SetOpacity(slotIndex, state, opacity)
    SetHighlightOpacity(slotIndex, state, opacity)
    UpdateHighlightFrame(slotIndex)
end

function BuffHighlights:GetOpacity(slotIndex, state)
    return GetHighlightOpacity(slotIndex, state)
end

function BuffHighlights:SetSaturation(slotIndex, state, saturated)
    SetHighlightSaturation(slotIndex, state, saturated)
    UpdateHighlightFrame(slotIndex)
end

function BuffHighlights:GetSaturation(slotIndex, state)
    return GetHighlightSaturation(slotIndex, state)
end

function BuffHighlights:SetAspectRatio(slotIndex, state, ratio)
    SetHighlightAspectRatio(slotIndex, state, ratio)
    UpdateHighlightFrame(slotIndex)
end

function BuffHighlights:GetAspectRatio(slotIndex, state)
    return GetHighlightAspectRatio(slotIndex, state)
end

function BuffHighlights:SetCustomAspectRatio(slotIndex, state, width, height)
    local db = GetDB()
    db[state].customAspectW[slotIndex] = width or 1
    db[state].customAspectH[slotIndex] = height or 1
    SetHighlightAspectRatio(slotIndex, state, "custom")
    UpdateHighlightFrame(slotIndex)
end

function BuffHighlights:GetCustomAspectRatio(slotIndex, state)
    local db = GetDB()
    return db[state].customAspectW[slotIndex] or 1, db[state].customAspectH[slotIndex] or 1
end

function BuffHighlights:IsTrackerHidden()
    return IsTrackerHidden()
end

function BuffHighlights:ApplyTrackerVisibility()
    local viewer = _G["BuffIconCooldownViewer"]
    local container = _G["TweaksUI_BuffsContainer"]
    local hidden = IsTrackerHidden()
    
    -- Also check layout mode - always show during layout mode
    local isLayoutMode = false
    local layoutContainer = _G["TweaksUI_LayoutContainer"]
    if layoutContainer and layoutContainer:IsShown() then
        isLayoutMode = true
    end
    
    if hidden and not isLayoutMode then
        -- Hide tracker but keep it functional (just hide the container)
        -- Note: We only set alpha on the container/viewer, NOT individual children
        -- because we need to read auraInstanceID from children even when hidden
        if viewer then
            viewer:SetAlpha(0)
            viewer:EnableMouse(false)
        end
        if container then
            container:SetAlpha(0)
            container:EnableMouse(false)
        end
    else
        -- Show tracker normally (let the main visibility system handle actual alpha)
        if viewer then
            viewer:EnableMouse(true)
            -- But if we're in layout mode, force show
            if isLayoutMode then
                viewer:SetAlpha(1)
            end
        end
        if container then
            container:EnableMouse(true)
            if isLayoutMode then
                container:SetAlpha(1)
            end
        end
    end
end

-- Ticker to enforce hide state (runs every 0.2 seconds when hide is enabled)
local hideEnforcementTicker = nil

local function StartHideEnforcement()
    if hideEnforcementTicker then return end
    
    hideEnforcementTicker = C_Timer.NewTicker(0.2, function()
        if not IsTrackerHidden() then
            -- Stop ticker if no longer hidden
            if hideEnforcementTicker then
                hideEnforcementTicker:Cancel()
                hideEnforcementTicker = nil
            end
            return
        end
        
        -- Check layout mode
        local layoutContainer = _G["TweaksUI_LayoutContainer"]
        if layoutContainer and layoutContainer:IsShown() then
            return  -- Don't enforce during layout mode
        end
        
        -- Force hide the tracker
        local viewer = _G["BuffIconCooldownViewer"]
        local container = _G["TweaksUI_BuffsContainer"]
        
        if viewer and viewer:GetAlpha() > 0 then
            viewer:SetAlpha(0)
            viewer:EnableMouse(false)
        end
        if container and container:GetAlpha() > 0 then
            container:SetAlpha(0)
            container:EnableMouse(false)
        end
    end)
end

local function StopHideEnforcement()
    if hideEnforcementTicker then
        hideEnforcementTicker:Cancel()
        hideEnforcementTicker = nil
    end
end

-- Override SetTrackerHidden to manage the enforcement ticker
local origSetTrackerHidden = BuffHighlights.SetTrackerHidden
function BuffHighlights:SetTrackerHidden(hidden)
    SetTrackerHidden(hidden)
    self:ApplyTrackerVisibility()
    
    if hidden then
        StartHideEnforcement()
    else
        StopHideEnforcement()
        -- Restore normal visibility
        local viewer = _G["BuffIconCooldownViewer"]
        local container = _G["TweaksUI_BuffsContainer"]
        if viewer then
            viewer:SetAlpha(1)
            viewer:EnableMouse(true)
        end
        if container then
            container:SetAlpha(1)
            container:EnableMouse(true)
        end
    end
end

function BuffHighlights:GetSlotCount()
    return GetBuffSlotCount()
end

function BuffHighlights:SetPosition(slotIndex, point, relPoint, x, y)
    SetHighlightPosition(slotIndex, point, relPoint, x, y)
end

function BuffHighlights:GetSlotInfo(slotIndex)
    return GetBuffSlotInfo(slotIndex)
end

function BuffHighlights:IsEnabled(slotIndex)
    return IsHighlightEnabled(slotIndex)
end

function BuffHighlights:ToggleDebug()
    debugMode = not debugMode
    print("|cff00ff00TweaksUI BuffHighlights:|r Debug mode", debugMode and "ENABLED" or "DISABLED")
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

function BuffHighlights:Initialize()
    if isInitialized then return end
    isInitialized = true
    
    dprint("Initializing BuffHighlights")
    
    -- Create frames for any enabled highlights
    local db = GetDB()
    for slotIndex, enabled in pairs(db.enabled) do
        if enabled then
            CreateHighlightFrame(slotIndex)
        end
    end
    
    -- Start update ticker if we have any enabled
    local hasEnabled = false
    for _, enabled in pairs(db.enabled) do
        if enabled then hasEnabled = true break end
    end
    if hasEnabled then
        StartUpdateTicker()
    end
    
    -- Register with Layout after a delay
    C_Timer.After(2, RegisterAllWithLayout)
    
    -- Apply initial tracker visibility and show icons after buff tracker is ready
    C_Timer.After(2.5, function()
        self:ApplyTrackerVisibility()
        -- Start hide enforcement if enabled
        if IsTrackerHidden() then
            StartHideEnforcement()
        end
        -- Initial update to show any enabled icons
        UpdateAllHighlights()
    end)
    
    -- Also update when entering world (in case buff tracker loads later)
    local initFrame = CreateFrame("Frame")
    initFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    initFrame:SetScript("OnEvent", function()
        C_Timer.After(3, function()
            UpdateAllHighlights()
        end)
    end)
    
    -- Hook into layout mode callbacks to show/hide frames
    if TUICD.Layout and TUICD.Layout.RegisterCallback then
        TUICD.Layout:RegisterCallback("OnLayoutModeEnter", function()
            -- Show tracker during layout mode (temporarily)
            local viewer = _G["BuffIconCooldownViewer"]
            local container = _G["TweaksUI_BuffsContainer"]
            if viewer then
                viewer:SetAlpha(1)
                viewer:EnableMouse(true)
            end
            if container then
                container:SetAlpha(1)
                container:EnableMouse(true)
            end
            
            -- Show all enabled highlight frames during layout mode
            local db = GetDB()
            for slotIndex, enabled in pairs(db.enabled) do
                if enabled then
                    local frame = highlightFrames[slotIndex]
                    if frame then
                        frame:Show()
                        -- Update appearance
                        UpdateHighlightFrame(slotIndex)
                    end
                end
            end
        end)
        
        TUICD.Layout:RegisterCallback("OnLayoutModeExit", function()
            -- Update all frames to respect their actual conditions
            UpdateAllHighlights()
            -- Re-apply tracker visibility setting
            self:ApplyTrackerVisibility()
        end)
    end
    
    dprint("BuffHighlights initialized")
end

-- ============================================================================
-- SLASH COMMANDS
-- ============================================================================

SLASH_TUIBUFFHIGHLIGHTS1 = "/tuibh"
SLASH_TUIBUFFHIGHLIGHTS2 = "/tuibuffhighlights"
SlashCmdList["TUIBUFFHIGHLIGHTS"] = function(msg)
    local args = {}
    for word in msg:gmatch("%S+") do
        args[#args + 1] = word:lower()
    end
    
    local cmd = args[1]
    
    if cmd == "config" or not cmd then
        BuffHighlights:ShowConfig()
    elseif cmd == "debug" then
        BuffHighlights:ToggleDebug()
    elseif cmd == "refresh" then
        BuffHighlights:RefreshConfigUI()
    elseif cmd == "dump" then
        -- Dump structure of first buff icon
        local slotIndex = tonumber(args[2]) or 1
        local icons = CollectBuffIcons()
        local icon = icons[slotIndex]
        if icon then
            print("|cff00ff00=== Buff Icon Slot " .. slotIndex .. " Structure ===|r")
            print("Frame: " .. tostring(icon:GetName() or "unnamed"))
            print("auraInstanceID: " .. tostring(icon.auraInstanceID))
            
            -- Check count properties specifically
            print("|cffff9900Count Properties:|r")
            print("  icon.Count: " .. tostring(icon.Count))
            print("  icon.count: " .. tostring(icon.count))
            print("  icon.CountText: " .. tostring(icon.CountText))
            print("  icon.countText: " .. tostring(icon.countText))
            
            -- If we found a count object, show its text
            local countObj = icon.Count or icon.count or icon.CountText or icon.countText
            if countObj then
                local text = ""
                local shown = false
                pcall(function() text = countObj:GetText() or "" end)
                pcall(function() shown = countObj:IsShown() end)
                print("  Count text: '" .. tostring(text) .. "', shown: " .. tostring(shown))
            end
            
            -- Try to get aura data via API
            if icon.auraInstanceID then
                print("|cffff9900Aura Data (from API):|r")
                pcall(function()
                    local auraData = C_UnitAuras.GetAuraDataByAuraInstanceID("player", icon.auraInstanceID)
                    if auraData then
                        print("  name: " .. tostring(auraData.name))
                        print("  applications (stacks): " .. tostring(auraData.applications))
                        print("  duration: " .. tostring(auraData.duration))
                        print("  expirationTime: " .. tostring(auraData.expirationTime))
                    else
                        print("  No aura data returned")
                    end
                end)
            end
            
            -- Dump all regions
            print("|cffff9900Regions:|r")
            if icon.GetRegions then
                pcall(function()
                    for i, region in ipairs({icon:GetRegions()}) do
                        local rType = region:GetObjectType()
                        local rName = region:GetName() or "unnamed"
                        local rText = ""
                        if rType == "FontString" then
                            pcall(function() rText = region:GetText() or "" end)
                        end
                        print(string.format("  %d: %s (%s) text='%s'", i, tostring(rName), tostring(rType), tostring(rText)))
                    end
                end)
            end
            
            -- Dump children (wrapped in pcall to handle secret values)
            print("|cffff9900Children:|r")
            if icon.GetChildren then
                pcall(function()
                    for i, child in ipairs({icon:GetChildren()}) do
                        local cName = "unnamed"
                        local cType = "unknown"
                        pcall(function() cName = child:GetName() or "unnamed" end)
                        pcall(function() cType = child:GetObjectType() end)
                        print(string.format("  %d: %s (%s)", i, tostring(cName), tostring(cType)))
                        
                        -- Check child regions
                        if child.GetRegions then
                            pcall(function()
                                for j, region in ipairs({child:GetRegions()}) do
                                    local rType = "unknown"
                                    local rName = "unnamed"
                                    local rText = ""
                                    pcall(function() rType = region:GetObjectType() end)
                                    pcall(function() rName = region:GetName() or "unnamed" end)
                                    if rType == "FontString" then
                                        pcall(function() rText = region:GetText() or "" end)
                                    end
                                    print(string.format("    %d.%d: %s (%s) text='%s'", i, j, tostring(rName), tostring(rType), tostring(rText)))
                                end
                            end)
                        end
                    end
                end)
            end
        else
            print("|cffff0000No icon found at slot " .. slotIndex .. "|r")
        end
    elseif cmd == "status" then
        -- Show current status of everything
        print("|cff00ff00=== BuffHighlights Status ===|r")
        print("Initialized: " .. tostring(isInitialized))
        print("Update ticker running: " .. tostring(updateTicker ~= nil))
        print("Hide enforcement running: " .. tostring(hideEnforcementTicker ~= nil))
        print("Tracker hidden setting: " .. tostring(IsTrackerHidden()))
        print("In combat: " .. tostring(InCombatLockdown()))
        print("Debug mode: " .. tostring(debugMode))
        
        local viewer = _G["BuffIconCooldownViewer"]
        print("Viewer exists: " .. tostring(viewer ~= nil))
        if viewer then
            print("Viewer alpha: " .. tostring(viewer:GetAlpha()))
            print("Viewer shown: " .. tostring(viewer:IsShown()))
            print("Viewer children: " .. tostring(viewer:GetNumChildren() or 0))
        end
        
        local icons = CollectBuffIcons()
        print("Icons collected: " .. #icons)
        
        -- Show details about each collected icon
        for i, icon in ipairs(icons) do
            local auraID = icon.auraInstanceID
            local name = icon:GetName() or "unnamed"
            print(string.format("  Icon %d: %s, auraInstanceID=%s", i, name, tostring(auraID)))
        end
        
        local db = GetDB()
        local enabledCount = 0
        print("|cffff9900Enabled Per-Icon slots:|r")
        for slotIndex, enabled in pairs(db.enabled) do
            if enabled then
                enabledCount = enabledCount + 1
                local slotInfo = GetBuffSlotInfo(slotIndex)
                local frame = highlightFrames[slotIndex]
                local showActive = GetShowState(slotIndex, "active")
                local showInactive = GetShowState(slotIndex, "inactive")
                print(string.format("  Slot %d: frame=%s, isActive=%s, shown=%s", 
                    slotIndex,
                    tostring(frame ~= nil),
                    slotInfo and tostring(slotInfo.isActive) or "NO INFO",
                    frame and tostring(frame:IsShown()) or "no frame"))
                print(string.format("    showActive=%s, showInactive=%s", 
                    tostring(showActive), tostring(showInactive)))
            end
        end
        print("Total enabled slots: " .. enabledCount)
    elseif cmd == "force" then
        -- Force update all highlights
        print("|cff00ff00Forcing update of all highlights...|r")
        UpdateAllHighlights()
        print("Done!")
    elseif cmd == "watch" then
        -- Toggle watch mode - print every update
        if not BuffHighlights._watchMode then
            BuffHighlights._watchMode = true
            BuffHighlights._watchTicker = C_Timer.NewTicker(0.5, function()
                local db = GetDB()
                local msg = "Watch: "
                for slotIndex, enabled in pairs(db.enabled) do
                    if enabled then
                        local slotInfo = GetBuffSlotInfo(slotIndex)
                        local frame = highlightFrames[slotIndex]
                        msg = msg .. string.format("[%d:%s/%s] ", 
                            slotIndex,
                            slotInfo and (slotInfo.isActive and "A" or "I") or "?",
                            frame and (frame:IsShown() and "V" or "H") or "X")
                    end
                end
                print(msg)
            end)
            print("|cff00ff00Watch mode ON - will print state every 0.5s. /tuibh watch to stop|r")
        else
            BuffHighlights._watchMode = false
            if BuffHighlights._watchTicker then
                BuffHighlights._watchTicker:Cancel()
                BuffHighlights._watchTicker = nil
            end
            print("|cffff0000Watch mode OFF|r")
        end
    else
        print("|cff00ff00TweaksUI BuffHighlights Commands:|r")
        print("  /tuibh - Open config UI")
        print("  /tuibh debug - Toggle debug mode")
        print("  /tuibh dump [slot] - Dump icon structure")
        print("  /tuibh status - Show current status")
        print("  /tuibh force - Force update all highlights")
        print("  /tuibh watch - Toggle real-time state monitoring")
    end
end

-- Auto-initialize when Cooldowns module loads
if TUICD.Modules and TUICD.Modules.Cooldowns then
    -- Hook into Cooldowns initialization
    local origInit = TUICD.Modules.Cooldowns.Initialize
    if origInit then
        TUICD.Modules.Cooldowns.Initialize = function(...)
            local result = origInit(...)
            C_Timer.After(1, function()
                BuffHighlights:Initialize()
            end)
            return result
        end
    end
else
    -- Fallback: Initialize on PLAYER_LOGIN
    local initFrame = CreateFrame("Frame")
    initFrame:RegisterEvent("PLAYER_LOGIN")
    initFrame:SetScript("OnEvent", function()
        C_Timer.After(3, function()
            BuffHighlights:Initialize()
        end)
    end)
end
