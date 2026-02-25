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

local DATASET = {

    {
        id = "early_access_feb_26_through_mar_2_pay_to_win",
        title = "Früher Zugang - 26. Feb bis 2. März - Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "level_characters_to_90_dmf_opens_sunday_for_10_more_exp", text = "Charaktere auf Level 90 bringen – DMF öffnet Sonntag für 10 % mehr XP" },
            { id = "after_sunday_use_dmf_buff_to_raise_renowns_see_week_1", text = "Ab Sonntag DMF-Buff nutzen, um Ansehen zu erhöhen (siehe Woche 1)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Wöchentliche Events abschließen, wenn verfügbar. (Wird ergänzt wenn bekannt)" },
            { id = "if_prey_can_be_upgraded_do_so_as_nightmare_preys_might_give_champ_pieces", text = "Beute aufwerten wenn möglich – Albtraum-Beute kann Champion-Teile geben" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Vorsaison Woche 1 - 3. März - M0s",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Ansehen bei Die Singularität auf Rang 7 erhöhen für 1/6-Champion-Schmuckstück" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Ansehen bei Hara'ti auf Rang 8 erhöhen für 1/6-Champion-Gürtel" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Ansehen bei Silbermond auf Rang 9 erhöhen für 1/6-Champion-Helm" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Ansehen beim Amani-Stamm auf Rang 9 erhöhen für 1/6-Champion-Halskette" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Tiefen bis Stufe 8 freischalten (11 falls verfügbar)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Wöchentliche Events abschließen, wenn verfügbar. (Wird ergänzt wenn bekannt)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Beute machen wenn sie nützliche Belohnungen gibt (Albtraum kann Champion-Teile geben)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Weltquests machen, die Ausrüstungsverbesserungen geben" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Welttour der M0-Dungeons abschließen – Veteran-Gs – noch nicht aufwerten" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Für heroische Dungeons einreihen für verbleibende Slots" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Vorsaison Woche 2 - 10. März - M0s",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Keine Wappen ausgeben, bis es angewiesen wird" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Tiefen bis Stufe 8 freischalten (11 falls verfügbar)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Wöchentliche Events abschließen, wenn verfügbar. (Wird ergänzt wenn bekannt)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Beute machen wenn sie nützliche Belohnungen gibt (Albtraum kann Champion-Teile geben)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Weltquests machen, die Ausrüstungsverbesserungen geben" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade", text = "Welttour der M0-Dungeons abschließen – Veteran-Gs – nicht aufwerten" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Für heroische Dungeons einreihen für verbleibende Slots" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Falls du Dienstag den 17. raidest, craften. Dokument für mehr Infos lesen." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Saison 1 Woche 1 - 17. März - Heroisch-Woche",
        items = {
            { id = "do_not_spend_heroic_or_mythic_crests", text = "KEINE heroischen oder mythischen Wappen ausgeben" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "LFR für Tier-Teile machen (Guide lesen warum)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Welttour der M0-Dungeons abschließen – Champion-Gs" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Weltboss für Champion-Gs töten" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Hochstufige ergiebige Tiefen mit Schatztruhen-Schlüsseln, Karte nutzen" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Beute machen wenn sie nützliche Belohnungen gibt (Albtraum kann Champion-Teile geben)" },
            { id = "complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "PvP-Quest für garantierten Helden-Hals/-Ring abschließen" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Vor dem Raid: 2x 246-Gs-Teile craften, 2x Verzierungen in schwache Slots, 160 Veteran-Wappen nutzen" },
            { id = "before_raid_spend_all_veteran_and_champion_crests_upgrading_everything", text = "Vor dem Raid: alle Veteran- und Champion-Wappen für Upgrades ausgeben" },
            { id = "complete_your_raids", text = "Schlachtzüge abschließen" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Wappen tracken: 0/100 Heroisch, 0/100 Mythisch" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Woche 2 - 24. März - Mythisch-Woche, M+ öffnet, nehmt Urlaub Nerds",
        items = {
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "LFR für Tier-Teile machen (Guide lesen warum)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Weltboss für Champion-Gs töten" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Hochstufige ergiebige Tiefen mit Schatztruhen-Schlüsseln, Karte nutzen" },
            { id = "even_if_you_skip_delves_do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Auch ohne Tiefen: mindestens einen T11 für den zerbrochenen Schlussstein-Quest" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "+10er farmen für 266-Ausrüstung in jedem Slot" },
            { id = "1h_crafted_note_check_guide_ignore_if_you_don_t_dual_wield", text = "1H-Craft-Hinweis, Guide lesen (ignorieren wenn kein Beidhänder)" },
            { id = "full_clear_normal_and_heroic", text = "Normal und Heroisch vollständig clearen" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Vor dem Mythisch-Raid: 11x 3/6-Heldenteile je einmal aufwerten" },
            { id = "enjoy_mythic_progression", text = "Mythisch-Progression genießen!" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mythisch: Falls du ein Mythisch-Spur-Item hast, Upgrade-Tipps der nächsten Woche dafür nutzen." },
            { id = "track_crests_220_220_heroic_0_220_mythic", text = "Wappen tracken: 220/220 Heroisch, 0/220 Mythisch" },
            { id = "ending_item_level_4x266_11x269", text = "Abschluss-Gs: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Woche 3 - 31. März - Letzter Raid öffnet",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Große Schatzkammer öffnen (272+ Mythisch-Item) – nach dem Craften aufwerten" },
            { id = "craft_2h_mythic_weapon_5_6_285_see_note_in_text_guide", text = "2H-Mythisch-Waffe craften (5/6 285) – Textguide-Hinweis beachten" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Falls kein 4p: LFR für Tier-Teile machen (Guide lesen warum)" },
            { id = "farm_12s_for_vault_crests", text = "+12er farmen für Große Schatzkammer + Wappen" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroisch: 2 deiner 4/6-269-Items auf 6/6 276 für 80 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 (20 Wappen). Dann 1/6 272 Mythisch-Spur auf 6/6 289 für 80 Mythisch-Wappen." },
            { id = "full_clear_normal_heroic_and_do_as_much_of_mythic_as_you_can", text = "Normal + Heroisch voll clearen, so viel Mythisch wie möglich" },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Falls 2. Mythisch-Spur-Item: Upgrade-Tipps der nächsten Woche dafür nutzen." },
            { id = "track_crests_320_320_heroic_160_320_mythic", text = "Wappen tracken: 320/320 Heroisch, 160/320 Mythisch" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Abschluss-Gs: 3x266, 8x269, 2x276h, 1x285(gecraftet), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Woche 4 - 7. Apr",
        items = {
            { id = "open_vault_272_myth_item", text = "Große Schatzkammer öffnen (272+ Mythisch-Item)" },
            { id = "farm_12s_for_vault_crests", text = "+12er farmen für Große Schatzkammer + Wappen" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroisch: 2 deiner 4/6-269-Items auf 6/6 276 für 80 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 (20 Wappen). Dann 1/6 272 Mythisch-Spur auf 6/6 289 für 80 Mythisch-Wappen." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythisch: Raid-Drop 2/6 275 Mythisch-Spur auf 6/6 289 für 80 Mythisch-Wappen aufwerten." },
            { id = "track_crests_420_400_heroic_320_420_mythic", text = "Wappen tracken: 420/400 Heroisch, 320/420 Mythisch" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Abschluss-Gs: 2x266, 5x269, 4x276h, 1x285(gecraftet), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Woche 5 - 14. Apr",
        items = {
            { id = "open_vault_272_myth_item", text = "Große Schatzkammer öffnen (272+ Mythisch-Item)" },
            { id = "farm_12s_for_vault_crests", text = "+12er farmen für Große Schatzkammer + Wappen" },
            { id = "craft_2nd_embellishment_at_285_ilvl_mythic_for_80_myth_crests", text = "2. Verzierung bei 285-Gs Mythisch für 80 Mythisch-Wappen craften" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroisch: 2 deiner 4/6-269-Items auf 6/6 276 für 80 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 (20 Wappen). Dann 1/6 272 Mythisch-Spur auf 6/6 289 für 80 Mythisch-Wappen." },
            { id = "track_crests_520_520_heroic_480_520_mythic", text = "Wappen tracken: 520/520 Heroisch, 480/520 Mythisch" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Abschluss-Gs: 1x266, 2x269, 6x276h, 2x285(gecraftet), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Woche 6 - 21. Apr - Fertig mit Heroisch-Wappen",
        items = {
            { id = "open_vault_272_myth_item", text = "Große Schatzkammer öffnen (272+ Mythisch-Item)" },
            { id = "farm_12s_for_vault_crests", text = "+12er farmen für Große Schatzkammer + Wappen" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Heroisch: Letztes 4/6-269-Item auf 6/6 276 für 40 Heroisch-Wappen aufwerten" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythisch: Falls Item der Großen Schatzkammer 1/6 war, erst Heroisch-Gegenstück auf 6/6 (20 Wappen). Dann 1/6 272 Mythisch-Spur auf 6/6 289 für 80 Mythisch-Wappen." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythisch: Raid-Drop 2/6 275 Mythisch-Spur auf 6/6 289 für 80 Mythisch-Wappen aufwerten." },
            { id = "track_crests_560_620_heroic_620_620_mythic", text = "Wappen tracken: 560/620 Heroisch, 620/620 Mythisch" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Abschluss-Gs: 7x276h, 2x285(gecraftet), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Woche 7 - 28. Apr+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Nicht craften wenn Items der Großen Schatzkammer besser als 1/6 möglich" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Mythisch-Items sofort aufwerten, bevorzugt auf 289 für den +4-Sprung" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Möglichen 1H + gecrafteten Schildhand-Tausch planen" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Blizzards viel besseres Upgrade-System genießen!" },
        },
    },
}

reg.data[LOCALE] = DATASET

