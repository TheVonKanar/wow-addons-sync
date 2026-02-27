--[[
Russian (ruRU) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]
if GetLocale() ~= "ruRU" and not _G["LARIASWEEKLYCHECKLIST_LOAD_ALL_LOCALES"] then return end

local LOCALE = "ruRU"

local LOCALE_REGISTRY_KEY = "LARIASWEEKLYCHECKLIST_LOCALE_REGISTRY"

local reg = _G[LOCALE_REGISTRY_KEY]
if type(reg) ~= "table" then
    reg = {}
    _G[LOCALE_REGISTRY_KEY] = reg
end
if type(reg.data) ~= "table" then reg.data = {} end

-- ⚠️ НЕПРОВЕРЕННЫЕ ТЕРМИНЫ MIDNIGHT – Проверьте в игре перед публикацией:
--   Режим войны (Warmode), ЯН = Ярмарка Новолуния (DMF, подтверждено для ruRU),
--   Вечеринка Салтерила (Saltheril's Soiree), Вечнопесенный лес (Eversong Woods),
--   Событие «Изобилие» (Abundance Event), Легенды Харанир (Legends of the Haranir),
--   Харандар (Harandar), Штурм Шторммариона (Stormarion Assault),
--   Пустотная буря (Voidstorm), Сингулярность (The Singularity),
--   Задание «Треснувший Камень» (Cracked Keystone Quest), ключи от сундука (Coffer keys)
local DATASET = {

    {
        id = "early_access_feb_26_through_mar_2_pay_to_win",
        title = "Ранний доступ — 26 фев. — 2 мар. — Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гербы до получения указаний" },
            { id = "level_characters_warmode_on_to_90_dmf_opens_sunday_for_10_more_exp", text = "Прокачайте персонажей в режиме войны до 90 — ЯН открывается в воскресенье (+10% опыта)" },
            { id = "if_available_complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Если доступно, выполните еженедельный вечер Сальтериля в Лесу Вечной Песни с бонусом ЯН." },
            { id = "if_available_complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Если доступно, выполните еженедельное мероприятие Эбундансия в Зул’Амане с бонусом ЯН." },
            { id = "if_available_complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Если доступно, выполните еженедельное мероприятие Легенды Харанир в Харандаре с бонусом ЯН." },
            { id = "if_available_complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Если доступно, выполните еженедельный штурм Тайфуносца в Буре Пустоты с бонусом ЯН." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Необяз.) Убивайте каждого редкого по одному разу в каждой зоне для репутации. У каждого редкого недельный кулдаўн." },
            { id = "complete_4x_prey_on_normal_difficulty_for_veteran_gear", text = "Выполните Охоту 4 раза на обычной сложности для получения снаряжения ветерана." },
            { id = "once_dmf_opens_complete_side_quest_chains_for_renown_can_be_done_on_alts_to_level_at_same_time", text = "После открытия ЯН выполняйте побочные цепочки заданий для репутации. (Можно на алтах параллельно с прокачкой)" },
            { id = "unlikely_see_doc_for_info_complete_a_world_tour_of_m0_s_after_full_release_but_before_your_region_s_reset", text = "(Маловероятно, см. док.) Пройдите мировой тур по M0 после выхода, до сброса вашего региона" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Предсезон неделя 1 — 3 марта — M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гербы до получения указаний" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Повысьте репутацию С Сингулярностью до 7 ранга для тринкета чемпиона 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Повысьте репутацию с Хара'ти до 8 ранга для пояса чемпиона 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Повысьте репутацию с Двором Луносвета до 9 ранга для шлема чемпиона 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Повысьте репутацию с Племенем Амани до 9 ранга для ожерелья чемпиона 1/6" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods_with_the_dmf_buff", text = "Выполните еженедельный вечер Сальтериля в Лесу Вечной Песни с бонусом ЯН." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman_with_the_dmf_buff", text = "Выполните еженедельное мероприятие Эбундансия в Зул’Амане с бонусом ЯН." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar_with_the_dmf_buff", text = "Выполните еженедельное мероприятие Легенды Харанир в Харандаре с бонусом ЯН." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm_with_the_dmf_buff", text = "Выполните еженедельный штурм Тайфуносца в Буре Пустоты с бонусом ЯН." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Необяз.) Убивайте каждого редкого по одному разу в каждой зоне для репутации. У каждого редкого недельный кулдаўн." },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Откройте Вылазки до уровня Ь8 (или Ь11, если доступно)" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Необяз.) Выполните Охоту 4 раза на обычной сложности для снаряжения авантюриста и репутации." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Выполните Охоту 4 раза на сложной сложности для снаряжения ветерана и репутации." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Пройдите мировой тур по M0-подземельям — награда уровня ветерана — пока не улучшайте" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Предсезон неделя 2 — 10 марта — M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гербы до получения указаний" },
            { id = "if_not_completed_continue_to_raise_renown_for_champion_pieces", text = "Если не завершено, продолжайте повышать репутацию для предметов чемпиона" },
            { id = "complete_the_weekly_saltheril_s_soiree_in_eversong_woods", text = "Выполните еженедельный вечер Сальтериля в Лесу Вечной Песни." },
            { id = "complete_the_weekly_abundance_event_in_zul_aman", text = "Выполните еженедельное мероприятие Эбундансия в Зул’Амане." },
            { id = "complete_the_weekly_legends_of_the_haranir_event_in_harandar", text = "Выполните еженедельное мероприятие Легенды Харанир в Харандаре." },
            { id = "complete_the_weekly_stormarion_assault_in_the_voidstorm", text = "Выполните еженедельный штурм Тайфуносца в Буре Пустоты." },
            { id = "optional_kill_each_rare_once_in_each_zone_for_renown_these_are_a_weekly_lockout_for_each_rare", text = "(Необяз.) Убивайте каждого редкого по одному разу в каждой зоне для репутации. У каждого редкого недельный кулдаўн." },
            { id = "unlock_delves_through_tier_8_11_if_available_if_not_done_yet", text = "Откройте Вылазки до уровня Ь8 (или Ь11, если доступно), если ещё не сделано" },
            { id = "optional_complete_4x_normal_prey_for_adventurer_gear_and_renown", text = "(Необяз.) Выполните Охоту 4 раза на обычной сложности для снаряжения авантюриста и репутации." },
            { id = "complete_4x_hard_prey_for_veteran_gear_and_renown", text = "Выполните Охоту 4 раза на сложной сложности для снаряжения ветерана и репутации." },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Пройдите мировой тур по M0-подземельям — награда уровня ветерана — пока не улучшайте" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Если рейдите в вторник 17-го, создайте предмет. См. документ для подробностей." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Сезон 1 неделя 1 — 17 марта — Героическая неделя",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гербы до получения указаний" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Проходите Поиск рейда для тировых предметов (см. руководство — почему)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Пройдите мировой тур по M0-подземельям — награда уровня чемпиона" },
            { id = "complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "Выполните Охоту 4 раза на сложности Кошмар для снаряжения чемпиона и репутации." },
            { id = "kill_world_boss_for_champ_2_6_250_ilvl_item", text = "Убейте мирового босса для предмета чемпиона 2/6 уровня 250" },
            { id = "if_available_complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Если доступно, выполните задание PvP для фиксированного ожерелья/кольца класса Героя" },
            { id = "do_t8_bountiful_delves_with_coffer_keys_use_map_on_t8_delve", text = "Выполняйте Многообещающие вылазки Ь8 с ключами сундука, используйте карту в вылазках Ь8+" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "До рейда: создайте 2 предмета уровня 246, 2 украшения на слабых слотах, используйте 160 Гербов ветерана" },
            { id = "before_raid_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "До рейда: потратьте все Гербы авантюриста, ветерана и чемпиона, улучшая всё подряд" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Следите за Гербами: 0/100 Героических, 0/100 Мифических" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Неделя 2 — 24 марта — Мифическая неделя, М+ открывается, берите выходные нерды",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гербы до получения указаний" },
            { id = "1h_crafted_note_check_guide_check_craft_path_info_very_important", text = "Заметка об одноручном созданном оружии, артефакте. путь создания (ОЧЕНЬ ВАЖНО!)" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Проходите Поиск рейда для тировых предметов (см. руководство — почему)" },
            { id = "optional_kill_world_boss_for_champ_2_6_250_ilvl_item", text = "(Необяз.) Убейте мирового босса для предмета чемпиона 2/6 уровня 250" },
            { id = "optional_complete_4x_nightmare_prey_for_champion_gear_and_renown", text = "(Необяз.) Выполните Охоту 4 раза на сложности Кошмар для снаряжения чемпиона и репутации." },
            { id = "do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Пройдите хотя бы одну вылазку Ь11 для получения задания „Треснутший зенитный камень“" },
            { id = "continue_to_spend_all_adventurer_veteran_and_champion_crests_upgrading_anything", text = "Продолжайте тратить Эгиды авантюриста, ветерана и чемпиона, улучшая всё подряд" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Фармите +10 для снаряжения уровня 266 в каждый слот" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "До мифического рейда: улучшите 11 предметов 3/6 класса Героя по одному разу каждый" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Миф: если повезло и выпал предмет мифической ветки, переходите к совету по улучшению следующей недели." },
            { id = "track_crests_220_220_heroic_0_220_mythic_never_hold_mythic_crests", text = "Следите за Гербами: 220/220 Героических, 0/220 Мифических — не копите Мифические Гербы" },
            { id = "ending_item_level_4x266_11x269", text = "Итоговый уровень предметов: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Неделя 3 — 31 марта — Открывается финальный рейд",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Откройте Великий тайник (мифический предмет 272+) — улучшайте после создания" },
            { id = "craft_items_see_guide_for_2_paths_to_pick", text = "Создайте предметы — см. руководство: 2 пути на выбор" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Без бонуса 4 предмета: пройдите Поиск рейда для тировых предметов (см. руководство)" },
            { id = "farm_10s_for_vault_crests", text = "Фармите +10 для Великого тайника + Гербы" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Героический: улучшите 2 предмета 269 4/6 до 276 6/6 за 80 Гербов Героя" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет тайника 1/6, сначала улучшите его аналог героического до 6/6 за 20 Гербов Героя. Затем улучшите предмет мифической ветки 272 1/6 до 6/6 289 за 80 Гербов Легенд." },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Если получили 2-й предмет мифической ветки, переходите к совету следующей недели." },
            { id = "track_crests_320_320_heroic_160_320_mythic_never_hold_mythic_crests", text = "Следите за Гербами: 320/320 Героических, 160/320 Мифических — не копите Мифические Гербы" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Итоговый уровень: 3x266, 8x269, 2x276h, 1x285(созд.), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Неделя 4 — 7 апр.",
        items = {
            { id = "open_vault_272_myth_item", text = "Откройте Великий тайник (мифический предмет 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Фармите +10 для Великого тайника + Гербы" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Героический: улучшите 2 предмета 269 4/6 до 276 6/6 за 80 Гербов Героя" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет тайника 1/6, сначала улучшите его аналог героического до 6/6 за 20 Гербов Героя. Затем улучшите предмет мифической ветки 272 1/6 до 6/6 289 за 80 Гербов Легенд." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Миф: улучшите выпавший в рейде предмет мифической ветки 275 2/6 до 289 6/6 за 80 Гербов Легенд." },
            { id = "track_crests_420_400_heroic_320_420_mythic_never_hold_mythic_crests", text = "Следите за Гербами: 420/400 Героических, 320/420 Мифических — не копите Мифические Гербы" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Итоговый уровень: 2x266, 5x269, 4x276h, 1x285(созд.), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Неделя 5 — 14 апр.",
        items = {
            { id = "open_vault_272_myth_item", text = "Откройте Великий тайник (мифический предмет 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Фармите +10 для Великого тайника + Гербы" },
            { id = "craft_next_item_see_doc_for_more_info", text = "Создайте следующий предмет (см. документ для подробностей)" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Героический: улучшите 2 предмета 269 4/6 до 276 6/6 за 80 Гербов Героя" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет тайника 1/6, сначала улучшите его аналог героического до 6/6 за 20 Гербов Героя. Затем улучшите предмет мифической ветки 272 1/6 до 6/6 289 за 80 Гербов Легенд." },
            { id = "track_crests_520_520_heroic_480_520_mythic_never_hold_mythic_crests", text = "Следите за Гербами: 520/520 Героических, 480/520 Мифических — не копите Мифические Гербы" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Итоговый уровень: 1x266, 2x269, 6x276h, 2x285(созд.), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Неделя 6 — 21 апр. — Героические Гербы исчерпаны",
        items = {
            { id = "open_vault_272_myth_item", text = "Откройте Великий тайник (мифический предмет 272+)" },
            { id = "farm_10s_for_vault_crests", text = "Фармите +10 для Великого тайника + Гербы" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Героический: улучшите последний предмет 269 4/6 до 276 6/6 за 40 Гербов Героя" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет тайника 1/6, сначала улучшите его аналог героического до 6/6 за 20 Гербов Героя. Затем улучшите предмет мифической ветки 272 1/6 до 6/6 289 за 80 Гербов Легенд." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Миф: улучшите выпавший в рейде предмет мифической ветки 275 2/6 до 289 6/6 за 80 Гербов Легенд." },
            { id = "track_crests_560_620_heroic_620_620_mythic_never_hold_mythic_crests", text = "Следите за Гербами: 560/620 Героических, 620/620 Мифических — не копите Мифические Гербы" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Итоговый уровень: 7x276h, 2x285(созд.), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Неделя 7 — 28 апр.+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Не создавайте, если можете получить предметы тайника выше 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Улучшайте мифические предметы по мере получения, предпочитая прыжок до 289 (+4)" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Спланируйте возможную замену на 1р + созданное доп. оружие" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Наслаждайтесь значительно улучшенной системой улучшения Blizzard!" },
        },
    },
}

reg.data[LOCALE] = DATASET
