
PLATYNATOR_CONFIG = {
["CharacterSpecific"] = {
},
["Version"] = 1,
["Profiles"] = {
["Jundies"] = {
["stack_region_scale_y"] = 2.8,
["design_all"] = {
},
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
["show_friendly_in_instances_1"] = "name_only",
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
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["cast_scale"] = 1.05,
["closer_nameplates"] = false,
["designs_assigned"] = {
["enemySimplifiedCombat"] = "_hare_simplified",
["enemyPvPPlayer"] = "Enemy Players",
["enemy"] = "Enemy Nameplates",
["friendCombat"] = "_name-only",
["friendPvPPlayer"] = "_name-only",
["friend"] = "Friendly Nameplates",
["enemySimplified"] = "Enemy Nameplates",
["enemyCombat"] = "_deer",
},
["designs_enabled"] = {
["pvpInstance"] = false,
["combat"] = false,
["pvpWorld"] = false,
},
["target_scale"] = 1.05,
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
["font"] = {
["outline"] = true,
["shadow"] = true,
["asset"] = "RobotoCondensed-Bold",
["slug"] = true,
},
["version"] = 1,
["bars"] = {
},
["markers"] = {
{
["anchor"] = {
"BOTTOMLEFT",
-45.5,
2,
},
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["scale"] = 0.9,
},
{
["anchor"] = {
"BOTTOM",
0,
17,
},
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
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
["neutral"] = {
["r"] = 1,
["g"] = 1,
["b"] = 0,
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
["font"] = {
["outline"] = false,
["shadow"] = true,
["asset"] = "Fira Sans Condensed Medium",
["slug"] = true,
},
["version"] = 1,
["bars"] = {
},
["markers"] = {
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
19.5,
},
["layer"] = 3,
["asset"] = "normal/blizzard-raid",
["scale"] = 1.2,
},
},
["texts"] = {
{
["showWhenWowDoes"] = true,
["truncate"] = false,
["color"] = {
["r"] = 0.9686275124549866,
["g"] = 0.9686275124549866,
["b"] = 0.9686275124549866,
},
["layer"] = 1,
["maxWidth"] = 1.03,
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
["colors"] = {
["unfriendly"] = {
["r"] = 1,
["g"] = 0.5058823529411764,
["b"] = 0,
},
["hostile"] = {
["b"] = 0,
["g"] = 0,
["r"] = 1,
},
["friendly"] = {
["b"] = 0,
["g"] = 1,
["r"] = 0,
},
["neutral"] = {
["b"] = 0,
["g"] = 1,
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
["align"] = "CENTER",
["scale"] = 1,
},
},
},
["Enemy Nameplates"] = {
["highlights"] = {
{
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 0,
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
["b"] = 0.6666666666666666,
["g"] = 0.6666666666666666,
["r"] = 0.6666666666666666,
},
["layer"] = 0,
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
},
["specialBars"] = {
{
["layer"] = 3,
["anchor"] = {
0,
-7,
},
["kind"] = "power",
["asset"] = "Platy: Soft Circle",
["scale"] = 0.01,
},
},
["scale"] = 1.5,
["auras"] = {
{
["direction"] = "LEFT",
["filters"] = {
["fromYou"] = true,
["important"] = true,
},
["showSwipe"] = true,
["scale"] = 0.9,
["layer"] = 1,
["showCountdown"] = true,
["textScale"] = 1,
["anchor"] = {
"BOTTOMRIGHT",
63,
10,
},
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
["limit"] = 3,
["showPandemic"] = true,
["height"] = 0.8,
["kind"] = "debuffs",
["showType"] = false,
["texts"] = {
["countdown"] = {
["anchor"] = {
},
["scale"] = 0.82,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["visible"] = true,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
9,
-0.5,
},
["scale"] = 0.64,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["visible"] = true,
},
},
},
{
["direction"] = "RIGHT",
["filters"] = {
["dispelable"] = true,
["important"] = true,
["defensive"] = false,
},
["layer"] = 1,
["scale"] = 0.9,
["showSwipe"] = true,
["showCountdown"] = true,
["texts"] = {
["countdown"] = {
["anchor"] = {
},
["scale"] = 0.82,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["visible"] = true,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
9.5,
-0.5,
},
["scale"] = 0.64,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["visible"] = true,
},
},
["height"] = 0.8,
["showType"] = true,
["limit"] = 3,
["textScale"] = 1,
["anchor"] = {
"BOTTOMLEFT",
-62,
10,
},
["kind"] = "buffs",
["showStealable"] = false,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["direction"] = "RIGHT",
["filters"] = {
["fromYou"] = false,
},
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["showSwipe"] = true,
["textScale"] = 1,
["height"] = 0.95,
["limit"] = 30,
["showType"] = false,
["anchor"] = {
"RIGHT",
92,
0,
},
["kind"] = "crowdControl",
["texts"] = {
["countdown"] = {
["anchor"] = {
},
["scale"] = 1.05,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["visible"] = true,
},
["stacks"] = {
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
["scale"] = 0.83,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["visible"] = true,
},
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
["asset"] = "Fira Sans Condensed Medium",
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
["height"] = 1.2,
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["asset"] = "Platy: 1px",
["width"] = 1,
},
["autoColors"] = {
{
["combatOnly"] = true,
["colors"] = {
["safe"] = {
["r"] = 0.7450980544090271,
["g"] = 0.1882353127002716,
["b"] = 0.1137254983186722,
},
["warning"] = {
["r"] = 0.8666667342185974,
["g"] = 0.4352941513061523,
["b"] = 0,
},
["offtank"] = {
["r"] = 0.501960813999176,
["g"] = 0.501960813999176,
["b"] = 1,
},
["transition"] = {
["r"] = 1,
["g"] = 0.9137255549430848,
["b"] = 0.2274509966373444,
},
},
["instancesOnly"] = false,
["useOffTankColor"] = true,
["kind"] = "threat",
["tanksOnly"] = false,
["useSafeColor"] = false,
},
{
["kind"] = "eliteType",
["colors"] = {
["boss"] = {
["r"] = 1,
["g"] = 0,
["b"] = 1,
},
["melee"] = {
["r"] = 0.7450980544090271,
["g"] = 0.1882353127002716,
["b"] = 0.1137254983186722,
},
["caster"] = {
["r"] = 0,
["g"] = 0.7490196228027344,
["b"] = 1,
},
["trivial"] = {
["r"] = 0.7450980544090271,
["g"] = 0.1882353127002716,
["b"] = 0.1137254983186722,
},
["miniboss"] = {
["r"] = 0.5764706134796143,
["g"] = 0.4392157196998596,
["b"] = 0.8588235974311829,
},
},
["instancesOnly"] = false,
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
["colors"] = {
["neutral"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0,
},
["hostile"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0,
},
["friendly"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0,
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
["b"] = 0,
["g"] = 0.8588235974311829,
["r"] = 0.8980392813682556,
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
["unfriendly"] = {
["r"] = 1,
["g"] = 0.5058823529411764,
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
["marker"] = {
["asset"] = "none",
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
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
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
["cast"] = {
["r"] = 1,
["g"] = 0.4941176772117615,
["b"] = 0.1372549086809158,
},
["empowered"] = {
["r"] = 0.0196078431372549,
["g"] = 0.7764705882352941,
["b"] = 0.4,
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
["scale"] = 1,
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
["scale"] = 1,
["kind"] = "quest",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["anchor"] = {
"LEFT",
-83.5,
0,
},
},
{
["scale"] = 1,
["kind"] = "raid",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 3,
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
["anchor"] = {
"TOPLEFT",
-62,
-17.5,
},
["scale"] = 0.8,
["kind"] = "castSpellName",
["truncate"] = true,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 2,
["align"] = "LEFT",
["maxWidth"] = 0.56,
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
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["applyClassColors"] = true,
},
{
["truncate"] = true,
["align"] = "RIGHT",
["layer"] = 2,
["maxWidth"] = 0.44,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
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
["Enemy Players"] = {
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
["anchor"] = {
},
["height"] = 1.1,
["sliced"] = true,
["scale"] = 0.96,
["kind"] = "target",
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
["anchor"] = {
},
["height"] = 1.2,
["sliced"] = true,
["scale"] = 1,
["kind"] = "target",
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
["anchor"] = {
},
["height"] = 1.2,
["sliced"] = true,
["scale"] = 1,
["kind"] = "focus",
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
["sliced"] = false,
["anchor"] = {
},
["kind"] = "focus",
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
["height"] = 1.2,
["anchor"] = {
},
["sliced"] = true,
["kind"] = "mouseover",
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
["height"] = 0.5,
["kind"] = "animatedBorder",
["borderWidth"] = 1.35,
["anchor"] = {
"TOP",
0,
-9.5,
},
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
["height"] = 1.1,
["anchor"] = {
"BOTTOM",
0,
-8,
},
["sliced"] = true,
["kind"] = "mouseover",
["includeTarget"] = false,
},
},
["specialBars"] = {
{
["kind"] = "power",
["anchor"] = {
0,
-7,
},
["layer"] = 3,
["asset"] = "Platy: Soft Circle",
["scale"] = 0.01,
},
},
["scale"] = 1.5,
["auras"] = {
{
["direction"] = "LEFT",
["texts"] = {
["countdown"] = {
["visible"] = true,
["anchor"] = {
},
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.82,
},
["stacks"] = {
["visible"] = true,
["anchor"] = {
"TOPRIGHT",
9,
-0.5,
},
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.64,
},
},
["scale"] = 0.9,
["showType"] = false,
["showSwipe"] = true,
["showCountdown"] = true,
["textScale"] = 1,
["height"] = 0.8,
["showPandemic"] = true,
["limit"] = 3,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["anchor"] = {
"BOTTOMRIGHT",
63,
10,
},
["kind"] = "debuffs",
["layer"] = 1,
["filters"] = {
["important"] = true,
["fromYou"] = true,
},
},
{
["direction"] = "RIGHT",
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["filters"] = {
["dispelable"] = true,
["important"] = true,
["defensive"] = false,
},
["scale"] = 0.9,
["layer"] = 1,
["showCountdown"] = true,
["showSwipe"] = true,
["anchor"] = {
"BOTTOMLEFT",
-62,
10,
},
["showType"] = true,
["limit"] = 3,
["textScale"] = 1,
["height"] = 0.8,
["kind"] = "buffs",
["showStealable"] = false,
["texts"] = {
["countdown"] = {
["visible"] = true,
["anchor"] = {
},
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.82,
},
["stacks"] = {
["visible"] = true,
["anchor"] = {
"TOPRIGHT",
9.5,
-0.5,
},
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
["direction"] = "RIGHT",
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["scale"] = 1,
["layer"] = 1,
["showCountdown"] = true,
["texts"] = {
["countdown"] = {
["visible"] = true,
["anchor"] = {
},
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 1.05,
},
["stacks"] = {
["visible"] = true,
["anchor"] = {
"TOPRIGHT",
12,
-1,
},
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 0.83,
},
},
["textScale"] = 1,
["anchor"] = {
"RIGHT",
92,
0,
},
["limit"] = 30,
["showType"] = false,
["height"] = 0.95,
["kind"] = "crowdControl",
["showSwipe"] = true,
["filters"] = {
["fromYou"] = false,
},
},
},
["font"] = {
["outline"] = false,
["shadow"] = true,
["asset"] = "Fira Sans Condensed Medium",
["slug"] = true,
},
["version"] = 1,
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
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["height"] = 1.2,
["asset"] = "Platy: 1px",
["width"] = 1,
},
["autoColors"] = {
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
},
["kind"] = "classColors",
},
{
["colors"] = {
["unfriendly"] = {
["b"] = 0,
["g"] = 0.5058823529411764,
["r"] = 1,
},
["neutral"] = {
["r"] = 0.8980392813682556,
["g"] = 0.8588235974311829,
["b"] = 0,
},
["hostile"] = {
["b"] = 0.1137254983186722,
["g"] = 0.1882353127002716,
["r"] = 0.7450980544090271,
},
["friendly"] = {
["r"] = 0,
["g"] = 0.8901961445808411,
["b"] = 0,
},
},
["kind"] = "reaction",
},
},
["scale"] = 1,
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
["kind"] = "health",
["anchor"] = {
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
["scale"] = 1,
["layer"] = 2,
["border"] = {
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["height"] = 0.5,
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
["empowered"] = {
["b"] = 0.4,
["g"] = 0.7764705882352941,
["r"] = 0.0196078431372549,
},
["cast"] = {
["b"] = 0.1372549086809158,
["g"] = 0.4941176772117615,
["r"] = 1,
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
["marker"] = {
["asset"] = "none",
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
["kind"] = "cast",
["foreground"] = {
["asset"] = "Platy: Solid White",
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
["anchor"] = {
"LEFT",
-83.5,
0,
},
["layer"] = 3,
["scale"] = 1,
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
{
["anchor"] = {
"BOTTOMRIGHT",
10,
3.5,
},
["layer"] = 3,
["scale"] = 1,
["kind"] = "raid",
["asset"] = "normal/blizzard-raid",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
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
["scale"] = 0.8,
["align"] = "LEFT",
["layer"] = 2,
["truncate"] = true,
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
["maxWidth"] = 0.56,
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
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["applyClassColors"] = true,
},
{
["truncate"] = true,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
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
["anchor"] = {
"TOPLEFT",
-86,
-9,
},
["scale"] = 1,
["layer"] = 2,
["truncate"] = false,
["align"] = "CENTER",
["kind"] = "quest",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["maxWidth"] = 0,
},
},
},
},
["target_behaviour"] = "none",
["style"] = "Enemy Players",
["click_region_scale_y"] = 1.1,
["obscured_alpha"] = 0.5,
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["cast_alpha"] = 1,
["show_nameplates"] = {
["friendlyMinion"] = false,
["enemyMinor"] = true,
["friendlyPlayer"] = true,
["friendlyNPC"] = false,
["enemyMinion"] = true,
["enemy"] = true,
},
},
["Kvotheen"] = {
["stack_region_scale_y"] = 1.1,
["show_nameplates"] = {
["friendlyMinion"] = false,
["enemyMinor"] = true,
["friendlyPlayer"] = false,
["enemy"] = true,
["enemyMinion"] = true,
["friendlyNPC"] = false,
},
["stack_region_scale_x"] = 1.2,
["design_all"] = {
},
["obscured_alpha"] = 0.6,
["show_nameplates_only_needed"] = false,
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["click_region_scale_y"] = 1,
["not_target_behaviour"] = "none",
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
["enemySimplified"] = "Windfury",
["friend"] = "_name-only",
["enemy"] = "Windfury",
},
["show_friendly_in_instances"] = true,
["target_scale"] = 1.1,
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
["designs"] = {
["Windfury"] = {
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
["height"] = 1.15,
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
["scale"] = 1.35,
["auras"] = {
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["showPandemic"] = true,
["showDispel"] = {
},
["height"] = 0.8,
["anchor"] = {
"BOTTOMLEFT",
-62.5,
9.5,
},
["kind"] = "debuffs",
["textScale"] = 0.8,
["filters"] = {
["fromYou"] = true,
["important"] = true,
},
},
{
["direction"] = "LEFT",
["scale"] = 1,
["showCountdown"] = true,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["textScale"] = 1,
["showDispel"] = {
["enrage"] = true,
},
["height"] = 1,
["kind"] = "buffs",
["anchor"] = {
"LEFT",
-98,
0,
},
["filters"] = {
["dispelable"] = false,
["important"] = true,
["defensive"] = false,
},
},
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["anchor"] = {
"RIGHT",
98.5,
0,
},
["showDispel"] = {
},
["height"] = 1,
["kind"] = "crowdControl",
["textScale"] = 1,
["filters"] = {
["fromYou"] = false,
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
["b"] = 1,
["g"] = 1,
["r"] = 1,
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
["r"] = 0,
["g"] = 0,
["b"] = 0,
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
["kind"] = "threat",
["useSafeColor"] = false,
["instancesOnly"] = false,
},
{
["colors"] = {
["neutral"] = {
["r"] = 0.8823530077934265,
["g"] = 0.8823530077934265,
["b"] = 0,
},
["friendly"] = {
["r"] = 0,
["g"] = 1,
["b"] = 0,
},
["hostile"] = {
["r"] = 1,
["g"] = 0.2039215862751007,
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
["relativeTo"] = 0,
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
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
["cast"] = {
["b"] = 0.1529411764705883,
["g"] = 0.09411764705882353,
["r"] = 1,
},
["channel"] = {
["b"] = 1,
["g"] = 0.2627450980392157,
["r"] = 0.0392156862745098,
},
},
["kind"] = "importantCast",
},
{
["colors"] = {
["uninterruptable"] = {
["r"] = 0.5137254901960784,
["g"] = 0.7529411764705882,
["b"] = 0.7647058823529411,
},
},
["kind"] = "uninterruptableCast",
},
{
["colors"] = {
["cast"] = {
["r"] = 0.9882352941176472,
["g"] = 0.5490196078431373,
["b"] = 0,
},
["interrupted"] = {
["r"] = 0.9882352941176472,
["g"] = 0.211764705882353,
["b"] = 0.8784313725490196,
},
["channel"] = {
["b"] = 0.2156862745098039,
["g"] = 0.7764705882352941,
["r"] = 0.2431372549019608,
},
},
["kind"] = "cast",
},
},
["scale"] = 1,
["kind"] = "cast",
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
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
["anchor"] = {
"TOP",
0,
-9,
},
["interruptMarker"] = {
["asset"] = "none",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
},
},
["markers"] = {
{
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 3,
["scale"] = 0.8,
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["anchor"] = {
"LEFT",
-68,
0,
},
},
{
["color"] = {
["r"] = 0.3921568627450981,
["g"] = 0.4823529411764706,
["b"] = 0.4980392156862745,
},
["layer"] = 3,
["scale"] = 0.5,
["kind"] = "cannotInterrupt",
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
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 3,
["anchor"] = {
"BOTTOMRIGHT",
70,
4,
},
["kind"] = "elite",
["asset"] = "special/blizzard-elite-midnight",
["scale"] = 0.8,
},
{
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 3,
["scale"] = 1,
["kind"] = "raid",
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
["b"] = 0.9843137860298157,
["g"] = 0.9843137860298157,
["r"] = 0.9843137860298157,
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
["align"] = "LEFT",
["scale"] = 0.92,
},
{
["scale"] = 1,
["anchor"] = {
"TOP",
0,
-12,
},
["layer"] = 2,
["truncate"] = false,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "castSpellName",
["align"] = "CENTER",
["maxWidth"] = 0,
},
{
["truncate"] = false,
["scale"] = 1,
["layer"] = 2,
["maxWidth"] = 0,
["significantFigures"] = 0,
["align"] = "RIGHT",
["anchor"] = {
"RIGHT",
59.5,
0,
},
["kind"] = "health",
["color"] = {
["a"] = 1,
["b"] = 0.9843137860298157,
["g"] = 0.9843137860298157,
["r"] = 0.9843137860298157,
},
["displayTypes"] = {
"percentage",
},
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
["kind"] = "target",
["height"] = 1.22,
["sliced"] = true,
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["anchor"] = {
},
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
["kind"] = "mouseover",
["height"] = 1,
["sliced"] = true,
["anchor"] = {
},
["includeTarget"] = true,
},
{
["scale"] = 0.9,
["layer"] = 0,
["asset"] = "Platy: Glow",
["width"] = 1,
["kind"] = "target",
["height"] = 1,
["sliced"] = false,
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
["b"] = 0,
["g"] = 0,
["r"] = 0,
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
["kind"] = "threat",
["instancesOnly"] = false,
["useSafeColor"] = false,
},
{
["colors"] = {
["unfriendly"] = {
["r"] = 1,
["g"] = 0.5960784554481506,
["b"] = 0,
},
["neutral"] = {
["b"] = 0,
["g"] = 0.8901961445808411,
["r"] = 0.8901961445808411,
},
["friendly"] = {
["b"] = 0,
["g"] = 1,
["r"] = 0,
},
["hostile"] = {
["r"] = 1,
["g"] = 0.3019607961177826,
["b"] = 0,
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
["marker"] = {
["asset"] = "none",
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
["kind"] = "quest",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["scale"] = 0.8,
},
{
["openWorldOnly"] = false,
["scale"] = 0.8,
["kind"] = "elite",
["anchor"] = {
"BOTTOMRIGHT",
70,
4,
},
["layer"] = 3,
["asset"] = "special/blizzard-elite-midnight",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
{
["anchor"] = {
"BOTTOM",
0,
5,
},
["kind"] = "raid",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
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
["r"] = 0.9843137860298157,
["g"] = 0.9843137860298157,
["b"] = 0.9843137860298157,
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
["scale"] = 0.92,
["align"] = "CENTER",
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
["sliced"] = true,
["anchor"] = {
},
["kind"] = "target",
["height"] = 1.22,
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
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
["sliced"] = true,
["height"] = 1.24,
["kind"] = "mouseover",
["anchor"] = {
},
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
["b"] = 0,
["g"] = 0,
["r"] = 0,
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
["transition"] = {
["b"] = 0,
["g"] = 0.6274509803921569,
["r"] = 1,
},
["offtank"] = {
["b"] = 0.7843137254901961,
["g"] = 0.6666666666666666,
["r"] = 0.05882352941176471,
},
["warning"] = {
["b"] = 0,
["g"] = 0,
["r"] = 0.8,
},
},
["kind"] = "threat",
["useSafeColor"] = true,
["instancesOnly"] = false,
},
{
["colors"] = {
["neutral"] = {
["b"] = 0,
["g"] = 1,
["r"] = 1,
},
["hostile"] = {
["b"] = 0,
["g"] = 0,
["r"] = 1,
},
["friendly"] = {
["b"] = 0,
["g"] = 1,
["r"] = 0,
},
["unfriendly"] = {
["r"] = 1,
["g"] = 0.5058823529411764,
["b"] = 0,
},
},
["kind"] = "reaction",
},
},
["scale"] = 1,
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
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["kind"] = "health",
["anchor"] = {
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
},
["markers"] = {
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["scale"] = 1.6,
["kind"] = "raid",
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
["maxWidth"] = 0,
["significantFigures"] = 0,
["scale"] = 3,
["anchor"] = {
},
["kind"] = "health",
["truncate"] = false,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
},
},
},
["global_scale"] = 1,
["target_behaviour"] = "enlarge",
["style"] = "Windfury",
["click_region_scale_x"] = 1,
["cast_scale"] = 1.1,
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["simplified_scale"] = 0.8,
["cast_alpha"] = 1,
},
["DEFAULT"] = {
["stack_region_scale_x"] = 1.2,
["cast_alpha"] = 1,
["simplified_scale"] = 0.6,
["obscured_alpha"] = 0.4,
["not_target_behaviour"] = "none",
["design_all"] = {
},
["click_region_scale_x"] = 1,
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["show_nameplates_only_needed"] = false,
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
["designs_assigned"] = {
["enemySimplifiedCombat"] = "_hare_simplified",
["enemyPvPPlayer"] = "_deer",
["enemy"] = "_hare",
["friendCombat"] = "_name-only",
["friendPvPPlayer"] = "_name-only",
["enemySimplified"] = "_hare_simplified",
["friend"] = "_name-only",
["enemyCombat"] = "_deer",
},
["show_friendly_in_instances"] = true,
["not_target_alpha"] = 1,
["blizzard_widget_scale"] = 1.2,
["show_friendly_in_instances_1"] = "always",
["stack_applies_to"] = {
["normal"] = true,
["minion"] = false,
["minor"] = false,
},
["designs"] = {
["_custom"] = {
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
["height"] = 1.22,
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
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
["sliced"] = true,
["height"] = 1.24,
["kind"] = "mouseover",
["anchor"] = {
},
["includeTarget"] = true,
},
},
["specialBars"] = {
},
["scale"] = 1,
["auras"] = {
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["showPandemic"] = true,
["showDispel"] = {
},
["height"] = 1,
["anchor"] = {
"BOTTOMLEFT",
-63,
25,
},
["kind"] = "debuffs",
["textScale"] = 1,
["filters"] = {
["fromYou"] = true,
["important"] = true,
},
},
{
["direction"] = "LEFT",
["scale"] = 1,
["showCountdown"] = true,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["textScale"] = 1,
["showDispel"] = {
["enrage"] = true,
},
["anchor"] = {
"LEFT",
-98,
0,
},
["kind"] = "buffs",
["height"] = 1,
["filters"] = {
["dispelable"] = false,
["important"] = true,
["defensive"] = false,
},
},
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["height"] = 1,
["showDispel"] = {
},
["anchor"] = {
"RIGHT",
101,
0,
},
["kind"] = "crowdControl",
["textScale"] = 1,
["filters"] = {
["fromYou"] = false,
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
["r"] = 0,
["g"] = 0,
["b"] = 0,
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
["warning"] = {
["r"] = 0.8,
["g"] = 0,
["b"] = 0,
},
["transition"] = {
["r"] = 1,
["g"] = 0.6274509803921569,
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
["kind"] = "threat",
["useSafeColor"] = true,
["instancesOnly"] = false,
},
{
["colors"] = {
["unfriendly"] = {
["b"] = 0,
["g"] = 0.5058823529411764,
["r"] = 1,
},
["hostile"] = {
["r"] = 1,
["g"] = 0,
["b"] = 0,
},
["friendly"] = {
["r"] = 0,
["g"] = 1,
["b"] = 0,
},
["neutral"] = {
["r"] = 1,
["g"] = 1,
["b"] = 0,
},
},
["kind"] = "reaction",
},
},
["scale"] = 1,
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
["kind"] = "health",
["anchor"] = {
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
{
["marker"] = {
["asset"] = "wide/glow",
},
["layer"] = 1,
["border"] = {
["height"] = 1,
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["asset"] = "Platy: 2px",
["width"] = 1,
},
["autoColors"] = {
{
["colors"] = {
["cast"] = {
["b"] = 0.1529411764705883,
["g"] = 0.09411764705882353,
["r"] = 1,
},
["channel"] = {
["b"] = 1,
["g"] = 0.2627450980392157,
["r"] = 0.0392156862745098,
},
},
["kind"] = "importantCast",
},
{
["colors"] = {
["uninterruptable"] = {
["r"] = 0.5137254901960784,
["g"] = 0.7529411764705882,
["b"] = 0.7647058823529411,
},
},
["kind"] = "uninterruptableCast",
},
{
["colors"] = {
["empowered"] = {
["b"] = 0.4,
["g"] = 0.7764705882352941,
["r"] = 0.0196078431372549,
},
["cast"] = {
["r"] = 0.9882352941176472,
["g"] = 0.5490196078431373,
["b"] = 0,
},
["interrupted"] = {
["r"] = 0.9882352941176472,
["g"] = 0.211764705882353,
["b"] = 0.8784313725490196,
},
["channel"] = {
["b"] = 0.2156862745098039,
["g"] = 0.7764705882352941,
["r"] = 0.2431372549019608,
},
},
["kind"] = "cast",
},
},
["scale"] = 1,
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
["anchor"] = {
"TOP",
0,
-9,
},
["kind"] = "cast",
["foreground"] = {
["asset"] = "Platy: Fade Bottom",
},
["interruptMarker"] = {
["asset"] = "none",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
},
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
"RIGHT",
-64,
0,
},
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["scale"] = 0.8,
},
{
["color"] = {
["r"] = 0.3921568627450981,
["g"] = 0.4823529411764706,
["b"] = 0.4980392156862745,
},
["layer"] = 3,
["anchor"] = {
"TOPRIGHT",
-50,
-12,
},
["kind"] = "cannotInterrupt",
["asset"] = "normal/shield-soft",
["scale"] = 0.5,
},
{
["openWorldOnly"] = false,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 3,
["anchor"] = {
"LEFT",
-61,
0,
},
["kind"] = "elite",
["asset"] = "special/blizzard-elite-midnight",
["scale"] = 0.8,
},
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
20,
},
["kind"] = "raid",
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
["align"] = "CENTER",
["significantFigures"] = 0,
["anchor"] = {
},
["kind"] = "health",
["truncate"] = false,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
{
["showWhenWowDoes"] = false,
["truncate"] = false,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
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
["align"] = "CENTER",
["scale"] = 1.1,
},
{
["align"] = "CENTER",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["layer"] = 2,
["truncate"] = false,
["anchor"] = {
"TOP",
0,
-12,
},
["kind"] = "castSpellName",
["scale"] = 1,
["maxWidth"] = 0,
},
},
},
},
["apply_cvars"] = true,
["current_skin"] = "blizzard",
["stack_region_scale_y"] = 1.1,
["global_scale"] = 1,
["target_behaviour"] = "enlarge",
["target_scale"] = 1.2,
["click_region_scale_y"] = 1,
["style"] = "_hare",
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["show_nameplates"] = {
["friendlyMinion"] = false,
["enemyMinor"] = true,
["friendlyPlayer"] = true,
["enemy"] = true,
["enemyMinion"] = true,
["friendlyNPC"] = true,
},
["designs_enabled"] = {
["pvpInstance"] = false,
["combat"] = false,
["pvpWorld"] = false,
},
},
},
}
