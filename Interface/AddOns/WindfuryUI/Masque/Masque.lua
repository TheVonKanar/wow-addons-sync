local Masque = LibStub("Masque", true)

local AddOn, _ = ...
local Version = C_AddOns.GetAddOnMetadata(AddOn, "Version")
local Author = C_AddOns.GetAddOnMetadata(AddOn, "Author")

----------------------------------------
-- Locals
---

-- String Constants
local STR_ADD = "ADD"

-- Texture Strings
local TEX_DEBUFF = [[Interface\Buttons\UI-Debuff-Overlays]]
local TEX_ENCHANT = [[Interface\Buttons\UI-TempEnchant-Border]]

----------------------------------------
-- Zoomed
---

Masque:AddSkin("WindfuryUI - CDM", {
	-- API_VERSION = Template.API_VERSION,
	Shape = "Square",
	Template = "Blizzard Classic",

	-- Info
	Authors = Author,
	Description = "A square skin with zoomed icons and a semi-transparent background.",
	Version = Version,

	-- Skin
	-- Mask = Template.Mask,
	Backdrop = {
		Color = {0, 0, 0, 0.5},
		UseColor = true,
	},
	Icon = {
		TexCoords = {0.07, 0.93, 0.07, 0.93},
	},
	-- Shadow = Template.Shadow,
	Normal = {Hide = true},
	-- Disabled = Template.Disabled,
	Pushed = {
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
		DrawLevel = 1,
		Width = 38,
		Height = 38,
	},
	-- Flash = Template.Flash,
	Checked = {
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = STR_ADD,
		Width = 38,
		Height = 38,
	},
	SlotHighlight = "Checked",
	Border = {
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = STR_ADD,
		Width = 66,
		Height = 66,
		OffsetX = 0.5,
		OffsetY = 0.5,
		Debuff = {
			Texture = TEX_DEBUFF,
			TexCoords = {0.296875, 0.5703125, 0, 0.515625},
			Width = 40,
			Height = 38,
		},
		Enchant = {
			Texture = TEX_ENCHANT,
			Width = 40,
			Height = 40,
		},
		Item = {
			Texture = [[Interface\Common\WhiteIconFrame]],
			Width = 38,
			Height = 38,
		},
	},
	DebuffBorder = {
		Texture = TEX_DEBUFF,
		TexCoords = {0.296875, 0.5703125, 0, 0.515625},
		Width = 40,
		Height = 38,
	},
	EnchantBorder = {
		Texture = TEX_ENCHANT,
		Width = 40,
		Height = 40,
	},
	IconBorder = {
		Texture = [[Interface\Common\WhiteIconFrame]],
		RelicTexture = [[Interface\Artifacts\RelicIconFrame]],
		Width = 38,
		Height = 38,
	},
	-- Gloss = Template.Gloss,
	NewAction = {
		Atlas = "bags-newitem",
		Width = 46,
		Height = 46,
	},
	SpellHighlight = "NewAction",
	IconOverlay = {
		Atlas = "AzeriteIconFrame",
		Width = 38,
		Height = 38,
	},
	IconOverlay2 = {
		Atlas = "ConduitIconFrame-Corners",
		Width = 38,
		Height = 38,
	},
	-- NewItem = Template.NewItem,
	-- QuestBorder = Template.QuestBorder,
	-- UpgradeIcon = Template.UpgradeIcon,
	ContextOverlay = {
		Color = {0, 0, 0, 0.8},
		Width = 38,
		Height = 38,
		UseColor = true,
	},
	SearchOverlay = "ContextOverlay",
	-- JunkIcon = Template.JunkIcon,
	-- Duration = Template.Duration,
	-- Name = Template.Name,
	-- Highlight = Template.Highlight,
	-- [ TextOverlayContainer (Retail) ]
	-- Count = Template.Count,
	-- HotKey = Template.HotKey,
	-- [ AutoCastShine (Classic) ]
	AutoCastable = {
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		Width = 66,
		Height = 66,
		OffsetX = 0.5,
		OffsetY = -0.5,
	},
	AutoCastShine = {
		Width = 36,
		Height = 36,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
	-- [ AutoCastOverlay (Retail) ]
	-- AutoCast_Frame = Template.AutoCast_Frame,
	-- AutoCast_Shine = Template.AutoCast_Shine,
	AutoCast_Mask = {
		Texture = [[Interface\AddOns\Masque\Textures\Square\AutoCast-Mask]],
		Width = 34,
		Height = 34,
	},
	AutoCast_Corners = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Corners",
		Width = 38,
		Height = 38,
	},
	-- [ Cooldowns ]
	-- Cooldown = Template.Cooldown,
	-- ChargeCooldown = Template.ChargeCooldown,
	-- [ SpellAlerts ]
	SpellAlert = {
		Width = 40,
		Height = 40,
		AltGlow = {
			Height = 46,
			Width = 46,
		},
		Classic = {
			Height = 34,
			Width = 34,
		},
		Modern = {
			Height = 34,
			Width = 34,
		},
		["Modern-Lite"] = {
			Height = 33,
			Width = 33,
		},
	},
	AssistedCombatHighlight = {
		Width = 46,
		Height = 46,
	},
}, true)
