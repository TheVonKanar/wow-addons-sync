--[[
French (frFR) strings for Larias's Weekly Checklist
]]
if GetLocale() ~= "frFR" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

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

    -- Update popup
    UPDATE_AVAILABLE_TEXT = "Nouvelle version disponible",
    UPDATE_AVAILABLE_FMT = "%s a une mise à jour disponible.\n\nVeuillez mettre à jour l'addon vers la dernière version.",

    -- Shared buttons
    BUTTON_OK = "OK",
    BUTTON_CANCEL = "Annuler",

    -- Options tab
    OPTIONS_HIDE_GREAT_VAULT = "Masquer la Grande Chambre Forte",
    OPTIONS_HIDE_CURRENCY = "Masquer la monnaie",

    HIDE_COMPLETED_WEEKS = "Masquer les semaines complétées",
    OPTIONS_HIDE_CHANGE_WEEK_BTN = "Masquer le bouton Changer de semaine",
    OPTIONS_HIDE_ILVL_REF_BTN = "Masquer le bouton Niveaux d'objet",
    OPTIONS_HIDE_CHAR_SELECT = "Masquer la sélection de personnage",
    OPTIONS_HIDDEN_CHARS_TITLE = "Personnages masqués :",
    OPTIONS_HIDDEN_CHARS_NONE = "Aucun",
    RESET_BUTTON = "Réinitialiser",
    UI_SCALE_LABEL = "Échelle UI",
    UI_SCALE_MIN_LABEL = "50%",
    UI_SCALE_MAX_LABEL = "150%",
    OPTIONS_HIDE_SCALE_SLIDER = "Masquer le curseur de mise à l'échelle",

    -- List tab
    DONE_PREFIX = "[Fait] ",

    -- Tracking panel
    TRACKING_GREAT_VAULT_TITLE = "Grande Chambre Forte",
    TRACKING_CURRENCY_TITLE = "Monnaie",
    TRACKING_GV_RAID = "Raid",
    TRACKING_GV_DUNGEONS = "Donjons",
    TRACKING_GV_WORLD    = "Monde",
    TRACKING_NA = "N/D",

    TRACKING_SPARKS_LABEL = "Étincelles :",
    TRACKING_DONE = "Terminé",
    TRACKING_NOT_DONE = "Non terminé",

    TRACKING_QUEST_DELVERS_BOUNTY = "Prime de l'explorateur :",
    TRACKING_QUEST_WEEKLY_PREY = "Traque hebdomadaire :",

    TRACKING_CREST_LABEL = "Écu :",
    TRACKING_CREST_ID_LABEL_FMT = "Écu %s :",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Aventure",
        [3341] = "Vétéran",
        [3343] = "Champion",
        [3345] = "Héroïque",
        [3347] = "Mythique",
    },
    TRACKING_NO_ID = "Aucun ID",
    TRACKING_TRADE_UP_SUFFIX = " Améliorer)",

    TRACKING_CATALYST_LABEL = "Catalyseur :",

    TRACKING_INF = "INF",

    -- Minimap tooltip
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clic gauche : Afficher/masquer la liste",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clic droit : Options",
    MINIMAP_TOOLTIP_MIDDLE_CLICK_ILVL = "Clic milieu : Niveaux d'objet",

    -- Main window
    TAB_OPTIONS = "Options",

    CHANGE_WEEK_BUTTON = "Changer de semaine",
    ILVLREF_BUTTON = "Voir les niveaux d'objet",

    -- Item level reference popup
    ILVLREF_WINDOW_TITLE  = "Référence des niveaux d'objet – Midnight Saison 1",

    ILVLREF_SEC_TRACKS    = "Voies d'amélioration  (20 écus par étape)",
    ILVLREF_SEC_CRAFTED   = "Niveaux d'objet fabriqué",
    ILVLREF_SEC_DUNGEONS  = "Niveaux d'objet en donjon",
    ILVLREF_SEC_RAID      = "Niveaux d'objet approx. du raid Midnight",
    ILVLREF_SEC_DELVES    = "Niveaux d'objet des gouffres abondants",

    ILVLREF_COL_ILVL         = "niv. obj.",
    ILVLREF_COL_TRACK        = "Voies d'amélioration",
    ILVLREF_COL_CREST_NEEDED = "Écus",
    ILVLREF_COL_QUALITY      = "Qualité",
    ILVLREF_COL_SOURCE       = "Source",
    ILVLREF_COL_END_LOOT     = "Butin final",
    ILVLREF_COL_GREAT_VAULT  = "Grande Chambre Forte",
    ILVLREF_COL_DIFFICULTY   = "Difficulté",
    ILVLREF_COL_BOSS1        = "Début",
    ILVLREF_COL_BOSS2        = "Milieu",
    ILVLREF_COL_BOSS3        = "Fin",
    ILVLREF_COL_BOSS4        = "Final",
    ILVLREF_COL_TIER         = "Niveau",
    ILVLREF_COL_MAP_DROP     = "Butin de carte",

    ILVLREF_CREST_ADV          = "Avent",
    ILVLREF_CREST_VET          = "Vét",
    ILVLREF_CREST_CHAMP        = "Champ",
    ILVLREF_CREST_HERO         = "Héroïque",
    ILVLREF_CREST_MYTH         = "Myth",
    ILVLREF_DO_NOT_USE_CRESTS_FMT = "NE PAS UTILISER D'ÉCUS %s",

    ILVLREF_DUNGEON_PRE_HEROIC = "Héroïque avant-saison",
    ILVLREF_DUNGEON_HEROIC     = "Héroïque",
    ILVLREF_DUNGEON_PRE_MYTHIC = "Mythique avant-saison",
    ILVLREF_DUNGEON_MYTHIC     = "Mythique",

    ILVLREF_RAID_LFR           = "LFR",
    ILVLREF_RAID_NORMAL        = "Normal",
    ILVLREF_RAID_HEROIC        = "Héroïque",
    ILVLREF_RAID_MYTHIC        = "Mythique",

    ILVLREF_DELVE_TIER_FMT     = "T%d",

    ILVLREF_TOGGLE_EXPAND = "Afficher tout",
    ILVLREF_TOGGLE_SHRINK = "Réduire",

    -- Slash commands
    SLASH_USAGE_TOGGLE = "Utilisation : /larias ou /lcl pour afficher/masquer la liste",
    SLASH_USAGE_LOCALE = "Utilisation : /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Langue définie sur %s (effective : %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
