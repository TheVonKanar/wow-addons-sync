WindfuryUI = LibStub("AceAddon-3.0"):NewAddon("WindfuryUI")

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
end

function WindfuryUI:OnDisable()
end