local KONG_CONFIG_COLUMN_WIDTH = 166
local COLOR_UNREGISTERED = {.3, .3, 1, .7}
local COLOR_REGISTERED = {.3, 1, .3, .7}
local COLOR_SELECTED = {1, .3, .6, .7}
local COLOR_BORDER_SELECTED = {1, 1, 0, 1}
local COLOR_BORDER_DESELECTED = {1, 1, 1, 1}
local MIN_SIZE = 30
local COVER_BUTTON_BACKDROP = {
    bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
    edgeFile = "Interface/Buttons/WHITE8X8", 
    edgeSize=1
}
local SLIDER_VALUE_NA = "-"
local TRIGGERS = "triggers" -- the array of triggers
local FIELD = "field" -- the trigger field
local TITLE = "title" -- the widget label
local TOOLTIP = "tooltip" -- the widget tooltip
local OWNER = "owner" -- anchor of the tooltip
local VALID = "valid" -- is the macro well formed
local FRAME = "frame" -- last frame to run a memory scan for
local UPDATE = "update" -- the widget update method
local ANCHOR = "anchor" -- the tooltip anchor location
local FADE_OUT_TIME = "Fade Out Time (sec)"
local FADE_IN_TIME = "Fade In Time (sec)"
local FADE_OUT_DELAY = "Fade Out Delay (sec)"
local SHOWN_ALPHA = "Shown Alpha"
local BRING_TO_FRONT = "Bring to Front |cFF00AAFF[Wheel Down]|r"
local SEND_TO_BACK = "Send to Back |cFF00AAFF[Wheel Up]|r"
local CONFIGURE_CHILDREN = "Configure Children"
local CONFIGURE_PARENT = "Configure Parent"
local CANCEL = "|TInterface/Buttons/UI-GroupLoot-Pass-Up:0:0:0:1|t Cancel"


local AceGUI = LibStub("AceGUI-3.0")
local LibUSC = LibStub("LibUserSpecifiedConditions")

local Dropdown = LibStub("AceGUI-3.0"):Create("EasyMenuDropDown")

KongConfig_SelectedFrames = {}
KongConfig_Frames = {}
KongConfig_NumFrames = 0

local Kong_UnloadOriginal = Kong_Unload
function Kong_Unload()

    if KongConfig then
        for i=#KongConfig_ConditionsGroup.children,1,-1 do
            local Panel = KongConfig_ConditionsGroup.children[i]
            local PanelTriggers = Panel:GetUserData("Triggers")
            
            -- For each trigger that was being configured in the panel
            for j=#PanelTriggers,1,-1 do
                local found = false
                local PanelTrigger = PanelTriggers[j]
                
                Panel:GetUserData("ConditionEditor"):RemoveCondition(PanelTrigger.Condition)
                tremove(PanelTriggers, j)
            end
            
            AceGUI:Release(tremove(KongConfig_ConditionsGroup.children, i))
        end
    end
    
    Kong_UnloadOriginal()
end

local function Simplify(str)

    str = gsub(str, "%[\"", ".")
    str = gsub(str, "\"%]", "")
    str = gsub(str, ":GetParent%(%)", "Parent")
    return string.sub(str, 2)
end                    

function KongConfig_Error(str, ...)
    KongConfig:SetStatusText("|cFFFF2222Error:|r "..string.format(str, ...))
end

function KongConfig_Warning(str, ...)
    KongConfig:SetStatusText("|cFFFF9922Warning:|r "..string.format(str, ...))
end

local Kong_ErrorOriginal
local Kong_WarningOriginal
function KongConfig_Show()

    if (not KongConfig) or (not KongConfig:IsVisible()) then
    
        -- Display registered frames
        for Frame in pairs(Kong_Frames) do
            Kong_Fade(Frame, 1, 1, 0)
        end
    
        -- Redirect errors and warnings to the status bar
        Kong_ErrorOriginal = Kong_Error
        Kong_Error = KongConfig_Error
        Kong_WarningOriginal = Kong_Warning
        Kong_Warning = KongConfig_Warning
    end
    
    KongConfig_CreateComponents()
    KongConfig_AutoExpandAndCollapse()
    KongConfig:Show()
    
    -- Create the cover buttons
    KongConfig_CreateChildCoverButtons(UIParent)
    for Frame in pairs(Kong_Frames) do
        local Parent = Frame:GetParent()
        if Parent ~= UIParent then
            KongConfig_CreateChildCoverButtons(Parent)
            
            -- Hide unregistered parents of registered Kong frames
            while Parent and Parent ~= UIParent do
                if KongConfig_Frames[Parent] and not Kong_Frames[Parent] then
                    KongConfig_Frames[Parent]:Hide()
                end
                Parent = Parent:GetParent()
            end
        end
    end
    
    -- Deselect any frames that are no longer onscreen for configuration
    for _, PreviouslySelectedFrame in pairs(KongConfig_SelectedFrames) do
        if not PreviouslySelectedFrame:IsShown() then
            KongConfig_SelectedFrames[PreviouslySelectedFrame] = nil
        end
    end
    
    -- Make sure the config frame is on top
    KongConfig.frame:SetFrameStrata("DIALOG")
    KongConfig.frame:SetFrameLevel(KongConfig_NumFrames)
    
    -- Update the config widgets' states
    KongConfig_UpdateComponents()
    
end

function KongConfig_CreateChildCoverButtons(Frame)
    for i,Child in pairs({Frame:GetChildren()}) do
		if not Child:IsForbidden() and not Child:IsAnchoringRestricted() and not Child:IsObjectType("GameTooltip") then
			if Child:IsShown() and Child ~= KongConfig.frame then
				KongConfig_CreateCoverButton(Child)
			end
		end
    end
end

function KongConfig_CreateCoverButton(Frame)

    local configName = "KongConfig_"..(Frame:GetName() or tostring(Frame))
    if not KongConfig_Frames[Frame] then
        local CoverButton
		
		CoverButton = CreateFrame("Button", configName, nil, "BackdropTemplate")
        CoverButton:SetFrameStrata("DIALOG")
        CoverButton:SetFrameLevel(KongConfig_NumFrames)
        CoverButton:SetBackdrop(COVER_BUTTON_BACKDROP)
        CoverButton:SetHighlightTexture("Interface\\FullScreenTextures\\OutOfControl", "ADD");
        CoverButton.uiFrame = Frame
        
        -- Mouse wheel used to change frame level
        CoverButton:EnableMouseWheel(true)
        CoverButton:SetScript("OnMouseWheel", KongConfig_CoverButton_OnMouseWheel)
        
        CoverButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        CoverButton:SetScript("OnClick", KongConfig_CoverButton_OnClick)
        
        local text1 = CoverButton:CreateFontString(configName.."Title", "ARTWORK", "GameFontNormal")
        text1:SetPoint("CENTER")
        text1:SetTextColor(1, 1, 1, 1)
        if Kong_Frames[Frame] then
            text1:SetText(Simplify(Kong_Frames[Frame].index))
        else
            text1:SetText(Simplify(Kong_FindGlobalIndex(Frame) or " <noname>"))
        end
        
        KongConfig_Frames[Frame] = CoverButton
        KongConfig_NumFrames = KongConfig_NumFrames + 1
		
    else
        KongConfig_Frames[Frame]:Show()
    end
    
    -- Distinguish between registered and unregistered frames
    if KongConfig_SelectedFrames[KongConfig_Frames[Frame]] then
        KongConfig_Frames[Frame]:SetBackdropColor(unpack(COLOR_SELECTED))
    elseif Kong_Frames[Frame] then 
        KongConfig_Frames[Frame]:SetBackdropColor(unpack(COLOR_REGISTERED))
    else
        KongConfig_Frames[Frame]:SetBackdropColor(unpack(COLOR_UNREGISTERED))
    end
    
    -- Expand config frame if too small
    local xoff, yoff = 0, 0
    if Frame:GetWidth() < MIN_SIZE then
        xoff = (MIN_SIZE-Frame:GetWidth())/2
    end
    if Frame:GetHeight() < MIN_SIZE then
        yoff = (MIN_SIZE-Frame:GetHeight())/2
    end
    KongConfig_Frames[Frame]:SetPoint("TOPLEFT", Frame, "TOPLEFT", -xoff, yoff)
    KongConfig_Frames[Frame]:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", xoff, -yoff)
end

