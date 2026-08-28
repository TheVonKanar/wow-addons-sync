# EllesmereUI

## [v9.0.7](https://github.com/EllesmereGaming/EllesmereUI/tree/v9.0.7) (2026-08-27)
[Full Changelog](https://github.com/EllesmereGaming/EllesmereUI/compare/v9.0.6...v9.0.7) [Previous Releases](https://github.com/EllesmereGaming/EllesmereUI/releases)

- Release v9.0.7  
- Merge pull request #1772 from delasteve/feat/mythic-plus-strict-compare  
    feat(mythictimer): add strict comparison mode for split compare  
- Merge pull request #1771 from dfrisone/fix/actionbar-gamepad-keybind-icons  
    Fix gamepad keybinds showing raw button names instead of controller icons  
- feat(mythictimer): add strict comparison mode for split compare  
- Merge remote-tracking branch 'upstream/main' into fix/actionbar-gamepad-keybind-icons  
- Resolve gamepad keybinds by markup rather than a binding-type test  
    A gamepad bind is rarely alone on the key: with a shoulder button set as the  
    emulated modifier, GetBindingKey returns "SHIFT-PAD4", and gating the whole  
    format on IsBindingForGamePad left that chord's modifier spelled out in front  
    of the icon on the one path controller users actually hit. Take GetBindingText's  
    answer whenever it came back carrying icon markup instead, and let the existing  
    substitutions run over it -- keyboard binds are untouched because their text has  
    no markup to match, and no gamepad atlas name contains one of the search  
    strings, so the modifier condenses and the icon survives.  
- Merge pull request #1770 from dfrisone/fix/databars-currency-season-cap  
    fix(databars): use season-earned total for capped currency tooltips  
- Fix gamepad keybinds showing raw button names instead of controller icons  
    GetBindingKey returns a gamepad binding as its raw id (PADDUP, PADLSHOULDER).  
    Both keybind formatters treated that as keyboard text and ran their condensing  
    substitutions over it, so a controller user saw "PADUP" where Blizzard's own  
    buttons draw the controller's icon. GetBindingText is what resolves the id to  
    the icon markup, and the condensing pass is skipped for those bindings since  
    its BUTTON/NUMPAD substitutions would corrupt the atlas names in the markup.  
- Merge pull request #1769 from dfrisone/fix/cdm-pvp-provider-taint  
    fix(cdm): never rebuild Blizzard's shared cooldown data on our stack  
- Merge pull request #1768 from JuJuFX-dev/fix/damagemeter-spacing-pixel-snap  
    fix(Damage Meter): bar spacing being double-scaled by UI scale  
- fix(databars): use season-earned total for capped currency tooltips  
    Currencies whose cap applies to what you earned this season rather than what  
    you hold (crests) were rendered as quantity / maxQuantity, so a wallet holding  
    99 Myth Mistcrests read "99 / 100" while the season cap was actually at 49/100.  
    Split the two figures the way the Crests block already does: the wallet total,  
    then the season progress dimmed in parentheses.  
- fix(cdm): keep the per-entry id guard when reading the display table  
    6ab561dd swapped pcall(provider.GetCooldownInfoForID, ...) for a direct  
    infoByID[cdID] index in EnumerateCDMSettingsCatalog and  
    BuildBuffFamilyPresentSet, which dropped the per-entry error boundary the  
    hidden-channel reader documents: "every provider read here is pcall-degraded  
    ... so the drop pass this feeds never over-drops on a bad read". A secret or  
    non-numeric cooldownID now raises on the table key instead of skipping one  
    entry -- in the picker that aborts the whole catalog for all nine bare  
    callers, and in the drop pass it escapes past ReconcileBuffFamilyDrops'  
    fail-open "return sd".  
    Gate both loops on \_IsUsableSID, already a file-local in each file and  
    already covering the third call site via CDMEntryHiddenOrRemoved. The falsy  
    branch leaves category nil/false exactly as the old okI-false path did, so a  
    skipped entry behaves as before.  
- fix(cdm): never rebuild Blizzard's shared cooldown data on our stack  
    Three call sites read the CDM settings provider via GetOrderedCooldownIDs()/  
    GetCooldownInfoForID(), which run Blizzard's CheckBuildDisplayData first and  
    REBUILD the shared cooldownInfoByID/orderedCooldownIDs tables whenever the  
    provider is dirty. Building the client's own shared state inside addon  
    execution poisons it for the client's later use, and the provider goes dirty  
    on exactly what changes at a PvP match boundary (talents (de)activating), so  
    the CDM bricks after leaving a BG/arena with no apparent trigger and only a  
    reload clearing it (reported by Factor, EllesmereUI-helper Discord, 8/5-8/15).  
    Added ns.CDMGetProviderDisplayData, which reads provider:GetDisplayData()  
    instead -- a plain field read that only ever observes what Blizzard already  
    built, never triggers a rebuild -- and used it in EnumerateCDMSettingsCatalog,  
    CDMEntryHiddenOrRemoved, and BuildBuffFamilyPresentSet. All three already  
    treat a nil/unavailable provider as "not ready" and fall back to keep-all or  
    live-pool behavior, so this changes nothing on the happy path.  
- Merge pull request #1766 from svart2521/mouseover-logic-gap  
    Fix Show All on Mouseover triggering from non-Mouseover bars  
- Merge pull request #1765 from vcherneny/feature/np-important-cast-glow-styles  
    Add all six glow styles plus a live preview to Important Cast Glow  
- Merge pull request #1762 from Barbiero/locale/ptbr-since-903  
    ptBR: Targeted Spell Bars interrupt/visibility, Player Housing menu fallback  
- Merge pull request #1755 from 0x963D/codex/raid-tools-compact-band  
    feat(qol): add Compact Band layout to Raid Tools  
- Merge pull request #1764 from svart2521/mirror-key-presses  
    Fix Mirror Key Presses not matching item-based actions  
- Merge pull request #1718 from uNBEx/crests\_and\_ilvl  
    feat(databars): crests and ilvl  
- Merge pull request #1763 from uNBEx/arcane\_soul  
    feat: arcane surge tracker  
- Fix Damage Meter bar spacing being double-scaled by UI scale  
    barSpacing and iconSpacing are pixel=true sliders, so the WidgetFactory  
    already converts them to coordinate units via PP.FromPixels() on save.  
    The module's own PhysicalPixels() helper multiplied by PP.mult a second  
    time, squaring the scale factor for any UI scale other than 1:1 native.  
    At non-native scales this collapsed small spacing values (e.g. 1) to a  
    fraction of a physical pixel, rendering as no gap at all, while larger  
    values lost proportionally less.  
    Use the stored config value directly for barSpacing/iconSpacing instead  
    of re-converting it. barHeight/iconSize are not pixel=true sliders and  
    still go through PhysicalPixels() as before. Also route the hover  
    tooltip's own hardcoded row spacing through the tooltip frame's actual  
    effective scale, since its scale is independent of the addon-wide UI  
    scale PP.mult is derived from.  
- Merge pull request #1761 from LoChinAn/locale-zhtw-tsb-markers-housing  
    zhTW: translate 54 new keys for cast bars, tooltip modes, markers and houses  
- Merge pull request #1760 from LoChinAn/fix-raidframes-modifier-warning-l10n  
    fix(raidframes): localize the Debuff Manager "Select a Modifier" warning  
- Merge pull request #1758 from svart2521/warbound-failure  
    Fix Auto Open Containers opening Warbound Until Equipped items  
- Merge pull request #1757 from JuJuFX-dev/claude/menu-visibility-simplification-a951f7  
    Simplify: Unify Visibility and Visibility Options into one control  
- Fix new visibility lanes going stale on Action Bars and three other gates  
    The four lanes added with the unified Visibility row were only half wired  
    on secure Action Bars. The target/enemy pair is macro-expressible and did  
    reach the state driver, but Instances and Skyriding Mount are Lua-only,  
    and the live re-evaluation path never learned about them: ShouldHideNonMacro  
    carried a hand-written list of five option keys, and the \_anyNonMacroVis  
    gate in front of it was built from the same five. Net effect was that  
    clicking one of those lanes applied once, through ApplyCombatVisibility's  
    shared evaluator, and then went stale on every zone and mount edge after;  
    a bar using only a new lane skipped the pass entirely.  
    ShouldHideNonMacro now delegates to the shared CheckVisibilityOptionsNonMacro  
    and keeps only its two deliberate extras: the soft-target check that  
    [noexists] cannot express, and the shapeshift-only mount check that must  
    not clobber the live [mounted] driver with a constant string. The shared  
    evaluator grew a skipMountAxis flag so that carve-out stays explicit.  
    The same hand-written-subset bug class turned up in three more places, all  
    now driven off the new EllesmereUI.VisHasAnyOption predicate or  
    VIS\_OPT\_KEYS directly: the Action Bars spell-drag surface (a bar hidden by  
    a new lane could not be dropped onto), the Unit Frames mouse-leave keep-  
    shown check (frame faded out instead of staying visible), and the CDM  
    Tracking Bars style copy (new lanes silently left behind on the source  
    bar). This also repairs visHideDragonriding, which predates the unified  
    row and never reached the Action Bars lists either.  
    Also fixes the Damage Meters "(seconds)" suffix: Refresh Rate moved into  
    the Visibility row's right slot, but that row's handle was discarded and  
    the suffix was anchored to the Background Opacity row instead, so it  
    landed beside Always Show Player and the slider lost its suffix.  
    Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>  
- Merge pull request #1754 from JuJuFX-dev/feature/tsb-icon-right-divider  
    Feature(Mythic+ Tools): add Icon on Right / Show Icon Divider to Targeted Spell Bars  
- Merge pull request #1753 from Crazyyoungs/main  
    koKR : Add new localization strings for UI options  
- Fix Show All on Mouseover triggering from non-Mouseover bars  
    AttachHoverHooks wires the hover fade handler onto every action bar  
    regardless of its own visibility mode, so FadeIn's "show all" broadcast  
    fired whenever mouseoverShowAll was on -- even when the bar actually  
    hovered was set to Always, not Mouseover.  
    FadeIn now only broadcasts when the entered bar itself has  
    mouseoverEnabled set, matching what the setting's tooltip promises.  
- Add all six glow styles plus a live preview to Important Cast Glow  
    The Important Cast Glow dropdown offered only Pixel Glow and Auto-Cast  
    Shine, under an ad-hoc numbering (1 and 4) that matched neither the shared  
    Glows list nor PANDEMIC\_GLOW\_STYLES. UpdateImportantCastGlow hardcoded the  
    two engines instead of using the shared dispatcher.  
    It now offers the same six styles as the Pandemic Glow row, built by  
    iterating PANDEMIC\_GLOW\_STYLES, and renders via Glows.StartGlow. The Pixel  
    Glow path is unchanged in output: StartGlow applies the same lineLen  
    formula, and an unset background alpha resolves to 1 there exactly as  
    omitting the argument did.  
    NP\_TO\_SHARED\_GLOW moves next to the style list it translates from and is  
    published on the module ns, so the aura containers and the cast glow share  
    one copy rather than drifting.  
    Saved style 4 meant Auto-Cast Shine under the old numbering but means GCD  
    under the new one, so np\_important\_cast\_glow\_style\_reindex\_v1 re-points it  
    to 3. 4 is the only reachable stale value: 1 is Pixel Glow in both. The  
    flag rides on profile data, so profiles imported from older builds are  
    fixed up on the pass after they land.  
    The row also gains a live preview icon, left of the cog. It calls the same  
    dispatcher with the same stored options the nameplate uses, so it cannot  
    drift from the real cast bar, and refreshes on style, colour and all five  
    cog settings.  
    Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>  
- Fix Mirror Key Presses not matching item-based actions  
    SlotSpellID only resolved spell and macro actions; a trinket, potion,  
    or healthstone placed directly on the action bar reports actionType  
    "item" and fell through to nil, silently no-oping the press mirror  
    for every item-tracked bar icon.  
    Item-based bar icons key off a negative identity (-itemID for item  
    presets, -invSlot for equipment-slot tracking like trinkets -13/-14),  
    not a spell ID, so OnPress now builds those same negative keys from  
    the pressed item alongside its on-use spell as a fallback.  
- fix(qol): preserve Compact Band position  
- feat: arcane surge tracker  
    - Adds an opt-in Arcane Soul Helper for Sunfury Arcane Mages (Resource Bars): a movable text showing "Soul in X.X" over the final seconds of Arcane Surge (threshold 1-15s, default 5) and the time remaining once the Arcane Soul window opens.  
    - Countdown format is switchable three ways — Seconds, GCD Count, or Seconds + GCD in Soul — so counting down to the window and counting Barrages inside it are set independently. In GCD modes the in-Soul counter reads as remaining Arcane Barrages and flips to a coloured LAST on the final one.  
    - Tracks the live Arcane Surge buff through an AuraKit engine slot instead of predicting the window from the cast, so the Spellfire-Sphere-dependent Surge length is exact — and the text is engine-rendered, so it keeps working where aura values are secret. No OnUpdate, no polling, no duration ever read in Lua.  
    - Fully customizable: font, outline, text size, three colours, Unlock Mode positioning with an inline X/Y cog. Defaults OFF, section only builds for Mages, and the display only activates on Arcane + Sunfury.  
- ptBR: Targeted Spell Bars interrupt/visibility, Player Housing menu fallback  
- zhTW: translate 54 new keys for cast bars, tooltip modes, markers and houses  
    Additions only, no existing line rewritten. Four groups:  
    - Mythic+ Timer, Targeted Spell Bars page: the new INTERRUPT AND VISIBILITY  
      block (cast colour swatches, important-cast glow, interrupt-range fade,  
      raid target marker).  
    - Raid Frames: the Debuff Manager tooltip mode "Shown on Modifier" plus its  
      cog hint, requirement tooltip and empty-selection warning.  
    - Quickdraw: the 32 raid/world marker entry labels. These are assembled at  
      runtime ("Target Marker: " .. MARKER\_NAMES[id]) and only the finished  
      string reaches L(), so a source scan never surfaces them; deDE and koKR  
      already carried all four families.  
    - Core: the housing unit-menu fallback (view/visit houses, list status text).  
    Wording follows the client's own zhTW strings where they exist: RAID\_TARGET\_1..8  
    for the marker shapes, UNIT\_VIEW\_HOUSES for View Houses,  
    VIEW\_HOUSES\_VISIT\_BUTTON for Visit, and the active-voice INTERRUPT rendering  
    rather than the passive INTERRUPTED one, matching the Interruptible Cast /  
    Interrupt on CD keys already in the file. Sentences that have a near twin  
    elsewhere in the catalog reuse that twin's wording verbatim.  
    Compiles under Lua 5.1 and round-trips through the catalog parser.  
- fix(raidframes): localize the Debuff Manager "Select a Modifier" warning  
    The red "Select a Modifier" bubble above the Use Modifier cog was passed to  
    AttachEmptyFilterWarn as a bare literal, so it rendered in English on every  
    client no matter what the locale file contained. The other five  
    AttachEmptyFilterWarn call sites (Player Aura Bars, Unit Frames, the Debuff  
    Manager's own filter dropdown) already wrap their warn text, so this was the  
    odd one out rather than a deliberate exception.  
    String-only change: the bubble text is the sole argument touched, and on an  
    English client L() returns the key unchanged.  
- Fix Auto Open Containers opening Warbound Until Equipped items  
    IsWarboundExcluded only matched bindType against ToWoWAccount/  
    ToBnetAccount/ToBnetAccountUntilEquipped, but a Warbound Until Equipped  
    container reports bindType == OnEquip (same as an ordinary BoE item,  
    no dedicated GetItemInfo enum), so that branch never matched and  
    Exclude Warbound Containers let these through to be auto-opened.  
    Fall back to C\_Item.IsBoundToAccountUntilEquip on the item's location  
    when bindType is OnEquip -- the same API EUI\_Bags.SetBindTypeText  
    already uses to detect WuE gear. Field-tested against Cache of  
    Void-Touched Armaments.  
- Fix CDM Bars section-end violation: pair Vertical Orientation with Keep Buffs in Same Place  
    Vertical Orientation stood alone with an empty right slot even though  
    buff bars render "Keep Buffs in Same Place" right after it, so the  
    empty slot was not on the section's actual last row for that bar type.  
    Buff bars now get Keep Buffs in Same Place | Vertical Orientation in  
    one row; cooldown/utility bars keep Vertical Orientation alone, which  
    is genuinely their last row.  
    Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>  
- Unify Visibility and Visibility Options into one control  
    Replaces the "Visibility" mode dropdown and the separate "Visibility  
    Options" checkbox dropdown with a single checklist row. Every condition  
    is now an axis with a Show and a Hide lane (the same two-lane pattern  
    already used by the Debuff Manager), so Never/Always/Mouseover, the  
    combat/group/skyriding modes, and the instance/housing/mount/target  
    options all live in one dropdown instead of two.  
    Storage stays split by design: mode axes still read and write the  
    legacy scalar plus visibilityModes through the shared engine, option  
    axes still read and write their existing per-axis booleans. No  
    evaluator, secure-driver, profile-sync or spec-override path changes,  
    so this is not a migration and needs no SavedVariables handling.  
    Four axes gained a counter-lane that had no equivalent before  
    (visHideInstances, visOnlySkyriding, visHideWithTarget,  
    visHideWithEnemy), wired into both the Lua evaluator and the Action  
    Bars secure macro compiler.  
    All 10 call sites (Chat, Minimap, Quest Tracker, Damage Meters, Data  
    Bars, CDM Bars, CDM Tracking Bars, Resource Bars, Action Bars x2, Unit  
    Frames) converted to the new EllesmereUI.BuildVisibilityRow. Sync icons  
    on Unit Frames, CDM Bars and Action Bars now copy both halves through  
    VisFullCopy/VisFullEquals. Page layouts recompacted so the freed slot  
    carries a related setting instead of sitting empty.  
    Fixes two behavior bugs found during the migration: resetting a Data  
    Bar to default only cleared the old 8 option keys, leaving the new  
    lanes stuck on; and CDM Tracking Bars' sleeper wake check only knew  
    about the old 8 keys too, so a bar using only a new lane would never  
    refresh its visibility.  
    Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>  
- feat(qol): add compact Raid Tools band  
- Add localization for content and combat state limits  
- QoL: add Icon on Right / Show Icon Divider to Targeted Spell Bars  
    Give the Targeted Spell Bars Show Icon setting the same cog popup as  
    the resource bars cast bar: attach the spell icon to the right side  
    instead of the left, and optionally draw a 1px divider at the  
    icon/bar seam matching the border color.  
- Remove a line from Korean localization file  
- Add Korean translations for UI changes and tooltips  
- Add new localization strings for UI options  
- feat(databars): crests and ilvl  
    - New DataBars block: Crests — all five of the season's Mistcrests in one readout, with a checklist for which tiers show, a separator dropdown (slash / line / dash / space), and toggles for icons, cap, hiding crests you own none of, and ladder order.  
    - Crest Colors text mode — a 4th Text Color swatch that tints each amount with its own tier colour; it's the block's nothing-stored default, resolved through ns.CrestColorMode rather than a forced write, so no migration and Custom/Class/Accent still take over cleanly.  
    - New DataBars block: Item Level — prefix of none / ILVL / Item Level / character icon, showing equipped (default), total, or both, with 0–2 decimal places.  
    - Band colouring — an optional 4th Text Color swatch on Item Level tinting the number by the upgrade track it sits in, reusing the crest tier colours.  
    - Season maintenance — crest IDs, tints and item-level band floors sit in two commented SEASON UPDATE tables next to the factory, mirroring EUI\_UpgradeCalc.lua's existing convention; crest names and icons come live from C\_CurrencyInfo, and the checklist stores tier slots (t1..t5) rather than currency IDs so a season's ID swap preserves each player's selection.  
