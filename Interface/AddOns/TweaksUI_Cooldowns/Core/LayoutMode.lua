-- ============================================================================
-- TweaksUI: Cooldowns - Layout Mode
-- Enhanced frame positioning system with grid, nudging, and visual feedback
-- ============================================================================

local ADDON_NAME, TUICD = ...

TUICD.LayoutMode = {}
local LayoutMode = TUICD.LayoutMode

-- ============================================================================
-- CONSTANTS
-- ============================================================================

local COLORS = {
    -- Overlay colors
    overlayBorder = { 0.4, 0.4, 0.4, 0.9 },
    overlayBorderHover = { 0.6, 0.8, 1.0, 1.0 },
    overlayBorderSelected = { 0.2, 1.0, 0.4, 1.0 },
    overlayBorderDragging = { 1.0, 0.8, 0.2, 1.0 },
    overlayBackground = { 0.1, 0.1, 0.1, 0.3 },
    overlayBackgroundSelected = { 0.2, 0.4, 0.2, 0.4 },
    
    -- Label colors
    labelText = { 1, 1, 1, 1 },
    labelBackground = { 0, 0, 0, 0.7 },
    
    -- Grid colors
    gridLine = { 0.4, 0.4, 0.4, 0.3 },
    gridLineCenter = { 0.8, 0.8, 0.2, 0.6 },
}

local OVERLAY_BORDER_SIZE = 2
local LABEL_PADDING = 4
local DEFAULT_GRID_SIZE = 32

-- ============================================================================
-- STATE
-- ============================================================================

local isUnlocked = false
local containers = {}  -- [trackerKey] = containerFrame
local originalViewerData = {}  -- [trackerKey] = { parent, points, ... }
local overlays = {}  -- [trackerKey] = overlayFrame
local selectedTrackerKey = nil  -- Currently selected tracker for nudging
local gridFrame = nil
local containerFrame = nil  -- Parent for layout UI elements

-- Blizzard viewer references
local BLIZZARD_VIEWERS = {
    essential = "EssentialCooldownViewer",
    utility = "UtilityCooldownViewer",
    buffs = "BuffIconCooldownViewer",
}

-- Display names
local DISPLAY_NAMES = {
    essential = "Essential Cooldowns",
    utility = "Utility Cooldowns",
    buffs = "Buff Tracker",
    customTrackers = "Custom Trackers",
}

-- Default positions
local DEFAULT_POSITIONS = {
    essential = { point = "CENTER", x = 0, y = -100 },
    utility = { point = "CENTER", x = 0, y = -160 },
    buffs = { point = "CENTER", x = 0, y = -220 },
    customTrackers = { point = "CENTER", x = 0, y = -280 },
}

-- ============================================================================
-- EARLY CONTAINER CREATION
-- Create container frames IMMEDIATELY so they exist before Blizzard's Edit Mode
-- runs and tries to reference them by name. Positions will be updated later
-- when the Database is available.
-- ============================================================================

local function CreateEarlyContainer(trackerKey)
    local frameName = "TUICD_Container_" .. trackerKey
    -- Don't recreate if already exists
    if _G[frameName] then return _G[frameName] end
    
    local displayName = DISPLAY_NAMES[trackerKey] or trackerKey
    local pos = DEFAULT_POSITIONS[trackerKey] or { point = "CENTER", x = 0, y = -100 }
    
    local container = CreateFrame("Frame", frameName, UIParent)
    container:SetSize(200, 50)
    container:SetFrameStrata("LOW")
    container:SetFrameLevel(10)
    container:SetClampedToScreen(true)
    container:SetMovable(true)
    container:EnableMouse(false)
    container:SetPoint(pos.point, UIParent, pos.point, pos.x or 0, pos.y or 0)
    
    container.trackerKey = trackerKey
    container.displayName = displayName
    containers[trackerKey] = container
    
    return container
end

-- Create containers immediately at file load time
-- This ensures they exist before Blizzard's EditModeManager tries to reference them
for trackerKey in pairs(BLIZZARD_VIEWERS) do
    CreateEarlyContainer(trackerKey)
end
CreateEarlyContainer("customTrackers")

-- ============================================================================
-- POSITION SAVE/RESTORE
-- ============================================================================

local function GetSavedPosition(trackerKey)
    if not TUICD.Database then return nil end
    return TUICD.Database:GetContainerPosition(trackerKey)
end

