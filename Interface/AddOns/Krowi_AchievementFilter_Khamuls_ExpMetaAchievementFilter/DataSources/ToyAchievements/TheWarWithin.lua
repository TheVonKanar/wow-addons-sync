local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWToyAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40314, -- Fragments of Memories
            41588, -- Read Between the Lines
            42241, -- Overcharged Delver
            41211, -- A Good Day to Dye Hard
        }
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
            Utilities:GetZoneNameByMapID(2274), -- Khaz Algar
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                40314, -- Fragments of Memories
            }
        },
        {
            Utilities:GetZoneNameByMapID(2346), -- Undermine
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                41588, -- Read Between the Lines
            }
        }
    }

    -- Delves
    local ACMList_Delves = {
        _G.DELVES_LABEL, -- Delves
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            42241, -- Overcharged Delver
        }
    }

    -- Raids->Liberation of Undermine
    local ACMList_Raids = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(2779), -- Liberation of Undermine
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                41211, -- A Good Day to Dye Hard
            }
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Delves,
        ACMList_Raids
    }

    return ACMList
end