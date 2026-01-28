local Masque = LibStub("Masque", true)

local AddOn, _ = ...
local Version = C_AddOns.GetAddOnMetadata(AddOn, "Version")
local Author = C_AddOns.GetAddOnMetadata(AddOn, "Author")

----------------------------------------
-- Locals
---


----------------------------------------
-- CDM Skin
---

Masque:AddSkin("WindfuryUI - CDM", {
	Template = "Blizzard Classic",
	Shape = "Square",

	-- Info
	Version = Version,
	Authors = Author,
	Description = "tbd",

	-- Skin
	Icon = {
		TexCoords = {0.07, 0.93, 0.07, 0.93},
	},
}, true)
