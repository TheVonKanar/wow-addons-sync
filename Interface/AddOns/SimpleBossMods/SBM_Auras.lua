-- SimpleBossMods debuff display.
-- Uses Blizzard's secure custom aura container so restricted and private
-- encounter auras can be rendered without exposing their identity to SBM.

local ADDON_NAME = ...
local M = _G[ADDON_NAME]
if not M then return end

local C = M.Const
local L = M.Live
local unpackValues = unpack or table.unpack

local ALL_DEBUFF_GROUP = {
	key = "harmfulDebuffs",
}
local DISPELLABLE_TYPES = AuraUtil.DispellableDebuffTypes

-- C-side filter tokens are allowlists over spell data flags; most ordinary
-- debuffs carry none of them, so only categories whose token semantics are
-- exactly right stay token-based. The rest match container-side through
-- candidate filters instead.
local TOKEN_FILTER_GROUPS = {
	{
		key = "harmfulDebuffsRaid",
		configKey = "raid",
		token = AuraUtil.AuraFilters.Raid,
	},
	{
		key = "harmfulDebuffsRaidPlayerDispellable",
		configKey = "raidPlayerDispellable",
		token = AuraUtil.AuraFilters.RaidPlayerDispellable,
	},
	{
		key = "harmfulDebuffsCrowdControl",
		configKey = "crowdControl",
		token = AuraUtil.AuraFilters.CrowdControl,
	},
}
local DISPELLABLE_GROUP = {
	key = "harmfulDebuffsDispellable",
	configKey = "dispellable",
	candidateFilters = {
		includeDispelTypes = DISPELLABLE_TYPES,
	},
}
local BOSS_OR_ROLE_GROUP = {
	key = "harmfulDebuffsBossOrRole",
	configKey = "bossOrRole",
	candidateFilters = {
		isBossOrRoleAura = true,
	},
}
-- Mirrors what Blizzard raid frames display, via AuraUtil.ProcessAura
-- classification (which defaults to showing harmful debuffs unless spell
-- visibility data hides them). Two groups because processedAuraType matches
-- a single classification and raid frames show both Debuff and Dispel.
local RAID_FRAME_GROUPS = {
	{
		key = "harmfulDebuffsRaidFrame",
		configKey = "raidInCombat",
		processedAuraType = AuraUtil.AuraUpdateChangedType.Debuff,
		candidateFilters = {
			processedAuraType = AuraUtil.AuraUpdateChangedType.Debuff,
		},
	},
	{
		key = "harmfulDebuffsRaidFrameDispel",
		configKey = "raidInCombat",
		processedAuraType = AuraUtil.AuraUpdateChangedType.Dispel,
		candidateFilters = {
			processedAuraType = AuraUtil.AuraUpdateChangedType.Dispel,
		},
	},
}
local TEST_SPELL_IDS = { 25771, 240559, 206151, 209858 }
local TEST_DURATIONS = { "8", "14", "22", "35" }

local durationFormatter
if C_StringUtil and C_StringUtil.CreateNumericRuleFormatter then
	durationFormatter = C_StringUtil.CreateNumericRuleFormatter()
	durationFormatter:SetBreakpoints({
		{
			threshold = 0,
			step = 1,
			rounding = Enum.NumericRuleFormatRounding.Nearest,
			min = 1,
			format = "%d",
		},
		{
			threshold = 60,
			step = 1,
			rounding = Enum.NumericRuleFormatRounding.Nearest,
			format = "%d:%02d",
			components = {
				{ div = 60 },
				{ mod = 60 },
			},
		},
		{
			threshold = 3600,
			step = 1,
			rounding = Enum.NumericRuleFormatRounding.Nearest,
			format = "%d:%02d:%02d",
			components = {
				{ div = 3600 },
				{ div = 60, mod = 60 },
				{ mod = 60 },
			},
		},
	})
end

local frames = M.frames or {}
M.frames = frames
local registeredGroups = {}
local registeredGroupKeys = {}

-- Keep the old global anchor name so existing profiles and other SBM sections
-- anchored to the former Private Auras display continue to resolve.
local auraAnchor = CreateFrame("Frame", ADDON_NAME .. "_PrivateAuras", UIParent)
auraAnchor:SetSize(1, 1)
frames.privateAurasAnchor = auraAnchor

