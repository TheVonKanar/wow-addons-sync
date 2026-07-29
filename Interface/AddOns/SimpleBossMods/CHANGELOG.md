# Simple Boss Mods

## [v3.13](https://github.com/ZapaNOR/SimpleBossMods/tree/v3.13) (2026-06-17)
[Full Changelog](https://github.com/ZapaNOR/SimpleBossMods/compare/v3.12.1...v3.13) 

- Bump to v3.13: fix red bars during real encounters, default to Outline (Slug)  
    Fix the in-combat bar color regression introduced by 12.0.7:  
    - getTimelineBarColor's old fallback queried C\_EncounterEvents.GetEventColor  
      with eventInfo.encounterEventID. That only returns user overrides (Nilable),  
      not Blizzard's per-event defaults that used to live on eventInfo.color  
      (field removed from EncounterEventInfo in 12.0.7). Now queries  
      C\_EncounterTimeline.GetEventColor(timelineEventID), which returns the  
      effective rendered color (default + override) and is the API replacement  
      for the old eventInfo.color access. The returned color is secret-wrapped  
      during real encounters, but :GetRGBA() values pass straight through  
      SetStatusBarColor / SetVertexColor — same pattern Blizzard's own  
      EncounterTimelineTimerEvent:UpdateTimerColor uses.  
    - getIndicatorBarColor now falls back to the cached \_indicatorMask when  
      eventInfo.icons is secret-wrapped (not just nil), so indicator colors  
      resolve mid-encounter instead of dropping straight to BAR\_FG.  
    - processEvent no longer forces BAR\_FG for un-indicated events; Blizzard's  
      per-event defaults now show through the timeline fallback.  
    Also add "Outline (Slug)" font outline option (matches Cast on Me) and set  
    it as the default for both bar and icon fonts.  