function KongConfig_OnClose()
       
    CloseDropDownMenus() 
    
    for child, frame in pairs(KongConfig_Frames) do
        frame:Hide()
    end
    
    -- Restore the original error display
    Kong_Error = Kong_ErrorOriginal
    Kong_Warning = Kong_WarningOriginal
    
    -- Re-hide registered frames
    for Frame in pairs(Kong_Frames) do
        Kong_CalculateFadeOut(Frame);
    end
    
    if not Kong_Settings.enabled then
        Kong_Warning("Kong is currently disabled. Use |cFF33FF99/kong toggle|r to enable it.")
    end
end

function KongConfig_ToggleChecked(self)
    local value = self:GetValue()
    if self.tristate then
        --cycle in [greyed,] checked, unchecked order
        if value then
            self:SetValue(false)
        elseif value == nil then
            self:SetValue(true)
        else
            self:SetValue(nil)
        end
    else
        self:SetValue(not self:GetValue())
    end
end

local function NegateBoolean(value)

    if string.sub(value, 1, 2) == "no" then
        return string.sub(value, 3)
    else
        return "no"..value
    end
end

-- GUI Setup ---------------------------------------------------------------------------------------
function KongConfig_CreateComponents()

    if not KongConfig then
    
        -- Create a container frame
        KongConfig = AceGUI:Create("Frame")
        KongConfig:SetTitle("Kong Configuration")
        KongConfig:SetStatusText("Status Bar")
        KongConfig:SetLayout("Flow")
        KongConfig:SetWidth(264)
        KongConfig:SetHeight(472)
        KongConfig:SetStatusText("")
        KongConfig.frame:SetScript("OnUpdate", KongConfig_OnUpdate);
		if ( KongConfig.frame.SetResizeBounds ~= nil ) then
			 KongConfig.frame:SetResizeBounds(264, 264)
		else
			 KongConfig.frame:SetMinResize(264, 264) -- Classic
		end
        tinsert(UISpecialFrames, "KongConfig")
--KongConfig:SetPoint("TOPLEFT", 0, -7)
        
        -- Make it opaque
        local kongback = KongConfig.frame:GetBackdrop()
        kongback.bgFile = "Interface\\ChatFrame\\ChatFrameBackground"
        KongConfig.frame:SetBackdrop(kongback)
        KongConfig.frame:SetBackdropColor(0, 0, 0, 1)

        -- Register for cleanup
        KongConfig:SetCallback("OnClose", KongConfig_OnClose)

        -- Fade CheckBox
        KongConfig_FadeCheckBox = AceGUI:Create("CheckBox")
        KongConfig_FadeCheckBox:SetWidth(205)
        --KongConfig_FadeCheckBox:SetHeight(12)
        --KongConfig_FadeCheckBox.text:SetJustifyH("RIGHT")
        KongConfig_FadeCheckBox:SetLabel("Hide Selected Frame(s)")
        KongConfig_FadeCheckBox:SetCallback("OnValueChanged", KongConfig_FadeCheckBox_OnValueChanged)
        KongConfig_FadeCheckBox:SetCallback("OnEnter", KongConfig_UpdateTooltip)
        KongConfig_FadeCheckBox:SetCallback("OnLeave", KongConfig_UpdateTooltip)
        KongConfig_FadeCheckBox:SetUserData(TOOLTIP, "Registers the selected frame(s) to be controlled by Kong")
        --KongConfig_FadeCheckBox.frame:SetHitRectInsets(0,0,0,-15)
        KongConfig_FadeCheckBox.ToggleChecked = KongConfig_ToggleChecked
        
        -- General Settings Scroll pane
        KongConfig_ScrollFrame = AceGUI:Create("ScrollFrame")
        KongConfig_ScrollFrame:SetFullWidth(true)
        KongConfig_ScrollFrame:SetFullHeight(true)
        KongConfig_ScrollFrame:SetLayout("List")
        
        KongConfig_CreateDefaultComponents()
        KongConfig_ScrollFrame:AddChild(KongConfig_DefaultsGroup)
        
        KongConfig_ConditionsCategoryGroup = AceGUI:Create("CollapsibleGroup")
        KongConfig_ConditionsCategoryGroup:SetLayout("List")
        KongConfig_ConditionsCategoryGroup:SetTitle("Show When")
        KongConfig_ConditionsCategoryGroup:SetFullWidth(true)
        KongConfig_ScrollFrame:AddChild(KongConfig_ConditionsCategoryGroup)
        
        KongConfig_ConditionsGroup = AceGUI:Create("SimpleGroup")
        KongConfig_ConditionsGroup:SetLayout("List")
        KongConfig_ConditionsGroup:SetFullWidth(true)
        KongConfig_ConditionsCategoryGroup:AddChild(KongConfig_ConditionsGroup)
        
        KongConfig_AddConditionButton = AceGUI:Create("Button")
        KongConfig_AddConditionButton:SetText("|TInterface\\LFGFrame\\LFGRole:16:16:0:0:64:16:48:64:0:16|t Add New Condition")
        KongConfig_AddConditionButton:SetWidth(188)
        KongConfig_AddConditionButton:SetHeight(20)
        KongConfig_AddConditionButton:SetUserData(TITLE, "Add New Condition")
        KongConfig_AddConditionButton:SetUserData(TOOLTIP, 
            "Creates a new condition that, when met, will cause the selected frame(s) to fade in.")
        KongConfig_AddConditionButton:SetUserData(ANCHOR, "ANCHOR_BOTTOM")
        KongConfig_AddConditionButton:SetCallback("OnClick",KongConfig_AddConditionButton_OnClick)
        KongConfig_AddConditionButton:SetCallback("OnEnter", KongConfig_UpdateTooltip)
        KongConfig_AddConditionButton:SetCallback("OnLeave", KongConfig_UpdateTooltip)
        KongConfig_ConditionsCategoryGroup:AddChild(KongConfig_AddConditionButton)
        
        KongConfig_CreateMouseoverGroupComponents()
        KongConfig_ScrollFrame:AddChild(KongConfig_MouseoverGroupsGroup)
        
        KongConfig_CreateAdvancedComponents()
        KongConfig_ScrollFrame:AddChild(KongConfig_AdvancedGroup)
        
        -- Main panel
        KongConfig:AddChild(KongConfig_FadeCheckBox)
        KongConfig:AddChild(KongConfig_ScrollFrame)
    end
    
    -- Set the initial state of these frames
    KongConfig_UpdateComponents() 
end

function KongConfig_CreateDefaultComponents()

    KongConfig_DefaultsGroup = AceGUI:Create("CollapsibleGroup")
    KongConfig_DefaultsGroup:SetFullWidth(true)
    KongConfig_DefaultsGroup:SetLayout("Flow")
    KongConfig_DefaultsGroup:SetTitle("Defaults")
    KongConfig_DefaultsGroup:SetCollapsed(true)
    
    local Triggers = {}
    KongConfig_DefaultsGroup:SetUserData(TRIGGERS, Triggers)
    
    -- Hidden Alpha
    KongConfig_HiddenAlphaCheckBox, KongConfig_HiddenAlphaSlider, KongConfig_HiddenAlphaGroup = 
        KongConfig_CreateTriggerSliderGroup("Hidden Alpha", Triggers, "alphaOut", 
        "The transparency of the selected frame(s) when hidden by Kong")
    KongConfig_HiddenAlphaSlider:SetIsPercent(true)
    KongConfig_HiddenAlphaSlider:SetSliderValues(0, 1, .01)
    
    
    -- Shown Alpha
    KongConfig_ShownAlphaCheckBox, KongConfig_ShownAlphaSlider, KongConfig_ShownAlphaGroup = 
        KongConfig_CreateTriggerSliderGroup(SHOWN_ALPHA, Triggers, "alphaIn",
        "The default transparency of the selected frame(s) when shown by Kong. This can be overridden on a per-condition basis below.")
    KongConfig_ShownAlphaSlider:SetIsPercent(true)
    KongConfig_ShownAlphaSlider:SetSliderValues(0, 1, .01)
    
    -- Fade In
    KongConfig_FadeInCheckBox, KongConfig_FadeInSlider, KongConfig_FadeInGroup = 
        KongConfig_CreateTriggerSliderGroup(FADE_IN_TIME, Triggers, "secondsIn", 
        "The default duration over which to fade in the selected widget(s). This can be overridden on a per-condition basis below.")
    KongConfig_FadeInSlider:SetSliderValues(0, 10, .1)

    -- Fade Out
    KongConfig_FadeOutCheckBox, KongConfig_FadeOutSlider, KongConfig_FadeOutGroup = 
        KongConfig_CreateTriggerSliderGroup(FADE_OUT_TIME, Triggers, "secondsOut",
        "The default duration over which to fade out the selected widget(s). This can be overridden on a per-condition basis below.")
    KongConfig_FadeOutSlider:SetSliderValues(0, 10, .1)

    -- Fade Out Delay 
     KongConfig_FadeOutDelayCheckBox, KongConfig_FadeOutDelaySlider, KongConfig_FadeOutDelayGroup = 
        KongConfig_CreateTriggerSliderGroup(FADE_OUT_DELAY, Triggers, "secondsTillOut",
        "The default duration before which to fade out the selected widget(s). This can be overridden on a per-condition basis below.")
    KongConfig_FadeOutDelaySlider:SetSliderValues(0, 60, 1)
	
    KongConfig_DefaultsGroup:AddChild(KongConfig_HiddenAlphaGroup)
    KongConfig_DefaultsGroup:AddChild(KongConfig_ShownAlphaGroup)
    KongConfig_DefaultsGroup:AddChild(KongConfig_FadeInGroup)
    KongConfig_DefaultsGroup:AddChild(KongConfig_FadeOutGroup)
    KongConfig_DefaultsGroup:AddChild(KongConfig_FadeOutDelayGroup)
