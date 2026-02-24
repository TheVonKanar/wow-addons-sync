--[[
Spanish (esMX) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]

local LOCALE = "esMX"

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
        title = "Acceso anticipado - del 26 de febrero al 2 de marzo - Paga para ganar",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Cresta hasta que se indique" },
            { id = "level_characters_to_90_dmf_opens_sunday_for_10_more_exp", text = "Sube personajes a 90 - la DMF abre el domingo para 10% más de exp" },
            { id = "after_sunday_use_dmf_buff_to_raise_renowns_see_week_1", text = "Después del domingo, usa el beneficio de la DMF para subir reputaciones (ver semana 1)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Completa los eventos semanales si están disponibles. (Por determinar; se añadirá conforme salgan)" },
            { id = "if_prey_can_be_upgraded_do_so_as_nightmare_preys_might_give_champ_pieces", text = "Si la Presa se puede mejorar, hazlo, ya que las Presas de Pesadilla pueden dar piezas de campeón" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pretemporada semana 1 - 3 de marzo - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Cresta hasta que se indique" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Sube la reputación de La Singularidad a rango 7 para abalorio de campeón 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Sube la reputación de Hara'ti a rango 8 para cinturón de campeón 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Sube la reputación de Lunargenta a rango 9 para yelmo de campeón 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Sube la reputación de la Tribu Amani a rango 9 para collar de campeón 1/6" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Desbloquea Delves hasta nivel 8 (11 si está disponible)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Completa los eventos semanales si están disponibles. (Por determinar; se añadirá conforme salgan)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Presa da recompensas útiles, haz la Presa (puede dar piezas de campeón en pesadilla)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Haz misiones del mundo que den mejoras de equipo" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Completa un tour mundial de mazmorras M0 - recompensa ilvl veterano - no mejores todavía" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Haz cola para mazmorras heroicas para los huecos restantes" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pretemporada semana 2 - 10 de marzo - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "No gastes ninguna Cresta hasta que se indique" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Desbloquea Delves hasta nivel 8 (11 si está disponible)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Completa los eventos semanales si están disponibles. (Por determinar; se añadirá conforme salgan)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Presa da recompensas útiles, haz la Presa (puede dar piezas de campeón en pesadilla)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Haz misiones del mundo que den mejoras de equipo" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade", text = "Completa un tour mundial de mazmorras M0 - recompensa ilvl veterano - no mejores" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Haz cola para mazmorras heroicas para los huecos restantes" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Si raideas el martes 17, craftea. Mira el documento para más info." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Temporada 1 semana 1 - 17 de marzo - Semana heroica",
        items = {
            { id = "do_not_spend_heroic_or_mythic_crests", text = "NO gastes crestas heroicas ni míticas" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Haz LFR para piezas de conjunto (mira la guía para saber por qué)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Completa un tour mundial de M0 - recompensa ilvl campeón" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Mata al jefe del mundo para ilvl campeón" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Haz Delves abundantes de alto nivel con llaves de cofre; usa mapa si es posible" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Si la Presa da recompensas útiles, haz la Presa (puede dar piezas de campeón en pesadilla)" },
            { id = "complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Completa la misión JcJ para collar/anillo de héroe garantizado" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Antes de raid, craftea 2 piezas ilvl 246, 2 adornos en huecos débiles, usa 160 crestas de veterano" },
            { id = "before_raid_spend_all_veteran_and_champion_crests_upgrading_everything", text = "Antes de raid, gasta todas las crestas de veterano y campeón mejorándolo todo" },
            { id = "complete_your_raids", text = "Completa tus bandas" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Seguimiento de crestas: 0/100 Heroicas, 0/100 Míticas" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Semana 2 - 24 de marzo - Semana mítica, abren M+, tómate el día libre giganerd",
        items = {
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Haz LFR para piezas de conjunto (mira la guía para saber por qué)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Mata al jefe del mundo para ilvl campeón" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Haz Delves abundantes de alto nivel con llaves de cofre; usa mapa si es posible" },
            { id = "even_if_you_skip_delves_do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Aunque te saltes Delves, haz al menos un t11 para conseguir la misión de Llave de piedra angular agrietada" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farmea +10 para equipo 266 en cada hueco" },
            { id = "1h_crafted_note_check_guide_ignore_if_you_don_t_dual_wield", text = "Nota de arma 1M crafteada: mira la guía (ignora si no llevas doble empuñadura)" },
            { id = "full_clear_normal_and_heroic", text = "Limpieza completa en normal y heroico" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Antes de banda mítica, mejora 11 objetos de héroe 3/6 una vez cada uno" },
            { id = "enjoy_mythic_progression", text = "¡Disfruta de la progresión mítica!" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mítico: si tienes suerte y consigues un objeto de pista mítica, pasa al consejo de mejoras de la semana que viene para él." },
            { id = "track_crests_220_220_heroic_0_220_mythic", text = "Seguimiento de crestas: 220/220 Heroicas, 0/220 Míticas" },
            { id = "ending_item_level_4x266_11x269", text = "Nivel de objeto final: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Semana 3 - 31 de marzo - Abre la banda final",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Abre la bóveda (objeto mítico 272+) - mejora después de craftear" },
            { id = "craft_2h_mythic_weapon_5_6_285_see_note_in_text_guide", text = "Craftea arma 2M mítica (5/6 285) - mira la nota en la guía de texto" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Si no tienes 4p, haz LFR para piezas de conjunto (mira la guía para saber por qué)" },
            { id = "farm_12s_for_vault_crests", text = "Farmea +12 para bóveda + crestas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: mejora 2 de tus objetos 269 4/6 a 276 6/6 por 80 crestas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la bóveda era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestas míticas." },
            { id = "full_clear_normal_heroic_and_do_as_much_of_mythic_as_you_can", text = "Limpieza completa en normal, heroico, y haz todo lo mítico que puedas" },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Si conseguiste un 2º objeto de pista mítica, pasa al consejo de mejoras de la semana que viene para él." },
            { id = "track_crests_320_320_heroic_160_320_mythic", text = "Seguimiento de crestas: 320/320 Heroicas, 160/320 Míticas" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Nivel de objeto final: 3x266, 8x269, 2x276h, 1x285(crafteado), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Semana 4 - 7 de abril",
        items = {
            { id = "open_vault_272_myth_item", text = "Abre la bóveda (objeto mítico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farmea +12 para bóveda + crestas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: mejora 2 de tus objetos 269 4/6 a 276 6/6 por 80 crestas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la bóveda era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestas míticas." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: mejora tu botín de banda 275 de pista mítica 2/6 a 6/6 289 por 80 crestas míticas." },
            { id = "track_crests_420_400_heroic_320_420_mythic", text = "Seguimiento de crestas: 420/400 Heroicas, 320/420 Míticas" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Nivel de objeto final: 2x266, 5x269, 4x276h, 1x285(crafteado), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Semana 5 - 14 de abril",
        items = {
            { id = "open_vault_272_myth_item", text = "Abre la bóveda (objeto mítico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farmea +12 para bóveda + crestas" },
            { id = "craft_2nd_embellishment_at_285_ilvl_mythic_for_80_myth_crests", text = "Craftea el 2º adorno a ilvl 285 mítico por 80 crestas míticas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: mejora 2 de tus objetos 269 4/6 a 276 6/6 por 80 crestas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la bóveda era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestas míticas." },
            { id = "track_crests_520_520_heroic_480_520_mythic", text = "Seguimiento de crestas: 520/520 Heroicas, 480/520 Míticas" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Nivel de objeto final: 1x266, 2x269, 6x276h, 2x285(crafteado), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Semana 6 - 21 de abril - Terminado con crestas heroicas",
        items = {
            { id = "open_vault_272_myth_item", text = "Abre la bóveda (objeto mítico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farmea +12 para bóveda + crestas" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Heroico: mejora tu último objeto 269 4/6 a 276 6/6 por 40 crestas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: si tu objeto de la bóveda era 1/6, mejora primero su equivalente heroico a 6/6 heroico por 20 crestas heroicas. Mejora tu objeto 272 de pista mítica 1/6 a 6/6 289 por 80 crestas míticas." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: mejora tu botín de banda 275 de pista mítica 2/6 a 6/6 289 por 80 crestas míticas." },
            { id = "track_crests_560_620_heroic_620_620_mythic", text = "Seguimiento de crestas: 560/620 Heroicas, 620/620 Míticas" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Nivel de objeto final: 7x276h, 2x285(crafteado), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Semana 7 - 28 de abril+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "No craftees si puedes conseguir objetos de la bóveda superiores a 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Mejora los objetos míticos conforme los consigas, priorizando saltarlos a 289 por el salto de +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Planifica un posible cambio a 1M + mano secundaria crafteada" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "¡Disfruta del mucho mejor sistema de mejoras de Blizzard!" },
        },
    },
}

reg.data[LOCALE] = DATASET

