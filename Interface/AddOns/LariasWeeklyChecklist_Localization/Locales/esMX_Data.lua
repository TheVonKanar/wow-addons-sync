--[[
Spanish (esMX) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]
if GetLocale() ~= "esMX" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

local LOCALE = "esMX"

local LOCALE_REGISTRY_KEY = "LARIASWEEKLYCHECKLIST_LOCALE_REGISTRY"

local reg = _G[LOCALE_REGISTRY_KEY]
if type(reg) ~= "table" then
    reg = {}
    _G[LOCALE_REGISTRY_KEY] = reg
end
if type(reg.data) ~= "table" then reg.data = {} end

-- ⚠️ TÉRMINOS MIDNIGHT NO VERIFICADOS – Verificar en el juego antes de publicar:
--   Modo de Guerra (Warmode), FLN = Feria de la Luna Negra (DMF),
--   Velada de Saltheril (Saltheril's Soiree), Bosques Siempreverd (Eversong Woods),
--   Evento de la abundancia (Abundance Event), Leyendas de los Haranir (Legends of the Haranir),
--   Harandar, Asalto de Tormarión (Stormarion Assault), Tormenta del Vacío (Voidstorm),
--   La Singularidad (The Singularity), Piedra rúnica agrietada (Cracked Keystone),
--   llaves de cofre (Coffer keys)
local DATASET = {

    {
        id = "early_access_feb_26_through_mar_2_pay_to_win",
        title = "Acceso anticipado – 26 feb. al 2 mar. – Paga para ganar",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Crestalborada hasta que se indique" },
            { id = "level_characters_warmode_on_to_90_dmf_opens_sunday_for_10_more_exp", text = "Sube personajes en Modo de Guerra a nivel 90 – la FLN abre el domingo para +10 % de exp." },
            { id = "if_available_complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Si disponible, completa la Velada de Saltheril semanal en los Bosques Siempreverd con el bonus FLN." },
            { id = "if_available_complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Si disponible, completa el Evento de la abundancia semanal en Zul'Aman con el bonus FLN." },
            { id = "if_available_complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Si disponible, completa el evento Leyendas de los Haranir semanal en Harandar con el bonus FLN." },
            { id = "if_available_complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Si disponible, completa el Asalto de Tormarión semanal en la Tormenta del Vacío con el bonus FLN." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Opcional) Mata cada élite raro una vez en cada zona para reputación. Tienen un bloqueo semanal por raro." },
            { id = "complete_4x_prey_on_normal_difficulty_for_veteran_gear", text = "Completa 4 veces la Presa en dificultad normal para equipo de veterano." },
            { id = "once_dmf_opens_complete_side_quest_chains_for_renown_can_be_done_on_alts_to_level_at_same_time", text = "Al abrir la FLN, completa cadenas de misiones secundarias para reputación. (Se puede hacer en alts mientras subes de nivel)" },
            { id = "unlikely_see_doc_for_info_complete_a_world_tour_of_m0_s_after_full_release_but_before_your_region_s_reset", text = "(Poco probable, ver doc) Completa un tour mundial de M0 tras el lanzamiento completo, antes del reinicio de tu región" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pretemporada semana 1 – 3 de marzo – M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Crestalborada hasta que se indique" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Sube la reputación de La Singularidad a rango 7 para abalorio de campeón 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Sube la reputación de Hara'ti a rango 8 para cinturón de campeón 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Sube la reputación de Lunargenta a rango 9 para yelmo de campeón 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Sube la reputación de la Tribu Amani a rango 9 para collar de campeón 1/6" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Completa la Velada de Saltheril semanal en los Bosques Siempreverd con el bonus FLN." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Completa el Evento de la abundancia semanal en Zul'Aman con el bonus FLN." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Completa el evento Leyendas de los Haranir semanal en Harandar con el bonus FLN." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Completa el Asalto de Tormarión semanal en la Tormenta del Vacío con el bonus FLN." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Opcional) Mata cada élite raro una vez en cada zona para reputación. Tienen un bloqueo semanal por raro." },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Desbloquea Profundidades hasta nivel 8 (11 si está disponible)" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Opcional) Completa 4 veces la Presa normal para equipo de aventurero y reputación." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Completa 4 veces la Presa difícil para equipo de veterano y reputación." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Completa un tour mundial de mazmorras M0 – recompensa nivel de objeto veterano – no mejores todavía" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pretemporada semana 2 - 10 de marzo - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Crestalborada hasta que se indique" },
            { id = "if_not_completed_continue_to_raise_renown_for_champion_pieces", text = "Si no completado, continúa subiendo la reputación para piezas de campeón" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods", text = "Completa la Velada de Saltheril semanal en los Bosques Siempreverd." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman", text = "Completa el Evento de la abundancia semanal en Zul'Aman." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar", text = "Completa el evento Leyendas de los Haranir semanal en Harandar." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm", text = "Completa el Asalto de Tormarión semanal en la Tormenta del Vacío." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Opcional) Mata cada élite raro una vez en cada zona para reputación. Tienen un bloqueo semanal por raro." },
            { id = "unlock_delves_through_tier_8_11_if_available_if_not_done_yet", text = "Desbloquea Profundidades hasta nivel 8 (11 si está disponible) si no lo has hecho todavía" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Opcional) Completa 4 veces la Presa normal para equipo de aventurero y reputación." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Completa 4 veces la Presa difícil para equipo de veterano y reputación." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Completa un tour mundial de mazmorras M0 – recompensa nivel de objeto veterano – no mejores todavía" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Si raideas el martes 17, craftea. Mira el documento para más info." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Temporada 1 semana 1 - 17 de marzo - Semana heroica",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Crestalborada hasta que se indique" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Haz LFR para piezas de conjunto (mira la guía para saber por qué)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Completa un tour mundial de M0 - recompensa ilvl campeón" },
            { id = "complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "Completa 4 veces la Presa de Pesadilla para equipo de campeón y reputación." },
            { id = "kill_world_boss_for_champ_2_6_250_ilvl_item", text = "Mata al jefe del mundo para un objeto de campeón 2/6 ilvl 250" },
            { id = "if_available_complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Si disponible, completa la misión JcJ para collar/anillo de héroe garantizado" },
            { id = "do_t8_bountiful_delves_with_coffer_keys_use_map_on_t8_delve", text = "Haz Profundidades abundantes T8 con llaves de cofre; usa mapa en Profundidades T8+" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Antes de raid, craftea 2 piezas ilvl 246, 2 adornos en huecos débiles, usa 160 crestalboradas de veterano" },
            { id = "before_raid_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Antes de raid, gasta todas las crestalboradas de aventurero, veterano y campeón mejorándolo todo" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Seguimiento de crestalboradas: 0/100 Heroicas, 0/100 Míticas" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Semana 2 - 24 de marzo - Semana mítica, abren M+, tómate el día libre giganerd",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Crestalborada hasta que se indique" },
            { id = "1h_crafted_note_check_guide_check_craft_path_info_very_important", text = "Nota de arma 1M crafteada: mira la guía, verifica el camino de crafteo (¡MUY IMPORTANTE!)" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Haz LFR para piezas de conjunto (mira la guía para saber por qué)" },
            { id = "optional_kill_world_boss_for_champ_2_6_250_ilvl_item", text = "(Opcional) Mata al jefe del mundo para un objeto de campeón 2/6 ilvl 250" },
            { id = "optional_complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "(Opcional) Completa 4 veces la Presa de Pesadilla para equipo de campeón y reputación." },
            { id = "do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Haz al menos un t11 para conseguir la misión de Piedra rúnica agrietada" },
            { id = "continue_to_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Continúa gastando todas las crestalboradas de aventurero, veterano y campeón mejorándolo todo" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farmea +10 para equipo 266 en cada hueco" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Antes de banda mítica, mejora 11 objetos de héroe 3/6 una vez cada uno" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mítico: si tienes suerte y consigues un objeto de pista mítica, pasa al consejo de mejoras de la semana que viene para él." },
            { id = "track_crests_220_220_heroic_0_220_mythic_never_hold_mythic_crests", text = "Seguimiento de crestalboradas: 220/220 Heroicas, 0/220 Míticas – no acumules nunca Míticas" },
            { id = "ending_item_level_4x266_11x269", text = "Nivel de objeto final: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Semana 3 - 31 de marzo - Abre la banda final",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Abre la Gran Cámara (objeto mítico 272+) - mejora después de craftear" },
            { id = "craft_items_see_guide_for_2_paths_to_pick", text = "Craftea objetos – mira la guía para 2 caminos a elegir" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Si no tienes 4p, haz LFR para piezas de conjunto (mira la guía para saber por qué)" },
            { id = "farm_10s_for_vault_crests", text = "Farmea +10 para Gran Cámara + crestalboradas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: mejora 2 de tus objetos 269 4/6 a 276 6/6 por 80 crestalboradas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la Gran Cámara era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestalboradas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestalboradas míticas." },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Si conseguiste un 2º objeto de pista mítica, pasa al consejo de mejoras de la semana que viene para él." },
            { id = "track_crests_320_320_heroic_160_320_mythic_never_hold_mythic_crests", text = "Seguimiento de crestalboradas: 320/320 Heroicas, 160/320 Míticas – no acumules nunca Míticas" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Nivel de objeto final: 3x266, 8x269, 2x276h, 1x285(crafteado), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Semana 4 - 7 de abril",
        items = {
            { id = "open_vault_272_myth_item", text = "Abre la Gran Cámara (objeto mítico 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farmea +10 para Gran Cámara + crestalboradas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: mejora 2 de tus objetos 269 4/6 a 276 6/6 por 80 crestalboradas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la Gran Cámara era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestalboradas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestalboradas míticas." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: mejora tu botín de banda 275 de pista mítica 2/6 a 6/6 289 por 80 crestalboradas míticas." },
            { id = "track_crests_420_400_heroic_320_420_mythic_never_hold_mythic_crests", text = "Seguimiento de crestalboradas: 420/400 Heroicas, 320/420 Míticas – no acumules nunca Míticas" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Nivel de objeto final: 2x266, 5x269, 4x276h, 1x285(crafteado), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Semana 5 - 14 de abril",
        items = {
            { id = "open_vault_272_myth_item", text = "Abre la Gran Cámara (objeto mítico 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farmea +10 para Gran Cámara + crestalboradas" },
            { id = "craft_next_item_see_doc_for_more_info", text = "Craftea el siguiente objeto (mira el documento para más info)" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: mejora 2 de tus objetos 269 4/6 a 276 6/6 por 80 crestalboradas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la Gran Cámara era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestalboradas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestalboradas míticas." },
            { id = "track_crests_520_520_heroic_480_520_mythic_never_hold_mythic_crests", text = "Seguimiento de crestalboradas: 520/520 Heroicas, 480/520 Míticas – no acumules nunca Míticas" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Nivel de objeto final: 1x266, 2x269, 6x276h, 2x285(crafteado), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Semana 6 - 21 de abril - Terminado con crestalboradas heroicas",
        items = {
            { id = "open_vault_272_myth_item", text = "Abre la Gran Cámara (objeto mítico 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farmea +10 para Gran Cámara + crestalboradas" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Heroico: mejora tu último objeto 269 4/6 a 276 6/6 por 40 crestalboradas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la Gran Cámara era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestalboradas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestalboradas míticas." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: mejora tu botín de banda 275 de pista mítica 2/6 a 6/6 289 por 80 crestalboradas míticas." },
            { id = "track_crests_560_620_heroic_620_620_mythic_never_hold_mythic_crests", text = "Seguimiento de crestalboradas: 560/620 Heroicas, 620/620 Míticas – no acumules nunca Míticas" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Nivel de objeto final: 7x276h, 2x285(crafteado), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Semana 7 - 28 de abril+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "No craftees si puedes conseguir objetos de la Gran Cámara superiores a 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Mejora los objetos míticos conforme los consigas, priorizando saltarlos a 289 por el salto de +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Planifica un posible cambio a 1M + mano secundaria crafteada" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "¡Disfruta del mucho mejor sistema de mejoras de Blizzard!" },
        },
    },
}

reg.data[LOCALE] = DATASET

