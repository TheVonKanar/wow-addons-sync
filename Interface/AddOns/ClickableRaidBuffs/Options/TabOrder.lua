-- ====================================
-- \Options\TabOrder.lua
-- ====================================

local addonName, ns = ...
ns.Options = ns.Options or {}
local O = ns.Options
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

O.TAB_ORDER = {
  COMMUNITIES_GUILD_INFO_TAB_TOOLTIP,
  ns.LayoutTabName,
  L["Thresholds"],
  IGNORE,
  OPTIONS,
  (L["Custom Buffs"] or L["Custom Spells"]),
}
