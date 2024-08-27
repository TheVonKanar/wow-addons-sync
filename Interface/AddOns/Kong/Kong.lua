local	_G, assert, ipairs, loadstring, math, next, pairs, pcall, print, setmetatable, string, table, tonumber, tostring, type, xpcall
=		_G, assert, ipairs, loadstring, math, next, pairs, pcall, print, setmetatable, string, table, tonumber, tostring, type, xpcall
local	CreateFrame, debugstack, GetMouseFoci, GetMouseFocus, GetRealmName, GetTime, hooksecurefunc, IsAddOnLoaded, StaticPopup_Show, strsplit, UnitName, WOW_PROJECT_CLASSIC, WOW_PROJECT_ID, WOW_PROJECT_MAINLINE
=		CreateFrame, debugstack, GetMouseFoci, GetMouseFocus, GetRealmName, GetTime, hooksecurefunc, IsAddOnLoaded, StaticPopup_Show, strsplit, UnitName, WOW_PROJECT_CLASSIC, WOW_PROJECT_ID, WOW_PROJECT_MAINLINE


local N, A = ... -- Addon (N)ame, (A)ddon Table
local R = A.CLASSES -- Class (R)epository


local DUMMY_FRAME = CreateFrame("frame") -- used for references to avoid abundant rawget calls when dealing with dummy functions
local FADER = R.Fader.construct()
R.Fader.addListener(FADER, "FADE_STARTED", 
		function(obj, event, region, fromAlpha, toAlpha, duration, smoothing, startDelay, endDelay)
			local setting = Kong_Frames[region]
			
			if ( setting.hideAtZeroAlpha and region:GetAlpha() == 0 ) then
				DUMMY_FRAME.Show(region)
			end
		end,
		{}
)
R.Fader.addListener(FADER, "FADE_FINISHED", 
		function(obj, event, region)
			local setting = Kong_Frames[region]
			
			if ( setting.hideAtZeroAlpha and region:GetAlpha() == 0 ) then
				DUMMY_FRAME.Hide(region)
			end
		end,
		{}
)


BINDING_HEADER_KONG = "Kong Automatic UI Hider"
BINDING_NAME_KONG_ENABLE = "Enable UI Fading"
BINDING_NAME_KONG_DISABLE = "Disable UI Fading"
BINDING_NAME_KONG_TOGGLE = "Toggle UI Fading On/Off"
BINDING_NAME_KONG_CONFIG = "Open Config GUI"
local VERSION = "1.6a"

Kong_Frames = {}
Kong_Profiles = {}

local lastMouseFocus = nil
local lastMouseStart = nil

local CANNOT_SAVE = "Nameless frames cannot be saved."
local PROFILE_RESET = "Current profile %q has been reset."
local WELCOME = "New character detected. Type |cFF33FF99/Kong|r to configure."

StaticPopupDialogs["KONG_RESET"] = {
	text = "Are you sure you want to delete all settings from the Kong profile \"%s\"?",
	button1 = "Reset",
	button2 = CANCEL,
	OnAccept = function(self)

		Kong_Unload()
		Kong_Profiles[Kong_Settings.profile] = nil
		A.LoadSettings()

		Kong_Info(PROFILE_RESET, Kong_Settings.profile)
	end,
	showAlert = 1,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}

-- The defaults for all triggers
local TriggerDefaults = {
	secondsIn = .2,
	secondsOut = 1,
	secondsTillOut = 0,
	alphaIn = 1,
	alphaOut = 0,
}

function Kong_Error(str, ...)
	print("|cFFFF2222Kong Error:|r "..string.format(str, ...))
end

function Kong_Warning(str, ...)
	print("|cFFFF9922Kong Warning:|r "..string.format(str, ...))
end

function Kong_Info(str, ...)
	print("|cFF33FF99Kong:|r "..string.format(str, ...))
end

local LibUSC = LibStub("LibUserSpecifiedConditions", true)
if not LibUSC then
	Kong_Error("Kong does not appear to have been installed correctly. Note: A full restart of "
			 .."World of Warcraft is required when upgrading from a previous version of Kong.")
	return
end

