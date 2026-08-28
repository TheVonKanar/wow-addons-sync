
PLATYNATOR_CONFIG = {
["Version"] = 1,
["CharacterSpecific"] = {
},
["Profiles"] = {
["Jundies"] = {
["stack_region_scale_y"] = 2.8,
["design_all"] = {
},
["migration"] = 9,
["not_in_combat_alpha"] = 1,
["not_target_behaviour"] = "fade",
["simplified_nameplates"] = {
["minor"] = true,
["minion"] = true,
["instancesNormal"] = false,
},
["stacking_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["obscured_combat_alpha"] = 0.4,
["show_friendly_in_instances"] = true,
["blizzard_widget_scale"] = 1.2,
["show_friendly_in_instances_1"] = "never",
["stack_applies_to"] = {
["normal"] = true,
["minion"] = false,
["minor"] = false,
},
["not_target_alpha"] = 0.75,
["show_nameplates_only_needed"] = false,
["click_region_scale_x"] = 1.1,
["simplified_scale"] = 0.9,
["stack_region_scale_x"] = 1,
["click_region_scale"] = 1,
["design_assignments"] = {
{
["scale"] = 1,
["simplified"] = false,
["criteria"] = {
"cannot-attack",
},
["style"] = "Friendly Nameplates",
},
{
["scale"] = 1,
["simplified"] = true,
["criteria"] = {
"can-attack",
"class-minor",
},
["style"] = "Enemy Nameplates",
},
{
["scale"] = 1,
["simplified"] = true,
["criteria"] = {
"can-attack",
"minion",
},
["style"] = "Enemy Nameplates",
},
{
["scale"] = 1,
["simplified"] = false,
["criteria"] = {
"can-attack",
},
["style"] = "Enemy Nameplates",
},
},
["designs_enabled"] = {
["pvpInstance"] = false,
["combat"] = false,
["pvpWorld"] = false,
},
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["vertical_offset"] = 0,
["cast_scale"] = 1.05,
["closer_nameplates"] = false,
["nameplate_position"] = "top",
["designs_assigned"] = {
["enemySimplifiedCombat"] = "_hare_simplified",
["enemyPvPPlayer"] = "Enemy Players",
["enemyCombat"] = "_deer",
["friendCombat"] = "_name-only",
["friendPvPPlayer"] = "_name-only",
["enemySimplified"] = "Enemy Nameplates",
["friend"] = "Friendly Nameplates",
["enemy"] = "Enemy Nameplates",
},
["style"] = "Friendly Nameplates",
["aura_filters"] = {
[263] = {
["debuffs"] = {
["include"] = {
},
["exclude"] = {
},
},
["buffs"] = {
["include"] = {
},
["exclude"] = {
},
},
},
["crowdControl"] = {
["include"] = {
},
["exclude"] = {
},
},
[0] = {
["debuffs"] = {
["include"] = {
},
["exclude"] = {
},
},
["buffs"] = {
["include"] = {
},
["exclude"] = {
},
},
},
},
["target_scale"] = 1.05,
["simplified_assigned_fallback"] = "Enemy Nameplates",
["cast_interrupted_timeout"] = 0.3,
["obscured_alpha"] = 0.5,
["apply_cvars"] = true,
["current_skin"] = "blizzard",
["global_scale"] = 1.1,
["designs"] = {
["_custom"] = {
["highlights"] = {
},
["specialBars"] = {
},
["scale"] = 1,
["auras"] = {
},
["regions"] = {
["stack"] = {
["autoSized"] = true,
["anchor"] = {
"BOTTOM",
0,
5.9,
},
["kind"] = "stack",
["height"] = 0.84,
["width"] = 1.14,
},
["click"] = {
["autoSized"] = true,
["anchor"] = {
"BOTTOM",
0,
7,
},
["kind"] = "click",
["height"] = 0.7,
["width"] = 1.04,
},
},
["font"] = {
["outline"] = true,
["shadow"] = true,
["asset"] = "RobotoCondensed-Bold",
["slug"] = true,
},
["version"] = 19,
["bars"] = {
},
["markers"] = {
{
["scale"] = 0.9,
["layer"] = 3,
["anchor"] = {
"BOTTOMLEFT",
-45.5,
2,
},
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
{
["scale"] = 1.2,
["layer"] = 3,
["anchor"] = {
"BOTTOM",
0,
17,
},
["kind"] = "raid",
["asset"] = "normal/blizzard-raid",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
},
["texts"] = {
{
["showWhenWowDoes"] = true,
["truncate"] = false,
["color"] = {
["b"] = 0.9686275124549866,
["g"] = 0.9686275124549866,
["r"] = 0.9686275124549866,
},
["layer"] = 2,
["maxWidth"] = 1.04,
["autoColors"] = {
{
["colors"] = {
},
["kind"] = "classColors",
},
{
["colors"] = {
["tapped"] = {
["b"] = 0.4313725490196079,
["g"] = 0.4313725490196079,
["r"] = 0.4313725490196079,
},
},
["kind"] = "tapped",
},
{
["colors"] = {
["neutral"] = {
["r"] = 1,
["g"] = 1,
["b"] = 0,
},
["friendly"] = {
["r"] = 0,
["g"] = 1,
["b"] = 0,
},
["hostile"] = {
["r"] = 1,
["g"] = 0,
["b"] = 0,
},
["unfriendly"] = {
["b"] = 0,
["g"] = 0.5058823529411764,
["r"] = 1,
},
},
["kind"] = "reaction",
},
},
["anchor"] = {
"BOTTOM",
0,
7,
},
["kind"] = "creatureName",
["scale"] = 1,
["align"] = "CENTER",
},
{
["align"] = "CENTER",
["anchor"] = {
"LEFT",
-48.5,
0,
},
["kind"] = "quest",
["truncate"] = false,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 2,
["scale"] = 1,
["maxWidth"] = 0,
},
},
},
["Friendly Nameplates"] = {
["highlights"] = {
},
["specialBars"] = {
},
["scale"] = 1.05,
["auras"] = {
},
["regions"] = {
["click"] = {
["width"] = 1.03,
["anchor"] = {
"BOTTOM",
0,
4.5,
},
["kind"] = "click",
["height"] = 0.92,
["autoSized"] = true,
},
["stack"] = {
["width"] = 1.13,
["anchor"] = {
"BOTTOM",
0,
3.07,
},
["kind"] = "stack",
["height"] = 1.1,
["autoSized"] = true,
},
},
["font"] = {
["outline"] = false,
["shadow"] = true,
["asset"] = "Fira Sans Condensed Medium",
["slug"] = true,
},
["version"] = 19,
["bars"] = {
},
["markers"] = {
{
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 3,
["anchor"] = {
"BOTTOM",
0,
19.5,
},
["kind"] = "raid",
["asset"] = "normal/blizzard-raid",
["scale"] = 1.2,
},
},
["texts"] = {
{
["showWhenWowDoes"] = true,
["truncate"] = false,
["color"] = {
["r"] = 0.9137255549430847,
["g"] = 0.9137255549430847,
["b"] = 0.9137255549430847,
},
["layer"] = 1,
["maxWidth"] = 1.03,
["autoColors"] = {
},
["anchor"] = {
"BOTTOM",
0,
4.5,
},
["kind"] = "creatureName",
["scale"] = 1.3,
["align"] = "CENTER",
},
},
},
["Enemy Players"] = {
["highlights"] = {
{
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 2,
["asset"] = "Platy: Arrow Double",
["width"] = 1.31,
["sliced"] = true,
["height"] = 1.1,
["kind"] = "target",
["scale"] = 0.96,
["anchor"] = {
},
},
{
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 2,
["asset"] = "Platy: 4px",
["width"] = 1,
["sliced"] = true,
["height"] = 1.2,
["kind"] = "target",
["scale"] = 1,
["anchor"] = {
},
},
{
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 1,
["b"] = 0.960784375667572,
},
["layer"] = 2,
["asset"] = "Platy: 4px",
["width"] = 1,
["sliced"] = true,
["height"] = 1.2,
["kind"] = "focus",
["scale"] = 1,
["anchor"] = {
},
},
{
["color"] = {
["a"] = 0.4973947405815125,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["layer"] = 1,
["asset"] = "Platy: Striped",
["width"] = 1,
["sliced"] = false,
["height"] = 1.2,
["kind"] = "focus",
["anchor"] = {
},
["scale"] = 1,
},
{
["color"] = {
["a"] = 0.52994704246521,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 0,
["asset"] = "Platy: White",
["width"] = 1,
["scale"] = 1,
["sliced"] = true,
["anchor"] = {
},
["kind"] = "mouseover",
["height"] = 1.2,
["includeTarget"] = true,
},
{
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 0.8823530077934265,
["b"] = 0.3411764800548554,
},
["layer"] = 3,
["asset"] = "Platy: Animated Dashes Long",
["width"] = 1,
["autoColors"] = {
{
["colors"] = {
["cast"] = {
["a"] = 1,
["r"] = 1,
["g"] = 0.8823530077934265,
["b"] = 0.3411764800548554,
},
["channel"] = {
["a"] = 1,
["r"] = 1,
["g"] = 0.8823530077934265,
["b"] = 0.3411764800548554,
},
},
["kind"] = "importantCast",
},
},
["height"] = 0.5,
["anchor"] = {
"TOP",
0,
-9.5,
},
["kind"] = "animatedBorder",
["borderWidth"] = 1.35,
["scale"] = 1,
},
{
["color"] = {
["a"] = 1,
["b"] = 0.7960785031318665,
["g"] = 0.7960785031318665,
["r"] = 0.7960785031318665,
},
["layer"] = 1,
["asset"] = "Platy: Arrow",
["width"] = 1.21,
["scale"] = 0.96,
["sliced"] = true,
["anchor"] = {
"BOTTOM",
0,
-8,
},
["kind"] = "mouseover",
["height"] = 1.1,
["includeTarget"] = false,
},
{
["color"] = {
["a"] = 1,
["b"] = 0.6666666865348816,
["g"] = 0.6666666865348816,
["r"] = 0.6666666865348816,
},
["layer"] = 0,
["asset"] = "Platy: Arrow",
["width"] = 1.21,
["kind"] = "softTarget",
["anchor"] = {
},
["sliced"] = true,
["height"] = 1.08,
["scale"] = 0.96,
},
},
["specialBars"] = {
{
["useSpecColors"] = true,
["scale"] = 0.01,
["layer"] = 3,
["anchor"] = {
0,
-7,
},
["kind"] = "power",
["asset"] = "Platy: Soft Circle",
["fixedColor"] = {
["b"] = 0,
["g"] = 0.788235294117647,
["r"] = 0.9411764705882353,
},
},
},
["scale"] = 1.5,
["auras"] = {
{
["direction"] = "LEFT",
["showPandemic"] = true,
["showSwipe"] = true,
["textScale"] = 1,
["limit"] = 3,
["anchor"] = {
"BOTTOMRIGHT",
63,
10,
},
["filters"] = {
["fromYou"] = true,
["important"] = true,
},
["showType"] = false,
["layer"] = 1,
["showCountdown"] = true,
["showTooltips"] = true,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
["scale"] = 0.9,
["height"] = 0.8,
["kind"] = "debuffs",
["padding"] = 0.1,
["texts"] = {
["countdown"] = {
["visible"] = true,
["scale"] = 0.82,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
["showFractions"] = false,
},
["stacks"] = {
["visible"] = true,
["scale"] = 0.64,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"TOPRIGHT",
9,
-0.5,
},
},
},
},
{
["direction"] = "RIGHT",
["scale"] = 0.9,
["showSwipe"] = true,
["textScale"] = 1,
["limit"] = 3,
["anchor"] = {
"BOTTOMLEFT",
-62,
10,
},
["showStealable"] = false,
["filters"] = {
["enrage"] = false,
["dispellable"] = true,
["important"] = true,
["defensive"] = false,
["friendlyFromYou"] = true,
},
["showType"] = true,
["layer"] = 1,
["showCountdown"] = true,
["showTooltips"] = true,
["texts"] = {
["countdown"] = {
["visible"] = true,
["scale"] = 0.82,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
["showFractions"] = false,
},
["stacks"] = {
["visible"] = true,
["scale"] = 0.64,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"TOPRIGHT",
9.5,
-0.5,
},
},
},
["height"] = 0.8,
["padding"] = 0.1,
["kind"] = "buffs",
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["filters"] = {
["fromYou"] = false,
},
["direction"] = "RIGHT",
["layer"] = 1,
["kind"] = "crowdControl",
["scale"] = 1,
["showSwipe"] = true,
["showCountdown"] = true,
["height"] = 0.95,
["showTooltips"] = true,
["showType"] = false,
["limit"] = 30,
["texts"] = {
["countdown"] = {
["visible"] = true,
["scale"] = 1.05,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
["showFractions"] = false,
},
["stacks"] = {
["visible"] = true,
["scale"] = 0.83,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
},
},
["anchor"] = {
"RIGHT",
92,
0,
},
["padding"] = 0.1,
["textScale"] = 1,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
},
["regions"] = {
["click"] = {
["autoSized"] = true,
["anchor"] = {
"TOP",
0,
9.38,
},
["kind"] = "click",
["height"] = 1.71,
["width"] = 1,
},
["stack"] = {
["autoSized"] = true,
["anchor"] = {
"TOP",
0,
12.04,
},
["kind"] = "stack",
["height"] = 2.05,
["width"] = 1.1,
},
},
["font"] = {
["outline"] = false,
["shadow"] = true,
["asset"] = "Fira Sans Condensed Medium",
["slug"] = true,
},
["version"] = 19,
["bars"] = {
{
["relativeTo"] = 0,
["animate"] = false,
["marker"] = {
["asset"] = "none",
},
["layer"] = 1,
["border"] = {
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["height"] = 1.2,
["asset"] = "Platy: 1px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
["tapped"] = {
["r"] = 0.4313725490196079,
["g"] = 0.4313725490196079,
["b"] = 0.4313725490196079,
},
},
["kind"] = "tapped",
},
{
["colors"] = {
},
["kind"] = "classColors",
},
{
["colors"] = {
["unfriendly"] = {
["r"] = 1,
["g"] = 0.5058823529411764,
["b"] = 0,
},
["hostile"] = {
["r"] = 0.7450980544090271,
["g"] = 0.1882353127002716,
["b"] = 0.1137254983186722,
},
["friendly"] = {
["b"] = 0,
["g"] = 0.8901961445808411,
["r"] = 0,
},
["neutral"] = {
["b"] = 0,
["g"] = 0.8588235974311829,
["r"] = 0.8980392813682556,
},
},
["kind"] = "reaction",
},
},
["absorb"] = {
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["asset"] = "Platy: Absorb Wide",
},
["foreground"] = {
["asset"] = "Platy: Solid White",
},
["anchor"] = {
},
["kind"] = "health",
["background"] = {
["color"] = {
["a"] = 0.5,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Black",
},
["scale"] = 1,
},
{
["scale"] = 1,
["layer"] = 2,
["border"] = {
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["height"] = 0.5,
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
["ready"] = {
["r"] = 1,
["g"] = 1,
["b"] = 0,
},
},
["kind"] = "interruptReady",
},
{
["colors"] = {
["cast"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0.1372549086809158,
},
["channel"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0.1372549086809158,
},
},
["kind"] = "importantCast",
},
{
["colors"] = {
["uninterruptable"] = {
["b"] = 0.3019607961177826,
["g"] = 0.3019607961177826,
["r"] = 0.8000000715255737,
},
},
["kind"] = "uninterruptableCast",
},
{
["colors"] = {
["empowered"] = {
["r"] = 0.0196078431372549,
["g"] = 0.7764705882352941,
["b"] = 0.4,
},
["cast"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0.1372549086809158,
},
["interrupted"] = {
["b"] = 0.3019607961177826,
["g"] = 0.3019607961177826,
["r"] = 0.8000000715255737,
},
["channel"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0.1372549086809158,
},
},
["kind"] = "cast",
},
},
["marker"] = {
["asset"] = "none",
},
["anchor"] = {
"TOP",
0,
-9.5,
},
["foreground"] = {
["asset"] = "Platy: Solid White",
},
["kind"] = "cast",
["background"] = {
["color"] = {
["a"] = 0.5,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Black",
},
["interruptMarker"] = {
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 1,
["b"] = 0.03921568766236305,
},
["asset"] = "wide/glow",
},
},
},
["markers"] = {
{
["anchor"] = {
"LEFT",
-83.5,
0,
},
["kind"] = "quest",
["scale"] = 1,
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
{
["anchor"] = {
"BOTTOMRIGHT",
10,
3.5,
},
["kind"] = "raid",
["scale"] = 1,
["layer"] = 3,
["asset"] = "normal/blizzard-raid",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
},
["texts"] = {
{
["displayTypes"] = {
"percentage",
},
["scale"] = 0.8,
["layer"] = 2,
["formatMultiple"] = "%s (%s)",
["maxWidth"] = 0.25,
["significantFigures"] = 2,
["showPercentSymbol"] = true,
["truncate"] = true,
["anchor"] = {
"RIGHT",
60,
0,
},
["kind"] = "health",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["align"] = "RIGHT",
},
{
["showWhenWowDoes"] = false,
["truncate"] = true,
["align"] = "LEFT",
["layer"] = 2,
["maxWidth"] = 0.75,
["autoColors"] = {
},
["anchor"] = {
"LEFT",
-59.5,
0,
},
["kind"] = "creatureName",
["scale"] = 0.8,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
{
["showInterrupted"] = true,
["truncate"] = true,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 2,
["maxWidth"] = 0.56,
["anchor"] = {
"TOPLEFT",
-62,
-17.5,
},
["kind"] = "castSpellName",
["align"] = "LEFT",
["scale"] = 0.8,
},
{
["truncate"] = true,
["align"] = "RIGHT",
["layer"] = 2,
["maxWidth"] = 0.44,
["scale"] = 0.8,
["anchor"] = {
"TOPRIGHT",
62.5,
-17.5,
},
["kind"] = "castTarget",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyClassColors"] = true,
},
{
["truncate"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 2,
["maxWidth"] = 0.44,
["align"] = "RIGHT",
["anchor"] = {
"TOPRIGHT",
62.5,
-17.5,
},
["kind"] = "castInterrupter",
["scale"] = 0.8,
["applyClassColors"] = true,
},
{
["align"] = "CENTER",
["anchor"] = {
"TOPLEFT",
-86,
-9,
},
["kind"] = "quest",
["truncate"] = false,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 2,
["scale"] = 1,
["maxWidth"] = 0,
},
},
},
["Enemy Nameplates"] = {
["highlights"] = {
{
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 0,
["asset"] = "Platy: Arrow Double",
["width"] = 1.31,
["height"] = 1.1,
["anchor"] = {
},
["kind"] = "target",
["scale"] = 0.96,
["sliced"] = true,
},
{
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 2,
["asset"] = "Platy: 4px",
["width"] = 1,
["height"] = 1.2,
["anchor"] = {
},
["kind"] = "target",
["scale"] = 1,
["sliced"] = true,
},
{
["color"] = {
["a"] = 1,
["b"] = 0.960784375667572,
["g"] = 1,
["r"] = 0,
},
["layer"] = 2,
["asset"] = "Platy: 4px",
["width"] = 1,
["height"] = 1.2,
["anchor"] = {
},
["kind"] = "focus",
["scale"] = 1,
["sliced"] = true,
},
{
["color"] = {
["a"] = 0.4973947405815125,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["layer"] = 1,
["asset"] = "Platy: Striped",
["width"] = 1,
["scale"] = 1,
["height"] = 1.2,
["kind"] = "focus",
["anchor"] = {
},
["sliced"] = false,
},
{
["color"] = {
["a"] = 0.52994704246521,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 0,
["asset"] = "Platy: White",
["width"] = 1,
["scale"] = 1,
["anchor"] = {
},
["height"] = 1.2,
["kind"] = "mouseover",
["sliced"] = true,
["includeTarget"] = true,
},
{
["color"] = {
["a"] = 1,
["b"] = 0.3411764800548554,
["g"] = 0.8823530077934265,
["r"] = 1,
},
["layer"] = 3,
["asset"] = "Platy: Animated Dashes Long",
["width"] = 1,
["autoColors"] = {
{
["colors"] = {
["cast"] = {
["a"] = 1,
["b"] = 0.3411764800548554,
["g"] = 0.8823530077934265,
["r"] = 1,
},
["channel"] = {
["a"] = 1,
["b"] = 0.3411764800548554,
["g"] = 0.8823530077934265,
["r"] = 1,
},
},
["kind"] = "importantCast",
},
},
["scale"] = 1,
["anchor"] = {
"TOP",
0,
-9.5,
},
["kind"] = "animatedBorder",
["borderWidth"] = 1.35,
["height"] = 0.5,
},
{
["color"] = {
["a"] = 1,
["r"] = 0.6666666666666666,
["g"] = 0.6666666666666666,
["b"] = 0.6666666666666666,
},
["layer"] = 0,
["asset"] = "Platy: Arrow",
["width"] = 1.21,
["scale"] = 0.96,
["anchor"] = {
"BOTTOM",
0,
-8,
},
["height"] = 1.1,
["kind"] = "mouseover",
["sliced"] = true,
["includeTarget"] = false,
},
},
["specialBars"] = {
{
["useSpecColors"] = true,
["scale"] = 0.01,
["kind"] = "power",
["anchor"] = {
0,
-7,
},
["layer"] = 3,
["asset"] = "Platy: Soft Circle",
["fixedColor"] = {
["b"] = 0,
["g"] = 0.788235294117647,
["r"] = 0.9411764705882353,
},
},
},
["scale"] = 1.5,
["auras"] = {
{
["direction"] = "LEFT",
["showPandemic"] = true,
["showSwipe"] = true,
["textScale"] = 1,
["limit"] = 3,
["anchor"] = {
"BOTTOMRIGHT",
63,
10,
},
["filters"] = {
["important"] = true,
["fromYou"] = true,
},
["showType"] = false,
["layer"] = 1,
["showCountdown"] = true,
["showTooltips"] = true,
["texts"] = {
["countdown"] = {
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.82,
["anchor"] = {
},
["showFractions"] = false,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
9,
-0.5,
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.64,
},
},
["scale"] = 0.9,
["height"] = 0.8,
["kind"] = "debuffs",
["padding"] = 0.1,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
},
{
["direction"] = "RIGHT",
["scale"] = 0.9,
["showSwipe"] = true,
["textScale"] = 1,
["limit"] = 3,
["anchor"] = {
"BOTTOMLEFT",
-62,
10,
},
["showStealable"] = false,
["filters"] = {
["enrage"] = false,
["dispellable"] = true,
["important"] = true,
["defensive"] = false,
["friendlyFromYou"] = true,
},
["showType"] = true,
["layer"] = 1,
["showCountdown"] = true,
["showTooltips"] = true,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["height"] = 0.8,
["padding"] = 0.1,
["kind"] = "buffs",
["texts"] = {
["countdown"] = {
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.82,
["anchor"] = {
},
["showFractions"] = false,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
9.5,
-0.5,
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.64,
},
},
},
{
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["direction"] = "RIGHT",
["texts"] = {
["countdown"] = {
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 1.05,
["anchor"] = {
},
["showFractions"] = false,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.83,
},
},
["kind"] = "crowdControl",
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["anchor"] = {
"RIGHT",
92,
0,
},
["showTooltips"] = true,
["showType"] = false,
["limit"] = 30,
["showSwipe"] = true,
["height"] = 0.95,
["padding"] = 0.1,
["textScale"] = 1,
["filters"] = {
["fromYou"] = false,
},
},
},
["regions"] = {
["click"] = {
["width"] = 1,
["anchor"] = {
"TOP",
0,
9.38,
},
["kind"] = "click",
["height"] = 1.71,
["autoSized"] = true,
},
["stack"] = {
["width"] = 1.1,
["anchor"] = {
"TOP",
0,
12.04,
},
["kind"] = "stack",
["height"] = 2.05,
["autoSized"] = true,
},
},
["font"] = {
["outline"] = false,
["shadow"] = true,
["asset"] = "Fira Sans Condensed Medium",
["slug"] = true,
},
["version"] = 19,
["bars"] = {
{
["relativeTo"] = 0,
["animate"] = false,
["scale"] = 1,
["layer"] = 1,
["border"] = {
["height"] = 1.2,
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["asset"] = "Platy: 1px",
["width"] = 1,
},
["autoColors"] = {
{
["combatOnly"] = true,
["colors"] = {
["warning"] = {
["b"] = 0,
["g"] = 0.4352941513061523,
["r"] = 0.8666667342185974,
},
["transition"] = {
["b"] = 0.2274509966373444,
["g"] = 0.9137255549430848,
["r"] = 1,
},
["offtank"] = {
["b"] = 1,
["g"] = 0.501960813999176,
["r"] = 0.501960813999176,
},
["safe"] = {
["b"] = 0.1137254983186722,
["g"] = 0.1882353127002716,
["r"] = 0.7450980544090271,
},
},
["useSafeColor"] = false,
["useOffTankColor"] = true,
["kind"] = "threat",
["tanksOnly"] = false,
["instancesOnly"] = false,
},
{
["enabled"] = {
["boss"] = true,
["melee"] = true,
["caster"] = true,
["trivial"] = true,
["miniboss"] = true,
},
["colors"] = {
["boss"] = {
["b"] = 1,
["g"] = 0,
["r"] = 1,
},
["melee"] = {
["b"] = 0.1137254983186722,
["g"] = 0.1882353127002716,
["r"] = 0.7450980544090271,
},
["caster"] = {
["b"] = 1,
["g"] = 0.7490196228027344,
["r"] = 0,
},
["trivial"] = {
["b"] = 0.1137254983186722,
["g"] = 0.1882353127002716,
["r"] = 0.7450980544090271,
},
["miniboss"] = {
["b"] = 0.8588235974311829,
["g"] = 0.4392157196998596,
["r"] = 0.5764706134796143,
},
},
["kind"] = "eliteType",
["applyCasterAlways"] = false,
["instancesOnly"] = false,
},
{
["colors"] = {
["tapped"] = {
["b"] = 0.4313725490196079,
["g"] = 0.4313725490196079,
["r"] = 0.4313725490196079,
},
},
["kind"] = "tapped",
},
{
["colors"] = {
["neutral"] = {
["b"] = 0,
["g"] = 0.4941176772117615,
["r"] = 1,
},
["hostile"] = {
["b"] = 0,
["g"] = 0.4941176772117615,
["r"] = 1,
},
["friendly"] = {
["b"] = 0,
["g"] = 0.4941176772117615,
["r"] = 1,
},
},
["kind"] = "quest",
},
{
["colors"] = {
},
["kind"] = "classColors",
},
{
["colors"] = {
["neutral"] = {
["r"] = 0.8980392813682556,
["g"] = 0.8588235974311829,
["b"] = 0,
},
["unfriendly"] = {
["b"] = 0,
["g"] = 0.5058823529411764,
["r"] = 1,
},
["friendly"] = {
["r"] = 0,
["g"] = 0.8901961445808411,
["b"] = 0,
},
["hostile"] = {
["b"] = 0.1137254983186722,
["g"] = 0.1882353127002716,
["r"] = 0.7450980544090271,
},
},
["kind"] = "reaction",
},
},
["marker"] = {
["asset"] = "none",
},
["kind"] = "health",
["anchor"] = {
},
["background"] = {
["color"] = {
["a"] = 0.5,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Black",
},
["foreground"] = {
["asset"] = "Platy: Solid White",
},
["absorb"] = {
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["asset"] = "Platy: Absorb Wide",
},
},
{
["marker"] = {
["asset"] = "none",
},
["layer"] = 2,
["border"] = {
["height"] = 0.5,
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
["ready"] = {
["b"] = 0,
["g"] = 1,
["r"] = 1,
},
},
["kind"] = "interruptReady",
},
{
["colors"] = {
["cast"] = {
["b"] = 0.1372549086809158,
["g"] = 0.4941176772117615,
["r"] = 1,
},
["channel"] = {
["b"] = 0.1372549086809158,
["g"] = 0.4941176772117615,
["r"] = 1,
},
},
["kind"] = "importantCast",
},
{
["colors"] = {
["uninterruptable"] = {
["r"] = 0.8000000715255737,
["g"] = 0.3019607961177826,
["b"] = 0.3019607961177826,
},
},
["kind"] = "uninterruptableCast",
},
{
["colors"] = {
["cast"] = {
["b"] = 0.1372549086809158,
["g"] = 0.4941176772117615,
["r"] = 1,
},
["empowered"] = {
["b"] = 0.4,
["g"] = 0.7764705882352941,
["r"] = 0.0196078431372549,
},
["interrupted"] = {
["r"] = 0.8000000715255737,
["g"] = 0.3019607961177826,
["b"] = 0.3019607961177826,
},
["channel"] = {
["b"] = 0.1372549086809158,
["g"] = 0.4941176772117615,
["r"] = 1,
},
},
["kind"] = "cast",
},
},
["scale"] = 1,
["kind"] = "cast",
["foreground"] = {
["asset"] = "Platy: Solid White",
},
["background"] = {
["color"] = {
["a"] = 0.5,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Black",
},
["anchor"] = {
"TOP",
0,
-9.5,
},
["interruptMarker"] = {
["color"] = {
["a"] = 1,
["b"] = 0.03921568766236305,
["g"] = 1,
["r"] = 0,
},
["asset"] = "wide/glow",
},
},
},
["markers"] = {
{
["scale"] = 1,
["layer"] = 3,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["anchor"] = {
"LEFT",
-83.5,
0,
},
},
{
["scale"] = 1,
["layer"] = 3,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "raid",
["asset"] = "normal/blizzard-raid",
["anchor"] = {
"BOTTOMRIGHT",
10,
-2,
},
},
},
["texts"] = {
{
["displayTypes"] = {
"percentage",
},
["scale"] = 0.8,
["layer"] = 2,
["formatMultiple"] = "%s (%s)",
["maxWidth"] = 0.25,
["significantFigures"] = 2,
["align"] = "RIGHT",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"RIGHT",
60,
0,
},
["kind"] = "health",
["truncate"] = true,
["showPercentSymbol"] = true,
},
{
["showWhenWowDoes"] = false,
["truncate"] = true,
["align"] = "LEFT",
["layer"] = 2,
["maxWidth"] = 0.75,
["autoColors"] = {
},
["anchor"] = {
"LEFT",
-59.5,
0,
},
["kind"] = "creatureName",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["scale"] = 0.8,
},
{
["showInterrupted"] = true,
["truncate"] = true,
["align"] = "LEFT",
["layer"] = 2,
["maxWidth"] = 0.56,
["anchor"] = {
"TOPLEFT",
-62,
-17.5,
},
["kind"] = "castSpellName",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.8,
},
{
["truncate"] = true,
["scale"] = 0.8,
["layer"] = 2,
["maxWidth"] = 0.44,
["align"] = "RIGHT",
["anchor"] = {
"TOPRIGHT",
62.5,
-17.5,
},
["kind"] = "castTarget",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["applyClassColors"] = true,
},
{
["truncate"] = true,
["align"] = "RIGHT",
["layer"] = 2,
["maxWidth"] = 0.44,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"TOPRIGHT",
62.5,
-17.5,
},
["kind"] = "castInterrupter",
["scale"] = 0.8,
["applyClassColors"] = true,
},
{
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["align"] = "CENTER",
["layer"] = 2,
["truncate"] = false,
["scale"] = 1,
["kind"] = "quest",
["anchor"] = {
"TOPLEFT",
-86,
-9,
},
["maxWidth"] = 0,
},
},
},
},
["target_behaviour"] = "none",
["cast_alpha"] = 1,
["click_region_scale_y"] = 1.1,
["out_of_range_alpha"] = 1,
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["instances_name_only_size"] = 3,
["show_nameplates"] = {
["friendlyMinion"] = false,
["friendlyMinionTotem"] = true,
["enemyMinionGuardian"] = true,
["enemy"] = true,
["friendlyNPC"] = false,
["friendlyMinionPet"] = true,
["enemyMinionPet"] = true,
["friendlyMinionGuardian"] = true,
["friendlyPlayer"] = true,
["enemyMinor"] = true,
["enemyMinion"] = true,
["enemyMinionTotem"] = true,
},
},
["Kvotheen"] = {
["stack_region_scale_y"] = 1.1,
["designs_enabled"] = {
["pvpInstance"] = false,
["combat"] = false,
["pvpWorld"] = false,
},
["cast_alpha"] = 1,
["simplified_scale"] = 0.8,
["design_all"] = {
},
["click_region_scale_x"] = 1,
["obscured_alpha"] = 0.6,
["style"] = "Windfury",
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["obscured_combat_alpha"] = 0.4,
["cast_scale"] = 1.1,
["simplified_nameplates"] = {
["minor"] = true,
["minion"] = true,
["instancesNormal"] = false,
},
["stacking_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["designs_assigned"] = {
["enemySimplifiedCombat"] = "_hare_simplified",
["enemyPvPPlayer"] = "_deer",
["enemyCombat"] = "_deer",
["friendCombat"] = "_name-only",
["friendPvPPlayer"] = "_name-only",
["friend"] = "_name-only",
["enemySimplified"] = "Windfury",
["enemy"] = "Windfury",
},
["show_friendly_in_instances"] = true,
["global_scale"] = 1,
["blizzard_widget_scale"] = 1.2,
["show_friendly_in_instances_1"] = "name_only",
["stack_applies_to"] = {
["normal"] = true,
["minion"] = false,
["minor"] = false,
},
["current_skin"] = "blizzard",
["apply_cvars"] = true,
["not_target_alpha"] = 1,
["not_target_behaviour"] = "none",
["designs"] = {
["Windfury"] = {
["highlights"] = {
{
["scale"] = 1,
["layer"] = 0,
["asset"] = "Platy: Arrow",
["width"] = 1.23,
["sliced"] = true,
["anchor"] = {
},
["kind"] = "target",
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["height"] = 1.22,
},
{
["color"] = {
["a"] = 0.5234366655349731,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["layer"] = 2,
["asset"] = "Platy: 2px",
["width"] = 1,
["scale"] = 1,
["sliced"] = true,
["anchor"] = {
},
["kind"] = "mouseover",
["height"] = 1.15,
["includeTarget"] = true,
},
{
["scale"] = 0.9,
["layer"] = 0,
["asset"] = "Platy: Glow",
["width"] = 1,
["sliced"] = false,
["height"] = 1,
["kind"] = "target",
["anchor"] = {
},
["color"] = {
["a"] = 0.3437488377094269,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
},
["specialBars"] = {
},
["scale"] = 1.35,
["auras"] = {
{
["direction"] = "RIGHT",
["texts"] = {
["countdown"] = {
["anchor"] = {
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.93,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.73,
},
},
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["showSwipe"] = true,
["showType"] = false,
["anchor"] = {
"BOTTOMLEFT",
-62.5,
9.5,
},
["limit"] = 30,
["filters"] = {
["important"] = true,
["fromYou"] = true,
},
["height"] = 0.8,
["kind"] = "debuffs",
["showPandemic"] = true,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["direction"] = "LEFT",
["texts"] = {
["countdown"] = {
["anchor"] = {
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 1.17,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.92,
},
},
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["showSwipe"] = true,
["showType"] = true,
["anchor"] = {
"LEFT",
-98,
0,
},
["limit"] = 30,
["filters"] = {
["dispelable"] = false,
["important"] = true,
["defensive"] = false,
},
["height"] = 1,
["kind"] = "buffs",
["showStealable"] = false,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["direction"] = "RIGHT",
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["texts"] = {
["countdown"] = {
["anchor"] = {
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 1.17,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
["visible"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.92,
},
},
["showSwipe"] = true,
["showType"] = false,
["limit"] = 30,
["anchor"] = {
"RIGHT",
98.5,
0,
},
["height"] = 1,
["kind"] = "crowdControl",
["filters"] = {
["fromYou"] = false,
},
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
},
["font"] = {
["outline"] = false,
["shadow"] = true,
["asset"] = "Fira Sans Condensed Bold",
["slug"] = true,
},
["version"] = 1,
["bars"] = {
{
["absorb"] = {
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["asset"] = "Platy: Absorb Wide",
},
["animate"] = false,
["scale"] = 1,
["layer"] = 1,
["border"] = {
["height"] = 1.15,
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["asset"] = "Platy: 1px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
},
["kind"] = "classColors",
},
{
["colors"] = {
["tapped"] = {
["b"] = 0.4313725490196079,
["g"] = 0.4313725490196079,
["r"] = 0.4313725490196079,
},
},
["kind"] = "tapped",
},
{
["combatOnly"] = false,
["colors"] = {
["safe"] = {
["b"] = 0.9019607843137256,
["g"] = 0.5882352941176471,
["r"] = 0.05882352941176471,
},
["warning"] = {
["b"] = 0,
["g"] = 0,
["r"] = 0.8,
},
["offtank"] = {
["b"] = 0.7843137254901961,
["g"] = 0.6666666666666666,
["r"] = 0.05882352941176471,
},
["transition"] = {
["b"] = 0,
["g"] = 0.6274509803921569,
["r"] = 1,
},
},
["instancesOnly"] = false,
["useOffTankColor"] = true,
["kind"] = "threat",
["tanksOnly"] = false,
["useSafeColor"] = false,
},
{
["colors"] = {
["neutral"] = {
["b"] = 0,
["g"] = 0.8823530077934265,
["r"] = 0.8823530077934265,
},
["unfriendly"] = {
["r"] = 1,
["g"] = 0.5058823529411764,
["b"] = 0,
},
["hostile"] = {
["b"] = 0,
["g"] = 0.2039215862751007,
["r"] = 1,
},
["friendly"] = {
["b"] = 0,
["g"] = 1,
["r"] = 0,
},
},
["kind"] = "reaction",
},
},
["relativeTo"] = 0,
["anchor"] = {
},
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["background"] = {
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Grey",
},
["kind"] = "health",
["marker"] = {
["asset"] = "none",
},
},
{
["marker"] = {
["asset"] = "wide/glow",
},
["layer"] = 1,
["border"] = {
["height"] = 1,
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
["cast"] = {
["r"] = 1,
["g"] = 0.09411764705882353,
["b"] = 0.1529411764705883,
},
["channel"] = {
["r"] = 0.0392156862745098,
["g"] = 0.2627450980392157,
["b"] = 1,
},
},
["kind"] = "importantCast",
},
{
["colors"] = {
["uninterruptable"] = {
["b"] = 0.7647058823529411,
["g"] = 0.7529411764705882,
["r"] = 0.5137254901960784,
},
},
["kind"] = "uninterruptableCast",
},
{
["colors"] = {
["cast"] = {
["b"] = 0,
["g"] = 0.5490196078431373,
["r"] = 0.9882352941176472,
},
["empowered"] = {
["b"] = 0.4,
["g"] = 0.7764705882352941,
["r"] = 0.0196078431372549,
},
["interrupted"] = {
["b"] = 0.8784313725490196,
["g"] = 0.211764705882353,
["r"] = 0.9882352941176472,
},
["channel"] = {
["r"] = 0.2431372549019608,
["g"] = 0.7764705882352941,
["b"] = 0.2156862745098039,
},
},
["kind"] = "cast",
},
},
["scale"] = 1,
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["anchor"] = {
"TOP",
0,
-9,
},
["background"] = {
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Grey",
},
["kind"] = "cast",
["interruptMarker"] = {
["asset"] = "none",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
},
},
["markers"] = {
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "quest",
["scale"] = 0.8,
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["anchor"] = {
"LEFT",
-68,
0,
},
},
{
["color"] = {
["b"] = 0.4980392156862745,
["g"] = 0.4823529411764706,
["r"] = 0.3921568627450981,
},
["kind"] = "cannotInterrupt",
["scale"] = 0.5,
["layer"] = 3,
["asset"] = "normal/shield-soft",
["anchor"] = {
"TOPRIGHT",
-50,
-12,
},
},
{
["openWorldOnly"] = false,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "elite",
["anchor"] = {
"BOTTOMRIGHT",
70,
4,
},
["layer"] = 3,
["asset"] = "special/blizzard-elite-midnight",
["scale"] = 0.8,
},
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "raid",
["scale"] = 1,
["layer"] = 3,
["asset"] = "normal/blizzard-raid",
["anchor"] = {
"BOTTOM",
0,
5,
},
},
},
["texts"] = {
{
["showWhenWowDoes"] = false,
["truncate"] = true,
["color"] = {
["a"] = 1,
["r"] = 0.9843137860298157,
["g"] = 0.9843137860298157,
["b"] = 0.9843137860298157,
},
["layer"] = 2,
["maxWidth"] = 0.67,
["autoColors"] = {
},
["anchor"] = {
"LEFT",
-58.5,
0,
},
["kind"] = "creatureName",
["scale"] = 0.92,
["align"] = "LEFT",
},
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 1,
["kind"] = "castSpellName",
["truncate"] = false,
["align"] = "CENTER",
["layer"] = 2,
["anchor"] = {
"TOP",
0,
-12,
},
["maxWidth"] = 0,
},
{
["truncate"] = false,
["scale"] = 1,
["layer"] = 2,
["formatMultiple"] = "%s (%s)",
["maxWidth"] = 0,
["significantFigures"] = 0,
["showPercentSymbol"] = true,
["displayTypes"] = {
"percentage",
},
["anchor"] = {
"RIGHT",
59.5,
0,
},
["kind"] = "health",
["color"] = {
["a"] = 1,
["r"] = 0.9843137860298157,
["g"] = 0.9843137860298157,
["b"] = 0.9843137860298157,
},
["align"] = "RIGHT",
},
},
},
["Windfury Simplified"] = {
["highlights"] = {
{
["scale"] = 1,
["layer"] = 0,
["asset"] = "Platy: Arrow",
["width"] = 1.23,
["height"] = 1.22,
["anchor"] = {
},
["sliced"] = true,
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "target",
},
{
["color"] = {
["a"] = 0.5234366655349731,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["layer"] = 2,
["asset"] = "Platy: 2px",
["width"] = 1,
["scale"] = 1,
["height"] = 1,
["anchor"] = {
},
["sliced"] = true,
["kind"] = "mouseover",
["includeTarget"] = true,
},
{
["scale"] = 0.9,
["layer"] = 0,
["asset"] = "Platy: Glow",
["width"] = 1,
["color"] = {
["a"] = 0.3437488377094269,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["height"] = 1,
["sliced"] = false,
["anchor"] = {
},
["kind"] = "target",
},
},
["specialBars"] = {
},
["scale"] = 1.1,
["auras"] = {
},
["font"] = {
["outline"] = false,
["shadow"] = true,
["asset"] = "Fira Sans Condensed Bold",
["slug"] = true,
},
["version"] = 1,
["bars"] = {
{
["relativeTo"] = 0,
["animate"] = false,
["scale"] = 1,
["layer"] = 1,
["border"] = {
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["height"] = 1,
["asset"] = "Platy: 1px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
},
["kind"] = "classColors",
},
{
["colors"] = {
["tapped"] = {
["r"] = 0.4313725490196079,
["g"] = 0.4313725490196079,
["b"] = 0.4313725490196079,
},
},
["kind"] = "tapped",
},
{
["combatOnly"] = false,
["colors"] = {
["transition"] = {
["r"] = 1,
["g"] = 0.6274509803921569,
["b"] = 0,
},
["warning"] = {
["r"] = 0.8,
["g"] = 0,
["b"] = 0,
},
["safe"] = {
["r"] = 0.05882352941176471,
["g"] = 0.5882352941176471,
["b"] = 0.9019607843137256,
},
["offtank"] = {
["r"] = 0.05882352941176471,
["g"] = 0.6666666666666666,
["b"] = 0.7843137254901961,
},
},
["useSafeColor"] = false,
["useOffTankColor"] = true,
["kind"] = "threat",
["tanksOnly"] = false,
["instancesOnly"] = false,
},
{
["colors"] = {
["unfriendly"] = {
["b"] = 0,
["g"] = 0.5960784554481506,
["r"] = 1,
},
["friendly"] = {
["r"] = 0,
["g"] = 1,
["b"] = 0,
},
["hostile"] = {
["b"] = 0,
["g"] = 0.3019607961177826,
["r"] = 1,
},
["neutral"] = {
["r"] = 0.8901961445808411,
["g"] = 0.8901961445808411,
["b"] = 0,
},
},
["kind"] = "reaction",
},
},
["marker"] = {
["asset"] = "none",
},
["kind"] = "health",
["anchor"] = {
},
["background"] = {
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Grey",
},
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["absorb"] = {
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["asset"] = "Platy: Absorb Wide",
},
},
},
["markers"] = {
{
["anchor"] = {
"LEFT",
-68,
0,
},
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["scale"] = 0.8,
},
{
["openWorldOnly"] = false,
["scale"] = 0.8,
["layer"] = 3,
["anchor"] = {
"BOTTOMRIGHT",
70,
4,
},
["kind"] = "elite",
["asset"] = "special/blizzard-elite-midnight",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
{
["anchor"] = {
"BOTTOM",
0,
5,
},
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "raid",
["asset"] = "normal/blizzard-raid",
["scale"] = 1,
},
},
["texts"] = {
{
["showWhenWowDoes"] = false,
["truncate"] = true,
["color"] = {
["a"] = 1,
["b"] = 0.9843137860298157,
["g"] = 0.9843137860298157,
["r"] = 0.9843137860298157,
},
["layer"] = 2,
["maxWidth"] = 0.94,
["autoColors"] = {
},
["anchor"] = {
"LEFT",
-58.5,
0,
},
["kind"] = "creatureName",
["align"] = "CENTER",
["scale"] = 0.92,
},
},
},
["_custom"] = {
["highlights"] = {
{
["scale"] = 1.03,
["layer"] = 0,
["asset"] = "Platy: Arrow",
["width"] = 1.23,
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
["kind"] = "target",
["height"] = 1.22,
["sliced"] = true,
},
{
["color"] = {
["a"] = 1,
["r"] = 0.6941176652908325,
["g"] = 0.3725490272045136,
["b"] = 0.9215686917304992,
},
["layer"] = 0,
["asset"] = "Platy: 7px",
["width"] = 1.03,
["scale"] = 1,
["height"] = 1.24,
["anchor"] = {
},
["kind"] = "mouseover",
["sliced"] = true,
["includeTarget"] = true,
},
},
["specialBars"] = {
},
["scale"] = 1,
["auras"] = {
},
["font"] = {
["outline"] = true,
["shadow"] = true,
["asset"] = "RobotoCondensed-Bold",
["slug"] = true,
},
["version"] = 1,
["bars"] = {
{
["relativeTo"] = 0,
["animate"] = false,
["marker"] = {
["asset"] = "wide/glow",
},
["layer"] = 1,
["border"] = {
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["height"] = 1,
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
},
["kind"] = "classColors",
},
{
["colors"] = {
["tapped"] = {
["r"] = 0.4313725490196079,
["g"] = 0.4313725490196079,
["b"] = 0.4313725490196079,
},
},
["kind"] = "tapped",
},
{
["combatOnly"] = false,
["colors"] = {
["transition"] = {
["r"] = 1,
["g"] = 0.6274509803921569,
["b"] = 0,
},
["warning"] = {
["r"] = 0.8,
["g"] = 0,
["b"] = 0,
},
["offtank"] = {
["r"] = 0.05882352941176471,
["g"] = 0.6666666666666666,
["b"] = 0.7843137254901961,
},
["safe"] = {
["r"] = 0.05882352941176471,
["g"] = 0.5882352941176471,
["b"] = 0.9019607843137256,
},
},
["instancesOnly"] = false,
["useOffTankColor"] = true,
["kind"] = "threat",
["tanksOnly"] = false,
["useSafeColor"] = true,
},
{
["colors"] = {
["neutral"] = {
["r"] = 1,
["g"] = 1,
["b"] = 0,
},
["unfriendly"] = {
["b"] = 0,
["g"] = 0.5058823529411764,
["r"] = 1,
},
["friendly"] = {
["r"] = 0,
["g"] = 1,
["b"] = 0,
},
["hostile"] = {
["r"] = 1,
["g"] = 0,
["b"] = 0,
},
},
["kind"] = "reaction",
},
},
["absorb"] = {
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["asset"] = "Platy: Absorb Wide",
},
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["anchor"] = {
},
["kind"] = "health",
["background"] = {
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Grey",
},
["scale"] = 1,
},
},
["markers"] = {
{
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "raid",
["scale"] = 1.6,
["layer"] = 3,
["asset"] = "normal/blizzard-raid",
["anchor"] = {
"BOTTOM",
0,
18,
},
},
},
["texts"] = {
{
["displayTypes"] = {
"absolute",
},
["align"] = "CENTER",
["layer"] = 2,
["formatMultiple"] = "%s (%s)",
["maxWidth"] = 0,
["significantFigures"] = 0,
["showPercentSymbol"] = true,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
["kind"] = "health",
["truncate"] = false,
["scale"] = 3,
},
},
},
},
["target_behaviour"] = "enlarge",
["target_scale"] = 1.1,
["click_region_scale_y"] = 1,
["show_nameplates_only_needed"] = false,
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["stack_region_scale_x"] = 1.2,
["show_nameplates"] = {
["friendlyMinion"] = false,
["enemyMinor"] = true,
["friendlyPlayer"] = false,
["friendlyNPC"] = false,
["enemyMinion"] = true,
["enemy"] = true,
},
},
["DEFAULT"] = {
["stack_region_scale_x"] = 1.2,
["designs_enabled"] = {
["pvpInstance"] = false,
["combat"] = false,
["pvpWorld"] = false,
},
["show_nameplates"] = {
["friendlyMinion"] = false,
["enemyMinor"] = true,
["friendlyPlayer"] = true,
["friendlyNPC"] = true,
["enemyMinion"] = true,
["enemy"] = true,
},
["design_all"] = {
},
["target_scale"] = 1.2,
["click_region_scale_y"] = 1,
["obscured_alpha"] = 0.4,
["style"] = "_hare",
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["designs_assigned"] = {
["enemySimplifiedCombat"] = "_hare_simplified",
["enemyPvPPlayer"] = "_deer",
["enemyCombat"] = "_deer",
["friendCombat"] = "_name-only",
["friendPvPPlayer"] = "_name-only",
["friend"] = "_name-only",
["enemySimplified"] = "_hare_simplified",
["enemy"] = "_hare",
},
["cast_scale"] = 1.1,
["simplified_nameplates"] = {
["minor"] = true,
["minion"] = true,
["instancesNormal"] = true,
},
["stacking_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["obscured_combat_alpha"] = 0.4,
["show_friendly_in_instances"] = true,
["global_scale"] = 1,
["blizzard_widget_scale"] = 1.2,
["show_friendly_in_instances_1"] = "always",
["stack_applies_to"] = {
["normal"] = true,
["minion"] = false,
["minor"] = false,
},
["stack_region_scale_y"] = 1.1,
["apply_cvars"] = true,
["not_target_alpha"] = 1,
["current_skin"] = "blizzard",
["designs"] = {
["_custom"] = {
["highlights"] = {
{
["scale"] = 1,
["layer"] = 0,
["asset"] = "Platy: Arrow",
["width"] = 1.23,
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["anchor"] = {
},
["kind"] = "target",
["height"] = 1.22,
["sliced"] = true,
},
{
["color"] = {
["a"] = 1,
["b"] = 0.9215686917304992,
["g"] = 0.3725490272045136,
["r"] = 0.6941176652908325,
},
["layer"] = 0,
["asset"] = "Platy: 7px",
["width"] = 1.03,
["scale"] = 1,
["height"] = 1.24,
["anchor"] = {
},
["kind"] = "mouseover",
["sliced"] = true,
["includeTarget"] = true,
},
},
["specialBars"] = {
},
["scale"] = 1,
["auras"] = {
{
["direction"] = "RIGHT",
["filters"] = {
["important"] = true,
["fromYou"] = true,
},
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
["showPandemic"] = true,
["anchor"] = {
"BOTTOMLEFT",
-63,
25,
},
["limit"] = 30,
["showType"] = false,
["height"] = 1,
["kind"] = "debuffs",
["showSwipe"] = true,
["texts"] = {
["countdown"] = {
["visible"] = true,
["scale"] = 1.17,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
},
["stacks"] = {
["visible"] = true,
["scale"] = 0.92,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
},
},
},
{
["direction"] = "LEFT",
["filters"] = {
["dispelable"] = false,
["important"] = true,
["defensive"] = false,
},
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["showSwipe"] = true,
["showType"] = true,
["anchor"] = {
"LEFT",
-98,
0,
},
["limit"] = 30,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
["height"] = 1,
["kind"] = "buffs",
["showStealable"] = false,
["texts"] = {
["countdown"] = {
["visible"] = true,
["scale"] = 1.17,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
},
["stacks"] = {
["visible"] = true,
["scale"] = 0.92,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
},
},
},
{
["direction"] = "RIGHT",
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["filters"] = {
["fromYou"] = false,
},
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
["showType"] = false,
["limit"] = 30,
["anchor"] = {
"RIGHT",
101,
0,
},
["height"] = 1,
["kind"] = "crowdControl",
["showSwipe"] = true,
["texts"] = {
["countdown"] = {
["visible"] = true,
["scale"] = 1.17,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
},
},
["stacks"] = {
["visible"] = true,
["scale"] = 0.92,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
},
},
},
},
["font"] = {
["outline"] = true,
["shadow"] = true,
["asset"] = "RobotoCondensed-Bold",
["slug"] = true,
},
["version"] = 1,
["bars"] = {
{
["relativeTo"] = 0,
["animate"] = false,
["marker"] = {
["asset"] = "wide/glow",
},
["layer"] = 1,
["border"] = {
["height"] = 1,
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
},
["kind"] = "classColors",
},
{
["colors"] = {
["tapped"] = {
["b"] = 0.4313725490196079,
["g"] = 0.4313725490196079,
["r"] = 0.4313725490196079,
},
},
["kind"] = "tapped",
},
{
["combatOnly"] = false,
["colors"] = {
["offtank"] = {
["b"] = 0.7843137254901961,
["g"] = 0.6666666666666666,
["r"] = 0.05882352941176471,
},
["transition"] = {
["b"] = 0,
["g"] = 0.6274509803921569,
["r"] = 1,
},
["safe"] = {
["b"] = 0.9019607843137256,
["g"] = 0.5882352941176471,
["r"] = 0.05882352941176471,
},
["warning"] = {
["b"] = 0,
["g"] = 0,
["r"] = 0.8,
},
},
["useSafeColor"] = true,
["useOffTankColor"] = false,
["kind"] = "threat",
["tanksOnly"] = false,
["instancesOnly"] = false,
},
{
["colors"] = {
["unfriendly"] = {
["r"] = 1,
["g"] = 0.5058823529411764,
["b"] = 0,
},
["neutral"] = {
["b"] = 0,
["g"] = 1,
["r"] = 1,
},
["friendly"] = {
["b"] = 0,
["g"] = 1,
["r"] = 0,
},
["hostile"] = {
["b"] = 0,
["g"] = 0,
["r"] = 1,
},
},
["kind"] = "reaction",
},
},
["absorb"] = {
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["asset"] = "Platy: Absorb Wide",
},
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["anchor"] = {
},
["kind"] = "health",
["background"] = {
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Grey",
},
["scale"] = 1,
},
{
["marker"] = {
["asset"] = "wide/glow",
},
["layer"] = 1,
["border"] = {
["height"] = 1,
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
["cast"] = {
["r"] = 1,
["g"] = 0.09411764705882353,
["b"] = 0.1529411764705883,
},
["channel"] = {
["r"] = 0.0392156862745098,
["g"] = 0.2627450980392157,
["b"] = 1,
},
},
["kind"] = "importantCast",
},
{
["colors"] = {
["uninterruptable"] = {
["b"] = 0.7647058823529411,
["g"] = 0.7529411764705882,
["r"] = 0.5137254901960784,
},
},
["kind"] = "uninterruptableCast",
},
{
["colors"] = {
["empowered"] = {
["r"] = 0.0196078431372549,
["g"] = 0.7764705882352941,
["b"] = 0.4,
},
["cast"] = {
["b"] = 0,
["g"] = 0.5490196078431373,
["r"] = 0.9882352941176472,
},
["interrupted"] = {
["b"] = 0.8784313725490196,
["g"] = 0.211764705882353,
["r"] = 0.9882352941176472,
},
["channel"] = {
["r"] = 0.2431372549019608,
["g"] = 0.7764705882352941,
["b"] = 0.2156862745098039,
},
},
["kind"] = "cast",
},
},
["scale"] = 1,
["anchor"] = {
"TOP",
0,
-9,
},
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["kind"] = "cast",
["background"] = {
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyColor"] = true,
["asset"] = "Platy: Solid Grey",
},
["interruptMarker"] = {
["asset"] = "none",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
},
},
["markers"] = {
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "quest",
["anchor"] = {
"RIGHT",
-64,
0,
},
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["scale"] = 0.8,
},
{
["color"] = {
["b"] = 0.4980392156862745,
["g"] = 0.4823529411764706,
["r"] = 0.3921568627450981,
},
["kind"] = "cannotInterrupt",
["anchor"] = {
"TOPRIGHT",
-50,
-12,
},
["layer"] = 3,
["asset"] = "normal/shield-soft",
["scale"] = 0.5,
},
{
["openWorldOnly"] = false,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "elite",
["anchor"] = {
"LEFT",
-61,
0,
},
["layer"] = 3,
["asset"] = "special/blizzard-elite-midnight",
["scale"] = 0.8,
},
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["kind"] = "raid",
["anchor"] = {
"BOTTOM",
0,
20,
},
["layer"] = 3,
["asset"] = "normal/blizzard-raid",
["scale"] = 1,
},
},
["texts"] = {
{
["displayTypes"] = {
"absolute",
},
["scale"] = 0.98,
["layer"] = 2,
["formatMultiple"] = "%s (%s)",
["maxWidth"] = 0,
["showPercentSymbol"] = true,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["truncate"] = false,
["anchor"] = {
},
["kind"] = "health",
["significantFigures"] = 0,
["align"] = "CENTER",
},
{
["showWhenWowDoes"] = false,
["truncate"] = false,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 2,
["maxWidth"] = 0.99,
["autoColors"] = {
},
["anchor"] = {
"BOTTOM",
0,
9,
},
["kind"] = "creatureName",
["scale"] = 1.1,
["align"] = "CENTER",
},
{
["anchor"] = {
"TOP",
0,
-12,
},
["align"] = "CENTER",
["kind"] = "castSpellName",
["truncate"] = false,
["scale"] = 1,
["layer"] = 2,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["maxWidth"] = 0,
},
},
},
},
["target_behaviour"] = "enlarge",
["show_nameplates_only_needed"] = false,
["click_region_scale_x"] = 1,
["not_target_behaviour"] = "none",
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["simplified_scale"] = 0.6,
["cast_alpha"] = 1,
},
},
}