end

function KongConfig_CreateMouseoverGroupComponents()

    KongConfig_MouseoverGroupsGroup = AceGUI:Create("CollapsibleGroup")
    KongConfig_MouseoverGroupsGroup:SetLayout("Flow")
    KongConfig_MouseoverGroupsGroup:SetFullWidth(true)
    KongConfig_MouseoverGroupsGroup:SetTitle("Mouseover Grouping")
    KongConfig_MouseoverGroupsGroup:SetCollapsed(true)
    
    KongConfig_GroupsComboBox = AceGUI:Create("Dropdown")
    KongConfig_GroupsComboBox:SetWidth(KONG_CONFIG_COLUMN_WIDTH)
    KongConfig_GroupsComboBox:SetLabel("Mouseover Groups")
    KongConfig_GroupsComboBox:SetMultiselect(true)
    KongConfig_GroupsComboBox:SetCallback("OnValueChanged", KongConfig_GroupsComboBox_OnValueChanged)
    KongConfig_GroupsComboBox:SetUserData(TITLE, "Mouseover Groups Selection")
    KongConfig_GroupsComboBox:SetUserData(TOOLTIP, "Lists the available mouseover groups. When the cursor enters any member of a mouseover group, all members of that group are shown. Groups that the selected frame(s) are part of are checked.")
    KongConfig_GroupsComboBox:SetCallback("OnEnter", KongConfig_UpdateTooltip)
    KongConfig_GroupsComboBox:SetCallback("OnLeave", KongConfig_UpdateTooltip)
    KongConfig_GroupsComboBox.pullout.frame:Hide()
    
    KongConfig_NewGroupEditBox = AceGUI:Create("EditBox")
    KongConfig_NewGroupEditBox:SetWidth(KONG_CONFIG_COLUMN_WIDTH)
    KongConfig_NewGroupEditBox:SetLabel("New Group:")
    KongConfig_NewGroupEditBox:SetCallback("OnEnterPressed", KongConfig_NewGroupEditBox_OnEnterPressed)
    KongConfig_NewGroupEditBox:SetUserData(TITLE, "New Group Field")
    KongConfig_NewGroupEditBox:SetUserData(TOOLTIP, "Adds the selected frame(s) to a new group with a given name.")
    KongConfig_NewGroupEditBox:SetCallback("OnEnter", KongConfig_UpdateTooltip)
    KongConfig_NewGroupEditBox:SetCallback("OnLeave", KongConfig_UpdateTooltip)
    
    KongConfig_MouseoverGroupsGroup:AddChild(KongConfig_GroupsComboBox)
    KongConfig_MouseoverGroupsGroup:AddChild(KongConfig_NewGroupEditBox)
end

function KongConfig_CreateAdvancedComponents()

    KongConfig_AdvancedGroup = AceGUI:Create("CollapsibleGroup")
    KongConfig_AdvancedGroup:SetLayout("Flow")
    KongConfig_AdvancedGroup:SetFullWidth(true)
    KongConfig_AdvancedGroup:SetTitle("Advanced")
    KongConfig_AdvancedGroup:SetCollapsed(true)
    
    KongConfig_OverrideAlphaCheckBox = AceGUI:Create("CheckBox")
    KongConfig_OverrideAlphaCheckBox:SetWidth(KONG_CONFIG_COLUMN_WIDTH)
    KongConfig_OverrideAlphaCheckBox:SetLabel("Dummy SetAlpha Function")
    KongConfig_OverrideAlphaCheckBox:SetCallback("OnValueChanged", KongConfig_OverrideAlphaCheckBox_OnValueChanged)
    KongConfig_OverrideAlphaCheckBox:SetUserData(TOOLTIP, "Add a dummy SetAlpha function to the selected frame(s) to prevent outside alpha changes.")
    KongConfig_OverrideAlphaCheckBox:SetCallback("OnEnter", KongConfig_UpdateTooltip)
    KongConfig_OverrideAlphaCheckBox:SetCallback("OnLeave", KongConfig_UpdateTooltip)
    KongConfig_OverrideAlphaCheckBox.ToggleChecked = KongConfig_ToggleChecked
    
    KongConfig_HideAtZeroAlphaCheckBox = AceGUI:Create("CheckBox")
    KongConfig_HideAtZeroAlphaCheckBox:SetWidth(KONG_CONFIG_COLUMN_WIDTH)
    KongConfig_HideAtZeroAlphaCheckBox:SetLabel("Hide At Zero Alpha")
    KongConfig_HideAtZeroAlphaCheckBox:SetCallback("OnValueChanged", KongConfig_HideAtZeroAlpha_OnValueChanged)
    KongConfig_HideAtZeroAlphaCheckBox:SetUserData(TOOLTIP, "Hides the frame(s) at zero alpha.")
    KongConfig_HideAtZeroAlphaCheckBox:SetCallback("OnEnter", KongConfig_UpdateTooltip)
    KongConfig_HideAtZeroAlphaCheckBox:SetCallback("OnLeave", KongConfig_UpdateTooltip)
    KongConfig_HideAtZeroAlphaCheckBox.ToggleChecked = KongConfig_ToggleChecked
    
    KongConfig_PersistAsDropDown = AceGUI:Create("Dropdown")
    KongConfig_PersistAsDropDown:SetFullWidth(true)
    KongConfig_PersistAsDropDown:SetLabel("Save As")
    KongConfig_PersistAsDropDown:SetCallback("OnValueChanged", KongConfig_PersistAsComboBox_OnValueChanged)
    KongConfig_PersistAsDropDown:SetUserData(TITLE, "Save As Selection")
    KongConfig_PersistAsDropDown:SetUserData(TOOLTIP, "The \"name\" with which Kong saves settings associated with the selected widget. Kong will use this name to find the widget again at the next login or /reload, so try to pick something that will be there every session.")
    KongConfig_PersistAsDropDown:SetCallback("OnEnter", KongConfig_UpdateTooltip)
    KongConfig_PersistAsDropDown:SetCallback("OnLeave", KongConfig_UpdateTooltip)
    KongConfig_PersistAsDropDown:SetList({""})
    KongConfig_PersistAsDropDown.button:HookScript("OnClick", KongConfig_PersistAsDropDown_OnClick);
    KongConfig_PersistAsDropDown.pullout.frame:Hide()
    
    KongConfig_AdvancedGroup:AddChild(KongConfig_OverrideAlphaCheckBox)
    KongConfig_AdvancedGroup:AddChild(KongConfig_HideAtZeroAlphaCheckBox)
    KongConfig_AdvancedGroup:AddChild(KongConfig_PersistAsDropDown)
end