local function SavePosition(trackerKey, point, x, y)
    if not TUICD.Database then return end
    TUICD.Database:SetContainerPosition(trackerKey, point, x, y)
end

-- ============================================================================
-- GRID OVERLAY
-- ============================================================================

local function CreateGrid()
    if gridFrame then return end
    
    gridFrame = CreateFrame("Frame", "TUICD_LayoutGrid", containerFrame)
    gridFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    gridFrame:SetFrameLevel(1)  -- Behind overlays
    gridFrame:SetAllPoints()
    gridFrame:Hide()
    
    gridFrame.lines = {}
end

local function UpdateGrid()
    if not gridFrame then return end
    
    -- Clear existing lines
    for _, line in ipairs(gridFrame.lines) do
        line:Hide()
    end
    
    local screenWidth = UIParent:GetWidth()
    local screenHeight = UIParent:GetHeight()
    local gridSize = DEFAULT_GRID_SIZE
    local lineIndex = 1
    
    -- Center point
    local centerX = screenWidth / 2
    local centerY = screenHeight / 2
    
    -- Draw vertical center line (Y axis)
    local line = gridFrame.lines[lineIndex]
    if not line then
        line = gridFrame:CreateLine(nil, "BACKGROUND")
        gridFrame.lines[lineIndex] = line
    end
    line:SetThickness(2)
    line:SetColorTexture(unpack(COLORS.gridLineCenter))
    line:SetStartPoint("BOTTOMLEFT", gridFrame, centerX, 0)
    line:SetEndPoint("TOPLEFT", gridFrame, centerX, screenHeight)
    line:Show()
    lineIndex = lineIndex + 1
    
    -- Draw horizontal center line (X axis)
    line = gridFrame.lines[lineIndex]
    if not line then
        line = gridFrame:CreateLine(nil, "BACKGROUND")
        gridFrame.lines[lineIndex] = line
    end
    line:SetThickness(2)
    line:SetColorTexture(unpack(COLORS.gridLineCenter))
    line:SetStartPoint("BOTTOMLEFT", gridFrame, 0, centerY)
    line:SetEndPoint("BOTTOMRIGHT", gridFrame, screenWidth, centerY)
    line:Show()
    lineIndex = lineIndex + 1
    
    -- Draw vertical lines from center outward (positive X)
    for offset = gridSize, centerX, gridSize do
        line = gridFrame.lines[lineIndex]
        if not line then
            line = gridFrame:CreateLine(nil, "BACKGROUND")
            gridFrame.lines[lineIndex] = line
        end
        line:SetThickness(1)
        line:SetColorTexture(unpack(COLORS.gridLine))
        line:SetStartPoint("BOTTOMLEFT", gridFrame, centerX + offset, 0)
        line:SetEndPoint("TOPLEFT", gridFrame, centerX + offset, screenHeight)
        line:Show()
        lineIndex = lineIndex + 1
    end
    
    -- Draw vertical lines from center outward (negative X)
    for offset = gridSize, centerX, gridSize do
        line = gridFrame.lines[lineIndex]
        if not line then
            line = gridFrame:CreateLine(nil, "BACKGROUND")
            gridFrame.lines[lineIndex] = line
        end
        line:SetThickness(1)
        line:SetColorTexture(unpack(COLORS.gridLine))
        line:SetStartPoint("BOTTOMLEFT", gridFrame, centerX - offset, 0)
        line:SetEndPoint("TOPLEFT", gridFrame, centerX - offset, screenHeight)
        line:Show()
        lineIndex = lineIndex + 1
    end
    
    -- Draw horizontal lines from center outward (positive Y)
    for offset = gridSize, centerY, gridSize do
        line = gridFrame.lines[lineIndex]
        if not line then
            line = gridFrame:CreateLine(nil, "BACKGROUND")
            gridFrame.lines[lineIndex] = line
        end
        line:SetThickness(1)
        line:SetColorTexture(unpack(COLORS.gridLine))
        line:SetStartPoint("BOTTOMLEFT", gridFrame, 0, centerY + offset)
        line:SetEndPoint("BOTTOMRIGHT", gridFrame, screenWidth, centerY + offset)
        line:Show()
        lineIndex = lineIndex + 1
    end
    
    -- Draw horizontal lines from center outward (negative Y)
    for offset = gridSize, centerY, gridSize do
        line = gridFrame.lines[lineIndex]
        if not line then
            line = gridFrame:CreateLine(nil, "BACKGROUND")
            gridFrame.lines[lineIndex] = line
        end
        line:SetThickness(1)
        line:SetColorTexture(unpack(COLORS.gridLine))
        line:SetStartPoint("BOTTOMLEFT", gridFrame, 0, centerY - offset)
        line:SetEndPoint("BOTTOMRIGHT", gridFrame, screenWidth, centerY - offset)
        line:Show()
        lineIndex = lineIndex + 1
    end
    
    gridFrame:Show()
