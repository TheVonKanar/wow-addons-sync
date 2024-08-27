--[[-----------------------------------------------------------------------------
CollapsibleGroup Container
InlineGroup that can be expanded or collapsed.
-------------------------------------------------------------------------------]]
local Type, Version = "CollapsibleGroup", 3
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Button_OnClick(button)
	local self = button.obj
    self:SetCollapsed(not self.isCollapsed)
end

local function GetTitleHeight(self)
    if self.titleWidget then
        return max(16, self.titleWidget.frame:GetHeight()+4)
    else 
        return max(16, self.titletext:GetHeight())
    end
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self.base:OnAcquire()
        self.isCollapsed = false;
        self.button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
        self.button:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
        self.content:Show();
	end,

	["OnRelease"] = function(self)
    
        -- Remove the old title widget, if any
        if self.titleWidget then
            self.titleWidget:Release()
            self.titleWidget = nil
        end
    end,

	["LayoutFinished"] = function(self, width, height)
		if not self.noAutoHeight then
            if self.titleWidget then
                self.titleWidget:SetWidth(self.frame:GetWidth()-16)
            end
            self.content:GetParent():SetPoint("TOPLEFT", 0, -GetTitleHeight(self))
            if self.isCollapsed then
                self:SetHeight(GetTitleHeight(self))
            else
                self:SetHeight((height or 0) + GetTitleHeight(self) + 24)
            end
        end
	end,

    ["SetTitle"] = function(self, title)

        -- Remove the old title widget, if any
        if self.titleWidget then
            self.titleWidget:Release()
            self.titleWidget = nil
        end
        
        local text
        if type(title) == "string" then
            text = title
            self.base:SetTitle(text)
            self.button:SetHitRectInsets(0, -self.titletext:GetWidth(), 0, 0);
        else
            text = ""
            self.base:SetTitle(text)
            
            self.titleWidget = title
            self.titleWidget.frame:SetParent(self.frame)
            self.titleWidget.frame:SetPoint("TOPLEFT", 17, -2)
            self.titleWidget.frame:SetPoint("RIGHT")
            self.titleWidget.frame:Show()
            self.button:SetHitRectInsets(0, -self.titleWidget.frame:GetWidth(), 
                0, 0)--self.button:GetHeight()-self.titleWidget.frame:GetHeight()-2);
        end
        
        self.content:GetParent():SetPoint("TOPLEFT", 0, -GetTitleHeight(self))
    end,
    
    ["SetCollapsed"] = function(self, collapsed)
        if collapsed then
            self.button:SetNormalTexture("Interface/Buttons/UI-PlusButton-UP")
            self.button:SetPushedTexture("Interface/Buttons/UI-PlusButton-DOWN")
            self.content:GetParent():Hide();
        else
            self.button:SetNormalTexture("Interface/Buttons/UI-MinusButton-UP")
            self.button:SetPushedTexture("Interface/Buttons/UI-MinusButton-DOWN")
            self.content:GetParent():Show();
        end
        self.isCollapsed = collapsed
        self:Fire("OnToggleCollapse", collapsed)
    
        -- Layout starting at root panel
        local Root = self
        while Root.parent do
            Root = Root.parent
        end
        Root:DoLayout()
        AceGUI:ClearFocus()
    end,
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()

    local base = AceGUI:Create("InlineGroup");
    
	local widget = {
        base = base,
		type = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end
    setmetatable(widget, {__index = base})
    
    base.content.obj = widget
    base.frame.obj = widget
    
    local button = CreateFrame("Button", nil, widget.frame)
    button:SetPoint("TOPLEFT", 0, 0)
    button:SetWidth(16)
    button:SetHeight(16)
    button:SetHighlightTexture("Interface/Buttons/UI-PlusButton-Hilight")
    button:SetScript("OnClick", Button_OnClick)
    button.obj = widget
    
    widget.titletext:SetHeight(widget.titletext:GetStringHeight())
    widget.titletext:SetPoint("TOPLEFT", 17, -2)
    -- button.texture = button:CreateTexture()
    -- button.texture:SetAllPoints(button)
    -- button.texture:SetTexture(1,1,1)
    
    -- widget.titletext.texture = widget.titletext:CreateTexture()
    -- widget.titletext.texture:SetAllPoints(widget.titletext)
    -- widget.titletext:SetTexture(1,1,.8)
    
    
    --widget.titletext:ClearAllPoints()
    -- widget.titletext:SetPoint("BOTTOMLEFT", button, "BOTTOMRIGHT")
    -- widget.titletext:SetHeight(16)
    
    widget.button = button
    
    return widget
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
