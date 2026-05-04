local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetClassicToyAchievements()

    -- Child Achievements Family Battler of Eastern Kingdoms
    local ACMChilds_FamilyBattlerOfEasternKingdoms = {
        Utilities:GetAchievementName(61040),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61029, -- Aquatic Battler of Eastern Kingdoms
            61030, -- Beast Battler of Eastern Kingdoms
            61031, -- Critter Battler of Eastern Kingdoms
            61032, -- Dragonkin Battler of Eastern Kingdoms
            61033, -- Elemental Battler of Eastern Kingdoms
            61034, -- Flying Battler of Eastern Kingdoms
            61035, -- Humanoid Battler of Eastern Kingdoms
            61036, -- Magic Battler of Eastern Kingdoms
            61037, -- Mechanical Battler of Eastern Kingdoms
            61028, -- Undead Battler of Eastern Kingdoms
        }
    }

    -- Child Achievements Family Battler of Kalimdor
    local ACMChilds_FamilyBattlerOfKalimdor = {
        Utilities:GetAchievementName(61051),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61041, -- Aquatic Battler of Kalimdor
            61042, -- Beast Battler of Kalimdor
            61043, -- Critter Battler of Kalimdor
            61044, -- Dragonkin Battler of Kalimdor
            61045, -- Elemental Battler of Kalimdor
            61046, -- Flying Battler of Kalimdor
            61047, -- Humanoid Battler of Kalimdor
            61048, -- Magic Battler of Kalimdor
            61049, -- Mechanical Battler of Kalimdor
            61050, -- Undead Battler of Kalimdor
        }
    }

    -- Child Achievements Old World Family Battler
    local ACMChilds_OldWorldFamilyBattler = {
        Utilities:GetAchievementName(61094),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }
    
    ACMChilds_OldWorldFamilyBattler[#ACMChilds_OldWorldFamilyBattler+1] = ACMChilds_FamilyBattlerOfEasternKingdoms
    ACMChilds_OldWorldFamilyBattler[#ACMChilds_OldWorldFamilyBattler+1] = ACMChilds_FamilyBattlerOfKalimdor

    ACMChilds_OldWorldFamilyBattler[#ACMChilds_OldWorldFamilyBattler+1] = {
        61040, -- Family Battler of Eastern Kingdoms
        61051, -- Family Battler of Kalimdor
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME0, -- Classic
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_OldWorldFamilyBattler
    end

    ACMListFlat[#ACMListFlat+1] = {
        14020, -- Pet Battle Challenge: Blackrock Depths
        61094, -- Old World Family Battler
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_PetBattleDungeonsBlackrockDepths = {
        Utilities:GetZoneNameByMapID(242), -- Blackrock Depths
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14020, -- Pet Battle Challenge: Blackrock Depths
        }
    }

    -- Pet Battle Dungeons
    local ACMList_PetBattleDungeons = {
        _G.BATTLE_PET_SOURCE_5 .. " " .. _G.DUNGEONS, -- Pet Battle Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_PetBattleDungeonsBlackrockDepths
    }

    -- PetBattles
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_OldWorldFamilyBattler
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        61094, -- Old World Family Battler
    }

    local ACMList = {
        _G.EXPANSION_NAME0, -- Classic
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_PetBattleDungeons,
        ACMList_PetBattles
    }

    return ACMList
end