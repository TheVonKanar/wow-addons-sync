local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetWoDToyAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME5, -- Warlords of Draenor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9838, -- What A Strange, Interdimensional Trip It's Been
            9912, -- Azeroth's Top Twenty Tunes
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Garrison
    local ACMList_Garrison = {
        _G.GARRISON_LOCATION_TOOLTIP, -- Garrison
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9912, -- Azeroth's Top Twenty Tunes
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME5, -- Warlords of Draenor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Garrison,
        {
            9838, -- What A Strange, Interdimensional Trip It's Been
        }
    }

    return ACMList
end