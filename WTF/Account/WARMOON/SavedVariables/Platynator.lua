
PLATYNATOR_CONFIG = {
["CharacterSpecific"] = {
},
["Version"] = 1,
["Profiles"] = {
["DEFAULT"] = {
["stack_region_scale_x"] = 1.2,
["design_all"] = {
},
["closer_to_screen_edges"] = true,
["cast_alpha"] = 1,
["not_target_behaviour"] = "none",
["simplified_nameplates"] = {
["minor"] = true,
["minion"] = true,
["instancesNormal"] = true,
},
["stacking_nameplates"] = true,
["designs_assigned"] = {
["enemySimplified"] = "_hare_simplified",
["friend"] = "_name-only",
["enemy"] = "_hare",
},
["show_friendly_in_instances"] = true,
["cast_scale"] = 1.1,
["not_target_alpha"] = 1,
["show_friendly_in_instances_1"] = "always",
["stack_applies_to"] = {
["normal"] = true,
["minion"] = false,
["minor"] = false,
},
["show_nameplates_only_needed"] = false,
["apply_cvars"] = true,
["current_skin"] = "blizzard",
["click_region_scale_x"] = 1,
["designs"] = {
["_custom"] = {
["highlights"] = {
{
["anchor"] = {
},
["scale"] = 1,
["layer"] = 0,
["height"] = 1,
["color"] = {
["a"] = 1,
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "target",
["asset"] = "arrows",
["width"] = 1,
},
{
["scale"] = 1,
["color"] = {
["a"] = 1,
["r"] = 0.6941176652908325,
["g"] = 0.3725490272045136,
["b"] = 0.9215686917304992,
},
["layer"] = 0,
["height"] = 1.24,
["anchor"] = {
},
["kind"] = "mouseover",
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
["sorting"] = {
["reversed"] = false,
["kind"] = "duration",
},
["showPandemic"] = true,
["anchor"] = {
"BOTTOMLEFT",
-63,
25,
},
["height"] = 1,
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
["height"] = 1,
["kind"] = "buffs",
["anchor"] = {
"LEFT",
-98,
0,
},
["filters"] = {
["dispelable"] = true,
["important"] = true,
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
["textScale"] = 1,
["height"] = 1,
["kind"] = "crowdControl",
["anchor"] = {
"RIGHT",
101,
0,
},
["filters"] = {
["fromYou"] = false,
},
},
},
["font"] = {
["outline"] = true,
["shadow"] = true,
["asset"] = "RobotoCondensed-Bold",
},
["version"] = 1,
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
["r"] = 0,
["g"] = 0,
["b"] = 0,
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
["scale"] = 1,
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
["asset"] = "grey",
},
["foreground"] = {
["asset"] = "wide/fade-bottom",
},
["absorb"] = {
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["asset"] = "wide/blizzard-absorb",
},
},
{
["scale"] = 1,
["layer"] = 1,
["border"] = {
["height"] = 1,
["color"] = {
["a"] = 1,
["r"] = 0,
["g"] = 0,
["b"] = 0,
},
["asset"] = "thin",
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
["uninterruptable"] = {
["r"] = 0.5137254901960784,
["g"] = 0.7529411764705882,
["b"] = 0.7647058823529411,
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
["marker"] = {
["asset"] = "wide/glow",
},
["anchor"] = {
"TOP",
0,
-9,
},
["background"] = {
["color"] = {
["a"] = 1,
["b"] = 1,
["g"] = 1,
["r"] = 1,
},
["applyColor"] = true,
["asset"] = "grey",
},
["foreground"] = {
["asset"] = "wide/fade-bottom",
},
["kind"] = "cast",
},
},
["kind"] = "style",
["markers"] = {
{
["scale"] = 0.8,
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "quest",
["asset"] = "normal/quest-blizzard",
["anchor"] = {
"RIGHT",
-64,
0,
},
},
{
["scale"] = 0.5,
["layer"] = 3,
["color"] = {
["r"] = 0.3921568627450981,
["g"] = 0.4823529411764706,
["b"] = 0.4980392156862745,
},
["kind"] = "cannotInterrupt",
["asset"] = "normal/shield-soft",
["anchor"] = {
"TOPRIGHT",
-50,
-12,
},
},
{
["scale"] = 0.8,
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "elite",
["asset"] = "special/blizzard-elite-midnight",
["anchor"] = {
"LEFT",
-61,
0,
},
},
{
["scale"] = 1,
["layer"] = 3,
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "raid",
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
["scale"] = 0.98,
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
["autoColors"] = {
},
["align"] = "CENTER",
["anchor"] = {
"BOTTOM",
0,
9,
},
["kind"] = "creatureName",
["widthLimit"] = 124,
["scale"] = 1.1,
},
{
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
["kind"] = "castSpellName",
["truncate"] = false,
["scale"] = 1,
["layer"] = 2,
["anchor"] = {
"TOP",
0,
-12,
},
["align"] = "CENTER",
},
},
},
},
["target_behaviour"] = "enlarge",
["style"] = "_hare",
["click_region_scale_y"] = 1,
["target_scale"] = 1.2,
["global_scale"] = 1,
["stack_region_scale_y"] = 1.1,
["show_nameplates"] = {
["player"] = true,
["npc"] = true,
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
["instancesNormal"] = true,
},
["stacking_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["designs_assigned"] = {
["enemySimplified"] = "Windfury Simplified",
["friend"] = "_name-only",
["enemy"] = "Windfury",
},
["show_friendly_in_instances"] = true,
["target_scale"] = 1.1,
["blizzard_widget_scale"] = 1.2,
["show_friendly_in_instances_1"] = "never",
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
["scale"] = 0.8,
["layer"] = 3,
["anchor"] = {
"LEFT",
-68,
0,
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
["scale"] = 0.5,
["layer"] = 3,
["anchor"] = {
"TOPRIGHT",
-50,
-12,
},
["kind"] = "cannotInterrupt",
["asset"] = "normal/shield-soft",
["color"] = {
["r"] = 0.3921568627450981,
["g"] = 0.4823529411764706,
["b"] = 0.4980392156862745,
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
["scale"] = 0.8,
["kind"] = "elite",
["asset"] = "special/blizzard-elite-midnight",
["color"] = {
["r"] = 1,
["g"] = 1,
["b"] = 1,
},
},
{
["scale"] = 1,
["layer"] = 3,
["anchor"] = {
"BOTTOM",
0,
5,
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
["g"] = 0.5058823529411764,
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
["marker"] = {
["asset"] = "none",
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
["openWorldOnly"] = false,
["anchor"] = {
"BOTTOMRIGHT",
70,
4,
},
["kind"] = "elite",
["color"] = {
["b"] = 1,
["g"] = 1,
["r"] = 1,
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
["scale"] = 1.6,
["layer"] = 3,
["anchor"] = {
"BOTTOM",
0,
18,
},
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
["style"] = "Windfury Simplified",
["click_region_scale_x"] = 1,
["cast_scale"] = 1.1,
["clickable_nameplates"] = {
["friend"] = false,
["enemy"] = true,
},
["simplified_scale"] = 0.9,
["cast_alpha"] = 1,
},
},
}
