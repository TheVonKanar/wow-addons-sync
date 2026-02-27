--[[
Portuguese-Brazil (ptBR) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]
if GetLocale() ~= "ptBR" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

local LOCALE = "ptBR"

local LOCALE_REGISTRY_KEY = "LARIASWEEKLYCHECKLIST_LOCALE_REGISTRY"

local reg = _G[LOCALE_REGISTRY_KEY]
if type(reg) ~= "table" then
    reg = {}
    _G[LOCALE_REGISTRY_KEY] = reg
end
if type(reg.data) ~= "table" then reg.data = {} end

-- ⚠️ TERMOS MIDNIGHT NÃO VERIFICADOS – Verificar no jogo antes de publicar:
--   Modo de Guerra (Warmode), FLN = Feira da Lua Negra (DMF),
--   Soirée de Saltheril (Saltheril's Soiree), Floresta dos Cantos Eternos (Eversong Woods),
--   Evento da abundância (Abundance Event), Lendas dos Haranir (Legends of the Haranir),
--   Harandar, Assalto de Stormarion (Stormarion Assault), Tempestade do Vazio (Voidstorm),
--   A Singularidade (The Singularity), Pedra-Rúnica Rachada (Cracked Keystone),
--   chaves do cofre (Coffer keys)
local DATASET = {

    {
        id = "early_access_feb_26_through_mar_2_pay_to_win",
        title = "Acesso Antecipado – 26 fev. a 2 mar. – Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhum Brasão até receber instruções" },
            { id = "level_characters_warmode_on_to_90_dmf_opens_sunday_for_10_more_exp", text = "Suba personagens com Modo Guerra ativado ao nível 90 – a FLN abre no domingo com +10% de EXP" },
            { id = "if_available_complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Se disponível, complete a Soiree de Saltheril semanal em Bosques da Canção Eterna com o bônus da FLN." },
            { id = "if_available_complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Se disponível, complete o Evento de Abundância semanal em Zul'Aman com o bônus da FLN." },
            { id = "if_available_complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Se disponível, complete o evento semanal Lendas dos Haranir em Harandar com o bônus da FLN." },
            { id = "if_available_complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Se disponível, complete o Assalto de Stormarion semanal na Voragem do Vázio com o bônus da FLN." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Opcional) Mate cada raro uma vez em cada zona para renome. Cada raro tem bloqueio semanal." },
            { id = "complete_4x_prey_on_normal_difficulty_for_veteran_gear", text = "Complete a Presa 4 vezes na dificuldade normal para obter equipamento veteranário." },
            { id = "once_dmf_opens_complete_side_quest_chains_for_renown_can_be_done_on_alts_to_level_at_same_time", text = "Após a abertura da FLN, complete cadeias de missões secundárias para renome. (Pode ser feito em alts enquanto lvla)" },
            { id = "unlikely_see_doc_for_info_complete_a_world_tour_of_m0_s_after_full_release_but_before_your_region_s_reset", text = "(Pouco provável, veja o doc) Complete um tour mundial dos M0 após o lançamento, antes do reset da sua região" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Pré-temporada Semana 1 – 3 de março – M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhum Brasão até receber instruções" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Eleve o renome com A Singularidade ao grau 7 para o acessório campeão 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Eleve o renome com Hara'ti ao grau 8 para o cinturão campeão 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Eleve o renome com Lua de Prata ao grau 9 para o elmo campeão 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Eleve o renome com a Tribo Amani ao grau 9 para o colar campeão 1/6" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Complete a Soiree de Saltheril semanal em Bosques da Canção Eterna com o bônus da FLN." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Complete o Evento de Abundância semanal em Zul'Aman com o bônus da FLN." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Complete o evento semanal Lendas dos Haranir em Harandar com o bônus da FLN." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Complete o Assalto de Stormarion semanal na Voragem do Vázio com o bônus da FLN." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Opcional) Mate cada raro uma vez em cada zona para renome. Cada raro tem bloqueio semanal." },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Desbloqueie Imersões até o nível 8 (11 se disponível)" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Opcional) Complete a Presa normal 4 vezes para equipamento aventureiro e renome." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Complete a Presa difícil 4 vezes para equipamento veteranário e renome." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Complete um tour mundial das masmorras M0 - recompensa nível de item veteranário - não melhore ainda" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Pré-temporada Semana 2 – 10 de março – M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhum Brasão até receber instruções" },
            { id = "if_not_completed_continue_to_raise_renown_for_champion_pieces", text = "Se não concluído, continue elevando o renome para peças campeã" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods", text = "Complete a Soiree de Saltheril semanal em Bosques da Canção Eterna." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman", text = "Complete o Evento de Abundância semanal em Zul'Aman." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar", text = "Complete o evento semanal Lendas dos Haranir em Harandar." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm", text = "Complete o Assalto de Stormarion semanal na Voragem do Vázio." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Opcional) Mate cada raro uma vez em cada zona para renome. Cada raro tem bloqueio semanal." },
            { id = "unlock_delves_through_tier_8_11_if_available_if_not_done_yet", text = "Desbloqueie Imersões até o nível 8 (11 se disponível), se ainda não feito" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Opcional) Complete a Presa normal 4 vezes para equipamento aventureiro e renome." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Complete a Presa difícil 4 vezes para equipamento veteranário e renome." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Complete um tour mundial das masmorras M0 - recompensa nível de item veteranário - não melhore ainda" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Se for raidy na terça dia 17, crie itens. Veja o documento para mais informações." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Semana 1 da Temporada 1 – 17 de março – Semana heróica",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhum Brasão até receber instruções" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faça o LFR para peças de conjunto (veja o guia para entender o porquê)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Complete um tour mundial das masmorras M0 - recompensa nível de item campeão" },
            { id = "complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "Complete a Presa Pesadelo 4 vezes para equipamento campeão e renome." },
            { id = "kill_world_boss_for_champ_2_6_250_ilvl_item", text = "Mate o chefe mundial para um item campeão 2/6 nível 250" },
            { id = "if_available_complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Se disponível, complete a missão de JcJ para colar/anel herói garantido" },
            { id = "do_t8_bountiful_delves_with_coffer_keys_use_map_on_t8_delve", text = "Faça Imersões Abundantes T8 com chaves do cofre, use o mapa nas Imersões T8+" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Antes da raid: crie 2 peças nível 246, 2 ornamentos nos slots fracos, use 160 Brasões veteranários" },
            { id = "before_raid_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Antes da raid: gaste todos os Brasões aventureiros, veteranários e campeões melhorando qualquer coisa" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Acompanhe os Brasões: 0/100 Heróico, 0/100 Mítico" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Semana 2 – 24 de março – Semana mítica, M+ abre, tirem férias nerds",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Não gaste nenhum Brasão até receber instruções" },
            { id = "1h_crafted_note_check_guide_check_craft_path_info_very_important", text = "Nota sobre arma 1M criada, veja o guia, verifique o caminho de criação (MUITO IMPORTANTE!)" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Faça o LFR para peças de conjunto (veja o guia para entender o porquê)" },
            { id = "optional_kill_world_boss_for_champ_2_6_250_ilvl_item", text = "(Opcional) Mate o chefe mundial para um item campeão 2/6 nível 250" },
            { id = "optional_complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "(Opcional) Complete a Presa Pesadelo 4 vezes para equipamento campeão e renome." },
            { id = "do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Faça pelo menos um nível 11 para obter a missão da Pedra Mágica Rachada" },
            { id = "continue_to_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Continue gastando todos os Brasões aventureiros, veteranários e campeões melhorando qualquer coisa" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Farme +10s para equipamento nível 266 em todos os slots" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Antes da raid mítica: melhore 11 itens herói 3/6 uma vez cada" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Mítico: se tiver sorte e obteve um item da trilha mítica, pule para o conselho de melhoria da próxima semana." },
            { id = "track_crests_220_220_heroic_0_220_mythic_never_hold_mythic_crests", text = "Acompanhe os Brasões: 220/220 Heróico, 0/220 Mítico – nunca acumule Brasões Míticos" },
            { id = "ending_item_level_4x266_11x269", text = "Nível de item final: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Semana 3 – 31 de março – Raid final abre",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Abra o Grande Cofre (item mítico 272+) - melhore após criar" },
            { id = "craft_items_see_guide_for_2_paths_to_pick", text = "Crie itens – consulte o guia para 2 caminhos a escolher" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Sem bônus 4 peças: faça o LFR para peças de conjunto (veja o guia)" },
            { id = "farm_10s_for_vault_crests", text = "Farme +10s para o Grande Cofre + Brasões" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heróico: melhore 2 dos seus itens 269 4/6 para 276 6/6 por 80 Brasões Heróicos" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do Grande Cofre era 1/6, melhore primeiro o equivalente heróico para 6/6 por 20 Brasões Heróicos. Depois melhore seu item da trilha mítica 272 1/6 para 6/6 289 por 80 Brasões Míticos." },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Se obteve um 2º item da trilha mítica, pule para o conselho de melhoria da próxima semana." },
            { id = "track_crests_320_320_heroic_160_320_mythic_never_hold_mythic_crests", text = "Acompanhe os Brasões: 320/320 Heróico, 160/320 Mítico – nunca acumule Brasões Míticos" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Nível de item final: 3x266, 8x269, 2x276h, 1x285(criado), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Semana 4 – 7 de abr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Abra o Grande Cofre (item mítico 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farme +10s para o Grande Cofre + Brasões" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heróico: melhore 2 dos seus itens 269 4/6 para 276 6/6 por 80 Brasões Heróicos" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do Grande Cofre era 1/6, melhore primeiro o equivalente heróico para 6/6 por 20 Brasões Heróicos. Depois melhore seu item da trilha mítica 272 1/6 para 6/6 289 por 80 Brasões Míticos." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: melhore seu item da raid 2/6 275 da trilha mítica para 6/6 289 por 80 Brasões Míticos." },
            { id = "track_crests_420_400_heroic_320_420_mythic_never_hold_mythic_crests", text = "Acompanhe os Brasões: 420/400 Heróico, 320/420 Mítico – nunca acumule Brasões Míticos" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Nível de item final: 2x266, 5x269, 4x276h, 1x285(criado), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Semana 5 – 14 de abr.",
        items = {
            { id = "open_vault_272_myth_item", text = "Abra o Grande Cofre (item mítico 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farme +10s para o Grande Cofre + Brasões" },
            { id = "craft_next_item_see_doc_for_more_info", text = "Crie o próximo item (consulte o documento para mais informações)" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Heróico: melhore 2 dos seus itens 269 4/6 para 276 6/6 por 80 Brasões Heróicos" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do Grande Cofre era 1/6, melhore primeiro o equivalente heróico para 6/6 por 20 Brasões Heróicos. Depois melhore seu item da trilha mítica 272 1/6 para 6/6 289 por 80 Brasões Míticos." },
            { id = "track_crests_520_520_heroic_480_520_mythic_never_hold_mythic_crests", text = "Acompanhe os Brasões: 520/520 Heróico, 480/520 Mítico – nunca acumule Brasões Míticos" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Nível de item final: 1x266, 2x269, 6x276h, 2x285(criado), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Semana 6 – 21 de abr. – Terminados os Brasões Heróicos",
        items = {
            { id = "open_vault_272_myth_item", text = "Abra o Grande Cofre (item mítico 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Farme +10s para o Grande Cofre + Brasões" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Heróico: melhore seu último item 269 4/6 para 276 6/6 por 40 Brasões Heróicos" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Mítico: se seu item do Grande Cofre era 1/6, melhore primeiro o equivalente heróico para 6/6 por 20 Brasões Heróicos. Depois melhore seu item da trilha mítica 272 1/6 para 6/6 289 por 80 Brasões Míticos." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Mítico: melhore seu item da raid 2/6 275 da trilha mítica para 6/6 289 por 80 Brasões Míticos." },
            { id = "track_crests_560_620_heroic_620_620_mythic_never_hold_mythic_crests", text = "Acompanhe os Brasões: 560/620 Heróico, 620/620 Mítico – nunca acumule Brasões Míticos" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Nível de item final: 7x276h, 2x285(criado), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Semana 7 – 28 de abr.+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Não crie se puder obter itens do Grande Cofre acima de 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Melhore itens míticos conforme os obtiver, preferindo pular para 289 pelo bônus de +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Planeje uma possível troca para 1M + mão secundária criada" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Aproveite o sistema de melhoria muito melhor da Blizzard!" },
        },
    },
}

reg.data[LOCALE] = DATASET
