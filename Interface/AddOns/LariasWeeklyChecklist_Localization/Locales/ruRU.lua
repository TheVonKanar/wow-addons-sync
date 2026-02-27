--[[
Russian (ruRU) strings for Larias's Weekly Checklist
]]
if GetLocale() ~= "ruRU" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

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
    OPTIONS_HIDE_GREAT_VAULT = "Скрыть Великий сейф",
    OPTIONS_HIDE_CURRENCY = "Скрыть валюту",

    HIDE_COMPLETED_WEEKS = "Скрыть завершённые недели",
    OPTIONS_HIDE_CHANGE_WEEK_BTN = "Скрыть кнопку «Сменить неделю»",
    OPTIONS_HIDE_ILVL_REF_BTN = "Скрыть кнопку «Уровни предметов»",
    OPTIONS_HIDE_CHAR_SELECT = "Скрыть выбор персонажа",
    OPTIONS_HIDDEN_CHARS_TITLE = "Скрытые персонажи:",
    OPTIONS_HIDDEN_CHARS_NONE = "Нет",
    RESET_BUTTON = "Сбросить",
    UI_SCALE_LABEL = "Масштаб UI",
    UI_SCALE_MIN_LABEL = "50%",
    UI_SCALE_MAX_LABEL = "150%",
    OPTIONS_HIDE_SCALE_SLIDER = "Скрыть ползунок масштаба",

    -- List tab
    DONE_PREFIX = "[Готово] ",

    -- Tracking panel
    TRACKING_GREAT_VAULT_TITLE = "Великий сейф",
    TRACKING_CURRENCY_TITLE = "Валюта",
    TRACKING_GV_RAID = "Рейд",
    TRACKING_GV_DUNGEONS = "Подземелья",
    TRACKING_GV_WORLD    = "Мир",
    TRACKING_NA = "Н/Д",

    TRACKING_SPARKS_LABEL = "Искры:",
    TRACKING_DONE = "Готово",
    TRACKING_NOT_DONE = "Не готово",

    TRACKING_QUEST_DELVERS_BOUNTY = "Награда исследователя:",
    TRACKING_QUEST_WEEKLY_PREY = "Еженедельная добыча:",

    TRACKING_CREST_LABEL = "Гербы:",
    TRACKING_CREST_ID_LABEL_FMT = "Герб %s:",
    -- Optional: if present, crest labels are taken from this table instead of the game currency name.
    -- Keys are currency IDs; values should be display names (with or without a trailing ':').
    TRACKING_CREST_NAMES_BY_ID = {
        [3383] = "Искатель приключений",
        [3341] = "Ветеран",
        [3343] = "Защитник",
        [3345] = "Герой",
        [3347] = "Эпохи",
    },
    TRACKING_NO_ID = "Нет ID",
    TRACKING_TRADE_UP_SUFFIX = " Улучшить)",

    TRACKING_CATALYST_LABEL = "Катализатор:",

    TRACKING_INF = "беск.",

    -- Minimap tooltip
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Левая кнопка: Показать/скрыть список",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Правая кнопка: Настройки",
    MINIMAP_TOOLTIP_MIDDLE_CLICK_ILVL = "Средняя кнопка: Уровни предметов",

    -- Main window
    TAB_OPTIONS = "Настройки",
    CHANGE_WEEK_BUTTON = "Сменить неделю",
    ILVLREF_BUTTON = "Уровни предметов",

    -- Item level reference popup
    ILVLREF_WINDOW_TITLE  = "Midnight, сезон 1 — справочник уровней предметов",

    ILVLREF_SEC_TRACKS    = "Уровни улучшения  (20 гербов за уровень)",
    ILVLREF_SEC_CRAFTED   = "Уровни крафтовых предметов",
    ILVLREF_SEC_DUNGEONS  = "Уровни предметов в подземельях",
    ILVLREF_SEC_RAID      = "Прибл. уровни предметов рейда Midnight",
    ILVLREF_SEC_DELVES    = "Уровни предметов из многообещающих вылазок",

    ILVLREF_COL_ILVL         = "ур. пред.",
    ILVLREF_COL_TRACK        = "Уровень улучшения",
    ILVLREF_COL_CREST_NEEDED = "Гербы",
    ILVLREF_COL_QUALITY      = "Качество",
    ILVLREF_COL_SOURCE       = "Источник",
    ILVLREF_COL_END_LOOT     = "Максимальный уровень",
    ILVLREF_COL_GREAT_VAULT  = "Великий сейф",
    ILVLREF_COL_DIFFICULTY   = "Сложность",
    ILVLREF_COL_BOSS1        = "Начало",
    ILVLREF_COL_BOSS2        = "Середина",
    ILVLREF_COL_BOSS3        = "Конец",
    ILVLREF_COL_BOSS4        = "Финал",
    ILVLREF_COL_TIER         = "Уровень",
    ILVLREF_COL_MAP_DROP     = "Добыча с картой",

    ILVLREF_CREST_ADV          = "Иск. прикл.",
    ILVLREF_CREST_VET          = "Ветеран",
    ILVLREF_CREST_CHAMP        = "Защитник",
    ILVLREF_CREST_HERO         = "Герой",
    ILVLREF_CREST_MYTH         = "Легенда",
    ILVLREF_DO_NOT_USE_CRESTS_FMT = "НЕ ИСПОЛЬЗОВАТЬ ГЕРБЫ %s",

    ILVLREF_DUNGEON_PRE_HEROIC = "До открытия Гер. рейда",
    ILVLREF_DUNGEON_HEROIC     = "Героический",
    ILVLREF_DUNGEON_PRE_MYTHIC = "До открытия Эпох. рейда",
    ILVLREF_DUNGEON_MYTHIC     = "Эпохальный",

    ILVLREF_RAID_LFR           = "Поиск рейда",
    ILVLREF_RAID_NORMAL        = "Обычный",
    ILVLREF_RAID_HEROIC        = "Героический",
    ILVLREF_RAID_MYTHIC        = "Эпохальный",

    ILVLREF_DELVE_TIER_FMT     = "У%d",
    ILVLREF_TOGGLE_EXPAND = "Показать все таблицы",
    ILVLREF_TOGGLE_SHRINK = "Свернуть",
    -- Slash commands
    SLASH_USAGE_TOGGLE = "Использование: /larias или /lcl для показа/скрытия списка",
    SLASH_USAGE_LOCALE = "Использование: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Язык установлен на %s (активный: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
