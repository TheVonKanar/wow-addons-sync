-- SimpleBossMods UI helpers: frames, borders, indicators, pools.

local ADDON_NAME = ...
local M = _G[ADDON_NAME]
if not M then return end

local C = M.Const
local L = M.Live
local U = M.Util

-- =========================
-- UI Roots
-- =========================
local frames = M.frames or {}
M.frames = frames

local iconsParent = CreateFrame("Frame", ADDON_NAME .. "_Icons", UIParent)
iconsParent:SetSize(1, 1)
frames.iconsParent = iconsParent

local barsParent = CreateFrame("Frame", ADDON_NAME .. "_Bars", UIParent)
barsParent:SetSize(1, 1)
frames.barsParent = barsParent

local function applyAnchorToFrame(frame, parentNameKey, fromKey, toKey, xKey, yKey, defaultFrom, defaultTo)
	frame:ClearAllPoints()
	local parent = UIParent
	local pName = L[parentNameKey]
	if type(pName) == "string" and pName ~= "" then
		parent = _G[pName] or UIParent
	end
	frame:SetPoint(
		L[fromKey] or defaultFrom,
		parent,
		L[toKey] or defaultTo,
		L[xKey] or 0,
		(L[yKey] or 0) + C.GLOBAL_Y_NUDGE
	)
end

function M:UpdateIconsAnchorPosition()
	if not iconsParent then return end
	applyAnchorToFrame(iconsParent, "ICON_PARENT_NAME", "ICON_ANCHOR_FROM", "ICON_ANCHOR_TO", "ICON_ANCHOR_X", "ICON_ANCHOR_Y", "TOPLEFT", "CENTER")
end

function M:UpdateBarsAnchorPosition()
	if not barsParent then return end
	applyAnchorToFrame(barsParent, "BAR_PARENT_NAME", "BAR_ANCHOR_FROM", "BAR_ANCHOR_TO", "BAR_ANCHOR_X", "BAR_ANCHOR_Y", "BOTTOMLEFT", "TOPLEFT")
end

local COMBAT_TIMER_PAD_X = 8
local COMBAT_TIMER_PAD_Y = 4
local COMBAT_TIMER_BORDER_THICKNESS = 1

local combatTimerFrame = CreateFrame("Frame", ADDON_NAME .. "_CombatTimer", UIParent)
combatTimerFrame:SetSize(1, 1)
do
	local parent = UIParent
	local parentName = L.COMBAT_TIMER_PARENT_NAME
	if type(parentName) == "string" and parentName ~= "" then
		parent = _G[parentName] or UIParent
	end
	combatTimerFrame:SetPoint(
		L.COMBAT_TIMER_ANCHOR_FROM or "CENTER",
		parent,
		L.COMBAT_TIMER_ANCHOR_TO or "CENTER",
		L.COMBAT_TIMER_X,
		(L.COMBAT_TIMER_Y or 0) + C.GLOBAL_Y_NUDGE
	)
end
combatTimerFrame:Hide()
frames.combatTimerFrame = combatTimerFrame

local combatTimerBg = combatTimerFrame:CreateTexture(nil, "BACKGROUND")
combatTimerBg:SetAllPoints()
combatTimerFrame.bg = combatTimerBg

local combatTimerText = combatTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
combatTimerText:SetPoint("CENTER", combatTimerFrame, "CENTER", 0, 0)
combatTimerFrame.text = combatTimerText

M:UpdateIconsAnchorPosition()
M:UpdateBarsAnchorPosition()

local function formatCombatTimer(secs)
	if not secs or secs < 0 then secs = 0 end
	local minutes = math.floor(secs / 60)
	local seconds = math.floor(secs % 60)
	return string.format("%02d:%02d", minutes, seconds)
end

local function updateCombatTimerSize()
	local w = combatTimerText:GetStringWidth() or 0
	local h = combatTimerText:GetStringHeight() or 0
	combatTimerFrame:SetSize(math.max(1, w + COMBAT_TIMER_PAD_X * 2), math.max(1, h + COMBAT_TIMER_PAD_Y * 2))
end

local function setCombatTimerText(seconds)
	local text = formatCombatTimer(seconds)
	if combatTimerFrame._lastText == text then return end
	combatTimerFrame._lastText = text
	combatTimerText:SetText(text)
	updateCombatTimerSize()
end

local function combatTimerOnUpdate()
	if not M._combatStartTime then return end
	local secs = GetTime() - M._combatStartTime
	if secs < 0 then secs = 0 end
	local whole = math.floor(secs)
	if combatTimerFrame._lastSeconds == whole then return end
	combatTimerFrame._lastSeconds = whole
	setCombatTimerText(whole)
end

