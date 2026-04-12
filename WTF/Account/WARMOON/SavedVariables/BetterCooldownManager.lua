
BCDMDB = {
["namespaces"] = {
},
["profileKeys"] = {
["Kvotheen - Hyjal"] = "Default",
},
["profiles"] = {
["Default"] = {
["global"] = {
["UseGlobalProfile"] = false,
["DisplayLoginMessage"] = true,
["GlobalProfileName"] = "Default",
["EditModeManager"] = {
["SwapOnInstanceDifficulty"] = false,
["RaidLayouts"] = {
["Normal"] = "",
["Heroic"] = "",
["Mythic"] = "",
["LFR"] = "",
},
},
},
["profile"] = {
["SecondaryPowerBar"] = {
["Enabled"] = true,
["MatchWidthOfAnchor"] = true,
["ForegroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["BackgroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["ColourByState"] = true,
["Text"] = {
["Enabled"] = false,
["FontSize"] = 12,
["ShowStaggerDPS"] = false,
["Layout"] = {
"CENTER",
"CENTER",
0,
0,
},
["Colour"] = {
1,
1,
1,
},
},
["FrameStrata"] = "LOW",
["Width"] = 200,
["ColourByClass"] = false,
["SwapToPowerBarPosition"] = false,
["HideTicks"] = false,
["ColourBySpec"] = false,
["Height"] = 13,
["HeightWithoutPrimary"] = 13,
["ColourByType"] = true,
["Layout"] = {
"BOTTOM",
"BCDM_PowerBar",
"TOP",
0,
1,
},
},
["General"] = {
["Fonts"] = {
["Font"] = "Friz Quadrata TT",
["FontFlag"] = "OUTLINE",
["Shadow"] = {
["Enabled"] = false,
["OffsetY"] = -1,
["OffsetX"] = 1,
["Colour"] = {
0,
0,
0,
1,
},
},
},
["Colours"] = {
["SecondaryPower"] = {
["SOUL"] = {
0.29,
0.42,
1,
1,
},
["STAGGER"] = {
0,
1,
0.59,
1,
},
[7] = {
0.58,
0.51,
0.79,
1,
},
["ESSENCE_RECHARGE"] = {
0.5,
0.5,
0.5,
1,
},
["SOUL_FRAGMENTS"] = {
0.5,
0.25,
1,
1,
},
[4] = {
1,
0.96,
0.41,
1,
},
[16] = {
0.1,
0.1,
0.98,
1,
},
["CHARGED_COMBO_POINTS"] = {
0.25,
0.5,
1,
1,
},
[9] = {
0.95,
0.9,
0.6,
1,
},
[5] = {
0.77,
0.12,
0.23,
1,
},
[19] = {
0.2,
0.58,
0.5,
1,
},
["RUNE_RECHARGE"] = {
0.5,
0.5,
0.5,
1,
},
[11] = {
0.25,
0.5,
0.8,
1,
},
["RUNES"] = {
["UNHOLY"] = {
0.25,
1,
0.25,
1,
},
["FROST"] = {
0.25,
1,
1,
1,
},
["BLOOD"] = {
1,
0.25,
0.25,
1,
},
},
[12] = {
0.71,
1,
0.92,
1,
},
["STAGGER_COLOURS"] = {
["MODERATE"] = {
1,
1,
0.25,
1,
},
["LIGHT"] = {
0.25,
1,
0.25,
1,
},
["HEAVY"] = {
1,
0.25,
0.25,
1,
},
},
},
["PrimaryPower"] = {
{
1,
0,
0,
},
{
1,
0.5,
0.25,
},
{
1,
1,
0,
},
[0] = {
0,
0,
1,
},
[13] = {
0.4,
0,
0.8,
},
[8] = {
0.75,
0.52,
0.9,
},
[18] = {
1,
0.61,
0,
},
[11] = {
0,
0.5,
1,
},
[6] = {
0,
0.82,
1,
},
[17] = {
0.79,
0.26,
0.99,
},
},
},
["Textures"] = {
["Foreground"] = "Better Blizzard",
["Background"] = "Better Blizzard",
},
["Animation"] = {
["SmoothBars"] = false,
},
},
["CooldownManager"] = {
["AdditionalCustom"] = {
["KeepAspectRatio"] = true,
["IconWidth"] = 38,
["Layout"] = {
"CENTER",
"NONE",
"CENTER",
0,
0,
},
["FrameStrata"] = "LOW",
["GrowthDirection"] = "RIGHT",
["Spacing"] = 1,
["IconHeight"] = 38,
["IconSize"] = 38,
["Columns"] = 0,
["Text"] = {
["FontSize"] = 12,
["Layout"] = {
"BOTTOMRIGHT",
"BOTTOMRIGHT",
0,
2,
},
["Colour"] = {
1,
1,
1,
},
},
["Spells"] = {
["DEATHKNIGHT"] = {
["BLOOD"] = {
},
["FROST"] = {
},
["UNHOLY"] = {
},
},
["WARRIOR"] = {
["FURY"] = {
},
["ARMS"] = {
},
["PROTECTION"] = {
},
},
["PALADIN"] = {
["RETRIBUTION"] = {
},
["HOLY"] = {
},
["PROTECTION"] = {
},
},
["MAGE"] = {
["FIRE"] = {
},
["FROST"] = {
},
["ARCANE"] = {
},
},
["PRIEST"] = {
["HOLY"] = {
},
["SHADOW"] = {
},
["DISCIPLINE"] = {
},
},
["SHAMAN"] = {
["RESTORATION"] = {
},
["ELEMENTAL"] = {
},
["ENHANCEMENT"] = {
},
},
["MONK"] = {
["MISTWEAVER"] = {
},
["BREWMASTER"] = {
},
["WINDWALKER"] = {
},
},
["WARLOCK"] = {
["AFFLICTION"] = {
},
["DESTRUCTION"] = {
},
["DEMONOLOGY"] = {
},
},
["DEMONHUNTER"] = {
["VENGEANCE"] = {
},
["HAVOC"] = {
},
["DEVOURER"] = {
},
},
["HUNTER"] = {
["SURVIVAL"] = {
},
["MARKSMANSHIP"] = {
},
["BEASTMASTERY"] = {
},
},
["DRUID"] = {
["RESTORATION"] = {
},
["FERAL"] = {
},
["BALANCE"] = {
},
["GUARDIAN"] = {
},
},
["EVOKER"] = {
["DEVASTATION"] = {
},
["PRESERVATION"] = {
},
["AUGMENTATION"] = {
},
},
["ROGUE"] = {
["OUTLAW"] = {
},
["ASSASSINATION"] = {
},
["SUBTLETY"] = {
},
},
},
},
["General"] = {
["BorderSize"] = 1,
["IconZoom"] = 0.1,
["DisableAuraOverlay"] = false,
["Glow"] = {
["Enabled"] = true,
["Type"] = "Pixel",
["Autocast"] = {
["Frequency"] = 0.25,
["Color"] = {
1,
1,
1,
1,
},
["XOffset"] = -1,
["Scale"] = 1,
["Particles"] = 10,
["YOffset"] = -1,
},
["Proc"] = {
["StartAnim"] = true,
["Color"] = {
1,
1,
1,
1,
},
["Duration"] = 1,
["XOffset"] = 0,
["YOffset"] = 0,
},
["Pixel"] = {
["Thickness"] = 1,
["Lines"] = 5,
["Frequency"] = 0.25,
["Color"] = {
1,
1,
1,
1,
},
["XOffset"] = -1,
["Length"] = 2,
["Border"] = false,
["YOffset"] = -1,
},
["Button"] = {
["Color"] = {
1,
1,
1,
1,
},
["Frequency"] = 0.125,
},
},
["CooldownText"] = {
["Colour"] = {
1,
1,
1,
},
["FontSize"] = 15,
["Layout"] = {
"CENTER",
"CENTER",
0,
0,
},
["ScaleByIconSize"] = false,
},
},
["Enable"] = true,
["BuffBar"] = {
["BackgroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["ForegroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["Width"] = 300,
["ColourByClass"] = true,
["GrowthDirection"] = "UP",
["Height"] = 24,
["Spacing"] = 1,
["MatchWidthOfAnchor"] = true,
["Layout"] = {
"BOTTOM",
"NONE",
"TOP",
0,
1.1,
},
["Icon"] = {
["Enabled"] = true,
["Layout"] = "LEFT",
},
["Text"] = {
["SpellName"] = {
["Enabled"] = true,
["FontSize"] = 12,
["Layout"] = {
"LEFT",
"LEFT",
3,
0,
},
["Colour"] = {
1,
1,
1,
},
},
["Duration"] = {
["Enabled"] = true,
["FontSize"] = 12,
["Layout"] = {
"RIGHT",
"RIGHT",
-3,
0,
},
["Colour"] = {
1,
1,
1,
},
},
},
},
["ItemSpell"] = {
["KeepAspectRatio"] = true,
["IconWidth"] = 38,
["Spacing"] = 1,
["Text"] = {
["FontSize"] = 12,
["Layout"] = {
"BOTTOMRIGHT",
"BOTTOMRIGHT",
0,
2,
},
["Colour"] = {
1,
1,
1,
},
},
["FrameStrata"] = "LOW",
["GrowthDirection"] = "LEFT",
["ItemsSpells"] = {
},
["Columns"] = 0,
["OffsetByParentHeight"] = true,
["IconHeight"] = 38,
["IconSize"] = 38,
["HideZeroCharges"] = false,
["ShowItemQualityBorder"] = true,
["Layout"] = {
"CENTER",
"NONE",
"CENTER",
0,
0,
},
},
["Custom"] = {
["KeepAspectRatio"] = true,
["IconWidth"] = 38,
["Layout"] = {
"CENTER",
"NONE",
"CENTER",
0,
0,
},
["FrameStrata"] = "LOW",
["GrowthDirection"] = "RIGHT",
["Spacing"] = 1,
["IconHeight"] = 38,
["IconSize"] = 38,
["Columns"] = 0,
["Text"] = {
["FontSize"] = 12,
["Layout"] = {
"BOTTOMRIGHT",
"BOTTOMRIGHT",
0,
2,
},
["Colour"] = {
1,
1,
1,
},
},
["Spells"] = {
["DEATHKNIGHT"] = {
["BLOOD"] = {
},
["FROST"] = {
},
["UNHOLY"] = {
},
},
["WARRIOR"] = {
["FURY"] = {
},
["ARMS"] = {
},
["PROTECTION"] = {
},
},
["PALADIN"] = {
["RETRIBUTION"] = {
},
["HOLY"] = {
},
["PROTECTION"] = {
},
},
["MAGE"] = {
["FIRE"] = {
},
["FROST"] = {
},
["ARCANE"] = {
},
},
["PRIEST"] = {
["HOLY"] = {
},
["SHADOW"] = {
},
["DISCIPLINE"] = {
},
},
["SHAMAN"] = {
["RESTORATION"] = {
},
["ELEMENTAL"] = {
},
["ENHANCEMENT"] = {
},
},
["MONK"] = {
["MISTWEAVER"] = {
},
["BREWMASTER"] = {
},
["WINDWALKER"] = {
},
},
["WARLOCK"] = {
["AFFLICTION"] = {
},
["DESTRUCTION"] = {
},
["DEMONOLOGY"] = {
},
},
["DEMONHUNTER"] = {
["VENGEANCE"] = {
},
["HAVOC"] = {
},
["DEVOURER"] = {
},
},
["HUNTER"] = {
["SURVIVAL"] = {
},
["MARKSMANSHIP"] = {
},
["BEASTMASTERY"] = {
},
},
["DRUID"] = {
["RESTORATION"] = {
},
["FERAL"] = {
},
["BALANCE"] = {
},
["GUARDIAN"] = {
},
},
["EVOKER"] = {
["DEVASTATION"] = {
},
["PRESERVATION"] = {
},
["AUGMENTATION"] = {
},
},
["ROGUE"] = {
["OUTLAW"] = {
},
["ASSASSINATION"] = {
},
["SUBTLETY"] = {
},
},
},
},
["Trinket"] = {
["Enabled"] = true,
["KeepAspectRatio"] = true,
["IconWidth"] = 38,
["Layout"] = {
"CENTER",
"NONE",
"CENTER",
0,
0,
},
["FrameStrata"] = "LOW",
["GrowthDirection"] = "LEFT",
["IconHeight"] = 38,
["IconSize"] = 38,
["Spacing"] = 1,
["OffsetByParentHeight"] = true,
},
["Essential"] = {
["IconHeight"] = 42,
["KeepAspectRatio"] = true,
["IconWidth"] = 42,
["IconSize"] = 42,
["Text"] = {
["FontSize"] = 15,
["Layout"] = {
"BOTTOMRIGHT",
"BOTTOMRIGHT",
0,
3,
},
["Colour"] = {
1,
1,
1,
},
},
["CenterHorizontally"] = false,
["Layout"] = {
"CENTER",
"CENTER",
0,
-275.1,
},
},
["Buffs"] = {
["IconHeight"] = 32,
["KeepAspectRatio"] = true,
["IconWidth"] = 32,
["IconSize"] = 32,
["Text"] = {
["FontSize"] = 15,
["Layout"] = {
"BOTTOMRIGHT",
"BOTTOMRIGHT",
0,
3,
},
["Colour"] = {
1,
1,
1,
},
},
["CenterBuffs"] = false,
["Layout"] = {
"BOTTOM",
"BCDM_SecondaryPowerBar",
"TOP",
0,
1.1,
},
},
["Item"] = {
["KeepAspectRatio"] = true,
["IconWidth"] = 38,
["Spacing"] = 1,
["Text"] = {
["FontSize"] = 12,
["Layout"] = {
"BOTTOMRIGHT",
"BOTTOMRIGHT",
0,
2,
},
["Colour"] = {
1,
1,
1,
},
},
["FrameStrata"] = "LOW",
["GrowthDirection"] = "LEFT",
["Items"] = {
},
["Columns"] = 0,
["OffsetByParentHeight"] = true,
["IconHeight"] = 38,
["IconSize"] = 38,
["HideZeroCharges"] = false,
["ShowItemQualityBorder"] = true,
["Layout"] = {
"CENTER",
"NONE",
"CENTER",
0,
0,
},
},
["Utility"] = {
["IconHeight"] = 36,
["KeepAspectRatio"] = true,
["IconWidth"] = 36,
["IconSize"] = 36,
["Text"] = {
["FontSize"] = 15,
["Layout"] = {
"BOTTOMRIGHT",
"BOTTOMRIGHT",
0,
3,
},
["Colour"] = {
1,
1,
1,
},
},
["CenterHorizontally"] = false,
["Layout"] = {
"TOP",
"EssentialCooldownViewer",
"BOTTOM",
0,
-1.1,
},
},
},
["PowerBar"] = {
["Enabled"] = true,
["FrequentUpdates"] = true,
["BackgroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["ForegroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["FrameStrata"] = "LOW",
["Width"] = 200,
["ColourByClass"] = false,
["HeightWithoutSecondary"] = 20,
["Layout"] = {
"BOTTOM",
"EssentialCooldownViewer",
"TOP",
0,
1,
},
["Height"] = 13,
["MatchWidthOfAnchor"] = true,
["ColourByType"] = true,
["Text"] = {
["Enabled"] = true,
["FontSize"] = 18,
["Layout"] = {
"BOTTOM",
"BOTTOM",
0,
1,
},
["Colour"] = {
1,
1,
1,
},
},
},
["CastBar"] = {
["Enabled"] = true,
["BackgroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["ForegroundColour"] = {
0.1333333333333333,
0.1333333333333333,
0.1333333333333333,
1,
},
["FrameStrata"] = "LOW",
["Width"] = 200,
["ColourByClass"] = true,
["MatchWidthOfAnchor"] = true,
["Height"] = 24,
["Text"] = {
["CastTime"] = {
["FontSize"] = 12,
["Layout"] = {
"RIGHT",
"RIGHT",
-3,
0,
},
["Colour"] = {
1,
1,
1,
},
},
["SpellName"] = {
["FontSize"] = 12,
["Layout"] = {
"LEFT",
"LEFT",
3,
0,
},
["MaxCharacters"] = 12,
["Colour"] = {
1,
1,
1,
},
},
},
["Icon"] = {
["Enabled"] = true,
["Layout"] = "LEFT",
},
["Layout"] = {
"TOP",
"UtilityCooldownViewer",
"BOTTOM",
0,
-1,
},
},
},
},
},
}