end

local function HideGrid()
    if gridFrame then
        gridFrame:Hide()
    end
end

-- ============================================================================
-- CONTAINER CREATION
-- ============================================================================

local function CreateContainer(trackerKey)
    if containers[trackerKey] then 
        -- Container already exists (created early), just load saved position
        local container = containers[trackerKey]
        local saved = GetSavedPosition(trackerKey)
        if saved then
            container:ClearAllPoints()
            container:SetPoint(saved.point, UIParent, saved.point, saved.x or 0, saved.y or 0)
        end
        return container
    end
    
    local displayName = DISPLAY_NAMES[trackerKey] or trackerKey
    
    local container = CreateFrame("Frame", "TUICD_Container_" .. trackerKey, UIParent)
    container:SetSize(200, 50)
    container:SetFrameStrata("LOW")
    container:SetFrameLevel(10)
    container:SetClampedToScreen(true)
    container:SetMovable(true)
    container:EnableMouse(false)
    
    -- Load saved position or use default
    local saved = GetSavedPosition(trackerKey)
    local pos = saved or DEFAULT_POSITIONS[trackerKey] or { point = "CENTER", x = 0, y = -100 }
    
    container:ClearAllPoints()
    container:SetPoint(pos.point, UIParent, pos.point, pos.x or 0, pos.y or 0)
    
    container.trackerKey = trackerKey
    container.displayName = displayName
    containers[trackerKey] = container
    
    return container
end

-- ============================================================================
-- OVERLAY (Enhanced with color states)
-- ============================================================================

local function UpdateOverlayAppearance(overlay)
    if not overlay then return end
    
    local borderColor
    local bgColor
    
    if overlay.isDragging then
        borderColor = COLORS.overlayBorderDragging
        bgColor = COLORS.overlayBackgroundSelected
    elseif overlay.isSelected then
        borderColor = COLORS.overlayBorderSelected
        bgColor = COLORS.overlayBackgroundSelected
    elseif overlay.isHovered then
        borderColor = COLORS.overlayBorderHover
        bgColor = COLORS.overlayBackground
    else
        borderColor = COLORS.overlayBorder
        bgColor = COLORS.overlayBackground
    end
    
    overlay:SetBackdropBorderColor(unpack(borderColor))
    overlay:SetBackdropColor(unpack(bgColor))
end

local function SelectOverlay(trackerKey)
    -- Deselect previous
    if selectedTrackerKey and overlays[selectedTrackerKey] then
        overlays[selectedTrackerKey].isSelected = false
        UpdateOverlayAppearance(overlays[selectedTrackerKey])
    end
    
    -- Select new
    selectedTrackerKey = trackerKey
    if trackerKey and overlays[trackerKey] then
        overlays[trackerKey].isSelected = true
        UpdateOverlayAppearance(overlays[trackerKey])
    end
end