function KongConfig_CreateTriggerPanel(Trigger, isMouseover)

    local ConditionEditor = AceGUI:Create("ConditionEditor")
    ConditionEditor:SetFullWidth(true)
    ConditionEditor:SetEnabled(not isMouseover)
    ConditionEditor:AddCondition(Trigger.Condition)
    
    local Triggers = {Trigger}
    
    local Group = AceGUI:Create("CollapsibleGroup")
    Group:SetFullWidth(true)
    Group:SetLayout("Flow")
    if isMouseover then
        Group:SetTitle("[Frame has Mouse Focus]")
    else
        Group:SetTitle(ConditionEditor)
    end
    Group:SetCollapsed(true)
    Group:SetUserData("Triggers", Triggers)
    Group:SetUserData("ConditionEditor", ConditionEditor)
    
    if isMouseover then
    
        local MouseoverText = AceGUI:Create("Label")
        MouseoverText:SetText("Mouseover fading is always\nenabled for registered frames.")
        MouseoverText:SetWidth(KONG_CONFIG_COLUMN_WIDTH)
        Group:SetUserData("MouseoverText", MouseoverText)
        
        Group:AddChild(MouseoverText)
    else
    
        local SyncButton = AceGUI:Create("Button")
        SyncButton:SetText("|TInterface/Buttons/UI-CheckBox-Check:0|t Sync")
        SyncButton:SetWidth(KONG_CONFIG_COLUMN_WIDTH/2)
        SyncButton:SetHeight(20)
        SyncButton:SetUserData(TITLE, "Synchronize Condition")
        SyncButton:SetUserData(TOOLTIP, 
            "Applies this condition to any selected frames that do not already have it")
        SyncButton:SetCallback("OnClick", KongConfig_SyncButton_OnClick)
        SyncButton:SetCallback("OnEnter", KongConfig_UpdateTooltip)
        SyncButton:SetCallback("OnLeave", KongConfig_UpdateTooltip)
        SyncButton.frame:SetMotionScriptsWhileDisabled(true)
        Group:SetUserData("SyncButton", SyncButton)
        
        local DeleteButton = AceGUI:Create("Button")
        DeleteButton:SetText("|TInterface/Buttons/UI-GroupLoot-Pass-Up:0|tDelete")
        DeleteButton:SetWidth(KONG_CONFIG_COLUMN_WIDTH/2)
        DeleteButton:SetHeight(20)
        DeleteButton:SetUserData(TITLE, "Delete Condition")
        DeleteButton:SetUserData(TOOLTIP, "Removes this condition from the selected frame(s)")
        DeleteButton:SetCallback("OnClick", KongConfig_DeleteButton_OnClick)
        DeleteButton:SetCallback("OnEnter", KongConfig_UpdateTooltip)
        DeleteButton:SetCallback("OnLeave", KongConfig_UpdateTooltip)
        Group:SetUserData("DeleteButton", DeleteButton)
    
        Group:AddChild(SyncButton)
        Group:AddChild(DeleteButton)
    end
    
    -- Alpha
    local AlphaCheckBox, AlphaSlider, AlphaGroup =
        KongConfig_CreateTriggerSliderGroup(SHOWN_ALPHA, Triggers, "alphaIn",
        "The transparency of the selected frame(s) while the given condition is met")
    AlphaSlider:SetIsPercent(true)
    AlphaSlider:SetSliderValues(0, 1, .01)
    Group:SetUserData("AlphaCheckBox", AlphaCheckBox)
    Group:SetUserData("AlphaSlider", AlphaSlider)
      
    -- Fade In
    local FadeInCheckBox, FadeInSlider, FadeInGroup =
        KongConfig_CreateTriggerSliderGroup(FADE_IN_TIME, Triggers, "secondsIn",
        "The duration over which to fade in the selected frame(s) when the given condition is met")
    FadeInSlider:SetSliderValues(0, 10, .1)
    Group:SetUserData("FadeInCheckBox", FadeInCheckBox)
    Group:SetUserData("FadeInSlider", FadeInSlider)

    -- Fade Out
    local FadeOutCheckBox, FadeOutSlider, FadeOutGroup =
        KongConfig_CreateTriggerSliderGroup(FADE_OUT_TIME, Triggers, "secondsOut",
        "The duration over which to fade out the selected frame(s) when the given condition is no longer met")
    FadeOutSlider:SetSliderValues(0, 10, .1)
    Group:SetUserData("FadeOutCheckBox", FadeOutCheckBox)
    Group:SetUserData("FadeOutSlider", FadeOutSlider)
    
	-- Fade Out Delay
    local FadeOutDelayCheckBox, FadeOutDelaySlider, FadeOutDelayGroup =
        KongConfig_CreateTriggerSliderGroup(FADE_OUT_DELAY, Triggers, "secondsTillOut",
        "The duration until which the selected frame(s) starts to fade out when the given condition is no longer met")
    FadeOutDelaySlider:SetSliderValues(0, 60, 1)
    Group:SetUserData("FadeOutDelayCheckBox", FadeOutDelayCheckBox)
    Group:SetUserData("FadeOutDelaySlider", FadeOutDelaySlider)
	
    Group:AddChild(AlphaGroup)
    Group:AddChild(FadeInGroup)
    Group:AddChild(FadeOutGroup)
    Group:AddChild(FadeOutDelayGroup)
	
    return Group
end

function KongConfig_CreateTriggerSliderGroup(text, triggers, field, tooltip)

    local checkbox = AceGUI:Create("CheckBox")
    checkbox:SetLabel(text)
    checkbox:SetHeight(0)
    checkbox:SetUserData(TRIGGERS, triggers)
    checkbox:SetUserData(FIELD, field)
    checkbox:SetUserData(TITLE, text)
    checkbox:SetUserData(TOOLTIP, tooltip)
    checkbox:SetCallback("OnValueChanged", KongConfig_SliderCheckBox_OnValueChanged)
    checkbox:SetCallback("OnEnter", KongConfig_UpdateTooltip)
    checkbox:SetCallback("OnLeave", KongConfig_UpdateTooltip)
    checkbox.ToggleChecked = KongConfig_ToggleChecked
   
    local slider = AceGUI:Create("Slider")
    slider:SetLabel("")
    slider:SetUserData(TRIGGERS, triggers)
    slider:SetUserData(FIELD, field)
    slider:SetUserData(TITLE, text)
    slider:SetUserData(TOOLTIP, tooltip)
    slider:SetCallback("OnMouseUp", KongConfig_TriggerSlider_OnMouseUp)
    slider:SetCallback("OnEnter", KongConfig_UpdateTooltip)
    slider:SetCallback("OnLeave", KongConfig_UpdateTooltip)
    slider.slider:SetHitRectInsets(0,0,0,0)

    local group = AceGUI:Create("SimpleGroup")
    group:SetWidth(KONG_CONFIG_COLUMN_WIDTH)
    group:SetLayout("Flow")
    group:AddChild(checkbox)
    group:AddChild(slider)
    
    checkbox:SetUserData(OWNER, group.frame)
    slider:SetUserData(OWNER, group.frame)
    
    return checkbox, slider, group
end

function KongConfig_CoverButton_OnMouseWheel(self, dir)

    if (dir == 1) then
        KongConfig_SendToBack(self)
    else
        local lowestFrame
        for child, frame in pairs(KongConfig_Frames) do
            if MouseIsOver(frame) and frame:IsShown() then
                if (not lowestFrame) or frame:GetFrameLevel() < lowestFrame:GetFrameLevel() then
                    lowestFrame = frame
                end
            end
        end
        if lowestFrame then
            KongConfig_BringToFront(lowestFrame)
        end
    end
    
    -- Make wow re-assign mouse focus
    self:Hide()
    self:Show()
end

function KongConfig_BringToFront(focus)
    local level = focus:GetFrameLevel()
    for child, frame in pairs(KongConfig_Frames) do
        if frame:GetFrameLevel() > level then
            frame:SetFrameLevel(frame:GetFrameLevel() - 1)
        end
    end
    focus:SetFrameLevel(KongConfig_NumFrames-1)
end

function KongConfig_SendToBack(self) 
    local level = self:GetFrameLevel()
    for child, frame in pairs(KongConfig_Frames) do
        if frame:GetFrameLevel() < level then
            frame:SetFrameLevel(frame:GetFrameLevel() + 1)
        end
    end
    self:SetFrameLevel(0)
end