-- Dummy condition
local MouseoverTypeName = "Frame has Mouse Focus"
LibUSC:RegisterParameter(MouseoverTypeName, {
	type = "Truth",
	isHidden = true,
	value = false,
})

function Kong_OverrideAlpha(region, override)
	assert(Kong_Frames[region] ~= nil)

	if ( override ) then
		region.SetAlpha = function() end
	else
		region.SetAlpha = nil
	end
end

function Kong_Fade(region, fromAlpha, toAlpha, duration, startDelay)
	if ( Kong_Settings.enabled and (KongConfig == nil or not KongConfig:IsShown()) ) then
		R.Fader.fade(FADER, region, nil, toAlpha, duration, nil, startDelay)
	end
end

function A.FadeIn(region, condition)
	condition.refs = condition.refs + 1
	if ( condition.refs == 1 ) then
		A.CalculateFadeIn(region)
	end
end

function A.CalculateFadeIn(region)
	local setting = Kong_Frames[region]
	local currentAlpha = region:GetAlpha()
	local chosenTrigger
	
	-- NOTE: choose the trigger with the highest alpha, with the fastest speed
	for i, trigger in ipairs(setting) do
		if ( trigger.refs > 0 ) then
			chosenTrigger = chosenTrigger or trigger
			
			local speed = math.abs(trigger.alphaIn - trigger.alphaOut) / trigger.secondsIn
			local otherSpeed = math.abs(chosenTrigger.alphaIn - chosenTrigger.alphaOut) / chosenTrigger.secondsIn
			
			if ( trigger.alphaIn > chosenTrigger.alphaIn or (trigger.alphaIn == chosenTrigger.alphaIn and speed > otherSpeed) ) then
				chosenTrigger = trigger
			end
		end
	end
	
	if ( chosenTrigger ~= nil ) then
		local endAlpha = chosenTrigger.alphaIn
		local speed = math.abs(chosenTrigger.alphaIn - chosenTrigger.alphaOut) / chosenTrigger.secondsIn
		local duration = math.abs(currentAlpha - endAlpha) / speed
		
		Kong_Fade(region, currentAlpha, endAlpha, duration)
	end
end

function A.FadeOut(region, condition)
	condition.refs = condition.refs - 1
	assert(condition.refs >= 0, "ref < 0 for region: " .. tostring(region:GetName() or region))
	if ( condition.refs == 0 ) then
		local rate = (condition.alphaOut - condition.alphaIn) / condition.secondsOut
		local displacement = (condition.alphaIn - region:GetAlpha()) / rate
		condition.lastFadeTime = GetTime() + displacement
		Kong_CalculateFadeOut(region)
	end
end

function Kong_CalculateFadeOut(region)
	local setting = Kong_Frames[region]
	local currentAlpha = region:GetAlpha()
	local endAlpha = setting.TriggerDefaults.alphaOut
	local duration = 0
	local delay = setting.TriggerDefaults.secondsTillOut
	local chosenTrigger

	for i, trigger in ipairs(setting) do
		if ( trigger.refs > 0 ) then
			if ( trigger.alphaIn >= currentAlpha ) then return end

			endAlpha = math.max(endAlpha, trigger.alphaIn)
		elseif ( trigger.lastFadeTime ~= nil ) then
			chosenTrigger = chosenTrigger or trigger

			local now = GetTime()
			local sinceTrue = now - trigger.lastFadeTime
			local otherSinceTrue = now - chosenTrigger.lastFadeTime
			
			local speed = math.abs(trigger.alphaOut - trigger.alphaIn) / trigger.secondsOut
			local otherSpeed = math.abs(chosenTrigger.alphaOut - chosenTrigger.alphaIn) / chosenTrigger.secondsOut

			if ( sinceTrue < otherSinceTrue or (sinceTrue == otherSinceTrue and speed < otherSpeed) ) then
				chosenTrigger = trigger
			end
		end
	end

	if ( chosenTrigger ~= nil ) then
		local speed = math.abs(chosenTrigger.alphaOut - chosenTrigger.alphaIn) / chosenTrigger.secondsOut
		duration = math.abs(endAlpha - currentAlpha) / speed
		delay = chosenTrigger.secondsTillOut
	end

	Kong_Fade(region, currentAlpha, endAlpha, duration, delay)
end

