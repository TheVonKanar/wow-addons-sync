TalentsWidgetDB = TalentsWidgetDB or {}

-- Create main frame
local mainFrame = CreateFrame("Button", "WUI_TalentsWidget", UIParent)
mainFrame:SetSize(297, 30)

-- Set saved position or default
local function RestorePosition()
    local pos = TalentsWidgetDB.position
    if pos then
        mainFrame:ClearAllPoints()
        mainFrame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.xOfs, pos.yOfs)
    else
        mainFrame:SetPoint("TOP", UIParent, "TOP", 0, -100) -- default position
    end
end

-- Save current position
local function SavePosition()
    local point, _, relativePoint, xOfs, yOfs = mainFrame:GetPoint()
    TalentsWidgetDB.position = {
        point = point,
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs
    }
end

-- Make the frame draggable
mainFrame:SetMovable(true)
mainFrame:EnableMouse(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetClampedToScreen(true)

mainFrame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)

mainFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    SavePosition()
end)

-- Background
mainFrame.bg = mainFrame:CreateTexture(nil, "BACKGROUND")
mainFrame.bg:SetAllPoints()
mainFrame.bg:SetColorTexture(0, 0, 0, 0.5)

-- Font string
mainFrame.text = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
mainFrame.text:SetPoint("LEFT", 6, 0)

-- Update logic
local function UpdateLoadoutDisplay()
    local specID = GetSpecialization() and select(1, GetSpecializationInfo(GetSpecialization()))
    local savedConfigID = C_ClassTalents.GetLastSelectedSavedConfigID(specID)
    if savedConfigID then
        local info = C_Traits.GetConfigInfo(savedConfigID)
        if info and info.name and info.name ~= "" then
            mainFrame.text:SetText(info.name)
            return
        end
    end

    local activeConfigID = C_ClassTalents.GetActiveConfigID()
    if activeConfigID then
        local activeInfo = C_Traits.GetConfigInfo(activeConfigID)
        if activeInfo and activeInfo.name and activeInfo.name ~= "" then
            mainFrame.text:SetText(activeInfo.name)
            return
        end
    end

    local _, specName = GetSpecializationInfo(GetSpecialization())
    mainFrame.text:SetText("Spec: " .. (specName or "Unknown"))
end

-- Swap Buttons
local function CreateSwapButtonFrame(parent, text, loadoutName, offsetX)
    local frame = CreateFrame("Button", "WUI_TalentsWidget_" .. loadoutName .. "_Button", mainFrame)

    -- Position and size
    frame:SetPoint("RIGHT", offsetX, 0)
    frame:SetSize(24, 24)

    -- Text
    frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    --frame.text:SetFont()
    frame.text:SetPoint("CENTER")
    frame.text:SetText(text)

    -- Border
    --frame.border = frame:CreateTexture(nil, "BORDER")
    --frame.border:SetAllPoints()
    --frame.border:SetColorTexture(0, 0, 1, 1)

    -- Events
    frame:SetScript("OnClick", function(self, button, down)
        C_ClassTalents.SwitchToLoadoutByName(loadoutName)
    end)

    return frame
end

CreateSwapButtonFrame(mainFrame, "R", "Stormbringer - Raid", -62)
CreateSwapButtonFrame(mainFrame, "M", "Stormbringer - M+", -34)
CreateSwapButtonFrame(mainFrame, "W", "Stormbringer - World", -6)

-- Events
mainFrame:RegisterEvent("PLAYER_LOGIN")
mainFrame:RegisterEvent("TRAIT_CONFIG_LIST_UPDATED")
mainFrame:RegisterEvent("TRAIT_CONFIG_UPDATED")
mainFrame:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")
mainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

mainFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        RestorePosition()
        UpdateLoadoutDisplay()
    else
        C_Timer.After(0.2, UpdateLoadoutDisplay)
    end
end)

mainFrame:SetScript("OnClick", function(self, button, down)
    PlayerSpellsFrame:Show()
end)
