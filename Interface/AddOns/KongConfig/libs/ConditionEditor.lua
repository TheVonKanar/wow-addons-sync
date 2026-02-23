--------------------------------------------------------------------------------
-- ConditionEditor
-- An interface for configuring LibUSC conditions
--------------------------------------------------------------------------------
local Type, Version = "ConditionEditor", 3
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

local LibUSC = LibStub("LibUserSpecifiedConditions")

local DEFAULT_COLOR = "|cFF00AAFF"
local FOCUS_COLOR = "|cFFFFFFFF"
local FOCUS_PARAM_COLOR = "|cFF444444"
local INVALID_COLOR = "|cFFFF0000"
local DISABLED_COLOR = "|cFF888888"

local CANCEL = "|TInterface/Buttons/UI-GroupLoot-Pass-Up:0:0:0:1|t Cancel"

StaticPopupDialogs["LibUSC_EnterValue"] = {
    text = "%s:",
    button1 = ACCEPT,
    button2 = CANCEL,
    OnShow = function(self, data)
        self:GetButton1():Disable()
    end,
    OnAccept = function(self, Parameters)
        for _, Parameter in ipairs(Parameters) do
            if "Number" == Parameter.type then
                Parameter:SetValue(tonumber(self:GetEditBox():GetText()))
            else
                Parameter:SetValue(self:GetEditBox():GetText())
            end
            Parameter:FireStructureChanged();
        end
        self.widget.selectedKey = nil
    end,
    OnCancel  = function(self)
        self.widget.selectedKey = nil
    end,
    hasEditBox = true,
    EditBoxOnTextChanged = function(EditBox)
        local self = EditBox:GetParent()
        for _, Parameter in ipairs(self.data) do
            if "Number" == Parameter.type then
                if nil ~= tonumber(EditBox:GetText()) then
                    self:GetButton1():Enable()
                else
                    self:GetButton1():Disable()
                end
            else
                if "" ~= EditBox:GetText() then
                    self:GetButton1():Enable()
                else
                    self:GetButton1():Disable()
                end
            end
            break
        end
    end,
    EditBoxOnEnterPressed = function(EditBox, Parameter)
        EditBox:GetParent():GetButton1():Click()
    end,
    EditBoxOnEscapePressed = function(EditBox, Parameter)
        EditBox:GetParent():GetButton2():Click()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

-- Scripts ---------------------------------------------------------------------
local function KeyToFunctionAndParamIndex(key, Func)

    local paramIndex = 1
    for index in string.gmatch(key, "(%d)") do
        Func = Func.Parameters[paramIndex]
        paramIndex = tonumber(index)
    end
    
    return Func, paramIndex
end

local function WrapDescription(desc, width)
    
    if desc then
        local length = desc:len()
        local rows = math.max(1, math.floor(length/(width or 30) + .5))
        local margin = math.ceil(length/rows)
        
        local crlf = 1
        local text = {}
        for i=1,rows do
            local j = 0
            repeat 
                if length <= margin*i+j then
                    text[i] = desc:sub(crlf)
                    break;
                end
                    
                local sub = desc:sub(margin*i-j, margin*i+j)
                local loc = sub:find(" ") 
                if loc then
                    loc = margin*i-j+loc-1
                    text[i] = desc:sub(crlf, loc)
                    crlf = loc+1
                    break;
                end
                j = j+1
            until false
        end
        
        return table.concat(text, "\n")
    end
end

local function OnClick(Editor, key, text, button)
    local self = Editor.obj
    
    local Func, paramIndex = KeyToFunctionAndParamIndex(key, self.Conditions[1])

    self.Dropdown:SetMenuList({})
    
    local CategoryMenus = {}
    local typeFilter = Func.ParameterTypes[paramIndex]
    for name, Param in pairs(LibUSC.Parameters) do
        if (type(typeFilter) == "table" and tContains(typeFilter,Param.type))
        or typeFilter == Param.type or typeFilter == "Any" then
            if not Param.isHidden then
                CategoryMenus[Param.category] = CategoryMenus[Param.category] 
                    or self.Dropdown:AddItem(Param.category)
                local overrideString = Param:GetMenuOverrideString()
                local item = self.Dropdown:AddItem(name, 
                    DEFAULT_COLOR..Param.type..":|r "..(overrideString or name), CategoryMenus[Param.category])
                item.tooltipTitle = DEFAULT_COLOR..Param.type..":|r "..(overrideString or name)
                item.tooltipText = WrapDescription(Param:GetDescription())
                item.tooltipOnButton = 1
            end
        end
    end
    self.Dropdown:Sort()
    self.Dropdown:AddItem(CANCEL)
    
	if ( GetMouseFocus ~= nil ) then
        ToggleDropDownMenu(nil, nil, self.Dropdown.dropdown, GetMouseFocus(), 0, 0, self.Dropdown.menuList)
	else
        ToggleDropDownMenu(nil, nil, self.Dropdown.dropdown, GetMouseFoci()[1], 0, 0, self.Dropdown.menuList)
	end
        
    self.selectedKey = key
end

local function ParamValueToString(Param)

    local value = Param:GetValue(value)
    if type(value) == "string" then
        return "|cff888888Current Value: \""..value.."\"|r"
    else
        return "|cFF888888Current Value: "..tostring(value).."|r"
    end
end

local function OnEnter(Editor, key, text)
    local self = Editor.obj
    self.hoveredKey = key
    
    local Func, paramIndex = KeyToFunctionAndParamIndex(key, self.Conditions[1])
    local Param = Func.Parameters[paramIndex]
    
    GameTooltip:SetOwner(self.frame, "ANCHOR_TOP")
    local valid, msg = Param:IsValid()
    if valid and IsModifierKeyDown() then
        GameTooltip:AddDoubleLine(DEFAULT_COLOR..Param.type..":|r "..Param.name,
            ParamValueToString(Param), 1,1,1)
        GameTooltip:AddLine(Param:GetDescription(), nil, nil, nil, true)
    else
        GameTooltip:AddLine(DEFAULT_COLOR..Param.type..":|r "..Param.name, 1,1,1)
        GameTooltip:AddLine(Param:GetDescription(), nil, nil, nil, true)
    end
    if (not valid) or IsModifierKeyDown() then
        if not valid then
            GameTooltip:AddLine("Error: "..msg, 1,0,0,1)
        end
        for _, Child in ipairs(Param.Parameters) do 
            GameTooltip:AddDoubleLine("\226\128\162 "..DEFAULT_COLOR..Child.type..":|r "..Child.name,
                                      ParamValueToString(Child), 1,1,1)
        end
    else
        -- GameTooltip:AddLine(ParamValueToString(Param))
        GameTooltip:AddDoubleLine("Click to Change", "Details: Shift", 1,1,1, .25,.25,.25)
    end
    GameTooltip:Show()
end

local function OnLeave(Editor)
    local self = Editor.obj
    self.hoveredKey = nil
    GameTooltip:Hide()
end

local function OnConditionChanged(Dropdown, _, value)
    local self = Dropdown.obj
    
    if value ~= CANCEL then
        local UserEnteredParams, Parameter
        for _, Condition in ipairs(self.Conditions) do

            local Func, paramIndex = KeyToFunctionAndParamIndex(self.selectedKey, Condition)
            
            if Func:GetParameter(paramIndex):GetName() ~= value then
                local newParam = LibUSC:Create(value)
                local previousParam = 
                    Func:SetParameter(paramIndex, newParam, true)
                
                -- for i,childParamType in ipairs(newParam:GetParameterTypes() or {}) do
                    -- if childParamType == previousParam:GetType() then
                        -- newParam:SetParameter(i, previousParam)
                        -- previousParam = nil
                        -- break;
                    -- end
                -- end
                
                -- if previousParam then
                    LibUSC:Deflate(previousParam)
                -- end
            end
            
            Parameter = Func:GetParameter(paramIndex)
            if Parameter.isUserEntered then
                UserEnteredParams = UserEnteredParams or {}
                tinsert(UserEnteredParams, Parameter)
            end
        end
    
        if UserEnteredParams then
            local dialog = StaticPopup_Show("LibUSC_EnterValue", Parameter:GetName())
            if (dialog) then
                dialog:GetEditBox():SetText(Parameter:GetValue())
                dialog:GetEditBox():HighlightText()
                dialog.widget = self
                dialog.data = UserEnteredParams
            end
        end
    end
    
    self.selectedKey = nil
end

local function GenerateHypertext(self, key, Param)
    
    local hypertext = Param:GetConfigString()

    local color = DEFAULT_COLOR
    if self.coloredKey == key then
        color = FOCUS_COLOR
    elseif self.coloredKey and (string.find(key, self.coloredKey) == 1) then
        color = FOCUS_PARAM_COLOR
    elseif not Param:IsValid() then
        color = INVALID_COLOR
    elseif not self.Editor:GetHyperlinksEnabled() then
        color = DISABLED_COLOR
    end
    
    if Param.Parameters then 
        for i=1,#Param.Parameters do
            
            local childString = GenerateHypertext(self, key..i.." ", Param.Parameters[i])
            hypertext = string.gsub(hypertext, "{"..i.."}",
                "|h|r"..string.gsub(childString, "%%", "%%%%")..color.."|H"..key.."|h")
        end
    end
    
    return color.."|H"..key.."|h".."["..hypertext.."]".."|h|r"
end

-- Methods ---------------------------------------------------------------------
local Methods = {
    ["OnAcquire"] = function(self)
        self:SetWidth(300)
        self:SetHeight(20)
    end,
    
    ["OnRelease"] = function(self)
        for i=#self.Conditions,1,-1 do
            self:RemoveCondition(self.Conditions[i])
        end
    end,
    
    ["OnWidthSet"] = function(self, width)
        self.Editor:SetWidth(width);
        self.FontString:SetWidth(width);

        self.Editor:SetText(self.FontString:GetText() or "", false)
        self:SetHeight(self.FontString:GetHeight())
    end,
    
    ["OnHeightSet"] = function(self, height)
        self.Editor:SetHeight(height);
    end,
    
    ["SetEnabled"] = function(self, enabled)
        self.Editor:SetHyperlinksEnabled(enabled)
        self.Editor:EnableMouse(enabled)
        if #self.Conditions > 0 then
            self:SetText(GenerateHypertext(self, " ", self.Conditions[1].Parameters[1]))
        end
    end,
    
    ["SetText"] = function(self, text) 
        self.Editor:SetText(text)
        self.FontString:SetText(text)
        self:SetHeight(self.FontString:GetHeight())

        -- Layout starting at root panel
        local Root = self.frame:GetParent().obj
        while Root do
            if Root.parent then
                Root = Root.parent
            else
                Root:DoLayout()
                break;
            end
        end
    end,
    
    ["GetText"] = function(self, text) 
        return self.FontString:GetText()
    end,
    
    ["AddCondition"] = function(self, Condition)
        assert((#self.Conditions == 0) or self.Conditions[1]:Equals(Condition),
            "Given condition is not equal to current editor condition(s)")
        for i, v in ipairs(self.Conditions) do
            assert(Condition ~= v, "Given condition is already being edited by this editor")
        end
            
        tinsert(self.Conditions, Condition)
        Condition:AddStructureListener(self.OnStructureChange, self)
        if #self.Conditions == 1 then
            self:SetText(GenerateHypertext(self, " ", Condition.Parameters[1]))
        end
    end,
    
    ["RemoveCondition"] = function(self, Condition)
        for i, v in ipairs(self.Conditions) do
            if Condition == v then
                tremove(self.Conditions, i)
                -- TODO should this check really be here?
                if (Condition.RemoveStructureListener) then
                    Condition:RemoveStructureListener(self)
                end
            end
        end
        
        if #self.Conditions == 0 then
            self:SetText("")
        end
    end,
    
    ["OnStructureChange"] = function(self)
        self:SetText(GenerateHypertext(self, " ", self.Conditions[1].Parameters[1]))
    end,
}

-- Constructor -----------------------------------------------------------------
local function Constructor()

    local Frame = CreateFrame("Frame", nil, UIParent)
    --Frame:SetMaxResize(1000, 1000)
    
    local Editor = CreateFrame("SimpleHtml", editorName, Frame)

    Editor:SetAllPoints(Frame)
    Editor:SetJustifyH("P", "left")
    Editor:SetSpacing("P", 2)
    Editor:SetFontObject("P", "GameFontNormal")
    Editor:SetTextColor("P", 1, 1, 1)
    -- Editor:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
    --    edgeFile = "Interface/Buttons/WHITE8X8", edgeSize=1})
    Editor:SetScript("OnHyperlinkClick", OnClick)
	--Editor:SetScript("OnHyperlinkEnter", OnEnter)
	--Editor:SetScript("OnHyperlinkLeave", OnLeave)
    Editor:SetScript("OnLeave", OnLeave)
    
    local FontString = Editor:CreateFontString()
    FontString:SetSpacing(2)
    FontString:SetFontObject("GameFontNormal")
    FontString:Hide()

    -- Workaround for the inability to set SimpleHTML text from inside OnHyperlinkEnter/Leave
    CreateFrame("Frame", nil, Editor):SetScript("OnUpdate", function()
        local self = Editor.obj

        local coloredKey
        if self.hoveredKey and self.Editor:IsMouseOver() then
            coloredKey = self.hoveredKey
            OnEnter(Editor, coloredKey)
        elseif DropDownList1:IsShown() 
        and (DropDownList1.dropdown == self.Dropdown.dropdown) then
            coloredKey = self.selectedKey
        end
        
        if self.coloredKey ~= coloredKey then
            self.coloredKey = coloredKey
            if #self.Conditions > 0 then
                self:SetText(GenerateHypertext(self, " ", self.Conditions[1].Parameters[1]))
            end
            if not Editor:IsMouseOver() then
                OnLeave(self.Editor)
            end
        end
    end)
    
    local Dropdown = LibStub("AceGUI-3.0"):Create("EasyMenuDropDown")
    Dropdown.dropdown:SetParent(Frame)
    Dropdown:SetCallback("OnValueChanged", OnConditionChanged)
    
    local widget = {
        frame        = Frame,
        Editor       = Editor,
        FontString   = FontString,
        Dropdown     = Dropdown,
        Conditions   = {},
        type         = Type,
    }
    for method, func in pairs(Methods) do
        widget[method] = func
    end
    
    Editor.obj = widget
    Dropdown.obj = widget
    
    return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
