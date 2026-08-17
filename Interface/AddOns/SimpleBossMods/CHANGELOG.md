# Simple Boss Mods

## [v3.15](https://github.com/ZapaNOR/SimpleBossMods/tree/v3.15) (2026-08-13)
[Full Changelog](https://github.com/ZapaNOR/SimpleBossMods/compare/v3.14...v3.15) 

- Bump to v3.15: guard private aura visuals against forbidden objects  
    Aura visual subframes inherit the forbidden state of their parent button  
    once Blizzard assigns it secret aura data, so restyling them from tainted  
    code threw "forbidden object" errors. Gate styleAuraVisual behind an  
    IsForbidden check and pcall the restyle loop so an escaping error can no  
    longer abort aura group configuration and leave every filter disabled.  
    DebugAuraFilters now reports styleable/forbidden visual counts.  
    Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>  
