
WeakAurasSaved = {
["dynamicIconCache"] = {
},
["editor_tab_spaces"] = 4,
["login_squelch_time"] = 10,
["registered"] = {
},
["editor_font_size"] = 12,
["lastArchiveClear"] = 1699306179,
["minimap"] = {
["hide"] = true,
},
["lastUpgrade"] = 1721323886,
["dbVersion"] = 75,
["migrationCutoff"] = 730,
["features"] = {
},
["displays"] = {
["[SR] Lightning Rush VFX Right"] = {
["customForegroundFrameWidth"] = 0,
["wagoID"] = "K-P_CgDIP",
["authorOptions"] = {
},
["preferToUpdate"] = true,
["adjustedMin"] = "",
["yOffset"] = -18,
["foregroundColor"] = {
1,
1,
1,
1,
},
["desaturateBackground"] = false,
["animationType"] = "loop",
["sameTexture"] = true,
["hideBackground"] = true,
["desaturateForeground"] = false,
["customForegroundRows"] = 16,
["frameRate"] = 15,
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "CENTER",
["customForegroundFileHeight"] = 0,
["customBackgroundRows"] = 16,
["customForegroundFileWidth"] = 0,
["source"] = "import",
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["debuffType"] = "HELPFUL",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["event"] = "Action Usable",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["unit"] = "player",
["use_ignoreoverride"] = true,
["use_track"] = true,
["spellName"] = 418592,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["activeTriggerMode"] = 1,
},
["width"] = 36,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 36,
["customForegroundFrameHeight"] = 0,
["load"] = {
["use_dragonriding"] = true,
["use_spellknown"] = true,
["spec"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
["use_exact_spellknown"] = true,
["class"] = {
["multi"] = {
},
},
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["xOffset"] = 30,
["useAdjustededMax"] = false,
["backgroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\stopmotion",
["customBackgroundColumns"] = 16,
["foregroundTexture"] = "dragonriding_sgvigor_decor_flipbook_right",
["backgroundPercent"] = 1,
["anchorPoint"] = "CENTER",
["mirror"] = false,
["useAdjustededMin"] = false,
["regionType"] = "stopmotion",
["blendMode"] = "BLEND",
["customForegroundFrames"] = 0,
["uid"] = "8X0oZUH69Wn",
["startPercent"] = 0,
["customForegroundColumns"] = 16,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["backgroundColor"] = {
0.5,
0.5,
0.5,
0.5,
},
["semver"] = "1.0.1",
["customBackgroundFrames"] = 0,
["id"] = "[SR] Lightning Rush VFX Right",
["endPercent"] = 1,
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["url"] = "https://wago.io/K-P_CgDIP/2",
["config"] = {
},
["inverse"] = false,
["parent"] = "[SR] Skyriding",
["conditions"] = {
},
["information"] = {
},
["adjustedMax"] = "",
},
["[SR] Lightning Rush"] = {
["iconSource"] = -1,
["wagoID"] = "K-P_CgDIP",
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = -33,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["spellName"] = 418592,
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["event"] = "Cooldown Progress (Spell)",
["unit"] = "player",
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["stacksOperator"] = ">=",
["auraspellids"] = {
"418590",
},
["useStacks"] = true,
["useExactSpellId"] = true,
["stacks"] = "10",
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "unit",
["use_absorbHealMode"] = true,
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["use_spellName"] = true,
["use_absorbMode"] = true,
["use_unit"] = true,
["use_ismoving"] = true,
["event"] = "Conditions",
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = false,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_text_format_p_time_format"] = 0,
["text_text_format_s_format"] = "none",
["text_text"] = "%p",
["text_text_format_1.s_format"] = "none",
["text_text_format_p_time_mod_rate"] = true,
["anchorXOffset"] = 0,
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_precision"] = 1,
["text_shadowXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_format"] = "Number",
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_fontType"] = "OUTLINE",
["text_shadowYOffset"] = 0,
["text_anchorYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_text_format_2.s_format"] = "none",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fontSize"] = 16,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 26,
["load"] = {
["use_spellknown"] = true,
["use_dragonriding"] = true,
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = false,
["source"] = "import",
["config"] = {
},
["color"] = {
1,
1,
1,
1,
},
["parent"] = "[SR] Skyriding",
["useAdjustededMin"] = false,
["regionType"] = "icon",
["cooldownEdge"] = false,
["cooldown"] = true,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["cooldownTextDisabled"] = true,
["anchorFrameType"] = "SCREEN",
["zoom"] = 0,
["semver"] = "1.0.1",
["frameStrata"] = 1,
["id"] = "[SR] Lightning Rush",
["useCooldownModRate"] = true,
["alpha"] = 1,
["width"] = 26,
["xOffset"] = 0,
["uid"] = "6auuKv1LDOV",
["inverse"] = true,
["preferToUpdate"] = true,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["information"] = {
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
},
["[SR] Whirling Surge"] = {
["iconSource"] = -1,
["wagoID"] = "K-P_CgDIP",
["parent"] = "[SR] Skyriding",
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = -33,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["debuffType"] = "HELPFUL",
["use_genericShowOn"] = true,
["event"] = "Cooldown Progress (Spell)",
["unit"] = "player",
["names"] = {
},
["use_spellName"] = true,
["spellIds"] = {
},
["genericShowOn"] = "showAlways",
["use_exact_spellName"] = true,
["subeventPrefix"] = "SPELL",
["use_track"] = true,
["spellName"] = 361584,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = false,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_shadowXOffset"] = 0,
["text_text_format_s_format"] = "none",
["text_text"] = "%p",
["text_text_format_p_round_type"] = "ceil",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_mod_rate"] = true,
["text_text_format_p_time_precision"] = 1,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_format"] = "Number",
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_visible"] = true,
["text_shadowYOffset"] = 0,
["text_anchorYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_2.s_format"] = "none",
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 16,
["anchorXOffset"] = 0,
["text_text_format_1.s_format"] = "none",
},
},
["height"] = 26,
["load"] = {
["use_dragonriding"] = true,
["use_not_spellknown"] = true,
["use_exact_not_spellknown"] = true,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["not_spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = false,
["source"] = "import",
["uid"] = "HiRY(MIYD6Y",
["xOffset"] = 0,
["authorOptions"] = {
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["cooldownEdge"] = false,
["information"] = {
},
["icon"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["zoom"] = 0,
["width"] = 26,
["cooldownTextDisabled"] = true,
["semver"] = "1.0.1",
["alpha"] = 1,
["id"] = "[SR] Whirling Surge",
["frameStrata"] = 1,
["useCooldownModRate"] = true,
["anchorFrameType"] = "SCREEN",
["progressSource"] = {
-1,
"",
},
["config"] = {
},
["inverse"] = true,
["preferToUpdate"] = true,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["cooldown"] = true,
["color"] = {
1,
1,
1,
1,
},
},
["[ENH] 2||Lava Lash (Storm)"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Primary Auras",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Lava Lash",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 60103,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["alpha"] = 1,
["adjustedMax"] = "",
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_shadowYOffset"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 30,
["selfPoint"] = "BOTTOM",
["load"] = {
["use_never"] = false,
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101812] = false,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["source"] = "import",
["progressSource"] = {
-1,
"",
},
["texXOffset"] = 0,
["uid"] = "mRAeXL0YtPW",
["xOffset"] = -48.75,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["useCooldownModRate"] = true,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["anchorFrameParent"] = true,
["auto"] = false,
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 2||Lava Lash (Storm)",
["url"] = "",
["frameStrata"] = 3,
["width"] = 48,
["authorOptions"] = {
},
["config"] = {
},
["inverse"] = true,
["color"] = {
1,
1,
1,
1,
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.1,
},
["[ENH] 1||Flame Shock Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["backgroundColor"] = {
0.2313725650310516,
0.1921568810939789,
0.01568627543747425,
1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0.97647058823529,
0.8078431372549,
0.062745098039216,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101824] = false,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["zoneIds"] = "",
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["auto"] = true,
["tocversion"] = 100107,
["alpha"] = 1,
["sparkColor"] = {
1,
1,
1,
1,
},
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Primary Auras",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["ownOnly"] = true,
["event"] = "Health",
["unit"] = "target",
["auraspellids"] = {
"188389",
},
["auranames"] = {
"188389",
},
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["subeventSuffix"] = "_CAST_START",
["useName"] = false,
["names"] = {
},
["debuffType"] = "HARMFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return t[1] and (t[2] or (t[3] and t[4]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["type"] = "subborder",
["border_anchor"] = "bar",
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] 1||Flame Shock",
["uid"] = "fOfmu873CS1",
["icon_side"] = "RIGHT",
["barColor2"] = {
1,
1,
0,
1,
},
["anchorFrameParent"] = true,
["sparkHeight"] = 30,
["authorOptions"] = {
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["spark"] = false,
["semver"] = "10.0.51",
["config"] = {
},
["id"] = "[ENH] 1||Flame Shock Duration",
["sparkHidden"] = "NEVER",
["frameStrata"] = 4,
["width"] = 48,
["anchorFrameType"] = "SELECTFRAME",
["icon"] = false,
["inverse"] = false,
["zoom"] = 0,
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["adjustedMax"] = "18",
},
["[ENH] 4||Sundering"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["xOffset"] = 48.75,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Crash Lightning",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 197214,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Stormstrike (Elementalist)",
["parent"] = "Secondary Auras",
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_format"] = "Number",
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101840] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_never"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["source"] = "import",
["authorOptions"] = {
},
["url"] = "",
["uid"] = "5)KRFBIiAjF",
["preferToUpdate"] = false,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["width"] = 48,
["frameStrata"] = 3,
["color"] = {
1,
1,
1,
1,
},
["progressSource"] = {
-1,
"",
},
["anchorFrameParent"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 4||Sundering",
["useCooldownModRate"] = true,
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["texXOffset"] = 0,
["config"] = {
},
["inverse"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["Resources"] = {
["controlledChildren"] = {
"[ENH] Maelstrom Background",
"[ENH] Maelstrom Bar 1",
"[ENH] Maelstrom Bar 2",
"[ENH] Maelstrom Bar 3",
"[ENH] Maelstrom Bar 4",
"[ENH] Maelstrom Bar 5",
"[ENH] Player Health",
},
["borderBackdrop"] = "Blizzard Tooltip",
["xOffset"] = 0,
["groupIcon"] = 237584,
["anchorPoint"] = "CENTER",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["subRegions"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["borderOffset"] = 4,
["config"] = {
},
["uid"] = ")3LtExtpZw8",
["id"] = "Resources",
["parent"] = "[ENH] Enhancement Shaman",
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["authorOptions"] = {
},
["borderInset"] = 1,
["yOffset"] = 0,
["selfPoint"] = "CENTER",
["conditions"] = {
},
["information"] = {
},
["alpha"] = 1,
},
["[ENH] Thunderstorm"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOM",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 51490,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Thunderstorm",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["charges"] = "1",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["desaturate"] = false,
["frameStrata"] = 3,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 3,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_time_precision"] = 1,
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["parent"] = "Cooldowns",
["load"] = {
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101995] = true,
[127878] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_spellknown"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["cooldown"] = true,
["source"] = "import",
["displayIcon"] = "",
["xOffset"] = 48.75,
["authorOptions"] = {
},
["config"] = {
},
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["width"] = 48,
["useCooldownModRate"] = true,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Thunderstorm",
["icon"] = true,
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["selfPoint"] = "TOP",
["uid"] = "Ks01AtYRxJt",
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["value"] = 0,
["variable"] = "show",
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = -0.1,
},
["[ENH] Player Health"] = {
["overlays"] = {
[2] = {
0,
1,
0.3333333432674408,
1,
},
},
["sparkOffsetX"] = 0,
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = -1,
["anchorPoint"] = "BOTTOM",
["sparkHeight"] = 30,
["sparkRotation"] = 0,
["sparkRotationMode"] = "AUTO",
["sparkWidth"] = 10,
["icon"] = false,
["triggers"] = {
{
["trigger"] = {
["use_showAbsorb"] = true,
["use_absorbMode"] = true,
["use_unit"] = true,
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["percenthealth"] = {
"25",
},
["absorbMode"] = "OVERLAY_FROM_END",
["use_showIncomingHeal"] = true,
["names"] = {
},
["spellIds"] = {
},
["event"] = "Health",
["subeventPrefix"] = "SPELL",
["use_percenthealth"] = false,
["percenthealth_operator"] = {
"<",
},
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_showAbsorb"] = false,
["use_absorbMode"] = true,
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["percenthealth"] = {
"25",
},
["event"] = "Health",
["use_showIncomingHeal"] = false,
["unit"] = "player",
["spellIds"] = {
},
["absorbMode"] = "OVERLAY_FROM_END",
["use_unit"] = true,
["use_percenthealth"] = true,
["percenthealth_operator"] = {
"<",
},
["names"] = {
},
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_incombat"] = true,
["use_absorbHealMode"] = true,
["use_unit"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "unit",
["use_health"] = true,
["health_operator"] = {
">",
},
["use_absorbMode"] = true,
["event"] = "Health",
["unit"] = "target",
["use_absorbHealMode"] = true,
["health"] = {
"0",
},
["percenthealth"] = {
"0",
},
["use_unit"] = true,
["use_percenthealth"] = false,
["percenthealth_operator"] = {
">",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["use_attackable"] = true,
["use_unit"] = true,
["use_absorbMode"] = true,
["event"] = "Unit Characteristics",
["unit"] = "target",
},
["untrigger"] = {
},
},
["disjunctive"] = "custom",
["customTriggerLogic"] = "function(t)\n    return t[2] or t[3] or (t[4] and t[5])\nend",
["activeTriggerMode"] = 1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = true,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "TOP",
["information"] = {
},
["text"] = false,
["barColor"] = {
0,
0.7490196228027344,
0,
1,
},
["desaturate"] = false,
["iconSource"] = -1,
["internalVersion"] = 75,
["sparkOffsetY"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_shadowXOffset"] = 1,
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_text_format_p_time_legacy_floor"] = false,
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorXOffset"] = 0,
["anchorYOffset"] = 0,
["text_text_format_n_abbreviate_max"] = 18,
["rotateText"] = "NONE",
["text_justify"] = "CENTER",
["text_text_format_n_format"] = "string",
["text_text_format_p_time_precision"] = 1,
["type"] = "subtext",
["text_anchorXOffset"] = 3,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Condensed Medium",
["text_text_format_p_format"] = "timed",
["text_shadowYOffset"] = -1,
["text_fontType"] = "None",
["text_wordWrap"] = "WordWrap",
["text_visible"] = false,
["text_anchorPoint"] = "INNER_LEFT",
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_fontSize"] = 14,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_n_abbreviate"] = true,
},
{
["text_text_format_p_time_format"] = 0,
["text_text"] = "%1.percenthealth%",
["text_text_format_p_realm_name"] = "never",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_text_format_1.percenthealth_abbreviate"] = false,
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["rotateText"] = "NONE",
["text_text_format_1.percenthealth_format"] = "Number",
["text_color"] = {
1,
1,
1,
1,
},
["text_shadowYOffset"] = -1,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "None",
["text_text_format_p_color"] = true,
["text_text_format_1.percenthealth_decimal_precision"] = 0,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_n_format"] = "none",
["text_text_format_p_time_mod_rate"] = true,
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_text_format_1.percenthealth_round_type"] = "ceil",
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["type"] = "subtext",
["text_anchorXOffset"] = -3,
["text_font"] = "Fira Sans Medium",
["text_text_format_1.percenthealth_abbreviate_max"] = 8,
["text_text_format_1.percenthealth_realm_name"] = "never",
["text_shadowXOffset"] = 1,
["text_text_format_1.percenthealth_color"] = true,
["text_text_format_p_format"] = "timed",
["text_anchorPoint"] = "INNER_RIGHT",
["text_text_format_p_abbreviate_max"] = 8,
["text_text_format_p_abbreviate"] = false,
["text_text_format_p_time_precision"] = 1,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_visible"] = false,
},
},
["gradientOrientation"] = "HORIZONTAL",
["textureSource"] = "LSM",
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["use_class_and_spec"] = true,
["use_dragonriding"] = false,
["class"] = {
["multi"] = {
},
},
["use_vehicleUi"] = false,
["class_and_spec"] = {
["single"] = 263,
},
["use_alive"] = true,
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["backgroundColor"] = {
0,
0.2000000178813934,
0,
0.5,
},
["uid"] = "ZRNY8M9)2uu",
["config"] = {
},
["parent"] = "Resources",
["anchorFrameType"] = "SCREEN",
["smoothProgress"] = true,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "aurabar",
["frameStrata"] = 1,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["do_custom"] = false,
},
},
["icon_side"] = "RIGHT",
["id"] = "[ENH] Player Health",
["overlayclip"] = true,
["texture"] = "Cell Default",
["overlaysTexture"] = {
"Clean",
"Clean",
},
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["zoom"] = 0,
["sparkHidden"] = "NEVER",
["useAdjustededMin"] = false,
["alpha"] = 1,
["width"] = 244,
["height"] = 13.5,
["sparkColor"] = {
1,
1,
1,
1,
},
["inverse"] = false,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["orientation"] = "HORIZONTAL",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "percenthealth",
["op"] = "<",
["value"] = "25",
},
["changes"] = {
{
["value"] = {
0.7490196228027344,
0.3764706254005432,
0,
1,
},
["property"] = "barColor",
},
{
["value"] = {
1,
0.501960813999176,
0,
1,
},
["property"] = "barColor2",
},
{
["value"] = {
0.2000000178813934,
0.1019607931375504,
0,
0.5,
},
["property"] = "backgroundColor",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "percenthealth",
["op"] = "<",
["value"] = "50",
},
["linked"] = true,
["changes"] = {
{
["value"] = {
0.7490196228027344,
0.7490196228027344,
0,
1,
},
["property"] = "barColor",
},
{
["value"] = {
1,
1,
0,
1,
},
["property"] = "barColor2",
},
{
["value"] = {
0.2000000178813934,
0.2000000178813934,
0,
0.5,
},
["property"] = "backgroundColor",
},
},
},
},
["barColor2"] = {
0,
1,
0,
1,
},
["xOffset"] = 0,
},
["[BWT] <=10s Ability Group"] = {
["controlledChildren"] = {
"[BWT] Vertical Bar",
"[BWT] <=10s Ability Prefab",
},
["borderBackdrop"] = "Blizzard Tooltip",
["wagoID"] = "CucqUEyfY",
["parent"] = "[BWT] Bigwigs Timeline",
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["borderColor"] = {
0,
0,
0,
1,
},
["url"] = "https://wago.io/CucqUEyfY/10",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["unit"] = "player",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["selfPoint"] = "CENTER",
["version"] = 10,
["subRegions"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["source"] = "import",
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["uid"] = "CdLf8CW1Oca",
["xOffset"] = 0,
["borderOffset"] = 4,
["semver"] = "1.0.10",
["tocversion"] = 110000,
["id"] = "[BWT] <=10s Ability Group",
["groupIcon"] = "",
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["config"] = {
},
["borderInset"] = 1,
["authorOptions"] = {
},
["conditions"] = {
},
["information"] = {
},
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
},
["[ENH] Target Lashing Flame"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 27,
["anchorPoint"] = "BOTTOMRIGHT",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["auraspellids"] = {
"334168",
},
["ownOnly"] = true,
["event"] = "Health",
["names"] = {
},
["matchesShowOn"] = "showOnActive",
["spellIds"] = {
},
["unit"] = "target",
["subeventPrefix"] = "SPELL",
["subeventSuffix"] = "_CAST_START",
["useExactSpellId"] = true,
["debuffType"] = "HARMFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Target Health Bar",
["parent"] = "Target Frame",
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 26,
["texXOffset"] = 0,
["load"] = {
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101812] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
},
["source"] = "import",
["authorOptions"] = {
},
["cooldownEdge"] = false,
["uid"] = "FByT7NRMaKV",
["xOffset"] = 1,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameType"] = "SELECTFRAME",
["frameStrata"] = 3,
["progressSource"] = {
-1,
"",
},
["alpha"] = 1,
["anchorFrameParent"] = true,
["auto"] = false,
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Target Lashing Flame",
["selfPoint"] = "BOTTOMLEFT",
["useCooldownModRate"] = true,
["width"] = 26,
["adjustedMax"] = "",
["config"] = {
},
["inverse"] = false,
["icon"] = true,
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["[SR] Flying Speed"] = {
["user_y"] = 0,
["iconSource"] = -1,
["user_x"] = 0,
["authorOptions"] = {
},
["preferToUpdate"] = true,
["yOffset"] = -2.7743251337612e-05,
["foregroundColor"] = {
0.80784320831299,
0.94117653369904,
1,
1,
},
["displayText_format_p_time_format"] = 0,
["sameTexture"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["icon"] = false,
["icon_color"] = {
1,
1,
1,
1,
},
["wordWrap"] = "WordWrap",
["barColor"] = {
0.30196079611778,
0.63921570777893,
0.7607843875885,
1,
},
["desaturate"] = false,
["rotation"] = 0,
["font"] = "Friz Quadrata TT",
["sparkOffsetY"] = 0,
["load"] = {
["ingroup"] = {
},
["use_zoneIds"] = false,
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["single"] = "none",
["multi"] = {
["none"] = true,
},
},
["instance_type"] = {
},
["difficulty"] = {
["single"] = "timewalking",
["multi"] = {
},
},
["use_dragonriding"] = true,
["zoneIds"] = "1978, 2022, 2023, 2024, 2025, 2112, 2093",
["class"] = {
["multi"] = {
},
},
["use_spellknown"] = false,
["use_never"] = false,
["spellknown"] = 372610,
["itemtypeequipped"] = {
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["foregroundTexture"] = "ui-storm-headerfill",
["shadowXOffset"] = 1,
["smoothProgress"] = true,
["useAdjustededMin"] = true,
["regionType"] = "progresstexture",
["blendMode"] = "ADD",
["slantMode"] = "INSIDE",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100002,
["alpha"] = 1,
["auraRotation"] = 0,
["fixedWidth"] = 200,
["backgroundOffset"] = 2,
["outline"] = "OUTLINE",
["displayText_format_p_time_dynamic_threshold"] = 60,
["sparkOffsetX"] = 0,
["wagoID"] = "K-P_CgDIP",
["parent"] = "[SR] Skyriding",
["color"] = {
1,
1,
1,
1,
},
["adjustedMin"] = "0",
["shadowYOffset"] = -1,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "thrill",
["value"] = 1,
},
["linked"] = false,
["changes"] = {
{
["value"] = {
0.10588236153126,
0.1803921610117,
1,
1,
},
["property"] = "foregroundColor",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
["changes"] = {
{
["property"] = "alpha",
},
},
},
},
["desaturateBackground"] = false,
["orientation"] = "CLOCKWISE",
["uid"] = "3zWBqp5XEiH",
["sparkRotationMode"] = "AUTO",
["automaticWidth"] = "Auto",
["desaturateForeground"] = false,
["triggers"] = {
{
["trigger"] = {
["type"] = "custom",
["subeventSuffix"] = "_CAST_START",
["customVariables"] = "{\n    value = \"number\",\n    delta = \"number\",\n    thrill = \"bool\",\n}",
["custom_type"] = "stateupdate",
["event"] = "Health",
["unit"] = "player",
["customDuration"] = "function()\n    return aura_env.smooth_delta + 0.5, 1, true\nend",
["subeventPrefix"] = "SPELL",
["events"] = "PLAYER_MOUNT_DISPLAY_CHANGED, MOUNT_JOURNAL_USABILITY_CHANGED, LEARNED_SPELL_IN_TAB, UNIT_SPELLCAST_SUCCEEDED:player, DMUI_DRAGONRIDING_UPDATE, VEHICLE_ANGLE_UPDATE",
["names"] = {
},
["check"] = "event",
["custom"] = "function(...)\n    return aura_env.trigger1(...)\nend",
["spellIds"] = {
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t) return (t[2] or t[3]) and t[4] end",
["activeTriggerMode"] = 1,
},
["endAngle"] = 180,
["displayText_format_p_time_legacy_floor"] = false,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["colorR"] = 0.74901962280273,
["scalex"] = 1,
["colorA"] = 1,
["colorG"] = 0,
["type"] = "none",
["easeType"] = "none",
["scaley"] = 1,
["alpha"] = 0,
["colorB"] = 0.015686275437474,
["y"] = 0,
["colorType"] = "custom",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["colorFunc"] = "function(_, r1, g1, b1, a1, r2, g2, b2, a2)\n    local progress = 1 - math.min(1, math.max(aura_env.smooth_accel + 0.5, 0))\n    if not aura_env.boosting then\n        return WeakAuras.GetHSVTransition(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n    else\n        return r1, g1, b1, a1\n    end\nend",
["rotate"] = 0,
["x"] = 0,
["use_color"] = false,
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["zoom"] = 0,
["displayText_format_p_time_mod_rate"] = true,
["compress"] = false,
["width"] = 114,
["adjustedMax"] = "100%",
["displayText"] = "Pitch: %p",
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_text_format_p_time_precision"] = 1,
["text_text_format_1.speedtext_format"] = "none",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_fixedWidth"] = 64,
["text_text_format_1.p_time_format"] = 0,
["text_text_format_p_time_legacy_floor"] = false,
["rotateText"] = "NONE",
["text_text_format_p_decimal_precision"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_shadowYOffset"] = -2,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "None",
["text_fontSize"] = 18,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "floor",
["text_text_format_n_format"] = "none",
["text_text_format_1.p_time_legacy_floor"] = false,
["text_text_format_.speedtext_format"] = "none",
["text_text_format_p_time_mod_rate"] = true,
["text_selfPoint"] = "CENTER",
["text_text_format_1.speedtext1600_format"] = "none",
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["text_text_format_1.p_time_precision"] = 1,
["text_text_format_1.p_time_mod_rate"] = true,
["type"] = "subtext",
["text_anchorXOffset"] = 2,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_font"] = "Fira Mono Medium",
["text_automaticWidth"] = "Auto",
["text_anchorYOffset"] = 6,
["text_text_format_1.p_time_dynamic_threshold"] = 60,
["text_text_format_p_time_format"] = 0,
["text_text_format_1.p_format"] = "timed",
["text_anchorPoint"] = "CENTER",
["text_text_format_1.speedtexttoto_format"] = "none",
["text_text"] = "%1.speedtext",
["text_shadowXOffset"] = 2,
["text_text_format_p_format"] = "Number",
["text_visible"] = true,
},
},
["height"] = 138,
["sparkHidden"] = "NEVER",
["fontSize"] = 12,
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = true,
["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
["source"] = "import",
["semver"] = "1.0.1",
["startAngle"] = 180,
["internalVersion"] = 75,
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:Dragonriding UI Pitch",
["xOffset"] = 0,
["anchorFrameParent"] = true,
["actions"] = {
["start"] = {
["custom"] = "",
["do_custom"] = false,
},
["init"] = {
["custom"] = "---- Parameters ----\n\nlocal mountEvents = {\n    [\"PLAYER_MOUNT_DISPLAY_CHANGED\"] = true,\n    [\"MOUNT_JOURNAL_USABILITY_CHANGED\"] = true,\n    [\"LEARNED_SPELL_IN_TAB\"] = true,\n}\n\nlocal ascentSpell = 372610\nlocal thrillBuff = 377234\nlocal thrillSpeed = 60\nlocal maxSamples = 5\nlocal ascentDuration = 3.5\nlocal ascentBoostMax = 35\nlocal pollRate = 1 / 10\nlocal updatePeriod = 1 / 10\nlocal speedTextFormat, speedTextFactor = \"%.0f%%\", 100 / 7\n\n---- Variables ----\n\nlocal active = false\nlocal updateHandle = nil\nlocal ascentStart = 0\nlocal lastX, lastY, lastT = 0, 0, 0\nlocal samples = 0\nlocal skipped = false\nlocal smoothSpeed, smoothGSpeed, lastSpeed = 0, 0, 0\n\n---- Localized functions ----\n\nlocal ScanEvents = WeakAuras.ScanEvents\nlocal GetTime = GetTime\nlocal After = C_Timer.After\nlocal GetBestMapForUnit = C_Map.GetBestMapForUnit\nlocal GetPlayerMapPosition = C_Map.GetPlayerMapPosition\nlocal GetMapWorldSize = C_Map.GetMapWorldSize\n\n---- Trigger 1 ----\n\n-- Events:\n--   PLAYER_MOUNT_DISPLAY_CHANGED\n--   MOUNT_JOURNAL_USABILITY_CHANGED\n--   LEARNED_SPELL_IN_TAB\n--   UNIT_SPELLCAST_SUCCEEDED:player\n--   DMUI_DRAGONRIDING_UPDATE\n\nlocal function setActive(allstates, state)\n    active = state\n    After(0, function()\n            ScanEvents(\"DMUI_DRAGONRIDING_SHOW\", state)\n    end)\n    \n    if active then\n        \n        if not updateHandle then\n            updateHandle = C_Timer.NewTicker(pollRate, function()\n                    if active then\n                        ScanEvents(\"DMUI_DRAGONRIDING_UPDATE\", true)\n                    end\n            end)\n        end\n        \n        if not allstates[\"\"] then\n            allstates[\"\"] = {\n                show = true,\n                changed = true,\n                progressType = \"static\",\n                value = 0,\n                accel = 0,\n                total = 100,\n                thrill = false,\n                speedtext = \"\",\n            }\n            return true\n        end\n    else\n        if updateHandle then\n            updateHandle:Cancel()\n            updateHandle = nil\n        end\n        \n        if allstates[\"\"] then\n            allstates[\"\"].show = false\n            allstates[\"\"].changed = true\n            return true\n        end\n    end\nend\n\naura_env.trigger1 = function(allstates, event, _, _, spellId)\n    \n    if event ~= \"DMUI_DRAGONRIDING_UDPATE\" then\n        \n        -- Ensure ticker is stopped on opening WA options\n        if event == \"OPTIONS\" then\n            return setActive(allstates, false)\n        end\n        \n        -- Detect dragonriding start/end\n        if mountEvents[event] then\n            if IsMounted() then\n                for _, mountId in ipairs(C_MountJournal.GetCollectedDragonridingMounts()) do\n                    if select(4, C_MountJournal.GetMountInfoByID(mountId)) then\n                        return setActive(allstates, true)\n                    end\n                end\n            end\n            return setActive(allstates, false)\n        end\n        \n        -- Detect ascent boost\n        if event == \"UNIT_SPELLCAST_SUCCEEDED\" then\n            if spellId == ascentSpell then\n                ascentStart = GetTime()\n            end\n            return false\n        end\n    end\n    \n    local time = GetTime()\n    \n    -- Delta time\n    local dt = time - lastT\n    if dt < updatePeriod then\n        -- Rate limit speed updates!\n        return false\n    end\n    lastT = time\n    \n    if not allstates or not allstates[\"\"] then return false end\n    \n    -- Compute accurate speed if possible\n    local instanced = true\n    local speed, groundSpeed = 0, 0\n    local map = GetBestMapForUnit(\"player\")\n    if map then\n        local position = GetPlayerMapPosition(map, \"player\")\n        if position then\n            instanced = false\n            \n            -- Delta position\n            local x, y = position.x, position.y\n            local w, h = GetMapWorldSize(map)\n            x = x * w\n            y = y * h\n            local dx = x - lastX\n            local dy = y - lastY\n            lastX = x\n            lastY = y\n            \n            -- Compute horizontal speed and adjust for pitch\n            groundSpeed = math.sqrt(dx * dx + dy * dy) / dt\n            if groundSpeed > 0 then\n                local cosTheta = math.cos(math.abs(0))\n                if cosTheta > 0 then\n                    speed = groundSpeed / cosTheta\n                end\n            end\n        end\n    end\n    \n    -- Ignore obviously invalid speeds that occur when jumping zones\n    if speed > 150 then\n        return false\n    end\n    \n    -- If speed can't be detected, reduce exp-avg window size\n    if speed == 0 then\n        samples = math.min(1, samples)\n    end\n    \n    local thrill = C_UnitAuras.GetPlayerAuraBySpellID(thrillBuff)\n    \n    -- Override with ascent boost\n    if thrill and time < ascentStart + ascentDuration then\n        local progress = (time - ascentStart) / ascentDuration\n        local boost = thrillSpeed + (1 - progress) * ascentBoostMax\n        if speed < boost then\n            speed = boost\n            samples = 0\n            skipped = true\n        end\n    end\n    \n    -- Override speed based on Thrill buff\n    if speed < thrillSpeed and thrill then\n        speed = thrillSpeed\n    end\n    \n    if speed > thrillSpeed and not thrill then\n        speed = thrillSpeed\n        samples = 0\n        skipped = true\n    end\n    \n    -- Skip sampling on large apparent speed changes\n    if math.abs(speed - smoothSpeed) > 100 then\n        if skipped then\n            samples = 0\n        else\n            skipped = true\n            return false\n        end\n    end\n    skipped = false\n    \n    -- Compute smooth speed\n    samples = math.min(maxSamples, samples + 1)\n    local lastWeight = (samples - 1) / samples\n    local newWeight = 1 / samples\n    smoothSpeed = smoothSpeed * lastWeight + speed * newWeight\n    smoothGSpeed = smoothGSpeed * lastWeight + groundSpeed * newWeight\n    lastSpeed = smoothSpeed\n    \n    -- Update display variables\n    local s = allstates[\"\"]\n    s.changed = true\n    s.value = smoothSpeed\n    s.thrill = not not thrill\n    local speed = (true or instanced) and smoothSpeed or smoothGSpeed\n    s.speedtext = speed < 1 and \"\" or string.format(speedTextFormat, speed * speedTextFactor)\n    \n    return true\nend",
["do_custom"] = true,
},
["finish"] = {
["custom"] = "\n    EncounterBar:Show()",
["do_custom"] = true,
},
},
["icon_side"] = "RIGHT",
["config"] = {
},
["displayText_format_p_time_precision"] = 1,
["sparkHeight"] = 30,
["sparkRotation"] = 0,
["displayText_format_p_format"] = "timed",
["backgroundColor"] = {
0,
0,
0,
0,
},
["justify"] = "LEFT",
["sparkColor"] = {
1,
1,
1,
1,
},
["id"] = "[SR] Flying Speed",
["sparkWidth"] = 10,
["frameStrata"] = 4,
["anchorFrameType"] = "SCREEN",
["anchorPoint"] = "TOP",
["selfPoint"] = "CENTER",
["inverse"] = false,
["customTextUpdate"] = "event",
["shadowColor"] = {
0,
0,
0,
1,
},
["crop_x"] = 0.41,
["information"] = {
["forceEvents"] = true,
},
["crop_y"] = 0.41,
},
["[ENH] Capacitor Totem"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOM",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 192058,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Capacitor Totem",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["charges"] = "1",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "spell",
["event"] = "Totem",
["subeventSuffix"] = "_CAST_START",
["names"] = {
},
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["totemName"] = "192058",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["use_totemName"] = true,
["unit"] = "player",
["use_track"] = true,
["spellName"] = 0,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return (t[1] or t[2]) and (t[3] or (t[4] and t[5]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["desaturate"] = false,
["frameStrata"] = 3,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 3,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_time_precision"] = 1,
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["xOffset"] = 0,
["load"] = {
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101961] = true,
[101803] = false,
[127851] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_spellknown"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["cooldown"] = true,
["source"] = "import",
["displayIcon"] = "",
["color"] = {
1,
1,
1,
1,
},
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["config"] = {
},
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["width"] = 48,
["useCooldownModRate"] = true,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Capacitor Totem",
["selfPoint"] = "TOP",
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["authorOptions"] = {
},
["uid"] = "o)EZkHhJQeg",
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["property"] = "cooldownSwipe",
},
{
["property"] = "sub.3.text_visible",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = -0.09999999999999998,
},
["[SR] Static Charges"] = {
["iconSource"] = -1,
["wagoID"] = "K-P_CgDIP",
["color"] = {
1,
1,
1,
1,
},
["adjustedMax"] = "10",
["adjustedMin"] = "0",
["yOffset"] = -33,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["useStacks"] = true,
["matchesShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["stacks"] = "10",
["match_count"] = "0",
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["stacksOperator"] = "<",
["match_countOperator"] = ">=",
["event"] = "Health",
["useExactSpellId"] = true,
["spellIds"] = {
},
["unit"] = "player",
["auraspellids"] = {
"418590",
},
["names"] = {
},
["subeventSuffix"] = "_CAST_START",
["use_debuffClass"] = false,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
1,
"stacks",
},
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_shadowXOffset"] = 0,
["text_text_format_s_format"] = "none",
["text_text"] = "%s",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["type"] = "subtext",
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_shadowYOffset"] = 0,
["text_anchorYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_text_format_2.s_format"] = "none",
["text_fontType"] = "OUTLINE",
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_1.s_format"] = "none",
},
},
["height"] = 26,
["load"] = {
["use_spellknown"] = true,
["use_dragonriding"] = true,
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = true,
["source"] = "import",
["uid"] = "NscGnzsi2cE",
["xOffset"] = 0,
["keepAspectRatio"] = false,
["useAdjustededMin"] = true,
["regionType"] = "icon",
["cooldownEdge"] = false,
["information"] = {
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["icon"] = true,
["zoom"] = 0,
["width"] = 26,
["cooldownTextDisabled"] = true,
["semver"] = "1.0.1",
["alpha"] = 1,
["id"] = "[SR] Static Charges",
["frameStrata"] = 1,
["useCooldownModRate"] = true,
["anchorFrameType"] = "SCREEN",
["parent"] = "[SR] Skyriding",
["config"] = {
},
["inverse"] = false,
["preferToUpdate"] = true,
["conditions"] = {
},
["cooldown"] = true,
["authorOptions"] = {
},
},
["[ENH] 5||Fire Nova"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 333974,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Ice Strike",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["charges"] = "1",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useGroup_count"] = true,
["ownOnly"] = true,
["unit"] = "multi",
["debuffType"] = "HARMFUL",
["useExactSpellId"] = true,
["auraspellids"] = {
"188389",
},
["group_count"] = "1",
["useName"] = false,
["auranames"] = {
},
["group_countOperator"] = ">",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["authorOptions"] = {
},
["preferToUpdate"] = false,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_shadowYOffset"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["glow"] = false,
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowLength"] = 8,
["glowYOffset"] = -0.85,
["glowColor"] = {
1,
1,
1,
1,
},
["type"] = "subglow",
["glowXOffset"] = -0.5,
["glowThickness"] = 1.8,
["glowScale"] = 1,
["glowDuration"] = 1,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 30,
["xOffset"] = 97.5,
["load"] = {
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101807] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldown"] = true,
["useAdjustededMax"] = false,
["displayIcon"] = "",
["source"] = "import",
["texXOffset"] = 0,
["progressSource"] = {
-1,
"",
},
["config"] = {
},
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "icon",
["width"] = 48,
["useCooldownModRate"] = true,
["url"] = "",
["alpha"] = 1,
["anchorFrameParent"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 5||Fire Nova",
["useAdjustededMin"] = false,
["frameStrata"] = 3,
["anchorFrameType"] = "SCREEN",
["parent"] = "Primary Auras",
["uid"] = "Ls1Z46o0HEj",
["inverse"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[ENH] 5||Stormstrike (Elementalist)"] = {
["texXOffset"] = 0,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Stormstrike",
["use_spellName"] = true,
["spellIds"] = {
},
["type"] = "spell",
["names"] = {
},
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 17364,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["unit"] = "player",
["ownOnly"] = true,
["auraspellids"] = {
"201846",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["parent"] = "Elementalist",
["iconSource"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_visible"] = true,
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["glow"] = false,
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowLength"] = 8,
["glowYOffset"] = -0.85,
["glowColor"] = {
1,
1,
1,
1,
},
["type"] = "subglow",
["glowXOffset"] = -0.5,
["glowThickness"] = 1.8,
["glowScale"] = 1,
["glowDuration"] = 1,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 30,
["authorOptions"] = {
},
["load"] = {
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101812] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
["linked"] = false,
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
},
["source"] = "import",
["adjustedMax"] = "",
["cooldownEdge"] = false,
["uid"] = "frlM2elLVnm",
["progressSource"] = {
-1,
"",
},
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["useCooldownModRate"] = true,
["useAdjustededMin"] = false,
["anchorFrameParent"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 5||Stormstrike (Elementalist)",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["frameStrata"] = 3,
["width"] = 48,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["config"] = {
},
["inverse"] = true,
["xOffset"] = 97.5,
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.1,
},
["[ENH] Skyfury"] = {
["iconSource"] = -1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["useMatch_count"] = false,
["useGroup_count"] = true,
["matchesShowOn"] = "showOnMissing",
["subeventPrefix"] = "SPELL",
["inRange"] = true,
["group_count"] = "100%",
["debuffType"] = "HELPFUL",
["showClones"] = false,
["type"] = "aura2",
["useExactSpellId"] = true,
["event"] = "Health",
["ignoreDisconnected"] = true,
["unit"] = "group",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["names"] = {
},
["auraspellids"] = {
"462854",
},
["ignoreDead"] = true,
["group_countOperator"] = "<",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar 4",
["color"] = {
1,
1,
1,
1,
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 48,
["xOffset"] = 0,
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["use_class_and_spec"] = true,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["size"] = {
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101841] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_spellknown"] = false,
["use_zoneIds"] = false,
["use_vehicleUi"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_combat"] = false,
["use_alive"] = true,
["zoneIds"] = "2022,2023,2024,2025,2151,2133,2200,2239,g433,g432,g434,g431,g430,g428,2093,g429,g437,g438,g443",
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
},
["source"] = "import",
["progressSource"] = {
-1,
"",
},
["texXOffset"] = 0.03,
["uid"] = "pEGhx4rGDgm",
["icon"] = true,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["useCooldownModRate"] = true,
["url"] = "",
["anchorFrameParent"] = false,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Skyfury",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["frameStrata"] = 3,
["width"] = 48,
["parent"] = "Buffs",
["config"] = {
},
["inverse"] = true,
["preferToUpdate"] = false,
["displayIcon"] = 135814,
["cooldown"] = false,
["texYOffset"] = 0,
},
["[BWT] >10s Ability Group"] = {
["arcLength"] = 360,
["controlledChildren"] = {
"[BWT] >10s Ability Prefab",
},
["borderBackdrop"] = "Blizzard Tooltip",
["wagoID"] = "CucqUEyfY",
["xOffset"] = 0,
["preferToUpdate"] = false,
["yOffset"] = 20,
["gridType"] = "RD",
["borderColor"] = {
0,
0,
0,
1,
},
["rowSpace"] = 1,
["url"] = "https://wago.io/CucqUEyfY/10",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["unit"] = "player",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["columnSpace"] = 1,
["radius"] = 200,
["gridWidth"] = 5,
["useLimit"] = false,
["align"] = "CENTER",
["selfPoint"] = "BOTTOM",
["internalVersion"] = 75,
["parent"] = "[BWT] Bigwigs Timeline",
["rotation"] = 0,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["version"] = 10,
["subRegions"] = {
},
["sortHybridTable"] = {
["BW/DBM ability >10s"] = false,
},
["stagger"] = 0,
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["borderInset"] = 1,
["backdropColor"] = {
1,
1,
1,
0.5,
},
["authorOptions"] = {
},
["source"] = "import",
["animate"] = false,
["scale"] = 1,
["centerType"] = "LR",
["border"] = false,
["borderEdge"] = "Square Full White",
["stepAngle"] = 15,
["borderSize"] = 2,
["sort"] = "ascending",
["frameStrata"] = 1,
["regionType"] = "dynamicgroup",
["anchorFrameParent"] = true,
["constantFactor"] = "RADIUS",
["limit"] = 5,
["borderOffset"] = 4,
["semver"] = "1.0.10",
["tocversion"] = 110000,
["id"] = "[BWT] >10s Ability Group",
["config"] = {
},
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["space"] = 2,
["uid"] = "zHX0pjpkeZ8",
["fullCircle"] = true,
["anchorPoint"] = "TOP",
["conditions"] = {
},
["information"] = {
},
["grow"] = "UP",
},
["[ENH] Phial"] = {
["iconSource"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Trash",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["enchant"] = "5400",
["use_genericShowOn"] = true,
["use_weapon"] = true,
["spellName"] = 197214,
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["use_showOn"] = true,
["event"] = "Weapon Enchant",
["use_exact_spellName"] = false,
["namePattern_name"] = "Phial of",
["useNamePattern"] = true,
["use_track"] = true,
["itemName"] = 0,
["use_absorbMode"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["namePattern_operator"] = "find('%s')",
["ownOnly"] = true,
["use_unit"] = true,
["charges"] = "1",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "aura2",
["unit"] = "player",
["auraspellids"] = {
"371172",
},
["matchesShowOn"] = "showOnMissing",
["use_charges"] = false,
["use_enchant"] = true,
["names"] = {
},
["realSpellName"] = "Sundering",
["use_spellName"] = true,
["spellIds"] = {
},
["use_itemName"] = true,
["showOn"] = "showOnMissing",
["track"] = "auto",
["useExactSpellId"] = false,
["weapon"] = "off",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["useCooldownModRate"] = true,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_selfPoint"] = "BOTTOM",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_n_format"] = "none",
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_p_format"] = "timed",
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Condensed Black",
["text_shadowYOffset"] = 0,
["text_anchorYOffset"] = 1,
["text_fontType"] = "OUTLINE",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "TOP",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 13,
["anchorXOffset"] = 0,
["text_text_format_p_time_mod_rate"] = true,
},
},
["height"] = 48,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["load"] = {
["use_petbattle"] = false,
["use_never"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["size"] = {
["multi"] = {
["party"] = true,
["flexible"] = true,
["ten"] = true,
["twentyfive"] = true,
["twenty"] = true,
["fortyman"] = true,
},
},
["use_size"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["instance_type"] = {
["multi"] = {
nil,
nil,
true,
true,
true,
true,
nil,
true,
[17] = true,
[15] = true,
[33] = true,
[14] = true,
[16] = true,
[192] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["difficulty"] = {
},
["use_spellknown"] = false,
["use_vehicleUi"] = false,
["talent"] = {
["multi"] = {
[101841] = true,
},
},
["use_combat"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["cooldown"] = false,
["source"] = "import",
["displayIcon"] = 4497577,
["xOffset"] = 0,
["icon"] = true,
["config"] = {
},
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar 3",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["width"] = 48,
["frameStrata"] = 3,
["adjustedMax"] = "",
["anchorFrameParent"] = false,
["cooldownTextDisabled"] = true,
["auto"] = false,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Phial",
["authorOptions"] = {
},
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["color"] = {
1,
1,
1,
1,
},
["uid"] = "udP0k1rRHiw",
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[ENH] 4||Crash Lightning Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["backgroundColor"] = {
0.1294117718935013,
0.250980406999588,
0.250980406999588,
1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0.50980392156863,
0.99607843137255,
0.99607843137255,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["zoneIds"] = "",
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "yxahtQ0hCnA",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Primary Auras",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["auranames"] = {
"187874",
},
["ownOnly"] = true,
["event"] = "Health",
["names"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["useExactSpellId"] = true,
["useName"] = false,
["auraspellids"] = {
"187878",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["type"] = "subborder",
["border_anchor"] = "bar",
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] 4||Crash Lightning",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["barColor2"] = {
1,
1,
0,
1,
},
["auto"] = true,
["anchorFrameParent"] = true,
["icon"] = false,
["authorOptions"] = {
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["semver"] = "10.0.51",
["sparkColor"] = {
1,
1,
1,
1,
},
["sparkHidden"] = "NEVER",
["id"] = "[ENH] 4||Crash Lightning Duration",
["frameStrata"] = 4,
["width"] = 48,
["anchorFrameType"] = "SELECTFRAME",
["config"] = {
},
["inverse"] = false,
["sparkHeight"] = 30,
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["zoom"] = 0,
},
["[SR] Background"] = {
["wagoID"] = "K-P_CgDIP",
["xOffset"] = 0,
["preferToUpdate"] = true,
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["rotation"] = 0,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 138,
["rotate"] = false,
["load"] = {
["use_dragonriding"] = true,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["source"] = "import",
["mirror"] = false,
["regionType"] = "texture",
["blendMode"] = "BLEND",
["texture"] = "ui-storm-headerorb",
["uid"] = "ltOWbcUpYXD",
["semver"] = "1.0.1",
["parent"] = "[SR] Skyriding",
["id"] = "[SR] Background",
["color"] = {
1,
0.9019608497619629,
0.6666666865348816,
1,
},
["frameStrata"] = 1,
["width"] = 114,
["alpha"] = 1,
["config"] = {
},
["authorOptions"] = {
},
["anchorFrameType"] = "SCREEN",
["conditions"] = {
},
["information"] = {
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
},
["[BWT] <=10s Ability Prefab"] = {
["iconSource"] = -1,
["wagoID"] = "CucqUEyfY",
["color"] = {
1,
1,
1,
1,
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = false,
["url"] = "https://wago.io/CucqUEyfY/10",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["type"] = "addons",
["subeventSuffix"] = "_CAST_START",
["remaining_operator"] = "<=",
["event"] = "Boss Mod Timer",
["unit"] = "player",
["remaining"] = "10",
["spellIds"] = {
},
["names"] = {
},
["subeventPrefix"] = "SPELL",
["use_remaining"] = true,
["use_cloneId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["activeTriggerMode"] = -10,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["colorR"] = 1,
["duration_type"] = "seconds",
["colorA"] = 1,
["colorG"] = 1,
["use_translate"] = true,
["colorB"] = 1,
["type"] = "custom",
["scalex"] = 1,
["easeType"] = "none",
["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
["scaley"] = 1,
["alpha"] = 0,
["easeStrength"] = 5,
["y"] = -220,
["x"] = 0,
["use_scale"] = false,
["scaleType"] = "straightScale",
["scaleFunc"] = "function(progress, startX, startY, scaleX, scaleY)\n    return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\nend\n",
["rotate"] = 0,
["translateType"] = "straightTranslate",
["duration"] = "10",
},
["finish"] = {
["type"] = "none",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "slidebottom",
["duration_type"] = "seconds",
},
},
["desaturate"] = false,
["version"] = 10,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_text_format_n_format"] = "none",
["text_text_format_s_format"] = "none",
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["type"] = "subtext",
["text_anchorXOffset"] = 4,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Medium",
["text_shadowYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "OUTER_RIGHT",
["text_visible"] = true,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_shadowXOffset"] = 0,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_text_format_p_gcd_cast"] = false,
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["rotateText"] = "NONE",
["text_text_format_p_decimal_precision"] = 0,
["text_text_format_p_gcd_gcd"] = true,
["text_color"] = {
1,
1,
1,
1,
},
["text_text_format_p_gcd_channel"] = false,
["text_shadowYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_text_format_p_gcd_hide_zero"] = false,
["text_fontSize"] = 15,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
["text_text_format_p_time_mod_rate"] = true,
["text_selfPoint"] = "CENTER",
["text_automaticWidth"] = "Auto",
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["type"] = "subtext",
["text_anchorXOffset"] = 1,
["text_font"] = "Fira Mono Bold",
["text_anchorYOffset"] = -1,
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_shadowXOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 5,
["text_text_format_p_format"] = "Number",
["text_text_format_p_big_number_format"] = "AbbreviateNumbers",
["text_text_format_p_time_format"] = 0,
},
{
["text_text_format_n_format"] = "none",
["text_text_format_s_format"] = "none",
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["type"] = "subtext",
["text_anchorXOffset"] = 4,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Medium",
["text_shadowYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "OUTER_RIGHT",
["text_visible"] = true,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_shadowXOffset"] = 0,
},
},
["height"] = 38,
["load"] = {
["use_size"] = false,
["use_never"] = false,
["instance_type"] = {
},
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
["flexible"] = true,
["ten"] = true,
["twentyfive"] = true,
["twenty"] = true,
["fortyman"] = true,
},
},
},
["useCooldownModRate"] = true,
["useAdjustededMax"] = false,
["width"] = 38,
["source"] = "import",
["cooldownEdge"] = false,
["parent"] = "[BWT] <=10s Ability Group",
["cooldown"] = false,
["displayIcon"] = "134377",
["useAdjustededMin"] = false,
["regionType"] = "icon",
["actions"] = {
["start"] = {
["do_custom"] = false,
},
["init"] = {
["do_custom"] = false,
},
["finish"] = {
["do_custom"] = false,
},
},
["preferToUpdate"] = false,
["config"] = {
["AnchorPoint"] = 1,
},
["authorOptions"] = {
{
["desc"] = "You can choose whether the name of the ability should be anchored to the right or to the left of the icon",
["type"] = "select",
["values"] = {
"Left",
"Right",
},
["default"] = 1,
["key"] = "AnchorPoint",
["useDesc"] = true,
["name"] = "Ability name anchor point",
["width"] = 1,
},
},
["keepAspectRatio"] = false,
["zoom"] = 0.3,
["cooldownTextDisabled"] = false,
["semver"] = "1.0.10",
["tocversion"] = 110000,
["id"] = "[BWT] <=10s Ability Prefab",
["alpha"] = 1,
["frameStrata"] = 3,
["anchorFrameType"] = "SELECTFRAME",
["xOffset"] = 0,
["uid"] = "yfR2GCsBij1",
["inverse"] = false,
["anchorFrameFrame"] = "WeakAuras:[BWT] Vertical Bar",
["conditions"] = {
{
["check"] = {
["trigger"] = -1,
["variable"] = "customcheck",
["value"] = "function (t)\n    if aura_env.config[\"AnchorPoint\"] == 2 then\n        return true\n    end\nend",
},
["changes"] = {
{
["value"] = false,
["property"] = "sub.3.text_visible",
},
{
["value"] = true,
["property"] = "sub.5.text_visible",
},
},
},
{
["check"] = {
["trigger"] = -1,
["variable"] = "customcheck",
["value"] = "function (t)\n    if aura_env.config[\"AnchorPoint\"] == 1 then\n        return true\n    end\nend\n\n\n",
},
["linked"] = true,
["changes"] = {
{
["value"] = true,
["property"] = "sub.3.text_visible",
},
{
["value"] = false,
["property"] = "sub.5.text_visible",
},
},
},
},
["information"] = {
},
["selfPoint"] = "TOP",
},
["[ENH] Spirit Walk"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOM",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Spirit Walk",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["type"] = "spell",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 58875,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
["ownOnly"] = true,
["auraspellids"] = {
"58875",
},
["unit"] = "player",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return (t[1] or t[2]) and (t[3] or (t[4] and t[5]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["useCooldownModRate"] = true,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_format"] = "Number",
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["anchorYOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_fontType"] = "OUTLINE",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowXOffset"] = 0,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 3,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["icon"] = true,
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101983] = true,
[127865] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["color"] = {
1,
1,
1,
1,
},
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["property"] = "cooldownSwipe",
},
{
["property"] = "sub.3.text_visible",
},
},
},
},
["xOffset"] = 97.5,
["selfPoint"] = "TOP",
["uid"] = "kywlg1ekYS2",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["auto"] = false,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Spirit Walk",
["parent"] = "Cooldowns",
["frameStrata"] = 3,
["width"] = 48,
["cooldownEdge"] = false,
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["[ENH] 3||Doom Winds"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Frost Shock",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 384352,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["alpha"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_shadowYOffset"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["parent"] = "Secondary Auras",
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101824] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_never"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["progressSource"] = {
-1,
"",
},
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["icon"] = true,
["xOffset"] = 0,
["uid"] = "JDss8iuzRZw",
["useAdjustededMin"] = false,
["regionType"] = "icon",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["anchorFrameType"] = "SCREEN",
["frameStrata"] = 3,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["auto"] = false,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 3||Doom Winds",
["preferToUpdate"] = false,
["useCooldownModRate"] = true,
["width"] = 48,
["url"] = "",
["config"] = {
},
["inverse"] = true,
["color"] = {
1,
1,
1,
1,
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["[ENH] Talents"] = {
["iconSource"] = 0,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "event",
["subeventSuffix"] = "_CAST_START",
["duration"] = "10",
["event"] = "Ready Check",
["unit"] = "player",
["spellIds"] = {
},
["names"] = {
},
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["frameStrata"] = 3,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_selfPoint"] = "BOTTOM",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_n_format"] = "none",
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_p_format"] = "timed",
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Condensed Black",
["text_shadowYOffset"] = 0,
["text_anchorYOffset"] = 1,
["text_fontType"] = "OUTLINE",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "TOP",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 13,
["anchorXOffset"] = 0,
["text_text_format_p_time_mod_rate"] = true,
},
},
["height"] = 48,
["xOffset"] = 0,
["load"] = {
["use_petbattle"] = false,
["use_never"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["size"] = {
["multi"] = {
["party"] = true,
["flexible"] = true,
["ten"] = true,
["twentyfive"] = true,
["twenty"] = true,
["fortyman"] = true,
},
},
["spec_position"] = {
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["instance_type"] = {
["multi"] = {
nil,
nil,
true,
true,
true,
true,
nil,
true,
[17] = true,
[15] = true,
[33] = true,
[14] = true,
[16] = true,
[192] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["difficulty"] = {
},
["use_spellknown"] = false,
["talent"] = {
["multi"] = {
[101841] = true,
},
},
["use_vehicleUi"] = false,
["use_size"] = false,
["use_combat"] = false,
["use_alive"] = true,
["use_class_and_spec"] = true,
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["value"] = 1,
["variable"] = "onCooldown",
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["parent"] = "Trash",
["selfPoint"] = "CENTER",
["uid"] = "ipydL1gi(7W",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar 3",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = false,
["zoom"] = 0,
["auto"] = false,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Talents",
["icon"] = true,
["useCooldownModRate"] = true,
["width"] = 48,
["authorOptions"] = {
},
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = 236544,
["cooldown"] = false,
["texYOffset"] = 0,
},
["[ENH] 3||Lightning Bolt"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Trash",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 188196,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Lightning Bolt",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["charges"] = "1",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["useName"] = false,
["useStacks"] = true,
["auranames"] = {
"344179",
},
["ownOnly"] = true,
["unit"] = "player",
["stacks"] = "5",
["auraspellids"] = {
"344179",
},
["type"] = "aura2",
["stacksOperator"] = ">=",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
["ownOnly"] = true,
["auraspellids"] = {
"375986",
},
["unit"] = "player",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["alpha"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["border_offset"] = -0.8,
["type"] = "subborder",
["border_color"] = {
1,
0,
0,
0.800000011920929,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowThickness"] = 2.6,
["glowYOffset"] = -0.6,
["glowColor"] = {
1,
0,
0,
1,
},
["glowDuration"] = 1,
["glowXOffset"] = -0.5,
["glowLength"] = 8,
["glow"] = false,
["glowScale"] = 1,
["glowLines"] = 7,
["glowBorder"] = false,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_visible"] = true,
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["xOffset"] = 0,
["load"] = {
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_spellknown"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["color"] = {
1,
1,
1,
1,
},
["useAdjustededMax"] = false,
["cooldown"] = true,
["source"] = "import",
["displayIcon"] = "",
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["config"] = {
},
["anchorFrameFrame"] = "WeakAuras:[ENH] Lava Lash (Elementalist)",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["width"] = 48,
["frameStrata"] = 3,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 3||Lightning Bolt",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["useCooldownModRate"] = true,
["anchorFrameType"] = "SCREEN",
["authorOptions"] = {
},
["uid"] = "aP40Hd5YTW8",
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 1,
},
["changes"] = {
{
["value"] = false,
["property"] = "sub.3.border_visible",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
{
["check"] = {
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
["linked"] = false,
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.useGlowColor",
},
{
["value"] = {
0,
0.9803922176361084,
0.760784387588501,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.4,
["property"] = "sub.4.glowFrequency",
},
},
},
{
["check"] = {
["op"] = ">=",
["checks"] = {
{
["trigger"] = 2,
["variable"] = "stacks",
["op"] = ">=",
["value"] = "8",
},
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
},
["trigger"] = 2,
["variable"] = "stacks",
["value"] = "8",
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.useGlowColor",
},
{
["value"] = {
1,
0,
0,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.3,
["property"] = "sub.4.glowFrequency",
},
},
["linked"] = true,
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[ENH] Windfury Weapon"] = {
["iconSource"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Buffs",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["matchesShowOn"] = "showOnMissing",
["use_weapon"] = true,
["spellName"] = 197214,
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["use_showOn"] = true,
["event"] = "Weapon Enchant",
["use_exact_spellName"] = false,
["use_track"] = true,
["itemName"] = 0,
["use_charges"] = false,
["genericShowOn"] = "showAlways",
["names"] = {
},
["use_unit"] = true,
["enchant"] = "5401",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["unit"] = "player",
["auraspellids"] = {
"33757",
},
["type"] = "item",
["use_genericShowOn"] = true,
["subeventPrefix"] = "SPELL",
["useExactSpellId"] = true,
["realSpellName"] = "Sundering",
["use_spellName"] = true,
["spellIds"] = {
},
["use_absorbMode"] = true,
["showOn"] = "showOnMissing",
["use_enchant"] = true,
["use_itemName"] = true,
["weapon"] = "main",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["useCooldownModRate"] = true,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 48,
["icon"] = true,
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101841] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_spellknown"] = false,
["use_combat"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["size"] = {
["multi"] = {
},
},
},
["authorOptions"] = {
},
["useAdjustededMax"] = false,
["cooldown"] = false,
["source"] = "import",
["displayIcon"] = 462329,
["xOffset"] = 0,
["url"] = "",
["config"] = {
},
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["width"] = 48,
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = false,
["zoom"] = 0,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Windfury Weapon",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["frameStrata"] = 3,
["anchorFrameType"] = "SCREEN",
["color"] = {
1,
1,
1,
1,
},
["uid"] = "5pR7pa72)ht",
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[ENH] Food"] = {
["iconSource"] = 0,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["auranames"] = {
"Well Fed",
},
["ownOnly"] = true,
["use_weapon"] = true,
["spellName"] = 197214,
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["use_showOn"] = true,
["event"] = "Weapon Enchant",
["use_exact_spellName"] = false,
["namePattern_name"] = "Phial of",
["useNamePattern"] = false,
["use_track"] = true,
["itemName"] = 0,
["use_charges"] = false,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["weapon"] = "off",
["useExactSpellId"] = false,
["names"] = {
},
["subeventPrefix"] = "SPELL",
["useName"] = true,
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["use_itemName"] = true,
["auraspellids"] = {
"382150",
},
["enchant"] = "5400",
["use_genericShowOn"] = true,
["use_unit"] = true,
["use_absorbMode"] = true,
["realSpellName"] = "Sundering",
["use_spellName"] = true,
["spellIds"] = {
},
["type"] = "aura2",
["showOn"] = "showOnMissing",
["use_enchant"] = true,
["matchesShowOn"] = "showOnMissing",
["namePattern_operator"] = "find('%s')",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "event",
["unit"] = "player",
["duration"] = "10",
["event"] = "Ready Check",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["frameStrata"] = 3,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_selfPoint"] = "BOTTOM",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_n_format"] = "none",
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_p_format"] = "timed",
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Condensed Black",
["text_shadowYOffset"] = 0,
["text_anchorYOffset"] = 1,
["text_fontType"] = "OUTLINE",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "TOP",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 13,
["anchorXOffset"] = 0,
["text_text_format_p_time_mod_rate"] = true,
},
},
["height"] = 48,
["xOffset"] = 0,
["load"] = {
["use_petbattle"] = false,
["use_never"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["size"] = {
["multi"] = {
["party"] = true,
["flexible"] = true,
["ten"] = true,
["twentyfive"] = true,
["twenty"] = true,
["fortyman"] = true,
},
},
["use_size"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["instance_type"] = {
["multi"] = {
nil,
nil,
true,
true,
true,
true,
nil,
true,
[17] = true,
[15] = true,
[33] = true,
[14] = true,
[16] = true,
[192] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["difficulty"] = {
},
["use_spellknown"] = false,
["use_vehicleUi"] = false,
["talent"] = {
["multi"] = {
[101841] = true,
},
},
["use_combat"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["icon"] = true,
["authorOptions"] = {
},
["uid"] = "Q38QCTS8fpl",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar 3",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = false,
["zoom"] = 0,
["auto"] = false,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Food",
["selfPoint"] = "CENTER",
["useCooldownModRate"] = true,
["width"] = 48,
["parent"] = "Trash",
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = 133950,
["cooldown"] = false,
["texYOffset"] = 0,
},
["Primary Auras"] = {
["controlledChildren"] = {
"[ENH] 1||Flame Shock",
"[ENH] 1||Flame Shock Duration",
"[ENH] 2||Lava Lash (Storm)",
"[ENH] 3||Stormstrike (Storm)",
"[ENH] 3||Windstrike",
"[ENH] 4||Crash Lightning",
"[ENH] 4||Crash Lightning Duration",
"[ENH] 5||Fire Nova",
},
["borderBackdrop"] = "Blizzard Tooltip",
["xOffset"] = 0,
["yOffset"] = 1,
["anchorPoint"] = "TOP",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["names"] = {
},
["event"] = "Health",
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["subRegions"] = {
},
["load"] = {
["size"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["alpha"] = 1,
["borderOffset"] = 4,
["selfPoint"] = "CENTER",
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["id"] = "Primary Auras",
["authorOptions"] = {
},
["frameStrata"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["uid"] = "VFKoa6uOXX6",
["borderInset"] = 1,
["groupIcon"] = 132314,
["config"] = {
},
["conditions"] = {
},
["information"] = {
},
["parent"] = "[ENH] Enhancement Shaman",
},
["[ENH] 4||Elemental Blast"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Elementalist",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["use_followoverride"] = false,
["use_trackcharge"] = true,
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "2",
["unit"] = "player",
["subeventSuffix"] = "_CAST_START",
["use_remaining"] = false,
["type"] = "spell",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Elemental Blast",
["use_spellName"] = true,
["spellIds"] = {
},
["use_charges"] = false,
["names"] = {
},
["spellName"] = 117014,
["use_track"] = true,
["trackcharge"] = "1",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["stacksOperator"] = ">=",
["auraspellids"] = {
"344179",
},
["ownOnly"] = true,
["unit"] = "player",
["stacks"] = "5",
["useStacks"] = true,
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["useCooldownModRate"] = true,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_visible"] = true,
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["glowDuration"] = 1,
["glowType"] = "Pixel",
["glowThickness"] = 1.8,
["glowYOffset"] = -0.6,
["glowColor"] = {
1,
0,
0,
1,
},
["useGlowColor"] = false,
["glowXOffset"] = -1,
["glowScale"] = 1,
["glow"] = false,
["glowLength"] = 8,
["glowLines"] = 7,
["glowBorder"] = false,
},
},
["height"] = 24,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["load"] = {
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[117750] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["url"] = "",
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["value"] = 1,
["variable"] = "show",
["trigger"] = 2,
["op"] = ">=",
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
{
["check"] = {
["op"] = ">=",
["checks"] = {
{
["trigger"] = 2,
["op"] = ">=",
["variable"] = "stacks",
["value"] = "8",
},
},
["trigger"] = 2,
["variable"] = "stacks",
["value"] = "8",
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.useGlowColor",
},
{
["value"] = 0.3,
["property"] = "sub.4.glowFrequency",
},
},
},
},
["icon"] = true,
["authorOptions"] = {
},
["uid"] = "6lriIbRuHwQ",
["anchorFrameFrame"] = "WeakAuras:[ENH] Ice Strike",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 4||Elemental Blast",
["xOffset"] = 48.75,
["frameStrata"] = 3,
["width"] = 48,
["color"] = {
1,
1,
1,
1,
},
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["[BWT] Vertical Bar"] = {
["wagoID"] = "CucqUEyfY",
["authorOptions"] = {
},
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "https://wago.io/CucqUEyfY/10",
["actions"] = {
["start"] = {
["do_custom"] = false,
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["use_absorbMode"] = true,
["genericShowOn"] = "showOnCooldown",
["names"] = {
},
["debuffType"] = "HELPFUL",
["type"] = "addons",
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["event"] = "Boss Mod Timer",
["spellName"] = 0,
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["use_unit"] = true,
["use_genericShowOn"] = true,
["unit"] = "player",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["activeTriggerMode"] = -10,
},
["internalVersion"] = 75,
["selfPoint"] = "TOP",
["desaturate"] = false,
["discrete_rotation"] = 0,
["version"] = 10,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "1 Pixel",
["type"] = "subborder",
},
},
["height"] = 220,
["rotate"] = false,
["load"] = {
["use_size"] = false,
["use_never"] = false,
["instance_type"] = {
},
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
["flexible"] = true,
["ten"] = true,
["twentyfive"] = true,
["twenty"] = true,
["fortyman"] = true,
},
},
},
["textureWrapMode"] = "CLAMP",
["source"] = "import",
["mirror"] = false,
["regionType"] = "texture",
["blendMode"] = "BLEND",
["frameStrata"] = 2,
["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
["xOffset"] = 0,
["rotation"] = 0,
["semver"] = "1.0.10",
["tocversion"] = 110000,
["id"] = "[BWT] Vertical Bar",
["color"] = {
1,
1,
1,
0.65999999642372,
},
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["parent"] = "[BWT] <=10s Ability Group",
["uid"] = "mlCSquEbLkB",
["width"] = 6,
["config"] = {
},
["conditions"] = {
},
["information"] = {
},
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
},
["[ENH] Lightning Bolt"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Lightning Bolt",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 188196,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["useName"] = false,
["useStacks"] = true,
["auraspellids"] = {
"344179",
},
["ownOnly"] = true,
["unit"] = "player",
["stacks"] = "5",
["auranames"] = {
"344179",
},
["useExactSpellId"] = true,
["stacksOperator"] = ">=",
["type"] = "aura2",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["unit"] = "player",
["ownOnly"] = true,
["auraspellids"] = {
"375986",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["auraspellids"] = {
"454015",
},
["unit"] = "player",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "TOPRIGHT",
["desaturate"] = false,
["frameStrata"] = 3,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_format"] = "Number",
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["glow"] = false,
["useGlowColor"] = true,
["glowType"] = "Pixel",
["glowLength"] = 8,
["glowYOffset"] = -1,
["glowColor"] = {
0.9686275124549866,
0.9686275124549866,
0.3137255012989044,
1,
},
["type"] = "subglow",
["glowXOffset"] = -1,
["glowDuration"] = 1,
["glowScale"] = 1,
["glowThickness"] = 1.8,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 42,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_never"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["parent"] = "Left Wing",
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
["op"] = "<",
},
{
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 4,
["variable"] = "show",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "stacks",
["value"] = "10",
["op"] = "==",
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
{
["value"] = {
0.5098039507865906,
0.9960784912109375,
0.9960784912109375,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.4,
["property"] = "sub.4.glowFrequency",
},
},
},
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 2,
["variable"] = "stacks",
["value"] = "5",
["op"] = ">=",
},
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
{
["value"] = {
0.0941176563501358,
0.9686275124549866,
0.8392157554626465,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.3,
["property"] = "sub.4.glowFrequency",
},
},
["linked"] = true,
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "stacks",
["value"] = "10",
["op"] = "==",
},
["linked"] = true,
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
{
["value"] = {
1,
0,
0,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.3,
["property"] = "sub.4.glowFrequency",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "stacks",
["op"] = ">=",
["value"] = "8",
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
["linked"] = true,
},
},
["xOffset"] = 0,
["adjustedMax"] = "",
["uid"] = "FkOlJKGu5Zd",
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameFrame"] = "WeakAuras:[ENH] Lava Lash (Elementalist)",
["anchorFrameType"] = "SCREEN",
["useCooldownModRate"] = true,
["keepAspectRatio"] = true,
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Lightning Bolt",
["url"] = "",
["alpha"] = 1,
["width"] = 42,
["authorOptions"] = {
},
["config"] = {
},
["inverse"] = true,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["[ENH] Flametongue Weapon"] = {
["iconSource"] = 0,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["matchesShowOn"] = "showOnMissing",
["use_weapon"] = true,
["spellName"] = 197214,
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["use_showOn"] = true,
["event"] = "Weapon Enchant",
["use_exact_spellName"] = false,
["use_track"] = true,
["itemName"] = 0,
["use_charges"] = false,
["genericShowOn"] = "showAlways",
["use_enchant"] = true,
["useExactSpellId"] = true,
["use_unit"] = true,
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "item",
["charges"] = "1",
["auraspellids"] = {
"33757",
},
["unit"] = "player",
["use_absorbMode"] = true,
["names"] = {
},
["use_genericShowOn"] = true,
["realSpellName"] = "Sundering",
["use_spellName"] = true,
["spellIds"] = {
},
["use_itemName"] = true,
["showOn"] = "showOnMissing",
["enchant"] = "5400",
["subeventPrefix"] = "SPELL",
["weapon"] = "off",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["alpha"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
},
["height"] = 48,
["cooldownEdge"] = false,
["load"] = {
["use_never"] = false,
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101841] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_combat"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_spellknown"] = false,
["size"] = {
["multi"] = {
},
},
},
["xOffset"] = 0,
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
},
["icon"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["uid"] = "LGoc5a9YuDX",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar 3",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["frameStrata"] = 3,
["adjustedMax"] = "",
["anchorFrameParent"] = false,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Flametongue Weapon",
["parent"] = "Buffs",
["useCooldownModRate"] = true,
["width"] = 48,
["authorOptions"] = {
},
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = 135814,
["cooldown"] = false,
["texYOffset"] = 0,
},
["Buffs"] = {
["controlledChildren"] = {
"[ENH] Flametongue Weapon",
"[ENH] Windfury Weapon",
"[ENH] Lightning Shield",
"[ENH] Skyfury",
},
["borderBackdrop"] = "Blizzard Tooltip",
["parent"] = "[ENH] Enhancement Shaman",
["yOffset"] = 116,
["anchorPoint"] = "CENTER",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["names"] = {
},
["event"] = "Health",
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["subRegions"] = {
},
["load"] = {
["size"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["borderOffset"] = 4,
["borderInset"] = 1,
["alpha"] = 1,
["id"] = "Buffs",
["xOffset"] = 0,
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["authorOptions"] = {
},
["config"] = {
},
["groupIcon"] = "237538",
["selfPoint"] = "CENTER",
["conditions"] = {
},
["information"] = {
},
["uid"] = "1jQABEpirJ3",
},
["[ENH] Astral Shift"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["xOffset"] = -97.5,
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOM",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 108271,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Astral Shift",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["type"] = "spell",
["use_track"] = true,
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["unit"] = "player",
["ownOnly"] = true,
["auraspellids"] = {
"108271",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return (t[1] or t[2]) and (t[3] or (t[4] and t[5]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["desaturate"] = false,
["frameStrata"] = 3,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 3,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_format"] = "Number",
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_visible"] = true,
["text_text_format_p_time_precision"] = 1,
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["parent"] = "Cooldowns",
["load"] = {
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101945] = true,
[127893] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_spellknown"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["color"] = {
1,
1,
1,
1,
},
["useAdjustededMax"] = false,
["cooldown"] = true,
["source"] = "import",
["displayIcon"] = "",
["cooldownEdge"] = false,
["icon"] = true,
["config"] = {
},
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["width"] = 48,
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["zoom"] = 0,
["auto"] = false,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Astral Shift",
["selfPoint"] = "TOP",
["useCooldownModRate"] = true,
["anchorFrameType"] = "SCREEN",
["authorOptions"] = {
},
["uid"] = "H8ELdtIaVsf",
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["property"] = "cooldownSwipe",
},
{
["property"] = "sub.3.text_visible",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = -0.1,
},
["[ENH] 3||Hot Hand Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["authorOptions"] = {
},
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["icon"] = false,
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
1,
0.3686274588108063,
0,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["size"] = {
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101809] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_class_and_spec"] = true,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["zoneIds"] = "",
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["auto"] = true,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "3kt0c(uxSPq",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Elementalist",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["useName"] = false,
["subeventSuffix"] = "_CAST_START",
["ownOnly"] = true,
["event"] = "Health",
["subeventPrefix"] = "SPELL",
["auraspellids"] = {
"215785",
},
["useExactSpellId"] = true,
["spellIds"] = {
},
["type"] = "aura2",
["auranames"] = {
"188389",
},
["unit"] = "player",
["names"] = {
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] 3||Lava Lash (Elementalist)",
["sparkColor"] = {
1,
1,
1,
1,
},
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["sparkHeight"] = 30,
["anchorFrameParent"] = true,
["xOffset"] = 0.000244140625,
["backgroundColor"] = {
0.250980406999588,
0.0941176563501358,
0,
1,
},
["config"] = {
},
["semver"] = "10.0.51",
["sparkHidden"] = "NEVER",
["id"] = "[ENH] 3||Hot Hand Duration",
["width"] = 48,
["frameStrata"] = 4,
["anchorFrameType"] = "SELECTFRAME",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["spark"] = false,
["inverse"] = false,
["zoom"] = 0,
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["adjustedMax"] = "18",
},
["[ENH] 1||Flame Shock"] = {
["texXOffset"] = 0,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "target",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HARMFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["auraspellids"] = {
"188389",
},
["charges"] = "1",
["use_charges"] = false,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Flame Shock",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["spellName"] = 188389,
["useExactSpellId"] = true,
["use_track"] = true,
["matchesShowOn"] = "showAlways",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["unit"] = "target",
["useExactSpellId"] = true,
["matchesShowOn"] = "showOnMissing",
["ownOnly"] = true,
["auraspellids"] = {
"188389",
},
["debuffType"] = "HARMFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_format"] = "Number",
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_shadowXOffset"] = 0,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowThickness"] = 1.8,
["glowYOffset"] = -0.85,
["glowColor"] = {
1,
0,
0,
1,
},
["glowDuration"] = 1,
["glowXOffset"] = -0.58,
["glowLength"] = 8,
["glow"] = false,
["glowScale"] = 2,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 30,
["parent"] = "Primary Auras",
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101824] = false,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
["checks"] = {
{
["value"] = 1,
["variable"] = "show",
},
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
},
["source"] = "import",
["xOffset"] = -97.5,
["iconSource"] = 1,
["uid"] = "69HrFABn6VS",
["authorOptions"] = {
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["frameStrata"] = 3,
["progressSource"] = {
-1,
"",
},
["alpha"] = 1,
["anchorFrameParent"] = true,
["auto"] = false,
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 1||Flame Shock",
["url"] = "",
["useCooldownModRate"] = true,
["width"] = 48,
["adjustedMax"] = "",
["config"] = {
},
["inverse"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.1,
},
["[ENH] 3||Lava Lash (Elementalist)"] = {
["texXOffset"] = 0,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 60103,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Lava Lash",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["charges"] = "1",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["unit"] = "player",
["useName"] = false,
["type"] = "aura2",
["useExactSpellId"] = true,
["auranames"] = {
"Hot Hand",
},
["ownOnly"] = true,
["auraspellids"] = {
"215785",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["unit"] = "player",
["type"] = "aura2",
["stacksOperator"] = ">=",
["auraspellids"] = {
"390371",
},
["stacks"] = "8",
["useStacks"] = true,
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_precision"] = 1,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["anchorYOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fontSize"] = 14,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["glowDuration"] = 1,
["glowType"] = "Pixel",
["glowThickness"] = 1.8,
["glowYOffset"] = -0.85,
["glowColor"] = {
1,
0.5254902243614197,
0,
1,
},
["useGlowColor"] = false,
["glowXOffset"] = -0.5,
["glowScale"] = 2,
["glow"] = false,
["glowLength"] = 8,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 30,
["parent"] = "Elementalist",
["load"] = {
["use_never"] = false,
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101812] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_spellknown"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldown"] = true,
["useAdjustededMax"] = false,
["displayIcon"] = "",
["source"] = "import",
["authorOptions"] = {
},
["iconSource"] = 1,
["config"] = {
},
["xOffset"] = 0,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["width"] = 48,
["frameStrata"] = 3,
["progressSource"] = {
-1,
"",
},
["alpha"] = 1,
["anchorFrameParent"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 3||Lava Lash (Elementalist)",
["url"] = "",
["useCooldownModRate"] = true,
["anchorFrameType"] = "SCREEN",
["adjustedMax"] = "",
["uid"] = "z3oQ2gGm6j3",
["inverse"] = true,
["selfPoint"] = "BOTTOM",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = -0.1,
},
["[ENH] Stone Bulwark Totem Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["authorOptions"] = {
},
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
1,
1,
1,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["zoneIds"] = "",
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101803] = true,
[127911] = true,
},
},
["use_vehicle"] = false,
["use_class_and_spec"] = true,
["use_never"] = true,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_alive"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["sparkColor"] = {
1,
1,
1,
1,
},
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["auranames"] = {
"187874",
},
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["remaining"] = "0",
["use_totemName"] = true,
["use_absorbMode"] = true,
["useName"] = false,
["use_remaining"] = false,
["debuffType"] = "HELPFUL",
["subeventSuffix"] = "_CAST_START",
["type"] = "spell",
["use_absorbHealMode"] = true,
["auraspellids"] = {
"327942",
},
["remaining_operator"] = ">",
["useExactSpellId"] = true,
["event"] = "Totem",
["totemName"] = "108270",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["unit"] = "player",
["spellName"] = 0,
["use_unit"] = true,
["use_track"] = true,
["names"] = {
},
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_incombat"] = true,
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "unit",
["use_absorbHealMode"] = true,
["use_absorbMode"] = true,
["event"] = "Health",
["unit"] = "target",
["percenthealth"] = {
"0",
},
["use_unit"] = true,
["use_percenthealth"] = true,
["percenthealth_operator"] = {
">",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["use_attackable"] = true,
["unit"] = "target",
["use_absorbMode"] = true,
["event"] = "Unit Characteristics",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "custom",
["customTriggerLogic"] = "function(t)\n    return t[1] and (t[2] or (t[3] and t[4]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_size"] = 1,
["border_anchor"] = "bar",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Stone Bulwark Totem",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["barColor2"] = {
1,
1,
0,
1,
},
["auto"] = true,
["anchorFrameParent"] = false,
["xOffset"] = 0.000244140625,
["icon"] = false,
["backgroundColor"] = {
0.250980406999588,
0.250980406999588,
0.250980406999588,
1,
},
["semver"] = "10.0.51",
["uid"] = "a5q577IFXNr",
["id"] = "[ENH] Stone Bulwark Totem Duration",
["sparkHeight"] = 30,
["frameStrata"] = 4,
["anchorFrameType"] = "SELECTFRAME",
["width"] = 48,
["sparkHidden"] = "NEVER",
["inverse"] = false,
["config"] = {
},
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["zoom"] = 0,
},
["[ENH] 2||Frost Shock"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 196840,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Frost Shock",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["type"] = "spell",
["use_track"] = true,
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useStacks"] = true,
["auraspellids"] = {
"334196",
},
["ownOnly"] = true,
["unit"] = "player",
["stacks"] = "5",
["stacksOperator"] = ">=",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["unit"] = "player",
["type"] = "aura2",
["auranames"] = {
"Ice Strike",
"384357",
},
["auraspellids"] = {
"384357",
},
["useName"] = false,
["ownOnly"] = true,
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["useCooldownModRate"] = true,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_precision"] = 1,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["anchorYOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fontSize"] = 14,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowThickness"] = 1.8,
["glowYOffset"] = -0.85,
["glowColor"] = {
1,
0,
0,
1,
},
["glowDuration"] = 1,
["glowXOffset"] = -1,
["glowLength"] = 8,
["glow"] = false,
["glowScale"] = 1,
["glowLines"] = 7,
["glowBorder"] = false,
},
},
["height"] = 30,
["cooldownEdge"] = false,
["load"] = {
["use_never"] = false,
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101808] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_spellknown"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["progressSource"] = {
-1,
"",
},
["useAdjustededMax"] = false,
["cooldown"] = true,
["source"] = "import",
["displayIcon"] = "",
["xOffset"] = -48.75,
["parent"] = "Elementalist",
["config"] = {
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["adjustedMax"] = "",
["width"] = 48,
["alpha"] = 1,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["anchorFrameParent"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 2||Frost Shock",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["frameStrata"] = 3,
["anchorFrameType"] = "SCREEN",
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["uid"] = "UfFUUMSdDUJ",
["inverse"] = true,
["authorOptions"] = {
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["op"] = ">=",
["checks"] = {
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "stacks",
["op"] = ">=",
["value"] = "6",
},
},
},
["linked"] = false,
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
{
["value"] = true,
["property"] = "sub.4.useGlowColor",
},
{
["value"] = {
1,
0,
0,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.3,
["property"] = "sub.4.glowFrequency",
},
},
},
{
["check"] = {
["op"] = ">=",
["checks"] = {
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
},
["trigger"] = 2,
["variable"] = "stacks",
["value"] = "5",
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
["linked"] = true,
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[ENH] Arc Discharge"] = {
["xOffset"] = -8,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 8,
["anchorPoint"] = "BOTTOMLEFT",
["desaturateBackground"] = false,
["animationType"] = "loop",
["sameTexture"] = true,
["hideBackground"] = true,
["backgroundColor"] = {
0.5,
0.5,
0.5,
0.5,
},
["customForegroundRows"] = 16,
["frameRate"] = 15,
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "BOTTOMLEFT",
["customForegroundFileHeight"] = 0,
["customBackgroundRows"] = 16,
["customForegroundFileWidth"] = 0,
["authorOptions"] = {
},
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 140,
["customForegroundFrameHeight"] = 0,
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["spec"] = {
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
},
["use_herotalent"] = false,
["use_dragonriding"] = false,
["class"] = {
["multi"] = {
},
},
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["herotalent"] = {
["multi"] = {
[125616] = true,
},
},
["size"] = {
["multi"] = {
},
},
},
["customForegroundFrames"] = 0,
["useAdjustededMax"] = false,
["backgroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\stopmotion",
["customBackgroundColumns"] = 16,
["foregroundTexture"] = "dragonriding_sgvigor_decor_flipbook_right",
["backgroundPercent"] = 1,
["desaturateForeground"] = false,
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Chain Lightning",
["regionType"] = "stopmotion",
["foregroundColor"] = {
1,
1,
1,
1,
},
["endPercent"] = 1,
["startPercent"] = 0,
["useAdjustededMin"] = false,
["customForegroundColumns"] = 16,
["config"] = {
},
["blendMode"] = "BLEND",
["width"] = 86,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["customBackgroundFrames"] = 0,
["id"] = "[ENH] Arc Discharge",
["parent"] = "Right Wing",
["frameStrata"] = 1,
["customForegroundFrameWidth"] = 0,
["anchorFrameType"] = "SELECTFRAME",
["uid"] = "ctIZJw2DnjR",
["inverse"] = false,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["conditions"] = {
},
["information"] = {
},
["triggers"] = {
{
["trigger"] = {
["useName"] = false,
["useExactSpellId"] = true,
["event"] = "Health",
["unit"] = "player",
["auranames"] = {
"Arc Discharge",
},
["names"] = {
},
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["auraspellids"] = {
"455097",
},
["subeventSuffix"] = "_CAST_START",
["type"] = "aura2",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["activeTriggerMode"] = -10,
},
},
["Right Wing"] = {
["controlledChildren"] = {
"[ENH] Arc Discharge",
"[ENH] Chain Lightning",
"[ENH] Arc Discharge Duration",
},
["borderBackdrop"] = "Blizzard Tooltip",
["authorOptions"] = {
},
["groupIcon"] = 136049,
["anchorPoint"] = "TOPRIGHT",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["names"] = {
},
["event"] = "Health",
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["subRegions"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["frameStrata"] = 1,
["borderOffset"] = 4,
["parent"] = "[ENH] Enhancement Shaman",
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["id"] = "Right Wing",
["xOffset"] = 0.5,
["alpha"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["uid"] = "d(XL9v4ppdl",
["borderInset"] = 1,
["selfPoint"] = "CENTER",
["config"] = {
},
["conditions"] = {
},
["information"] = {
},
["yOffset"] = 0.5,
},
["[ENH] Tempest"] = {
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 8,
["anchorPoint"] = "BOTTOMRIGHT",
["desaturateBackground"] = false,
["animationType"] = "loop",
["sameTexture"] = true,
["hideBackground"] = true,
["backgroundColor"] = {
0.5,
0.5,
0.5,
0.5,
},
["triggers"] = {
{
["trigger"] = {
["useName"] = false,
["useExactSpellId"] = true,
["event"] = "Health",
["subeventPrefix"] = "SPELL",
["names"] = {
},
["auranames"] = {
},
["spellIds"] = {
},
["auraspellids"] = {
"454015",
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["type"] = "aura2",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["activeTriggerMode"] = -10,
},
["frameRate"] = 15,
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "BOTTOMRIGHT",
["customForegroundFileHeight"] = 0,
["customBackgroundRows"] = 16,
["customForegroundFileWidth"] = 0,
["customForegroundRows"] = 16,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 140,
["customForegroundFrameHeight"] = 0,
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["spec"] = {
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
},
["use_herotalent"] = false,
["use_dragonriding"] = false,
["class"] = {
["multi"] = {
},
},
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["herotalent"] = {
["multi"] = {
[117489] = true,
},
},
["size"] = {
["multi"] = {
},
},
},
["endPercent"] = 1,
["useAdjustededMax"] = false,
["backgroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\stopmotion",
["customBackgroundColumns"] = 16,
["foregroundTexture"] = "dragonriding_sgvigor_decor_flipbook_left",
["backgroundPercent"] = 1,
["foregroundColor"] = {
1,
1,
1,
1,
},
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Lightning Bolt",
["regionType"] = "stopmotion",
["startPercent"] = 0,
["customForegroundFrames"] = 0,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["xOffset"] = 8,
["customForegroundColumns"] = 16,
["uid"] = "0xqyUnt)ur2",
["customForegroundFrameWidth"] = 0,
["anchorFrameType"] = "SELECTFRAME",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["customBackgroundFrames"] = 0,
["id"] = "[ENH] Tempest",
["parent"] = "Left Wing",
["frameStrata"] = 1,
["width"] = 86,
["blendMode"] = "BLEND",
["config"] = {
},
["inverse"] = false,
["useAdjustededMin"] = false,
["conditions"] = {
},
["information"] = {
},
["desaturateForeground"] = false,
},
["[ENH] 4||Chain Lightning"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["xOffset"] = 48.75,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["use_followoverride"] = false,
["use_trackcharge"] = true,
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["trackcharge"] = "1",
["use_remaining"] = false,
["subeventSuffix"] = "_CAST_START",
["spellName"] = 188443,
["charges"] = "2",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Elemental Blast",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["type"] = "spell",
["use_track"] = true,
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useStacks"] = true,
["auraspellids"] = {
"344179",
},
["ownOnly"] = true,
["unit"] = "player",
["stacks"] = "5",
["stacksOperator"] = ">=",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["desaturate"] = false,
["color"] = {
1,
1,
1,
1,
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["border_size"] = 1,
["border_offset"] = -0.8,
["border_color"] = {
1,
0,
0,
0.800000011920929,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowThickness"] = 2.6,
["glowYOffset"] = -0.6,
["glowColor"] = {
1,
0,
0,
1,
},
["glowDuration"] = 1,
["glowXOffset"] = -1,
["glowLength"] = 8,
["glow"] = false,
["glowScale"] = 1,
["glowLines"] = 7,
["glowBorder"] = false,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_format"] = "Number",
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["url"] = "",
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101819] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["size"] = {
["multi"] = {
},
},
},
["progressSource"] = {
-1,
"",
},
["useAdjustededMax"] = false,
["cooldown"] = true,
["source"] = "import",
["displayIcon"] = "",
["selfPoint"] = "BOTTOM",
["preferToUpdate"] = false,
["config"] = {
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["authorOptions"] = {
},
["width"] = 48,
["alpha"] = 1,
["useCooldownModRate"] = true,
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["auto"] = false,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 4||Chain Lightning",
["parent"] = "Trash",
["frameStrata"] = 3,
["anchorFrameType"] = "SCREEN",
["anchorFrameFrame"] = "WeakAuras:[ENH] Ice Strike",
["uid"] = "dSayk9XYRtK",
["inverse"] = true,
["icon"] = true,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 1,
},
["changes"] = {
{
["value"] = false,
["property"] = "sub.3.border_visible",
},
},
},
{
["check"] = {
["value"] = 1,
["variable"] = "show",
["op"] = ">=",
["trigger"] = 2,
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
{
["check"] = {
["op"] = ">=",
["checks"] = {
{
["trigger"] = 2,
["op"] = ">=",
["value"] = "8",
["variable"] = "stacks",
},
},
["trigger"] = 2,
["variable"] = "stacks",
["value"] = "8",
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.useGlowColor",
},
{
["value"] = 0.3,
["property"] = "sub.4.glowFrequency",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[ENH] Maelstrom Background"] = {
["sparkWidth"] = 10,
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["preferToUpdate"] = false,
["adjustedMin"] = "100",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["auto"] = true,
["iconSource"] = -1,
["sparkRotation"] = 0,
["sparkRotationMode"] = "AUTO",
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["use_alwaystrue"] = true,
["use_absorbMode"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["use_genericShowOn"] = true,
["use_unit"] = true,
["custom_hide"] = "timed",
["spellName"] = 0,
["custom_type"] = "status",
["type"] = "custom",
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["events"] = "FAKE_EVENT",
["event"] = "Conditions",
["realSpellName"] = 0,
["customDuration"] = "function()\n    return 1,1,true\nend",
["use_spellName"] = true,
["custom"] = "function()\n    return true\nend",
["spellIds"] = {
},
["check"] = "event",
["debuffType"] = "HELPFUL",
["use_track"] = true,
["names"] = {
},
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_incombat"] = true,
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "unit",
["use_health"] = true,
["health_operator"] = {
">",
},
["use_absorbMode"] = true,
["event"] = "Health",
["unit"] = "target",
["use_absorbHealMode"] = true,
["health"] = {
"0",
},
["percenthealth"] = {
"0",
},
["use_unit"] = true,
["use_percenthealth"] = false,
["percenthealth_operator"] = {
">",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["use_attackable"] = true,
["unit"] = "target",
["use_absorbMode"] = true,
["event"] = "Unit Characteristics",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "custom",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
0,
100,
},
["selfPoint"] = "BOTTOM",
["parent"] = "Resources",
["adjustedMax"] = "0",
["barColor"] = {
0,
0.1725490242242813,
0.3294117748737335,
1,
},
["desaturate"] = false,
["xOffset"] = 0,
["icon"] = false,
["sparkOffsetY"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_size"] = 1,
["border_anchor"] = "bar",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["tick_rotation"] = 0,
["tick_xOffset"] = 0,
["tick_desaturate"] = false,
["use_texture"] = false,
["tick_placement_mode"] = "AtPercent",
["tick_texture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["tick_length"] = 30,
["tick_blend_mode"] = "ADD",
["type"] = "subtick",
["tick_placements"] = {
"20",
},
["automatic_length"] = true,
["tick_thickness"] = 1,
["tick_color"] = {
0,
0,
0,
1,
},
["tick_yOffset"] = 0,
["tick_visible"] = true,
["tick_mirror"] = false,
["progressSources"] = {
{
-2,
"",
},
},
},
{
["tick_rotation"] = 0,
["tick_xOffset"] = 0,
["tick_desaturate"] = false,
["use_texture"] = false,
["tick_placement_mode"] = "AtPercent",
["tick_texture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["tick_length"] = 30,
["tick_blend_mode"] = "ADD",
["type"] = "subtick",
["tick_placements"] = {
"40",
},
["automatic_length"] = true,
["tick_thickness"] = 1,
["tick_color"] = {
0,
0,
0,
1,
},
["tick_yOffset"] = 0,
["tick_visible"] = true,
["tick_mirror"] = false,
["progressSources"] = {
{
-2,
"",
},
},
},
{
["tick_rotation"] = 0,
["tick_xOffset"] = 0,
["tick_desaturate"] = false,
["use_texture"] = false,
["tick_placement_mode"] = "AtPercent",
["tick_texture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["tick_length"] = 30,
["tick_blend_mode"] = "ADD",
["type"] = "subtick",
["tick_placements"] = {
"60",
},
["automatic_length"] = true,
["tick_thickness"] = 1,
["tick_color"] = {
0,
0,
0,
1,
},
["tick_yOffset"] = 0,
["tick_visible"] = true,
["tick_mirror"] = false,
["progressSources"] = {
{
-2,
"",
},
},
},
{
["tick_rotation"] = 0,
["tick_xOffset"] = 0,
["tick_desaturate"] = false,
["use_texture"] = false,
["tick_placement_mode"] = "AtPercent",
["tick_texture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["tick_length"] = 30,
["tick_blend_mode"] = "ADD",
["type"] = "subtick",
["tick_placements"] = {
"80",
},
["automatic_length"] = true,
["tick_thickness"] = 1,
["tick_color"] = {
0,
0,
0,
1,
},
["tick_yOffset"] = 0,
["tick_visible"] = true,
["tick_mirror"] = false,
["progressSources"] = {
{
-2,
"",
},
},
},
},
["height"] = 27,
["textureSource"] = "LSM",
["load"] = {
["talent2"] = {
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_never"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_petbattle"] = false,
["size"] = {
["multi"] = {
},
},
},
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["enableGradient"] = false,
["source"] = "import",
["animation"] = {
["start"] = {
["colorR"] = 1,
["duration_type"] = "seconds",
["alphaType"] = "straight",
["colorB"] = 1,
["colorG"] = 1,
["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
["use_translate"] = true,
["use_alpha"] = true,
["type"] = "preset",
["easeType"] = "easeIn",
["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
["preset"] = "fade",
["alpha"] = 0,
["translateType"] = "straightTranslate",
["y"] = 0,
["x"] = 0,
["colorA"] = 1,
["rotate"] = 0,
["scaley"] = 1,
["easeStrength"] = 3,
["scalex"] = 1,
["duration"] = "1",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["config"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["backgroundColor"] = {
0,
0,
0,
0.6044447422027588,
},
["version"] = 252,
["icon_side"] = "RIGHT",
["gradientOrientation"] = "HORIZONTAL",
["semver"] = "10.0.51",
["sparkHeight"] = 30,
["texture"] = "Cell Default",
["sparkColor"] = {
1,
1,
1,
1,
},
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Maelstrom Background",
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["width"] = 244,
["zoom"] = 0,
["uid"] = "QYj5jT1AbXJ",
["inverse"] = false,
["sparkHidden"] = "NEVER",
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["frameStrata"] = 3,
},
["[BWT] >10s Ability Prefab"] = {
["iconSource"] = -1,
["wagoID"] = "CucqUEyfY",
["xOffset"] = 0,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = false,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
["do_custom"] = false,
},
["init"] = {
["do_custom"] = false,
},
["finish"] = {
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "addons",
["subeventSuffix"] = "_CAST_START",
["remaining_operator"] = ">",
["event"] = "Boss Mod Timer",
["unit"] = "player",
["remaining"] = "10",
["spellIds"] = {
},
["names"] = {
},
["subeventPrefix"] = "SPELL",
["use_remaining"] = true,
["use_cloneId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["activeTriggerMode"] = -10,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "TOP",
["desaturate"] = false,
["version"] = 10,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_text_format_n_format"] = "none",
["text_text_format_s_format"] = "none",
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["type"] = "subtext",
["text_anchorXOffset"] = 4,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Medium",
["text_shadowYOffset"] = -1,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "OUTER_RIGHT",
["text_visible"] = true,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_shadowXOffset"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_text_format_p_gcd_cast"] = false,
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["rotateText"] = "NONE",
["text_text_format_p_decimal_precision"] = 0,
["text_text_format_p_gcd_gcd"] = true,
["text_color"] = {
1,
1,
1,
1,
},
["text_text_format_p_gcd_channel"] = false,
["text_shadowYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_text_format_p_gcd_hide_zero"] = false,
["text_fontSize"] = 15,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
["text_text_format_p_time_mod_rate"] = true,
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["type"] = "subtext",
["text_anchorXOffset"] = 1,
["text_font"] = "Fira Mono Bold",
["text_anchorYOffset"] = -1,
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_shadowXOffset"] = 0,
["text_text_format_p_time_dynamic_threshold"] = 10,
["text_text_format_p_format"] = "Number",
["text_text_format_p_big_number_format"] = "AbbreviateNumbers",
["text_text_format_p_time_format"] = 0,
},
{
["text_text_format_n_format"] = "none",
["text_text_format_s_format"] = "none",
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["type"] = "subtext",
["text_anchorXOffset"] = 4,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Medium",
["text_shadowYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "OUTER_RIGHT",
["text_visible"] = true,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_shadowXOffset"] = 0,
},
},
["height"] = 38,
["load"] = {
["use_size"] = false,
["instance_type"] = {
},
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
["flexible"] = true,
["ten"] = true,
["twentyfive"] = true,
["twenty"] = true,
["fortyman"] = true,
},
},
},
["alpha"] = 1,
["useAdjustededMax"] = false,
["icon"] = true,
["source"] = "import",
["color"] = {
1,
1,
1,
1,
},
["cooldown"] = false,
["displayIcon"] = 134377,
["preferToUpdate"] = false,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["colorR"] = 1,
["duration_type"] = "seconds",
["colorA"] = 1,
["colorG"] = 1,
["use_translate"] = false,
["colorB"] = 1,
["type"] = "none",
["scalex"] = 1,
["easeType"] = "none",
["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
["scaley"] = 1,
["alpha"] = 0,
["easeStrength"] = 5,
["y"] = -220,
["x"] = 0,
["use_scale"] = false,
["scaleType"] = "straightScale",
["scaleFunc"] = "function(progress, startX, startY, scaleX, scaleY)\n    return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\nend\n",
["rotate"] = 0,
["translateType"] = "straightTranslate",
["duration"] = "10",
},
["finish"] = {
["type"] = "none",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "slidebottom",
["duration_type"] = "seconds",
},
},
["config"] = {
["AnchorPoint"] = 1,
},
["parent"] = "[BWT] >10s Ability Group",
["width"] = 38,
["anchorFrameParent"] = false,
["useCooldownModRate"] = true,
["zoom"] = 0,
["cooldownTextDisabled"] = false,
["semver"] = "1.0.10",
["tocversion"] = 110000,
["id"] = "[BWT] >10s Ability Prefab",
["url"] = "https://wago.io/CucqUEyfY/10",
["frameStrata"] = 3,
["anchorFrameType"] = "SELECTFRAME",
["anchorFrameFrame"] = "WeakAuras:[BWT] Vertical Bar",
["uid"] = "T9XAeAKCuKy",
["inverse"] = false,
["authorOptions"] = {
{
["desc"] = "You can choose whether the name of the ability should be anchored to the right or to the left of the icon",
["type"] = "select",
["values"] = {
"Left",
"Right",
},
["default"] = 1,
["key"] = "AnchorPoint",
["useDesc"] = true,
["name"] = "Ability name anchor point",
["width"] = 1,
},
},
["conditions"] = {
{
["check"] = {
["trigger"] = -1,
["variable"] = "customcheck",
["value"] = "function (t)\n    if aura_env.config[\"AnchorPoint\"] == 2 then\n        return true\n    end\nend",
},
["changes"] = {
{
["value"] = false,
["property"] = "sub.3.text_visible",
},
{
["value"] = true,
["property"] = "sub.5.text_visible",
},
},
},
{
["check"] = {
["trigger"] = -1,
["variable"] = "customcheck",
["value"] = "function (t)\n    if aura_env.config[\"AnchorPoint\"] == 1 then\n        return true\n    end\nend\n\n\n",
},
["linked"] = true,
["changes"] = {
{
["value"] = true,
["property"] = "sub.3.text_visible",
},
{
["value"] = false,
["property"] = "sub.5.text_visible",
},
},
},
},
["information"] = {
},
["keepAspectRatio"] = false,
},
["[ENH] 2||Feral Spirit"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Feral Spirit",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 51533,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["alpha"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_legacy_floor"] = false,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowXOffset"] = 0,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["color"] = {
1,
1,
1,
1,
},
["load"] = {
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101838] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["icon"] = true,
["selfPoint"] = "BOTTOM",
["uid"] = "4Ay3X8(LGdQ",
["anchorFrameFrame"] = "WeakAuras:[ENH] Frost Shock",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["useCooldownModRate"] = true,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 2||Feral Spirit",
["parent"] = "Secondary Auras",
["frameStrata"] = 3,
["width"] = 48,
["xOffset"] = -48.75,
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.1,
},
["[ENH] Ancestral Guidance Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["icon"] = false,
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0.1882353127002716,
0.7019608020782471,
1,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["size"] = {
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[102000] = true,
[128116] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_class_and_spec"] = true,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["zoneIds"] = "",
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["zoom"] = 0,
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["sparkColor"] = {
1,
1,
1,
1,
},
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["auranames"] = {
"187874",
},
["use_totemName"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["remaining"] = "0",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["spellName"] = 0,
["names"] = {
},
["useName"] = false,
["useExactSpellId"] = true,
["auraspellids"] = {
"108281",
},
["use_genericShowOn"] = true,
["type"] = "aura2",
["event"] = "Totem",
["totemName"] = "Healing Stream Totem",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["use_remaining"] = false,
["subeventSuffix"] = "_CAST_START",
["remaining_operator"] = ">",
["use_track"] = true,
["ownOnly"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_size"] = 1,
["border_anchor"] = "bar",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Ancestral Guidance",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["auto"] = true,
["sparkHeight"] = 30,
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["authorOptions"] = {
},
["backgroundColor"] = {
0.0470588281750679,
0.1764705926179886,
0.250980406999588,
1,
},
["semver"] = "10.0.51",
["config"] = {
},
["id"] = "[ENH] Ancestral Guidance Duration",
["anchorFrameParent"] = true,
["frameStrata"] = 4,
["width"] = 48,
["anchorFrameType"] = "SELECTFRAME",
["sparkHidden"] = "NEVER",
["inverse"] = false,
["uid"] = "zmUxVlMPrcD",
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
},
["[AB] Action Bar Background"] = {
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["uid"] = "AcLHgGOiwZD",
["frameStrata"] = 1,
["color"] = {
0.2313725650310516,
0.2313725650310516,
0.2313725650310516,
1,
},
["xOffset"] = 0,
["mirror"] = false,
["anchorFrameFrame"] = "MainMenuBar",
["regionType"] = "texture",
["information"] = {
},
["blendMode"] = "BLEND",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["authorOptions"] = {
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_FullWhite",
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
["activeTriggerMode"] = -10,
},
["internalVersion"] = 75,
["conditions"] = {
},
["selfPoint"] = "CENTER",
["id"] = "[AB] Action Bar Background",
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["alpha"] = 1,
["desaturate"] = false,
["rotation"] = 0,
["config"] = {
},
["anchorFrameType"] = "SELECTFRAME",
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 46,
["rotate"] = false,
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["width"] = 510,
},
["[ENH] 3||Windstrike"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Primary Auras",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = true,
["realSpellName"] = "Stormstrike",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["type"] = "spell",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 115356,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["unit"] = "player",
["auraspellids"] = {
"114051",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "unit",
["use_absorbHealMode"] = true,
["use_absorbMode"] = true,
["event"] = "Range Check",
["unit"] = "target",
["use_range"] = true,
["use_unit"] = true,
["range"] = "30",
["range_operator"] = "<=",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "custom",
["customTriggerLogic"] = "function(t)\n    return t[1] and t[2];\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["useCooldownModRate"] = true,
["progressSource"] = {
-1,
"",
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["glow"] = true,
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowLength"] = 8,
["glowYOffset"] = -0.85,
["glowColor"] = {
1,
1,
1,
1,
},
["type"] = "subglow",
["glowXOffset"] = -0.5,
["glowThickness"] = 1.8,
["glowScale"] = 1,
["glowDuration"] = 1,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 30,
["cooldownEdge"] = false,
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["size"] = {
["multi"] = {
},
},
["talent2"] = {
["multi"] = {
[114291] = true,
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101816] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_talent2"] = false,
["use_spellknown"] = false,
["use_vehicleUi"] = false,
["use_alive"] = true,
["use_class_and_spec"] = true,
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["source"] = "import",
["color"] = {
1,
1,
1,
1,
},
["adjustedMax"] = "",
["uid"] = "g6ThjQdNqUj",
["authorOptions"] = {
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["texXOffset"] = 0,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["anchorFrameParent"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 3||Windstrike",
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["frameStrata"] = 3,
["width"] = 48,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["config"] = {
},
["inverse"] = true,
["xOffset"] = 0,
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.1,
},
["[ENH] 3||Doom Winds Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["adjustedMax"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["icon"] = false,
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0.7019608020782471,
0.874509871006012,
1,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
["use_class_and_spec"] = true,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_alive"] = true,
["use_never"] = false,
["zoneIds"] = "",
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "OIsMOUwwY44",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Secondary Auras",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["auraspellids"] = {
"384352",
},
["ownOnly"] = true,
["event"] = "Health",
["unit"] = "player",
["useExactSpellId"] = true,
["auranames"] = {
},
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["subeventSuffix"] = "_CAST_START",
["useName"] = false,
["names"] = {
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_size"] = 1,
["border_anchor"] = "bar",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] 3||Doom Winds",
["zoom"] = 0,
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["preferToUpdate"] = false,
["anchorFrameParent"] = true,
["backgroundColor"] = {
0.1294117718935013,
0.250980406999588,
0.250980406999588,
1,
},
["sparkHeight"] = 30,
["config"] = {
},
["semver"] = "10.0.51",
["id"] = "[ENH] 3||Doom Winds Duration",
["sparkHidden"] = "NEVER",
["anchorFrameType"] = "SELECTFRAME",
["frameStrata"] = 4,
["width"] = 48,
["auto"] = true,
["sparkColor"] = {
1,
1,
1,
1,
},
["inverse"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["authorOptions"] = {
},
},
["Elementalist"] = {
["backdropColor"] = {
1,
1,
1,
0.5,
},
["controlledChildren"] = {
"[ENH] 1||Primordial Wave Duration",
"[ENH] 2||Frost Shock",
"[ENH] 3||Lava Lash (Elementalist)",
"[ENH] 3||Hot Hand Duration",
"[ENH] 5||Stormstrike (Elementalist)",
"[ENH] 4||Elemental Blast",
"[ENH] 4||Ice Strike",
},
["borderBackdrop"] = "Blizzard Tooltip",
["authorOptions"] = {
},
["borderEdge"] = "Square Full White",
["border"] = false,
["yOffset"] = 0,
["regionType"] = "group",
["borderSize"] = 2,
["selfPoint"] = "CENTER",
["borderColor"] = {
0,
0,
0,
1,
},
["scale"] = 1,
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["names"] = {
},
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
},
["anchorPoint"] = "CENTER",
["internalVersion"] = 75,
["xOffset"] = 0,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["id"] = "Elementalist",
["borderOffset"] = 4,
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["uid"] = "gtzsFfPTjII",
["borderInset"] = 1,
["load"] = {
["size"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
},
["subRegions"] = {
},
["frameStrata"] = 1,
["conditions"] = {
},
["information"] = {
},
["config"] = {
},
},
["[ENH] Tremor Totem"] = {
["iconSource"] = -1,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 100,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["debuffType"] = "HELPFUL",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnReady",
["unit"] = "player",
["realSpellName"] = "Tremor Totem",
["use_spellName"] = true,
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["names"] = {
},
["event"] = "Cooldown Progress (Spell)",
["use_track"] = true,
["spellName"] = 8143,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["track"] = "auto",
["matchesShowOn"] = "showOnMissing",
["use_weapon"] = true,
["spellName"] = 8143,
["use_spellIds"] = true,
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["use_showOn"] = true,
["percenthealth"] = {
"0",
},
["event"] = "Cast",
["use_exact_spellName"] = false,
["use_track"] = true,
["itemName"] = 0,
["use_enchant"] = true,
["use_charges"] = false,
["genericShowOn"] = "showOnReady",
["use_unit"] = true,
["use_itemName"] = true,
["use_totemName"] = true,
["use_genericShowOn"] = true,
["enchant"] = "5401",
["use_remaining"] = false,
["type"] = "unit",
["realSpellName"] = "Tremor Totem",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["unit"] = "target",
["auraspellids"] = {
"33757",
},
["useExactSpellId"] = true,
["names"] = {
},
["use_absorbMode"] = true,
["totemName"] = "8143",
["use_npcId"] = false,
["use_spellName"] = true,
["spellIds"] = {
255371,
},
["subeventPrefix"] = "SPELL",
["showOn"] = "showOnMissing",
["use_percenthealth"] = true,
["percenthealth_operator"] = {
">",
},
["weapon"] = "main",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["alpha"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["glowFrequency"] = 0.2,
["glow"] = true,
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowLength"] = 10,
["glowYOffset"] = -1.15,
["glowColor"] = {
1,
1,
1,
1,
},
["type"] = "subglow",
["glowXOffset"] = -0.6,
["glowThickness"] = 2.5,
["glowScale"] = 1,
["glowDuration"] = 1,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 48,
["cooldownEdge"] = false,
["load"] = {
["size"] = {
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101958] = true,
[127868] = true,
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_class_and_spec"] = true,
["use_zoneIds"] = true,
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_combat"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["zoneIds"] = "g275",
},
["xOffset"] = 0,
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = 2,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["icon"] = true,
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["uid"] = "G6JLAEvNmYo",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar 2",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["frameStrata"] = 3,
["adjustedMax"] = "",
["anchorFrameParent"] = false,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Tremor Totem",
["parent"] = "Trash",
["useCooldownModRate"] = true,
["width"] = 48,
["authorOptions"] = {
},
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = 136108,
["cooldown"] = false,
["texYOffset"] = 0,
},
["[ENH] Maelstrom Bar 4"] = {
["parent"] = "Resources",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["useStacks"] = true,
["auranames"] = {
"344179",
},
["matchesShowOn"] = "showOnActive",
["unit"] = "player",
["unitExists"] = false,
["stacks"] = "4",
["match_count"] = "4",
["debuffType"] = "HELPFUL",
["useName"] = false,
["stacksOperator"] = ">=",
["subeventSuffix"] = "_CAST_START",
["event"] = "Health",
["auraspellids"] = {
"344179",
},
["match_countOperator"] = ">=",
["spellIds"] = {
},
["useExactSpellId"] = true,
["type"] = "aura2",
["ownOnly"] = true,
["subeventPrefix"] = "SPELL",
["names"] = {
},
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["desaturate"] = false,
["rotation"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 26,
["rotate"] = false,
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
},
},
["talent"] = {
["multi"] = {
[101948] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["spec"] = {
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "texture",
["blendMode"] = "BLEND",
["anchorFrameParent"] = true,
["texture"] = "Interface\\AddOns\\WindfuryUI\\Textures\\MaelstromBar.tga",
["uid"] = "yAJ(ZoNLNUo",
["xOffset"] = 48.78,
["id"] = "[ENH] Maelstrom Bar 4",
["alpha"] = 1,
["frameStrata"] = 1,
["width"] = 48,
["anchorFrameType"] = "SELECTFRAME",
["config"] = {
},
["authorOptions"] = {
},
["color"] = {
0,
0.501960813999176,
1,
1,
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "totalStacks",
["value"] = "9",
["op"] = ">=",
},
["changes"] = {
{
["value"] = {
0.5098039507865906,
0.9960784912109375,
0.9960784912109375,
1,
},
["property"] = "color",
},
},
},
},
["information"] = {
},
["selfPoint"] = "CENTER",
},
["Cooldowns"] = {
["controlledChildren"] = {
"[ENH] Astral Shift",
"[ENH] Ancestral Guidance",
"[ENH] Stone Bulwark Totem",
"[ENH] Capacitor Totem",
"[ENH] Thunderstorm",
"[ENH] Healing Stream Totem",
"[ENH] Spirit Walk",
"[ENH] Astral Shift Duration",
"[ENH] Ancestral Guidance Duration",
"[ENH] Stone Bulwark Totem Duration",
"[ENH] Capacitor Totem Duration",
"[ENH] Healing Stream Totem Duration",
"[ENH] Spirit Walk Duration",
},
["borderBackdrop"] = "Blizzard Tooltip",
["parent"] = "Trash",
["yOffset"] = -15.25,
["anchorPoint"] = "BOTTOM",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["selfPoint"] = "CENTER",
["subRegions"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "group",
["borderSize"] = 2,
["frameStrata"] = 1,
["borderOffset"] = 4,
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["groupIcon"] = 538564,
["id"] = "Cooldowns",
["authorOptions"] = {
},
["alpha"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["borderInset"] = 1,
["uid"] = "nvQX7KTHqlP",
["borderEdge"] = "Square Full White",
["config"] = {
},
["conditions"] = {
},
["information"] = {
},
["xOffset"] = 0,
},
["[ENH] Target Health Bar"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOMRIGHT",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["sparkRotation"] = 0,
["sparkRotationMode"] = "AUTO",
["overlays"] = {
[2] = {
1,
1,
1,
1,
},
},
["icon"] = false,
["triggers"] = {
{
["trigger"] = {
["use_showAbsorb"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["use_absorbMode"] = true,
["absorbMode"] = "OVERLAY_FROM_END",
["names"] = {
},
["use_showIncomingHeal"] = true,
["spellIds"] = {
},
["event"] = "Health",
["subeventPrefix"] = "SPELL",
["use_unit"] = true,
["unit"] = "target",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return true\nend",
["activeTriggerMode"] = -10,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = true,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["barColor2"] = {
1,
0,
0,
1,
},
["text"] = false,
["barColor"] = {
0.7490196228027344,
0,
0,
1,
},
["desaturate"] = false,
["backgroundColor"] = {
0.2000000178813934,
0,
0,
0.6000000238418579,
},
["selfPoint"] = "BOTTOMLEFT",
["sparkOffsetY"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_shadowXOffset"] = 1,
["text_text"] = "%1.percenthealth",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_text_format_1.percenthealth_big_number_format"] = "AbbreviateNumbers",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_1.percenthealth_abbreviate_max"] = 8,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_1.percenthealth_format"] = "Number",
["text_text_format_1.percenthealth_abbreviate"] = false,
["text_text_format_1.percenthealth_realm_name"] = "never",
["type"] = "subtext",
["text_text_format_1.percenthealth_color"] = true,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_shadowYOffset"] = -1,
["text_anchorYOffset"] = 2,
["text_fontType"] = "None",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "INNER_BOTTOM",
["text_text_format_n_format"] = "none",
["text_text_format_1.percenthealth_decimal_precision"] = 0,
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_1.percenthealth_round_type"] = "round",
},
},
["height"] = 89.5,
["textureSource"] = "LSM",
["load"] = {
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["class"] = {
["multi"] = {
},
},
["use_dragonriding"] = false,
["spec"] = {
["multi"] = {
},
},
["use_vehicleUi"] = false,
["class_and_spec"] = {
["single"] = 263,
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["internalVersion"] = 75,
["parent"] = "Target Frame",
["uid"] = "EpaUFNrz7xp",
["sparkOffsetX"] = 0,
["width"] = 40,
["smoothProgress"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Player Health",
["regionType"] = "aurabar",
["alpha"] = 1,
["gradientOrientation"] = "VERTICAL",
["icon_side"] = "RIGHT",
["sparkHidden"] = "NEVER",
["overlayclip"] = true,
["texture"] = "Cell Default",
["overlaysTexture"] = {
"Clean",
"Clean",
},
["zoom"] = 0,
["spark"] = false,
["sparkHeight"] = 30,
["id"] = "[ENH] Target Health Bar",
["sparkColor"] = {
1,
1,
1,
1,
},
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["useAdjustededMin"] = false,
["config"] = {
},
["inverse"] = false,
["actions"] = {
["start"] = {
["do_custom"] = false,
["do_glow"] = false,
},
["finish"] = {
},
["init"] = {
["do_custom"] = false,
},
},
["orientation"] = "VERTICAL_INVERSE",
["conditions"] = {
},
["information"] = {
},
["authorOptions"] = {
},
},
["Target Frame"] = {
["controlledChildren"] = {
"[ENH] Target Health Bar",
"[ENH] Target Lashing Flame",
"[ENH] Target Flame Shock",
},
["borderBackdrop"] = "Blizzard Tooltip",
["authorOptions"] = {
},
["yOffset"] = -12,
["anchorPoint"] = "BOTTOMRIGHT",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["subeventPrefix"] = "SPELL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["names"] = {
},
["event"] = "Health",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["selfPoint"] = "CENTER",
["subRegions"] = {
},
["load"] = {
["size"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["frameStrata"] = 1,
["borderOffset"] = 4,
["xOffset"] = 0.5,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["id"] = "Target Frame",
["parent"] = "Trash",
["alpha"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["borderInset"] = 1,
["uid"] = "YseM(7Wbt3K",
["groupIcon"] = 236612,
["config"] = {
},
["conditions"] = {
},
["information"] = {
},
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
},
["[ENH] Astral Shift Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["backgroundColor"] = {
0.250980406999588,
0.2196078598499298,
0,
1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
1,
0.8823530077934265,
0,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["zoneIds"] = "",
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101945] = true,
[127893] = true,
},
},
["use_vehicle"] = false,
["use_class_and_spec"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_alive"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["auto"] = true,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "1WyXpp8WR7S",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["auranames"] = {
"187874",
},
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["names"] = {
},
["remaining"] = "0",
["ownOnly"] = true,
["debuffType"] = "HELPFUL",
["spellName"] = 0,
["subeventPrefix"] = "SPELL",
["type"] = "aura2",
["remaining_operator"] = ">",
["useExactSpellId"] = true,
["use_remaining"] = false,
["useName"] = false,
["event"] = "Totem",
["totemName"] = "Healing Stream Totem",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["auraspellids"] = {
"108271",
},
["use_totemName"] = true,
["use_track"] = true,
["unit"] = "player",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Astral Shift",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["barColor2"] = {
1,
1,
0,
1,
},
["spark"] = false,
["sparkHeight"] = 30,
["authorOptions"] = {
},
["icon"] = false,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["semver"] = "10.0.51",
["config"] = {
},
["id"] = "[ENH] Astral Shift Duration",
["anchorFrameParent"] = true,
["frameStrata"] = 4,
["width"] = 48,
["anchorFrameType"] = "SELECTFRAME",
["sparkHidden"] = "NEVER",
["inverse"] = false,
["sparkColor"] = {
1,
1,
1,
1,
},
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["zoom"] = 0,
},
["[ENH] 2||Feral Spirit Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["backgroundColor"] = {
0.1058823615312576,
0.2392157018184662,
0.250980406999588,
1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0.4196078777313232,
0.9529412388801575,
1,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["size"] = {
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101838] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_class_and_spec"] = true,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["zoneIds"] = "",
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["zoom"] = 0,
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["config"] = {
},
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Secondary Auras",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["spellId"] = {
51533,
},
["auranames"] = {
"187874",
},
["ownOnly"] = true,
["names"] = {
},
["debuffType"] = "HELPFUL",
["useName"] = false,
["auraspellids"] = {
"187878",
},
["duration"] = "15",
["event"] = "Combat Log",
["useExactSpellId"] = true,
["unit"] = "player",
["use_spellId"] = true,
["spellIds"] = {
},
["use_sourceUnit"] = true,
["type"] = "combatlog",
["subeventPrefix"] = "SPELL",
["sourceUnit"] = "player",
["subeventSuffix"] = "_CAST_SUCCESS",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] 2||Feral Spirit",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["auto"] = true,
["anchorFrameParent"] = true,
["authorOptions"] = {
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["icon"] = false,
["semver"] = "10.0.51",
["sparkHeight"] = 30,
["sparkHidden"] = "NEVER",
["sparkColor"] = {
1,
1,
1,
1,
},
["frameStrata"] = 4,
["anchorFrameType"] = "SELECTFRAME",
["width"] = 48,
["id"] = "[ENH] 2||Feral Spirit Duration",
["inverse"] = false,
["uid"] = "ECtNaLjuKQA",
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
},
["[SR] Skyriding"] = {
["controlledChildren"] = {
"[SR] Background",
"[SR] Surge Forward",
"[SR] Flying Speed",
"[SR] Lightning Rush VFX Left",
"[SR] Lightning Rush VFX Right",
"[SR] Static Charges",
"[SR] Lightning Rush",
"[SR] Whirling Surge",
},
["borderBackdrop"] = "Blizzard Tooltip",
["wagoID"] = "K-P_CgDIP",
["authorOptions"] = {
},
["preferToUpdate"] = true,
["yOffset"] = -274,
["anchorPoint"] = "CENTER",
["borderColor"] = {
0,
0,
0,
1,
},
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["names"] = {
},
["event"] = "Health",
["unit"] = "player",
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["desc"] = "Skyriding aura to keep track of movement speed and Static Charges.\n\nBased on https://wago.io/Afdc0wSAr and modified to suit my own needs.",
["version"] = 2,
["subRegions"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["source"] = "import",
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["config"] = {
},
["borderOffset"] = 4,
["semver"] = "1.0.1",
["tocversion"] = 100002,
["id"] = "[SR] Skyriding",
["selfPoint"] = "CENTER",
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["groupIcon"] = "4640477",
["uid"] = "CdWFPjG7zKy",
["borderInset"] = 1,
["xOffset"] = 6.103515884855691e-05,
["conditions"] = {
},
["information"] = {
},
["frameStrata"] = 1,
},
["[ENH] 3||Stormstrike (Storm)"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 17364,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = true,
["realSpellName"] = "Stormstrike",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["charges"] = "1",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
["matchesShowOn"] = "showOnMissing",
["auraspellids"] = {
"114051",
},
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
["ownOnly"] = true,
["auraspellids"] = {
"201846",
},
["unit"] = "player",
},
["untrigger"] = {
},
},
["disjunctive"] = "custom",
["customTriggerLogic"] = "function(t)\n    return t[1] and t[2];\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["useAdjustededMin"] = false,
["url"] = "",
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_format"] = "Number",
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_fontSize"] = 14,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowLength"] = 8,
["glowYOffset"] = -0.85,
["glowColor"] = {
1,
1,
1,
1,
},
["glow"] = false,
["glowXOffset"] = -0.5,
["glowDuration"] = 1,
["glowScale"] = 1,
["glowThickness"] = 1.8,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 30,
["keepAspectRatio"] = true,
["load"] = {
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101804] = true,
[101819] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_never"] = false,
["size"] = {
["multi"] = {
},
},
},
["cooldown"] = true,
["useAdjustededMax"] = false,
["displayIcon"] = "",
["source"] = "import",
["xOffset"] = 0,
["preferToUpdate"] = false,
["config"] = {
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "icon",
["width"] = 48,
["frameStrata"] = 3,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["useCooldownModRate"] = true,
["anchorFrameParent"] = true,
["auto"] = false,
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 3||Stormstrike (Storm)",
["texXOffset"] = 0,
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["color"] = {
1,
1,
1,
1,
},
["uid"] = "hoiXUFMamFl",
["inverse"] = true,
["parent"] = "Primary Auras",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
["checks"] = {
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = -0.1,
},
["[ENH] Maelstrom Bar 3"] = {
["authorOptions"] = {
},
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["useStacks"] = true,
["auranames"] = {
"344179",
},
["matchesShowOn"] = "showOnActive",
["subeventPrefix"] = "SPELL",
["unitExists"] = false,
["stacks"] = "3",
["match_count"] = "3",
["debuffType"] = "HELPFUL",
["useName"] = false,
["stacksOperator"] = ">=",
["subeventSuffix"] = "_CAST_START",
["event"] = "Health",
["auraspellids"] = {
"344179",
},
["match_countOperator"] = ">=",
["spellIds"] = {
},
["useExactSpellId"] = true,
["type"] = "aura2",
["names"] = {
},
["unit"] = "player",
["ownOnly"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["desaturate"] = false,
["rotation"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 26,
["rotate"] = false,
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
},
},
["talent"] = {
["multi"] = {
[101948] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["spec"] = {
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "texture",
["blendMode"] = "BLEND",
["anchorFrameParent"] = true,
["texture"] = "Interface\\AddOns\\WindfuryUI\\Textures\\MaelstromBar.tga",
["anchorFrameType"] = "SELECTFRAME",
["selfPoint"] = "CENTER",
["id"] = "[ENH] Maelstrom Bar 3",
["xOffset"] = 0,
["alpha"] = 1,
["width"] = 48,
["frameStrata"] = 1,
["uid"] = "90US0axat4s",
["color"] = {
0,
0.501960813999176,
1,
1,
},
["config"] = {
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "totalStacks",
["op"] = ">=",
["value"] = "8",
},
["changes"] = {
{
["value"] = {
0.5098039507865906,
0.9960784912109375,
0.9960784912109375,
1,
},
["property"] = "color",
},
},
},
},
["information"] = {
},
["parent"] = "Resources",
},
["[ENH] Arc Discharge Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.5,
["adjustedMax"] = "",
["yOffset"] = 0,
["anchorPoint"] = "RIGHT",
["sparkRotation"] = 0,
["url"] = "",
["backgroundColor"] = {
0.1294117718935013,
0.250980406999588,
0.250980406999588,
1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "LEFT",
["barColor"] = {
0.50980392156863,
0.99607843137255,
0.99607843137255,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "VERTICAL",
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["zoneIds"] = "",
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_herotalent"] = false,
["use_vehicleUi"] = false,
["size"] = {
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["herotalent"] = {
["multi"] = {
[125616] = true,
},
},
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "mSKux0Y3mPw",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Right Wing",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["auranames"] = {
"187874",
},
["ownOnly"] = true,
["event"] = "Health",
["names"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["useExactSpellId"] = true,
["useName"] = false,
["auraspellids"] = {
"455097",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_size"] = 1,
["border_anchor"] = "bar",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 42,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Chain Lightning",
["authorOptions"] = {
},
["icon_side"] = "RIGHT",
["barColor2"] = {
1,
1,
0,
1,
},
["anchorFrameParent"] = true,
["sparkHeight"] = 30,
["icon"] = false,
["sparkColor"] = {
1,
1,
1,
1,
},
["config"] = {
},
["semver"] = "10.0.51",
["id"] = "[ENH] Arc Discharge Duration",
["sparkHidden"] = "NEVER",
["zoom"] = 0,
["frameStrata"] = 4,
["width"] = 5,
["anchorFrameType"] = "SELECTFRAME",
["auto"] = true,
["inverse"] = false,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["orientation"] = "VERTICAL_INVERSE",
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["preferToUpdate"] = false,
},
["[ENH] 4||Crash Lightning"] = {
["texXOffset"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Primary Auras",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 187874,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Crash Lightning",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["charges"] = "1",
["use_track"] = true,
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Stormstrike (Elementalist)",
["iconSource"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_visible"] = true,
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 30,
["adjustedMax"] = "",
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101840] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_spellknown"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldown"] = true,
["useAdjustededMax"] = false,
["displayIcon"] = "",
["source"] = "import",
["xOffset"] = 48.75,
["icon"] = true,
["config"] = {
},
["authorOptions"] = {
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["progressSource"] = {
-1,
"",
},
["anchorFrameParent"] = true,
["auto"] = false,
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 4||Crash Lightning",
["useCooldownModRate"] = true,
["frameStrata"] = 3,
["width"] = 48,
["color"] = {
1,
1,
1,
1,
},
["uid"] = "HFfZlyWVWCp",
["inverse"] = true,
["url"] = "",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = -0.1,
},
["[ENH] Maelstrom Bar 5"] = {
["color"] = {
0,
0.501960813999176,
1,
1,
},
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["useStacks"] = true,
["auranames"] = {
"344179",
},
["matchesShowOn"] = "showOnActive",
["subeventPrefix"] = "SPELL",
["unitExists"] = false,
["stacks"] = "5",
["match_count"] = "5",
["debuffType"] = "HELPFUL",
["useName"] = false,
["stacksOperator"] = ">=",
["subeventSuffix"] = "_CAST_START",
["event"] = "Health",
["auraspellids"] = {
"344179",
},
["match_countOperator"] = ">=",
["spellIds"] = {
},
["useExactSpellId"] = true,
["type"] = "aura2",
["unit"] = "player",
["names"] = {
},
["ownOnly"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["desaturate"] = false,
["rotation"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 26,
["rotate"] = false,
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
},
},
["talent"] = {
["multi"] = {
[101948] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["spec"] = {
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "texture",
["blendMode"] = "BLEND",
["anchorFrameParent"] = true,
["texture"] = "Interface\\AddOns\\WindfuryUI\\Textures\\MaelstromBar.tga",
["anchorFrameType"] = "SELECTFRAME",
["selfPoint"] = "CENTER",
["id"] = "[ENH] Maelstrom Bar 5",
["xOffset"] = 97,
["alpha"] = 1,
["width"] = 48,
["frameStrata"] = 1,
["uid"] = "BXB8IaWWkUA",
["authorOptions"] = {
},
["config"] = {
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "totalStacks",
["op"] = ">=",
["value"] = "10",
},
["changes"] = {
{
["value"] = {
0.5098039507865906,
0.9960784912109375,
0.9960784912109375,
1,
},
["property"] = "color",
},
},
},
},
["information"] = {
},
["parent"] = "Resources",
},
["Left Wing"] = {
["controlledChildren"] = {
"[ENH] Tempest",
"[ENH] Lightning Bolt",
"[ENH] Tempest Duration",
},
["borderBackdrop"] = "Blizzard Tooltip",
["xOffset"] = -0.5,
["yOffset"] = 0.5,
["anchorPoint"] = "TOPLEFT",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["subRegions"] = {
},
["load"] = {
["size"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["alpha"] = 1,
["borderOffset"] = 4,
["selfPoint"] = "CENTER",
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["id"] = "Left Wing",
["authorOptions"] = {
},
["frameStrata"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["parent"] = "[ENH] Enhancement Shaman",
["uid"] = "CV1ap7OYNPv",
["config"] = {
},
["borderInset"] = 1,
["conditions"] = {
},
["information"] = {
},
["groupIcon"] = 136048,
},
["[ENH] 1||Primordial Wave"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["xOffset"] = -97.5,
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 375982,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Primordial Wave",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["type"] = "spell",
["use_track"] = true,
["unit"] = "player",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["unit"] = "target",
["useExactSpellId"] = true,
["matchesShowOn"] = "showOnMissing",
["ownOnly"] = true,
["auraspellids"] = {
"188389",
},
["debuffType"] = "HARMFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["desaturate"] = false,
["frameStrata"] = 3,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_visible"] = true,
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["useGlowColor"] = false,
["glowType"] = "Pixel",
["glowThickness"] = 1.8,
["glowYOffset"] = -0.6,
["glowColor"] = {
1,
0,
0,
1,
},
["glowDuration"] = 1,
["glowXOffset"] = -0.5,
["glowLength"] = 8,
["glow"] = false,
["glowScale"] = 1,
["glowLines"] = 7,
["glowBorder"] = false,
},
},
["height"] = 24,
["parent"] = "Secondary Auras",
["load"] = {
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101830] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_spellknown"] = false,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["color"] = {
1,
1,
1,
1,
},
["useAdjustededMax"] = false,
["cooldown"] = true,
["source"] = "import",
["displayIcon"] = "",
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["config"] = {
},
["anchorFrameFrame"] = "WeakAuras:[ENH] 1||Flame Shock",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["width"] = 48,
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["zoom"] = 0,
["auto"] = false,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 1||Primordial Wave",
["selfPoint"] = "BOTTOM",
["useCooldownModRate"] = true,
["anchorFrameType"] = "SCREEN",
["authorOptions"] = {
},
["uid"] = "8H2XsvDMjsJ",
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["value"] = 1,
["variable"] = "show",
["trigger"] = 2,
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[BWT] Bigwigs Timeline"] = {
["controlledChildren"] = {
"[BWT] >10s Ability Group",
"[BWT] <=10s Ability Group",
},
["borderBackdrop"] = "Blizzard Tooltip",
["wagoID"] = "CucqUEyfY",
["xOffset"] = 360,
["preferToUpdate"] = false,
["groupIcon"] = 2026009,
["anchorPoint"] = "CENTER",
["borderColor"] = {
0,
0,
0,
1,
},
["url"] = "https://wago.io/CucqUEyfY/10",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["unit"] = "player",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["desc"] = "Based on the very popular Raid Ability Timeline by Jodsderechte but with much less code.\nSee custom options tab for anchoring the name of the ability to the right or to the left of the icon.",
["version"] = 10,
["subRegions"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["source"] = "import",
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["anchorFrameParent"] = false,
["yOffset"] = 0,
["borderOffset"] = 4,
["semver"] = "1.0.10",
["tocversion"] = 110000,
["id"] = "[BWT] Bigwigs Timeline",
["authorOptions"] = {
},
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["frameStrata"] = 1,
["uid"] = "UCUACpt8qjO",
["borderInset"] = 1,
["config"] = {
},
["conditions"] = {
},
["information"] = {
},
["selfPoint"] = "CENTER",
},
["Trash"] = {
["backdropColor"] = {
1,
1,
1,
0.5,
},
["controlledChildren"] = {
"Cooldowns",
"[ENH] 5||Thunderstorm",
"[ENH] 4||Chain Lightning",
"[ENH] 3||Lightning Bolt",
"Target Frame",
"[ENH] Phial",
"[ENH] Food",
"[ENH] Talents",
"[ENH] Tremor Totem",
"[ENH] Target Cast",
},
["borderBackdrop"] = "Blizzard Tooltip",
["xOffset"] = 0,
["borderEdge"] = "Square Full White",
["border"] = false,
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["borderSize"] = 2,
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["borderColor"] = {
0,
0,
0,
1,
},
["authorOptions"] = {
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["regionType"] = "group",
["borderOffset"] = 4,
["scale"] = 1,
["selfPoint"] = "CENTER",
["id"] = "Trash",
["internalVersion"] = 75,
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["borderInset"] = 1,
["config"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["subRegions"] = {
},
["alpha"] = 1,
["conditions"] = {
},
["information"] = {
},
["uid"] = "akSTO28XhkM",
},
["[ENH] Capacitor Totem Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["authorOptions"] = {
},
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0.50980392156863,
0.99607843137255,
0.99607843137255,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["size"] = {
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101961] = true,
[101803] = false,
[127851] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_class_and_spec"] = true,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["zoneIds"] = "",
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["zoom"] = 0,
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["config"] = {
},
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["auranames"] = {
"187874",
},
["ownOnly"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["use_totemName"] = true,
["useName"] = false,
["auraspellids"] = {
"187878",
},
["useExactSpellId"] = true,
["spellName"] = 0,
["subeventSuffix"] = "_CAST_START",
["event"] = "Totem",
["totemName"] = "Capacitor Totem",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["type"] = "spell",
["unit"] = "player",
["use_genericShowOn"] = true,
["use_track"] = true,
["names"] = {
},
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Capacitor Totem",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["auto"] = true,
["sparkHeight"] = 30,
["icon"] = false,
["xOffset"] = 0.000244140625,
["backgroundColor"] = {
0.1294117718935013,
0.250980406999588,
0.250980406999588,
1,
},
["semver"] = "10.0.51",
["uid"] = "(nRB27hlkfJ",
["sparkHidden"] = "NEVER",
["anchorFrameParent"] = true,
["frameStrata"] = 4,
["anchorFrameType"] = "SELECTFRAME",
["width"] = 48,
["id"] = "[ENH] Capacitor Totem Duration",
["inverse"] = false,
["sparkColor"] = {
1,
1,
1,
1,
},
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
},
["[ENH] 1||Primordial Wave Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["authorOptions"] = {
},
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["backgroundColor"] = {
0.01960784383118153,
0.2313725650310516,
0.1960784494876862,
1,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0.0941176563501358,
0.9686275124549866,
0.8392157554626465,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["size"] = {
["multi"] = {
},
},
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101828] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_class_and_spec"] = true,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_alive"] = true,
["use_never"] = false,
["zoneIds"] = "",
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["zoom"] = 0,
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "vZEsOO8J5u3",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Elementalist",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["useName"] = false,
["subeventSuffix"] = "_CAST_START",
["ownOnly"] = true,
["event"] = "Health",
["subeventPrefix"] = "SPELL",
["auraspellids"] = {
"382043",
},
["useExactSpellId"] = true,
["spellIds"] = {
},
["type"] = "aura2",
["auranames"] = {
},
["unit"] = "player",
["names"] = {
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_size"] = 1,
["border_anchor"] = "bar",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] 1||Primordial Wave",
["adjustedMax"] = "18",
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["sparkHeight"] = 30,
["xOffset"] = 0.000244140625,
["auto"] = true,
["config"] = {
},
["semver"] = "10.0.51",
["id"] = "[ENH] 1||Primordial Wave Duration",
["sparkHidden"] = "NEVER",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["frameStrata"] = 4,
["anchorFrameType"] = "SELECTFRAME",
["width"] = 48,
["sparkColor"] = {
1,
1,
1,
1,
},
["inverse"] = false,
["anchorFrameParent"] = true,
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["icon"] = false,
},
["[ENH] Healing Stream Totem Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["icon"] = false,
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
0,
0.8352941870689392,
1,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["zoneIds"] = "",
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[127863] = true,
[101995] = false,
[101998] = true,
},
},
["use_vehicle"] = false,
["use_class_and_spec"] = true,
["use_never"] = true,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_alive"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "jFtgmD0AEop",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["auranames"] = {
"187874",
},
["use_totemName"] = true,
["genericShowOn"] = "showOnCooldown",
["names"] = {
},
["remaining"] = "0",
["use_genericShowOn"] = true,
["ownOnly"] = true,
["debuffType"] = "HELPFUL",
["useName"] = false,
["use_remaining"] = false,
["unit"] = "player",
["auraspellids"] = {
"187878",
},
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["event"] = "Totem",
["totemName"] = "Healing Stream Totem",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["spellName"] = 0,
["useExactSpellId"] = true,
["subeventPrefix"] = "SPELL",
["use_track"] = true,
["remaining_operator"] = ">",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_size"] = 1,
["border_anchor"] = "bar",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Healing Stream Totem",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["barColor2"] = {
1,
1,
0,
1,
},
["auto"] = true,
["anchorFrameParent"] = true,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["authorOptions"] = {
},
["backgroundColor"] = {
0,
0.207843154668808,
0.250980406999588,
1,
},
["semver"] = "10.0.51",
["sparkColor"] = {
1,
1,
1,
1,
},
["id"] = "[ENH] Healing Stream Totem Duration",
["config"] = {
},
["frameStrata"] = 4,
["width"] = 48,
["anchorFrameType"] = "SELECTFRAME",
["sparkHidden"] = "NEVER",
["inverse"] = false,
["sparkHeight"] = 30,
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["zoom"] = 0,
},
["[ENH] Healing Stream Totem"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOM",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Healing Stream Totem",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["type"] = "spell",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 5394,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["use_unit"] = true,
["use_totemType"] = false,
["debuffType"] = "HELPFUL",
["use_remaining"] = false,
["use_absorbHealMode"] = true,
["event"] = "Totem",
["totemName"] = "5394",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellName"] = 0,
["use_totemName"] = true,
["unit"] = "player",
["use_absorbMode"] = true,
["use_track"] = true,
["type"] = "spell",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return (t[1] or t[2]) and (t[3] or (t[4] and t[5]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["useCooldownModRate"] = true,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_format"] = "Number",
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["anchorYOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_fontType"] = "OUTLINE",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowXOffset"] = 0,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 3,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["cooldownEdge"] = false,
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[127863] = true,
[101995] = false,
[101998] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["color"] = {
1,
1,
1,
1,
},
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["value"] = false,
["property"] = "cooldownSwipe",
},
{
["property"] = "sub.3.text_visible",
},
},
},
},
["icon"] = true,
["selfPoint"] = "TOP",
["uid"] = "MB09NHjSiHu",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["cooldownTextDisabled"] = true,
["auto"] = false,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Healing Stream Totem",
["xOffset"] = 48.75,
["frameStrata"] = 3,
["width"] = 48,
["parent"] = "Cooldowns",
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.1,
},
["[ENH] Target Cast"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = -1.2,
["anchorPoint"] = "BOTTOM",
["sparkRotation"] = 0,
["sparkRotationMode"] = "AUTO",
["sparkHidden"] = "NEVER",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "unit",
["subeventSuffix"] = "_CAST_START",
["event"] = "Cast",
["subeventPrefix"] = "SPELL",
["spellIds"] = {
},
["use_unit"] = true,
["names"] = {
},
["unit"] = "target",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "spell",
["use_genericShowOn"] = true,
["event"] = "Cooldown Progress (Spell)",
["unit"] = "player",
["realSpellName"] = "Wind Shear",
["use_spellName"] = true,
["debuffType"] = "HELPFUL",
["genericShowOn"] = "showOnCooldown",
["use_track"] = true,
["spellName"] = 57994,
},
["untrigger"] = {
},
},
["disjunctive"] = "custom",
["customTriggerLogic"] = "function(t)\n    return t[1]\nend",
["activeTriggerMode"] = -10,
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "TOP",
["icon"] = false,
["barColor"] = {
0,
1,
0,
1,
},
["desaturate"] = false,
["barColor2"] = {
1,
1,
0,
1,
},
["backgroundColor"] = {
0,
0.250980406999588,
0,
0.5,
},
["sparkOffsetY"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_shadowXOffset"] = 1,
["text_text"] = "%n",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_mod_rate"] = true,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_p_format"] = "timed",
["type"] = "subtext",
["text_anchorXOffset"] = 3,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Condensed Medium",
["text_text_format_p_time_precision"] = 1,
["text_shadowYOffset"] = -1,
["text_text_format_n_format"] = "none",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "INNER_LEFT",
["text_fontType"] = "None",
["text_text_format_p_time_format"] = 0,
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_time_legacy_floor"] = false,
},
{
["text_shadowXOffset"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_precision"] = 1,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_n_format"] = "none",
["type"] = "subtext",
["text_anchorXOffset"] = -3,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Sans Medium",
["text_text_format_p_time_legacy_floor"] = false,
["text_shadowYOffset"] = -1,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "INNER_RIGHT",
["text_fontType"] = "None",
["text_text_format_p_format"] = "timed",
["text_fontSize"] = 13,
["anchorXOffset"] = 0,
["text_text_format_p_time_mod_rate"] = true,
},
},
["height"] = 24,
["textureSource"] = "LSM",
["load"] = {
["class_and_spec"] = {
["single"] = 263,
},
["use_never"] = true,
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["internalVersion"] = 75,
["authorOptions"] = {
},
["gradientOrientation"] = "HORIZONTAL",
["uid"] = "g1Ir(cQbWly",
["overlayclip"] = true,
["smoothProgress"] = true,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["anchorFrameType"] = "SELECTFRAME",
["alpha"] = 1,
["icon_side"] = "RIGHT",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["sparkHeight"] = 30,
["texture"] = "Cell Default",
["overlaysTexture"] = {
"Clean",
"Clean",
"Clean",
"Clean",
"Clean",
},
["zoom"] = 0,
["spark"] = false,
["parent"] = "Trash",
["id"] = "[ENH] Target Cast",
["sparkColor"] = {
1,
1,
1,
1,
},
["frameStrata"] = 1,
["width"] = 164,
["anchorFrameFrame"] = "WeakAuras:Target Health",
["config"] = {
},
["inverse"] = false,
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["orientation"] = "HORIZONTAL",
["conditions"] = {
{
["check"] = {
["value"] = 0,
["variable"] = "interruptible",
["trigger"] = 1,
},
["changes"] = {
{
["value"] = {
1,
0,
0,
1,
},
["property"] = "barColor",
},
{
["value"] = {
0.250980406999588,
0,
0,
0.5,
},
["property"] = "backgroundColor",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["linked"] = true,
["changes"] = {
{
["value"] = {
1,
0.501960813999176,
0,
1,
},
["property"] = "barColor",
},
{
["value"] = {
0.250980406999588,
0.125490203499794,
0,
0.5,
},
["property"] = "backgroundColor",
},
},
},
},
["information"] = {
},
["sparkOffsetX"] = 0,
},
["[SR] Surge Forward"] = {
["iconSource"] = 0,
["wagoID"] = "K-P_CgDIP",
["xOffset"] = 0,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 8,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["spellName"] = 372608,
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["event"] = "Cooldown Progress (Spell)",
["subeventPrefix"] = "SPELL",
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 76,
["load"] = {
["use_dragonriding"] = true,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = false,
["source"] = "import",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["config"] = {
},
["preferToUpdate"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["useAdjustededMin"] = false,
["regionType"] = "icon",
["cooldown"] = true,
["displayIcon"] = "",
["keepAspectRatio"] = false,
["authorOptions"] = {
},
["width"] = 76,
["useCooldownModRate"] = true,
["zoom"] = 0,
["semver"] = "1.0.1",
["cooldownTextDisabled"] = false,
["id"] = "[SR] Surge Forward",
["frameStrata"] = 1,
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["parent"] = "[SR] Skyriding",
["uid"] = "qxCemCOhc8G",
["inverse"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["conditions"] = {
},
["information"] = {
},
["color"] = {
1,
1,
1,
1,
},
},
["[ENH] Stone Bulwark Totem"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["color"] = {
1,
1,
1,
1,
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOM",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Capacitor Totem",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["type"] = "spell",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 108270,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["spellName"] = 0,
["type"] = "spell",
["event"] = "Totem",
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["totemName"] = "108270",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["use_totemName"] = true,
["names"] = {
},
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return (t[1] or t[2]) and (t[3] or (t[4] and t[5]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "TOP",
["desaturate"] = false,
["parent"] = "Cooldowns",
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_format"] = "Number",
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["anchorYOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_fontType"] = "OUTLINE",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowXOffset"] = 0,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 3,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["progressSource"] = {
-1,
"",
},
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101961] = true,
[101803] = false,
[127911] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["adjustedMax"] = "",
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["property"] = "cooldownSwipe",
},
{
["property"] = "sub.3.text_visible",
},
},
},
},
["authorOptions"] = {
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["uid"] = "6kC0wyokVY(",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["url"] = "",
["anchorFrameType"] = "SCREEN",
["useCooldownModRate"] = true,
["frameStrata"] = 3,
["anchorFrameParent"] = true,
["zoom"] = 0,
["auto"] = false,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Stone Bulwark Totem",
["useAdjustededMin"] = false,
["alpha"] = 1,
["width"] = 48,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["config"] = {
},
["inverse"] = true,
["xOffset"] = 0,
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.09999999999999998,
},
["[ENH] Enhancement Shaman"] = {
["controlledChildren"] = {
"Left Wing",
"Right Wing",
"Resources",
"Primary Auras",
"Secondary Auras",
"Buffs",
},
["borderBackdrop"] = "Blizzard Tooltip",
["xOffset"] = 0,
["groupIcon"] = 237581,
["anchorPoint"] = "CENTER",
["borderColor"] = {
0,
0,
0,
1,
},
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["names"] = {
},
["event"] = "Health",
["subeventPrefix"] = "SPELL",
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["selfPoint"] = "CENTER",
["subRegions"] = {
},
["load"] = {
["size"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["borderOffset"] = 4,
["config"] = {
},
["id"] = "[ENH] Enhancement Shaman",
["borderInset"] = 1,
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["authorOptions"] = {
},
["uid"] = "C6fkdPqYxn0",
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["yOffset"] = -276.5,
["conditions"] = {
},
["information"] = {
["groupOffset"] = false,
},
["alpha"] = 1,
},
["[ENH] 5||Wind Shear"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["xOffset"] = 97.5,
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Crash Lightning",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 57994,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["useAdjustededMin"] = false,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["anchorYOffset"] = 0,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_shadowXOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_format"] = "Number",
["text_shadowYOffset"] = 0,
["text_fontType"] = "OUTLINE",
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["adjustedMax"] = "",
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101840] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_never"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_spellknown"] = false,
["size"] = {
["multi"] = {
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["source"] = "import",
["url"] = "",
["color"] = {
1,
1,
1,
1,
},
["uid"] = "j4P5zf0M5yg",
["authorOptions"] = {
},
["anchorFrameFrame"] = "WeakAuras:[ENH] Stormstrike (Elementalist)",
["regionType"] = "icon",
["width"] = 48,
["frameStrata"] = 3,
["useCooldownModRate"] = true,
["keepAspectRatio"] = true,
["anchorFrameParent"] = true,
["semver"] = "10.0.51",
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] 5||Wind Shear",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["parent"] = "Secondary Auras",
["config"] = {
},
["inverse"] = true,
["texXOffset"] = 0,
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.05,
},
["[ENH] Spirit Walk Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = 0.000244140625,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["sparkRotation"] = 0,
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "TOP",
["barColor"] = {
1,
0.2980392277240753,
0,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "HORIZONTAL",
["load"] = {
["size"] = {
["multi"] = {
},
},
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
[101983] = true,
[127865] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_class_and_spec"] = true,
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_alive"] = true,
["use_never"] = true,
["zoneIds"] = "",
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["zoom"] = 0,
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["sparkColor"] = {
1,
1,
1,
1,
},
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["auranames"] = {
"187874",
},
["remaining_operator"] = ">",
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["remaining"] = "0",
["names"] = {
},
["spellName"] = 0,
["debuffType"] = "HELPFUL",
["use_totemName"] = true,
["useName"] = false,
["useExactSpellId"] = true,
["auraspellids"] = {
"58875",
},
["subeventSuffix"] = "_CAST_START",
["use_remaining"] = false,
["event"] = "Totem",
["totemName"] = "Healing Stream Totem",
["realSpellName"] = 0,
["use_spellName"] = true,
["spellIds"] = {
},
["type"] = "aura2",
["unit"] = "player",
["ownOnly"] = true,
["use_track"] = true,
["use_genericShowOn"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["type"] = "subborder",
["border_anchor"] = "bar",
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
},
["height"] = 5,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Spirit Walk",
["adjustedMax"] = "",
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["auto"] = true,
["anchorFrameParent"] = true,
["authorOptions"] = {
},
["backgroundColor"] = {
0.250980406999588,
0.07450980693101883,
0,
1,
},
["icon"] = false,
["semver"] = "10.0.51",
["config"] = {
},
["id"] = "[ENH] Spirit Walk Duration",
["sparkHeight"] = 30,
["frameStrata"] = 4,
["anchorFrameType"] = "SELECTFRAME",
["width"] = 48,
["sparkHidden"] = "NEVER",
["inverse"] = false,
["uid"] = "KjRUSRTWKaE",
["orientation"] = "HORIZONTAL",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
},
["[ENH] Lightning Shield"] = {
["iconSource"] = -1,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Buffs",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["auraspellids"] = {
"192106",
},
["ownOnly"] = true,
["event"] = "Health",
["subeventPrefix"] = "SPELL",
["subeventSuffix"] = "_CAST_START",
["spellIds"] = {
},
["unit"] = "player",
["names"] = {
},
["useExactSpellId"] = true,
["matchesShowOn"] = "showOnMissing",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t)\n    return t[2] or (t[3] and t[4])\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar 4",
["cooldownEdge"] = false,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
},
["height"] = 48,
["adjustedMax"] = "",
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101841] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_spellknown"] = false,
["use_combat"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldown"] = false,
["useAdjustededMax"] = false,
["displayIcon"] = 135814,
["source"] = "import",
["color"] = {
1,
1,
1,
1,
},
["authorOptions"] = {
},
["config"] = {
},
["texXOffset"] = 0.03,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["width"] = 48,
["frameStrata"] = 3,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["progressSource"] = {
-1,
"",
},
["anchorFrameParent"] = false,
["auto"] = false,
["zoom"] = 0,
["cooldownTextDisabled"] = true,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] Lightning Shield",
["useCooldownModRate"] = true,
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["xOffset"] = 0,
["uid"] = "8LXeog5nAzX",
["inverse"] = true,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["[ENH] Ancestral Guidance"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Cooldowns",
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOM",
["cooldownSwipe"] = true,
["url"] = "",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Ancestral Guidance",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 108281,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["unit"] = "player",
["ownOnly"] = true,
["auraspellids"] = {
"108281",
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "function(t)\n    return (t[1] or t[2]) and (t[3] or (t[4] and t[5]))\nend",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["alpha"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_text_format_p_time_precision"] = 1,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_legacy_floor"] = false,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowXOffset"] = 0,
["text_fontSize"] = 12,
["text_text_format_p_time_dynamic_threshold"] = 3,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["color"] = {
1,
1,
1,
1,
},
["load"] = {
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[102000] = true,
[128116] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["property"] = "cooldownSwipe",
},
{
["property"] = "sub.3.text_visible",
},
},
},
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["selfPoint"] = "TOP",
["uid"] = "vjQlGRHvFZR",
["anchorFrameFrame"] = "WeakAuras:Maelstrom Bar Background",
["regionType"] = "icon",
["useAdjustededMin"] = false,
["anchorFrameType"] = "SCREEN",
["useCooldownModRate"] = true,
["adjustedMax"] = "",
["anchorFrameParent"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Ancestral Guidance",
["authorOptions"] = {
},
["frameStrata"] = 3,
["width"] = 48,
["xOffset"] = -48.75,
["config"] = {
},
["inverse"] = true,
["progressSource"] = {
-1,
"",
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = -0.1,
},
["[ENH] 4||Ice Strike"] = {
["texXOffset"] = 0,
["wagoID"] = "4yz3N1TG7",
["xOffset"] = 48.75,
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Ice Strike",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["charges"] = "1",
["use_charges"] = false,
["use_track"] = true,
["spellName"] = 342240,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["iconSource"] = 1,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subborder",
["border_offset"] = 0,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_precision"] = 1,
["anchorXOffset"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["anchorYOffset"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_format"] = 0,
["text_shadowYOffset"] = 0,
["text_visible"] = true,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_anchorPoint"] = "CENTER",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fontSize"] = 14,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 30,
["cooldownEdge"] = false,
["load"] = {
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101821] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_dragonriding"] = false,
["size"] = {
["multi"] = {
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["useAdjustededMax"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["source"] = "import",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["progressSource"] = {
-1,
"",
},
["uid"] = "BGEvGMPayNO",
["parent"] = "Elementalist",
["useAdjustededMin"] = false,
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["frameStrata"] = 3,
["alpha"] = 1,
["icon"] = true,
["anchorFrameParent"] = true,
["auto"] = false,
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 4||Ice Strike",
["color"] = {
1,
1,
1,
1,
},
["useCooldownModRate"] = true,
["width"] = 48,
["adjustedMax"] = "",
["config"] = {
},
["inverse"] = true,
["authorOptions"] = {
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["[SR] Lightning Rush VFX Left"] = {
["customForegroundFrameWidth"] = 0,
["wagoID"] = "K-P_CgDIP",
["xOffset"] = -30,
["preferToUpdate"] = true,
["adjustedMin"] = "",
["yOffset"] = -18,
["anchorPoint"] = "CENTER",
["desaturateBackground"] = false,
["animationType"] = "loop",
["sameTexture"] = true,
["hideBackground"] = true,
["desaturateForeground"] = false,
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 418592,
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["event"] = "Action Usable",
["use_spellName"] = true,
["spellIds"] = {
},
["unit"] = "player",
["names"] = {
},
["use_ignoreoverride"] = true,
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["use_unit"] = true,
},
["untrigger"] = {
},
},
["activeTriggerMode"] = 1,
},
["frameRate"] = 15,
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "CENTER",
["customForegroundFileHeight"] = 0,
["customBackgroundRows"] = 16,
["customForegroundFileWidth"] = 0,
["source"] = "import",
["customForegroundRows"] = 16,
["anchorFrameType"] = "SCREEN",
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 36,
["customForegroundFrameHeight"] = 0,
["load"] = {
["use_spellknown"] = true,
["use_dragonriding"] = true,
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
["use_exact_spellknown"] = true,
["spec"] = {
["multi"] = {
},
},
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["parent"] = "[SR] Skyriding",
["useAdjustededMax"] = false,
["backgroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\stopmotion",
["customBackgroundColumns"] = 16,
["foregroundTexture"] = "dragonriding_sgvigor_decor_flipbook_left",
["backgroundPercent"] = 1,
["foregroundColor"] = {
1,
1,
1,
1,
},
["mirror"] = false,
["useAdjustededMin"] = false,
["regionType"] = "stopmotion",
["customForegroundFrames"] = 0,
["blendMode"] = "BLEND",
["uid"] = "U18CS9tWcbQ",
["backgroundColor"] = {
0.5,
0.5,
0.5,
0.5,
},
["customForegroundColumns"] = 16,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["authorOptions"] = {
},
["endPercent"] = 1,
["semver"] = "1.0.1",
["customBackgroundFrames"] = 0,
["id"] = "[SR] Lightning Rush VFX Left",
["url"] = "https://wago.io/K-P_CgDIP/2",
["frameStrata"] = 1,
["width"] = 36,
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["config"] = {
},
["inverse"] = false,
["startPercent"] = 0,
["conditions"] = {
},
["information"] = {
},
["adjustedMax"] = "",
},
["[ENH] Maelstrom Bar 2"] = {
["parent"] = "Resources",
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["useStacks"] = true,
["auranames"] = {
"344179",
},
["matchesShowOn"] = "showOnActive",
["names"] = {
},
["unitExists"] = false,
["stacks"] = "2",
["match_count"] = "2",
["debuffType"] = "HELPFUL",
["showClones"] = false,
["useName"] = false,
["stacksOperator"] = ">=",
["match_countOperator"] = ">=",
["event"] = "Health",
["useExactSpellId"] = true,
["subeventSuffix"] = "_CAST_START",
["auraspellids"] = {
"344179",
},
["spellIds"] = {
},
["type"] = "aura2",
["ownOnly"] = true,
["subeventPrefix"] = "SPELL",
["unit"] = "player",
["combineMode"] = "showLowest",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["desaturate"] = false,
["rotation"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 26,
["rotate"] = false,
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
},
},
["talent"] = {
["multi"] = {
[101948] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["spec"] = {
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "texture",
["blendMode"] = "BLEND",
["anchorFrameParent"] = true,
["texture"] = "Interface\\AddOns\\WindfuryUI\\Textures\\MaelstromBar.tga",
["uid"] = "sVcX9BtrQLS",
["selfPoint"] = "CENTER",
["id"] = "[ENH] Maelstrom Bar 2",
["alpha"] = 1,
["frameStrata"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["width"] = 48,
["config"] = {
},
["color"] = {
0,
0.501960813999176,
1,
1,
},
["xOffset"] = -48.8,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "totalStacks",
["value"] = "7",
["op"] = ">=",
},
["changes"] = {
{
["value"] = {
0.5098039507865906,
0.9960784912109375,
0.9960784912109375,
1,
},
["property"] = "color",
},
},
},
},
["information"] = {
},
["authorOptions"] = {
},
},
["[ENH] 5||Thunderstorm"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["charges"] = "1",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 51490,
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Crash Lightning",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["use_charges"] = false,
["type"] = "spell",
["use_track"] = true,
["unit"] = "player",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOM",
["desaturate"] = false,
["adjustedMax"] = "",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
},
["height"] = 24,
["texXOffset"] = 0,
["load"] = {
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101840] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_class"] = true,
["use_spellknown"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldown"] = true,
["useAdjustededMax"] = false,
["displayIcon"] = "",
["source"] = "import",
["color"] = {
1,
1,
1,
1,
},
["parent"] = "Trash",
["config"] = {
},
["icon"] = true,
["anchorFrameFrame"] = "WeakAuras:[ENH] Stormstrike (Elementalist)",
["regionType"] = "icon",
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["progressSource"] = {
-1,
"",
},
["useAdjustededMin"] = false,
["anchorFrameParent"] = true,
["auto"] = false,
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["tocversion"] = 100107,
["id"] = "[ENH] 5||Thunderstorm",
["useCooldownModRate"] = true,
["frameStrata"] = 3,
["width"] = 48,
["xOffset"] = 97.5,
["uid"] = "FNNg6RNWukl",
["inverse"] = true,
["cooldownEdge"] = false,
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0.1,
},
["[ENH] Target Flame Shock"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["preferToUpdate"] = false,
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "BOTTOMRIGHT",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["useExactSpellId"] = true,
["ownOnly"] = true,
["event"] = "Health",
["unit"] = "target",
["auraspellids"] = {
"188389",
},
["spellIds"] = {
},
["matchesShowOn"] = "showOnActive",
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["names"] = {
},
["debuffType"] = "HARMFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["selfPoint"] = "BOTTOMLEFT",
["desaturate"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Target Health Bar",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_size"] = 1,
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_offset"] = 0,
},
},
["height"] = 26,
["xOffset"] = 1,
["load"] = {
["use_petbattle"] = false,
["use_never"] = true,
["talent"] = {
["multi"] = {
[101824] = false,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_spellknown"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["use_spec"] = true,
["use_class_and_spec"] = true,
["use_alive"] = true,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["cooldown"] = true,
["useAdjustededMax"] = false,
["displayIcon"] = "",
["source"] = "import",
["texXOffset"] = 0,
["url"] = "",
["config"] = {
},
["color"] = {
1,
1,
1,
1,
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["width"] = 26,
["frameStrata"] = 3,
["progressSource"] = {
-1,
"",
},
["useCooldownModRate"] = true,
["anchorFrameParent"] = true,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["zoom"] = 0,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Target Flame Shock",
["icon"] = true,
["alpha"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["adjustedMax"] = "",
["uid"] = "7a9FjiSTSL(",
["inverse"] = false,
["parent"] = "Target Frame",
["conditions"] = {
},
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["texYOffset"] = 0,
},
["Secondary Auras"] = {
["controlledChildren"] = {
"[ENH] 1||Primordial Wave",
"[ENH] 2||Feral Spirit",
"[ENH] 2||Feral Spirit Duration",
"[ENH] 3||Doom Winds",
"[ENH] 3||Doom Winds Duration",
"[ENH] 4||Sundering",
"[ENH] 5||Wind Shear",
},
["borderBackdrop"] = "Blizzard Tooltip",
["authorOptions"] = {
},
["groupIcon"] = 237577,
["anchorPoint"] = "TOP",
["borderColor"] = {
0,
0,
0,
1,
},
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["subRegions"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["frameStrata"] = 1,
["borderOffset"] = 4,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["selfPoint"] = "CENTER",
["id"] = "Secondary Auras",
["xOffset"] = 0,
["alpha"] = 1,
["anchorFrameType"] = "SELECTFRAME",
["borderInset"] = 1,
["config"] = {
},
["uid"] = "oOzJGlZgSuI",
["yOffset"] = 32,
["conditions"] = {
},
["information"] = {
},
["parent"] = "[ENH] Enhancement Shaman",
},
["[ENH] Chain Lightning"] = {
["iconSource"] = 1,
["wagoID"] = "4yz3N1TG7",
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 0,
["anchorPoint"] = "TOP",
["cooldownSwipe"] = true,
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "",
["do_custom"] = false,
},
},
["triggers"] = {
{
["trigger"] = {
["track"] = "auto",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["use_followoverride"] = false,
["use_trackcharge"] = true,
["debuffType"] = "HELPFUL",
["charges_operator"] = ">=",
["use_remaining"] = false,
["unit"] = "player",
["subeventSuffix"] = "_CAST_START",
["charges"] = "2",
["type"] = "spell",
["event"] = "Cooldown Progress (Spell)",
["use_exact_spellName"] = false,
["realSpellName"] = "Elemental Blast",
["use_spellName"] = true,
["spellIds"] = {
},
["use_charges"] = false,
["names"] = {
},
["trackcharge"] = "1",
["use_track"] = true,
["spellName"] = 188443,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["stacksOperator"] = ">=",
["auraspellids"] = {
"344179",
},
["ownOnly"] = true,
["unit"] = "player",
["stacks"] = "5",
["useStacks"] = true,
["useExactSpellId"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "aura2",
["auraspellids"] = {
"455097",
},
["debuffType"] = "HELPFUL",
["useExactSpellId"] = true,
["unit"] = "player",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["keepAspectRatio"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["preset"] = "fade",
},
},
["desaturate"] = false,
["useCooldownModRate"] = true,
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["border_offset"] = 0,
["border_size"] = 1,
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["type"] = "subborder",
},
{
["text_shadowXOffset"] = 0,
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["text_text_format_p_time_legacy_floor"] = false,
["text_text_format_p_time_dynamic_threshold"] = 0,
["text_text_format_p_decimal_precision"] = 0,
["type"] = "subtext",
["text_text_format_p_time_precision"] = 1,
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_text_format_p_time_mod_rate"] = true,
["text_shadowYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_anchorPoint"] = "CENTER",
["text_fontType"] = "OUTLINE",
["text_text_format_p_format"] = "Number",
["text_fontSize"] = 12,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "ceil",
},
{
["glowFrequency"] = 0.2,
["type"] = "subglow",
["glowDuration"] = 1,
["glowType"] = "Pixel",
["glowThickness"] = 1.8,
["glowYOffset"] = -1,
["glowColor"] = {
0.9686275124549866,
0.9686275124549866,
0.3137255012989044,
1,
},
["useGlowColor"] = true,
["glowXOffset"] = -1,
["glowScale"] = 1,
["glow"] = false,
["glowLength"] = 8,
["glowLines"] = 8,
["glowBorder"] = false,
},
},
["height"] = 42,
["progressSource"] = {
-1,
"",
},
["load"] = {
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_petbattle"] = false,
["use_never"] = false,
["talent"] = {
["multi"] = {
[101819] = true,
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["use_talent"] = false,
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["use_vehicleUi"] = false,
["use_class_and_spec"] = true,
["use_alive"] = true,
["use_spellknown"] = false,
["size"] = {
["multi"] = {
},
},
},
["cooldownEdge"] = false,
["useAdjustededMax"] = false,
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["source"] = "import",
["conditions"] = {
{
["check"] = {
["trigger"] = -2,
["variable"] = "OR",
["checks"] = {
{
["trigger"] = -2,
["op"] = "<",
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 0,
},
},
},
{
["trigger"] = 1,
["variable"] = "spellInRange",
["value"] = 0,
},
},
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
{
["check"] = {
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
["changes"] = {
{
["value"] = 3,
["property"] = "iconSource",
},
},
},
{
["check"] = {
["trigger"] = -2,
["variable"] = "AND",
["checks"] = {
{
["trigger"] = 3,
["variable"] = "show",
["value"] = 1,
},
{
["trigger"] = 2,
["variable"] = "show",
["value"] = 1,
["op"] = ">=",
},
},
},
["linked"] = false,
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
{
["value"] = {
0.5098039507865906,
0.9960784912109375,
0.9960784912109375,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.4,
["property"] = "sub.4.glowFrequency",
},
},
},
{
["check"] = {
["trigger"] = 2,
["op"] = "==",
["variable"] = "stacks",
["value"] = "10",
},
["linked"] = true,
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
{
["value"] = {
1,
0,
0,
1,
},
["property"] = "sub.4.glowColor",
},
{
["value"] = 0.3,
["property"] = "sub.4.glowFrequency",
},
},
},
{
["check"] = {
["value"] = "8",
["variable"] = "stacks",
["trigger"] = 2,
["op"] = ">=",
},
["changes"] = {
{
["value"] = true,
["property"] = "sub.4.glow",
},
},
["linked"] = true,
},
},
["xOffset"] = 0,
["parent"] = "Right Wing",
["uid"] = "36pfpwKHwws",
["anchorFrameFrame"] = "WeakAuras:[ENH] Ice Strike",
["regionType"] = "icon",
["preferToUpdate"] = false,
["anchorFrameType"] = "SCREEN",
["frameStrata"] = 3,
["selfPoint"] = "TOPLEFT",
["anchorFrameParent"] = true,
["zoom"] = 0,
["semver"] = "10.0.51",
["cooldownTextDisabled"] = true,
["auto"] = false,
["tocversion"] = 100107,
["id"] = "[ENH] Chain Lightning",
["useAdjustededMin"] = false,
["alpha"] = 1,
["width"] = 42,
["icon"] = true,
["config"] = {
},
["inverse"] = true,
["color"] = {
1,
1,
1,
1,
},
["displayIcon"] = "",
["cooldown"] = true,
["texYOffset"] = 0,
},
["[ENH] Maelstrom Bar 1"] = {
["color"] = {
0,
0.501960813999176,
1,
1,
},
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["useStacks"] = true,
["auranames"] = {
"344179",
},
["matchesShowOn"] = "showOnActive",
["subeventPrefix"] = "SPELL",
["unitExists"] = false,
["stacks"] = "1",
["match_count"] = "1",
["debuffType"] = "HELPFUL",
["useName"] = false,
["stacksOperator"] = ">=",
["subeventSuffix"] = "_CAST_START",
["event"] = "Health",
["auraspellids"] = {
"344179",
},
["match_countOperator"] = ">=",
["spellIds"] = {
},
["useExactSpellId"] = true,
["type"] = "aura2",
["unit"] = "player",
["names"] = {
},
["ownOnly"] = true,
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["desaturate"] = false,
["rotation"] = 0,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 26,
["rotate"] = false,
["load"] = {
["use_petbattle"] = false,
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
},
},
["talent"] = {
["multi"] = {
[101948] = true,
},
},
["use_vehicle"] = false,
["class"] = {
["multi"] = {
},
},
["use_dragonriding"] = false,
["use_vehicleUi"] = false,
["spec"] = {
["multi"] = {
},
},
["use_alive"] = true,
["use_class_and_spec"] = true,
["size"] = {
["multi"] = {
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:[ENH] Maelstrom Background",
["regionType"] = "texture",
["blendMode"] = "BLEND",
["anchorFrameParent"] = true,
["texture"] = "Interface\\AddOns\\WindfuryUI\\Textures\\MaelstromBar.tga",
["config"] = {
},
["selfPoint"] = "CENTER",
["id"] = "[ENH] Maelstrom Bar 1",
["alpha"] = 1,
["frameStrata"] = 1,
["width"] = 48,
["anchorFrameType"] = "SELECTFRAME",
["uid"] = "dq1pw84CjQS",
["xOffset"] = -97,
["authorOptions"] = {
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "totalStacks",
["op"] = ">=",
["value"] = "6",
},
["changes"] = {
{
["value"] = {
0.5098039507865906,
0.9960784912109375,
0.9960784912109375,
1,
},
["property"] = "color",
},
},
},
},
["information"] = {
},
["parent"] = "Resources",
},
["[ENH] Tempest Duration"] = {
["sparkWidth"] = 10,
["iconSource"] = -1,
["xOffset"] = -0.5,
["preferToUpdate"] = false,
["yOffset"] = 0,
["anchorPoint"] = "LEFT",
["sparkRotation"] = 0,
["url"] = "",
["icon"] = false,
["icon_color"] = {
1,
1,
1,
1,
},
["enableGradient"] = false,
["selfPoint"] = "RIGHT",
["barColor"] = {
0.50980392156863,
0.99607843137255,
0.99607843137255,
1,
},
["desaturate"] = false,
["sparkOffsetY"] = 0,
["gradientOrientation"] = "VERTICAL",
["load"] = {
["use_petbattle"] = false,
["use_never"] = false,
["class"] = {
["single"] = "SHAMAN",
["multi"] = {
},
},
["use_class"] = true,
["use_dragonriding"] = false,
["use_spec"] = true,
["size"] = {
["multi"] = {
},
},
["class_and_spec"] = {
["single"] = 263,
["multi"] = {
[263] = true,
},
},
["talent"] = {
["multi"] = {
},
},
["use_vehicle"] = false,
["spec"] = {
["single"] = 2,
["multi"] = {
},
},
["use_herotalent"] = false,
["use_vehicleUi"] = false,
["zoneIds"] = "",
["use_alive"] = true,
["use_class_and_spec"] = true,
["herotalent"] = {
["multi"] = {
[117489] = true,
},
},
},
["smoothProgress"] = false,
["useAdjustededMin"] = false,
["regionType"] = "aurabar",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100107,
["alpha"] = 1,
["uid"] = "f4Vrq(KAVXK",
["sparkOffsetX"] = 0,
["wagoID"] = "4yz3N1TG7",
["parent"] = "Left Wing",
["adjustedMin"] = "",
["sparkRotationMode"] = "AUTO",
["triggers"] = {
{
["trigger"] = {
["type"] = "aura2",
["auraspellids"] = {
"454015",
},
["ownOnly"] = true,
["event"] = "Health",
["unit"] = "player",
["useExactSpellId"] = true,
["auranames"] = {
"187874",
},
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["subeventSuffix"] = "_CAST_START",
["useName"] = false,
["names"] = {
},
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["customTriggerLogic"] = "",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 75,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["easeStrength"] = 3,
["preset"] = "fade",
["duration_type"] = "seconds",
},
},
["version"] = 252,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["type"] = "subforeground",
},
{
["border_offset"] = 0,
["border_anchor"] = "bar",
["type"] = "subborder",
["border_color"] = {
0,
0,
0,
1,
},
["border_visible"] = true,
["border_edge"] = "Square Full White",
["border_size"] = 1,
},
},
["height"] = 42,
["textureSource"] = "LSM",
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = false,
["source"] = "import",
["anchorFrameFrame"] = "WeakAuras:[ENH] Lightning Bolt",
["backgroundColor"] = {
0.1294117718935013,
0.250980406999588,
0.250980406999588,
1,
},
["icon_side"] = "RIGHT",
["information"] = {
["forceEvents"] = true,
["ignoreOptionsEventErrors"] = true,
},
["sparkHeight"] = 30,
["anchorFrameParent"] = true,
["authorOptions"] = {
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["config"] = {
},
["semver"] = "10.0.51",
["id"] = "[ENH] Tempest Duration",
["sparkHidden"] = "NEVER",
["auto"] = true,
["frameStrata"] = 4,
["anchorFrameType"] = "SELECTFRAME",
["width"] = 5,
["zoom"] = 0,
["inverse"] = false,
["sparkColor"] = {
1,
1,
1,
1,
},
["orientation"] = "VERTICAL_INVERSE",
["conditions"] = {
},
["barColor2"] = {
1,
1,
0,
1,
},
["adjustedMax"] = "",
},
},
["historyCutoff"] = 730,
["editor_theme"] = "Monokai",
}