function Kong_FindGlobalIndex(region)
	local name = region:GetName()
	
	if ( name ) then
		return '["' .. name .. '"]'
	end
	
	for k, v in pairs(_G) do
		if ( v == region ) then
			local keyType = type(k)
			if ( keyType == "string" ) then
				return '["' .. k .. '"]'
			elseif ( keyType == "number" or keyType == "boolean" ) then
				return "[" .. tostring(k) .. "]"
			end
		end
	end
	
	for i, child in pairs{region:GetChildren()} do
		name = Kong_FindGlobalIndex(child)
		if ( name ) then
			return name .. ":GetParent()"
		end
	end
end

function A.CreateTrigger(Frame)

	local Trigger = {}
	setmetatable(Trigger, {__index = Kong_Frames[Frame].TriggerDefaults or TriggerDefaults})

	if Kong_Frames[Frame].TriggerDefaults then
		Trigger.refs = 0
	else
		Trigger.Frame = Frame
	end

	return Trigger
end

function Kong_RegisterFrame(region)
	Kong_Frames[region] = {}
	local index = Kong_FindGlobalIndex(region)
	if ( index ~= nil ) then
		Kong_Frames[region].index = index
	else
		Kong_Frames[region].index = {}
		Kong_Warning(CANNOT_SAVE)
	end
	Kong_Frames[region].version = VERSION
	Kong_Frames[region].TriggerDefaults = A.CreateTrigger(region)
	Kong_Frames[region].Mouseover = Kong_AddTrigger(region, LibUSC:Create("Condition", LibUSC:Create(MouseoverTypeName)))
	Kong_AddTrigger(region, LibUSC:Create("Condition", LibUSC:Create("Unit in Combat")))
end

function Kong_UnregisterFrame(region)
	for i = #Kong_Frames[region], 1, -1 do
		Kong_RemoveTrigger(region, Kong_Frames[region][i])
	end
	Kong_OverrideAlpha(region, false)
	Kong_Fade(region, 1, 1, 0)
	local index = Kong_Frames[region].index
	for name, group in pairs(Kong_Settings.Groups) do
		if ( group[index] ~= nil ) then
			group[index] = nil
			if ( next(group) == nil ) then
				Kong_Settings.Groups[name] = nil
			end
		end
	end
	Kong_Frames[region] = nil
end

function A.OnConditionStateChange(region, trigger)
	if ( trigger.Condition:IsMet() ) then
		A.FadeIn(region, trigger)
	else
		A.FadeOut(region, trigger)
	end
end

function Kong_AddTrigger(region, condition)
	local trigger = A.CreateTrigger(region)
	trigger.Condition = condition
	trigger.Condition:AddListener(A.OnConditionStateChange, region, trigger)
	table.insert(Kong_Frames[region], trigger)
	if ( trigger.Condition:IsMet() ) then
		A.FadeIn(region, trigger)
	end
	return trigger
end

function Kong_RemoveTrigger(region, trigger)
	if ( trigger.Condition:IsMet() ) then
		A.FadeOut(region, trigger)
	end
	trigger.Condition:RemoveListener(A.OnConditionStateChange)
	LibUSC:Deflate(trigger.Condition)
	for i, v in ipairs(Kong_Frames[region]) do
		if ( v == trigger ) then
			table.remove(Kong_Frames[region], i)
			break
		end
	end
end

function Kong_AddFrameToGroup(region, name)
	Kong_Settings.Groups[name] = Kong_Settings.Groups[name] or {}
	local group = Kong_Settings.Groups[name]
	local index = Kong_Frames[region].index
	if ( group[index] == nil ) then
		group[index] = region
		return true
	end
end

function Kong_RemoveFrameFromGroup(region, name)
	local group = Kong_Settings.Groups[name]
	local index = Kong_Frames[region].index
	if ( group ~= nil and group[index] ~= nil ) then
		group[index] = nil
		if ( next(group) == nil ) then
			Kong_Settings.Groups[name] = nil
		end
		return true
	end
end

function A.Enable()
	Kong_Settings.enabled = true
	for Frame in pairs(Kong_Frames) do
		Kong_CalculateFadeOut(Frame)
	end
end