local auraContainer = CreateFrame(
	"AuraContainer",
	ADDON_NAME .. "_BossAuraContainer",
	auraAnchor,
	"CustomAuraContainerTemplate"
)
auraContainer:SetSize(1, 1)
auraContainer:Show()
frames.auraContainer = auraContainer

local function applyAuraFont(fontString, size)
	if not fontString then return end
	fontString:SetFont(
		L.PRIVATE_AURA_FONT_PATH or C.FONT_PATH,
		size,
		L.PRIVATE_AURA_FONT_FLAGS or C.FONT_FLAGS
	)
	if L.PRIVATE_AURA_SHADOW then
		fontString:SetShadowColor(0, 0, 0, 1)
		fontString:SetShadowOffset(1, -1)
	else
		fontString:SetShadowColor(0, 0, 0, 0)
		fontString:SetShadowOffset(0, 0)
	end
end

-- The aura buttons themselves deny addon access whenever aura data is secret
-- (raids, M+), so they are only touched at creation. Everything that has to
-- follow setting changes lives on an addon-owned visual subframe, tracked
-- here so applyAuraDisplay can restyle it at any time.
local createdAuraVisuals = {}

-- A visual subframe hangs off an aura button and inherits its forbidden state,
-- so once Blizzard assigns that button secret aura data every method on the
-- subtree (SetSize, SetFont, texture creation) throws "forbidden object" when
-- called from tainted code. IsForbidden is one of the few methods that stays
-- callable, so it is the gate. Skipped entries keep whatever style they were
-- created with until the container recycles the button through
-- initializeAuraButton, which is the only remaining styling opportunity.
local function isVisualAccessible(entry)
	local visual = entry.visual
	if not visual then return false end
	if visual.IsForbidden and visual:IsForbidden() then return false end
	return true
end

local function styleAuraVisual(entry)
	if not isVisualAccessible(entry) then return end
	entry.visual:SetSize(L.PRIVATE_AURA_SIZE, L.PRIVATE_AURA_SIZE)
	applyAuraFont(entry.durationText, L.PRIVATE_AURA_FONT_SIZE)
	applyAuraFont(entry.countText, math.max(10, math.floor(L.PRIVATE_AURA_FONT_SIZE * 0.55 + 0.5)))
	if M.ensureFullBorder then
		M.ensureFullBorder(entry.visual, L.PRIVATE_AURA_BORDER_THICKNESS, 0, 0, 0, 1)
	end
end