local function CreateOverlay(trackerKey)
    if overlays[trackerKey] then return overlays[trackerKey] end
    
    local container = containers[trackerKey]
    if not container then return nil end
    
    local displayName = DISPLAY_NAMES[trackerKey] or trackerKey
    
    local overlay = CreateFrame("Frame", nil, containerFrame, "BackdropTemplate")
    overlay:SetFrameStrata("TOOLTIP")
    overlay:SetFrameLevel(1000)
    overlay:SetToplevel(true)
    
    -- Backdrop for border and background
    overlay:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = OVERLAY_BORDER_SIZE,
    })
    overlay:SetBackdropColor(unpack(COLORS.overlayBackground))
    overlay:SetBackdropBorderColor(unpack(COLORS.overlayBorder))
    
    -- Label background
    local labelBg = overlay:CreateTexture(nil, "BACKGROUND")
    labelBg:SetColorTexture(unpack(COLORS.labelBackground))
    overlay.labelBg = labelBg
    
    -- Label text
    local label = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetTextColor(unpack(COLORS.labelText))
    label:SetPoint("BOTTOM", overlay, "TOP", 0, 4)
    label:SetText(displayName)
    overlay.label = label
    
    -- Position label background around text
    labelBg:SetPoint("TOPLEFT", label, "TOPLEFT", -LABEL_PADDING, LABEL_PADDING)
    labelBg:SetPoint("BOTTOMRIGHT", label, "BOTTOMRIGHT", LABEL_PADDING, -LABEL_PADDING)
    
    -- Drag hint (smaller, at bottom)
    local hint = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hint:SetPoint("TOP", overlay, "BOTTOM", 0, -2)
    hint:SetText("|cff888888Click to select · Drag to move · Arrow keys to nudge|r")
    hint:SetScale(0.85)
    overlay.hint = hint
    
    -- State tracking
    overlay.isDragging = false
    overlay.isHovered = false
    overlay.isSelected = false
    overlay.trackerKey = trackerKey
    
    -- Enable interaction
    overlay:EnableMouse(true)
    overlay:RegisterForDrag("LeftButton")
    
    -- Event handlers
    overlay:SetScript("OnEnter", function(self)
        self.isHovered = true
        UpdateOverlayAppearance(self)
    end)
    
    overlay:SetScript("OnLeave", function(self)
        self.isHovered = false
        UpdateOverlayAppearance(self)
    end)
    
    overlay:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            SelectOverlay(self.trackerKey)
        end
    end)
    
    overlay:SetScript("OnDragStart", function(self)
        self.isDragging = true
        UpdateOverlayAppearance(self)
        SelectOverlay(self.trackerKey)
        container:StartMoving()
        container.isMoving = true
    end)
    
    overlay:SetScript("OnDragStop", function(self)
        self.isDragging = false
        UpdateOverlayAppearance(self)
        container:StopMovingOrSizing()
        container.isMoving = false
        
        -- Save position
        local point, _, _, x, y = container:GetPoint(1)
        SavePosition(trackerKey, point, x, y)
        
        TUICD:Print(displayName .. " position saved.")
    end)
    
    overlay:Hide()
    overlays[trackerKey] = overlay
    
    return overlay
end

local function UpdateOverlayPosition(trackerKey)
    local overlay = overlays[trackerKey]
    local container = containers[trackerKey]
    if not overlay or not container then return end
    
    overlay:ClearAllPoints()
    overlay:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
    overlay:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
end

-- ============================================================================
-- KEYBOARD NUDGING
-- ============================================================================

local function NudgeSelected(dx, dy)
    if not selectedTrackerKey then return end
    
    local container = containers[selectedTrackerKey]
    if not container then return end
    
    local point, relativeTo, relPoint, x, y = container:GetPoint(1)
    if not point then return end
    
    -- Apply nudge
    container:ClearAllPoints()
    container:SetPoint(point, relativeTo, relPoint, x + dx, y + dy)
    
    -- Save position
    SavePosition(selectedTrackerKey, point, x + dx, y + dy)
    
    -- Update overlay position
    UpdateOverlayPosition(selectedTrackerKey)
end

local function SetupKeyboardNudging()
    if not containerFrame then return end
    
    containerFrame:EnableKeyboard(true)
    containerFrame:SetPropagateKeyboardInput(true)
    
    containerFrame:SetScript("OnKeyDown", function(self, key)
        if not isUnlocked then
            self:SetPropagateKeyboardInput(true)
            return
        end
        
        -- Only handle if we have a selection
        if selectedTrackerKey then
            local amount = IsShiftKeyDown() and 10 or 1
            
            if key == "UP" then
                NudgeSelected(0, amount)
                self:SetPropagateKeyboardInput(false)
                return
            elseif key == "DOWN" then
                NudgeSelected(0, -amount)
                self:SetPropagateKeyboardInput(false)
                return
            elseif key == "LEFT" then
                NudgeSelected(-amount, 0)
                self:SetPropagateKeyboardInput(false)
                return
            elseif key == "RIGHT" then
                NudgeSelected(amount, 0)
                self:SetPropagateKeyboardInput(false)
                return
            end
        end
        
        -- Escape to exit layout mode
        if key == "ESCAPE" then
            LayoutMode:Lock()
            self:SetPropagateKeyboardInput(false)
            return
        end
        
        -- Let all other keys through
        self:SetPropagateKeyboardInput(true)
    end)
end

-- ============================================================================
-- CALCULATE CONTAINER SIZE FROM ICONS
-- ============================================================================

