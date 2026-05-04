local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetDFToyAchievements()

    -- Child Achievements Dragonriding Challenge: Dragon Isles: Bronze
    local ACMChilds_DragonridingChallenge_DragonIsles_Bronze = {
        Utilities:GetAchievementName(18790),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            18748, -- Waking Shores Challenge: Bronze
            18754, -- Ohn'ahran Plains Challenge: Bronze
            18757, -- Azure Span Challenge: Bronze
            18760, -- Thaldraszus Challenge: Bronze
            18779, -- Forbidden Reach Challenge: Bronze
            18786, -- Zaralek Cavern Challenge: Bronze
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_DragonridingChallenge_DragonIsles_Bronze
    end

    ACMListFlat[#ACMListFlat+1] = {
        17782, -- Daycare Derby
        18559, -- Many Boxes, Many Rockses
        16423, -- Honor Our Ancestors
        15889, -- River Rapids Wrangler
        18100, -- Cavern Clawbbering
        16762, -- The Vegetarian Diet
        18790, -- Dragonriding Challenge: Dragon Isles: Bronze
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zone
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(2112), -- Valdrakken
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                17782, -- Daycare Derby
            }
        },
        {
            Utilities:GetZoneNameByMapID(2022), -- The Waking Shores
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                18559, -- Many Boxes, Many Rockses
            }
        },
        {
            Utilities:GetZoneNameByMapID(2023), -- Ohn'ahran Plains
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                16423, -- Honor Our Ancestors
            }
        },
        {
            Utilities:GetZoneNameByMapID(2024), -- The Azure Span
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                15889, -- River Rapids Wrangler
            }
        },
        {
            Utilities:GetZoneNameByMapID(2133), -- Zaralek Cavern
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                18100, -- Cavern Clawbbering
            }
        }
    }

    -- Dungeons->Brackenhide Hollow
    local ACMList_Dungeons_BrackenhideHollow = {
        _G.DUNGEONS, -- Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(2362),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                16762, -- The Vegetarian Diet
            }
        }
    }

    -- Skyriding
    local ACMList_Skyriding = {
        Utilities:GetAchievementCategoryNameByCategoryID(15462), -- Skyriding
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_Skyriding[#ACMList_Skyriding+1] = ACMChilds_DragonridingChallenge_DragonIsles_Bronze
    end

    ACMList_Skyriding[#ACMList_Skyriding+1] = {
        18790, -- Dragonriding Challenge: Dragon Isles: Bronze
    }

    local ACMList = {
        _G.EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Dungeons_BrackenhideHollow,
        ACMList_Skyriding
    }

    return ACMList
end