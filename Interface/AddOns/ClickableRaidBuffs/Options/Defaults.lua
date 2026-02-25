-- ====================================
-- \Options\Defaults.lua
-- ====================================

local addonName, ns = ...
ns.Options = ns.Options or {}
local O = ns.Options

ns.LayoutTabName = (HUD_EDIT_MODE_LAYOUT or "Layout:"):gsub("%s*:%s*$", "")

local locale = GetLocale()

local LOCALE_FONTS = {

  -- Latin and Cyrillic
  default = {
    panel  = "FiraSans-Regular",
    title  = "FiraSans-ExtraBoldItalic",
    author = "FiraSans-Medium",
    italic = "FiraSans-Italic",
    layout = "Oswald-Regular",
  },

  -- Korean
  koKR = {
    panel  = "NotoSansKR-Regular",
    title  = "FiraSans-ExtraBoldItalic",
    author = "FiraSans-Medium",
    italic = "NotoSansKR-Regular",
    layout = "NotoSansKR-Regular",
  },

  -- Simplified Chinese
  zhCN = {
    panel  = "NotoSansSC-Regular",
    title  = "FiraSans-ExtraBoldItalic",
    author = "FiraSans-Medium",
    italic = "NotoSansSC-Regular",
    layout = "NotoSansSC-Regular",
  },

  -- Traditional Chinese
  zhTW = {
    panel  = "NotoSansTC-Regular",
    title  = "FiraSans-ExtraBoldItalic",
    author = "FiraSans-Medium",
    italic = "NotoSansTC-Regular",
    layout = "NotoSansTC-Regular",
  },

  -- Japanese
  jaJP = {
    panel  = "NotoSansJP-Regular",
    title  = "FiraSans-ExtraBoldItalic",
    author = "FiraSans-Medium",
    italic = "NotoSansJP-Regular",
    layout = "NotoSansJP-Regular",
  },
}


local function GetLocaleFontSet()
  return LOCALE_FONTS[locale] or LOCALE_FONTS.default
end

local fonts = GetLocaleFontSet()

local D = {

  PANEL_FONT_NAME = fonts.panel,
  TITLE_FONT_NAME = fonts.title,
  AUTHOR_LABEL_FONT_NAME = fonts.author,
  LABEL_ITALIC_FONT_NAME = fonts.italic,
  fontName = fonts.layout, 

  SIZE_TITLE = 50,
  SIZE_SECTION_HEAD = 20,
  SIZE_LABEL = 14,
  SIZE_COPY_LABEL = 10,
  SIZE_EDITBOX = 14,
  SIZE_TAB_LABEL = 15,

  RESET_W = 60,
  RESET_H = 30,

  AUTHOR_LABEL_SIZE = 17,
  AUTHOR_LABEL_X = 335,
  AUTHOR_LABEL_Y = -55,

  TAB_HEIGHT = 24,
  TAB_COUNT = 6,

  topSize = 14,
  bottomSize = 14,
  timerSize = 22,
  topOutline = true,
  bottomOutline = true,
  timerOutline = true,
  topTextColor = { r = 1, g = 1, b = 1, a = 1 },
  bottomTextColor = { r = 1, g = 1, b = 1, a = 1 },
  timerTextColor = { r = 1, g = 1, b = 1, a = 1 },

  glowEnabled = true,
  specialGlowColor = { r = 0.35, g = 0.80, b = 1.00, a = 1 },
  glowColor = { r = 1.00, g = 0.90, b = 0.20, a = 1 },

  iconSize = 50,
  hSpace = 10,
  vSpace = 45,

  optionsWindow = {
    width = 940,
    height = 720,
    point = "CENTER",
    x = 0,
    y = 0,
  },

  expansions = {
    [10] = true,
    [11] = true,
  },

  bagRefreshSeconds = 5,
  raidRefreshSeconds = 5,
  userRefreshSeconds = 1,
  scanIntervalSeconds = 5,
}

O.DEFAULTS = D

function O.GetDefault(key)
  local v = D[key]
  if type(v) == "table" then
    local copy = {}
    for k, vv in pairs(v) do
      copy[k] = vv
    end
    return copy
  end
  return v
end
