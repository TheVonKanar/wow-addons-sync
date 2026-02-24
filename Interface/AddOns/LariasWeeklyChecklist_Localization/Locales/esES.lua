--[[
Spanish Spain (esES) strings for Larias's Weekly Checklist
]]

local LOCALE = "esES"
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

    UPDATE_AVAILABLE_TITLE = "Nueva versión disponible",
    UPDATE_AVAILABLE_TEXT = "Nueva versión disponible",
    UPDATE_AVAILABLE_FMT = "%s tiene una actualización disponible.\n\nPor favor, actualiza el complemento a la versión más reciente.",

    BUTTON_OK = "Aceptar",
    BUTTON_CANCEL = "Cancelar",

    OPTIONS_SHOW_GREAT_VAULT = "Mostrar Gran Cámara",
    OPTIONS_SHOW_CURRENCY = "Mostrar moneda",

    HIDE_COMPLETED_WEEKS = "Ocultar semanas completadas",
    OPTIONS_BUTTON = "Opciones",
    RESET_BUTTON = "Reiniciar",
    DONE_PREFIX = "[Hecho] ",

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

    TRACKING_CREST_LABEL = "Cresta:",
    TRACKING_CREST_ID_LABEL_FMT = "Cresta %s:",
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

    TRACKING_CURRENCY_FALLBACK_PREFIX = "Moneda ",
    -- NOTE: should match the lowercase substring found in Spanish WoW crest currency names ("cresta").
    TRACKING_CREST_MATCH_SUBSTRING = "cresta",
    TRACKING_INF = "INF",

    MINIMAP_TOOLTIP_TEXT = "Clic izquierdo: mostrar/ocultar la lista",
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clic izquierdo: mostrar/ocultar la lista",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clic derecho: opciones",

    TAB_LIST = "Lista",
    TAB_OPTIONS = "Opciones",

    SLASH_USAGE_TOGGLE = "Uso: /larias o /lcl para mostrar/ocultar la lista",
    SLASH_USAGE_LOCALE = "Uso: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Idioma configurado a %s (efectivo: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
