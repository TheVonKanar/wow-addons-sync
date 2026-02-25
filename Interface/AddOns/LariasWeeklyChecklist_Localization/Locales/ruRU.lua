--[[
Russian (ruRU) strings for Larias's Weekly Checklist
]]

local LOCALE = "ruRU"
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
    UPDATE_AVAILABLE_TEXT = "Доступна новая версия",
    UPDATE_AVAILABLE_FMT = "%s имеет доступное обновление.\n\nПожалуйста, обновите аддон до последней версии.",

    -- Shared buttons
    BUTTON_OK = "ОК",
    BUTTON_CANCEL = "Отмена",

    -- Options tab
    OPTIONS_HIDE_GREAT_VAULT = "Скрыть Великий тайник",
    OPTIONS_HIDE_CURRENCY = "Скрыть валюту",

    HIDE_COMPLETED_WEEKS = "Скрыть завершённые недели",
    OPTIONS_HIDE_CHANGE_WEEK_BTN = "Скрыть кнопку «Сменить неделю»",
    OPTIONS_HIDE_ILVL_REF_BTN = "Скрыть кнопку «Реф. ilvl»",

    RESET_BUTTON = "Сбросить",

    -- List tab
    DONE_PREFIX = "[Готово] ",

    -- Tracking panel
    TRACKING_GREAT_VAULT_TITLE = "Великий тайник",
    TRACKING_CURRENCY_TITLE = "Валюта",
    TRACKING_GV_RAID = "Рейд",
    TRACKING_GV_DUNGEONS = "Подземелья",
    TRACKING_NA = "Н/Д",

    TRACKING_SPARKS_LABEL = "Искры:",
    TRACKING_DONE = "Готово",
    TRACKING_NOT_DONE = "Не готово",

    TRACKING_QUEST_DELVERS_BOUNTY = "Награда исследователя:",
    TRACKING_QUEST_WEEKLY_PREY = "Еженедельная добыча:",

    TRACKING_CREST_LABEL = "Гребень:",
    TRACKING_CREST_ID_LABEL_FMT = "Гребень %s:",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Путешественник",
        [3341] = "Ветеран",
        [3343] = "Чемпион",
        [3345] = "Герой",
        [3347] = "Позолоченный",
    },
    TRACKING_NO_ID = "Нет ID",
    TRACKING_TRADE_UP_SUFFIX = " Улучшить)",

    TRACKING_CATALYST_LABEL = "Катализатор:",

    TRACKING_INF = "INF",

    -- Minimap tooltip
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Левая кнопка: Показать/скрыть список",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Правая кнопка: Настройки",

    -- Main window
    TAB_LIST = "Список",
    TAB_OPTIONS = "Настройки",
    CHANGE_WEEK_BUTTON = "Сменить неделю",
    ILVLREF_BUTTON = "Реф. ilvl",

    -- Item level reference popup
    ILVLREF_WINDOW_TITLE  = "Midnight, сезон 1 — справочник уровней предметов",

    ILVLREF_SEC_TRACKS    = "Пути улучшения  (20 гребней за шаг)",
    ILVLREF_SEC_CRAFTED   = "Уровни созданных предметов",
    ILVLREF_SEC_DUNGEONS  = "Уровни предметов в подземельях",
    ILVLREF_SEC_RAID      = "Прибл. уровни предметов рейда Midnight",
    ILVLREF_SEC_DELVES    = "Уровни предметов из щедрых вылазок",

    ILVLREF_COL_ILVL         = "ур. пред.",
    ILVLREF_COL_TRACK        = "Пути улучшения",
    ILVLREF_COL_CREST_NEEDED = "Гребни",
    ILVLREF_COL_QUALITY      = "Качество",
    ILVLREF_COL_SOURCE       = "Источник",
    ILVLREF_COL_END_LOOT     = "Конечные предметы",
    ILVLREF_COL_GREAT_VAULT  = "Великий тайник",
    ILVLREF_COL_DIFFICULTY   = "Сложность",
    ILVLREF_COL_BOSS1        = "Начало",
    ILVLREF_COL_BOSS2        = "Середина",
    ILVLREF_COL_BOSS3        = "Конец",
    ILVLREF_COL_BOSS4        = "Финал",
    ILVLREF_COL_TIER         = "Уровень",
    ILVLREF_COL_MAP_DROP     = "Карта-дроп",

    ILVLREF_CREST_ADV          = "Путеш",
    ILVLREF_CREST_VET          = "Вет",
    ILVLREF_CREST_CHAMP        = "Чемп",
    ILVLREF_CREST_HERO         = "Герой",
    ILVLREF_CREST_MYTH         = "Позол",
    ILVLREF_DO_NOT_USE_CRESTS_FMT = "НЕ ИСПОЛЬЗОВАТЬ ГРЕБНИ %s",

    ILVLREF_DUNGEON_PRE_HEROIC = "Досезонный Героич.",
    ILVLREF_DUNGEON_HEROIC     = "Героический",
    ILVLREF_DUNGEON_PRE_MYTHIC = "Досезонный Эпич.",
    ILVLREF_DUNGEON_MYTHIC     = "Эпический",

    ILVLREF_RAID_LFR           = "LFR",
    ILVLREF_RAID_NORMAL        = "Обычный",
    ILVLREF_RAID_HEROIC        = "Героический",
    ILVLREF_RAID_MYTHIC        = "Эпический",

    ILVLREF_DELVE_TIER_FMT     = "У%d",

    -- Slash commands
    SLASH_USAGE_TOGGLE = "Использование: /larias или /lcl для показа/скрытия списка",
    SLASH_USAGE_LOCALE = "Использование: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Язык установлен на %s (активный: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
