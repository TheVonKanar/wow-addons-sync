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

    -- Update popup
    UPDATE_AVAILABLE_TEXT = "Nuova versione disponibile",
    UPDATE_AVAILABLE_FMT = "%s ha un aggiornamento disponibile.\n\nAggiorna l'addon all'ultima versione.",

    -- Shared buttons
    BUTTON_OK = "OK",
    BUTTON_CANCEL = "Annulla",

    -- Options tab
    OPTIONS_HIDE_GREAT_VAULT = "Nascondi Grande Forziere",
    OPTIONS_HIDE_CURRENCY = "Nascondi valuta",

    HIDE_COMPLETED_WEEKS = "Nascondi settimane completate",
    OPTIONS_HIDE_CHANGE_WEEK_BTN = "Nascondi pulsante Cambia settimana",
    OPTIONS_HIDE_ILVL_REF_BTN = "Nascondi pulsante Rif. ilvl",

    RESET_BUTTON = "Reimposta",

    -- List tab
    DONE_PREFIX = "[Fatto] ",

    -- Tracking panel
    TRACKING_GREAT_VAULT_TITLE = "Grande Forziere",
    TRACKING_CURRENCY_TITLE = "Valuta",
    TRACKING_GV_RAID = "Raid",
    TRACKING_GV_DUNGEONS = "Dungeon",
    TRACKING_NA = "N/D",

    TRACKING_SPARKS_LABEL = "Scintille:",
    TRACKING_DONE = "Fatto",
    TRACKING_NOT_DONE = "Non fatto",

    TRACKING_QUEST_DELVERS_BOUNTY = "Ricompensa dell'esploratore:",
    TRACKING_QUEST_WEEKLY_PREY = "Preda settimanale:",

    TRACKING_CREST_LABEL = "Emblema:",
    TRACKING_CREST_ID_LABEL_FMT = "Emblema %s:",
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

    TRACKING_INF = "INF",

    -- Minimap tooltip
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clic sinistro: Mostra/nascondi la lista",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clic destro: Opzioni",

    -- Main window
    TAB_LIST = "Lista",
    TAB_OPTIONS = "Opzioni",
    CHANGE_WEEK_BUTTON = "Cambia settimana",
    ILVLREF_BUTTON = "Rif. ilvl",

    -- Item level reference popup
    ILVLREF_WINDOW_TITLE  = "Riferimento livelli oggetto – Midnight Stagione 1",

    ILVLREF_SEC_TRACKS    = "Percorsi di potenziamento  (20 emblemi per passo)",
    ILVLREF_SEC_CRAFTED   = "Livelli degli oggetti artigianali",
    ILVLREF_SEC_DUNGEONS  = "Livelli degli oggetti nei dungeon",
    ILVLREF_SEC_RAID      = "Livelli oggetto appross. del raid di Midnight",
    ILVLREF_SEC_DELVES    = "Livelli oggetto delle profondità rigogliose",

    ILVLREF_COL_ILVL         = "liv. ogg.",
    ILVLREF_COL_TRACK        = "Percorsi potenziamento",
    ILVLREF_COL_CREST_NEEDED = "Emblemi",
    ILVLREF_COL_QUALITY      = "Qualità",
    ILVLREF_COL_SOURCE       = "Fonte",
    ILVLREF_COL_END_LOOT     = "Bottino finale",
    ILVLREF_COL_GREAT_VAULT  = "Grande Forziere",
    ILVLREF_COL_DIFFICULTY   = "Difficoltà",
    ILVLREF_COL_BOSS1        = "Inizio",
    ILVLREF_COL_BOSS2        = "Metà",
    ILVLREF_COL_BOSS3        = "Tardi",
    ILVLREF_COL_BOSS4        = "Fine",
    ILVLREF_COL_TIER         = "Livello",
    ILVLREF_COL_MAP_DROP     = "Drop mappa",

    ILVLREF_CREST_ADV          = "Avv",
    ILVLREF_CREST_VET          = "Vet",
    ILVLREF_CREST_CHAMP        = "Camp",
    ILVLREF_CREST_HERO         = "Eroe",
    ILVLREF_CREST_MYTH         = "Dor",
    ILVLREF_DO_NOT_USE_CRESTS_FMT = "NON USARE EMBLEMI %s",

    ILVLREF_DUNGEON_PRE_HEROIC = "Eroico pre-stagione",
    ILVLREF_DUNGEON_HEROIC     = "Eroico",
    ILVLREF_DUNGEON_PRE_MYTHIC = "Mitico pre-stagione",
    ILVLREF_DUNGEON_MYTHIC     = "Mitico",

    ILVLREF_RAID_LFR           = "LFR",
    ILVLREF_RAID_NORMAL        = "Normale",
    ILVLREF_RAID_HEROIC        = "Eroico",
    ILVLREF_RAID_MYTHIC        = "Mitico",

    ILVLREF_DELVE_TIER_FMT     = "T%d",

    -- Slash commands
    SLASH_USAGE_TOGGLE = "Utilizzo: /larias o /lcl per mostrare/nascondere la lista",
    SLASH_USAGE_LOCALE = "Utilizzo: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Lingua impostata su %s (effettiva: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