-- =========================
-- Combat timer
-- =========================
function M:UpdateCombatTimerAppearance()
	if not combatTimerFrame then return end
	combatTimerText:SetFont(L.COMBAT_TIMER_FONT_PATH or L.FONT_PATH or C.FONT_PATH, L.COMBAT_TIMER_FONT_SIZE or 16, C.FONT_FLAGS)
	combatTimerText:SetTextColor(L.COMBAT_TIMER_COLOR_R or 1, L.COMBAT_TIMER_COLOR_G or 1, L.COMBAT_TIMER_COLOR_B or 1, L.COMBAT_TIMER_COLOR_A or 1)
	combatTimerBg:SetColorTexture(L.COMBAT_TIMER_BG_R or 0, L.COMBAT_TIMER_BG_G or 0, L.COMBAT_TIMER_BG_B or 0, L.COMBAT_TIMER_BG_A or 1)
	combatTimerFrame:ClearAllPoints()
	local parent = UIParent
	local parentName = L.COMBAT_TIMER_PARENT_NAME
	if type(parentName) == "string" and parentName ~= "" then
		parent = _G[parentName] or UIParent
	end
	combatTimerFrame:SetPoint(
		L.COMBAT_TIMER_ANCHOR_FROM or "CENTER",
		parent,
		L.COMBAT_TIMER_ANCHOR_TO or "CENTER",
		L.COMBAT_TIMER_X or 0,
		(L.COMBAT_TIMER_Y or 0) + C.GLOBAL_Y_NUDGE
	)
	if M.ensureFullBorder then
		M.ensureFullBorder(combatTimerFrame, COMBAT_TIMER_BORDER_THICKNESS, L.COMBAT_TIMER_BORDER_R or 0, L.COMBAT_TIMER_BORDER_G or 0, L.COMBAT_TIMER_BORDER_B or 0, L.COMBAT_TIMER_BORDER_A or 1)
	end
	updateCombatTimerSize()
end

function M:StartCombatTimer(reset)
	if not L.COMBAT_TIMER_ENABLED then return end
	if reset or not self._combatStartTime then
		self._combatStartTime = GetTime()
	end
	combatTimerFrame._lastSeconds = nil
	setCombatTimerText(math.floor((GetTime() - self._combatStartTime) or 0))
	combatTimerFrame:SetScript("OnUpdate", combatTimerOnUpdate)
	combatTimerFrame:Show()
end

function M:StopCombatTimer()
	if combatTimerFrame then
		combatTimerFrame:SetScript("OnUpdate", nil)
		combatTimerFrame:Hide()
		combatTimerFrame._lastSeconds = nil
	end
	self._combatStartTime = nil
end

function M:UpdateCombatTimerState()
	if not L.COMBAT_TIMER_ENABLED then
		self:StopCombatTimer()
		return
	end
	if InCombatLockdown and InCombatLockdown() then
		self:StartCombatTimer(false)
	else
		self:StopCombatTimer()
	end
end

-- =========================
-- Border system (ALWAYS on top)
-- =========================
local function ensureBorderFrame(owner)
	if owner.__borderFrame then return owner.__borderFrame end
	local bf = CreateFrame("Frame", nil, owner)
	bf:SetAllPoints(owner)
	bf:SetFrameLevel(owner:GetFrameLevel() + 200)
	owner.__borderFrame = bf
	return bf
end

local function ensureFullBorder(owner, thickness, r, g, b, a)
	local bf = ensureBorderFrame(owner)
	local function setColor(border)
		local cr = r or 0
		local cg = g or 0
		local cb = b or 0
		local ca = a or 1
		border.top:SetVertexColor(cr, cg, cb, ca)
		border.bot:SetVertexColor(cr, cg, cb, ca)
		border.left:SetVertexColor(cr, cg, cb, ca)
		border.right:SetVertexColor(cr, cg, cb, ca)
	end

	if bf.__fullBorder then
		local t = thickness or 1
		bf.__fullBorder.top:SetHeight(t)
		bf.__fullBorder.bot:SetHeight(t)
		bf.__fullBorder.left:SetWidth(t)
		bf.__fullBorder.right:SetWidth(t)
		if r ~= nil or g ~= nil or b ~= nil or a ~= nil then
			setColor(bf.__fullBorder)
		end
		return
	end

	local t = thickness or 1
	local function line()
		local tex = bf:CreateTexture(nil, "OVERLAY")
		tex:SetColorTexture(1, 1, 1, 1)
		return tex
	end

	local top = line()
	top:SetPoint("TOPLEFT", 0, 0)
	top:SetPoint("TOPRIGHT", 0, 0)
	top:SetHeight(t)

	local bot = line()
	bot:SetPoint("BOTTOMLEFT", 0, 0)
	bot:SetPoint("BOTTOMRIGHT", 0, 0)
	bot:SetHeight(t)

	local left = line()
	left:SetPoint("TOPLEFT", 0, 0)
	left:SetPoint("BOTTOMLEFT", 0, 0)
	left:SetWidth(t)

	local right = line()
	right:SetPoint("TOPRIGHT", 0, 0)
	right:SetPoint("BOTTOMRIGHT", 0, 0)
	right:SetWidth(t)

	bf.__fullBorder = { top = top, bot = bot, left = left, right = right }
	setColor(bf.__fullBorder)
end

local function ensureDivider(owner, thickness, fieldKey, topAnchor, botAnchor)
	local bf = ensureBorderFrame(owner)

	if bf[fieldKey] then
		bf[fieldKey]:SetWidth(thickness or 1)
		return
	end

	local t = thickness or 1
	local div = bf:CreateTexture(nil, "OVERLAY")
	div:SetColorTexture(0, 0, 0, 1)
	div:SetPoint(topAnchor, owner, topAnchor, 0, 0)
	div:SetPoint(botAnchor, owner, botAnchor, 0, 0)
	div:SetWidth(t)

	bf[fieldKey] = div
