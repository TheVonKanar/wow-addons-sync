--[[
Italian (itIT) strings for Larias's Weekly Checklist
]]

local LOCALE = "itIT"
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

    UPDATE_AVAILABLE_TITLE = "Nuova versione disponibile",
    UPDATE_AVAILABLE_TEXT = "Nuova versione disponibile",
    UPDATE_AVAILABLE_FMT = "%s ha un aggiornamento disponibile.\n\nAggiorna l'addon all'ultima versione.",

    BUTTON_OK = "OK",
    BUTTON_CANCEL = "Annulla",

    OPTIONS_SHOW_GREAT_VAULT = "Mostra Grande Volta",
    OPTIONS_SHOW_CURRENCY = "Mostra valuta",

    HIDE_COMPLETED_WEEKS = "Nascondi settimane completate",
    OPTIONS_BUTTON = "Opzioni",
    RESET_BUTTON = "Reimposta",
    DONE_PREFIX = "[Fatto] ",

    TRACKING_GREAT_VAULT_TITLE = "Grande Volta",
    TRACKING_CURRENCY_TITLE = "Valuta",
    TRACKING_GV_RAID = "Raid",
    TRACKING_GV_DUNGEONS = "Dungeon",
    TRACKING_NA = "N/D",

    TRACKING_SPARKS_LABEL = "Scintille:",
    TRACKING_DONE = "Fatto",
    TRACKING_NOT_DONE = "Non fatto",

    TRACKING_QUEST_DELVERS_BOUNTY = "Ricompensa dell'esploratore:",
    TRACKING_QUEST_WEEKLY_PREY = "Preda settimanale:",

    TRACKING_CREST_LABEL = "Cresta:",
    TRACKING_CREST_ID_LABEL_FMT = "Cresta %s:",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Avventuriero",
        [3341] = "Veterano",
        [3343] = "Campione",
        [3345] = "Eroe",
        [3347] = "Dorato",
    },
    TRACKING_NO_ID = "Nessun ID",
    TRACKING_TRADE_UP_SUFFIX = " Potenzia)",

    TRACKING_CATALYST_LABEL = "Catalizzatore:",

    TRACKING_CURRENCY_FALLBACK_PREFIX = "Valuta ",
    -- NOTE: should match the lowercase substring found in Italian WoW crest currency names ("cresta").
    TRACKING_CREST_MATCH_SUBSTRING = "cresta",
    TRACKING_INF = "INF",

    MINIMAP_TOOLTIP_TEXT = "Clic sinistro: mostra/nascondi la lista",
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clic sinistro: Mostra/nascondi la lista",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clic destro: Opzioni",

    TAB_LIST = "Lista",
    TAB_OPTIONS = "Opzioni",

    SLASH_USAGE_TOGGLE = "Utilizzo: /larias o /lcl per mostrare/nascondere la lista",
    SLASH_USAGE_LOCALE = "Utilizzo: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Lingua impostata su %s (effettiva: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
