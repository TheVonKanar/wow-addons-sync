--[[
Portuguese-Brazil (ptBR) strings for Larias's Weekly Checklist
]]

local LOCALE = "ptBR"
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

    UPDATE_AVAILABLE_TITLE = "Nova versão disponível",
    UPDATE_AVAILABLE_TEXT = "Nova versão disponível",
    UPDATE_AVAILABLE_FMT = "%s tem uma atualização disponível.\n\nPor favor, atualize o addon para a versão mais recente.",

    BUTTON_OK = "OK",
    BUTTON_CANCEL = "Cancelar",

    OPTIONS_SHOW_GREAT_VAULT = "Mostrar Grande Cofre",
    OPTIONS_SHOW_CURRENCY = "Mostrar moeda",

    HIDE_COMPLETED_WEEKS = "Ocultar semanas concluídas",
    OPTIONS_BUTTON = "Opções",
    RESET_BUTTON = "Redefinir",
    DONE_PREFIX = "[Feito] ",

    TRACKING_GREAT_VAULT_TITLE = "Grande Cofre",
    TRACKING_CURRENCY_TITLE = "Moeda",
    TRACKING_GV_RAID = "Raid",
    TRACKING_GV_DUNGEONS = "Masmorras",
    TRACKING_NA = "N/D",

    TRACKING_SPARKS_LABEL = "Fagulhas:",
    TRACKING_DONE = "Feito",
    TRACKING_NOT_DONE = "Não feito",

    TRACKING_QUEST_DELVERS_BOUNTY = "Recompensa do explorador:",
    TRACKING_QUEST_WEEKLY_PREY = "Presa semanal:",

    TRACKING_CREST_LABEL = "Crista:",
    TRACKING_CREST_ID_LABEL_FMT = "Crista %s:",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Aventureiro",
        [3341] = "Veterano",
        [3343] = "Campeão",
        [3345] = "Herói",
        [3347] = "Dourado",
    },
    TRACKING_NO_ID = "Sem ID",
    TRACKING_TRADE_UP_SUFFIX = " Melhorar)",

    TRACKING_CATALYST_LABEL = "Catalisador:",

    TRACKING_CURRENCY_FALLBACK_PREFIX = "Moeda ",
    -- NOTE: should match the lowercase substring found in Portuguese WoW crest currency names ("crista").
    TRACKING_CREST_MATCH_SUBSTRING = "crista",
    TRACKING_INF = "INF",

    MINIMAP_TOOLTIP_TEXT = "Clique esquerdo: mostrar/ocultar a lista",
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clique esquerdo: Mostrar/ocultar a lista",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clique direito: Opções",

    TAB_LIST = "Lista",
    TAB_OPTIONS = "Opções",

    SLASH_USAGE_TOGGLE = "Uso: /larias ou /lcl para mostrar/ocultar a lista",
    SLASH_USAGE_LOCALE = "Uso: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Idioma definido para %s (efetivo: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