local function CalculateIconBounds(viewer)
    if not viewer or not viewer.GetChildren then return 50, 50 end
    
    local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge
    local hasIcons = false
    
    for _, child in ipairs({viewer:GetChildren()}) do
        if child and (child.Icon or child.icon or child.Cooldown or child.cooldown) then
            if child:IsShown() then
                local left = child:GetLeft()
                local right = child:GetRight()
                local top = child:GetTop()
                local bottom = child:GetBottom()
                
                if left and right and top and bottom then
                    local viewerLeft = viewer:GetLeft() or 0
                    local viewerTop = viewer:GetTop() or 0
                    
                    local relLeft = left - viewerLeft
                    local relRight = right - viewerLeft
                    local relTop = viewerTop - top
                    local relBottom = viewerTop - bottom
                    
                    minX = math.min(minX, relLeft)
                    maxX = math.max(maxX, relRight)
                    minY = math.min(minY, relTop)
                    maxY = math.max(maxY, relBottom)
                    hasIcons = true
                end
            end
        end
    end
    
    if hasIcons then
        local width = maxX - minX
        local height = maxY - minY
        return math.max(width, 50), math.max(height, 50)
    end
    
    return 100, 50
end

local function UpdateContainerSize(trackerKey)
    local container = containers[trackerKey]
    if not container then return end
    
    local viewerName = BLIZZARD_VIEWERS[trackerKey]
    local viewer = viewerName and _G[viewerName]
    
    -- For custom tracker, use TUICD frame
    if trackerKey == "customTrackers" then
        viewer = _G["TUICD_CustomTrackerFrame"] or _G["TweaksUI_CustomTrackerFrame"]
    end
    
    if not viewer then return end
    
    -- Use viewer size (set by ApplyGridLayout) - this is the actual content size
    local viewerWidth = viewer:GetWidth() or 100
    local viewerHeight = viewer:GetHeight() or 50
    
    -- Container size matches viewer size exactly (no padding for overlay)
    -- The overlay will match the container, so it perfectly covers the tracker grid
    local width = math.max(viewerWidth, 50)
    local height = math.max(viewerHeight, 30)
    
    container:SetSize(width, height)
    
    -- Re-center the viewer within the container
    -- Since container now equals viewer size, anchor viewer to CENTER
    if viewer._TUICD_Controlled then
        viewer._TUICD_Controlled = false
        viewer:ClearAllPoints()
        viewer:SetPoint("CENTER", container, "CENTER", 0, 0)
        viewer._TUICD_Controlled = true
    end
end

-- ============================================================================
-- REPARENT VIEWER TO CONTAINER
-- ============================================================================

local function ReparentViewerToContainer(trackerKey)
    local container = containers[trackerKey]
    if not container then return false end
    
    local viewerName = BLIZZARD_VIEWERS[trackerKey]
    local viewer = viewerName and _G[viewerName]
    
    if not viewer then return false end
    
    -- Store original data (only once)
    if not originalViewerData[trackerKey] then
        originalViewerData[trackerKey] = {
            parent = viewer:GetParent(),
            points = {},
            originalSetPoint = viewer.SetPoint,
            originalClearAllPoints = viewer.ClearAllPoints,
        }
        for i = 1, viewer:GetNumPoints() do
            local point, relativeTo, relativePoint, xOfs, yOfs = viewer:GetPoint(i)
            table.insert(originalViewerData[trackerKey].points, {
                point = point,
                relativeTo = relativeTo,
                relativePoint = relativePoint,
                x = xOfs,
                y = yOfs
            })
        end
    end
    
    -- Reparent viewer to container
    viewer:SetParent(container)
    viewer:ClearAllPoints()
    viewer:SetPoint("CENTER", container, "CENTER", 0, 0)
    
    -- Mark viewer as controlled
    viewer._TUICD_Container = container
    viewer._TUICD_Controlled = true
    
    -- Hook SetPoint to prevent Edit Mode interference
    local origSetPoint = originalViewerData[trackerKey].originalSetPoint
    viewer.SetPoint = function(self, ...)
        if self._TUICD_Controlled then
            return
        end
        return origSetPoint(self, ...)
    end
    
    local origClearAllPoints = originalViewerData[trackerKey].originalClearAllPoints
    viewer.ClearAllPoints = function(self, ...)
        if self._TUICD_Controlled then
            return
        end
        return origClearAllPoints(self, ...)
    end
    
    -- Update container size
    C_Timer.After(0.2, function()
        UpdateContainerSize(trackerKey)
    end)
    
    viewer:SetAlpha(1)
    viewer:Show()
    container:Show()
    
    return true
