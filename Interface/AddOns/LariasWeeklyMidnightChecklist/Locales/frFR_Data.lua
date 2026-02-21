--[[
Localization (checklist data)

This file provides the default (enUS) checklist data.
To add a new language:
1) Copy Locales\\enUS.lua -> Locales\\<locale>.lua (example: Locales\\deDE.lua)
2) Copy Locales\\enUS_Data.lua -> Locales\\<locale>_Data.lua (example: Locales\\deDE_Data.lua)
3) In both copies, change the locale string ("enUS") to your locale ("deDE")
4) Translate section titles and item text in the _Data file
5) Add BOTH files to LariasWeeklyMidnightChecklist.toc AFTER the enUS entries

Common locale codes: enUS, enGB, frFR, deDE, esES, esMX, itIT, ptBR, ruRU, koKR, zhCN, zhTW
]]

local addonName = ...
local locale = (GetLocale and GetLocale()) or nil
local LOCALE = "frFR"
local listKey = addonName .. "_LIST_DATA"

if locale == LOCALE or type(_G[listKey]) ~= "table" then
_G[listKey] = {

    {
        id = "early_access_feb_26_through_mar_2_pay_to_win",
        title = "Accès anticipé - du 26 février au 2 mars - Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun écu jusqu'à ce qu'on vous le demande." },
            { id = "level_characters_to_90_dmf_opens_sunday_for_10_more_exp", text = "Montez des personnages jusqu'au niveau 90 - La Foire de Sombrelune ouvre dimanche pour 10% d'expérience en plus" },
            { id = "after_sunday_use_dmf_buff_to_raise_renowns_see_week_1", text = "Après dimanche, utilisez le buff de la foire pour augmenter la réputation (voir semaine 1)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Terminez les événements hebdomadaires si disponibles. (à déterminer, j'ajouterai au fur et à mesure que nous les recevrons)" },
            { id = "if_prey_can_be_upgraded_do_so_as_nightmare_preys_might_give_champ_pieces", text = "Si la Traque peut être améliorée, faites-le car les Traques Cauchemar pourraient donner des pièces de champion." },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pre-Season Week 1 - March 3 - M0's",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun écu jusqu'à ce qu'on vous le demande." },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Augmentez la réputation de Singularité au rang 7 pour un bijou de champion 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Augmentez la réputation de Hara'ti au rang 8 pour une ceinture de champion 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Augmentez la réputation de Lune-d'Argent au rang 9 pour un casque de champion 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Augmentez la réputation de la Tribu des Amani au rang 9 pour un collier de champion 1/6" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Débloquez les Gouffres jusqu'au niveau 8 (11 si disponible)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Terminez les événements hebdomadaires si disponibles. (à déterminer, j'ajouterai au fur et à mesure que nous les recevrons)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Traque donne des récompenses utiles, faites-le (pourrait donner des pièces de champion en Cauchemar)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Faites des expéditions qui donnent de meilleurs équipements" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Faites le tour des donjons M0 (récompense de niveau vétéran). Ne pas encore améliorer." },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Faites des donjons héroïques pour les emplacements restants" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pre-Season Week 2 - March 10 - M0's",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun écu jusqu'à ce qu'on vous le demande." },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Débloquez les gouffres jusqu'au niveau 8 (11 si disponible)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Terminez les événements hebdomadaires si disponibles. (à déterminer, j'ajouterai au fur et à mesure que nous les recevrons)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Traque donne des récompenses utiles, faites-le (pourrait donner des pièces de champion en Cauchemar)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Faites des expéditions qui donnent de meilleurs équipements" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade", text = "Faites le tour des donjons M0 (récompense de niveau vétéran). Ne pas encore améliorer." },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Faites des donjons héroïques pour les emplacements restants" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Si vous faites un raid le mercredi 18, craftez. Voir le doc pour plus d'informations." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Season 1 Week 1 - Mar 17 - Heroic Week",
        items = {
            { id = "do_not_spend_heroic_or_mythic_crests", text = "Ne dépensez PAS d'écus héroïques ou mythiques" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faites du LFR pour les pièces de set (consultez le guide pour savoir pourquoi)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Terminez le tour des donjons M0 (récompenses ilvl champion)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Tuer le World Boss pour de l'ilvl champion" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Faites des gouffres abondants de haut niveau avec les clés de coffret, utilisez le butin si possible" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Traque donne des récompenses utiles, faites-le (pourrait donner des pièces de champion en Cauchemar)" },
            { id = "complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Terminez la quête PvP pour un cou/anneau de héros garanti" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Avant le raid, fabriquez 2x pièces à 246 d'ilvl, 2x embellissements sur les emplacements faibles, utilisez 160 écus vétérans." },
            { id = "before_raid_spend_all_veteran_and_champion_crests_upgrading_everything", text = "Avant le raid, dépensez tous les écus de vétéran et de champion pour tout améliorer." },
            { id = "complete_your_raids", text = "Terminez vos raids" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Écus : 0/100 Héroïque, 0/100 Mythique" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Week 2 - Mar 24 - Mythic Week, M+ Opens, take off work giganerds",
        items = {
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faites du LFR pour les pièces de set (consultez le guide pour savoir pourquoi)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Tuer le World Boss pour de l'ilvl champion" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Faites des gouffres abondants de haut niveau avec les clés de coffret, utilisez le butin si possible" },
            { id = "even_if_you_skip_delves_do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Même si vous skippez les gouffres, faites au moins un t11 pour obtenir la quête Clé fêlée" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farm des +10 pour équipements 266 dans chaque emplacement" },
            { id = "1h_crafted_note_check_guide_ignore_if_you_don_t_dual_wield", text = "Craft arme 1 main, consultez le guide (ignorez si vous n'utilisez pas deux armes)" },
            { id = "full_clear_normal_and_heroic", text = "Raids normal et héroïque complétés" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Avant le raid mythique, améliorez 11 objets de héros 3/6 une fois chacun." },
            { id = "enjoy_mythic_progression", text = "Profitez de la progression mythique !" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mythique : si vous avez de la chance et obtenez un élément de set Mythique, passez aux conseils d'amélioration de la semaine prochaine." },
            { id = "track_crests_220_220_heroic_0_220_mythic", text = "Écus: 220/220 Héroïque, 0/220 Mythique" },
            { id = "ending_item_level_4x266_11x269", text = "Prévisions item level: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Week 3 - Mar 31 - Final Raid Opens",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Ouvrir Chambre Forte (objet mythique 272+). Améliorez qu'après avoir craft." },
            { id = "craft_2h_mythic_weapon_5_6_285_see_note_in_text_guide", text = "Craft une arme mythique 2mains (5/6 285) - voir la note dans le guide" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Si pas de 4p, faites du LFR pour les pièces de set (consultez le guide pour savoir pourquoi)" },
            { id = "farm_12s_for_vault_crests", text = "Farm des +12s pour Chambre Forte + écus" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 4/6 269 en 6/6 276 pour 80 écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de Chambre Forte était 1/6, améliorez d'abord son homologue héroïque en 6/6 héroïque pour 20 écus héroïques. Améliorez votre élément de set Mythique 1/6 272 en 6/6 289 pour 80 écus Mythiques." },
            { id = "full_clear_normal_heroic_and_do_as_much_of_mythic_as_you_can", text = "Terminez les raids Normal, Héroïque et faites autant de Mythique que possible" },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Si vous avez obtenu une 2ème pièce de set mythique, passez aux conseils d'amélioration de la semaine prochaine." },
            { id = "track_crests_320_320_heroic_160_320_mythic", text = "Écus: 320/320 Héroïque, 160/320 Mythique" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Prévisions item level : 3x266, 8x269, 2x276h, 1x285(craft), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Week 4 - Apr 7",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrir Chambre Forte (objet mythique 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farm des +12s pour Chambre Forte + écus" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 4/6 269 en 6/6 276 pour 80 écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de Chambre Forte était 1/6, améliorez d'abord son homologue héroïque en 6/6 héroïque pour 20 écus héroïques. Améliorez votre élément de set Mythique 1/6 272 en 6/6 289 pour 80 écus Mythiques." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythique : améliorez votre drop de raid de 2/6 275 piste Mythique à 6/6 289 pour 80 écus Mythiques." },
            { id = "track_crests_420_400_heroic_320_420_mythic", text = "Écus : 420/400 Héroïque, 320/420 Mythique" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Prévisions item level : 2x266, 5x269, 4x276h, 1x285(craft), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Week 5 - Apr 14",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrir Chambre Forte (objet mythique 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farm des +12s pour Chambre Forte + écus" },
            { id = "craft_2nd_embellishment_at_285_ilvl_mythic_for_80_myth_crests", text = "Craft un deuxième embellissement à 285 ilvl Mythique pour 80 écus Mythiques" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 4/6 269 en 6/6 276 pour 80 écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de Chambre Forte était 1/6, améliorez d'abord son homologue héroïque en 6/6 héroïque pour 20 écus héroïques. Améliorez votre élément de set Mythique 1/6 272 en 6/6 289 pour 80 écus Mythiques." },
            { id = "track_crests_520_520_heroic_480_520_mythic", text = "Écus : 520/520 Héroïque, 480/520 Mythique" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Prévisions item level:  1x266, 2x269, 6x276h, 2x285(craft), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Week 6 - Apr 21 - Done with Heroic Crests",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrir Chambre Forte (objet mythique 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farm des +12s pour Chambre Forte + écus" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Héroïque : améliorez votre dernier objet du 4/6 269 au 6/6 276 pour 40 écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de Chambre Forte était 1/6, améliorez d'abord son homologue héroïque en 6/6 héroïque pour 20 écus héroïques. Améliorez votre élément de set Mythique 1/6 272 en 6/6 289 pour 80 écus Mythiques." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythique : améliorez votre drop de raid de 2/6 275 piste Mythique à 6/6 289 pour 80 écus Mythiques." },
            { id = "track_crests_560_620_heroic_620_620_mythic", text = "Écus : 560/620 Héroïque, 620/620 Mythique" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Prévisions item level:  7x276h, 2x285(craft), 1x 285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Week 7 - Apr 28+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Ne craftez pas si vous pouvez obtenir des objets de Chambre Forte supérieurs à 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Améliorez les objets mythiques au fur et à mesure que vous les obtenez, en préférant les passer au niveau 289 pour le saut +4." },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Prévoyez un éventuel échange 1-main + main gauche crafté" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Profitez du bien meilleur système d'amélioration de Blizzard !" },
        },
    },
}
end
