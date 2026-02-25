--[[
Spanish (esMX) strings for Larias's Weekly Checklist
]]

local LOCALE = "esMX"
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
    UPDATE_AVAILABLE_TEXT = "Nueva versión disponible",
    UPDATE_AVAILABLE_FMT = "%s tiene una actualización disponible.\n\nPor favor, actualiza el addon a la versión más reciente.",

    -- Shared buttons
    BUTTON_OK = "Aceptar",
    BUTTON_CANCEL = "Cancelar",

    -- Options tab
    OPTIONS_HIDE_GREAT_VAULT = "Ocultar Gran Cámara",
    OPTIONS_HIDE_CURRENCY = "Ocultar moneda",

    HIDE_COMPLETED_WEEKS = "Ocultar semanas completadas",
    OPTIONS_HIDE_CHANGE_WEEK_BTN = "Ocultar botón Cambiar semana",
    OPTIONS_HIDE_ILVL_REF_BTN = "Ocultar botón Refs. ilvl",
    RESET_BUTTON = "Reiniciar",

    -- List tab
    DONE_PREFIX = "[Hecho] ",

    -- Tracking panel
    TRACKING_GREAT_VAULT_TITLE = "Gran Cámara",
    TRACKING_CURRENCY_TITLE = "Moneda",
    TRACKING_GV_RAID = "Banda",
    TRACKING_GV_DUNGEONS = "Mazmorras",
    TRACKING_NA = "N/D",

    TRACKING_SPARKS_LABEL = "Chispas:",
    TRACKING_DONE = "Hecho",
    TRACKING_NOT_DONE = "No hecho",

    TRACKING_QUEST_DELVERS_BOUNTY = "Botín del explorador:",
    TRACKING_QUEST_WEEKLY_PREY = "Presa semanal:",

    TRACKING_CREST_LABEL = "Blasón:",
    TRACKING_CREST_ID_LABEL_FMT = "Blasón %s:",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Aventurero",
        [3341] = "Veterano",
        [3343] = "Campeón",
        [3345] = "Héroe",
        [3347] = "Dorado",
    },
    TRACKING_NO_ID = "Sin ID",
    TRACKING_TRADE_UP_SUFFIX = " Mejorar)",

    TRACKING_CATALYST_LABEL = "Catalizador:",

    TRACKING_INF = "INF",

    -- Minimap tooltip
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clic izquierdo: mostrar/ocultar la lista",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clic derecho: opciones",

    -- Main window
    TAB_LIST = "Lista",
    TAB_OPTIONS = "Opciones",
    CHANGE_WEEK_BUTTON = "Cambiar semana",
    ILVLREF_BUTTON = "Refs. ilvl",

    -- Item level reference popup
    ILVLREF_WINDOW_TITLE  = "Referencia de nivel de objeto – Temporada 1 de Midnight",

    ILVLREF_SEC_TRACKS    = "Rangos de mejora  (20 blasones por paso)",
    ILVLREF_SEC_CRAFTED   = "Niveles de objeto fabricado",
    ILVLREF_SEC_DUNGEONS  = "Niveles de objeto en mazmorra",
    ILVLREF_SEC_RAID      = "Aprox. niveles de objeto en banda de Midnight",
    ILVLREF_SEC_DELVES    = "Niveles de objeto en profundidades abundantes",

    ILVLREF_COL_ILVL         = "n. obj.",
    ILVLREF_COL_TRACK        = "Rangos de mejora",
    ILVLREF_COL_CREST_NEEDED = "Blasones",
    ILVLREF_COL_QUALITY      = "Calidad",
    ILVLREF_COL_SOURCE       = "Fuente",
    ILVLREF_COL_END_LOOT     = "Botín final",
    ILVLREF_COL_GREAT_VAULT  = "Gran Cámara",
    ILVLREF_COL_DIFFICULTY   = "Dificultad",
    ILVLREF_COL_BOSS1        = "Inicio",
    ILVLREF_COL_BOSS2        = "Medio",
    ILVLREF_COL_BOSS3        = "Final",
    ILVLREF_COL_BOSS4        = "Fin",
    ILVLREF_COL_TIER         = "Nivel",
    ILVLREF_COL_MAP_DROP     = "Drop de mapa",

    ILVLREF_CREST_ADV          = "Avent",
    ILVLREF_CREST_VET          = "Vet",
    ILVLREF_CREST_CHAMP        = "Cam",
    ILVLREF_CREST_HERO         = "Héroe",
    ILVLREF_CREST_MYTH         = "Dor",
    ILVLREF_DO_NOT_USE_CRESTS_FMT = "NO USAR BLASONES %s",

    ILVLREF_DUNGEON_PRE_HEROIC = "Heroico de pretemp.",
    ILVLREF_DUNGEON_HEROIC     = "Heroico",
    ILVLREF_DUNGEON_PRE_MYTHIC = "Mítico de pretemp.",
    ILVLREF_DUNGEON_MYTHIC     = "Mítico",

    ILVLREF_RAID_LFR           = "LFR",
    ILVLREF_RAID_NORMAL        = "Normal",
    ILVLREF_RAID_HEROIC        = "Heroico",
    ILVLREF_RAID_MYTHIC        = "Mítico",

    ILVLREF_DELVE_TIER_FMT     = "T%d",

    -- Slash commands
    SLASH_USAGE_TOGGLE = "Uso: /larias o /lcl para mostrar/ocultar la lista",

    SLASH_USAGE_LOCALE = "Uso: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Idioma configurado a %s (efectivo: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