end

-- ============================================================================
-- CUSTOM TRACKER CONTAINER
-- ============================================================================

local function SetupCustomTrackerContainer()
    local customFrame = _G["TUICD_CustomTrackerFrame"] or _G["TweaksUI_CustomTrackerFrame"]
    if not customFrame then return end
    if customFrame._TUICD_ContainerSetup then return end
    
    local trackerKey = "customTrackers"
    
    -- Create container
    local container = CreateContainer(trackerKey)
    
    -- Reparent custom tracker to container
    customFrame:SetParent(container)
    customFrame:ClearAllPoints()
    customFrame:SetPoint("CENTER", container, "CENTER", 0, 0)
    
    -- Create overlay
    CreateOverlay(trackerKey)
    
    -- Update size
    C_Timer.After(0.5, function()
        UpdateContainerSize(trackerKey)
    end)
    
    customFrame._TUICD_ContainerSetup = true
end

-- ============================================================================
-- PER-ICON FRAME SUPPORT (CooldownHighlights, BuffHighlights)
-- ============================================================================

local perIconFrames = {}  -- Track registered per-icon frames
local perIconOverlays = {}  -- Overlays for per-icon frames

local function CreatePerIconOverlay(frame, displayName)
    if not frame then return nil end
    
    local overlay = CreateFrame("Frame", nil, containerFrame, "BackdropTemplate")
    overlay:SetAllPoints(frame)
    overlay:SetFrameStrata("TOOLTIP")
    overlay:SetFrameLevel(1000)
    
    overlay:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    overlay:SetBackdropColor(0, 0.8, 0.5, 0.5)
    overlay:SetBackdropBorderColor(0, 1, 0.6, 1)
    
    local hint = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hint:SetPoint("CENTER", 0, 0)
    hint:SetText("Drag")
    hint:SetTextColor(1, 1, 1, 0.8)
    overlay.hint = hint
    
    -- Enable dragging - capture all mouse activity
    overlay:EnableMouse(true)
    overlay:RegisterForDrag("LeftButton")
    overlay:SetScript("OnMouseDown", function() end)  -- Capture clicks to prevent pass-through
    overlay:SetScript("OnMouseUp", function() end)
    
    overlay:SetScript("OnDragStart", function(self)
        frame:StartMoving()
    end)
    
    overlay:SetScript("OnDragStop", function(self)
        frame:StopMovingOrSizing()
        -- Save position
        local point, _, relPoint, x, y = frame:GetPoint(1)
        local trackerKey = frame.trackerKey
        local slotIndex = frame.slotIndex
        
        if trackerKey and slotIndex then
            if trackerKey == "buffs" then
                -- BuffHighlights
                if TUICD.BuffHighlights and TUICD.BuffHighlights.SetPosition then
                    TUICD.BuffHighlights:SetPosition(slotIndex, point, relPoint or point, x, y)
                end
            else
                -- CooldownHighlights (essential, utility)
                if TUICD.CooldownHighlights and TUICD.CooldownHighlights.SetPosition then
                    TUICD.CooldownHighlights:SetPosition(trackerKey, slotIndex, point, relPoint or point, x, y)
                end
            end
        end
        TUICD:Print(displayName .. " position saved.")
    end)
    
    overlay:Hide()
    return overlay
end

local function ShowPerIconOverlays()
    for key, data in pairs(perIconFrames) do
        if data.frame and data.frame:IsShown() then
            if not perIconOverlays[key] then
                perIconOverlays[key] = CreatePerIconOverlay(data.frame, data.displayName)
            end
            if perIconOverlays[key] then
                perIconOverlays[key]:Show()
            end
        end
    end
end

local function HidePerIconOverlays()
    for key, overlay in pairs(perIconOverlays) do
        if overlay then
            overlay:Hide()
        end
    end
end

-- ============================================================================
-- DISABLE/ENABLE MOUSE ON VIEWER ICONS
-- ============================================================================

-- Store original mouse state for icons so we can restore them
local iconMouseStates = {}  -- [frame] = originalMouseEnabled

