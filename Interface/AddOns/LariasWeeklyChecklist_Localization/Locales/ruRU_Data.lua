--[[
Russian (ruRU) checklist data for Larias's Weekly Checklist

NOTE: IDs are kept identical to the enUS dataset so completion tracking stays consistent
across locales.
]]

local LOCALE = "ruRU"

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
        title = "Ранний доступ — 26 фев. — 2 мар. — Pay to Win",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гребни до получения указаний" },
            { id = "level_characters_to_90_dmf_opens_sunday_for_10_more_exp", text = "Прокачайте персонажей до 90 — Ярмарка Темной луны открывается в воскресенье (+10% опыта)" },
            { id = "after_sunday_use_dmf_buff_to_raise_renowns_see_week_1", text = "После воскресенья используйте бонус Ярмарки для повышения репутации (см. неделю 1)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Выполняйте еженедельные события, если доступны (будет уточнено и добавлено)" },
            { id = "if_prey_can_be_upgraded_do_so_as_nightmare_preys_might_give_champ_pieces", text = "Если Добычу можно улучшить — сделайте это: кошмарная Добыча может давать вещи чемпиона" },
        },
    },
    {
        id = "pre_season_week_1_march_3_m0_s",
        title = "Предсезон неделя 1 — 3 марта — M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гребни до получения указаний" },
            { id = "raise_the_singularity_renown_to_rank_7_for_1_6_champion_trinket", text = "Повысьте репутацию с Сингулярностью до ранга 7 — тринкет чемпиона 1/6" },
            { id = "raise_hara_ti_renown_to_rank_8_for_1_6_champion_belt", text = "Повысьте репутацию с Хара'ти до ранга 8 — пояс чемпиона 1/6" },
            { id = "raise_silvermoon_renown_to_rank_9_for_1_6_champion_helm", text = "Повысьте репутацию с Серебряным Городом до ранга 9 — шлем чемпиона 1/6" },
            { id = "raise_amani_tribe_renown_to_rank_9_for_1_6_champion_necklace", text = "Повысьте репутацию с Племенем Амани до ранга 9 — ожерелье чемпиона 1/6" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Откройте Экспедиции до уровня 8 (до 11, если доступно)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Выполняйте еженедельные события, если доступны (будет уточнено и добавлено)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Если Добыча даёт полезные награды — выполняйте (на «Кошмаре» могут быть вещи чемпиона)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Выполняйте мировые задания, дающие улучшения снаряжения" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade_yet", text = "Завершите мировой тур по подземельям M0 — ур. предмета ветерана — пока не улучшайте" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Встаньте в очередь на героические подземелья для оставшихся слотов" },
        },
    },
    {
        id = "pre_season_week_2_march_10_m0_s",
        title = "Предсезон неделя 2 — 10 марта — M0",
        items = {
            { id = "do_not_spend_any_crests_until_told_to_do_so", text = "Не тратьте Гребни до получения указаний" },
            { id = "unlock_delves_through_tier_8_11_if_available", text = "Откройте Экспедиции до уровня 8 (до 11, если доступно)" },
            { id = "complete_weekly_events_if_available_tbd_will_add_as_we_get_them", text = "Выполняйте еженедельные события, если доступны (будет уточнено и добавлено)" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Если Добыча даёт полезные награды — выполняйте (на «Кошмаре» могут быть вещи чемпиона)" },
            { id = "do_world_quests_that_give_gear_upgrades", text = "Выполняйте мировые задания, дающие улучшения снаряжения" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_vet_ilvl_do_not_upgrade", text = "Завершите мировой тур по подземельям M0 — ур. предмета ветерана — не улучшайте" },
            { id = "queue_for_heroic_dungeons_for_remaining_slots", text = "Встаньте в очередь на героические подземелья для оставшихся слотов" },
            { id = "if_you_raid_tuesday_the_17th_craft_see_doc_for_more_info", text = "Если идёте в рейд во вторник 17-го — создайте предметы. Подробнее в документе." },
        },
    },
    {
        id = "season_1_week_1_mar_17_heroic_week",
        title = "Сезон 1 неделя 1 — 17 марта — Героическая неделя",
        items = {
            { id = "do_not_spend_heroic_or_mythic_crests", text = "НЕ тратьте героические или мифические Гребни" },
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Идите в ЛФД за сетовыми частями (причину см. в гайде)" },
            { id = "complete_a_world_tour_of_m0_dungeons_rewards_champ_ilvl", text = "Завершите мировой тур по подземельям M0 — ур. предмета чемпиона" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Убейте мирового босса ради ур. предмета чемпиона" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Проходите Щедрые Экспедиции высокого уровня с ключами сундука, используйте карту если возможно" },
            { id = "if_prey_gives_any_useful_rewards_do_prey_might_give_champ_pieces_on_nightmare", text = "Если Добыча даёт полезные награды — выполняйте (на «Кошмаре» могут быть вещи чемпиона)" },
            { id = "complete_pvp_quest_for_guaranteed_hero_neck_ring", text = "Выполните задание PvP ради гарантированного ожерелья/кольца героя" },
            { id = "before_raid_craft_2x_246_ilvl_pieces_2x_embellishments_on_weak_slots_use_160_vet_crests", text = "Перед рейдом: создайте 2 предмета ур. 246, 2 украшения в слабые слоты, используйте 160 ветеранских Гребней" },
            { id = "before_raid_spend_all_veteran_and_champion_crests_upgrading_everything", text = "Перед рейдом: потратьте все ветеранские и чемпионские Гребни на улучшение всего" },
            { id = "complete_your_raids", text = "Завершите свои рейды" },
            { id = "track_crests_0_100_heroic_0_100_mythic", text = "Отслеживайте Гребни: 0/100 Героических, 0/100 Мифических" },
        },
    },
    {
        id = "week_2_mar_24_mythic_week_m_opens_take_off_work_giganerds",
        title = "Неделя 2 — 24 марта — Мифическая неделя, открывается M+, берите отгул, задроты",
        items = {
            { id = "do_lfr_for_tier_pieces_check_guide_for_why", text = "Идите в ЛФД за сетовыми частями (причину см. в гайде)" },
            { id = "kill_world_boss_for_champ_ilvl", text = "Убейте мирового босса ради ур. предмета чемпиона" },
            { id = "do_high_level_bountiful_delves_with_coffer_keys_use_map_if_possible", text = "Проходите Щедрые Экспедиции высокого уровня с ключами сундука, используйте карту если возможно" },
            { id = "even_if_you_skip_delves_do_at_least_one_t11_to_get_cracked_keystone_quest", text = "Даже если пропускаете Экспедиции — сделайте хотя бы один уровень 11 ради квеста с Треснутым камнем" },
            { id = "farm_10s_for_266_gear_in_every_slot", text = "Фармите +10 ради снаряжения 266 в каждый слот" },
            { id = "1h_crafted_note_check_guide_ignore_if_you_don_t_dual_wield", text = "Заметка о созданном оружии 1М — см. гайд (игнорируйте, если не используете два оружия)" },
            { id = "full_clear_normal_and_heroic", text = "Полная зачистка Нормального и Героического режимов" },
            { id = "before_mythic_raid_upgrade_11x_3_6_hero_items_once_each", text = "Перед мифическим рейдом: улучшите 11 героических предметов 3/6 по одному разу каждый" },
            { id = "enjoy_mythic_progression", text = "Наслаждайтесь мифическим прогрессом!" },
            { id = "mythic_if_you_re_lucky_and_got_a_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Миф: если повезло и получили предмет мифической дорожки — переходите к советам по улучшению следующей недели." },
            { id = "track_crests_220_220_heroic_0_220_mythic", text = "Отслеживайте Гребни: 220/220 Героических, 0/220 Мифических" },
            { id = "ending_item_level_4x266_11x269", text = "Итоговый уровень предметов: 4x266, 11x269" },
        },
    },
    {
        id = "week_3_mar_31_final_raid_opens",
        title = "Неделя 3 — 31 марта — Открывается финальный рейд",
        items = {
            { id = "open_vault_272_myth_item_upgrade_after_crafting", text = "Откройте Великое хранилище (мифический предмет 272+) — улучшите после крафта" },
            { id = "craft_2h_mythic_weapon_5_6_285_see_note_in_text_guide", text = "Создайте мифическое оружие 2М (5/6 285) — см. заметку в текстовом гайде" },
            { id = "if_no_4p_do_lfr_for_tier_pieces_check_guide_for_why", text = "Нет бонуса 4 частей: идите в ЛФД за сетом (причину см. в гайде)" },
            { id = "farm_12s_for_vault_crests", text = "Фармите +12 ради Великого хранилища + Гребней" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Герой: улучшите 2 предмета 269 4/6 до 276 6/6 за 80 героических Гребней" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет хранилища 1/6 — сначала улучшите героический аналог до 6/6 за 20 героических Гребней. Затем улучшите предмет мифической дорожки 272 1/6 до 289 6/6 за 80 мифических Гребней." },
            { id = "full_clear_normal_heroic_and_do_as_much_of_mythic_as_you_can", text = "Полная зачистка Нормального и Героического, и максимально возможный прогресс в Мифическом" },
            { id = "if_you_got_a_2nd_myth_track_item_skip_to_next_week_s_upgrade_advice_for_it", text = "Получили 2-й предмет мифической дорожки — переходите к советам следующей недели." },
            { id = "track_crests_320_320_heroic_160_320_mythic", text = "Отслеживайте Гребни: 320/320 Героических, 160/320 Мифических" },
            { id = "ending_item_level_3x266_8x269_2x276h_1x285_crafted_1x289", text = "Итоговый уровень предметов: 3x266, 8x269, 2x276h, 1x285(крафт), 1x289" },
        },
    },
    {
        id = "week_4_apr_7",
        title = "Неделя 4 — 7 апреля",
        items = {
            { id = "open_vault_272_myth_item", text = "Откройте Великое хранилище (мифический предмет 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Фармите +12 ради Великого хранилища + Гребней" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Герой: улучшите 2 предмета 269 4/6 до 276 6/6 за 80 героических Гребней" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет хранилища 1/6 — сначала улучшите героический аналог до 6/6 за 20 героических Гребней. Затем улучшите предмет мифической дорожки 272 1/6 до 289 6/6 за 80 мифических Гребней." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Миф: улучшите дроп рейда мифической дорожки 275 2/6 до 289 6/6 за 80 мифических Гребней." },
            { id = "track_crests_420_400_heroic_320_420_mythic", text = "Отслеживайте Гребни: 420/400 Героических, 320/420 Мифических" },
            { id = "ending_item_level_2x266_5x269_4x276h_1x285_crafted_3x289", text = "Итоговый уровень предметов: 2x266, 5x269, 4x276h, 1x285(крафт), 3x289" },
        },
    },
    {
        id = "week_5_apr_14",
        title = "Неделя 5 — 14 апреля",
        items = {
            { id = "open_vault_272_myth_item", text = "Откройте Великое хранилище (мифический предмет 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Фармите +12 ради Великого хранилища + Гребней" },
            { id = "craft_2nd_embellishment_at_285_ilvl_mythic_for_80_myth_crests", text = "Создайте 2-е украшение на ур. 285 Мифическом за 80 мифических Гребней" },
            { id = "heroic_upgrade_2_of_your_4_6_269_items_to_6_6_276_for_80_heroic_crests", text = "Герой: улучшите 2 предмета 269 4/6 до 276 6/6 за 80 героических Гребней" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет хранилища 1/6 — сначала улучшите героический аналог до 6/6 за 20 героических Гребней. Затем улучшите предмет мифической дорожки 272 1/6 до 289 6/6 за 80 мифических Гребней." },
            { id = "track_crests_520_520_heroic_480_520_mythic", text = "Отслеживайте Гребни: 520/520 Героических, 480/520 Мифических" },
            { id = "ending_item_level_1x266_2x269_6x276h_2x285_crafted_4x289", text = "Итоговый уровень предметов: 1x266, 2x269, 6x276h, 2x285(крафт), 4x289" },
        },
    },
    {
        id = "week_6_apr_21_done_with_heroic_crests",
        title = "Неделя 6 — 21 апреля — Героические Гребни исчерпаны",
        items = {
            { id = "open_vault_272_myth_item", text = "Откройте Великое хранилище (мифический предмет 272+)" },
            { id = "farm_12s_for_vault_crests", text = "Фармите +12 ради Великого хранилища + Гребней" },
            { id = "heroic_upgrade_your_last_4_6_269_item_to_6_6_276_for_40_heroic_crests", text = "Герой: улучшите последний предмет 269 4/6 до 276 6/6 за 40 героических Гребней" },
            { id = "mythic_if_your_vault_item_was_1_6_upgrade_its_heroic_counterpart_first_to_6_6_heroic_for_20_heroic_crests_upgrade_your_1_6_272_myth_track_item_to_6_6_289_for_80_myth_crests", text = "Миф: если предмет хранилища 1/6 — сначала улучшите героический аналог до 6/6 за 20 героических Гребней. Затем улучшите предмет мифической дорожки 272 1/6 до 289 6/6 за 80 мифических Гребней." },
            { id = "mythic_upgrade_your_raid_drop_from_2_6_275_myth_track_to_6_6_289_for_80_myth_crests", text = "Миф: улучшите дроп рейда мифической дорожки 275 2/6 до 289 6/6 за 80 мифических Гребней." },
            { id = "track_crests_560_620_heroic_620_620_mythic", text = "Отслеживайте Гребни: 560/620 Героических, 620/620 Мифических" },
            { id = "ending_item_level_7x276h_2x285_crafted_1x_285_5x289", text = "Итоговый уровень предметов: 7x276h, 2x285(крафт), 1x285, 5x289" },
        },
    },
    {
        id = "week_7_apr_28",
        title = "Неделя 7 — 28 апреля+",
        items = {
            { id = "do_not_craft_if_you_can_get_vault_items_higher_than_1_6", text = "Не крафтите, если можете получить предметы хранилища выше 1/6" },
            { id = "upgrade_mythic_items_as_you_get_them_preferring_to_jump_them_to_289_for_the_4_jump", text = "Улучшайте мифические предметы по мере получения, предпочтительно до 289 ради прыжка +4" },
            { id = "plan_for_possible_1h_crafted_oh_swap", text = "Планируйте возможную замену на 1М + созданный доп. предмет" },
            { id = "enjoy_blizzard_s_much_better_upgrade_system", text = "Наслаждайтесь значительно улучшенной системой улучшения Blizzard!" },
        },
    },
}

reg.data[LOCALE] = DATASET

