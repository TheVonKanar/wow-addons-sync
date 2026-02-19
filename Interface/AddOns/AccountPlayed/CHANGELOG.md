# Account Played

## [v1.1.4](https://github.com/Jeremy-Gstein/AccountPlayed/tree/v1.1.4) (2026-02-17)
[Full Changelog](https://github.com/Jeremy-Gstein/AccountPlayed/compare/v1.0.3...v1.1.4) [Previous Releases](https://github.com/Jeremy-Gstein/AccountPlayed/releases)

- Release: v1.1.4 - Minor: Localization support for enUS, zhCN, zhTW (Huge thanks to SGSwdzgr!!). Improved performance while idle (rework minimap logic)  
- Patch: FIXED - bug with minimap preventing player from clicking (pinging) minimap.  
- remove changelog from repo  
- Minor: Localization support for enUS, zhCN, zhTW. Rework logic in MinimapButton to fix cpu usage while idle.  
- Patch: add SGSwdzgr to readme for extensive contributions localizing the addon to other languages  
- feat: Add localization support (zhCN/zhTW) & UI adjustments  
    - Added `Localization.lua` to handle multi-language support.  
    - Refactored `AccountPlayed.lua` and `MinimapButton.lua` to use a shared `L` table.  
    - Implemented `LOCALIZED_CLASS_NAMES_MALE` for automatic class name translation.  
    - Adjusted UI layout (widened rows/window) to accommodate longer text in non-English locales.  
    - Updated Minimap button tooltips and messages to support localization.  
- Update: a few Minimap Button Quality-of-Life adjustments. right click to lock button and hide button when mouse is not near minimap. `/apresetmap` - reset minimap location to default (bottom left of minimap).  
- Support Windows PATHs in justfile  
- Bug: fix memory leak, use timer instead of on frame events when checking snap state  
- New: Slash Command `/apresetmap` - Reset minimap icon (button) to default location (bottom left of minimap)  
- New: Minimap Button will only show when mouse is near or on minimap (always show when not snapped to map)  
