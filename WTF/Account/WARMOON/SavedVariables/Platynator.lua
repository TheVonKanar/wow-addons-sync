
PLATYNATOR_CONFIG = {
["Version"] = 1,
["CharacterSpecific"] = {
},
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
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["cast_scale"] = 1.05,
["closer_nameplates"] = false,
["designs_assigned"] = {
["enemySimplifiedCombat"] = "_hare_simplified",
["enemyPvPPlayer"] = "_deer",
["enemyCombat"] = "_deer",
["friendCombat"] = "_name-only",
["friendPvPPlayer"] = "_name-only",
["enemySimplified"] = "Enemy Nameplates",
["friend"] = "Friendly Nameplates",
["enemy"] = "Enemy Nameplates",
},
["designs_enabled"] = {
["pvpInstance"] = false,
["combat"] = false,
["pvpWorld"] = false,
},
["cast_alpha"] = 1,
["apply_cvars"] = true,
["current_skin"] = "blizzard",
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
["scale"] = 0.9,
["kind"] = "quest",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["anchor"] = {
"BOTTOMLEFT",
-45.5,
2,
},
},
{
["scale"] = 1.2,
["kind"] = "raid",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["asset"] = "normal/blizzard-raid",
["anchor"] = {
"BOTTOM",
0,
17,
},
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
["b"] = 0,
["g"] = 1,
["r"] = 1,
},
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
"LEFT",
-48.5,
0,
},
["maxWidth"] = 0,
},
},
},
["Friendly Nameplates"] = {
["highlights"] = {
},
["specialBars"] = {
},
["scale"] = 1.25,
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
["anchor"] = {
"BOTTOM",
0,
19.5,
},
["layer"] = 3,
["scale"] = 1.2,
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
["neutral"] = {
["r"] = 1,
["g"] = 1,
["b"] = 0,
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
["filled"] = "normal/soft-full",
["blank"] = "normal/soft-faded",
["scale"] = 0.01,
["kind"] = "power",
["anchor"] = {
0,
-7,
},
["layer"] = 3,
},
},
["scale"] = 1.5,
["auras"] = {
{
["direction"] = "LEFT",
["scale"] = 0.9,
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
"BOTTOMRIGHT",
63,
10,
},
["kind"] = "debuffs",
["textScale"] = 0.7,
["filters"] = {
["important"] = true,
["fromYou"] = true,
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
["height"] = 0.95,
["showDispel"] = {
["enrage"] = true,
},
["anchor"] = {
"LEFT",
-92,
0,
},
["kind"] = "buffs",
["textScale"] = 0.9,
["filters"] = {
["dispelable"] = true,
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
["height"] = 0.95,
["showDispel"] = {
},
["anchor"] = {
"RIGHT",
92,
0,
},
["kind"] = "crowdControl",
["textScale"] = 0.9,
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
["transition"] = {
["b"] = 0.2274509966373444,
["g"] = 0.9137255549430848,
["r"] = 1,
},
["warning"] = {
["b"] = 0,
["g"] = 0.4352941513061523,
["r"] = 0.8666667342185974,
},
["safe"] = {
["b"] = 0.1137254983186722,
["g"] = 0.1882353127002716,
["r"] = 0.7450980544090271,
},
["offtank"] = {
["b"] = 1,
["g"] = 0.501960813999176,
["r"] = 0.501960813999176,
},
},
["kind"] = "threat",
["useSafeColor"] = false,
["instancesOnly"] = false,
},
{
["kind"] = "eliteType",
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
["marker"] = {
["asset"] = "none",
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
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["anchor"] = {
"LEFT",
-83.5,
0,
},
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["scale"] = 1,
},
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["anchor"] = {
"BOTTOMRIGHT",
10,
-2,
},
["kind"] = "raid",
["asset"] = "normal/blizzard-raid",
["scale"] = 1,
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
["global_scale"] = 1.1,
["target_behaviour"] = "none",
["obscured_alpha"] = 0.5,
["click_region_scale_y"] = 1.1,
["style"] = "Enemy Nameplates",
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["target_scale"] = 1.05,
["show_nameplates"] = {
["friendlyMinion"] = false,
["enemyMinor"] = true,
["friendlyPlayer"] = true,
["enemy"] = true,
["enemyMinion"] = true,
["friendlyNPC"] = false,
},
},
["Kvotheen"] = {
["stack_region_scale_y"] = 1.1,
["cast_alpha"] = 1,
["simplified_scale"] = 0.8,
["obscured_alpha"] = 0.6,
["design_all"] = {
},
["cast_scale"] = 1.1,
["mouseover_alpha"] = 1,
["closer_to_screen_edges"] = true,
["click_region_scale_x"] = 1,
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
["friend"] = "_name-only",
["enemySimplified"] = "Windfury",
["enemy"] = "Windfury",
},
["show_friendly_in_instances"] = true,
["style"] = "Windfury",
["blizzard_widget_scale"] = 1.2,
["show_friendly_in_instances_1"] = "name_only",
["stack_applies_to"] = {
["normal"] = true,
["minion"] = false,
["minor"] = false,
},
["not_target_alpha"] = 1,
["apply_cvars"] = true,
["current_skin"] = "blizzard",
["global_scale"] = 1,
["designs"] = {
["Windfury"] = {
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
["height"] = 1.15,
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
["scale"] = 1.35,
["auras"] = {
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["filters"] = {
["important"] = true,
["fromYou"] = true,
},
["textScale"] = 0.8,
["kind"] = "debuffs",
["anchor"] = {
"BOTTOMLEFT",
-62.5,
9.5,
},
["height"] = 0.8,
["showDispel"] = {
},
["showPandemic"] = true,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["direction"] = "LEFT",
["scale"] = 1,
["showCountdown"] = true,
["filters"] = {
["dispelable"] = false,
["important"] = true,
["defensive"] = false,
},
["anchor"] = {
"LEFT",
-98,
0,
},
["kind"] = "buffs",
["height"] = 1,
["showDispel"] = {
["enrage"] = true,
},
["textScale"] = 1,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["filters"] = {
["fromYou"] = false,
},
["textScale"] = 1,
["kind"] = "crowdControl",
["anchor"] = {
"RIGHT",
98.5,
0,
},
["showDispel"] = {
},
["height"] = 1,
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
["friendly"] = {
["b"] = 0,
["g"] = 1,
["r"] = 0,
},
["hostile"] = {
["b"] = 0,
["g"] = 0.2039215862751007,
["r"] = 1,
},
},
["kind"] = "reaction",
},
},
["relativeTo"] = 0,
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
["scale"] = 0.8,
["kind"] = "quest",
["anchor"] = {
"LEFT",
-68,
0,
},
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
{
["scale"] = 0.5,
["kind"] = "cannotInterrupt",
["anchor"] = {
"TOPRIGHT",
-50,
-12,
},
["layer"] = 3,
["asset"] = "normal/shield-soft",
["color"] = {
["b"] = 0.4980392156862745,
["g"] = 0.4823529411764706,
["r"] = 0.3921568627450981,
},
},
{
["openWorldOnly"] = false,
["anchor"] = {
"BOTTOMRIGHT",
70,
4,
},
["kind"] = "elite",
["scale"] = 0.8,
["layer"] = 3,
["asset"] = "special/blizzard-elite-midnight",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
},
{
["scale"] = 1,
["kind"] = "raid",
["anchor"] = {
"BOTTOM",
0,
5,
},
["layer"] = 3,
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
{
["truncate"] = false,
["scale"] = 1,
["layer"] = 2,
["maxWidth"] = 0,
["significantFigures"] = 0,
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
["anchor"] = {
},
["height"] = 1.22,
["kind"] = "target",
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["sliced"] = true,
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
["anchor"] = {
},
["height"] = 1,
["kind"] = "mouseover",
["sliced"] = true,
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
["kind"] = "target",
["anchor"] = {
},
["sliced"] = false,
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
["useSafeColor"] = false,
["instancesOnly"] = false,
},
{
["colors"] = {
["unfriendly"] = {
["b"] = 0,
["g"] = 0.5960784554481506,
["r"] = 1,
},
["hostile"] = {
["b"] = 0,
["g"] = 0.3019607961177826,
["r"] = 1,
},
["friendly"] = {
["r"] = 0,
["g"] = 1,
["b"] = 0,
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
["openWorldOnly"] = false,
["anchor"] = {
"BOTTOMRIGHT",
70,
4,
},
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
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
["sliced"] = true,
["height"] = 1.22,
["kind"] = "target",
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
["anchor"] = {
},
["height"] = 1.24,
["sliced"] = true,
["kind"] = "mouseover",
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
["instancesOnly"] = false,
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
["anchor"] = {
},
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
["kind"] = "health",
["scale"] = 1,
},
},
["markers"] = {
{
["scale"] = 1.6,
["kind"] = "raid",
["anchor"] = {
"BOTTOM",
0,
18,
},
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
"absolute",
},
["align"] = "CENTER",
["layer"] = 2,
["maxWidth"] = 0,
["significantFigures"] = 0,
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
["show_nameplates_only_needed"] = false,
["click_region_scale_y"] = 1,
["target_scale"] = 1.1,
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
["design_all"] = {
},
["closer_to_screen_edges"] = true,
["show_nameplates"] = {
["player"] = true,
["npc"] = true,
["enemy"] = true,
},
["not_target_behaviour"] = "none",
["simplified_nameplates"] = {
["minor"] = true,
["minion"] = true,
["instancesNormal"] = true,
},
["stacking_nameplates"] = true,
["designs_assigned"] = {
["friend"] = "_name-only",
["enemySimplified"] = "_hare_simplified",
["enemy"] = "_hare",
},
["show_friendly_in_instances"] = true,
["stack_region_scale_y"] = 1.1,
["global_scale"] = 1,
["show_friendly_in_instances_1"] = "always",
["stack_applies_to"] = {
["normal"] = true,
["minion"] = false,
["minor"] = false,
},
["show_nameplates_only_needed"] = false,
["apply_cvars"] = true,
["not_target_alpha"] = 1,
["click_region_scale_y"] = 1,
["designs"] = {
["_custom"] = {
["highlights"] = {
{
["scale"] = 1,
["height"] = 1,
["kind"] = "target",
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["anchor"] = {
},
["layer"] = 0,
["asset"] = "arrows",
["width"] = 1,
},
{
["color"] = {
["a"] = 1,
["b"] = 0.9215686917304992,
["g"] = 0.3725490272045136,
["r"] = 0.6941176652908325,
},
["height"] = 1.24,
["kind"] = "mouseover",
["anchor"] = {
},
["scale"] = 1,
["layer"] = 0,
["asset"] = "bold",
["width"] = 1.03,
},
},
["specialBars"] = {
},
["addon"] = "Platynator",
["auras"] = {
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["filters"] = {
["important"] = true,
["fromYou"] = true,
},
["textScale"] = 1,
["height"] = 1,
["anchor"] = {
"BOTTOMLEFT",
-63,
25,
},
["kind"] = "debuffs",
["showPandemic"] = true,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["direction"] = "LEFT",
["scale"] = 1,
["showCountdown"] = true,
["filters"] = {
["dispelable"] = true,
["important"] = true,
},
["anchor"] = {
"LEFT",
-98,
0,
},
["height"] = 1,
["kind"] = "buffs",
["textScale"] = 1,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
{
["direction"] = "RIGHT",
["scale"] = 1,
["showCountdown"] = true,
["filters"] = {
["fromYou"] = false,
},
["anchor"] = {
"RIGHT",
101,
0,
},
["height"] = 1,
["kind"] = "crowdControl",
["textScale"] = 1,
["sorting"] = {
["kind"] = "duration",
["reversed"] = false,
},
},
},
["font"] = {
["outline"] = true,
["shadow"] = true,
["asset"] = "RobotoCondensed-Bold",
},
["version"] = 1,
["kind"] = "style",
["bars"] = {
{
["relativeTo"] = 0,
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
["asset"] = "thin",
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
["useSafeColor"] = true,
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
["asset"] = "wide/blizzard-absorb",
},
["foreground"] = {
["asset"] = "wide/fade-bottom",
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
["asset"] = "grey",
},
["scale"] = 1,
},
{
["scale"] = 1,
["layer"] = 1,
["border"] = {
["height"] = 1,
["color"] = {
["a"] = 1,
["b"] = 0,
["g"] = 0,
["r"] = 0,
},
["asset"] = "thin",
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
["cast"] = {
["b"] = 0,
["g"] = 0.5490196078431373,
["r"] = 0.9882352941176472,
},
["uninterruptable"] = {
["b"] = 0.7647058823529411,
["g"] = 0.7529411764705882,
["r"] = 0.5137254901960784,
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
["kind"] = "cast",
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
["asset"] = "grey",
},
["foreground"] = {
["asset"] = "wide/fade-bottom",
},
["marker"] = {
["asset"] = "wide/glow",
},
},
},
["markers"] = {
{
["scale"] = 0.8,
["kind"] = "quest",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["asset"] = "normal/quest-blizzard",
["anchor"] = {
"RIGHT",
-64,
0,
},
},
{
["scale"] = 0.5,
["kind"] = "cannotInterrupt",
["color"] = {
["b"] = 0.4980392156862745,
["g"] = 0.4823529411764706,
["r"] = 0.3921568627450981,
},
["layer"] = 3,
["asset"] = "normal/shield-soft",
["anchor"] = {
"TOPRIGHT",
-50,
-12,
},
},
{
["scale"] = 0.8,
["kind"] = "elite",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["asset"] = "special/blizzard-elite-midnight",
["anchor"] = {
"LEFT",
-61,
0,
},
},
{
["scale"] = 1,
["kind"] = "raid",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["layer"] = 3,
["asset"] = "normal/blizzard-raid",
["anchor"] = {
"BOTTOM",
0,
20,
},
},
},
["texts"] = {
{
["widthLimit"] = 0,
["displayTypes"] = {
"absolute",
},
["align"] = "CENTER",
["layer"] = 2,
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["anchor"] = {
},
["kind"] = "health",
["truncate"] = false,
["scale"] = 0.98,
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
["autoColors"] = {
},
["scale"] = 1.1,
["anchor"] = {
"BOTTOM",
0,
9,
},
["kind"] = "creatureName",
["widthLimit"] = 124,
["align"] = "CENTER",
},
{
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["scale"] = 1,
["truncate"] = false,
["align"] = "CENTER",
["kind"] = "castSpellName",
["layer"] = 2,
["anchor"] = {
"TOP",
0,
-12,
},
},
},
},
},
["target_behaviour"] = "enlarge",
["style"] = "_hare",
["click_region_scale_x"] = 1,
["target_scale"] = 1.2,
["current_skin"] = "blizzard",
["cast_scale"] = 1.1,
["cast_alpha"] = 1,
},
},
}