function KongConfig_CoverButton_OnClick(self, button)

    if button == "RightButton" then
        for frame in pairs(KongConfig_SelectedFrames) do
            KongConfig_SelectedFrames[frame] = nil
            KongConfig_CoverButton_Update(frame)
        end
        
        CloseDropDownMenus()
        
        Dropdown:SetMenuList({})
        Dropdown:AddItem(BRING_TO_FRONT)
        Dropdown:AddItem(SEND_TO_BACK)
        
        if self.uiFrame:GetParent() ~= UIParent then
            Dropdown:AddItem(CONFIGURE_PARENT)
        end
        if self.uiFrame:GetNumChildren() > 0 then
            Dropdown:AddItem(CONFIGURE_CHILDREN)
        end
        Dropdown:AddItem(CANCEL)

        Dropdown.obj = self
        ToggleDropDownMenu(nil, nil, Dropdown.dropdown, "cursor", 0, 0, 
            Dropdown.menuList)
    else
        KongConfig_BringToFront(self)
    end
    
    -- Recolor Kong config frames
    if IsControlKeyDown() or IsShiftKeyDown() then
        if KongConfig_SelectedFrames[self] then
            KongConfig_SelectedFrames[self] = nil
        else
            KongConfig_SelectedFrames[self] = self
        end
        KongConfig_CoverButton_Update(self)
    else
        for frame in pairs(KongConfig_SelectedFrames) do
            KongConfig_SelectedFrames[frame] = nil
            KongConfig_CoverButton_Update(frame)
        end
        KongConfig_SelectedFrames[self] = self
        KongConfig_CoverButton_Update(self)
    end

    KongConfig_UpdateComponents() 
    KongConfig_AutoExpandAndCollapse()
    
    if nil == next(KongConfig_SelectedFrames) then
        KongConfig:SetStatusText("Select a widget to configure.")
    else
        for child, frame in pairs(KongConfig_Frames) do
            if MouseIsOver(frame) and frame ~= self then
                KongConfig:SetStatusText("Use mouse wheel to uncover frames.")
                return
            end
        end
        if nil == next(KongConfig_SelectedFrames, next(KongConfig_SelectedFrames)) then
            KongConfig:SetStatusText("Shift-click to select multiple frames.")
        else
            KongConfig:SetStatusText("")
        end
    end
end

-- GUI Update --------------------------------------------------------------------------------------
function KongConfig_AutoExpandAndCollapse()

    KongConfig_ConditionsCategoryGroup:SetCollapsed(KongConfig_FadeCheckBox:GetValue() == false)

    local hasAdvancedSettings = false
    for _, SelectedFrame in pairs(KongConfig_SelectedFrames) do
        if Kong_Frames[SelectedFrame.uiFrame] then
            if Kong_Frames[SelectedFrame.uiFrame].overrideAlpha 
            or Kong_Frames[SelectedFrame.uiFrame].hideAtZeroAlpha
            or type(Kong_Frames[SelectedFrame.uiFrame].index) == "table" then 
                hasAdvancedSettings = true
            end
        end
    end
    if hasAdvancedSettings then
        KongConfig_AdvancedGroup:SetCollapsed(false)
    end
end

local SelectedBackdrop = CopyTable(COVER_BUTTON_BACKDROP)
function KongConfig_CoverButton_Update(button)
    
    if KongConfig_SelectedFrames[button] then
        button:SetBackdrop(SelectedBackdrop)
        button:SetBackdropColor(unpack(COLOR_SELECTED))
        button:SetBackdropBorderColor(unpack(COLOR_BORDER_SELECTED))
        button:LockHighlight()
        _G[button:GetName().."Title"]:SetTextColor(1, 1, 0, 1)
    else
        button:SetBackdrop(COVER_BUTTON_BACKDROP)
        if Kong_Frames[button.uiFrame] then 
            button:SetBackdropColor(unpack(COLOR_REGISTERED))
        else
            button:SetBackdropColor(unpack(COLOR_UNREGISTERED))
        end
        button:SetBackdropBorderColor(unpack(COLOR_BORDER_DESELECTED))
        button:GetHighlightTexture():SetVertexColor(1, 1, 1, 1)
        button:UnlockHighlight()
        _G[button:GetName().."Title"]:SetTextColor(1, 1, 1, 1)
    end
end

local SELECTION_BLINK_PERIOD = 1;
local updateTimer = 0;
function KongConfig_OnUpdate(self, elapsed)
    
    updateTimer = updateTimer - elapsed;
    if updateTimer <= 0 then
        updateTimer = SELECTION_BLINK_PERIOD;
    end
    
    local numSelected = 0;
    SelectedBackdrop.edgeSize = 1 + math.abs(4*(updateTimer/SELECTION_BLINK_PERIOD)-2)
    for Frame in pairs(KongConfig_SelectedFrames) do
        KongConfig_CoverButton_Update(Frame)
        Frame:GetHighlightTexture():SetVertexColor(1, 1, 1, math.abs(2*(updateTimer/SELECTION_BLINK_PERIOD)-1))
        numSelected = numSelected + 1
    end
    
    local showTip
    local Focus
	if ( GetMouseFocus ~= nil ) then
		Focus = GetMouseFocus()
	else
		Focus = GetMouseFoci()[1]
	end
    local numUnderCursor = 0
    for child, Frame in pairs(KongConfig_Frames) do 
        showTip = (Frame == Focus)
        if MouseIsOver(Frame) then
            numUnderCursor = numUnderCursor + 1
        end
    end
    local unselectedUnderCursor = not KongConfig_SelectedFrames[Focus]

    if showTip then
        GameTooltip:SetOwner(KongConfig.frame, "ANCHOR_CURSOR")
        if (numUnderCursor > 0) and numSelected == 0 then
            GameTooltip:AddLine("Click to configure.")
        elseif (numUnderCursor > 0) and unselectedUnderCursor then
            GameTooltip:AddLine("Shift-click to select multiple widgets.")
        elseif numUnderCursor > 1 then
            GameTooltip:AddLine("Use the mouse wheel to uncover widgets.")
        end
    elseif GameTooltip:IsOwned(KongConfig.frame) then
        GameTooltip:Hide()
    end
    
    if KongConfig_PersistAsCoroutine
    and coroutine.status(KongConfig_PersistAsCoroutine) == "suspended" then
        local status, err = coroutine.resume(KongConfig_PersistAsCoroutine)
        if not status then
            error(err)
        end
    end
end

local MAX_DEPTH = 4
function KongConfig_RecursiveFrameSearch(Frame, tbl, depth, path, numParents)
       
    for name, value in pairs(tbl) do
        if (type(name) == "string") or (type(name) == "number") or (type(name) == "boolean") then
            if (type(value) == "table") and (value ~= tbl) then
                table.insert(path, name)
                if Frame == value then
                    if (string.sub(path[1], 1, 4) ~= "Kong") and (string.sub(path[1], 1, 6) ~= "AceGUI") then
                        local code = "";
                        for i = 1,#path do
                            if type(path[i]) == "string" then
                                code = code .. "[\"" .. path[i] .. "\"]"
                            else
                                code = code .. "[" .. tostring(path[i]) .. "]"
                            end
                        end
                        code = code..string.rep(":GetParent()", numParents)
                        KongConfig_PersistAsDropDown:AddItem(code, Simplify(code))
                    end
                elseif depth <= MAX_DEPTH then
                    KongConfig_RecursiveFrameSearch(Frame, value, depth+1, path, numParents)
                end
                table.remove(path)
            end
        end
    end
end

function KongConfig_PersistableFramePathSearch(frame, numParents)
    KongConfig_RecursiveFrameSearch(frame, _G, 1, {}, numParents)
    
    KongConfig_UpdatePersistAsPullout(KongConfig_PersistAsDropDown.pullout);
    coroutine.yield()
    for _, child in pairs({frame:GetChildren()}) do
       KongConfig_PersistableFramePathSearch(child, numParents+1)
    end
end

function KongConfig_UpdatePersistAsPullout(pullout)
    local items = pullout.items
    local frame = pullout.frame
    local itemFrame = pullout.itemFrame
    
    local height = 8
    for i, item in pairs(items) do
        if i == 1 then
            item:SetPoint("TOP", itemFrame, "TOP", 0, -2)
        else
            item:SetPoint("TOP", items[i-1].frame, "BOTTOM", 0, 1)
        end
        
        item:Show()
        
        if item:GetText() == KongConfig_PersistAsDropDown.text:GetText() then
            item.check:Show();
        end
        
        height = height + 16
    end
    itemFrame:SetHeight(height)
end