local function DisableMouseOnViewerIcons()
    -- Clear previous state
    wipe(iconMouseStates)
    
    -- Disable mouse on Blizzard viewer children
    for trackerKey, viewerName in pairs(BLIZZARD_VIEWERS) do
        local viewer = _G[viewerName]
        if viewer and viewer.GetChildren then
            for _, child in ipairs({viewer:GetChildren()}) do
                -- Check if this looks like an icon frame
                if child and (child.Icon or child.icon or child.Cooldown or child.cooldown) then
                    iconMouseStates[child] = child:IsMouseEnabled()
                    child:EnableMouse(false)
                end
            end
        end
    end
    
    -- Disable mouse on custom tracker icons
    local customTrackerIcons = TUICD.Cooldowns and TUICD.Cooldowns.GetCustomTrackerIcons and TUICD.Cooldowns:GetCustomTrackerIcons()
    if customTrackerIcons then
        for _, iconFrame in pairs(customTrackerIcons) do
            if iconFrame then
                iconMouseStates[iconFrame] = iconFrame:IsMouseEnabled()
                iconFrame:EnableMouse(false)
            end
        end
    end
end

local function RestoreMouseOnViewerIcons()
    -- Restore original mouse state for all tracked icons
    for frame, wasEnabled in pairs(iconMouseStates) do
        if frame and frame.EnableMouse then
            frame:EnableMouse(wasEnabled)
        end
    end
    wipe(iconMouseStates)
end

-- ============================================================================
-- LAYOUT UI CONTAINER
-- ============================================================================

local function CreateLayoutContainer()
    if containerFrame then return end
    
    containerFrame = CreateFrame("Frame", "TUICD_LayoutContainer", UIParent)
    containerFrame:SetFrameStrata("TOOLTIP")
    containerFrame:SetAllPoints()
    containerFrame:Hide()
    
    -- Create grid
    CreateGrid()
    
    -- Setup keyboard handling
    SetupKeyboardNudging()
end

-- ============================================================================
-- UNLOCK/LOCK TOGGLE
-- ============================================================================

function LayoutMode:Unlock()
    if isUnlocked then return end
    isUnlocked = true
    
    -- Ensure layout container exists
    CreateLayoutContainer()
    
    TUICD:Print("|cff00ff00Layout Mode enabled.|r")
    TUICD:Print("  • Click a tracker to select it")
    TUICD:Print("  • Drag to move, Arrow keys to nudge (Shift = 10px)")
    TUICD:Print("  • Press ESC or type /tuicd layout to exit")
    
    -- Show container frame
    containerFrame:Show()
    
    -- Show grid
    UpdateGrid()
    
    -- Disable mouse on all viewer icons so overlay can receive clicks
    DisableMouseOnViewerIcons()
    
    -- Show all tracker overlays
    for trackerKey, overlay in pairs(overlays) do
        -- Update container size first
        UpdateContainerSize(trackerKey)
        UpdateOverlayPosition(trackerKey)
        overlay:Show()
    end
    
    -- Show per-icon overlays
    ShowPerIconOverlays()
    
    -- Select first available tracker
    for trackerKey in pairs(overlays) do
        SelectOverlay(trackerKey)
        break
    end
    
    -- Fire event
    TUICD.Events:Fire("LAYOUT_MODE_ENTER")
end

function LayoutMode:Lock()
    if not isUnlocked then return end
    isUnlocked = false
    
    TUICD:Print("|cffff8800Layout Mode disabled.|r Positions saved.")
    
    -- Hide container frame
    if containerFrame then
        containerFrame:Hide()
    end
    
    -- Hide grid
    HideGrid()
    
    -- Hide all tracker overlays
    for _, overlay in pairs(overlays) do
        overlay:Hide()
    end
    
    -- Hide per-icon overlays
    HidePerIconOverlays()
    
    -- Clear selection
    selectedTrackerKey = nil
    
    -- Restore mouse on all viewer icons
    RestoreMouseOnViewerIcons()
    
    -- Fire event
    TUICD.Events:Fire("LAYOUT_MODE_EXIT")
end

function LayoutMode:Toggle()
    if isUnlocked then
        self:Lock()
    else
        self:Unlock()
    end
end

function LayoutMode:IsUnlocked()
    return isUnlocked
end

function LayoutMode:RegisterPerIconFrame(frame, trackerKey, slotIndex, displayName)
    if not frame then return end
    
    local key = trackerKey .. "_" .. slotIndex
    perIconFrames[key] = {
        frame = frame,
        trackerKey = trackerKey,
        slotIndex = slotIndex,
        displayName = displayName or ("Icon " .. slotIndex)
    }
    
    -- Create overlay if we're already unlocked
    if isUnlocked then
        if not perIconOverlays[key] then
            perIconOverlays[key] = CreatePerIconOverlay(frame, displayName)
        end
        if perIconOverlays[key] then
            perIconOverlays[key]:Show()
        end
    end
