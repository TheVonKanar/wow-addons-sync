# Simple Boss Mods

## [v3.9.1](https://github.com/ZapaNOR/SimpleBossMods/tree/v3.9.1) (2026-03-15)
[Full Changelog](https://github.com/ZapaNOR/SimpleBossMods/compare/v3.9...v3.9.1) 

- Fix default bar color not being used when indicator colors don't match  
    Native Blizzard API colors (red/yellow) were overriding the user's  
    configured default bar color. Now the fallback chain correctly goes:  
    indicator color → default bar color, skipping native API colors.  
    Bump version to 3.9.1  
