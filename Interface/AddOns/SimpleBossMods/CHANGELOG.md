# Simple Boss Mods

## [v3.11](https://github.com/ZapaNOR/SimpleBossMods/tree/v3.11) (2026-04-25)
[Full Changelog](https://github.com/ZapaNOR/SimpleBossMods/compare/v3.10.3...v3.11) 

- Bump to v3.11: bundle LibKeystone/LibDeflate, clean up dead Private Aura code, add HideBorder toggle  
    - Bundle LibKeystone, LibDeflate, AceLocale-3.0 in Libraries/ (drop libkeystone external dep)  
    - Remove dead Private Aura overlay/styling pipeline in SBM\_UI.lua (custom border + region scrubbing never worked - Blizzard's native border draws above any addon frame)  
    - Add HideBorder toggle for Private Aura tracker (uses borderScale = -100 trick from NSRT to suppress the native debuff border)  
    - Collapse C\_Spell.GetSpellInfo/GetSpellName fallbacks to GetSpellInfo (unreachable on retail since 10.2.5)  
