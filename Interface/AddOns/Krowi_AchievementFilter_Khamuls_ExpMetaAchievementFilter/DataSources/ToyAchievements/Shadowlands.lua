local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetSLToyAchievements()

    -- Child Achievements Twisting Corridors: Layer 4
    local ACMChilds_TwistingCorridors = {
        Utilities:GetAchievementName(14471),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14468, -- Twisting Corridors: Layer 1
            14469, -- Twisting Corridors: Layer 2
            14470, -- Twisting Corridors: Layer 3
        }
    }

    -- Child Achievements The Jailer's Gauntlet: Layer 2
    local ACMChilds_TheJailersGauntlet = {
        Utilities:GetAchievementName(15252),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            15251, -- The Jailer's Gauntlet: Layer 1
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME8, -- Shadowlands
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TwistingCorridors
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TheJailersGauntlet
    end

    ACMListFlat[#ACMListFlat+1] = {
        14721, -- It's In The Mix
        14634, -- Nine Afterlives
        14766, -- Parasoling
        15229, -- Traversing the Spheres
        15211, -- Completing the Code
        14471, -- Twisting Corridors: Layer 4
        15252, -- The Jailer's Gauntlet: Layer 2
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(1536), -- Maldraxxus
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                14721, -- It's In The Mix
                14634, -- Nine Afterlives
            }
        },
        {
            Utilities:GetZoneNameByMapID(1525), -- Rivendreth
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                14766, -- Parasoling
            }
        },
        {
            Utilities:GetZoneNameByMapID(1970), -- Zereth Mortis
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                15229, -- Traversing the Spheres
                15211, -- Completing the Code
            }
        }
    }

    -- Torghast
    local ACMList_Torghast = {
        Utilities:GetZoneNameByMapID(1618), -- Torghast
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_Torghast[#ACMList_Torghast+1] = ACMChilds_TwistingCorridors
        ACMList_Torghast[#ACMList_Torghast+1] = ACMChilds_TheJailersGauntlet
    end

    ACMList_Torghast[#ACMList_Torghast+1] = {
        14471, -- Twisting Corridors: Layer 4
        15252, -- The Jailer's Gauntlet: Layer 2
    }

    local ACMList = {
        _G.EXPANSION_NAME8, -- Shadowlands
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Torghast
    }

    return ACMList
end