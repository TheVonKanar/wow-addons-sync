local L = LibStub("AceLocale-3.0"):NewLocale("MythicPlusUtility", "ruRU")
if not L then return end

-- Options
L["Toggle Window"] = "Переключение окна"
L["Window Position and Size Settings"] = "Размер и положение окна"
L["Width"] = "Ширина"
L["Height"] = "Высота"
L["Lock Window"] = "Отключить перемещение окна"
L["Anchor to Screen's"] = "Закрепить за экран"
L["X Offset"] = "Смещение по X"
L["Y Offset"] = "Смещение по Y"
L["Text and Icon Size Settings"] = "Размер текста и иконки"
L["Dungeon Name Size"] = "Размер названия подземелья"
L["Icon Size"] = "Размер иконки"
L["Icon Label Size"] = "Размер названия иконки"
L["Body Text Size"] = "Размер текста"
L["Background Opacity"] = "Прозрачность фона"
L["Hide on Mythic+ start"] = "Скрыть при начале Эпохальный+"
L["Hide not Important"] = "Скрыть неважные"
L["Hides dungeon entries that are marked with %s"] =
  "Скрывает записи в подземельях, помеченные %s"
L["Dungeon Preview"] = "Просмотр подземелья"
L["Show in"] = "Показывать в"

-- Difficulty
L["Normal"] = "Обычный"
L["Heroic"] = "Героический"
L["Mythic"] = "Эпохальный"

L["Show/Hide Utility Window"] = "Показать/Скрыть окно"
L["Open Settings"] = "Открыть настройки"
L["Disable Minimap Button"] = "Отключить кнопку миникарты"

-- Dungeons
L["Algeth\'ar Academy"] = "Академия Алгет\'ар"
L["Magisters\' Terrace"] = "Терраса Магистров"
L["Maisara Caverns"] = "Пещеры Маисара"
L["Nexus-Point Xenas"] = "Узел Нексуса Зенас"
L["Pit of Saron"] = "Яма Сарона"
L["Seat of the Triumvirate"] = "Престол Триумвирата"
L["Skyreach"] = "Небесный Путь"
L["Windrunner Spire"] = "Шпили Ветрокрылых"

-- Dungeon entries
L["{spell:%d} buff is cast by {npc:%d} (trash before {npc:%d}). Also, this cast can be interrupted."] =
  "{spell:%d} бафф, который накладывает {npc:%d} (треш перед {npc:%d}). Также, это заклинание можно прервать."
L["{spell:%d} buff is cast by {npc:%d}."] = "{spell:%d} бафф, который накладывает {npc:%d}."
L["{spell:%d} buff on {npc:%d} (trash before {npc:%d})."] =
  "{spell:%d} бафф на {npc:%d} (треш перед {npc:%d})."
L["{spell:%d} buff on {npc:%d}."] = "{spell:%d} бафф на {npc:%d}."
L["{spell:%d} buff on the second boss {npc:%d}."] = "{spell:%d} бафф на втором боссе {npc:%d}."
L["{spell:%d} debuff is inflicted by {npc:%d} (trash before {npc:%d}). Also, this cast can be interrupted."] =
  "{spell:%d} дебафф, который накладывает {npc:%d} (треш перед {npc:%d}). Также, это заклинание можно прервать."
L["{spell:%d} debuff is inflicted by {npc:%d} (trash before {npc:%d})."] =
  "{spell:%d} дебафф, который накладывает {npc:%d} (треш перед {npc:%d})."
