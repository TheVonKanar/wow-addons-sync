--[[
Portuguese-Brazil (ptBR) strings for Larias's Weekly Checklist
]]
if GetLocale() ~= "ptBR" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

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

    -- Update popup
    UPDATE_AVAILABLE_TEXT = "Nova versão disponível",
    UPDATE_AVAILABLE_FMT = "%s tem uma atualização disponível.\n\nPor favor, atualize o addon para a versão mais recente.",

    -- Shared buttons
    BUTTON_OK = "OK",
    BUTTON_CANCEL = "Cancelar",

    -- Options tab
    OPTIONS_HIDE_GREAT_VAULT = "Ocultar Grande Cofre",
    OPTIONS_HIDE_CURRENCY = "Ocultar moeda",

    HIDE_COMPLETED_WEEKS = "Ocultar semanas concluídas",
    OPTIONS_HIDE_CHANGE_WEEK_BTN = "Ocultar botão Mudar semana",
    OPTIONS_HIDE_ILVL_REF_BTN = "Ocultar botão Níveis de item",
    OPTIONS_HIDE_CHAR_SELECT = "Ocultar seleção de personagem",
    OPTIONS_HIDDEN_CHARS_TITLE = "Personagens ocultos:",
    OPTIONS_HIDDEN_CHARS_NONE = "Nenhum",
    RESET_BUTTON = "Redefinir",
    UI_SCALE_LABEL = "Escala de UI",
    UI_SCALE_MIN_LABEL = "50%",
    UI_SCALE_MAX_LABEL = "150%",
    OPTIONS_HIDE_SCALE_SLIDER = "Ocultar controle de escala",

    -- List tab
    DONE_PREFIX = "[Feito] ",

    -- Tracking panel
    TRACKING_GREAT_VAULT_TITLE = "Grande Cofre",
    TRACKING_CURRENCY_TITLE = "Moeda",
    TRACKING_GV_RAID = "Raid",
    TRACKING_GV_DUNGEONS = "Masmorras",    TRACKING_GV_WORLD    = "Mundo",    TRACKING_NA = "N/D",

    TRACKING_SPARKS_LABEL = "Fagulhas:",
    TRACKING_DONE = "Feito",
    TRACKING_NOT_DONE = "Não feito",

    TRACKING_QUEST_DELVERS_BOUNTY = "Recompensa do explorador:",
    TRACKING_QUEST_WEEKLY_PREY = "Presa semanal:",

    TRACKING_CREST_LABEL = "Brasão:",
    TRACKING_CREST_ID_LABEL_FMT = "Brasão %s:",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Aventureiro",
        [3341] = "Veterano",
        [3343] = "Campeão",
        [3345] = "Herói",
        [3347] = "Mítico",
    },
    TRACKING_NO_ID = "Sem ID",
    TRACKING_TRADE_UP_SUFFIX = " Melhorar)",

    TRACKING_CATALYST_LABEL = "Catalisador:",

    TRACKING_INF = "INF",

    -- Minimap tooltip
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Clique esquerdo: Mostrar/ocultar a lista",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Clique direito: Opções",
    MINIMAP_TOOLTIP_MIDDLE_CLICK_ILVL = "Clique do meio: Níveis de item",

    -- Main window
    TAB_OPTIONS = "Opções",
    CHANGE_WEEK_BUTTON = "Mudar semana",
    ILVLREF_BUTTON = "Ver níveis de item",

    -- Item level reference popup
    ILVLREF_WINDOW_TITLE  = "Referência de nível de item – Midnight Temporada 1",

    ILVLREF_SEC_TRACKS    = "Trilhas de melhoria  (20 brasões por passo)",
    ILVLREF_SEC_CRAFTED   = "Níveis de item criado",
    ILVLREF_SEC_DUNGEONS  = "Níveis de item de masmorra",
    ILVLREF_SEC_RAID      = "Aprox. níveis de item de raid de Midnight",
    ILVLREF_SEC_DELVES    = "Níveis de item de profundezas abundantes",

    ILVLREF_COL_ILVL         = "n. item",
    ILVLREF_COL_TRACK        = "Trilhas de melhoria",
    ILVLREF_COL_CREST_NEEDED = "Brasões",
    ILVLREF_COL_QUALITY      = "Qualidade",
    ILVLREF_COL_SOURCE       = "Fonte",
    ILVLREF_COL_END_LOOT     = "Saque final",
    ILVLREF_COL_GREAT_VAULT  = "Grande Cofre",
    ILVLREF_COL_DIFFICULTY   = "Dificuldade",
    ILVLREF_COL_BOSS1        = "Início",
    ILVLREF_COL_BOSS2        = "Meio",
    ILVLREF_COL_BOSS3        = "Final",
    ILVLREF_COL_BOSS4        = "Fim",
    ILVLREF_COL_TIER         = "Nível",
    ILVLREF_COL_MAP_DROP     = "Drop de mapa",

    ILVLREF_CREST_ADV          = "Avent",
    ILVLREF_CREST_VET          = "Vet",
    ILVLREF_CREST_CHAMP        = "Camp",
    ILVLREF_CREST_HERO         = "Herói",
    ILVLREF_CREST_MYTH         = "Mít",
    ILVLREF_DO_NOT_USE_CRESTS_FMT = "NÃO USAR BRASÕES %s",

    ILVLREF_DUNGEON_PRE_HEROIC = "Heróico pré-temp.",
    ILVLREF_DUNGEON_HEROIC     = "Heróico",
    ILVLREF_DUNGEON_PRE_MYTHIC = "Mítico pré-temp.",
    ILVLREF_DUNGEON_MYTHIC     = "Mítico",

    ILVLREF_RAID_LFR           = "LFR",
    ILVLREF_RAID_NORMAL        = "Normal",
    ILVLREF_RAID_HEROIC        = "Heróico",
    ILVLREF_RAID_MYTHIC        = "Mítico",

    ILVLREF_DELVE_TIER_FMT     = "T%d",

    ILVLREF_TOGGLE_EXPAND = "Mostrar todas as tabelas",
    ILVLREF_TOGGLE_SHRINK = "Minimizar",

    -- Slash commands
    SLASH_USAGE_TOGGLE = "Uso: /larias ou /lcl para mostrar/ocultar a lista",
    SLASH_USAGE_LOCALE = "Uso: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Idioma definido para %s (efetivo: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