end

local function ensureRightDivider(owner, thickness)
	ensureDivider(owner, thickness, "__rightDivider", "TOPRIGHT", "BOTTOMRIGHT")
end

local function ensureLeftDivider(owner, thickness)
	ensureDivider(owner, thickness, "__leftDivider", "TOPLEFT", "BOTTOMLEFT")
end

M.ensureFullBorder = ensureFullBorder
M.ensureRightDivider = ensureRightDivider
M.ensureLeftDivider = ensureLeftDivider

-- =========================
-- Indicator helpers
-- =========================
local function ensureIndicatorTextures(containerFrame, count)
	containerFrame.__indicatorTextures = containerFrame.__indicatorTextures or {}
	local t = containerFrame.__indicatorTextures
	for i = #t + 1, count do
		local tex = containerFrame:CreateTexture(nil, "OVERLAY")
		tex:Hide()
		t[i] = tex
	end
	return t
end

local function layoutIconIndicators(iconFrame, textures)
	-- bottom-right inside icon, 2x3 grid (usually you won't have all)
	local s = U.iconIndicatorSize()
	local gap = U.clamp(math.floor(s * 0.12 + 0.5) + 1, 2, 4)
	local mirror = L.ICON_GROW_DIR == "LEFT_DOWN" or L.ICON_GROW_DIR == "LEFT_UP"

	-- Place as:
	-- [4][5][6]
	-- [1][2][3]  (bottom row)
	-- anchored bottom-right
	for i = 1, C.INDICATOR_MAX do
		local tex = textures[i]
		tex:SetSize(s, s)

		local idx = i - 1
		local col = idx % 3
		local row = math.floor(idx / 3) -- 0 or 1

		local x = col * (s + gap)
		local y =  (row * (s + gap))

		tex:ClearAllPoints()
		if mirror then
			tex:SetPoint("BOTTOMLEFT", iconFrame.main, "BOTTOMLEFT", 3 + x, 3 + y)
		else
			tex:SetPoint("BOTTOMRIGHT", iconFrame.main, "BOTTOMRIGHT", -3 - x, 3 + y)
		end
	end
end

local function layoutBarIndicators(barFrame, textures)
	local size = U.barIndicatorSize()
	local gap = 3
	local totalW = C.INDICATOR_MAX * size + (C.INDICATOR_MAX - 1) * gap
	local mirror = L.BAR_INDICATOR_ON_LEFT
	if mirror == nil then
		mirror = L.BAR_FILL_REVERSE
		if L.BAR_INDICATOR_SWAP then
			mirror = not mirror
		end
	end
	barFrame.endIndicatorsFrame:SetWidth(totalW)

	for i = 1, C.INDICATOR_MAX do
		local tex = textures[i]
		local x = (i - 1) * (size + gap)
		tex:ClearAllPoints()
		tex:SetSize(size, size)
		if mirror then
			tex:SetPoint("RIGHT", barFrame.endIndicatorsFrame, "RIGHT", -x, 0)
		else
			tex:SetPoint("LEFT", barFrame.endIndicatorsFrame, "LEFT", x, 0)
		end
	end
end

M.ensureIndicatorTextures = ensureIndicatorTextures
M.layoutIconIndicators = layoutIconIndicators
M.layoutBarIndicators = layoutBarIndicators

-- =========================
-- Secure indicator API wrapper
-- =========================
local function safeSetEventIconTextures(eventID, mask, textures)
	if not (C_EncounterTimeline and C_EncounterTimeline.SetEventIconTextures) then return false end
	local ok = pcall(C_EncounterTimeline.SetEventIconTextures, eventID, mask, textures)
	return ok
end

local function applyIndicatorsToIconFrame(iconFrame, eventID)
	if not iconFrame or not iconFrame.indicatorsFrame then return end
	local idType = type(eventID)
	if idType ~= "number" and idType ~= "string" then return end

	local textures = ensureIndicatorTextures(iconFrame.indicatorsFrame, C.INDICATOR_MAX)
	for i = 1, C.INDICATOR_MAX do
		local tex = textures[i]
		tex:ClearAllPoints()
		tex:SetSize(1, 1)
		tex:Show()
	end

	if not safeSetEventIconTextures(eventID, C.INDICATOR_MASK, textures) then
		for i = 1, C.INDICATOR_MAX do textures[i]:Hide() end
		return
	end

	layoutIconIndicators(iconFrame, textures)
end

local function applyIndicatorsToBarEnd(barFrame, eventID)
	if not barFrame or not barFrame.endIndicatorsFrame then return end
	if L.BAR_INDICATOR_HIDDEN then
		if barFrame.endIndicatorsFrame.__indicatorTextures then
			for _, tex in ipairs(barFrame.endIndicatorsFrame.__indicatorTextures) do
				tex:Hide()
			end
		end
		barFrame.endIndicatorsFrame:SetWidth(1)
		return
	end
	local idType = type(eventID)
	if idType ~= "number" and idType ~= "string" then return end

	local textures = ensureIndicatorTextures(barFrame.endIndicatorsFrame, C.INDICATOR_MAX)

	for i = 1, C.INDICATOR_MAX do
		local tex = textures[i]
		tex:ClearAllPoints()
		tex:SetSize(1, 1)
		tex:Show()
	end

	if not safeSetEventIconTextures(eventID, C.INDICATOR_MASK, textures) then
		for i = 1, C.INDICATOR_MAX do textures[i]:Hide() end
		barFrame.endIndicatorsFrame:SetWidth(1)
		return
	end

	layoutBarIndicators(barFrame, textures)
end

M.applyIndicatorsToIconFrame = applyIndicatorsToIconFrame
M.applyIndicatorsToBarEnd = applyIndicatorsToBarEnd

local function applyBarMirror(f)
	if not f then return end

	local iconOnRight = false
	if L.BAR_ICON_SWAP then
		iconOnRight = not iconOnRight
	end
	local iconVisible = not L.BAR_ICON_HIDDEN

	f.leftFrame:SetWidth(iconVisible and L.BAR_HEIGHT or 0)
	f.leftFrame:SetShown(iconVisible)
	f.iconFrame:SetSize(iconVisible and L.BAR_HEIGHT or 0, iconVisible and L.BAR_HEIGHT or 0)
	f.iconFrame:SetShown(iconVisible)

	f.leftFrame:ClearAllPoints()
	if iconOnRight then
		f.leftFrame:SetPoint("RIGHT", f, "RIGHT", 0, 0)
		f.leftFrame:SetPoint("TOP", f, "TOP", 0, 0)
		f.leftFrame:SetPoint("BOTTOM", f, "BOTTOM", 0, 0)
		ensureLeftDivider(f.leftFrame, L.BAR_BORDER_THICKNESS)
	else
		f.leftFrame:SetPoint("LEFT", f, "LEFT", 0, 0)
		f.leftFrame:SetPoint("TOP", f, "TOP", 0, 0)
		f.leftFrame:SetPoint("BOTTOM", f, "BOTTOM", 0, 0)
		ensureRightDivider(f.leftFrame, L.BAR_BORDER_THICKNESS)
	end
	if f.leftFrame.__borderFrame then
		if f.leftFrame.__borderFrame.__rightDivider then
			f.leftFrame.__borderFrame.__rightDivider:SetShown(iconVisible and not iconOnRight)
		end
		if f.leftFrame.__borderFrame.__leftDivider then
			f.leftFrame.__borderFrame.__leftDivider:SetShown(iconVisible and iconOnRight)
		end
	end

	f.sb:ClearAllPoints()
	if iconVisible then
		if iconOnRight then
			f.sb:SetPoint("RIGHT", f.leftFrame, "LEFT", 0, 0)
			f.sb:SetPoint("LEFT", f, "LEFT", 0, 0)
		else
			f.sb:SetPoint("LEFT", f.leftFrame, "RIGHT", 0, 0)
			f.sb:SetPoint("RIGHT", f, "RIGHT", 0, 0)
		end
	else
		f.sb:SetPoint("LEFT", f, "LEFT", 0, 0)
		f.sb:SetPoint("RIGHT", f, "RIGHT", 0, 0)
	end
	f.sb:SetPoint("TOP", f, "TOP", 0, 0)
	f.sb:SetPoint("BOTTOM", f, "BOTTOM", 0, 0)

	if f.sb.SetReverseFill then
		f.sb:SetReverseFill(L.BAR_FILL_REVERSE)
	elseif f.sb.SetReverse then
		f.sb:SetReverse(L.BAR_FILL_REVERSE)
	end

	if f.endIndicatorsFrame then
		local indicatorOnLeft = L.BAR_INDICATOR_ON_LEFT
		if indicatorOnLeft == nil then
			indicatorOnLeft = L.BAR_FILL_REVERSE
			if L.BAR_INDICATOR_SWAP then
				indicatorOnLeft = not indicatorOnLeft
			end
		end
		local indicatorsVisible = not L.BAR_INDICATOR_HIDDEN
		f.endIndicatorsFrame:SetShown(indicatorsVisible)
		if not indicatorsVisible then
			if f.endIndicatorsFrame.__indicatorTextures then
				for _, tex in ipairs(f.endIndicatorsFrame.__indicatorTextures) do
					tex:Hide()
				end
			end
			f.endIndicatorsFrame:SetWidth(1)
		else
			f.endIndicatorsFrame:ClearAllPoints()
			if indicatorOnLeft then
				f.endIndicatorsFrame:SetPoint("RIGHT", f, "LEFT", -C.BAR_END_INDICATOR_GAP_X, 0)
			else
				f.endIndicatorsFrame:SetPoint("LEFT", f, "RIGHT", C.BAR_END_INDICATOR_GAP_X, 0)
			end
			f.endIndicatorsFrame:SetPoint("TOP", f, "TOP", 0, 0)
			f.endIndicatorsFrame:SetPoint("BOTTOM", f, "BOTTOM", 0, 0)
		end
	end

	if f.txt then
		f.txt:ClearAllPoints()
		if L.BAR_FILL_REVERSE then
			f.txt:SetPoint("RIGHT", f.sb, "RIGHT", -6, 0)
			f.txt:SetJustifyH("RIGHT")
		else
			f.txt:SetPoint("LEFT", f.sb, "LEFT", 6, 0)
			f.txt:SetJustifyH("LEFT")
		end
	end
	if f.rt then
		f.rt:ClearAllPoints()
		if L.BAR_FILL_REVERSE then
			f.rt:SetPoint("LEFT", f.sb, "LEFT", 6, 0)
			f.rt:SetJustifyH("LEFT")
		else
			f.rt:SetPoint("RIGHT", f.sb, "RIGHT", -6, 0)
			f.rt:SetJustifyH("RIGHT")
		end
	end
end

M.applyBarMirror = applyBarMirror

-- =========================
-- Bar fill
-- =========================

-- Applies the configured background to a bar's base texture. In match mode
-- the base is opaque black; the fill-colored tint layered on top of it in
-- setBarFillFlat then renders as a darkened copy of the fill color.
local function applyBarBackground(f)
	if not f or not f.bg then return end
	if L.BAR_BG_MATCH then
		f.bg:SetColorTexture(0, 0, 0, 1)
		f.bg:SetAlpha(L.BAR_BG_BASE_ALPHA)
	else
		f.bg:SetColorTexture(L.BAR_BG_R, L.BAR_BG_G, L.BAR_BG_B, 1)
		f.bg:SetAlpha(L.BAR_BG_A)
		if f.bgTint then
			f.bgTint:Hide()
		end
	end
end

M.applyBarBackground = applyBarBackground

local function setBarFillFlat(barFrame, r, g, b, a)
	if not barFrame or not barFrame.sb then return end
	local texPath = L.BAR_TEX or C.BAR_TEX_DEFAULT or "Interface\\Buttons\\WHITE8X8"
	local aa = a or 1
	local tintKey = L.BAR_BG_MATCH and L.BAR_BG_TINT_ALPHA or false
	local hasSecret = type(issecretvalue) == "function" and (
		issecretvalue(r) or issecretvalue(g) or issecretvalue(b) or issecretvalue(aa)
	)
	if not hasSecret then
		if barFrame.__sbmBarTex == texPath
			and barFrame.__sbmBarR == r
			and barFrame.__sbmBarG == g
			and barFrame.__sbmBarB == b
			and barFrame.__sbmBarA == aa
			and barFrame.__sbmBarTint == tintKey
			and barFrame.sbTex then
			return
		end
		barFrame.__sbmBarTex = texPath
		barFrame.__sbmBarR = r
		barFrame.__sbmBarG = g
		barFrame.__sbmBarB = b
		barFrame.__sbmBarA = aa
		barFrame.__sbmBarTint = tintKey
	else
		barFrame.__sbmBarTex = nil
		barFrame.__sbmBarR = nil
		barFrame.__sbmBarG = nil
		barFrame.__sbmBarB = nil
		barFrame.__sbmBarA = nil
		barFrame.__sbmBarTint = nil
	end

	barFrame.sb:SetStatusBarTexture(texPath)
	local tex = barFrame.sb:GetStatusBarTexture()
	barFrame.sbTex = tex
	barFrame.sb:SetStatusBarColor(r, g, b, aa)
	if tex then
		tex:SetDrawLayer("ARTWORK")
		tex:SetVertexColor(r, g, b, aa)
	end

	local bgTint = barFrame.bgTint
	if bgTint then
		if L.BAR_BG_MATCH then
			-- The fill color may be secret; SetVertexColor accepts it while
			-- the fixed alpha does the darkening via compositing.
			bgTint:SetVertexColor(r, g, b, L.BAR_BG_TINT_ALPHA)
			bgTint:Show()
		else
			bgTint:Hide()
		end
	end
end

M.setBarFillFlat = setBarFillFlat

-- =========================
-- Tooltips
-- =========================
local isSecretValue = U.isSecretValue

local function getEventRecordFromFrame(frame)
	if not frame then return nil end
	local id = frame.__id
	if not id and frame.__owner and frame.__owner.__id then
		id = frame.__owner.__id
	end
	if not id then return nil end
	if not M.events then return nil end
	return M.events[id]
end

local function trySetSpellTooltip(spellID)
	if not GameTooltip then return false end
	if isSecretValue(spellID) then
		if not GameTooltip.SetSpellByID then return false end
		local ok, result = pcall(GameTooltip.SetSpellByID, GameTooltip, spellID)
		return ok and result ~= false
	end

	local numeric = tonumber(spellID)
	if type(numeric) ~= "number" or numeric <= 0 then
		return false
	end

	if GameTooltip.SetSpellByID then
		local ok, result = pcall(GameTooltip.SetSpellByID, GameTooltip, numeric)
		if ok and result ~= false then
			return true
		end
	end

	if GameTooltip.SetHyperlink then
		local linkID = math.floor(numeric + 0.5)
		local ok = pcall(GameTooltip.SetHyperlink, GameTooltip, "spell:" .. tostring(linkID))
		if ok then
			return true
		end
	end

	return false
end

local function parseTooltipSpellID(value)
	if isSecretValue(value) then
		-- Never index or pattern-match secret strings; return as-is and let secure API handle it.
		return value
	end

	if type(value) == "number" then
		if value > 0 then
			return value
		end
		return nil
	end

	if type(value) ~= "string" then
		return nil
	end

	local trimmed = value:match("^%s*(.-)%s*$")
	if trimmed == "" then
		return nil
	end

	local numeric = tonumber(trimmed)
	if numeric and numeric > 0 then
		return numeric
	end

	numeric = tonumber(trimmed:match("^spell:(%d+)$"))
		or tonumber(trimmed:match("^Timer(%d+)"))
		or tonumber(trimmed:match("^Timerej(%d+)"))
		or tonumber(trimmed:match("^ej(%d+)$"))
	if numeric and numeric > 0 then
		return numeric
	end

	return nil
end

local function showEventTooltip(self)
	if not GameTooltip then return end
	local rec = getEventRecordFromFrame(self)
	if not rec then return end
	if type(GameTooltip_SetDefaultAnchor) == "function" then
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
	else
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
	end

	local eventInfo = rec.eventInfo
	local usedSpell = false
	if eventInfo then
		local parsedSpellID = parseTooltipSpellID(eventInfo.spellID)
		if parsedSpellID ~= nil then
			usedSpell = trySetSpellTooltip(parsedSpellID)
		end
	end

	if not usedSpell then
		local label = eventInfo and U.safeGetLabel(eventInfo) or nil
		if isSecretValue(label) then
			label = nil
		end
		if not label or label == "" then
			if type(rec.id) == "number" then
				label = "Event " .. tostring(rec.id)
			else
				label = "Ability"
			end
		end
		GameTooltip:SetText(label or "Ability", 1, 1, 1, 1, true)
	end
	GameTooltip:Show()
end

local function hideEventTooltip(self)
	if not GameTooltip then return end
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end

local iconTooltipOnEnter = showEventTooltip
local barIconTooltipOnEnter = showEventTooltip
local barTooltipOnEnter = showEventTooltip

-- =========================
-- Pools
-- =========================
local pools = M.pools or { icon = {}, bar = {} }
M.pools = pools

local iconPool = pools.icon
local barPool = pools.bar
local tooltipMousePending = M.tooltipMousePending or setmetatable({}, { __mode = "k" })
M.tooltipMousePending = tooltipMousePending

local function applyFont(fs, path, size, flags, shadow)
	if not fs then return end
	fs:SetFont(path, size, flags or C.FONT_FLAGS)
	if shadow then
		fs:SetShadowColor(0, 0, 0, 1)
		fs:SetShadowOffset(1, -1)
	else
		fs:SetShadowColor(0, 0, 0, 0)
		fs:SetShadowOffset(0, 0)
	end
end

local function applyIconFont(fs)
	applyFont(fs, L.ICON_FONT_PATH or L.FONT_PATH or C.FONT_PATH, L.ICON_FONT_SIZE, L.ICON_FONT_FLAGS, L.ICON_SHADOW)
end

local function applyBarFont(fs)
	applyFont(fs, L.FONT_PATH or C.FONT_PATH, L.BAR_FONT_SIZE, L.BAR_FONT_FLAGS, L.BAR_SHADOW)
end

local function configureTooltipFrameMouse(frame)
	if not frame then return end
	frame:EnableMouse(true)
	if frame.SetMouseMotionEnabled then
		frame:SetMouseMotionEnabled(true)
	end
	if frame.SetMouseClickEnabled then
		frame:SetMouseClickEnabled(false)
	end
	if InCombatLockdown and InCombatLockdown() then
		tooltipMousePending[frame] = true
		return
	end
	if frame.SetPassThroughButtons then
		frame:SetPassThroughButtons("LeftButton", "RightButton", "MiddleButton", "Button4", "Button5")
	elseif frame.SetPropagateMouseClicks then
		frame:SetPropagateMouseClicks(true)
	end
	if frame.SetPropagateMouseMotion then
		frame:SetPropagateMouseMotion(false)
	end
	tooltipMousePending[frame] = nil
end

function M:RefreshTooltipFrameMouse()
	for frame in pairs(tooltipMousePending) do
		configureTooltipFrameMouse(frame)
	end
end

M.applyIconFont = applyIconFont
M.applyBarFont = applyBarFont

local function acquireIcon()
	local f = tremove(iconPool)
	if not f then
		f = CreateFrame("Frame", nil, iconsParent)

		local main = CreateFrame("Frame", nil, f)
		main:SetAllPoints(f)
		f.main = main

		local tex = main:CreateTexture(nil, "ARTWORK")
		tex:SetAllPoints()
		f.tex = tex

		local cd = CreateFrame("Cooldown", nil, main, "CooldownFrameTemplate")
		cd:SetAllPoints()
		cd:SetDrawEdge(false)
		if cd.SetReverse then cd:SetReverse(true) end
		if cd.SetHideCountdownNumbers then cd:SetHideCountdownNumbers(true) end
		cd:SetFrameLevel(main:GetFrameLevel() + 5)
		f.cd = cd

		local tf = CreateFrame("Frame", nil, main)
		tf:SetAllPoints()
		tf:SetFrameLevel(cd:GetFrameLevel() + 10)
		f.textOverlay = tf

		local pauseIcon = tf:CreateTexture(nil, "OVERLAY")
		pauseIcon:SetTexture(C.PAUSE_STATE_ICON)
		pauseIcon:SetPoint("TOPRIGHT", tf, "TOPRIGHT", -2, -2)
		pauseIcon:Hide()
		f.pauseIcon = pauseIcon

		local blockedIcon = tf:CreateTexture(nil, "OVERLAY")
		blockedIcon:SetTexture(C.BLOCKED_STATE_ICON)
		blockedIcon:SetPoint("TOPRIGHT", tf, "TOPRIGHT", -2, -2)
		blockedIcon:Hide()
		f.blockedIcon = blockedIcon

		local tt = tf:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		tt:SetPoint("CENTER", tf, "CENTER", 0, 0)
		tt:SetTextColor(1, 1, 1, 1)
		f.timeText = tt

		-- indicator layer inside icon, above cooldown/text
		local ind = CreateFrame("Frame", nil, main)
		ind:SetAllPoints(main)
		ind:SetFrameLevel(tf:GetFrameLevel() + 10)
		f.indicatorsFrame = ind

			configureTooltipFrameMouse(f)
			f:SetScript("OnEnter", iconTooltipOnEnter)
			f:SetScript("OnLeave", hideEventTooltip)
			f:SetScript("OnHide", hideEventTooltip)
		end

	f:SetSize(L.ICON_SIZE, L.ICON_SIZE)
	f:SetAlpha(1)
	f.__sbmIconLayoutPoint = nil
	f.__sbmIconLayoutX = nil
	f.__sbmIconLayoutY = nil
	f.__sbmIconLayoutTargetX = nil
	f.__sbmIconLayoutTargetY = nil
	ensureFullBorder(f.main, L.ICON_BORDER_THICKNESS)
	if f.cd then
		f.cd:Clear()
		f.cd:Hide()
	end
	if f.timeText then
		f.timeText:SetText("")
	end

	f.cd:SetFrameLevel(f.main:GetFrameLevel() + 5)
	if f.textOverlay then
		f.textOverlay:SetFrameLevel(f.cd:GetFrameLevel() + 10)
	end
	if f.indicatorsFrame and f.textOverlay then
		f.indicatorsFrame:SetFrameLevel(f.textOverlay:GetFrameLevel() + 10)
	end
	if f.pauseIcon and f.textOverlay then
		f.pauseIcon:SetDrawLayer("OVERLAY")
	end
	if f.blockedIcon and f.textOverlay then
		f.blockedIcon:SetDrawLayer("OVERLAY")
	end

	applyIconFont(f.timeText)
	f:Show()
	return f
end

local function releaseIcon(f)
	if not f then return end
	if M and M.ClearIconAnimation then
		M:ClearIconAnimation(f)
	end
	if M and M.StopIconLayoutMotion then
		M:StopIconLayoutMotion(f, false)
	end
	if M and M.StopIconFadeIn then
		M:StopIconFadeIn(f, true)
	end
	f:Hide()
	f:SetAlpha(1)
	f:ClearAllPoints()
	f.__id = nil
	f.__sbmIconLayoutPoint = nil
	f.__sbmIconLayoutX = nil
	f.__sbmIconLayoutY = nil
	f.__sbmIconLayoutTargetX = nil
	f.__sbmIconLayoutTargetY = nil
	f:SetScript("OnUpdate", nil)
	f.tex:SetTexture(nil)
	if f.tex.SetDesaturated then
		f.tex:SetDesaturated(false)
	end
	f.tex:SetVertexColor(1, 1, 1, 1)
	ensureFullBorder(f.main, L.ICON_BORDER_THICKNESS, 0, 0, 0, 1)
	if f.cd then
		f.cd:Clear()
		f.cd:Hide()
	end
	if f.timeText then f.timeText:SetText("") end
	if f.pauseIcon then f.pauseIcon:Hide() end
	if f.blockedIcon then f.blockedIcon:Hide() end

	if f.indicatorsFrame and f.indicatorsFrame.__indicatorTextures then
		for _, tex in ipairs(f.indicatorsFrame.__indicatorTextures) do
			tex:Hide()
		end
	end

	tinsert(iconPool, f)
end

local function acquireBar()
	local f = tremove(barPool)
	if not f then
		f = CreateFrame("Frame", nil, barsParent)
			configureTooltipFrameMouse(f)
			f:SetScript("OnEnter", barTooltipOnEnter)
			f:SetScript("OnLeave", hideEventTooltip)
			f:SetScript("OnHide", hideEventTooltip)

		local bg = f:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints()
		bg:SetColorTexture(L.BAR_BG_R, L.BAR_BG_G, L.BAR_BG_B, 1)
		bg:SetAlpha(L.BAR_BG_A)
		f.bg = bg

		local bgTint = f:CreateTexture(nil, "BACKGROUND", nil, 1)
		bgTint:SetAllPoints()
		bgTint:SetColorTexture(1, 1, 1, 1)
		bgTint:Hide()
		f.bgTint = bgTint

		local leftFrame = CreateFrame("Frame", nil, f)
		leftFrame:SetPoint("LEFT", f, "LEFT", 0, 0)
		leftFrame:SetPoint("TOP", f, "TOP", 0, 0)
		leftFrame:SetPoint("BOTTOM", f, "BOTTOM", 0, 0)
		leftFrame:SetWidth(L.BAR_HEIGHT)
		f.leftFrame = leftFrame

		local iconFrame = CreateFrame("Frame", nil, leftFrame)
		iconFrame:SetAllPoints()
		f.iconFrame = iconFrame
			iconFrame.__owner = f
			configureTooltipFrameMouse(iconFrame)
			iconFrame:SetScript("OnEnter", barIconTooltipOnEnter)
			iconFrame:SetScript("OnLeave", hideEventTooltip)
			iconFrame:SetScript("OnHide", hideEventTooltip)

		local icon = iconFrame:CreateTexture(nil, "ARTWORK")
		icon:SetAllPoints()
		f.icon = icon

		local sb = CreateFrame("StatusBar", nil, f)
		sb:SetPoint("LEFT", leftFrame, "RIGHT", 0, 0)
		sb:SetPoint("TOP", f, "TOP", 0, 0)
		sb:SetPoint("BOTTOM", f, "BOTTOM", 0, 0)
		sb:SetPoint("RIGHT", f, "RIGHT", 0, 0)
		sb:SetStatusBarTexture(L.BAR_TEX or C.BAR_TEX_DEFAULT)
		sb:SetMinMaxValues(0, L.THRESHOLD_TO_BAR)
		sb:SetValue(L.THRESHOLD_TO_BAR)
		f.sb = sb

		f.sbTex = sb:GetStatusBarTexture()
		if f.sbTex then
			f.sbTex:SetDrawLayer("BACKGROUND")
		end

		-- End indicators (outside bar)
		local endInd = CreateFrame("Frame", nil, f)
		endInd:SetPoint("LEFT", f, "RIGHT", C.BAR_END_INDICATOR_GAP_X, 0)
		endInd:SetPoint("TOP", f, "TOP", 0, 0)
		endInd:SetPoint("BOTTOM", f, "BOTTOM", 0, 0)
		endInd:SetWidth(1)
		f.endIndicatorsFrame = endInd

		local textFrame = CreateFrame("Frame", nil, f)
		textFrame:SetAllPoints()
		textFrame:SetFrameLevel(f:GetFrameLevel() + 50)
		f.textFrame = textFrame

		local txt = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		txt:SetPoint("LEFT", sb, "LEFT", 6, 0)
		txt:SetJustifyH("LEFT")
		txt:SetTextColor(1, 1, 1, 1)
		f.txt = txt

		local rt = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		rt:SetPoint("RIGHT", sb, "RIGHT", -6, 0)
		rt:SetJustifyH("RIGHT")
		rt:SetTextColor(1, 1, 1, 1)
		f.rt = rt
	end

	f:SetSize(L.BAR_WIDTH, L.BAR_HEIGHT)
	f:SetAlpha(1)
	ensureFullBorder(f, L.BAR_BORDER_THICKNESS)
	applyBarBackground(f)

	applyBarMirror(f)

	if f.endIndicatorsFrame then
		f.endIndicatorsFrame:SetWidth(1)
	end

	applyBarFont(f.txt)
	applyBarFont(f.rt)

	setBarFillFlat(f, L.BAR_FG_R, L.BAR_FG_G, L.BAR_FG_B, L.BAR_FG_A)

	f:Show()
	return f
end

local function releaseBar(f)
	if not f then return end
	if M and M.ClearBarAnimation then
		M:ClearBarAnimation(f)
	end
	if M and M.StopBarLayoutMotion then
		M:StopBarLayoutMotion(f, false)
	end
	if M and M.StopBarFadeIn then
		M:StopBarFadeIn(f, true)
	end
	f:Hide()
	f:SetAlpha(1)
	f:ClearAllPoints()
	f.__id = nil
	f.__sbmLayoutPoint = nil
	f.__sbmLayoutY = nil
	f.__sbmLayoutTargetY = nil

	f.sb:SetMinMaxValues(0, L.THRESHOLD_TO_BAR)
	f.sb:SetValue(L.THRESHOLD_TO_BAR)
	setBarFillFlat(f, L.BAR_FG_R, L.BAR_FG_G, L.BAR_FG_B, L.BAR_FG_A)

	f.txt:SetText("")
	f.rt:SetText("")
	if f.icon then
		f.icon:SetTexture(nil)
		f.icon:SetTexCoord(0, 1, 0, 1)
	end

	if f.endIndicatorsFrame and f.endIndicatorsFrame.__indicatorTextures then
		for _, tex in ipairs(f.endIndicatorsFrame.__indicatorTextures) do
			tex:Hide()
		end
	end
	if f.endIndicatorsFrame then
		f.endIndicatorsFrame:SetWidth(1)
	end

	f:SetScript("OnUpdate", nil)
	tinsert(barPool, f)
end

M.acquireIcon = acquireIcon
M.releaseIcon = releaseIcon
M.acquireBar = acquireBar
M.releaseBar = releaseBar
