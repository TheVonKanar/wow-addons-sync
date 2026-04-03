# Simple Boss Mods

## [v3.10.2](https://github.com/ZapaNOR/SimpleBossMods/tree/v3.10.2) (2026-03-31)
[Full Changelog](https://github.com/ZapaNOR/SimpleBossMods/compare/v3.10...v3.10.2) 

- Fix custom indicator colors not working during real encounters  
    C\_EncounterTimeline.GetEventInfo() returns secret-wrapped icons/severity  
    during real boss encounters (SecretWhenEncounterEvent). Fall back to  
    C\_EncounterEvents data (AllowedWhenUntainted) and eventInfo.color for  
    bar coloring when indicator mask is unavailable.  
    Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>  
- Fix blank slider editboxes on initial load  
    Workaround for font loading issue causing editbox text to be blank  
    until the value changes.  
    Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>  
- Add setting to disable /key and /keys slash commands  
    Allows other addons to use /key and /keys by disabling the setting  
    in Dungeon > Mythic+. On by default, requires reload to take effect.  
    Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>  
