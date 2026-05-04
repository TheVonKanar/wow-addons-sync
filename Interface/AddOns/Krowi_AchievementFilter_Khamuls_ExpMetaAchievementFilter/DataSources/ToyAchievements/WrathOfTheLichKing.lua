local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetWotLKToyAchievements()

    -- Child Achievements The Coin Master
    local ACMChilds_TheCoinMaster = {
        Utilities:GetAchievementName(2096),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            2094, -- A Penny For Your Thougths
            2095, -- Silver in the City
            1957, -- There's Gold In That There Fountain
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME2, -- Wrath of the Lich King
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TheCoinMaster
    end

    ACMListFlat[#ACMListFlat+1] = {
        1956, -- Higher Learning
        2096, -- The Coin Master
        18725, -- Best Stellar
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zones
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(41), -- Dalaram
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                1956, -- Higher Learing
            }
        }
    }

    -- Professions->Fishing
    local ACMList_Professions_Fishing = {
        _G.PROFESSIONS_FISHING,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_Professions_Fishing[#ACMList_Professions_Fishing+1] = ACMChilds_TheCoinMaster
    end

    ACMList_Professions_Fishing[#ACMList_Professions_Fishing+1] = {
        2096, -- The Coin Master
    }

    -- Professions->Inscription
    local ACMList_Professions_Inscription = {
        _G.INSCRIPTION,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            18725, -- Best Stellar
        }
    }

    -- Professions
    local ACMList_Professions = {
        _G.TRADE_SKILLS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Professions_Fishing,
        ACMList_Professions_Inscription
    }


    local ACMList = {
        _G.EXPANSION_NAME2, -- Wrath of the Lich King
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Professions
    }

    return ACMList
end