local function initializeAuraButton(frame)
	frame:SetSize(L.PRIVATE_AURA_SIZE, L.PRIVATE_AURA_SIZE)
	frame:SetTooltipAnchorPoint("ANCHOR_RIGHT")

	local visual = CreateFrame("Frame", nil, frame)
	visual:SetPoint("CENTER", frame, "CENTER", 0, 0)

	local icon = visual:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints(visual)
	local zoom = C.ICON_ZOOM or 0
	icon:SetTexCoord(zoom, 1 - zoom, zoom, 1 - zoom)
	frame:SetIcon(icon)

	local cooldown = CreateFrame("Cooldown", nil, visual, "CooldownFrameTemplate")
	cooldown:SetAllPoints(visual)
	cooldown:SetDrawEdge(false)
	if cooldown.SetReverse then
		cooldown:SetReverse(true)
	end
	if cooldown.SetHideCountdownNumbers then
		cooldown:SetHideCountdownNumbers(true)
	end
	cooldown:SetFrameLevel(visual:GetFrameLevel() + 5)
	frame:SetDurationCooldown(cooldown)

	local textOverlay = CreateFrame("Frame", nil, visual)
	textOverlay:SetAllPoints(visual)
	textOverlay:SetFrameLevel(cooldown:GetFrameLevel() + 10)

	local durationText = textOverlay:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	durationText:SetPoint("CENTER", textOverlay, "CENTER", 0, 0)
	durationText:SetTextColor(1, 1, 1, 1)
	durationText:SetJustifyH("CENTER")
	durationText:SetJustifyV("MIDDLE")
	frame:SetDurationText(durationText, {
		textFormatter = durationFormatter,
	})

	local countText = textOverlay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	countText:SetPoint("BOTTOMRIGHT", textOverlay, "BOTTOMRIGHT", -2, 2)
	countText:SetTextColor(1, 1, 1, 1)
	countText:SetJustifyH("RIGHT")
	frame:SetApplicationCount(countText, {})

	local entry = {
		visual = visual,
		durationText = durationText,
		countText = countText,
	}
	createdAuraVisuals[#createdAuraVisuals + 1] = entry
	styleAuraVisual(entry)
end

local function getFlowSettings()
	local direction = L.PRIVATE_AURA_GROW_DIR or "RIGHT_DOWN"
	local horizontal = direction:find("^LEFT") and AnchorUtil.FlowDirection.Left or AnchorUtil.FlowDirection.Right
	local vertical = direction:find("_UP$") and AnchorUtil.FlowDirection.Up or AnchorUtil.FlowDirection.Down
	local anchorPoint

	if horizontal == AnchorUtil.FlowDirection.Left then
		anchorPoint = vertical == AnchorUtil.FlowDirection.Up and "BOTTOMRIGHT" or "TOPRIGHT"
	else
		anchorPoint = vertical == AnchorUtil.FlowDirection.Up and "BOTTOMLEFT" or "TOPLEFT"
	end

	return horizontal, vertical, anchorPoint
end

local containerAnchorPoint
local function updateContainerAnchor()
	local _, _, anchorPoint = getFlowSettings()
	if containerAnchorPoint == anchorPoint then return end

	auraContainer:ClearAllPoints()
	auraContainer:SetPoint(anchorPoint, auraAnchor, anchorPoint, 0, 0)
	containerAnchorPoint = anchorPoint
end

function M:UpdatePrivateAuraAnchorPosition()
	auraAnchor:ClearAllPoints()

	local parent = UIParent
	local parentName = L.PRIVATE_AURA_PARENT_NAME
	if type(parentName) == "string" and parentName ~= "" then
		parent = _G[parentName] or UIParent
	end
	if parent == auraAnchor then
		parent = UIParent
	end

	auraAnchor:SetPoint(
		L.PRIVATE_AURA_ANCHOR_FROM or "TOPLEFT",
		parent,
		L.PRIVATE_AURA_ANCHOR_TO or "BOTTOMLEFT",
		L.PRIVATE_AURA_X or 0,
		(L.PRIVATE_AURA_Y or 0) + C.GLOBAL_Y_NUDGE
	)
end

local function ensureTestAuraFrames()
	if M._testPrivateAuraFrames then
		return M._testPrivateAuraFrames
	end

	local testFrames = {}
	for index, spellID in ipairs(TEST_SPELL_IDS) do
		local frame = CreateFrame("Frame", nil, auraAnchor)
		frame:SetSize(L.PRIVATE_AURA_SIZE, L.PRIVATE_AURA_SIZE)

		local icon = frame:CreateTexture(nil, "ARTWORK")
		icon:SetAllPoints(frame)
		local texture = C_Spell and C_Spell.GetSpellTexture and C_Spell.GetSpellTexture(spellID)
		icon:SetTexture(texture or 134400)
		local zoom = C.ICON_ZOOM or 0
		icon:SetTexCoord(zoom, 1 - zoom, zoom, 1 - zoom)

		local shade = frame:CreateTexture(nil, "ARTWORK", nil, 1)
		shade:SetAllPoints(frame)
		shade:SetColorTexture(0, 0, 0, 0.35)

		local durationText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		durationText:SetPoint("CENTER", frame, "CENTER", 0, 0)
		durationText:SetText(TEST_DURATIONS[index])
		durationText:SetTextColor(1, 1, 1, 1)
		frame.__sbmDurationText = durationText

		frame:Hide()
		testFrames[index] = frame
	end

	M._testPrivateAuraFrames = testFrames
	return testFrames
end

function M:UpdateTestPrivateAuras()
	local testFrames = self._testPrivateAuraFrames
	if not testFrames then return end

	local horizontal, vertical, anchorPoint = getFlowSettings()
	local step = L.PRIVATE_AURA_SIZE + L.PRIVATE_AURA_GAP
	local perRow = L.PRIVATE_AURAS_PER_ROW
	local visibleLimit = L.PRIVATE_AURAS_LIMIT > 0 and L.PRIVATE_AURAS_LIMIT or #testFrames

	for index, frame in ipairs(testFrames) do
		local zeroIndex = index - 1
		local column = zeroIndex % perRow
		local row = math.floor(zeroIndex / perRow)

		frame:SetSize(L.PRIVATE_AURA_SIZE, L.PRIVATE_AURA_SIZE)
		frame:ClearAllPoints()
		frame:SetPoint(
			anchorPoint,
			auraAnchor,
			anchorPoint,
			column * step * horizontal,
			row * step * vertical
		)
		applyAuraFont(frame.__sbmDurationText, L.PRIVATE_AURA_FONT_SIZE)
		if M.ensureFullBorder then
			M.ensureFullBorder(frame, L.PRIVATE_AURA_BORDER_THICKNESS, 0, 0, 0, 1)
		end
		frame:SetShown(self._testActive and L.PRIVATE_AURA_ENABLED and index <= visibleLimit)
	end
end

function M:ShowTestPrivateAuras(show)
	if not show then
		if self._testPrivateAuraFrames then
			for _, frame in ipairs(self._testPrivateAuraFrames) do
				frame:Hide()
			end
		end
		return
	end

	ensureTestAuraFrames()
	self:UpdateTestPrivateAuras()
end

local function makeAuraGroupLayout(size, gap)
	return {
		elementSpacing = gap,
		lineSpacing = gap,
		groupSpacing = gap,
		groupLineSpacing = gap,
		-- Retain the aliases used by earlier 12.1 CustomAuraContainer builds.
		elementSpacingX = gap,
		elementSpacingY = gap,
		elementWidth = size,
		elementHeight = size,
	}
end

local function ensureAuraGroup(group)
	if registeredGroups[group.key] then return end

	auraContainer:AddAuraGroup(
		group.key,
		AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful),
		{
			maxFrameCount = 0,
			candidateFilters = group.candidateFilters,
			sortMethod = AuraContainerSortMethod.ExpirationOnly,
			sortDirection = AuraContainerSortDirection.Normal,
			layout = makeAuraGroupLayout(L.PRIVATE_AURA_SIZE, L.PRIVATE_AURA_GAP),
			initializeFrame = initializeAuraButton,
		}
	)
	registeredGroups[group.key] = true
	registeredGroupKeys[#registeredGroupKeys + 1] = group.key
end

local function makeOrFilterString(token, priorTokens)
	local parts = {
		AuraUtil.AuraFilters.Harmful,
		token,
	}
	for _, priorToken in ipairs(priorTokens) do
		parts[#parts + 1] = AuraUtil.AuraFilterNegationPrefix .. priorToken
	end
	return AuraUtil.CreateFilterString(unpackValues(parts))
end

local function makeNegatedFilterString(priorTokens)
	local parts = {
		AuraUtil.AuraFilters.Harmful,
	}
	for _, priorToken in ipairs(priorTokens) do
		parts[#parts + 1] = AuraUtil.AuraFilterNegationPrefix .. priorToken
	end
	return AuraUtil.CreateFilterString(unpackValues(parts))
end

-- Group registration is deferred to the first applyAuraDisplay so the frame
-- batches each group pre-creates are styled from the saved configuration,
-- which is not loaded yet while this file executes. Anchor the container
-- before registering a group; AddAuraGroup intentionally applies layout
-- restrictions after registration. Register every possible group before
-- assigning a live unit: once player auras have been assigned, Blizzard's
-- secure container owns forbidden frames and late-created groups cannot be
-- relied upon to receive aura assignments.
local containerConfigured = false
local function ensureContainerSetup()
	if containerConfigured then return end
	containerConfigured = true

	updateContainerAnchor()
	-- ProcessAura classification powers the raid-frame groups' candidate
	-- filters; it only adds metadata to parsed auras, so the other groups
	-- are unaffected.
	auraContainer:SetAuraProcessingPolicy(CustomAuraContainerAuraProcessingPolicy.ProcessAura)
	ensureAuraGroup(ALL_DEBUFF_GROUP)
	for _, group in ipairs(RAID_FRAME_GROUPS) do
		ensureAuraGroup(group)
	end
	for _, group in ipairs(TOKEN_FILTER_GROUPS) do
		ensureAuraGroup(group)
	end
	ensureAuraGroup(DISPELLABLE_GROUP)
	ensureAuraGroup(BOSS_OR_ROLE_GROUP)
	auraContainer:SetUnit("player")
end

local function applyAuraDisplay()
	M._privateAuraRefreshPending = nil

	ensureContainerSetup()
	M:UpdatePrivateAuraAnchorPosition()
	updateContainerAnchor()

	local horizontal, vertical, anchorPoint = getFlowSettings()
	local size = L.PRIVATE_AURA_SIZE
	local gap = L.PRIVATE_AURA_GAP
	local perRow = L.PRIVATE_AURAS_PER_ROW
	local maximumLineSize = size * perRow + gap * math.max(0, perRow - 1)
	local maxFrameCount = L.PRIVATE_AURAS_LIMIT > 0 and L.PRIVATE_AURAS_LIMIT or math.huge

	-- Match the working SimpleUnitFrames container lifecycle: give the
	-- container a non-zero layout area before asking its secure OnUpdate
	-- handler to assign aura frames.
	auraContainer:SetSize(math.max(maximumLineSize, 1), math.max(size, 1))
	auraContainer:SetFlowLayoutAxis(AnchorUtil.FlowLayoutAxis.Horizontal)
	auraContainer:SetFlowLayoutAnchorPoint(anchorPoint)
	auraContainer:SetFlowLayoutGrowthDirection(horizontal, vertical)
	auraContainer:SetFlowLayoutMaximumLineSize(maximumLineSize)

	local filters = L.PRIVATE_AURA_FILTERS or {}
	local hasSelectedFilter = false

	local groupLayout = makeAuraGroupLayout(size, gap)
	for _, groupKey in ipairs(registeredGroupKeys) do
		auraContainer:SetAuraGroupLayout(groupKey, groupLayout)
	end

	-- Only the addon-owned visual subframes are restyled here; the buttons
	-- themselves are untouchable outside initializeAuraButton. styleAuraVisual
	-- skips subframes that have gone forbidden, and the loop is pcall-wrapped
	-- on top of that because an error escaping here would abort the group
	-- configuration below and leave every filter disabled.
	local styleOk = pcall(function()
		for _, entry in ipairs(createdAuraVisuals) do
			styleAuraVisual(entry)
		end
	end)
	M._privateAuraStyleBlocked = not styleOk or nil

	auraContainer:SetAuraGroupFilterString(
		ALL_DEBUFF_GROUP.key,
		AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful)
	)

	local priorTokens = {}
	for _, group in ipairs(TOKEN_FILTER_GROUPS) do
		if filters[group.configKey] then
			auraContainer:SetAuraGroupFilterString(
				group.key,
				makeOrFilterString(group.token, priorTokens)
			)
			auraContainer:SetAuraGroupMaxFrameCount(group.key, maxFrameCount)
			priorTokens[#priorTokens + 1] = group.token
			hasSelectedFilter = true
		else
			auraContainer:SetAuraGroupMaxFrameCount(group.key, 0)
		end
	end

	-- The candidate-based groups all share the token-negated HARMFUL string
	-- and exclude one another's domains through candidate filters, so enabled
	-- categories combine as a union without showing the same aura twice.
	local negatedFilterString = makeNegatedFilterString(priorTokens)
	local dispellableOn = filters[DISPELLABLE_GROUP.configKey] and true or false
	local bossOrRoleOn = filters[BOSS_OR_ROLE_GROUP.configKey] and true or false
	local raidFrameOn = filters[RAID_FRAME_GROUPS[1].configKey] and true or false

	if dispellableOn then
		auraContainer:SetAuraGroupFilterString(DISPELLABLE_GROUP.key, negatedFilterString)
		auraContainer:SetAuraGroupCandidateFilters(DISPELLABLE_GROUP.key, {
			includeDispelTypes = DISPELLABLE_TYPES,
		})
		auraContainer:SetAuraGroupMaxFrameCount(DISPELLABLE_GROUP.key, maxFrameCount)
		hasSelectedFilter = true
	else
		auraContainer:SetAuraGroupMaxFrameCount(DISPELLABLE_GROUP.key, 0)
	end

	if bossOrRoleOn then
		local candidates = { isBossOrRoleAura = true }
		if dispellableOn then
			candidates.excludeDispelTypes = DISPELLABLE_TYPES
		end
		auraContainer:SetAuraGroupFilterString(BOSS_OR_ROLE_GROUP.key, negatedFilterString)
		auraContainer:SetAuraGroupCandidateFilters(BOSS_OR_ROLE_GROUP.key, candidates)
		auraContainer:SetAuraGroupMaxFrameCount(BOSS_OR_ROLE_GROUP.key, maxFrameCount)
		hasSelectedFilter = true
	else
		auraContainer:SetAuraGroupMaxFrameCount(BOSS_OR_ROLE_GROUP.key, 0)
	end

	for index, group in ipairs(RAID_FRAME_GROUPS) do
		-- The Dispel classification is fully covered by the dispellable group
		-- when both filters are enabled.
		local active = raidFrameOn and not (index == 2 and dispellableOn)
		if active then
			local candidates = { processedAuraType = group.processedAuraType }
			if bossOrRoleOn then
				candidates.isBossOrRoleAura = false
			end
			if dispellableOn then
				candidates.excludeDispelTypes = DISPELLABLE_TYPES
			end
			auraContainer:SetAuraGroupFilterString(group.key, negatedFilterString)
			auraContainer:SetAuraGroupCandidateFilters(group.key, candidates)
			auraContainer:SetAuraGroupMaxFrameCount(group.key, maxFrameCount)
			hasSelectedFilter = true
		else
			auraContainer:SetAuraGroupMaxFrameCount(group.key, 0)
		end
	end

	-- Switch away from the catch-all group only after every selected group is
	-- fully configured. Aura frames become forbidden after Blizzard assigns
	-- them, so they must only be styled by initializeAuraButton at creation;
	-- attempting to restyle owned frames here aborts the refresh and would
	-- otherwise leave every group disabled.
	auraContainer:SetAuraGroupMaxFrameCount(
		ALL_DEBUFF_GROUP.key,
		hasSelectedFilter and 0 or maxFrameCount
	)

	auraContainer:SetUnit("player")
	auraContainer:SetEnabled(L.PRIVATE_AURA_ENABLED)
	auraContainer:SetShown(L.PRIVATE_AURA_ENABLED)
	if L.PRIVATE_AURA_ENABLED then
		auraContainer:UpdateAllAuras()
	end
	if M._testActive then
		M:ShowTestPrivateAuras(L.PRIVATE_AURA_ENABLED)
	end
end

function M:UpdatePrivateAuraDisplay()
	if InCombatLockdown and InCombatLockdown() then
		self._privateAuraRefreshPending = true
		return
	end
	applyAuraDisplay()
end

-- /sbm auras: report what the C-side aura queries return for each filter the
-- display uses, independent of the secure container, to tell data-layer
-- failures (query returns nothing) apart from container failures.
function M:DebugAuraFilters()
	local function queryCount(filterString)
		local ok, result = pcall(C_UnitAuras.GetUnitAuraInstanceIDs, "player", filterString)
		if not ok then
			return "|cffff3333ERROR: " .. tostring(result) .. "|r"
		end
		local countOk, count = pcall(function() return #result end)
		return countOk and tostring(count) or "|cffff9933secret|r"
	end

	local filters = L.PRIVATE_AURA_FILTERS or {}
	print("|cff33ff99SBM aura filter debug|r")
	print(("  container: enabled=%s shown=%s unit=%s limit=%s pendingCombatRefresh=%s"):format(
		tostring(auraContainer:IsEnabled()),
		tostring(auraContainer:IsShown()),
		tostring(auraContainer:GetUnit()),
		tostring(L.PRIVATE_AURAS_LIMIT),
		tostring(self._privateAuraRefreshPending or false)
	))
	print(("  baseline HARMFUL -> %s aura(s)"):format(
		queryCount(AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful))
	))

	-- Forbidden visuals are frames whose button holds secret aura data: they
	-- render fine but keep the size/font they were created with.
	local styleable, forbidden = 0, 0
	for _, entry in ipairs(createdAuraVisuals) do
		if isVisualAccessible(entry) then
			styleable = styleable + 1
		else
			forbidden = forbidden + 1
		end
	end
	print(("  visuals: styleable=%d forbidden=%d lastStyleBlocked=%s"):format(
		styleable,
		forbidden,
		tostring(self._privateAuraStyleBlocked or false)
	))

	local priorTokens = {}
	for _, group in ipairs(TOKEN_FILTER_GROUPS) do
		local selected = filters[group.configKey] and true or false
		local singleString = AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful, group.token)
		local line = ("  %s %s: %s -> %s"):format(
			selected and "|cff00ff00[on]|r" or "[off]",
			group.configKey,
			singleString,
			queryCount(singleString)
		)
		if selected then
			local combinedString = makeOrFilterString(group.token, priorTokens)
			if combinedString ~= singleString then
				line = line .. (" | applied: %s -> %s"):format(combinedString, queryCount(combinedString))
			end
			priorTokens[#priorTokens + 1] = group.token
		end
		print(line .. (" (frames created: %d)"):format(auraContainer:GetAuraGroupFrameCount(group.key)))
	end

	local negatedString = makeNegatedFilterString(priorTokens)
	local function printCandidateGroup(label, configKey, groupKey, note)
		print(("  %s %s: %s -> %s, then container-side %s (frames created: %d)"):format(
			filters[configKey] and "|cff00ff00[on]|r" or "[off]",
			label,
			negatedString,
			queryCount(negatedString),
			note,
			auraContainer:GetAuraGroupFrameCount(groupKey)
		))
	end
	printCandidateGroup("dispellable", DISPELLABLE_GROUP.configKey, DISPELLABLE_GROUP.key, "dispel-type check")
	printCandidateGroup("bossOrRole", BOSS_OR_ROLE_GROUP.configKey, BOSS_OR_ROLE_GROUP.key, "isBossOrRoleAura check")
	printCandidateGroup("raidFrame", RAID_FRAME_GROUPS[1].configKey, RAID_FRAME_GROUPS[1].key, "ProcessAura classification")
	print(("  catch-all frames created: %d (active when no filter is selected)"):format(
		auraContainer:GetAuraGroupFrameCount(ALL_DEBUFF_GROUP.key)
	))

	local function enumName(enumTable, value)
		for name, enumValue in pairs(enumTable) do
			if enumValue == value then
				return name
			end
		end
		return tostring(value)
	end

	local ok, auraInstanceIDs = pcall(
		C_UnitAuras.GetUnitAuraInstanceIDs,
		"player",
		AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful)
	)
	if ok and auraInstanceIDs then
		for _, auraInstanceID in ipairs(auraInstanceIDs) do
			local lineOk, line = pcall(function()
				local aura = C_UnitAuras.GetAuraDataByAuraInstanceID("player", auraInstanceID)
				if not aura then return nil end
				return ("    %s (spell %s): dispel=%s boss=%s role=%s processed=%s"):format(
					tostring(aura.name),
					tostring(aura.spellId),
					tostring(aura.dispelName),
					tostring(aura.isBossAura),
					tostring(AuraUtil.IsRoleAura(aura)),
					enumName(AuraUtil.AuraUpdateChangedType, AuraUtil.ProcessAura(aura, false, false, false, false))
				)
			end)
			if lineOk and line then
				print(line)
			elseif not lineOk then
				print("    (aura data restricted)")
			end
		end
	end
end

local refreshDriver = CreateFrame("Frame")
refreshDriver:RegisterEvent("PLAYER_ENTERING_WORLD")
refreshDriver:RegisterEvent("PLAYER_REGEN_ENABLED")
refreshDriver:RegisterEvent("PLAYER_REGEN_DISABLED")
refreshDriver:SetScript("OnEvent", function(_, event)
	if event == "PLAYER_ENTERING_WORLD" or (event == "PLAYER_REGEN_ENABLED" and M._privateAuraRefreshPending) then
		M:UpdatePrivateAuraDisplay()
	elseif L.PRIVATE_AURA_ENABLED then
		-- Spell visibility (and so ProcessAura classification) differs in and
		-- out of combat without an accompanying UNIT_AURA update.
		auraContainer:UpdateAllAuras()
	end
end)
