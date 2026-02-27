--[[
German (deDE) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]
if GetLocale() ~= "deDE" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

local LOCALE = "deDE"

local LOCALE_REGISTRY_KEY = "LARIASWEEKLYCHECKLIST_LOCALE_REGISTRY"

local reg = _G[LOCALE_REGISTRY_KEY]
if type(reg) ~= "table" then
    reg = {}
    _G[LOCALE_REGISTRY_KEY] = reg
end
if type(reg.data) ~= "table" then reg.data = {} end

-- ⚠️ UNVERIFIED MIDNIGHT TERMS – Verify these in-game before shipping:
--   Kriegsmodus (Warmode), Jahrmarkt des Dunkelmondes (DMF abbr. "JdD"),
--   Saltheril-Fest (Saltheril's Soiree), Immergrüner Wald (Eversong Woods),
--   Überfluss-Ereignis (Abundance Event), Legenden der Haranir,
--   Harandar, Sturmarion-Angriff (Stormarion Assault),
--   Nichtsturm (Voidstorm), Die Singularität (The Singularity),
--   Zerbrochener Schlussstein (Cracked Keystone), Truhen-Schlüssel (Coffer keys)
local DATASET = {

    {
        id = "early_access_feb_26_through_mar_2_pay_to_win",
        title = "Früher Zugang – 26. Feb. bis 2. März – Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "level_characters_warmode_on_to_90_dmf_opens_sunday_for_10_more_exp", text = "Charaktere im Kriegsmodus auf Level 90 bringen – JdD öffnet Sonntag für +10 % XP" },
            { id = "if_available_complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Falls verfügbar: Wöchentliches Saltheril-Fest im Immergrünen Wald mit JdD-Buff abschließen." },
            { id = "if_available_complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Falls verfügbar: Wöchentliches Überfluss-Ereignis in Zul'Aman mit JdD-Buff abschließen." },
            { id = "if_available_complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Falls verfügbar: Wöchentliches Legenden der Haranir-Ereignis in Harandar mit JdD-Buff abschließen." },
            { id = "if_available_complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Falls verfügbar: Wöchentlichen Sturmarion-Angriff im Nichtsturm mit JdD-Buff abschließen." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Optional) Jeden seltenen Gegner einmal pro Zone für Ansehen töten. Wöchentlicher Lockout pro Seltenem." },
            { id = "complete_4x_prey_on_normal_difficulty_for_veteran_gear", text = "4x Beute auf Normaler Schwierigkeit für Veteran-Ausrüstung abschließen." },
            { id = "once_dmf_opens_complete_side_quest_chains_for_renown_can_be_done_on_alts_to_level_at_same_time", text = "Ab JdD-Öffnung: Nebenquestketten für Ansehen abschließen. (Kann auf Alts gleichzeitig beim Leveln erledigt werden)" },
            { id = "unlikely_see_doc_for_info_complete_a_world_tour_of_m0_s_after_full_release_but_before_your_region_s_reset", text = "(Unwahrscheinlich, Dokument für Infos) Welttour der M0s nach dem vollständigen Release, aber vor dem Wochen-Reset deiner Region" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Vorsaison Woche 1 – 3. März – M0s",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Ansehen bei 'Die Singularität' auf Rang 7 erhöhen für 1/6-Champion-Schmuckstück" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Ansehen bei Hara'ti auf Rang 8 erhöhen für 1/6-Champion-Gürtel" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Ansehen bei Silbermond auf Rang 9 erhöhen für 1/6-Champion-Helm" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Ansehen beim Amani-Stamm auf Rang 9 erhöhen für 1/6-Champion-Halskette" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Wöchentliches Saltheril-Fest im Immergrünen Wald mit JdD-Buff abschließen." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Wöchentliches Überfluss-Ereignis in Zul'Aman mit JdD-Buff abschließen." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Wöchentliches Legenden der Haranir-Ereignis in Harandar mit JdD-Buff abschließen." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Wöchentlichen Sturmarion-Angriff im Nichtsturm mit JdD-Buff abschließen." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Optional) Jeden seltenen Gegner einmal pro Zone für Ansehen töten. Wöchentlicher Lockout pro Seltenem." },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Tiefen bis Stufe 8 freischalten (11 falls verfügbar)" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Optional) 4x Normale Beute für Abenteurer-Ausrüstung und Ansehen abschließen." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "4x Schwere Beute für Veteran-Ausrüstung und Ansehen abschließen." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Welttour der M0-Dungeons abschließen – Veteran-Gs – noch nicht aufwerten" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Vorsaison Woche 2 – 10. März – M0s",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "if_not_completed_continue_to_raise_renown_for_champion_pieces", text = "Falls nicht abgeschlossen: weiter Ansehen für Champion-Teile erhöhen" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods", text = "Wöchentliches Saltheril-Fest im Immergrünen Wald abschließen." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman", text = "Wöchentliches Überfluss-Ereignis in Zul'Aman abschließen." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar", text = "Wöchentliches Legenden der Haranir-Ereignis in Harandar abschließen." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm", text = "Wöchentlichen Sturmarion-Angriff im Nichtsturm abschließen." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Optional) Jeden seltenen Gegner einmal pro Zone für Ansehen töten. Wöchentlicher Lockout pro Seltenem." },
            { id = "unlock_delves_through_tier_8_11_if_available_if_not_done_yet", text = "Tiefen bis Stufe 8 freischalten (11 falls verfügbar), falls noch nicht erledigt" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Optional) 4x Normale Beute für Abenteurer-Ausrüstung und Ansehen abschließen." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "4x Schwere Beute für Veteran-Ausrüstung und Ansehen abschließen." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Welttour der M0-Dungeons abschließen – Veteran-Gs – noch nicht aufwerten" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Falls du Dienstag den 17. raidest, craften. Dokument für mehr Infos lesen." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Saison 1 Woche 1 – 17. März – Heroisch-Woche",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "LFR für Tier-Teile machen (Guide lesen warum)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Welttour der M0-Dungeons abschließen – Champion-Gs" },
            { id = "complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "4x Albtraum-Beute für Champion-Ausrüstung und Ansehen abschließen." },
            { id = "kill_world_boss_for_champ_2_6_250_ilvl_item", text = "Weltboss töten für Champion 2/6 250-Gs-Item" },
            { id = "if_available_complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Falls verfügbar: PvP-Quest für garantierten Helden-Hals/-Ring abschließen" },
            { id = "do_t8_bountiful_delves_with_coffer_keys_use_map_on_t8_delve", text = "T8-Üppige Tiefen mit Truhen-Schlüsseln machen, Karte bei T8+-Tiefen nutzen" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Vor dem Schlachtzug: 2x 246-Gs-Teile craften, 2x Verzierungen in schwache Slots, 160 Veteran-Wappen nutzen" },
            { id = "before_raid_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Vor dem Schlachtzug: alle Abenteurer-, Veteran- und Champion-Wappen für Upgrades ausgeben" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Wappen tracken: 0/100 Heroisch, 0/100 Mythisch" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Woche 2 – 24. März – Mythisch-Woche, M+ öffnet, nehmt Urlaub Nerds",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "1h_crafted_note_check_guide_check_craft_path_info_very_important", text = "1H-Craft-Hinweis, Guide lesen, Craftpfad-Info prüfen (SEHR WICHTIG!)" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "LFR für Tier-Teile machen (Guide lesen warum)" },
            { id = "optional_kill_world_boss_for_champ_2_6_250_ilvl_item", text = "(Optional) Weltboss töten für Champion 2/6 250-Gs-Item" },
            { id = "optional_complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "(Optional) 4x Albtraum-Beute für Champion-Ausrüstung und Ansehen abschließen." },
            { id = "do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Mindestens einen T11 für den Zerbrochener-Schlussstein-Quest machen" },
            { id = "continue_to_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Weiterhin alle Abenteurer-, Veteran- und Champion-Wappen für Upgrades ausgeben" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "+10er farmen für 266-Ausrüstung in jedem Slot" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Vor dem Mythisch-Schlachtzug: 11x 3/6-Heldenteile je einmal aufwerten" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mythisch: Falls du ein Mythen-Spur-Item hast, Upgrade-Tipps der nächsten Woche dafür nutzen." },
            { id = "track_crests_220_220_heroic_0_220_mythic_never_hold_mythic_crests", text = "Wappen tracken: 220/220 Heroisch, 0/220 Mythisch – Mythen-Wappen nie horten" },
            { id = "ending_item_level_4x266_11x269", text = "Abschluss-Gs: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Woche 3 – 31. März – Letzter Schlachtzug öffnet",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Große Schatzkammer öffnen (272+ Mythisch-Item) – nach dem Craften aufwerten" },
            { id = "craft_items_see_guide_for_2_paths_to_pick", text = "Items craften – Guide für 2 auswählbare Pfade lesen" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Falls kein 4p: LFR für Tier-Teile machen (Guide lesen warum)" },
            { id = "farm_10s_for_vault_crests", text = "+10er farmen für Große Schatzkammer + Wappen" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroisch: 2 deiner 4/6-269-Items auf 6/6 276 für 80 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 für 20 Heroisch-Wappen. Dann 1/6 272 Mythen-Spur auf 6/6 289 für 80 Mythen-Wappen." },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Falls 2. Mythen-Spur-Item: Upgrade-Tipps der nächsten Woche dafür nutzen." },
            { id = "track_crests_320_320_heroic_160_320_mythic_never_hold_mythic_crests", text = "Wappen tracken: 320/320 Heroisch, 160/320 Mythisch – Mythen-Wappen nie horten" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Abschluss-Gs: 3x266, 8x269, 2x276h, 1x285(gecraftet), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Woche 4 – 7. Apr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Große Schatzkammer öffnen (272+ Mythisch-Item)" },
            { id = "farm_10s_for_vault_crests", text = "+10er farmen für Große Schatzkammer + Wappen" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroisch: 2 deiner 4/6-269-Items auf 6/6 276 für 80 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 für 20 Heroisch-Wappen. Dann 1/6 272 Mythen-Spur auf 6/6 289 für 80 Mythen-Wappen." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythisch: Schlachtzug-Drop 2/6 275 Mythen-Spur auf 6/6 289 für 80 Mythen-Wappen aufwerten." },
            { id = "track_crests_420_400_heroic_320_420_mythic_never_hold_mythic_crests", text = "Wappen tracken: 420/400 Heroisch, 320/420 Mythisch – Mythen-Wappen nie horten" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Abschluss-Gs: 2x266, 5x269, 4x276h, 1x285(gecraftet), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Woche 5 – 14. Apr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Große Schatzkammer öffnen (272+ Mythisch-Item)" },
            { id = "farm_10s_for_vault_crests", text = "+10er farmen für Große Schatzkammer + Wappen" },
            { id = "craft_next_item_see_doc_for_more_info", text = "Nächstes Item craften (Dokument für mehr Infos lesen)" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroisch: 2 deiner 4/6-269-Items auf 6/6 276 für 80 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 für 20 Heroisch-Wappen. Dann 1/6 272 Mythen-Spur auf 6/6 289 für 80 Mythen-Wappen." },
            { id = "track_crests_520_520_heroic_480_520_mythic_never_hold_mythic_crests", text = "Wappen tracken: 520/520 Heroisch, 480/520 Mythisch – Mythen-Wappen nie horten" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Abschluss-Gs: 1x266, 2x269, 6x276h, 2x285(gecraftet), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Woche 6 – 21. Apr. – Fertig mit Heroisch-Wappen",
        items = {
            { id = "open_vault_272_myth_item", text = "Große Schatzkammer öffnen (272+ Mythisch-Item)" },
            { id = "farm_10s_for_vault_crests", text = "+10er farmen für Große Schatzkammer + Wappen" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Heroisch: Letztes 4/6-269-Item auf 6/6 276 für 40 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 für 20 Heroisch-Wappen. Dann 1/6 272 Mythen-Spur auf 6/6 289 für 80 Mythen-Wappen." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythisch: Schlachtzug-Drop 2/6 275 Mythen-Spur auf 6/6 289 für 80 Mythen-Wappen aufwerten." },
            { id = "track_crests_560_620_heroic_620_620_mythic_never_hold_mythic_crests", text = "Wappen tracken: 560/620 Heroisch, 620/620 Mythisch – Mythen-Wappen nie horten" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Abschluss-Gs: 7x276h, 2x285(gecraftet), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Woche 7 – 28. Apr.+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Nicht craften wenn Items der Großen Schatzkammer besser als 1/6 möglich" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Mythisch-Items sofort aufwerten, bevorzugt auf 289 für den +4-Sprung" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Möglichen 1H + gecrafteten Nebenwaffenwechsel planen" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Blizzards viel besseres Upgrade-System genießen!" },
        },
    },
}

reg.data[LOCALE] = DATASET