function KongConfig_UpdateComponents()

    KongConfig_FadeCheckBox:SetUserData(true, nil)
    KongConfig_FadeCheckBox:SetUserData(false, nil)
    
    KongConfig_HiddenAlphaCheckBox:SetUserData(true, nil)
    KongConfig_HiddenAlphaCheckBox:SetUserData(false, nil)
    KongConfig_ShownAlphaCheckBox:SetUserData(true, nil)
    KongConfig_ShownAlphaCheckBox:SetUserData(false, nil)
    KongConfig_FadeInCheckBox:SetUserData(true, nil)
    KongConfig_FadeInCheckBox:SetUserData(false, nil)
    KongConfig_FadeOutCheckBox:SetUserData(true, nil)
    KongConfig_FadeOutCheckBox:SetUserData(false, nil)
	KongConfig_FadeOutDelayCheckBox:SetUserData(true, nil)
	KongConfig_FadeOutDelayCheckBox:SetUserData(false, nil)
    
    KongConfig_OverrideAlphaCheckBox:SetUserData(true, nil)
    KongConfig_OverrideAlphaCheckBox:SetUserData(false, nil)
    
    KongConfig_HideAtZeroAlphaCheckBox:SetUserData(true, nil)
    KongConfig_HideAtZeroAlphaCheckBox:SetUserData(false, nil)
    
    local Defaults = KongConfig_DefaultsGroup:GetUserData(TRIGGERS)
    table.wipe(Defaults)
    
    for _, SelectedFrame in pairs(KongConfig_SelectedFrames) do
        
        if Kong_Frames[SelectedFrame.uiFrame] then
            
            KongConfig_FadeCheckBox:SetUserData(true, true)
            
            local TriggerDefaults = Kong_Frames[SelectedFrame.uiFrame].TriggerDefaults
            KongConfig_HiddenAlphaCheckBox:SetUserData(nil ~= rawget(TriggerDefaults, "alphaOut"), true)
            KongConfig_ShownAlphaCheckBox:SetUserData(nil ~= rawget(TriggerDefaults, "alphaIn"), true)
            KongConfig_FadeInCheckBox:SetUserData(nil ~= rawget(TriggerDefaults, "secondsIn"), true)
            KongConfig_FadeOutCheckBox:SetUserData(nil ~= rawget(TriggerDefaults, "secondsOut"), true)
			KongConfig_FadeOutDelayCheckBox:SetUserData(nil ~= rawget(TriggerDefaults, "secondsTillOut"), true)
            tinsert(Defaults, TriggerDefaults)
              
            KongConfig_OverrideAlphaCheckBox:SetUserData(true == Kong_Frames[SelectedFrame.uiFrame].overrideAlpha, true) 
            KongConfig_HideAtZeroAlphaCheckBox:SetUserData(true == Kong_Frames[SelectedFrame.uiFrame].hideAtZeroAlpha, true) 
        else
           KongConfig_FadeCheckBox:SetUserData(false, true)
        end
    end
    
    KongConfig_SetCheckBox(KongConfig_FadeCheckBox)
    
    KongConfig_SetCheckBox(KongConfig_HiddenAlphaCheckBox)
    KongConfig_SetCheckBox(KongConfig_ShownAlphaCheckBox)
    KongConfig_SetCheckBox(KongConfig_FadeInCheckBox)
    KongConfig_SetCheckBox(KongConfig_FadeOutCheckBox)
    KongConfig_SetCheckBox(KongConfig_FadeOutDelayCheckBox)
    
    KongConfig_SetCheckBox(KongConfig_OverrideAlphaCheckBox)
    KongConfig_SetCheckBox(KongConfig_HideAtZeroAlphaCheckBox)
    
    local fade = KongConfig_FadeCheckBox:GetValue()
    
    KongConfig_FadeCheckBox:SetDisabled(nil == next(KongConfig_SelectedFrames))

    KongConfig_HiddenAlphaCheckBox:SetDisabled(not fade)
    KongConfig_HiddenAlphaSlider:SetDisabled(not (fade and KongConfig_HiddenAlphaCheckBox:GetValue()))
    KongConfig_ShownAlphaCheckBox:SetDisabled(not fade)
    KongConfig_ShownAlphaSlider:SetDisabled(not (fade and KongConfig_ShownAlphaCheckBox:GetValue()))
    KongConfig_FadeInCheckBox:SetDisabled(not fade)
    KongConfig_FadeInSlider:SetDisabled(not (fade and KongConfig_FadeInCheckBox:GetValue()))
    KongConfig_FadeOutCheckBox:SetDisabled(not fade)
    KongConfig_FadeOutSlider:SetDisabled(not (fade and KongConfig_FadeOutCheckBox:GetValue()))
	KongConfig_FadeOutDelayCheckBox:SetDisabled(not fade)
	KongConfig_FadeOutDelaySlider:SetDisabled(not (fade and KongConfig_FadeOutDelayCheckBox:GetValue()))
    
    KongConfig_AddConditionButton:SetDisabled(not fade)
    
    KongConfig_GroupsComboBox:SetDisabled(not fade)
    KongConfig_NewGroupEditBox:SetDisabled(not fade)
    
    KongConfig_OverrideAlphaCheckBox:SetDisabled(not fade)
    KongConfig_HideAtZeroAlphaCheckBox:SetDisabled(not fade)
    local selectedFrame = next(KongConfig_SelectedFrames)
    KongConfig_PersistAsDropDown:SetDisabled(not (fade and selectedFrame and not next(KongConfig_SelectedFrames, selectedFrame)))
    
    -- Slider display
    KongConfig_UpdateTriggerSlider(KongConfig_HiddenAlphaSlider)
    KongConfig_UpdateTriggerSlider(KongConfig_ShownAlphaSlider)
    KongConfig_UpdateTriggerSlider(KongConfig_FadeInSlider)
    KongConfig_UpdateTriggerSlider(KongConfig_FadeOutSlider)
	KongConfig_UpdateTriggerSlider(KongConfig_FadeOutDelaySlider)
    
    -- Hidden and Shown alpha are constrained by one another
    if KongConfig_FadeCheckBox:GetValue() then
        KongConfig_ShownAlphaSlider:SetSliderValues(floor(KongConfig_HiddenAlphaSlider:GetValue()*100+.5)/100, 1, .01)
        KongConfig_HiddenAlphaSlider:SetSliderValues(0, floor(KongConfig_ShownAlphaSlider:GetValue()*100+.5)/100, .01)
    end
    
    KongConfig_UpdateConditions()
    
    KongConfig_UpdateGroups()
    
    KongConfig_UpdateAdvanced()
end

