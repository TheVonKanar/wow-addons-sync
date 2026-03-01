# Larias's Weekly Checklist

## [v2.1.1](https://github.com/Devbezos/Larias-Weekly-Checklist/tree/v2.1.1) (2026-03-01)
[Full Changelog](https://github.com/Devbezos/Larias-Weekly-Checklist/compare/v0.0.1...v2.1.1) 

- Release v2.1.1  
- Post-release: bump version to 2.1.1  
- Feature/early access changes (#11)  
    🚀 Major Features  
    Theme & UI upgrades  
    Full color customization (background, text, header) with live preview.  
    Custom styled checkboxes, buttons, sliders, and dropdowns.  
    Opacity + scale sliders now update live and stay anchored correctly.  
    Gear popup redesigned with color swatches, version info, and credits.  
    Options panel added to Interface → AddOns (native WoW settings).  
    Layout improvements  
    Taller list, cleaner header/footer, better spacing.  
    Great Vault grid resizes properly and fills space.  
    Options popup intelligently expands left/right depending on anchor.  
    Dropdowns and floating panels behave more reliably.  
    Week selector improvements  
    Button label stays stable while scrolling.  
    No longer auto-advances to next week prematurely.  
    Shows current week clearly with better logic.  
    Character/profile tools  
    Character selector feature enabled.  
    “Swap Profile” UI improvements.  
    🧠 Smart Data / Versioning  
    Sheet version now tracked alongside addon version.  
    Update notices distinguish between:  
    Addon updates  
    Checklist data updates (“X versions behind”).  
    False update warnings fixed.  
    Reset List now resets theme + UI state correctly.  
    🛠️ Fixes (lots)  
    Checkbox text colour always synced with checked state.  
    Menu errors, syntax errors, missing ends fixed.  
    Dropdown clicks no longer block the rest of the UI.  
    Gear popup toggle edge cases fixed.  
    Sliders clipping and layout overlap issues fixed.  
    Theme colors now update everywhere consistently.  
    Background opacity works correctly.  
    Locale and API edge cases fixed.  
    🧹 Refactors / Cleanup  
    Huge project restructure:  
    Libs → lib, Modules → features, Controls → components, etc.  
    React-style folder organization.  
    Shared helpers for frames, buttons, and styling.  
    Removed unused Ace3 libraries and old scripts.  
    Consolidated duplicated UI code.  
    Extracted list data and modules into cleaner architecture.  
    ⚡ Performance / Reliability  
    Removed duplicate scroll hooks.  
    Cached layout values to prevent visual flicker.  
    Libraries fully vendored into repo for stability.  
    ❌ Removed  
    Old update popup system (StaticPopup dialog).  
    ALL-CAPS text emphasis feature.  
    Some unused credits and legacy compatibility code.  
- Post-release: bump version to 2.0.9  
- Release v2.0.8  
- Post-release: bump version to 2.0.8  
- Release v2.0.7  
- Post-release: bump version to 2.0.7  
- Release v2.0.6  
- Post-release: bump version to 2.0.6  
- Release v2.0.5  
- Post-release: bump version to 2.0.5  
- Feature/text and prompt fixes (#10)  
    * Grey out checked options  
    * Fix incorrect update prompts  
- Post-release: bump version to 2.0.4  
- Release v2.0.3  
- Post-release: bump version to 2.0.3  
- Merge branch 'main' of github.com:Devbezos/Larias-Weekly-Checklist  
- updates  
- Post-release: bump version to 2.0.2  
- Post-release: bump version to 2.0.1  
- Update LariasWeeklyChecklist.toc  
- Merge branch 'main' of github.com:Devbezos/Larias-Weekly-Checklist  
- Update LariasWeeklyChecklist\_Options.lua  
- Bundle all libs in repo; remove pkgmeta externals; fix LibWindow-1.1 nil MINOR  
- Post-release: bump version to 2.0.2  
- Fix events  
- Post-release: bump version to 2.0.1  
- Release v2.0.0  
- Update version number to 2.0.0  
- Update workflows  
