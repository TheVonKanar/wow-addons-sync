local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetBfaToyAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13285, -- Upright Citizens
            13489, -- Secret Fish of Mechagon
            12936, -- Battle on Zandalar and Kul Tiras
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Tiragarde Sound
    local ACMList_Zones_TiragardeSound = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(895),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13285, -- Upright Citizens
            }
        }
    }

    -- Professions -> Fishing
    local ACMList_Professions_Fishing = {
        _G.TRADE_SKILLS, -- Professions
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            _G.PROFESSIONS_FISHING, -- Fishing
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13489, -- Secret Fish of Mechagon
            }
        }
    }

    -- Pet Battle
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12936, -- Battle on Zandalar and Kul Tiras
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_TiragardeSound,
        ACMList_Professions_Fishing,
        ACMList_PetBattles
    }

    return ACMList
end