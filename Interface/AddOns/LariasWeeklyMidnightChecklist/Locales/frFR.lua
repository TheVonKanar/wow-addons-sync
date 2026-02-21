--[[
Localization (strings)

To add a new language:
1) Copy Locales\\enUS.lua -> Locales\\<locale>.lua (example: Locales\\deDE.lua)
2) Copy Locales\\enUS_Data.lua -> Locales\\<locale>_Data.lua (example: Locales\\deDE_Data.lua)
3) In both copies, change the locale string ("enUS") to your locale ("deDE")
4) Translate strings (this file) and checklist text (the _Data file)
5) Add BOTH files to LariasWeeklyMidnightChecklist.toc AFTER the enUS entries

Common locale codes: enUS, enGB, frFR, deDE, esES, esMX, itIT, ptBR, ruRU, koKR, zhCN, zhTW
]]

local addonName = ...

local locale = (GetLocale and GetLocale()) or nil

local Addon = _G[addonName] or {}
_G[addonName] = Addon

Addon.L = Addon.L or {}
local L = Addon.L

local function SetDefault(key, value)

    if locale == "frFR" or L[key] == nil then
        L[key] = value
    end
end
SetDefault("DISPLAY_NAME", "Checklist hebdomadaire de Larias for Midnight")

-- UI: popup shown when a new addon version is installed (until acknowledged).
SetDefault("UPDATE_AVAILABLE_TITLE", "Nouvelle version disponible")
SetDefault("UPDATE_AVAILABLE_TEXT", "Nouvelle version disponible")
SetDefault("UPDATE_AVAILABLE_FMT", "%s a une mise à jour disponible.\n\nVeuillez mettre à jour l'addon vers la version la plus récente.")

SetDefault("OPTIONS_SHOW_GREAT_VAULT", "Afficher la Grande Chambre Forte")
SetDefault("OPTIONS_SHOW_CURRENCY", "Afficher la monnaie")

SetDefault("HIDE_COMPLETED_WEEKS", "Masquer les semaines complétées")
SetDefault("OPTIONS_BUTTON", "Options")
SetDefault("RESET_BUTTON", "Reset")
SetDefault("DONE_PREFIX", "[Terminé] ")

SetDefault("TRACKING_GREAT_VAULT_TITLE", "Grande Chambre Forte")
SetDefault("TRACKING_CURRENCY_TITLE", "Monnaies")
SetDefault("TRACKING_GV_RAID", "Raid")
SetDefault("TRACKING_GV_DUNGEONS", "Donjons")
SetDefault("TRACKING_NA", "N/A")

SetDefault("TRACKING_SPARKS_LABEL", "Étincelle:")
SetDefault("TRACKING_DONE", "Terminé")
SetDefault("TRACKING_NOT_DONE", "Pas terminé")

SetDefault("TRACKING_QUEST_DELVERS_BOUNTY", "Butin de l'archéologue:")
SetDefault("TRACKING_QUEST_WEEKLY_PREY", "Traque:")

SetDefault("TRACKING_CREST_LABEL", "Écu:")
SetDefault("TRACKING_CREST_ID_LABEL_FMT", "Écu %s:")
SetDefault("TRACKING_NO_ID", "No ID")
SetDefault("TRACKING_TRADE_UP_SUFFIX", " échangeables)")

SetDefault("TRACKING_CATALYST_LABEL", "Catalyseur:")

SetDefault("TRACKING_CURRENCY_FALLBACK_PREFIX", "Monnaie ")
SetDefault("TRACKING_CREST_MATCH_SUBSTRING", "écu")
SetDefault("TRACKING_INF", "INF")
