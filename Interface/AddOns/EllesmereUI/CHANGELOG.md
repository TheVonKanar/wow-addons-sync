# EllesmereUI

## [v9.1.3](https://github.com/EllesmereGaming/EllesmereUI/tree/v9.1.3) (2026-08-31)
[Full Changelog](https://github.com/EllesmereGaming/EllesmereUI/compare/v9.1.2...v9.1.3) [Previous Releases](https://github.com/EllesmereGaming/EllesmereUI/releases)

- Release v9.1.3  
- Merge pull request #1878 from Barbiero/locale/ptbr-since-912  
    ptBR: translate Quick Fire, LibDataBroker plugin blocks, and other v9.1 additions  
- Merge pull request #1873 from Crazyyoungs/main  
    [koKR]: Enhance Korean localization with quick fire features  
- Merge pull request #1875 from LoChinAn/locale-zhtw-quick-fire-broker-blocks  
    zhTW: translate 48 new keys for Quick Fire, Broker blocks and stack glows  
- Merge pull request #1879 from JuJuFX-dev/fix/cdm-revert-cooldown-text-clone  
    Revert(CDM): drop the countdown-number clone widget  
- Revert(CDM): drop the countdown-number clone widget  
    The 9.1.1 duration-text fix gave every cooldown icon a second, swipe-less  
    Cooldown widget to carry the countdown number above the glow overlays, with  
    forwarding hooks mirroring the real widget's state onto it. That approach does  
    not hold up.  
    In restricted content Blizzard arms the widget with secret start/duration  
    values, and forwarding those out of a tainted hook is a hard error: it produced  
    a live error storm, patched in 9.1.2 by falling back to the real widget's own  
    number for such arms. That fallback is the tell. The clone cannot be driven  
    where the values are secret, so in dungeons and raids the number renders under  
    the glow again anyway, which is the exact layering the clone existed to fix.  
    It also blanked duration text on buff bar icons once a frame was reused, which  
    PR #1871 addresses by excluding buff-viewer frames, the very family the bug was  
    reported on.  
    Beyond those, reading the shipped code turns up more of the same kind: the  
    existing-clone early return and the caller's fallback both bypass every  
    exclusion, nothing ever retires a clone or unhooks it, the Threshold Text  
    formatter stays attached to the clone while the 9.1.2 fallback renders on the  
    real widget, SetCooldownFromDurationObject is forwarded without its second  
    argument, and the fallback sources a spell cooldown duration for what may be an  
    aura. The common cause is structural: mirroring a widget driven by C code and  
    roughly ten call sites, whose inputs are secret half the time, leaks at every  
    new setter and call site.  
    So the countdown goes back onto the single widget it was always on. This  
    restores the pre-9.1.1 duration-text behaviour exactly; the file is identical to  
    v9.1.0 apart from the stack-glow fixes, which are untouched and stay. The  
    tradeoff returns with it: with Duration Text on, the interior-painting glow  
    styles (Modern/Classic WoW Glow, GCD, Shape Glow) draw over the digits. That is  
    cosmetic, style-dependent, and better solved by an opt-in setting than by  
    mirroring combat-time state.  
    PR #1871 becomes unnecessary and should be closed rather than merged.  
- ptBR: translate Quick Fire, LibDataBroker plugin blocks, Raid Frames highlight border, Cooldown Manager stack glow, Split Compare, and Resting/In Vehicle visibility conditions  
- zhTW: translate 48 new keys for Quick Fire, Broker blocks and stack glows  
    Covers everything added to the options tree between v9.0.8 and v9.1.2:  
    the Raid Tools Quick Fire world-marker binds, the DataBars Broker plugin  
    block, the Cooldown Manager stack text/glow cog, the raid-frame highlight  
    border sizes, the Mythic+ split-time toggle, the bag Recent Items clear  
    button, the taintLog/scriptProfile performance popup and the Resting /  
    In Vehicle visibility conditions.  
    Also unifies Ignore Pain on the client name and drops one dead key whose  
    English source string upstream rewrote.  
- Add Korean translations for various UI elements  
- Add 'Show Clear Button' option in UI settings  
    Added a new option to show a clear button in the UI settings.  
- Enhance Korean localization with quick fire features  
    Added new quick fire features and tooltips for raid tools in Korean localization.  