BetterSelfHighlight = LibStub("AceAddon-3.0"):NewAddon("BetterSelfHighlight", "AceEvent-3.0", "AceConsole-3.0")

local LSM = LibStub("LibSharedMedia-3.0", true)

-- TODO: Put those in a settings panel.
local IsVerbose = false

function BetterSelfHighlight:OnInitialize()
	-- Add fonts Fira fonts to LSM.
	LSM:Register("font", "Fira Mono Regular", [[Interface\Addons\WindfuryUI\Fonts\FiraMono-Regular.ttf]])
	LSM:Register("font", "Fira Mono Medium", [[Interface\Addons\WindfuryUI\Fonts\FiraMono-Medium.ttf]])
	LSM:Register("font", "Fira Mono Bold", [[Interface\Addons\WindfuryUI\Fonts\FiraMono-Bold.ttf]])
	LSM:Register("font", "Fira Sans Condensed Regular", [[Interface\Addons\WindfuryUI\Fonts\FiraSansCondensed-Regular.ttf]])
	LSM:Register("font", "Fira Sans Condensed Medium", [[Interface\Addons\WindfuryUI\Fonts\FiraSansCondensed-Medium.ttf]])
	LSM:Register("font", "Fira Sans Condensed Bold", [[Interface\Addons\WindfuryUI\Fonts\FiraSansCondensed-Bold.ttf]])
end

function BetterSelfHighlight:OnEnable()
	-- Register events.
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function BetterSelfHighlight:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function BetterSelfHighlight:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
	local _, instanceType = IsInInstance()
	if instanceType == "party" or instanceType == "raid" then
		SetCVar("findYourselfModeCircle", true)
		SetCVar("findYourselfModeIcon", true)

		if IsVerbose then
			self:Print("Self Highlight is enabled.")
		end
	else
		SetCVar("findYourselfModeCircle", false)
		SetCVar("findYourselfModeIcon", false)

		if IsVerbose then
			self:Print("Self Highlight is disabled.")
		end
	end
end