L["{spell:%d} debuff is inflicted by {npc:%d} on the first boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает {npc:%d} на первом боссе {npc:%d}."
L["{spell:%d} debuff is inflicted by {npc:%d}. Also, this cast can be interrupted."] =
  "{spell:%d} дебафф, который накладывает {npc:%d}. Также, это заклинание можно прервать."
L["{spell:%d} debuff is inflicted by {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает {npc:%d}."
L["{spell:%d} debuff is inflicted by contact with {npc:%d} on the last boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает контакт с {npc:%d} на последнем боссе {npc:%d}."
L["{spell:%d} debuff is inflicted by contact with orbs on the last boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает контакт со сферами на последнем боссе {npc:%d}."
L["{spell:%d} debuff is inflicted by the first boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает первый босс {npc:%d}."
L["{spell:%d} debuff is inflicted by the second boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает второй босс {npc:%d}."
L["{spell:%d} debuff is inflicted on the first boss {npc:%d}. Also, this debuff can be avoided."] =
  "{spell:%d} дебафф, который накладывает первый босс {npc:%d}. Также, этот дебафф можно избежать."
L["{spell:%d} debuff is inflicted on the first boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает первый босс {npc:%d}."
L["{spell:%d} debuff is inflicted on the last boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает последний босс {npc:%d}."
L["{spell:%d} debuff is inflicted on the second boss {npc:%d}."] =
  "{spell:%d} дебафф, который накладывает второй босс {npc:%d}."
L["{spell:%d} is cast by {npc:%d} (trash before {npc:%d}). Also, this cast can be interrupted."] =
  "{spell:%d}, которое произносит {npc:%d} (треш перед {npc:%d}). Также, это заклинание можно прервать."
L["{spell:%d} is cast by {npc:%d}."] = "{spell:%d}, которое произносит {npc:%d}."
L["{spell:%d} is channeled by {npc:%d} on the third boss {npc:%d}."] =
  "{spell:%d}, которое направляет {npc:%d} на третьем боссе {npc:%d}."
L["{spell:%d} is channeled by {npc:%d}. The caster is immune to CC while it has {spell:%d}"] =
  "{spell:%d}, которое направляет {npc:%d}. Заклинатель невосприимчив к эффектам контроля пока на нём есть {spell:%d}"
L["{spell:%d} is channeled by {npc:%d}."] = "{spell:%d}, которое направляет {npc:%d}."
L["Mitigates effects of {spell:%d} on the last boss {npc:%d}."] =
  "Нивелирует эффекты {spell:%d} на последнем боссе {npc:%d}."
L["Prevent {npc:%d} from reaching {npc:%d}."] = "Мешает {npc:%d} достичь {npc:%d}."
L["Prevent {npc:%d} from reaching players or other {npc:%d} on the second boss {npc:%d}."] =
  "Мешает {npc:%d} достичь игроков или других {npc:%d} на последнем боссе {npc:%d}."
L["Prevent {npc:%d} from reaching the first boss {npc:%d}."] =
  "Мешает {npc:%d} достичь первого босса {npc:%d}."
L["Slow {npc:%d} on the third boss {npc:%d}."] = "Замедляет {npc:%d} на третьем боссе {npc:%d}."
L["Stun {npc:%d} on the last boss {npc:%d}."] = "Оглушает {npc:%d} на последнем боссе {npc:%d}."
L["{spell:%d} debuff is inflicted by {npc:%d} (trash before {npc:%d}). Also, this cast can be LoS."] =
  "{spell:%d} дебафф, который накладывает {npc:%d} (треш перед {npc:%d}). Также, от этого заклинание можно укрытся."
L["{spell:%d} debuff is inflicted by {npc:%d} (trash before {npc:%d}). Also, this cast can be interrupted and LoS."] =
  "{spell:%d} дебафф, который накладывает {npc:%d} (треш перед {npc:%d}). Также, это заклинание можно прервать и укрытся от него."
L["{spell:%d} debuff is inflicted by {npc:%d}. Also, this debuff can be avoided."] =
  "{spell:%d} дебафф, который накладывает {npc:%d}. Также, этот дебафф можно избежать."
L["{spell:%d} debuff is inflicted by the third boss {npc:%d}. Also, this debuff can be avoided."] =
  "{spell:%d} дебафф, который накладывает второй босс {npc:%d}. Также, этот дебафф можно избежать."
