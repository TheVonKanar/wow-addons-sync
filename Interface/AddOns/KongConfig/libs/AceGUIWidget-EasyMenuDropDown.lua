--[[----------------------------------------------------------------------------
EasyMenuDropDown Widget
AceGUI wrapper for an EasyMenu()-created drop down menu
------------------------------------------------------------------------------]]
local Type, Version = "EasyMenuDropDown", 2
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Private Methods -------------------------------------------------------------
local function Button_OnClick(button)
    local self = button.obj
    ToggleDropDownMenu(nil, nil, self.dropdown, self.dropdown, 18, 0, self.menuList)
end

local function Item_OnClick(button)
    local self = button.arg1
    
    if not button.keepShownOnClick then 
        CloseDropDownMenus()
    end
    
    self:SetValue(button.value)
    
    self.ValuePath = {}
    for i = 1,button:GetParent():GetID() do
        tinsert(self.ValuePath, button.value)
    end
    
    self:Fire("OnValueChanged", self.value)
end

local function RecursiveSort(menuList, comp)
    table.sort(menuList, comp)
    for _, item in ipairs(menuList) do
        if item.menuList then
            RecursiveSort(item.menuList, comp)
        end
    end
end

local function BuildMenu(frame, level, menuList)
    for i = 1, #menuList do
		local info = menuList[i]
		if ( info.text ~= nil ) then
			info.index = i
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

-- Fix for large menus that Blizzard positions past the top of the screen
hooksecurefunc("ToggleDropDownMenu", function(level) 
	if level then 
		local listFrame = _G["DropDownList"..level];
		if listFrame:GetTop() > UIParent:GetTop() then
			for i = 1,listFrame:GetNumPoints() do
				point, anchorFrame, relativePoint, xOffset, yOffset = 
					listFrame:GetPoint(i)
				listFrame:SetPoint(point, anchorFrame, relativePoint, xOffset, 
					UIParent:GetTop() - listFrame:GetTop() - 14)
			end
		end
	end
end)

-- Public Methods --------------------------------------------------------------
local methods = {
    ["OnAcquire"] = function(self)
        self:SetWidth(210)
        self:SetHeight(self.dropdown:GetHeight())
        self:SetMenuList({})
        self:SetText("")
        self.value = nil
    end,
    
    ["OnWidthSet"] = function(self, width)
        UIDropDownMenu_SetWidth(self.dropdown, width-18, 18)
    end,
    
    ["SetMenuList"] = function(self, menuList)
        self.menuList = menuList
        UIDropDownMenu_Initialize(self.dropdown, BuildMenu, nil, nil, self.menuList);
    end,
    
    ["SetText"] = function(self, text)
        self.text:SetText(text)
    end,
    
    ["SetLabel"] = function(self, text) 
        self.label:SetText(text)
    end,
    
    ["SetMultiselect"] = function(self, multiselect)
        self.multiselect = multiselect
    end,
    
    -- AddItem(value [, text] [, submenu])
    ["AddItem"] = function(self, value, arg2, arg3)
        
        local text, submenu
        if type(arg2) == "string" then
            text = arg2
            if arg3 then
                assert(type(arg3) == "table", 
                    "Bad param #3 (table expected, got "..tostring(arg3)..")")
                submenu = arg3
            end
        else
            text = tostring(value)
            if arg2 then
                assert(type(arg2) == "table", 
                    "Bad param #2 (string or table expected, got "..tostring(arg2)..")")
                submenu = arg2
            end
        end
    
        local item = {
            value = value,
            text = text,
            notCheckable = not self.multiselect,
            keepShownOnClick = self.multiSelect, 
            func = Item_OnClick,
            arg1 = self,
        }
        
        if submenu then
            assert(type(submenu) == "table", 
                "Bad param #3 (table expected, got "..tostring(submenu)..")")
            
            -- Add menu item to submenu
            submenu.menuList = submenu.menuList or {}
            tinsert(submenu.menuList, item)
            submenu.hasArrow = true
            submenu.keepShownOnClick = true
            submenu.func = nil
        else
            tinsert(self.menuList, item)
        end
        
        return item
    end,
    
    ["GetValue"] = function(self)
        return self.value
    end,
    
    ["SetValue"] = function(self, value)
        self.value = value
        self:SetText(value)
        
        for _, item in pairs(self.menuList) do
            if value == item.value then
                self:SetText(item.text)
                break
            end
        end
    end,
    
    ["GetValuePath"] = function(self)
        return self.ValuePath
    end,
    
    ["SetValuePath"] = function(self, ...)
        self.ValuePath = {...}
    end,
    
    ["Sort"] = function(self, comp)
        RecursiveSort(self.menuList, comp or function(a,b) return a.text < b.text end)
    end,
}

--[[----------------------------------------------------------------------------
Constructor
------------------------------------------------------------------------------]]
local function Constructor()

    local frame = CreateFrame("Frame", nil, UIParent)
    --frame:SetFrameStrata("FULLSCREEN_DIALOG")
    --frame:Show()
    
    local label = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
    label:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, -3)
    label:SetJustifyH("LEFT")

    local dropdownName = Type..AceGUI:GetNextWidgetNum(Type)
    local dropdown = CreateFrame("Frame", dropdownName, frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", -18, -3)
    dropdown:SetHeight(24)
    
    local button = _G[dropdownName.."Button"]
    button:SetScript("OnClick", Button_OnClick)

    local text = _G[dropdownName.."Text"]
    
    local widget = {
        frame        = frame,
        label        = label,
        dropdown     = dropdown,
        button       = button,
        text         = text,
        type         = Type,
    }
    for method, func in pairs(methods) do
        widget[method] = func
    end
    widget:SetMenuList({})
    
    button.obj = widget;
    
    return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