function KongConfig_UpdateConditions()
    
    -- Check for new conditions in each selected frame
    for Frame in pairs(KongConfig_SelectedFrames) do
        -- If registered
        if Kong_Frames[Frame.uiFrame] then
            -- For each trigger in the frame
            for _, FrameTrigger in ipairs(Kong_Frames[Frame.uiFrame]) do
                local found = false
                -- Check the trigger against each panel in the GUI
                for i, TriggerPanel in ipairs(KongConfig_ConditionsGroup.children) do
                    local GUITrigger = TriggerPanel:GetUserData("Triggers")[1]
                    -- If the triggers have the same structure
                    if GUITrigger.Condition:Equals(FrameTrigger.Condition) then
                        local duplicate = false
                        -- Check if the trigger is already being configured by the panel
                        for _, GUITrigger in ipairs(TriggerPanel:GetUserData("Triggers")) do
                            if FrameTrigger == GUITrigger then
                                found = true
                                break
                            elseif FrameTrigger.Frame == GUITrigger.Frame then
                                -- Each panel should only have one trigger for any single frame
                                duplicate = true
                            end
                        end
                        -- Otherwise
                        if (not found) and (not duplicate) then
                            tinsert(TriggerPanel:GetUserData("Triggers"), FrameTrigger)
                            TriggerPanel:GetUserData("ConditionEditor"):AddCondition(
                                FrameTrigger.Condition)
                            found = true
                            break
                        end
                    end
                end
                -- Add a panel for the trigger if one doesn't exist
                if not found then
                    KongConfig_ConditionsGroup:AddChild(KongConfig_CreateTriggerPanel(
                        FrameTrigger, FrameTrigger == Kong_Frames[Frame.uiFrame].Mouseover))
                end
            end
        end
    end
    
    -- Remove old or duplicate panels, disable panels that aren't used by all selected frames
    for i=#KongConfig_ConditionsGroup.children,1,-1 do
        local Panel = KongConfig_ConditionsGroup.children[i]
        local PanelTriggers = Panel:GetUserData("Triggers")
        
        -- For each trigger that was being configured in the panel
        for j=#PanelTriggers,1,-1 do
            local found = false
            local PanelTrigger = PanelTriggers[j]
            
            -- For each selected frame
            for Frame in pairs(KongConfig_SelectedFrames) do
                
                -- If registered
                if Kong_Frames[Frame.uiFrame] then
                
                    -- Does the trigger belong to this frame?
                    for _, FrameTrigger in ipairs(Kong_Frames[Frame.uiFrame]) do
                        if PanelTrigger == FrameTrigger then
                            found = true
                            break
                        end
                    end
                end
                if found then
                    break
                end
            end
            -- Remove the trigger if its frame was deselected or unregistered
            if not found then
                Panel:GetUserData("ConditionEditor"):RemoveCondition(PanelTrigger.Condition)
                tremove(PanelTriggers, j)
            end
        end
        
        -- Remove the panel if all its triggers were removed
        if #PanelTriggers == 0 then
            AceGUI:Release(tremove(KongConfig_ConditionsGroup.children, i))
            KongConfig_ScrollFrame:DoLayout()
        else
            -- Update panels state
            local AlphaCheckBox = Panel:GetUserData("AlphaCheckBox")
            local FadeInCheckBox = Panel:GetUserData("FadeInCheckBox")
            local FadeOutCheckBox = Panel:GetUserData("FadeOutCheckBox")
			local FadeOutDelayCheckBox = Panel:GetUserData("FadeOutDelayCheckBox")
            
            AlphaCheckBox:SetUserData(true, nil)
            AlphaCheckBox:SetUserData(false, nil)
            FadeInCheckBox:SetUserData(true, nil)
            FadeInCheckBox:SetUserData(false, nil)
            FadeOutCheckBox:SetUserData(true, nil)
            FadeOutCheckBox:SetUserData(false, nil)
			FadeOutDelayCheckBox:SetUserData(true, nil)
			FadeOutDelayCheckBox:SetUserData(false, nil)
            
            local foundInAllFrames = true
			for Frame in pairs(KongConfig_SelectedFrames) do
                local found = false	
                if Kong_Frames[Frame.uiFrame] then
                
                    -- Check if there's a trigger being configured for this frame
                    for _, PanelTrigger in ipairs(PanelTriggers) do
                        if PanelTrigger.Frame == Frame.uiFrame then
                            found = true
                            AlphaCheckBox:SetUserData(nil ~= rawget(PanelTrigger, "alphaIn"), true)
                            FadeInCheckBox:SetUserData(nil ~= rawget(PanelTrigger, "secondsIn"), true)
                            FadeOutCheckBox:SetUserData(nil ~= rawget(PanelTrigger, "secondsOut"), true)
							FadeOutDelayCheckBox:SetUserData(nil ~= rawget(PanelTrigger, "secondsTillOut"), true)
                            break
                        end
                    end
                end
                foundInAllFrames = foundInAllFrames and found
            end
            
            local MouseoverText = Panel:GetUserData("MouseoverText")
            if MouseoverText then
                if foundInAllFrames then 
                    Panel:SetTitle("Frame has Mouse Focus")
                    MouseoverText.label:SetTextColor(1,1,1);
                else
                    Panel:SetTitle("|cFF888888Frame has Mouse Focus")
                    MouseoverText.label:SetTextColor(.5,.5,.5);
                end
            else
                Panel:GetUserData("ConditionEditor"):SetEnabled(foundInAllFrames)
            
                local SyncButton = Panel:GetUserData("SyncButton")
                local fade = KongConfig_FadeCheckBox:GetValue()
                SyncButton:SetDisabled((not fade) or foundInAllFrames)
            end
            
            AlphaCheckBox:SetDisabled(not foundInAllFrames)
            KongConfig_SetCheckBox(AlphaCheckBox)
            
            FadeInCheckBox:SetDisabled(not foundInAllFrames)
            KongConfig_SetCheckBox(FadeInCheckBox)
            
            FadeOutCheckBox:SetDisabled(not foundInAllFrames)
            KongConfig_SetCheckBox(FadeOutCheckBox)
            
			FadeOutDelayCheckBox:SetDisabled(not foundInAllFrames)
			KongConfig_SetCheckBox(FadeOutDelayCheckBox)
			
            local AlphaSlider = Panel:GetUserData("AlphaSlider")
            AlphaSlider:SetDisabled(not (foundInAllFrames and AlphaCheckBox:GetValue()))
            AlphaSlider:SetSliderValues(floor(KongConfig_HiddenAlphaSlider:GetValue()*100+.5)/100, 1, .01)
            KongConfig_UpdateTriggerSlider(AlphaSlider)
            
            local FadeInSlider = Panel:GetUserData("FadeInSlider")
            FadeInSlider:SetDisabled(not (foundInAllFrames and FadeInCheckBox:GetValue()))
            KongConfig_UpdateTriggerSlider(FadeInSlider)
            
            local FadeOutSlider = Panel:GetUserData("FadeOutSlider")
            FadeOutSlider:SetDisabled(not (foundInAllFrames and FadeOutCheckBox:GetValue()))
            KongConfig_UpdateTriggerSlider(FadeOutSlider)
			
			local FadeOutDelaySlider = Panel:GetUserData("FadeOutDelaySlider")
			FadeOutDelaySlider:SetDisabled(not (foundInAllFrames and FadeOutDelayCheckBox:GetValue()))
			KongConfig_UpdateTriggerSlider(FadeOutDelaySlider)
        end
    end
    
    -- Fix for crazy empty group sizes
    if #KongConfig_ConditionsGroup.children == 0 then
        if KongConfig_ConditionsCategoryGroup.children[1] == KongConfig_ConditionsGroup then
            tremove(KongConfig_ConditionsCategoryGroup.children, 1)
            KongConfig_ConditionsGroup.frame:Hide()
            KongConfig_ConditionsCategoryGroup:DoLayout()
        end
    elseif KongConfig_ConditionsCategoryGroup.children[1] ~= KongConfig_ConditionsGroup then
        tinsert(KongConfig_ConditionsCategoryGroup.children, 1, KongConfig_ConditionsGroup)
        KongConfig_ConditionsGroup.frame:Show()
        KongConfig_ConditionsCategoryGroup:DoLayout()
    end
end

function KongConfig_UpdateGroups()

    if KongConfig_FadeCheckBox:GetValue() then
        -- Populate the group pulldown
        local groups = {}
        for name in pairs(Kong_Settings.Groups) do 
            groups[name] = name
        end
        KongConfig_GroupsComboBox:SetList(groups)
        
        -- Select items based on state
        for i, widget in KongConfig_GroupsComboBox.pullout:IterateItems() do
            if widget.type == "Dropdown-Item-Toggle" then
            
                widget:SetUserData(true, nil)
                widget:SetUserData(false, nil)
                
                for _, SelectedFrame in pairs(KongConfig_SelectedFrames) do
                    if Kong_Frames[SelectedFrame.uiFrame] then
                        
                        widget:SetUserData(nil ~= 
                            Kong_Settings.Groups[widget:GetText()][Kong_Frames[SelectedFrame.uiFrame].index], true)
                    end
                end
                
                local set, clear = widget:GetUserData(true), widget:GetUserData(false)
                if set and clear then
                    widget.value = nil
                    widget.check:Show()
                    SetDesaturation(widget.check, true)
                else
                    KongConfig_GroupsComboBox:SetItemValue(widget:GetText(), set)
                    SetDesaturation(widget.check, false)
                end
            end
        end
        
        if KongConfig_GroupsComboBox.open then
            KongConfig_GroupsComboBox.pullout:Open("TOPLEFT", KongConfig_GroupsComboBox.frame, "BOTTOMLEFT", 0, KongConfig_GroupsComboBox.label:IsShown() and -2 or 0)
        end
    else
        KongConfig_GroupsComboBox:SetList({})
        KongConfig_GroupsComboBox.pullout:Close()
    end
    
    KongConfig_NewGroupEditBox.editbox:ClearFocus()
    KongConfig_NewGroupEditBox:SetText("")
end

function KongConfig_UpdateAdvanced()
    
    local selectedFrame = next(KongConfig_SelectedFrames)
    if selectedFrame then
        if not next(KongConfig_SelectedFrames, selectedFrame) then
        
            KongConfig_PersistAsDropDown:SetText(_G[selectedFrame:GetName().."Title"]:GetText())
        else
            KongConfig_PersistAsDropDown:SetText("Too many widgets selected");
            KongConfig_PersistAsDropDown.pullout:Close()
        end
    else
        KongConfig_PersistAsDropDown:SetText("");
        KongConfig_PersistAsDropDown.pullout:Close()
    end

    if not KongConfig_FadeCheckBox:GetValue() then
        KongConfig_PersistAsDropDown.pullout:Close()
    end
end

function KongConfig_SetCheckBox(checkbox)
    
    local set, clear = checkbox:GetUserData(true), checkbox:GetUserData(false)
    if set and clear then
        checkbox:SetTriState(true)
        checkbox:SetValue(nil)
    else
        checkbox:SetTriState(false)
        checkbox:SetValue(set == true)
    end
end