end

function LayoutMode:UnregisterPerIconFrame(trackerKey, slotIndex)
    local key = trackerKey .. "_" .. slotIndex
    if perIconOverlays[key] then
        perIconOverlays[key]:Hide()
        perIconOverlays[key] = nil
    end
    perIconFrames[key] = nil
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

function LayoutMode:Initialize()
    -- Create layout container first
    CreateLayoutContainer()
    
    -- Create containers and overlays for Blizzard viewers
    for trackerKey, viewerName in pairs(BLIZZARD_VIEWERS) do
        CreateContainer(trackerKey)
        CreateOverlay(trackerKey)
    end
    
    -- Create container for custom tracker
    CreateContainer("customTrackers")
    CreateOverlay("customTrackers")
    
    -- Delay reparenting until viewers exist
    C_Timer.After(1.0, function()
        for trackerKey, viewerName in pairs(BLIZZARD_VIEWERS) do
            if _G[viewerName] then
                ReparentViewerToContainer(trackerKey)
            end
        end
        
        -- Setup custom tracker
        SetupCustomTrackerContainer()
    end)
    
    -- Also try again later in case viewers load late
    C_Timer.After(3.0, function()
        for trackerKey, viewerName in pairs(BLIZZARD_VIEWERS) do
            if _G[viewerName] and not originalViewerData[trackerKey] then
                ReparentViewerToContainer(trackerKey)
            end
        end
        SetupCustomTrackerContainer()
    end)
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

function LayoutMode:GetContainer(trackerKey)
    return containers[trackerKey]
end

function LayoutMode:RefreshContainerSize(trackerKey)
    if trackerKey then
        UpdateContainerSize(trackerKey)
        UpdateOverlayPosition(trackerKey)
    else
        for key in pairs(containers) do
            UpdateContainerSize(key)
            UpdateOverlayPosition(key)
        end
    end
end

function LayoutMode:GetSelectedTracker()
    return selectedTrackerKey
end

-- ============================================================================
-- SLASH COMMAND
-- ============================================================================

SLASH_TUICDLAYOUT1 = "/tuicdlayout"
SlashCmdList["TUICDLAYOUT"] = function(msg)
    msg = (msg or ""):lower():trim()
    
    if msg == "debug" then
        TUICD:Print("Layout Mode Debug Info:")
        print("  isUnlocked: " .. tostring(isUnlocked))
        print("  selectedTrackerKey: " .. tostring(selectedTrackerKey))
        print("  Containers:")
        for key, container in pairs(containers) do
            local x, y = container:GetCenter() or 0, 0
            print("    " .. key .. ": shown=" .. tostring(container:IsShown()) .. " size=" .. math.floor(container:GetWidth() or 0) .. "x" .. math.floor(container:GetHeight() or 0) .. " pos=" .. math.floor(x) .. "," .. math.floor(y))
        end
        print("  Overlays:")
        for key, overlay in pairs(overlays) do
            print("    " .. key .. ": shown=" .. tostring(overlay:IsShown()) .. " selected=" .. tostring(overlay.isSelected) .. " size=" .. math.floor(overlay:GetWidth() or 0) .. "x" .. math.floor(overlay:GetHeight() or 0))
        end
        print("  Blizzard Viewers:")
        for key, viewerName in pairs(BLIZZARD_VIEWERS) do
            local viewer = _G[viewerName]
            if viewer then
                local parent = viewer:GetParent()
                local parentName = parent and (parent:GetName() or "unnamed") or "nil"
                print("    " .. key .. " (" .. viewerName .. "): exists=true parent=" .. parentName .. " controlled=" .. tostring(viewer._TUICD_Controlled))
            else
                print("    " .. key .. " (" .. viewerName .. "): exists=false")
            end
        end
        print("  Original Viewer Data:")
        for key, data in pairs(originalViewerData) do
            print("    " .. key .. ": reparented=true")
        end
    elseif msg == "grid" then
        if gridFrame and gridFrame:IsShown() then
            HideGrid()
            TUICD:Print("Grid hidden.")
        else
            UpdateGrid()
            TUICD:Print("Grid shown.")
        end
    else
        LayoutMode:Toggle()
    end
end