function A.Disable()
	for Frame in pairs(Kong_Frames) do
		Kong_Fade(Frame, 1, 1, 0)
	end
	Kong_Settings.enabled = false
end

function Kong_RenameFrame(region, newIndex)
	local index = Kong_Frames[region].index
	for name, group in pairs(Kong_Settings.Groups) do
		if ( group[index] ~= nil ) then
			group[index] = nil
			group[newIndex] = region
		end
	end
	Kong_Frames[region].index = newIndex
end

function A.LoadSettings()
	if ( Kong_Initialized ) then return end
	Kong_Initialized = true
	
	if ( not Kong_Settings or not Kong_Settings.profile ) then
		local playerName = string.lower( UnitName("player") )
		local playerServer = string.lower( string.gsub(GetRealmName(), " ", "_") )
		local profileName = playerName .. "_of_" .. playerServer
		
		Kong_Settings = {
			profile = profileName,
			enabled = true,
		}
	end

	Kong_Settings.profile = string.gsub(Kong_Settings.profile, " ", "_")
	
	if ( not Kong_Profiles[Kong_Settings.profile] ) then
		Kong_Profiles[Kong_Settings.profile] = {
			Frames = {},
			Groups = {},
		}
	end
	
	setmetatable(Kong_Settings, {__index = Kong_Profiles[Kong_Settings.profile]})

	Kong_Profiles[Kong_Settings.profile].version = VERSION

	A.LoadFrames()

	if ( not Kong_Settings.enabled ) then
	   Kong_Warning("Kong is currently disabled. Use |cFF33FF99/kong toggle|r to enable it.")
	end
end

function A.LoadFrames()
	for i = #Kong_Settings.Frames, 1, -1 do
		local setting = Kong_Settings.Frames[i]
		
		if ( not setting.loader ) then
			setting.loader = loadstring("return _G" .. setting.index)
		end

		local isFound, region = pcall(setting.loader)

		if (
				isFound
				and region
				and type(region.IsObjectType) == "function"
				and region:IsObjectType("Region") -- make sure it is a region; ticket #5
				and not Kong_Frames[region]
		) then
			setting.loader = nil
			Kong_Frames[region] = setting
			table.remove(Kong_Settings.Frames, i)

			setmetatable(setting.TriggerDefaults, {__index = TriggerDefaults})
			setting.TriggerDefaults.Frame = region
			
			if ( setting.overrideAlpha ) then
				Kong_OverrideAlpha(region, true)
			end
			
			for i, trigger in ipairs(setting) do
				setmetatable(trigger, {__index = setting.TriggerDefaults})
				trigger.refs = 0
				LibUSC:Inflate(trigger.Condition)
				trigger.Condition:AddListener(A.OnConditionStateChange, region, trigger)
				
				if ( MouseoverTypeName == trigger.Condition.Parameters[1]:GetName() ) then
					setting.Mouseover = trigger
				end
			end

			if ( Kong_Settings.enabled ) then
				Kong_CalculateFadeOut(region)
			end
			
			for i, trigger in ipairs(setting) do
				if ( trigger.Condition:IsMet() ) then
					A.FadeIn(region, trigger)
				end
			end
			
			for name, group in pairs(Kong_Settings.Groups) do
				if ( group[setting.index] ) then
					for i = 1, group[setting.index] do
						A.FadeIn(region, setting.Mouseover)
					end
					group[setting.index] = region
				end
			end
		end
	end
end

function Kong_Unload()
	for region, settings in pairs(Kong_Frames) do
		Kong_OverrideAlpha(region, false)
		Kong_Fade(region, 1, 1, 0)
		
		for i, trigger in ipairs(settings) do
			trigger.refs = nil
			trigger.lastFadeTime = nil
			trigger.Condition:RemoveListener(A.OnConditionStateChange)
			LibUSC:Deflate(trigger.Condition)
		end
		
		settings.loader = nil
		settings.Mouseover = nil
		settings.TriggerDefaults.Frame = nil
		
		Kong_Frames[region] = nil
		if ( type(settings.index) ~= "table" ) then
			table.insert(Kong_Settings.Frames, settings)
		end
	end
	
	if ( MinimapParent ) then
		MinimapParent.KongAlphaAnimation:GetScript("OnFinished")()
	end
	
	for name, group in pairs(Kong_Settings.Groups) do
		for index in pairs(group) do
			group[index] = 0
		end
	end
	
	Kong_Frames = {}
	lastMouseFocus = nil
	lastMouseStart = nil
	Kong_Initialized = false
