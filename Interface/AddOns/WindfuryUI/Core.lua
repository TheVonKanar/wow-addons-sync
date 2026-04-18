WindfuryUI = LibStub("AceAddon-3.0"):NewAddon("WindfuryUI", "AceEvent-3.0", "AceConsole-3.0")

local LSM = LibStub("LibSharedMedia-3.0", true)

function WindfuryUI:OnInitialize()
	-- Add fonts Fira fonts to LSM.
	LSM:Register("font", "Fira Mono Regular", [[Interface\Addons\WindfuryUI\Fonts\FiraMono-Regular.ttf]])
	LSM:Register("font", "Fira Mono Medium", [[Interface\Addons\WindfuryUI\Fonts\FiraMono-Medium.ttf]])
	LSM:Register("font", "Fira Mono Bold", [[Interface\Addons\WindfuryUI\Fonts\FiraMono-Bold.ttf]])
	LSM:Register("font", "Fira Sans Condensed Regular", [[Interface\Addons\WindfuryUI\Fonts\FiraSansCondensed-Regular.ttf]])
	LSM:Register("font", "Fira Sans Condensed Medium", [[Interface\Addons\WindfuryUI\Fonts\FiraSansCondensed-Medium.ttf]])
	LSM:Register("font", "Fira Sans Condensed Bold", [[Interface\Addons\WindfuryUI\Fonts\FiraSansCondensed-Bold.ttf]])
end

function WindfuryUI:OnEnable()
	-- Register events.
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function WindfuryUI:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function WindfuryUI:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
	local _, instanceType = IsInInstance()
	if instanceType == "party" or instanceType == "raid" then
		SetCVar("findYourselfModeCircle", true)
		SetCVar("findYourselfModeIcon", true)
		self:Print("Self-highlight has been activated.")
	else
		SetCVar("findYourselfModeCircle", false)
		SetCVar("findYourselfModeIcon", false)
		self:Print("Self-highlight has been deactivated.")
	end
end