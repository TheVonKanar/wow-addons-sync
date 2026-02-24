--[[
French (frFR) strings for Larias's Weekly Checklist
]]

local LOCALE = "frFR"
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

    UPDATE_AVAILABLE_TITLE = "Nouvelle version disponible",
    UPDATE_AVAILABLE_TEXT = "Nouvelle version disponible",
    UPDATE_AVAILABLE_FMT = "%s a une mise à jour disponible.\n\nVeuillez mettre à jour l'addon vers la dernière version.",

    BUTTON_OK = "OK",
    BUTTON_CANCEL = "Annuler",

    OPTIONS_SHOW_GREAT_VAULT = "Afficher le Grand Coffre",
    OPTIONS_SHOW_CURRENCY = "Afficher la monnaie",

    HIDE_COMPLETED_WEEKS = "Masquer les semaines complétées",
    OPTIONS_BUTTON = "Options",
    RESET_BUTTON = "Réinitialiser",
    DONE_PREFIX = "[Fait] ",

    TRACKING_GREAT_VAULT_TITLE = "Grand Coffre",
    TRACKING_CURRENCY_TITLE = "Monnaie",
    TRACKING_GV_RAID = "Raid",
    TRACKING_GV_DUNGEONS = "Donjons",
    TRACKING_NA = "N/D",

    TRACKING_SPARKS_LABEL = "Étincelles :",
    TRACKING_DONE = "Terminé",
    TRACKING_NOT_DONE = "Non terminé",

    TRACKING_QUEST_DELVERS_BOUNTY = "Prime de l'explorateur :",
    TRACKING_QUEST_WEEKLY_PREY = "Proie hebdomadaire :",

    TRACKING_CREST_LABEL = "Crête :",
    TRACKING_CREST_ID_LABEL_FMT = "Crête %s :",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Aventurier",
        [3341] = "Vétéran",
        [3343] = "Champion",
        [3345] = "Héros",
        [3347] = "Doré",
    },
    TRACKING_NO_ID = "Aucun ID",
    TRACKING_TRADE_UP_SUFFIX = " Améliorer)",

    TRACKING_CATALYST_LABEL = "Catalyseur :",

    TRACKING_CURRENCY_FALLBACK_PREFIX = "Monnaie ",
    -- NOTE: should match the lowercase substring found in French WoW crest currency names ("crête").
    TRACKING_CREST_MATCH_SUBSTRING = "crête",
    TRACKING_INF = "INF",

    MINIMAP_TOOLTIP_TEXT = "Clic gauche : afficher/masquer la liste",
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clic gauche : Afficher/masquer la liste",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clic droit : Options",

    TAB_LIST = "Liste",
    TAB_OPTIONS = "Options",

    SLASH_USAGE_TOGGLE = "Utilisation : /larias ou /lcl pour afficher/masquer la liste",
    SLASH_USAGE_LOCALE = "Utilisation : /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Langue définie sur %s (effective : %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