function KongConfig_UpdateTriggerSlider(slider)

    slider:SetValue((slider.min+slider.max)/2)
    slider.editbox:SetText(SLIDER_VALUE_NA)

    -- N/A if not all selected frames are registered
    for _, SelectedFrame in pairs(KongConfig_SelectedFrames) do
        if not Kong_Frames[SelectedFrame.uiFrame] then
            slider:SetValue((slider.min+slider.max)/2)
            slider.editbox:SetText(SLIDER_VALUE_NA)
            return
        end
    end
    
    -- N/A if not all Trigger values match
    local Triggers, field = slider:GetUserData(TRIGGERS), slider:GetUserData(FIELD)
    local sliderValue, currentValue
    for _, Trigger in ipairs(Triggers) do
    
        currentValue = Trigger[field]
        
        if not sliderValue then
            sliderValue = currentValue
            slider:SetValue(sliderValue)
        elseif sliderValue ~= currentValue then
            slider:SetValue((slider.min+slider.max)/2)
            slider.editbox:SetText(SLIDER_VALUE_NA)
            break
        end
    end
end

-- Callbacks ---------------------------------------------------------------------------------------
function KongConfig_SliderCheckBox_OnValueChanged(self) 
    
    KongConfig:SetStatusText("")

    local triggers, field = self:GetUserData(TRIGGERS), self:GetUserData(FIELD)

    if self:GetValue() then
        for i, trigger in ipairs(triggers) do 
            trigger[field] = trigger[field] -- Read from metatable
        end
    else
        for i, trigger in ipairs(triggers) do 
            rawset(trigger, field, nil)
        end
    end
    
    KongConfig_UpdateComponents()
end

function KongConfig_TriggerSlider_OnMouseUp(self, _, value)
  
    KongConfig:SetStatusText("")

    self:SetValue(value)
    
    local triggers, field = self:GetUserData(TRIGGERS), self:GetUserData(FIELD)
    for i, trigger in ipairs(triggers) do
        trigger[field] = value
    end
    
    KongConfig_UpdateComponents()
end

function KongConfig_FadeCheckBox_OnValueChanged() 
    
    KongConfig:SetStatusText("")

    local hide = KongConfig_FadeCheckBox:GetValue()
    if hide then
        for frame in pairs(KongConfig_SelectedFrames) do
            if not Kong_Frames[frame.uiFrame] then
                Kong_RegisterFrame(frame.uiFrame)
            end
        end
    else
        for frame in pairs(KongConfig_SelectedFrames) do
            if Kong_Frames[frame.uiFrame] then
                Kong_UnregisterFrame(frame.uiFrame)
            end
        end
    end

    KongConfig_UpdateComponents()
    KongConfig_AutoExpandAndCollapse()
end

function KongConfig_AddConditionButton_OnClick()

    for Frame in pairs(KongConfig_SelectedFrames) do
        Kong_AddTrigger(Frame.uiFrame, LibUSC:Create("Condition", LibUSC:Create("False")))
    end
    
    KongConfig_UpdateComponents()
end

function KongConfig_SyncButton_OnClick(self, button, down)

    local ConfigPanel = self.parent
    local Triggers = ConfigPanel:GetUserData("Triggers")
    
    for Frame in pairs(KongConfig_SelectedFrames) do
        local found = false
        
        for _, Trigger in ipairs(Triggers) do
            if Frame.uiFrame == Trigger.Frame then
                found = true
                break
            end
        end
        
        if not found then
            Kong_AddTrigger(Frame.uiFrame, Triggers[1].Condition:Clone())
            
            -- TODO Copy fade settings if selected triggers are in agreement on them
        end
    end
    
    KongConfig_UpdateComponents()
end

function KongConfig_DeleteButton_OnClick(self, button, down)

    local ConfigPanel = self.parent
    local Triggers = ConfigPanel:GetUserData("Triggers")
    
    for i, child in ipairs(KongConfig_ConditionsGroup.children) do 
        if child == ConfigPanel then
            AceGUI:Release(tremove(KongConfig_ConditionsGroup.children, i))
            break
        end
    end

    for i=#Triggers,1,-1 do
        local Trigger = Triggers[i]
        Kong_RemoveTrigger(Trigger.Frame, Trigger)
        tremove(Triggers, i)
    end
    
    KongConfig_UpdateComponents()
    GameTooltip:Hide()
end

function KongConfig_GroupsComboBox_OnValueChanged(self, _, group, checked)
    
    KongConfig:SetStatusText("")

    for frame in pairs(KongConfig_SelectedFrames) do
        if checked then
            Kong_AddFrameToGroup(frame.uiFrame, group)
        else
            Kong_RemoveFrameFromGroup(frame.uiFrame, group)
        end
    end
    
    KongConfig_UpdateComponents()
end

function KongConfig_NewGroupEditBox_OnEnterPressed(self, _, text)
    
    if text == "" then
        KongConfig_Error("Group name cannot be empty.")
        return
    else
        KongConfig:SetStatusText("")
    end
    
    for frame in pairs(KongConfig_SelectedFrames) do
        Kong_AddFrameToGroup(frame.uiFrame, string.lower(text))
    end
    
    KongConfig_UpdateComponents()
end

function KongConfig_OverrideAlphaCheckBox_OnValueChanged(self)
    
    KongConfig:SetStatusText("")
    
    local override = self:GetValue()

    for Frame in pairs(KongConfig_SelectedFrames) do
        Kong_Frames[Frame.uiFrame].overrideAlpha = override
        Kong_OverrideAlpha(Frame.uiFrame, override)
    end
    
    KongConfig_UpdateComponents()
end

function KongConfig_HideAtZeroAlpha_OnValueChanged(self)
	KongConfig:SetStatusText("")
	
	for frame in pairs(KongConfig_SelectedFrames) do
		Kong_Frames[frame.uiFrame].hideAtZeroAlpha = self:GetValue()
	end
	
	KongConfig_UpdateComponents()
end

function KongConfig_PersistAsDropDown_OnClick(self, button, down)

    KongConfig_PersistAsDropDown.pullout:SetWidth(KongConfig_PersistAsDropDown.frame:GetWidth() - 30);
    
    -- Scan memory if a new frame was selected since last time
    local Frame = next(KongConfig_SelectedFrames)
    if Frame ~= KongConfig_PersistAsDropDown:GetUserData(FRAME) then
        KongConfig_PersistAsDropDown:SetUserData(FRAME, Frame)
        KongConfig_PersistAsDropDown:SetList({})
        KongConfig_PersistAsCoroutine = coroutine.create(KongConfig_PersistableFramePathSearch)
        local status, err = coroutine.resume(KongConfig_PersistAsCoroutine, Frame.uiFrame, 0)
        if not status then
            error(err)
        end
    end
end

function KongConfig_PersistAsComboBox_OnValueChanged(self, _, code)

    KongConfig:SetStatusText("")
    
    local Frame = next(KongConfig_SelectedFrames)
    
    Kong_RenameFrame(Frame.uiFrame, code)
    _G[Frame:GetName().."Title"]:SetText(Simplify(code))
    
    KongConfig_UpdateComponents()
end

function KongConfig_UpdateTooltip(self, event)
    
    if event == "OnEnter" then
        GameTooltip:SetOwner(self:GetUserData(OWNER) or self.frame, 
            self:GetUserData(ANCHOR) or "ANCHOR_TOP")
        GameTooltip:AddLine(self:GetUserData(TITLE) or self.text:GetText())
        
        GameTooltip:AddLine(self:GetUserData(TOOLTIP) or 
            self:GetUserData(TOOLTIP..self:GetUserData(TRIGGER)), 1,1,1,1,1)
        
        GameTooltip:Show()
    else
        GameTooltip:Hide()
    end
end

function KongConfig_OnDropdownValueChanged(Dropdown, _, value)
    
    local CoverButton = Dropdown.obj;
    if value == BRING_TO_FRONT then
        KongConfig_BringToFront(CoverButton)
    elseif value == SEND_TO_BACK then
        KongConfig_SendToBack(CoverButton)
    elseif value == CONFIGURE_CHILDREN then
        KongConfig_CreateChildCoverButtons(CoverButton.uiFrame)
        if Kong_Frames[CoverButton.uiFrame] then
            KongConfig_SendToBack(CoverButton)
        else
            CoverButton:Hide();
        end
    elseif value == CONFIGURE_PARENT then
        local Parent = CoverButton.uiFrame:GetParent()
        for _, Child in pairs({Parent:GetChildren()}) do
            if KongConfig_Frames[Child] and not Kong_Frames[Child] then
                KongConfig_Frames[Child]:Hide()
            end
        end
        KongConfig_CreateCoverButton(Parent)
        KongConfig_BringToFront(KongConfig_Frames[Parent])
    end
end
Dropdown:SetCallback("OnValueChanged", KongConfig_OnDropdownValueChanged)