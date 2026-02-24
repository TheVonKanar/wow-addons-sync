--[[
German (deDE) strings for Larias's Weekly Checklist
]]

local LOCALE = "deDE"
local LOCALE_REGISTRY_KEY = "LARIASWEEKLYCHECKLIST_LOCALE_REGISTRY"

local reg = _G[LOCALE_REGISTRY_KEY]
if type(reg) ~= "table" then
    reg = {}
    _G[LOCALE_REGISTRY_KEY] = reg
end
if type(reg.strings) ~= "table" then reg.strings = {} end

reg.strings[LOCALE] = reg.strings[LOCALE] or {}
local L = reg.strings[LOCALE]

local STRINGS = {
    DISPLAY_NAME = "Larias's Weekly Checklist",

    UPDATE_AVAILABLE_TITLE = "Neue Version verfügbar",
    UPDATE_AVAILABLE_TEXT = "Neue Version verfügbar",
    UPDATE_AVAILABLE_FMT = "%s hat ein Update verfügbar.\n\nBitte aktualisiere das Addon auf die neueste Version.",

    BUTTON_OK = "OK",
    BUTTON_CANCEL = "Abbrechen",

    OPTIONS_SHOW_GREAT_VAULT = "Großes Gewölbe anzeigen",
    OPTIONS_SHOW_CURRENCY = "Währung anzeigen",

    HIDE_COMPLETED_WEEKS = "Abgeschlossene Wochen ausblenden",
    OPTIONS_BUTTON = "Optionen",
    RESET_BUTTON = "Zurücksetzen",
    DONE_PREFIX = "[Fertig] ",

    TRACKING_GREAT_VAULT_TITLE = "Großes Gewölbe",
    TRACKING_CURRENCY_TITLE = "Währung",
    TRACKING_GV_RAID = "Schlachtzug",
    TRACKING_GV_DUNGEONS = "Dungeons",
    TRACKING_NA = "N/A",

    TRACKING_SPARKS_LABEL = "Funken:",
    TRACKING_DONE = "Fertig",
    TRACKING_NOT_DONE = "Nicht fertig",

    TRACKING_QUEST_DELVERS_BOUNTY = "Erkundsuchprämie:",
    TRACKING_QUEST_WEEKLY_PREY = "Wöchentliche Beute:",

    TRACKING_CREST_LABEL = "Zinne:",
    TRACKING_CREST_ID_LABEL_FMT = "Zinne %s:",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Abenteurer",
        [3341] = "Veteran",
        [3343] = "Champion",
        [3345] = "Held",
        [3347] = "Vergoldet",
    },
    TRACKING_NO_ID = "Keine ID",
    TRACKING_TRADE_UP_SUFFIX = " Aufwerten)",

    TRACKING_CATALYST_LABEL = "Katalysator:",

    TRACKING_CURRENCY_FALLBACK_PREFIX = "Währung ",
    -- NOTE: should match the lowercase substring found in German WoW crest currency names ("Zinne").
    TRACKING_CREST_MATCH_SUBSTRING = "zinne",
    TRACKING_INF = "INF",

    MINIMAP_TOOLTIP_TEXT = "Linksklick zum Ein-/Ausblenden der Checkliste",
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Linksklick: Checkliste ein-/ausblenden",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Rechtsklick: Optionen",

    TAB_LIST = "Liste",
    TAB_OPTIONS = "Optionen",

    SLASH_USAGE_TOGGLE = "Verwendung: /larias oder /lcl zum Ein-/Ausblenden",
    SLASH_USAGE_LOCALE = "Verwendung: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Sprache gesetzt auf %s (aktiv: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
