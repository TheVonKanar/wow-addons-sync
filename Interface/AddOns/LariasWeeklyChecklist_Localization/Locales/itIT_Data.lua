--[[
Italian (itIT) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]
if GetLocale() ~= "itIT" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

local LOCALE = "itIT"

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
        title = "Accesso anticipato - dal 26 feb. al 2 mar. - Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Non spendere nessun Emblema finché non ti viene detto" },
            { id = "level_characters_to_90_dmf_opens_sunday_for_10_more_exp", text = "Porta i personaggi al livello 90 - la Fiera della Luna Oscura apre domenica per +10% di esperienza" },
            { id = "after_sunday_use_dmf_buff_to_raise_renowns_see_week_1", text = "Da domenica in poi, usa il bonus della Fiera per aumentare le reputazioni (vedi settimana 1)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Completa gli eventi settimanali se disponibili. (Da definire, verrà aggiunto)" },
            { id = "if_prey_can_be_upgraded_do_so_as_nightmare_preys_might_give_champ_pieces", text = "Se la Preda può essere potenziata, fallo: le Prede da Incubo possono dare pezzi da campione" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pre-stagione settimana 1 - 3 marzo - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Non spendere nessun Emblema finché non ti viene detto" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Porta la reputazione con La Singolarità al grado 7 per il ciondolo campione 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Porta la reputazione con Hara'ti al grado 8 per la cintura campione 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Porta la reputazione con Lunargento al grado 9 per l'elmo campione 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Porta la reputazione con la Tribù Amani al grado 9 per la collana campione 1/6" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Sblocca le Scorribande fino al livello 8 (11 se disponibile)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Completa gli eventi settimanali se disponibili. (Da definire, verrà aggiunto)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Se la Preda dà ricompense utili, falla (può dare pezzi da campione da Incubo)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Fai le missioni mondiali che danno potenziamenti all'equipaggiamento" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Completa un tour mondiale dei dungeon M0 - ricompensa livello oggetto veterano - non potenziare ancora" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Mettiti in coda per i dungeon eroici per gli slot rimanenti" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pre-stagione settimana 2 - 10 marzo - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Non spendere nessun Emblema finché non ti viene detto" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Sblocca le Scorribande fino al livello 8 (11 se disponibile)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Completa gli eventi settimanali se disponibili. (Da definire, verrà aggiunto)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Se la Preda dà ricompense utili, falla (può dare pezzi da campione da Incubo)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Fai le missioni mondiali che danno potenziamenti all'equipaggiamento" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade", text = "Completa un tour mondiale dei dungeon M0 - ricompensa livello oggetto veterano - non potenziare" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Mettiti in coda per i dungeon eroici per gli slot rimanenti" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Se radi martedì 17, crafta. Consulta il documento per ulteriori informazioni." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Stagione 1 settimana 1 - 17 marzo - Settimana eroica",
        items = {
            { id = "do_not_spend_heroic_or_mythic_crests", text = "NON spendere emblemi eroici o mitici" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Fai il LFR per i pezzi tier (controlla la guida per sapere perché)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Completa un tour mondiale dei dungeon M0 - ricompensa livello oggetto campione" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Uccidi il boss mondiale per il livello oggetto campione" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Fai Scorribande generose di alto livello con chiavi del forziere, usa la mappa se possibile" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Se la Preda dà ricompense utili, falla (può dare pezzi da campione da Incubo)" },
            { id = "complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Completa la missione JcJ per collana/anello eroe garantito" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Prima del raid: crafta 2 pezzi liv. 246, 2 ornamenti negli slot deboli, usa 160 emblemi veterano" },
            { id = "before_raid_spend_all_veteran_and_champion_crests_upgrading_everything", text = "Prima del raid: spendi tutti gli emblemi veterano e campione potenziando tutto" },
            { id = "complete_your_raids", text = "Completa i tuoi raid" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Tieni traccia degli emblemi: 0/100 Eroico, 0/100 Mitico" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Settimana 2 - 24 marzo - Settimana mitica, M+ apre, prendetevi ferie nerd",
        items = {
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Fai il LFR per i pezzi tier (controlla la guida per sapere perché)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Uccidi il boss mondiale per il livello oggetto campione" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Fai Scorribande generose di alto livello con chiavi del forziere, usa la mappa se possibile" },
            { id = "even_if_you_skip_delves_do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Anche se salti le Scorribande, fai almeno un livello 11 per la missione della Chiave Incrinata" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farma i +10 per equipaggiamento liv. 266 in ogni slot" },
            { id = "1h_crafted_note_check_guide_ignore_if_you_don_t_dual_wield", text = "Nota sull'arma 1M craftata, controlla la guida (ignora se non usi due armi)" },
            { id = "full_clear_normal_and_heroic", text = "Pulisci completamente Normale ed Eroico" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Prima del raid mitico: potenzia 11 oggetti eroe 3/6 una volta ciascuno" },
            { id = "enjoy_mythic_progression", text = "Goditi la progressione mitica!" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mitico: se hai un oggetto del percorso mitico, passa ai consigli di potenziamento della settimana successiva." },
            { id = "track_crests_220_220_heroic_0_220_mythic", text = "Tieni traccia degli emblemi: 220/220 Eroico, 0/220 Mitico" },
            { id = "ending_item_level_4x266_11x269", text = "Livello oggetto finale: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Settimana 3 - 31 marzo - Apre il raid finale",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Apri la Grande Forziere (oggetto mitico 272+) - potenzia dopo il crafting" },
            { id = "craft_2h_mythic_weapon_5_6_285_see_note_in_text_guide", text = "Crafta l'arma mitica a 2M (5/6 285) - vedi la nota nella guida testuale" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Senza bonus 4 pezzi: fai il LFR per i pezzi tier (controlla la guida)" },
            { id = "farm_12s_for_vault_crests", text = "Farma i +12 per la Grande Forziere + emblemi" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Eroico: potenzia 2 dei tuoi oggetti 269 4/6 a 276 6/6 per 80 emblemi eroici" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mitico: se il tuo oggetto della Grande Forziere era 1/6, potenzia prima la controparte eroica a 6/6 per 20 emblemi eroici. Poi potenzia il tuo oggetto del percorso mitico 272 1/6 a 6/6 289 per 80 emblemi mitici." },
            { id = "full_clear_normal_heroic_and_do_as_much_of_mythic_as_you_can", text = "Pulisci completamente Normale ed Eroico, e avanza il più possibile in Mitico" },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Se hai un 2° oggetto del percorso mitico, passa ai consigli di potenziamento della settimana successiva." },
            { id = "track_crests_320_320_heroic_160_320_mythic", text = "Tieni traccia degli emblemi: 320/320 Eroico, 160/320 Mitico" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Livello oggetto finale: 3x266, 8x269, 2x276h, 1x285(craftato), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Settimana 4 - 7 apr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Apri la Grande Forziere (oggetto mitico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farma i +12 per la Grande Forziere + emblemi" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Eroico: potenzia 2 dei tuoi oggetti 269 4/6 a 276 6/6 per 80 emblemi eroici" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mitico: se il tuo oggetto della Grande Forziere era 1/6, potenzia prima la controparte eroica a 6/6 per 20 emblemi eroici. Poi potenzia il tuo oggetto del percorso mitico 272 1/6 a 6/6 289 per 80 emblemi mitici." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mitico: potenzia il tuo bottino del raid 2/6 275 del percorso mitico a 6/6 289 per 80 emblemi mitici." },
            { id = "track_crests_420_400_heroic_320_420_mythic", text = "Tieni traccia degli emblemi: 420/400 Eroico, 320/420 Mitico" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Livello oggetto finale: 2x266, 5x269, 4x276h, 1x285(craftato), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Settimana 5 - 14 apr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Apri la Grande Forziere (oggetto mitico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farma i +12 per la Grande Forziere + emblemi" },
            { id = "craft_2nd_embellishment_at_285_ilvl_mythic_for_80_myth_crests", text = "Crafta il 2° ornamento a livello oggetto 285 Mitico per 80 emblemi mitici" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Eroico: potenzia 2 dei tuoi oggetti 269 4/6 a 276 6/6 per 80 emblemi eroici" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mitico: se il tuo oggetto della Grande Forziere era 1/6, potenzia prima la controparte eroica a 6/6 per 20 emblemi eroici. Poi potenzia il tuo oggetto del percorso mitico 272 1/6 a 6/6 289 per 80 emblemi mitici." },
            { id = "track_crests_520_520_heroic_480_520_mythic", text = "Tieni traccia degli emblemi: 520/520 Eroico, 480/520 Mitico" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Livello oggetto finale: 1x266, 2x269, 6x276h, 2x285(craftato), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Settimana 6 - 21 apr. - Finite gli emblemi eroici",
        items = {
            { id = "open_vault_272_myth_item", text = "Apri la Grande Forziere (oggetto mitico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farma i +12 per la Grande Forziere + emblemi" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Eroico: potenzia il tuo ultimo oggetto 269 4/6 a 276 6/6 per 40 emblemi eroici" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mitico: se il tuo oggetto della Grande Forziere era 1/6, potenzia prima la controparte eroica a 6/6 per 20 emblemi eroici. Poi potenzia il tuo oggetto del percorso mitico 272 1/6 a 6/6 289 per 80 emblemi mitici." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mitico: potenzia il tuo bottino del raid 2/6 275 del percorso mitico a 6/6 289 per 80 emblemi mitici." },
            { id = "track_crests_560_620_heroic_620_620_mythic", text = "Tieni traccia degli emblemi: 560/620 Eroico, 620/620 Mitico" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Livello oggetto finale: 7x276h, 2x285(craftato), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Settimana 7 - 28 apr.+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Non craftare se puoi ottenere oggetti dalla Grande Forziere superiori a 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Potenzia gli oggetti mitici man mano che li ottieni, preferendo il salto a 289 per il +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Pianifica un possibile scambio a 1M + mano secondaria craftata" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Goditi il sistema di potenziamento molto migliore di Blizzard!" },
        },
    },
}

reg.data[LOCALE] = DATASET

