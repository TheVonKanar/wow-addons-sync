--[[
French (frFR) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]

local LOCALE = "frFR"

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
        title = "Accès anticipé - 26 fév. au 2 mars - Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucune Crête avant d'en recevoir l'instruction" },
            { id = "level_characters_to_90_dmf_opens_sunday_for_10_more_exp", text = "Montez vos personnages au niveau 90 - la Foire de la Lune Noire ouvre dimanche pour +10 % d'XP" },
            { id = "after_sunday_use_dmf_buff_to_raise_renowns_see_week_1", text = "Après dimanche, utilisez le buff de la Foire pour augmenter les renommées (voir semaine 1)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Complétez les événements hebdomadaires disponibles. (À confirmer, sera ajouté au fur et à mesure)" },
            { id = "if_prey_can_be_upgraded_do_so_as_nightmare_preys_might_give_champ_pieces", text = "Si la Proie peut être améliorée, faites-le : les Proies de Cauchemar peuvent donner des pièces de champion" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pré-saison semaine 1 - 3 mars - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucune Crête avant d'en recevoir l'instruction" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Montez la renommée de La Singularité au rang 7 pour une babiole de champion 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Montez la renommée de Hara'ti au rang 8 pour une ceinture de champion 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Montez la renommée de Lune-d'Argent au rang 9 pour un casque de champion 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Montez la renommée de la tribu Amani au rang 9 pour un collier de champion 1/6" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Débloquez les Plongées jusqu'au niveau 8 (11 si disponible)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Complétez les événements hebdomadaires disponibles. (À confirmer, sera ajouté au fur et à mesure)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Proie donne des récompenses utiles, faites-la (peut donner des pièces de champion en Cauchemar)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Faites les quêtes mondiales qui donnent des améliorations d'équipement" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Effectuez un tour du monde des donjons M0 - récompense niveau d'objet vétéran - n'améliorez pas encore" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Rejoignez la file pour les donjons héroïques pour les emplacements restants" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pré-saison semaine 2 - 10 mars - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucune Crête avant d'en recevoir l'instruction" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Débloquez les Plongées jusqu'au niveau 8 (11 si disponible)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Complétez les événements hebdomadaires disponibles. (À confirmer, sera ajouté au fur et à mesure)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Proie donne des récompenses utiles, faites-la (peut donner des pièces de champion en Cauchemar)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Faites les quêtes mondiales qui donnent des améliorations d'équipement" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade", text = "Effectuez un tour du monde des donjons M0 - récompense niveau d'objet vétéran - n'améliorez pas" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Rejoignez la file pour les donjons héroïques pour les emplacements restants" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Si vous raidez le mardi 17, fabriquez. Consultez le document pour plus d'informations." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Saison 1 semaine 1 - 17 mars - Semaine héroïque",
        items = {
            { id = "do_not_spend_heroic_or_mythic_crests", text = "NE dépensez PAS les crêtes héroïques ou mythiques" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faites le LFR pour les pièces de palier (consultez le guide pour savoir pourquoi)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Effectuez un tour du monde des donjons M0 - récompense niveau d'objet champion" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Tuez le boss mondial pour le niveau d'objet champion" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Faites des plongées généreuses de haut niveau avec des clés de coffre, utilisez la carte si possible" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Proie donne des récompenses utiles, faites-la (peut donner des pièces de champion en Cauchemar)" },
            { id = "complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Complétez la quête JcJ pour un collier/anneau héroïque garanti" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Avant le raid : fabriquez 2 pièces niv. 246, 2 embellissements sur les emplacements faibles, utilisez 160 crêtes de vétéran" },
            { id = "before_raid_spend_all_veteran_and_champion_crests_upgrading_everything", text = "Avant le raid : dépensez toutes les crêtes vétéran et champion pour tout améliorer" },
            { id = "complete_your_raids", text = "Complétez vos raids" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Suivi des crêtes : 0/100 Héroïque, 0/100 Mythique" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Semaine 2 - 24 mars - Semaine mythique, M+ ouvre, prenez des congés les nerds",
        items = {
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faites le LFR pour les pièces de palier (consultez le guide pour savoir pourquoi)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Tuez le boss mondial pour le niveau d'objet champion" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Faites des plongées généreuses de haut niveau avec des clés de coffre, utilisez la carte si possible" },
            { id = "even_if_you_skip_delves_do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Même si vous sautez les Plongées, faites au moins un niveau 11 pour la quête de la Pierre de Keystonecracquée" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farmez les +10 pour l'équipement niv. 266 dans chaque emplacement" },
            { id = "1h_crafted_note_check_guide_ignore_if_you_don_t_dual_wield", text = "Note sur l'arme à 1M fabriquée, consultez le guide (ignorez si vous ne combattez pas à deux armes)" },
            { id = "full_clear_normal_and_heroic", text = "Effacez entièrement le Normal et l'Héroïque" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Avant le raid mythique : améliorez 11 objets héroïques 3/6 une fois chacun" },
            { id = "enjoy_mythic_progression", text = "Profitez de la progression mythique !" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mythique : si vous avez de la chance et obtenu un objet de piste mythique, passez aux conseils d'amélioration de la semaine suivante." },
            { id = "track_crests_220_220_heroic_0_220_mythic", text = "Suivi des crêtes : 220/220 Héroïque, 0/220 Mythique" },
            { id = "ending_item_level_4x266_11x269", text = "Niveau d'objet final : 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Semaine 3 - 31 mars - Le raid final ouvre",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Ouvrez le Grand Coffre (objet mythique 272+) - améliorez après fabrication" },
            { id = "craft_2h_mythic_weapon_5_6_285_see_note_in_text_guide", text = "Fabriquez une arme mythique à 2M (5/6 285) - consultez la note dans le guide texte" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Sans bonus 4 pièces, faites le LFR pour les pièces de palier (consultez le guide)" },
            { id = "farm_12s_for_vault_crests", text = "Farmez les +12 pour le Grand Coffre + crêtes" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 269 4/6 à 276 6/6 pour 80 crêtes héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet du Grand Coffre était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 crêtes héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 crêtes mythiques." },
            { id = "full_clear_normal_heroic_and_do_as_much_of_mythic_as_you_can", text = "Effacez entièrement le Normal et l'Héroïque, et progressez le plus possible en Mythique" },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Si vous obtenez un 2e objet de piste mythique, passez aux conseils d'amélioration de la semaine suivante." },
            { id = "track_crests_320_320_heroic_160_320_mythic", text = "Suivi des crêtes : 320/320 Héroïque, 160/320 Mythique" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Niveau d'objet final : 3x266, 8x269, 2x276h, 1x285(fabriqué), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Semaine 4 - 7 avr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrez le Grand Coffre (objet mythique 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farmez les +12 pour le Grand Coffre + crêtes" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 269 4/6 à 276 6/6 pour 80 crêtes héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet du Grand Coffre était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 crêtes héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 crêtes mythiques." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythique : améliorez votre butin de raid de piste mythique 275 2/6 à 6/6 289 pour 80 crêtes mythiques." },
            { id = "track_crests_420_400_heroic_320_420_mythic", text = "Suivi des crêtes : 420/400 Héroïque, 320/420 Mythique" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Niveau d'objet final : 2x266, 5x269, 4x276h, 1x285(fabriqué), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Semaine 5 - 14 avr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrez le Grand Coffre (objet mythique 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farmez les +12 pour le Grand Coffre + crêtes" },
            { id = "craft_2nd_embellishment_at_285_ilvl_mythic_for_80_myth_crests", text = "Fabriquez le 2e embellissement au niv. 285 Mythique pour 80 crêtes mythiques" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 269 4/6 à 276 6/6 pour 80 crêtes héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet du Grand Coffre était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 crêtes héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 crêtes mythiques." },
            { id = "track_crests_520_520_heroic_480_520_mythic", text = "Suivi des crêtes : 520/520 Héroïque, 480/520 Mythique" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Niveau d'objet final : 1x266, 2x269, 6x276h, 2x285(fabriqué), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Semaine 6 - 21 avr. - Terminé avec les crêtes héroïques",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrez le Grand Coffre (objet mythique 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farmez les +12 pour le Grand Coffre + crêtes" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Héroïque : améliorez votre dernier objet 269 4/6 à 276 6/6 pour 40 crêtes héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet du Grand Coffre était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 crêtes héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 crêtes mythiques." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythique : améliorez votre butin de raid de piste mythique 275 2/6 à 6/6 289 pour 80 crêtes mythiques." },
            { id = "track_crests_560_620_heroic_620_620_mythic", text = "Suivi des crêtes : 560/620 Héroïque, 620/620 Mythique" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Niveau d'objet final : 7x276h, 2x285(fabriqué), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Semaine 7 - 28 avr.+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Ne fabriquez pas si vous pouvez obtenir des objets du Grand Coffre supérieurs à 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Améliorez les objets mythiques au fur et à mesure, en privilégiant le saut à 289 pour le bonus +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Planifiez un éventuel échange 1M + main secondaire fabriquée" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Profitez du bien meilleur système d'amélioration de Blizzard !" },
        },
    },
}

reg.data[LOCALE] = DATASET

