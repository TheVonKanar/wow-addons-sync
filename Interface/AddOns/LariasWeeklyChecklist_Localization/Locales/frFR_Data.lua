--[[
French (frFR) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]
if GetLocale() ~= "frFR" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

local LOCALE = "frFR"

local LOCALE_REGISTRY_KEY = "LARIASWEEKLYCHECKLIST_LOCALE_REGISTRY"

local reg = _G[LOCALE_REGISTRY_KEY]
if type(reg) ~= "table" then
    reg = {}
    _G[LOCALE_REGISTRY_KEY] = reg
end
if type(reg.data) ~= "table" then reg.data = {} end

-- ⚠️ TERMES MIDNIGHT NON VÉRIFIÉS – Vérifier en jeu avant de publier :
--   Mode Guerre (Warmode), FLN = Foire de la Lune Noire (DMF),
--   Soirée de Saltheril (Saltheril's Soiree), Bois des Chants éternels (Eversong Woods),
--   Événement d'abondance (Abundance Event), Légendes des Haranir (Legends of the Haranir),
--   Harandar, Assaut de Stormarion (Stormarion Assault), Tempête du néant (Voidstorm),
--   La Singularité (The Singularity), Pierre runique fissurée (Cracked Keystone),
--   clés de coffre (Coffer keys)
local DATASET = {

    {
        id = "early_access_feb_26_through_mar_2_pay_to_win",
        title = "Accès anticipé – 26 fév. au 2 mars – Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun Écu avant d'en recevoir l'instruction" },
            { id = "level_characters_warmode_on_to_90_dmf_opens_sunday_for_10_more_exp", text = "Montez vos personnages en Mode Guerre au niveau 90 – la FLN ouvre dimanche pour +10 % d'XP" },
            { id = "if_available_complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Si disponible, complétez la Soirée de Saltheril hebdo dans les Bois des Chants éternels avec le buff FLN." },
            { id = "if_available_complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Si disponible, complétez l'Événement d'abondance hebdo dans Zul'Aman avec le buff FLN." },
            { id = "if_available_complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Si disponible, complétez l'événement Légendes des Haranir hebdo à Harandar avec le buff FLN." },
            { id = "if_available_complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Si disponible, complétez l'Assaut de Stormarion hebdo dans la Tempête du néant avec le buff FLN." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Optionnel) Tuez chaque créature rare une fois par zone pour de la renommée. Chaque rare a un blocage hebdomadaire." },
            { id = "complete_4x_prey_on_normal_difficulty_for_veteran_gear", text = "Complétez 4 fois la Traque en difficulté normale pour de l'équipement vétéran." },
            { id = "once_dmf_opens_complete_side_quest_chains_for_renown_can_be_done_on_alts_to_level_at_same_time", text = "À l'ouverture de la FLN, complétez les chaînes de quêtes secondaires pour la renommée. (Peut être fait sur les alts en levant en même temps)" },
            { id = "unlikely_see_doc_for_info_complete_a_world_tour_of_m0_s_after_full_release_but_before_your_region_s_reset", text = "(Peu probable, voir doc) Effectuez un tour du monde des M0 après le lancement complet, avant la réinitialisation de votre région" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pré-saison semaine 1 – 3 mars – M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun Écu avant d'en recevoir l'instruction" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Montez la renommée de La Singularité au rang 7 pour une babiole champion 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Montez la renommée de Hara'ti au rang 8 pour une ceinture champion 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Montez la renommée de Lune-d'Argent au rang 9 pour un casque champion 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Montez la renommée de la tribu Amani au rang 9 pour un collier champion 1/6" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Complétez la Soirée de Saltheril hebdo dans les Bois des Chants éternels avec le buff FLN." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Complétez l'Événement d'abondance hebdo dans Zul'Aman avec le buff FLN." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Complétez l'événement Légendes des Haranir hebdo à Harandar avec le buff FLN." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Complétez l'Assaut de Stormarion hebdo dans la Tempête du néant avec le buff FLN." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Optionnel) Tuez chaque rare une fois par zone pour de la renommée. Blocage hebdomadaire par rare." },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Débloquez les Gouffres jusqu'au niveau 8 (11 si disponible)" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Optionnel) Complétez 4 fois la Traque normale pour équipement aventure et renommée." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Complétez 4 fois la Traque difficile pour équipement vétéran et renommée." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Effectuez un tour mondial des donjons M0 – récompense niv. obj. vétéran – n'améliorez pas encore" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pré-saison semaine 2 – 10 mars – M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun Écu avant d'en recevoir l'instruction" },
            { id = "if_not_completed_continue_to_raise_renown_for_champion_pieces", text = "Si pas terminé, continuez à augmenter la renommée pour les pièces champion" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods", text = "Complétez la Soirée de Saltheril hebdo dans les Bois des Chants éternels." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman", text = "Complétez l'Événement d'abondance hebdo dans Zul'Aman." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar", text = "Complétez l'événement Légendes des Haranir hebdo à Harandar." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm", text = "Complétez l'Assaut de Stormarion hebdo dans la Tempête du néant." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Optionnel) Tuez chaque rare une fois par zone pour de la renommée. Blocage hebdomadaire par rare." },
            { id = "unlock_delves_through_tier_8_11_if_available_if_not_done_yet", text = "Débloquez les Gouffres jusqu'au niveau 8 (11 si disponible), si pas encore fait" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Optionnel) Complétez 4 fois la Traque normale pour équipement aventure et renommée." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Complétez 4 fois la Traque difficile pour équipement vétéran et renommée." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Effectuez un tour mondial des donjons M0 – récompense niv. obj. vétéran – n'améliorez pas encore" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Si vous raidez le mardi 17, fabriquez. Consultez le document pour plus d'informations." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Saison 1 semaine 1 – 17 mars – Semaine héroïque",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun Écu avant d'en recevoir l'instruction" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faites le LFR pour les pièces de palier (consultez le guide pour savoir pourquoi)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Effectuez un tour mondial des donjons M0 – récompense niv. obj. champion" },
            { id = "complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "Complétez 4 fois la Traque de cauchemar pour équipement champion et renommée." },
            { id = "kill_world_boss_for_champ_2_6_250_ilvl_item", text = "Tuez le boss mondial pour un objet champion 2/6 niv. 250" },
            { id = "if_available_complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Si disponible, complétez la quête JcJ pour un collier/anneau héroïque garanti" },
            { id = "do_t8_bountiful_delves_with_coffer_keys_use_map_on_t8_delve", text = "Faites des Gouffres abondants T8 avec des clés de coffre, utilisez la carte sur les Gouffres T8+" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Avant le raid : fabriquez 2 pièces niv. 246, 2 embellissements sur les emplacements faibles, utilisez 160 Écus de vétéran" },
            { id = "before_raid_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Avant le raid : dépensez tous les Écus d'aventure, de vétéran et de champion pour tout améliorer" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Suivi des Écus : 0/100 Héroïque, 0/100 Mythique" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Semaine 2 – 24 mars – Semaine mythique, M+ ouvre, prenez des congés les nerds",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Ne dépensez aucun Écu avant d'en recevoir l'instruction" },
            { id = "1h_crafted_note_check_guide_check_craft_path_info_very_important", text = "Note arme fabriquée 1M, consultez le guide, vérifiez le chemin de fabrication (TRÈS IMPORTANT !)" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faites le LFR pour les pièces de palier (consultez le guide pour savoir pourquoi)" },
            { id = "optional_kill_world_boss_for_champ_2_6_250_ilvl_item", text = "(Optionnel) Tuez le boss mondial pour un objet champion 2/6 niv. 250" },
            { id = "optional_complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "(Optionnel) Complétez 4 fois la Traque de cauchemar pour équipement champion et renommée." },
            { id = "do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Faites au moins un T11 pour obtenir la quête de la Pierre runique fissurée" },
            { id = "continue_to_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Continuez à dépenser tous les Écus d'aventure, de vétéran et de champion pour tout améliorer" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farmez les +10 pour l'équipement niv. 266 dans chaque emplacement" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Avant le raid mythique : améliorez 11 objets héroïques 3/6 une fois chacun" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mythique : si vous avez un objet de piste mythique, passez aux conseils d'amélioration de la semaine suivante." },
            { id = "track_crests_220_220_heroic_0_220_mythic_never_hold_mythic_crests", text = "Suivi des Écus : 220/220 Héroïque, 0/220 Mythique – ne jamais conserver d'Écus mythiques" },
            { id = "ending_item_level_4x266_11x269", text = "Niveau d'objet final : 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Semaine 3 – 31 mars – Le raid final ouvre",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Ouvrez la Grande Chambre Forte (objet mythique 272+) – améliorez après fabrication" },
            { id = "craft_items_see_guide_for_2_paths_to_pick", text = "Fabriquez des objets – consultez le guide pour 2 choix de parcours" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Sans bonus 4 pièces, faites le LFR pour les pièces de palier (consultez le guide)" },
            { id = "farm_10s_for_vault_crests", text = "Farmez les +10 pour la Grande Chambre Forte + Écus" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 269 4/6 à 276 6/6 pour 80 Écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de la Grande Chambre Forte était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 Écus héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 Écus mythiques." },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Si vous obtenez un 2e objet de piste mythique, passez aux conseils d'amélioration de la semaine suivante." },
            { id = "track_crests_320_320_heroic_160_320_mythic_never_hold_mythic_crests", text = "Suivi des Écus : 320/320 Héroïque, 160/320 Mythique – ne jamais conserver d'Écus mythiques" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Niveau d'objet final : 3x266, 8x269, 2x276h, 1x285(fabriqué), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Semaine 4 – 7 avr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrez la Grande Chambre Forte (objet mythique 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farmez les +10 pour la Grande Chambre Forte + Écus" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 269 4/6 à 276 6/6 pour 80 Écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de la Grande Chambre Forte était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 Écus héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 Écus mythiques." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythique : améliorez votre butin de raid de piste mythique 275 2/6 à 6/6 289 pour 80 Écus mythiques." },
            { id = "track_crests_420_400_heroic_320_420_mythic_never_hold_mythic_crests", text = "Suivi des Écus : 420/400 Héroïque, 320/420 Mythique – ne jamais conserver d'Écus mythiques" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Niveau d'objet final : 2x266, 5x269, 4x276h, 1x285(fabriqué), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Semaine 5 – 14 avr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrez la Grande Chambre Forte (objet mythique 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farmez les +10 pour la Grande Chambre Forte + Écus" },
            { id = "craft_next_item_see_doc_for_more_info", text = "Fabriquez le prochain objet (consultez le document pour plus d'informations)" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Héroïque : améliorez 2 de vos objets 269 4/6 à 276 6/6 pour 80 Écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de la Grande Chambre Forte était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 Écus héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 Écus mythiques." },
            { id = "track_crests_520_520_heroic_480_520_mythic_never_hold_mythic_crests", text = "Suivi des Écus : 520/520 Héroïque, 480/520 Mythique – ne jamais conserver d'Écus mythiques" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Niveau d'objet final : 1x266, 2x269, 6x276h, 2x285(fabriqué), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Semaine 6 – 21 avr. – Écus héroïques épuisés",
        items = {
            { id = "open_vault_272_myth_item", text = "Ouvrez la Grande Chambre Forte (objet mythique 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farmez les +10 pour la Grande Chambre Forte + Écus" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Héroïque : améliorez votre dernier objet 269 4/6 à 276 6/6 pour 40 Écus héroïques" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mythique : si votre objet de la Grande Chambre Forte était 1/6, améliorez d'abord son équivalent héroïque à 6/6 pour 20 Écus héroïques. Améliorez ensuite votre objet de piste mythique 272 1/6 à 6/6 289 pour 80 Écus mythiques." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mythique : améliorez votre butin de raid de piste mythique 275 2/6 à 6/6 289 pour 80 Écus mythiques." },
            { id = "track_crests_560_620_heroic_620_620_mythic_never_hold_mythic_crests", text = "Suivi des Écus : 560/620 Héroïque, 620/620 Mythique – ne jamais conserver d'Écus mythiques" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Niveau d'objet final : 7x276h, 2x285(fabriqué), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Semaine 7 – 28 avr.+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Ne fabriquez pas si vous pouvez obtenir des objets de la Grande Chambre Forte supérieurs à 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Améliorez les objets mythiques au fur et à mesure, en privilégiant le saut à 289 pour le bonus +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Planifiez un éventuel échange 1M + main secondaire fabriquée" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Profitez du bien meilleur système d'amélioration de Blizzard !" },
        },
    },
}

reg.data[LOCALE] = DATASET

