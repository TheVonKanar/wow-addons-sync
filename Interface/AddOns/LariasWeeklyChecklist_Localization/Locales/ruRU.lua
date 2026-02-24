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

    UPDATE_AVAILABLE_TITLE = "Доступна новая версия",
    UPDATE_AVAILABLE_TEXT = "Доступна новая версия",
    UPDATE_AVAILABLE_FMT = "%s имеет доступное обновление.\n\nПожалуйста, обновите аддон до последней версии.",

    BUTTON_OK = "ОК",
    BUTTON_CANCEL = "Отмена",

    OPTIONS_SHOW_GREAT_VAULT = "Показать Великое хранилище",
    OPTIONS_SHOW_CURRENCY = "Показать валюту",

    HIDE_COMPLETED_WEEKS = "Скрыть завершённые недели",
    OPTIONS_BUTTON = "Настройки",
    RESET_BUTTON = "Сбросить",
    DONE_PREFIX = "[Готово] ",

    TRACKING_GREAT_VAULT_TITLE = "Великое хранилище",
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

    TRACKING_CURRENCY_FALLBACK_PREFIX = "Валюта ",
    -- NOTE: Lua's string.lower() does NOT lowercase Cyrillic, so this must match the exact
    -- casing used by WoW's Russian client in crest currency names. Verify in-game if needed.
    TRACKING_CREST_MATCH_SUBSTRING = "Гребень",
    TRACKING_INF = "INF",

    MINIMAP_TOOLTIP_TEXT = "Левая кнопка: показать/скрыть список",
    MINIMAP_TOOLTIP_LEFT_CLICK_TOGGLE = "Левая кнопка: Показать/скрыть список",
    MINIMAP_TOOLTIP_RIGHT_CLICK_OPTIONS = "Правая кнопка: Настройки",

    TAB_LIST = "Список",
    TAB_OPTIONS = "Настройки",

    SLASH_USAGE_TOGGLE = "Использование: /larias или /lcl для показа/скрытия списка",
    SLASH_USAGE_LOCALE = "Использование: /larias locale auto|enUS|deDE|esES|esMX|frFR|itIT|ptBR|ruRU",
    SLASH_LOCALE_SET_FMT = "Язык установлен на %s (активный: %s)",
}

for key, value in pairs(STRINGS) do
    L[key] = value
end
