local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetLegionToyAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME6, -- Legion
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            10774, -- Hatchling or the Talon
            11427, -- No Shellfish Endeavor
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = {
        _G.ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(650),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                10774, -- Hatchling or the Talon
            }
        },
        {
            _G.CLUB_FINDER_MULTIPLE_CHECKED .. " " .. _G.ZONE, -- Multiple Zone
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                11427, -- No Shellfish Endeavor
            }
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME6, -- Legion
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones
    }

    return ACMList
end