--[[
Portuguese-Brazil (ptBR) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]

local LOCALE = "ptBR"

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
        title = "Acesso Antecipado - 26 fev. a 2 mar. - Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhuma Crista até receber instruções" },
            { id = "level_characters_to_90_dmf_opens_sunday_for_10_more_exp", text = "Suba personagens ao nível 90 - a Feira da Lua Negra abre no domingo com +10% de EXP" },
            { id = "after_sunday_use_dmf_buff_to_raise_renowns_see_week_1", text = "Depois do domingo use o bônus da Feira para aumentar reputações (veja semana 1)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Complete eventos semanais se disponíveis (a confirmar, será adicionado)" },
            { id = "if_prey_can_be_upgraded_do_so_as_nightmare_preys_might_give_champ_pieces", text = "Se a Presa puder ser aprimorada, faça-o - presas de Pesadelo podem dar peças de campeão" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pré-temporada Semana 1 - 3 de março - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhuma Crista até receber instruções" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Aumente a reputação com A Singularidade ao rank 7 para o bugiganga de campeão 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Aumente a reputação com Hara'ti ao rank 8 para o cinto de campeão 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Aumente a reputação com Lua de Prata ao rank 9 para o elmo de campeão 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Aumente a reputação com a Tribo Amani ao rank 9 para o colar de campeão 1/6" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Desbloqueie as Expedições até nível 8 (11 se disponível)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Complete eventos semanais se disponíveis (a confirmar, será adicionado)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Se a Presa der recompensas úteis, faça-a (pode dar peças de campeão no Pesadelo)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Faça missões do mundo que dão melhorias de equipamento" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Complete um tour mundial de masmorras M0 - recompensa nível de item veterano - não aprimore ainda" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Entre na fila de masmorras heroicas para os slots restantes" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pré-temporada Semana 2 - 10 de março - M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhuma Crista até receber instruções" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Desbloqueie as Expedições até nível 8 (11 se disponível)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Complete eventos semanais se disponíveis (a confirmar, será adicionado)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Se a Presa der recompensas úteis, faça-a (pode dar peças de campeão no Pesadelo)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Faça missões do mundo que dão melhorias de equipamento" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade", text = "Complete um tour mundial de masmorras M0 - recompensa nível de item veterano - não aprimore" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Entre na fila de masmorras heroicas para os slots restantes" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Se você fizer raid na terça dia 17, crie itens. Consulte o documento para mais informações." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Temporada 1 Semana 1 - 17 de março - Semana Heroica",
        items = {
            { id = "do_not_spend_heroic_or_mythic_crests", text = "NÃO gaste cristas heroicas ou míticas" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faça o LFR por peças de tier (veja o guia para saber o motivo)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Complete um tour mundial de masmorras M0 - recompensa nível de item campeão" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Mate o chefe mundial por nível de item campeão" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Faça Expedições Generosas de alto nível com chaves do cofre, use o mapa se possível" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Se a Presa der recompensas úteis, faça-a (pode dar peças de campeão no Pesadelo)" },
            { id = "complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Complete a missão PvP para colar/anel herói garantido" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Antes do raid: crie 2 peças nível 246, 2 ornamentos nos slots fracos, use 160 cristas veterano" },
            { id = "before_raid_spend_all_veteran_and_champion_crests_upgrading_everything", text = "Antes do raid: gaste todas as cristas veterano e campeão melhorando tudo" },
            { id = "complete_your_raids", text = "Complete seus raids" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Rastreie cristas: 0/100 Heroico, 0/100 Mítico" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Semana 2 - 24 de março - Semana Mítica, M+ abre, tirem férias nerds",
        items = {
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faça o LFR por peças de tier (veja o guia para saber o motivo)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Mate o chefe mundial por nível de item campeão" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Faça Expedições Generosas de alto nível com chaves do cofre, use o mapa se possível" },
            { id = "even_if_you_skip_delves_do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Mesmo que pule as Expedições, faça pelo menos um nível 11 para a missão da Pedra-Chave Rachada" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farme +10 por equipamento nível 266 em todos os slots" },
            { id = "1h_crafted_note_check_guide_ignore_if_you_don_t_dual_wield", text = "Nota sobre arma de 1 mão criada, veja o guia (ignore se não usar duas armas)" },
            { id = "full_clear_normal_and_heroic", text = "Limpe completamente Normal e Heroico" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Antes do raid mítico: melhore 11 itens herói 3/6 uma vez cada" },
            { id = "enjoy_mythic_progression", text = "Aproveite a progressão mítica!" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mítico: se tiver sorte e pegar um item da trilha mítica, pule para o conselho de melhoria da próxima semana." },
            { id = "track_crests_220_220_heroic_0_220_mythic", text = "Rastreie cristas: 220/220 Heroico, 0/220 Mítico" },
            { id = "ending_item_level_4x266_11x269", text = "Nível de item final: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Semana 3 - 31 de março - Raid final abre",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Abra o Grande Cofre (item mítico 272+) - melhore após criar" },
            { id = "craft_2h_mythic_weapon_5_6_285_see_note_in_text_guide", text = "Crie a arma mítica de 2 mãos (5/6 285) - veja a nota no guia de texto" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Sem bônus de 4 peças: faça o LFR por peças de tier (veja o guia)" },
            { id = "farm_12s_for_vault_crests", text = "Farme +12 pelo Grande Cofre + cristas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: melhore 2 de seus itens 269 4/6 para 276 6/6 por 80 cristas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do cofre era 1/6, melhore primeiro a versão heroica para 6/6 por 20 cristas heroicas. Depois melhore seu item 272 da trilha mítica 1/6 para 289 6/6 por 80 cristas míticas." },
            { id = "full_clear_normal_heroic_and_do_as_much_of_mythic_as_you_can", text = "Limpe completamente Normal e Heroico, e avance o máximo possível em Mítico" },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Se pegou um 2° item da trilha mítica, pule para o conselho de melhoria da próxima semana." },
            { id = "track_crests_320_320_heroic_160_320_mythic", text = "Rastreie cristas: 320/320 Heroico, 160/320 Mítico" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Nível de item final: 3x266, 8x269, 2x276h, 1x285(criado), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Semana 4 - 7 de abril",
        items = {
            { id = "open_vault_272_myth_item", text = "Abra o Grande Cofre (item mítico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farme +12 pelo Grande Cofre + cristas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: melhore 2 de seus itens 269 4/6 para 276 6/6 por 80 cristas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do cofre era 1/6, melhore primeiro a versão heroica para 6/6 por 20 cristas heroicas. Depois melhore seu item 272 da trilha mítica 1/6 para 289 6/6 por 80 cristas míticas." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: melhore o drop do raid trilha mítica 275 2/6 para 289 6/6 por 80 cristas míticas." },
            { id = "track_crests_420_400_heroic_320_420_mythic", text = "Rastreie cristas: 420/400 Heroico, 320/420 Mítico" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Nível de item final: 2x266, 5x269, 4x276h, 1x285(criado), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Semana 5 - 14 de abril",
        items = {
            { id = "open_vault_272_myth_item", text = "Abra o Grande Cofre (item mítico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farme +12 pelo Grande Cofre + cristas" },
            { id = "craft_2nd_embellishment_at_285_ilvl_mythic_for_80_myth_crests", text = "Crie o 2° ornamento no nível 285 Mítico por 80 cristas míticas" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heroico: melhore 2 de seus itens 269 4/6 para 276 6/6 por 80 cristas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do cofre era 1/6, melhore primeiro a versão heroica para 6/6 por 20 cristas heroicas. Depois melhore seu item 272 da trilha mítica 1/6 para 289 6/6 por 80 cristas míticas." },
            { id = "track_crests_520_520_heroic_480_520_mythic", text = "Rastreie cristas: 520/520 Heroico, 480/520 Mítico" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Nível de item final: 1x266, 2x269, 6x276h, 2x285(criado), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Semana 6 - 21 de abril - Cristas heroicas concluídas",
        items = {
            { id = "open_vault_272_myth_item", text = "Abra o Grande Cofre (item mítico 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Farme +12 pelo Grande Cofre + cristas" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Heroico: melhore seu último item 269 4/6 para 276 6/6 por 40 cristas heroicas" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do cofre era 1/6, melhore primeiro a versão heroica para 6/6 por 20 cristas heroicas. Depois melhore seu item 272 da trilha mítica 1/6 para 289 6/6 por 80 cristas míticas." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: melhore o drop do raid trilha mítica 275 2/6 para 289 6/6 por 80 cristas míticas." },
            { id = "track_crests_560_620_heroic_620_620_mythic", text = "Rastreie cristas: 560/620 Heroico, 620/620 Mítico" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Nível de item final: 7x276h, 2x285(criado), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Semana 7 - 28 de abril+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Não crie se puder pegar itens do cofre acima de 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Melhore itens míticos conforme obtê-los, priorizando chegar a 289 pelo salto de +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Planeje uma possível troca para 1 mão + off-hand criado" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Aproveite o sistema de melhoria muito melhor da Blizzard!" },
        },
    },
}

reg.data[LOCALE] = DATASET