end

function A.FindFirstTrackedRegion(region)
	while ( region ~= nil and Kong_Frames[region] == nil ) do
		region = not region:IsForbidden() and region:GetParent() or nil
	end
	return region
end

function A.ForEachTrackedRegion(region, func, ...)
	while ( region ~= nil ) do
		if ( Kong_Frames[region] ~= nil ) then func(region, ...) end
		region = not region:IsForbidden() and region:GetParent() or nil
	end
end

function A.MouseoverRegionFader(region, func, additive)
	local settings = Kong_Frames[region]
	for name, group in pairs(Kong_Settings.Groups) do
		if ( group[settings.index] ~= nil ) then
			for index, groupRegion in pairs(group) do
				if ( type(groupRegion) == "table" ) then -- TODO: remove value-type ambiguity
					func(groupRegion, Kong_Frames[groupRegion].Mouseover)
				else
					group[index] = groupRegion + additive
				end
			end
		end
	end
	func(region, settings.Mouseover)
end

local FRAME_FIND_PERIOD = 1.0
local frameFindTimer = 0

function A.OnUpdate(self, elapsed)
	frameFindTimer = frameFindTimer - elapsed
	if frameFindTimer <= 0 then
		frameFindTimer = FRAME_FIND_PERIOD
		A.LoadFrames()
	end

	local mouseFocus
	if ( GetMouseFocus ~= nil ) then
		mouseFocus = GetMouseFocus()
	else
		mouseFocus = GetMouseFoci()[1]
	end
	if ( mouseFocus ~= lastMouseFocus ) then
		local mouseStart = mouseFocus ~= nil and A.FindFirstTrackedRegion(mouseFocus) or nil
		if ( mouseStart ~= lastMouseStart ) then
			if ( mouseStart ~= nil ) then
				A.ForEachTrackedRegion(mouseStart, A.MouseoverRegionFader, A.FadeIn, 1)
			end
			if ( lastMouseStart ~= nil ) then
				A.ForEachTrackedRegion(lastMouseStart, A.MouseoverRegionFader, A.FadeOut, -1)
			end
			lastMouseStart = mouseStart
		end
		lastMouseFocus = mouseFocus
	end
end

function A.OnEvent(self, event, arg1, ...)

	if event == "ADDON_LOADED" then
		if arg1 == "Kong" and not Kong_Settings then
			Kong_Info(WELCOME)
		end
	elseif event == "PLAYER_LOGIN" then

		A.LoadSettings()
		
		hooksecurefunc("CreateFrame", function() frameFindTimer = 0; end)
		KongUIFader:SetScript("OnUpdate", A.OnUpdate)
	elseif event == "PLAYER_LOGOUT" then
		xpcall(Kong_Unload, function(message) Kong_Settings.error = message.."\n"..debugstack() end)
	end
end

-- Fix for TukUI PetBattleHider -- TODO remove after v1.6
if TukuiPetBattleHider then
	for _,TukChild in pairs({TukuiPetBattleHider:GetChildren()}) do
		TukChild:SetParent(UIParent)
		local unit = TukChild:GetAttribute("unit")
		if unit then
			RegisterUnitWatch(TukChild, true)
			RegisterStateDriver(TukChild, "visibility", "[@"..unit..",exists,nopetbattle] show; hide")
		else
			RegisterStateDriver(TukChild, "visibility", "[nopetbattle] show; hide")
		end
	end
	UnregisterStateDriver(TukuiPetBattleHider, "visibility")
	TukuiPetBattleHider:Hide()
	TukuiPetBattleHider = UIParent
end

-- The event receiver frame
KongUIFader = CreateFrame("Frame")
KongUIFader:SetScript("OnEvent", A.OnEvent)

KongUIFader:RegisterEvent("ADDON_LOADED")
KongUIFader:RegisterEvent("PLAYER_LOGIN")
KongUIFader:RegisterEvent("PLAYER_LOGOUT")