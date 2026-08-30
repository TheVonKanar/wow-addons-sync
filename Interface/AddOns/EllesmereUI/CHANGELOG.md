# EllesmereUI

## [v9.0.8](https://github.com/EllesmereGaming/EllesmereUI/tree/v9.0.8) (2026-08-29)
[Full Changelog](https://github.com/EllesmereGaming/EllesmereUI/compare/v9.0.7...v9.0.8) [Previous Releases](https://github.com/EllesmereGaming/EllesmereUI/releases)

- Release v9.0.8  
- Merge pull request #1819 from saadjwabin-dot/patch-2  
    Update koKR.lua  
- Merge pull request #1816 from dfrisone/fix/quickdraw-icon-question-marks  
    Fix Quickdraw entries drawing as question marks on the first open  
- Merge pull request #1814 from dfrisone/fix/pab-filter-spell-family-alts  
    Fix multi-state buffs dropping out of Player Aura Bars filters  
- Merge pull request #1812 from svart2521/sense-power-missing  
    Fix Sense Power not tracked, and its options-menu name collision  
- Merge pull request #1811 from Nnoggie/codex/augment-rune-empty-bags  
    Fix(Aura Buff Reminders): show out-of-stock Augment Rune  
- Merge pull request #1810 from JuJuFX-dev/bugfix/cdm-housing-default-reset  
    Fix(CDM): housing-hide default resetting on the three built-in bars  
- Merge pull request #1804 from manaste/raidframes-update-status-icons  
    refactor(raidframes): update status icons to newest version  
- Merge pull request #1803 from manaste/raidframes-fix-status-text-preview  
    fix(raidframes): respect status text setting in preview mode  
- Merge pull request #1801 from dfrisone/fix/pab-vehicle-suppression-combat-restore  
    fix(unitframes): restore player aura bars after a vehicle ride like Kings' Rest Entomb  
- Merge pull request #1800 from dfrisone/fix/chat-hidden-in-house-editor  
    Fix chat disappearing inside the house editor  
- Merge pull request #1799 from dfrisone/fix/databars-loadout-configid-race  
    Fix spec data bar swap confirmation racing unrelated trait updates  
- Merge pull request #1798 from svart2521/mirror-key-presses-revisited  
    Fix Mirror Key Presses not matching current-tier potions  
- Merge pull request #1795 from dfrisone/fix/cdm-lust-debuff-coverage  
    fix(cdm): arm the lust preset again after a death  
- Merge pull request #1792 from svart2521/chat-lua  
    Fix taint error from secret mouse-channel values during combat in raid  
- Merge pull request #1791 from svart2521/queue-skin-bug  
    Fix Missing skin for the party role-check popup (LFDRoleCheckPopup)  
- Merge pull request #1790 from svart2521/visibility-combat-bug  
    Fix action bars staying hidden through combat after a mount-triggered hide condition (Druid forms + Skyriding Mount)  
- Merge pull request #1788 from dfrisone/fix/unlock-fps-counter-disabled  
    fix(qol): hide the FPS Counter mover when Show FPS Counter is off  
- Merge pull request #1787 from dfrisone/fix/rf-dispel-fill-overlay-vertical  
    fix(dispels): anchor the Fill Overlay to the fill on both axes  
- Merge pull request #1785 from svart2521/vanishing-class-resource-after-cutscene  
    Fix class resource bar vanishing after cutscenes  
- Update koKR.lua  
    I updated the existing translation to match the in-game localization  
- Merge pull request #1784 from dfrisone/fix/riptide-hot-tank-buff-round2  
    Fix party/raid buff monitor icons sticking after a unit un-ghosts  
- Merge pull request #1781 from JuJuFX-dev/feature/visibility-combine-or  
    Feature(Visibility Options): Adds a Match Mode choice to the unified Visibility row  
- Merge pull request #1780 from Barbiero/feat/databars-gold-abbreviate  
    Add gold amount abbreviation option to Databars  
- Retest the pending Quickdraw entries rather than re-requesting them  
    AdvancePendingIcons used WarmSlot as its predicate, so an entry whose  
    data never resolves re-issued the load on every frame of the open --  
    up to the latch timeout. Split the cache test into ns.SlotDataReady and  
    leave the request to WarmSlot.  
    Warm the nested children in PushPalette's claim loop too: a palette  
    reached only by being nested carries no keybind of its own, so it gets  
    no push, and its entries were warmed for the first time by the open  
    that drew them.  
- Load Quickdraw entry data before the palette draws it  
    A palette paints its icons once per open. Spell, item and toy display  
    data is loaded on demand, so any entry whose data had not been cached  
    this session drew the question mark and kept it for the whole of that  
    open -- the second open looked right only because the first one's failed  
    lookup had fetched the data in the meantime.  
    Request the load for every bound palette's entries at push time, which  
    runs at login and on every spellbook or macro change, and collect the  
    cells that are still waiting so an open palette repaints them as their  
    loads land.  
- Apply spell families to the hide lane and to filter edits  
    The catch-all's excludeSpellIDs, the two preview mirrors of that lane, and the  
    Filter Editor's own toggle and delete now treat a curated family as one buff,  
    so hiding or removing one state cannot leave its siblings behind.  
- Track every state of a multi-state buff in Player Aura Bars  
    Filters and Extra Spells resolve curated buff families (a primary plus its  
    alts) instead of the single id the UI can offer, so a buff whose aura swaps  
    spell ID as it advances keeps showing.  
- fix(auras): show out-of-stock rune reminder  
- Fix Sense Power tracking and name collision in buff options  
    Sense Power was keyed to a secret-fingerprint spell ID (361022) whose sig  
    never matched in testing, so it never appeared as trackable at all. Switch  
    to 361021, the caster's own confirmed non-secret buff, and keep 361022  
    alongside it as the separate "(Ally)" effect, both registered in the buff  
    presets and off by default.  
    Blizzard's client reports the same name for both spell IDs, so every spot  
    that built a dropdown/list label straight from GetSpellName couldn't tell  
    them apart. Route those through the existing curated-name lookup  
    (SPELL\_NAME\_BY\_ID), exported to EUI\_RaidFrames\_ManagerPages.lua too since  
    it had its own independent copies of the same raw-API pattern.  
- ptBR: translate the new gold abbreviation options  
- feat(databars): add Force English Units option for gold abbreviation  
    Mirrors Damage Meters' forceEnglishUnits toggle: CJK clients (zhCN/zhTW/koKR)  
    group abbreviated gold by 万/萬/만 by default, and can opt into K/M instead.  
    The option row only appears for those three locales, same as the Damage  
    Meters options page.  
- feat(databars): add gold amount abbreviation option  
    Adds an "Abbreviate Amount" toggle to the Databars Gold block that  
    displays large balances with K/M suffixes (e.g. 284,208g -> 284.2Kg)  
    instead of the fully grouped number. The gold tooltip breakdown always  
    keeps full precision. CJK clients group by 万/萬/만 instead of K/M.  
- Fix CDM housing-hide default resetting on the three built-in bars  
    Unchecking a visibility option axis always persisted as nil, which is  
    correct for axes that default off but wrong for visHideHousing on the  
    built-in Cooldowns/Utility/Buffs bars, whose DEFAULTS entry ships true.  
    On login, DeepMergeDefaults filled the nil back in, silently  
    re-enabling housing-hide even after the user turned it off. Custom  
    bars were unaffected since they sit outside the DEFAULTS array that  
    gets merged.  
    SetOpt in AttachVisibilityChecklist now accepts an optional  
    trueDefaultOpts set; keys listed there persist an explicit false on  
    uncheck instead of nil, so the merge can no longer mistake "explicitly  
    off" for "never set". CDM wires this up for visHideHousing.  
- refactor(raidframes): update status icons to newest version  
- fix(raidframes): respect status text setting in preview mode  
- Merge upstream/main into the Any match branch  
    Brings in the Never/Always option-axis fix (#1776) plus the koKR, ptBR and  
    zhCN locale updates. One conflict, in AttachVisibilityChecklist: both sides  
    inserted a helper directly after SetOpt. Resolved by keeping both.  
    The two features compose without further change. AnyShowOptActive unchecks  
    Always while a Show lane is set because always is not one of the axes  
    TallyVisibilityModeAxes counts, so under Any it contributes no disjunct and  
    the Show lane is left as the only one -- the same narrowing the All path  
    reconciles, reached by a different route. The modifier rows carry no axis  
    field, so the opt-axis walks in AnyShowOptActive and the Always branch of  
    SetChecked never see them.  
- Merge pull request #1778 from Barbiero/locale/ptbr-since-907  
    ptBR: Arcane Soul, Crests block, Debuff Filter modes, Compact Band, markers  
- Merge pull request #1777 from Crazyyoungs/main  
    KoKR: Add Korean translations for various UI elements  
- Merge pull request #1776 from JuJuFX-dev/fix/visibility-never-always-option-axes  
    Fix(Visiblity Options): Never and Always interplay with the visibility option axes  
- Merge pull request #1773 from tenngoxars/locale/zhcn-90-localization  
    locale(zhCN): translate 9.0 housing, cast bar, and marker strings  
- Add Korean translation for Combat Status text  
- Keep the portal flyout clickable after leaving the house editor  
    The toggle keyed off the shown flag, which survives the host frame being  
    hidden out from under the flyout when the editor closes, so the next click  
    took the hide branch and nothing opened.  
- Seat the chat popups and late-built chrome on the house editor host too  
    Review follow-up: the URL copy popup, the Copy Chat window and the M+ portal  
    flyout are built on first use, so they can be created on either side of an  
    editor session and the panel pass cannot own them -- they now seat themselves  
    on show. A profile or spec swap made inside the editor can also build panel  
    chrome (borders, the tab-band extension) that did not exist when the editor  
    opened, so the refresh ends with a host pass.  
- Fix chat disappearing inside the house editor  
    The house editor is a full-screen UI panel: it hides UIParent and reparents the  
    chat frames onto itself so chat stays readable while decorating. Blizzard's  
    FCF\_SetFullScreenFrame only moves widgets still parented to UIParent, so our  
    chat panel frames -- background, message frames, tabs, sidebar, borders -- were  
    left behind on the hidden UIParent and the whole visible chat vanished.  
    Follow the chat frames onto whichever host Blizzard picked when the editor  
    opens, and back to UIParent when it closes.  
- Fix spec data bar swap confirmation racing unrelated trait updates  
    The pending-swap resolver treated any TRAIT\_CONFIG\_UPDATED as proof the  
    tracked swap had landed, without checking which config the event was  
    about. Group content generates far more background trait churn (other  
    loadouts syncing, hero-talent data) than solo play, so an unrelated  
    update was routinely mistaken for commit confirmation and the pointer  
    got written to a swap that was still stuck behind combat -- reproducing  
    as "reverts fine solo, sticks on the new loadout in dungeons/raids".  
    Match the event's configID against the pending swap before acting on it.  
- Fix Mirror Key Presses not matching current-tier potions  
    OnPress keyed pressed items off their literal itemID, but pot-family  
    bar icons (Health Potion, Light's Potential, etc.) always key off a  
    fixed primary itemID that stays pinned as an identity anchor while the  
    current-tier item ships as an altItemIDs entry. Pressing the potion  
    players actually carry never populated the matching key, so the mirror  
    overlay never lit up. Resolve alt-tier itemIDs back to their preset's  
    primary id before building the pressed set.  
- Fix action bars staying hidden through combat with Hide - Skyriding Mount  
    "Hide - Skyriding Mount" (visHideDragonriding) is evaluated purely in Lua for  
    every caller, since no secure macro token can express its "ground included"  
    semantics (the airborne-only [advflyable,flying] pair used for the separate  
    Skyriding (Airborne) mode is a different check). This exposed it to the same  
    bug as the earlier Druid mount-form fix: a bare "hide" written by the  
    non-secure fallback is a dead constant once InCombatLockdown() defers the  
    next Lua pass, freezing the bar hidden through an entire fight after a  
    skyriding dismount into combat, for any class.  
    The shared evaluator now flags this axis with a "mountaxis" marker instead  
    of a plain true, and Action Bars maps it to the same "combathide" signal the  
    Druid-form case already uses, so the write site bakes in the same [combat]  
    show escape hatch. Confirmed on a regular mount with matching toggles.  
- fix(cdm): treat both faction lust ids as one preset identity  
    Review follow-ups to the faction resolve. The preset only ever declared the  
    current character's lust id, so on a profile shared with a character of the  
    other faction the picker read the stored icon as absent: the entry showed as  
    addable, and clicking it appended the second id next to the first, leaving two  
    identical lust icons on the bar.  
    The preset now lists both ids with this character's first, which is what every  
    store site takes, and the picker's "already added" test moved to  
    ns.IsPresetOnBar so it greys exactly what AddPresetToBar's guard would reject.  
    That guard already scanned every member, so the same mismatch was visible on  
    the invisibility potions, whose five ids made the entry look addable whenever a  
    variant other than the primary was stored.  
    Tracking Bar labels now read the live preset name the way the icon already did,  
    since the copy saved at pick time can name the other faction's lust and those  
    labels are never user-edited.  
- fix(cdm): resolve the lust preset's faction after the player loads  
    The Bloodlust/Heroism preset baked its name, icon and spell id from  
    UnitFactionGroup at file load. That call can read nil early in a client  
    session, which took the Alliance branch and left a Horde player looking at a  
    "Heroism" entry in the picker, with the Alliance art and id stored on whatever  
    bar they added it to. The table now carries the Horde form and is re-resolved  
    from OnEnable, alongside the existing race/class cache.  
    Stored ids are left alone: a profile shared between a Horde and an Alliance  
    character keeps whichever id was added first, and the Sated edge already arms  
    on both, so the displays resolve their art through the current character's  
    faction instead. Covers the options preview strip, the injected buff-family  
    frame and the Custom Auras frame; the picker and Tracking Bars read the  
    refreshed preset directly.  
- fix(cdm): re-read the lust lockout after death so the next lust arms  
    The Sated listener pins the lockout debuff for 590s after a rising edge it  
    armed on, skipping the aura probe on the assumption that nothing lifts the  
    debuff early. Death does: a player who dies loses Sated, which is why a wipe  
    frees the raid to lust again on the next pull. Inside the pin the probe never  
    runs, \_satedPresent stays true, and the fresh lust produces no rising edge, so  
    the Bloodlust preset shows nothing for the rest of the stamped window.  
    It bites hardest with two lusters in the group, where the second lust lands a  
    minute or two after the first rather than a full lockout later. Re-read  
    presence and drop the stamp on PLAYER\_DEAD/PLAYER\_ALIVE so the next aura event  
    sees the truth.  
- Address review findings on the Any match path (round 3)  
    - BuildAnyMatchTail: return liveAxes as a third value (count of axes  
      compiled as live macro terms, not the lower bound constrained). Unit  
      Frames gates on liveAxes > 0 so a target/enemy-only Any selection  
      does not register a frozen-constant driver during combat.  
    - BuildVisibilityDriverStringAny: generalise the luaOnly filter via  
      VisAxisIsLuaOnly instead of hard-coding the softTarget edge name.  
    - EUI\_ActionBars\_Options: call \_RefreshSoftTargetGate first in both  
      onOptionChanged closures so the gate flags are current before the  
      driver string is rebuilt.  
- Fix taint error from secret mouse-channel values during combat in raid  
    GetMouseChannels read IsMouseClickEnabled/IsMouseMotionEnabled directly and  
    immediately boolean-tested the result. Under WoW 12.1's secret-value system,  
    these can return a secret boolean once execution is combat-tainted (e.g. in  
    a raid), and testing a secret value throws. Sanitize each value with  
    issecretvalue() before use, defaulting to false when secret, matching the  
    same pattern already used elsewhere in this file for other secret booleans.  
- Skin the party role-check popup (LFDRoleCheckPopup)  
    Only the later "group found" and "queue missed" queue popups were wired into  
    the reskin system; the initial "Confirm your role" popup shown to the whole  
    party when anyone queues was never touched, so it stayed stock Blizzard  
    regardless of who initiated the queue. Strips the outer chrome and applies  
    the same dark background/border as the other queue popups, hooked on the  
    frame's OnShow so it applies universally rather than depending on who  
    triggered the queue.  
- Fix action bars staying hidden through combat after dropping out of Druid mount-like forms  
    Hide-when-Mounted relies on the secure [mounted] macro conditional for real  
    mounts, which self-updates even in combat. Druid Travel/Flight Form isn't a  
    real mount, so it falls back to a non-secure Lua clobber that wrote a bare  
    "hide" string. Shifting out of form to attack fires UPDATE\_SHAPESHIFT\_FORM  
    into combat almost immediately, the deferred handler bails on  
    InCombatLockdown(), and the bare "hide" constant never re-evaluates until  
    combat ends. The fallback now writes "[combat] show; hide" instead, so the  
    secure engine can self-correct mid-fight the same way real mounts do.  
- fix(qol): re-register the FPS mover so an open unlock session tracks the toggle  
- fix(qol): hide the FPS Counter mover when the counter is off  
    The EUI\_FPS unlock element only reported itself hidden while attached to  
    Secondary Stats, so a profile with Show FPS Counter off still got a  
    draggable FPS Counter box in unlock mode. Gate isHidden on showFPS as  
    well.  
- fix(dispels): anchor the Fill Overlay to the fill on both axes  
    The fill-mode dispel overlay anchored TOPLEFT to the health bar and only  
    BOTTOMRIGHT to the fill texture, which tracks a left-to-right bar and nothing  
    else. With Vertical Fill the fill texture keeps the bar's own BOTTOMRIGHT, so  
    the overlay spanned the whole frame and read as Full Overlay. Both corners now  
    come off the fill texture, covering vertical and reverse fills for raid, party  
    and unit frames plus their option previews.  
- fix(unitframes): catch ClearAllPoints stripping Blizzard class power bar anchors  
    During in-engine cutscenes/UI transitions something calls ClearAllPoints  
    directly on the Blizzard class power frame without reparenting or hiding  
    it, so the existing SetParent/Hide hooks never see it and the bar renders  
    with zero points. Add a ClearAllPoints hook and widen ReassertClassPower's  
    trigger condition to also fire on GetNumPoints() == 0.  
- Merge remote-tracking branch 'upstream/main' into fix/riptide-hot-tank-buff-round2  
- Guard the new assist-gate re-check against the same stale-map hazard  
    RFC\_ApplyAssistGate was called with the loop's unit key directly,  
    missing the same live-attribute reconfirmation the resync block right  
    below it already does. unitToButton et al. can carry a stale token ->  
    button mapping (entries are only ever added, not dropped, between  
    full wipes), so a probe against the wrong token could write its  
    assist verdict onto a button that's actually showing a different,  
    live occupant -- hiding that occupant's real dispel/BM containers  
    until their next genuine reassignment.  
    Hoist the live-attribute read once and gate both call sites on it.  
- Re-drive the assist/identity gate on the ghost ticker's cadence  
    ApplyAssistGate already forces a full container UpdateAllAuras on its  
    own false->true edge, correctly self-healing whatever the identity  
    gate parsed wrong while it was down. But the only thing that ever  
    calls it is a real unit (re)assignment -- so a trip and clear from  
    faction/phase/filter-streaming causes, with no accompanying token  
    change or render-visibility loss, never gets re-evaluated at all.  
    Piggyback it onto the existing 1s ghost-check ticker so the gate gets  
    re-driven regularly regardless of what triggered it. Cheap: it's  
    already a same-state no-op past one pcall'd read.  
- Fix soft-target and druid-form staleness on the Any driver path  
    Two macro tokens knowingly disagree with their own Lua probe -- [exists]  
    counts a soft target, [mounted] cannot see a druid travel or flight  
    form -- and the all-match path reconciles both with a Lua force-hide.  
    Under Any a veto is wrong, since one axis must not silence the others,  
    so AnyDriverLaneFixups resolves each per axis: a token that would  
    wrongly pass loses its disjunct, one that would wrongly fail shows  
    outright.  
    Action Bars had a second, independent soft-target path  
    (ImmediateSoftTargetCheck) that still wrote a literal hide under Any;  
    it now defers to the shared tail builder for that lane, and its gate  
    now arms for the counter lane too so the Hide-lane correction gets its  
    own immediate rebuild instead of going stale until an unrelated event.  
    Unit Frames and the Minimap have no soft-target event edge, so a  
    compiled [exists]/[noexists] token there would drift the moment a soft  
    target changed with nothing to rebuild it. Option axes now declare  
    needsEdge, and a consumer passes the edges it actually watches --  
    Action Bars gets the live macro token because it rebuilds on the  
    soft-target events, everyone else resolves that axis in Lua, matching  
    what the all-match path always did with it.  
    Also: gate the fixup probes behind their own lanes and run them after  
    the cheap luaP early-out, since Action Bars was hitting them on every  
    soft-target flip and every 0.1s poll tick regardless of whether a bar  
    even used mounted/target visibility; the four building blocks that  
    each secure consumer repeated collapse into EUI.BuildAnyMatchTail; a  
    spec-override capture of an orphan scalar now clears the match the way  
    the row's own orphan branch already does, so the state the UI locks  
    cannot come back through that path; and the two identical Any tail  
    builds in AttachVisibilityChecklist are just one now.  
- Address review findings on the Any match path  
    Secure driver correctness: two macro tokens knowingly disagree with their  
    own Lua probe -- [exists] counts a soft target, [mounted] cannot see a  
    druid travel or flight form. The all-match path reconciles both with a  
    Lua force-hide, which is wrong under Any, where one axis must not silence  
    the rest. AnyDriverLaneFixups now resolves it per axis instead: a token  
    that would wrongly pass loses its disjunct, one that would wrongly fail  
    shows outright. Limited to those two axes; [harm]'s treatment of soft  
    enemies is not established here and is left alone.  
    The four steps every secure consumer repeated to build an Any tail move  
    into EUI.BuildAnyMatchTail, so Action Bars, Unit Frames and the Minimap  
    share one implementation instead of three copies. It also reports how  
    many axes actually constrain the element, which lets Unit Frames keep a  
    frame on its unit watch when an Any selection constrains nothing -- the  
    modifier alone changed no visibility but used to change the mechanism  
    delivering it.  
    An orphan scalar combined with Any silently dropped the option lanes,  
    reachable by clicking a Match Mode row while a legacy value was stored.  
    The Match Mode rows now lock in that state; Never and Always stay  
    clickable, so it is never a dead end.  
    Also: short-circuit both tallies once the verdict is fixed (the option  
    probes walk druid form auras), keep visibilityMatch frame-local in the  
    unit-frame group copy the way barVisibility already is, restate the  
    Mouseover tooltip under Any, stop repainting a hovered modifier row, and  
    drop the unused GetVisibilityMatch wrapper.  
- ptBR: Arcane Soul, Crests block, Debuff Filter modes, Compact Band, markers  
    Translates the new Sunfury Arcane Mage Arcane Soul countdown, the Data  
    Bars Crests block and item level display, the target/focus/boss Debuff  
    Filter's expanded mode dropdown, the Raid Tools Compact Band layout and  
    its marker/pull-timer tooltips, the visibility checklist's Skyriding  
    and Housing rows, raid/world target marker names, and a few smaller  
    strings across Chat, Minimap, and Raid Frames options. Also drops nine  
    ptBR entries whose English text was reworded or removed upstream,  
    leaving them dead.  
- Split Match Any Condition into an exclusive Match Mode pair  
    Replaces the single Match Any Condition toggle with two radio-style  
    rows, Match All Conditions and Match Any Condition, under their own  
    Match Mode header. Both write the same store.visibilityMatch scalar,  
    so picking one is what unpicks the other.  
    Only the active row now reads in accent color; the inactive one looks  
    like any other unchecked row, and the color updates live when the  
    other row in the pair is clicked.  
- Add Korean translations for various UI elements  
- Fix Never and Always interplay with the visibility option axes  
    The option axes (Skyriding Mount, Instances, Housing, Mounted, Target,  
    Enemy Target) are stored as their own booleans outside the mode selection,  
    so Never and Always were never reconciled with them.  
    Checking an option axis while Never was picked was a silent no-op, because  
    Never hides before any option is consulted. Such a click now clears Never,  
    which empties the selection and lands on Always through WriteSel's  
    never-empty invariant. That is the base state a Hide lane needs, and the  
    one a Show lane then narrows. Unchecking a lane leaves Never alone.  
    Always and a Show lane could also read as checked at the same time, which  
    is a contradiction: Always claims to be unrestricted while a Show lane  
    narrows showing to a subset. Always now reads unchecked while any Show  
    lane is active, and clicking it clears those lanes so that the click is  
    not a no-op itself. Hide lanes are exceptions on top of showing and  
    survive both Never and Always.  
    Both cases write a mode and an option in a single click, so AfterChange  
    runs both callback chains. Neither is a subset of the other: Action Bars  
    recompiles the housing driver only in its option chain, and rebuilds the  
    options page on a Never flip only in its mode chain.  
- Add Match Any Condition option to the unified Visibility row  
    Adds a per-element toggle (stored as store.visibilityMatch = "any") that  
    switches the Visibility row's conditions from AND to OR. Off (default)  
    keeps the existing behavior byte-identical.  
    Under Any, mode axes (combat, group, dragonriding) and option lanes  
    (instances, housing, mounted, target, enemy target) are evaluated  
    together as disjuncts instead of independent vetoes, since a veto chain  
    cannot express OR. The secure state-visibility driver compiler gets a  
    matching Any-mode builder for Action Bars, Unit Frames and the Minimap,  
    compiling each constrained axis into its own bracket group; the  
    dragonriding-hide axis, which has no single positive macro token, is  
    compiled as a trailing hide gate instead.  
    Sync icons, Myslot backups and profile copies carry the match flag  
    alongside the rest of the visibility selection so it never desyncs from  
    the conditions it governs.  
- locale(zhCN): translate 9.0 housing, cast bar, and marker strings  
- fix(unitframes): keep the aura stand-down latch tied to its recovery lane  
    Review follow-up on the alpha stand-down. Two consequences of leaving the  
    containers live behind alpha 0:  
    A vehicle exit un-dimmed on the raw event edge, one frame ahead of the  
    repair, so the ride's filter-degraded parse painted for a frame. The exit  
    now hands the stand-down to the degraded lane, which un-dims and forces  
    the clean re-parse in a single execution.  
    The latch could also outlive the lane that clears it: with the settle  
    watcher no longer giving up, a module disabled mid-window stranded it  
    true and every later bar was rebuilt dimmed. Both lane exits and the  
    enable path now hand it back.  
- fix(unitframes): restore player aura bars after a vehicle ride ends in combat  
    The vehicle/degraded suppression stood the bar parents down with a real  
    Hide whenever it was reached out of combat. The parent's Show is  
    ADDON\_ACTION\_BLOCKED in lockdown (the engine aura container is an  
    anchored protected child), so a suppression that lifted mid-combat could  
    not be undone until the next PLAYER\_REGEN\_ENABLED replay.  
    Kings' Rest hits that exactly: Entomb is a vehicle and sitting in the  
    tomb drops the player's combat, so the ride's queued hide replayed for  
    real at that regen edge and the exit's show landed inside the next pull.  
    Reported by Thylaei: buffs and debuffs vanish on entomb and stay gone for  
    the whole boss pulled afterwards, returning only when combat ends.  
    Suppression now rides on alpha in and out of combat, leaving the shown  
    state to carry the durable render verdict (master enable, per-bar toggle,  
    Use Blizzard Buffs), so it is always reversible. The settle watcher no  
    longer gives up after 15s either: nothing else re-shows an alpha-hidden  
    bar, so a watcher that stopped early would strand it for the session.  
- Fix review findings on the ghost-aura resync  
    Trusting unitToButton's loop key as the button's real unit was wrong:  
    OnAttributeChanged only ever adds a new entry on reassignment, never  
    drops the old one, so a stale oldToken -> btn mapping can survive  
    until the next RebuildUnitMap wipe -- the same UnitExists() race  
    PR #1726 fixed for d.rfcUnit can leave this map stale too. Re-confirm  
    against the button's own live unit attribute before touching anything.  
    Also drop the d.rfcUnit = nil trick used to force RFC\_OnUnitAssigned's  
    full SetUnit + container rebuild + DM re-point + assist-gate path.  
    The unit token never changed here, so that's the exact "raid-wide  
    UpdateAllAuras storm" its own same-unit guard exists to prevent, just  
    reached through ghost-recovery instead of a real reassignment. Call  
    UpdateAllAuras() directly on each container instead, same shape as  
    ApplyAssistGate's own regain refresh -- and add the Debuff Manager  
    tiles explicitly, since DM\_OnUnitAssigned's own per-tile cache never  
    saw a unit change either and would otherwise skip them silently.  
- Clear stale party/raid aura indicators after a unit un-ghosts  
    GhostAuraCheck's ticker still tracks d.ghostCleared for every raid/party  
    button whose unit goes invisible or disconnects, but v8.8's rewrite onto  
    the 12.1 aura containers dropped the actual clearing call -- it left  
    Blizzard's real-time UNIT\_AURA-driven containers with whatever they last  
    painted before the unit ghosted, and nothing ever revisits it.  
    UNIT\_AURA stops firing for an invisible/disconnected unit, so a HoT or  
    debuff that falls off during that window (a LoS break, a loading screen)  
    never reaches the container as a removal. The Cooldown widget's own  
    countdown still finishes and drops its text on schedule -- that timer is  
    client-side and needs no confirmation -- but the icon itself stays  
    assigned to the now-stale aura instance until something forces a full  
    re-parse, which nothing did.  
    On regain, force the same full container resync RebuildUnitMap already  
    uses to repair a stale unit binding: clear d.rfcUnit and re-drive  
    RFC\_OnUnitAssigned, which re-registers every container against the  
    current unit and reprocesses its live aura list from scratch.  
