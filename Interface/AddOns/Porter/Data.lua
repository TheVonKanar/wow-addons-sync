-- Data.lua
-- All teleportation spells, items, and toys organized by category.
-- Each entry: { type = "spell"|"item"|"toy", id = <number>, name = "<fallback name>", [classReq], [raceReq] }
-- The addon will query WoW for actual localized names and icons at runtime.

local _, Porter = ...

Porter.Categories = {
    "Hearthstones",
    "Class & Racial",
    "Items",
    "Toys",
    "Dungeons",
    "Raids",
    "Delves",
    "House",
}

-- Categories that support Current / Legacy tabs.
-- Defaults to "current" view when opened.
Porter.TabbedCategories = {
    ["Dungeons"] = true,
    ["Raids"] = true,
}

-- Expansion display order for legacy tabs (most recent first)
Porter.ExpansionOrder = {
    "The War Within",
    "Dragonflight",
    "Shadowlands",
    "Battle for Azeroth",
    "Legion",
    "Warlords of Draenor",
    "Mists of Pandaria",
    "Cataclysm",
}

Porter.TeleportData = {

    ---------------------------------------------------------------------------
    -- HEARTHSTONES
    ---------------------------------------------------------------------------
    ["Hearthstones"] = {
        { type = "spell", id = 8690,   name = "Hearthstone", alwaysAvailable = true },
        { type = "toy", id = 140192, name = "Dalaran Hearthstone" },
        { type = "toy", id = 110560, name = "Garrison Hearthstone" },
        -- Cosmetic hearthstone toys (inn-bound reskins)
        { type = "toy", id = 142542, name = "Tome of Town Portal", cosmetic = true },
        { type = "toy", id = 188952, name = "Dominated Hearthstone", cosmetic = true },
        { type = "toy", id = 172179, name = "Eternal Traveler's Hearthstone", cosmetic = true },
        { type = "toy", id = 200630, name = "Ohn'ir Windsage's Hearthstone", cosmetic = true },
        { type = "toy", id = 208704, name = "Deepdweller's Earthen Hearthstone", cosmetic = true },
        { type = "toy", id = 209035, name = "Hearthstone of the Flame", cosmetic = true },
        { type = "toy", id = 190237, name = "Broker Translocation Matrix", cosmetic = true },
        { type = "toy", id = 184353, name = "Kyrian Hearthstone", cosmetic = true },
        { type = "toy", id = 183716, name = "Venthyr Sinstone", cosmetic = true },
        { type = "toy", id = 180290, name = "Night Fae Hearthstone", cosmetic = true },
        { type = "toy", id = 182773, name = "Necrolord Hearthstone", cosmetic = true },
        { type = "toy", id = 212337, name = "Stone of the Hearth", cosmetic = true },
        { type = "toy", id = 206195, name = "Path of the Naaru", cosmetic = true },
        { type = "toy", id = 260221, name = "Naaru's Embrace", cosmetic = true },
        { type = "toy", id = 166746, name = "Fire Eater's Hearthstone", cosmetic = true },
        { type = "toy", id = 166747, name = "Brewfest Reveler's Hearthstone", cosmetic = true },
        { type = "toy", id = 163045, name = "Headless Horseman's Hearthstone", cosmetic = true },
        { type = "toy", id = 165669, name = "Lunar Elder's Hearthstone", cosmetic = true },
        { type = "toy", id = 165670, name = "Peddlefeet's Lovely Hearthstone", cosmetic = true },
        { type = "toy", id = 165802, name = "Noble Gardener's Hearthstone", cosmetic = true },
        { type = "toy", id = 162973, name = "Greatfather Winter's Hearthstone", cosmetic = true },
        { type = "toy", id = 168907, name = "Holographic Digitalization Hearthstone", cosmetic = true },
        { type = "toy", id = 245970, name = "P.O.S.T. Master's Express Hearthstone", cosmetic = true },
        { type = "toy", id = 193588, name = "Timewalker's Hearthstone", cosmetic = true },
        { type = "toy", id = 228940, name = "Notorious Thread's Hearthstone", cosmetic = true },
        { type = "toy", id = 64488,  name = "The Innkeeper's Daughter", cosmetic = true },
        { type = "toy", id = 93672,  name = "Dark Portal", cosmetic = true },
        { type = "toy", id = 54452,  name = "Ethereal Portal", cosmetic = true },
        { type = "toy", id = 190196, name = "Enlightened Hearthstone", cosmetic = true },
        { type = "toy", id = 246565, name = "Cosmic Hearthstone", cosmetic = true },
        { type = "toy", id = 265100, name = "Corewarden's Hearthstone", cosmetic = true },
        { type = "toy", id = 263933, name = "Preyseeker's Hearthstone", cosmetic = true },
        { type = "toy", id = 235016, name = "Redeployment Module", cosmetic = true },
    },

    ---------------------------------------------------------------------------
    -- CLASS & RACIAL
    ---------------------------------------------------------------------------
    ["Class & Racial"] = {
        -- Mage Teleports (Alliance)
        { type = "spell", id = 3561,   name = "Teleport: Stormwind",            classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 3562,   name = "Teleport: Ironforge",            classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 3565,   name = "Teleport: Darnassus",            classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 32271,  name = "Teleport: Exodar",               classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 49359,  name = "Teleport: Theramore",            classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 33690,  name = "Teleport: Shattrath (Alliance)", classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 132621, name = "Teleport: Vale (Alliance)",      classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 176248, name = "Teleport: Stormshield",          classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 281403, name = "Teleport: Boralus",              classReq = "MAGE", mageType = "teleport" },

        -- Mage Teleports (Horde)
        { type = "spell", id = 3567,   name = "Teleport: Orgrimmar",            classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 3563,   name = "Teleport: Undercity",            classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 3566,   name = "Teleport: Thunder Bluff",        classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 32272,  name = "Teleport: Silvermoon",           classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 49358,  name = "Teleport: Stonard",              classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 35715,  name = "Teleport: Shattrath (Horde)",    classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 132627, name = "Teleport: Vale (Horde)",         classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 176242, name = "Teleport: Warspear",             classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 281404, name = "Teleport: Dazar'alor",           classReq = "MAGE", mageType = "teleport" },

        -- Mage Teleports (Neutral)
        { type = "spell", id = 53140,  name = "Teleport: Dalaran (Northrend)",  classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 224869, name = "Teleport: Dalaran (Broken Isles)", classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 88342,  name = "Teleport: Tol Barad (Alliance)", classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 88344,  name = "Teleport: Tol Barad (Horde)",    classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 395277, name = "Teleport: Valdrakken",           classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 446540, name = "Teleport: Dornogal",             classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 344587, name = "Teleport: Oribos",               classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 120145, name = "Ancient Teleport: Dalaran",      classReq = "MAGE", mageType = "teleport" },
        { type = "spell", id = 193759, name = "Teleport: Hall of the Guardian", classReq = "MAGE", mageType = "teleport" },

        -- Mage Portals (Alliance)
        { type = "spell", id = 10059,  name = "Portal: Stormwind",              classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 11416,  name = "Portal: Ironforge",              classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 11419,  name = "Portal: Darnassus",              classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 32266,  name = "Portal: Exodar",                 classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 49360,  name = "Portal: Theramore",              classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 33691,  name = "Portal: Shattrath (Alliance)",   classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 132620, name = "Portal: Vale (Alliance)",        classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 176246, name = "Portal: Stormshield",            classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 281400, name = "Portal: Boralus",                classReq = "MAGE", mageType = "portal" },

        -- Mage Portals (Horde)
        { type = "spell", id = 11417,  name = "Portal: Orgrimmar",              classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 11418,  name = "Portal: Undercity",              classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 11420,  name = "Portal: Thunder Bluff",          classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 32267,  name = "Portal: Silvermoon",             classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 49361,  name = "Portal: Stonard",                classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 35717,  name = "Portal: Shattrath (Horde)",      classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 132626, name = "Portal: Vale (Horde)",           classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 176244, name = "Portal: Warspear",               classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 281402, name = "Portal: Dazar'alor",             classReq = "MAGE", mageType = "portal" },

        -- Mage Portals (Neutral)
        { type = "spell", id = 53142,  name = "Portal: Dalaran (Northrend)",    classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 224871, name = "Portal: Dalaran (Broken Isles)", classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 88345,  name = "Portal: Tol Barad (Alliance)",   classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 88346,  name = "Portal: Tol Barad (Horde)",      classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 395289, name = "Portal: Valdrakken",             classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 446534, name = "Portal: Dornogal",               classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 344597, name = "Portal: Oribos",                 classReq = "MAGE", mageType = "portal" },
        { type = "spell", id = 120146, name = "Ancient Portal: Dalaran",        classReq = "MAGE", mageType = "portal" },

        -- Druid
        { type = "spell", id = 193753, name = "Dreamwalk",                      classReq = "DRUID" },

        -- Death Knight
        { type = "spell", id = 50977,  name = "Death Gate",                     classReq = "DEATHKNIGHT" },

        -- Monk
        { type = "spell", id = 126892, name = "Zen Pilgrimage",                 classReq = "MONK" },

        -- Shaman
        { type = "spell", id = 556,    name = "Astral Recall",                  classReq = "SHAMAN" },

        -- Dark Iron Dwarf
        { type = "spell", id = 265225, name = "Mole Machine",                   raceReq = "DarkIronDwarf" },

        -- Vulpera
        { type = "spell", id = 312370, name = "Make Camp",                      raceReq = "Vulpera" },
        { type = "spell", id = 312372, name = "Return to Camp",                 raceReq = "Vulpera" },
    },

    ---------------------------------------------------------------------------
    -- ITEMS
    ---------------------------------------------------------------------------
    ["Items"] = {
        { type = "item", id = 63378,  name = "Hellscream's Reach Tabard",       equippable = true },
        { type = "item", id = 63379,  name = "Baradin's Wardens Tabard",       equippable = true },
        { type = "item", id = 65274,  name = "Cloak of Coordination (Horde)",   equippable = true },
        { type = "item", id = 65360,  name = "Cloak of Coordination (Alliance)",equippable = true },
        { type = "item", id = 63352,  name = "Shroud of Cooperation (Horde)",   equippable = true },
        { type = "item", id = 63353,  name = "Shroud of Cooperation (Alliance)",equippable = true },
        { type = "item", id = 63207,  name = "Wrap of Unity (Horde)",          equippable = true },
        { type = "item", id = 63206,  name = "Wrap of Unity (Alliance)",       equippable = true },
        { type = "item", id = 118663, name = "Blessed Medallion of Karabor" },
        { type = "item", id = 140493, name = "Adept's Guide to Dimensional Rifting" },
        { type = "item", id = 52251,  name = "Jaina's Locket" },
        { type = "item", id = 139599, name = "Empowered Ring of the Kirin Tor", equippable = true },
        { type = "item", id = 46874,  name = "Argent Crusader's Tabard",        equippable = true },
        { type = "item", id = 32757,  name = "Blessed Medallion of Karabor" },
        { type = "item", id = 44935,  name = "Ring of the Kirin Tor",           equippable = true },
        { type = "item", id = 40586,  name = "Band of the Kirin Tor",           equippable = true },
        { type = "item", id = 193000, name = "Ring-Bound Hourglass",            equippable = true },
        { type = "item", id = 142469, name = "Violet Seal of the Grand Magus",  equippable = true },
        { type = "item", id = 40585,  name = "Signet of the Kirin Tor",         equippable = true },
        { type = "item", id = 95050,  name = "The Brassiest Knuckle",           equippable = true },
        { type = "item", id = 118907, name = "Pit Fighter's Punching Ring",     equippable = true },
        { type = "item", id = 144391, name = "Pugilist's Powerful Punching Ring",equippable = true },
        { type = "item", id = 128353, name = "Admiral's Compass" },
        { type = "item", id = 219222, name = "Time-Lost Artifact" },
        { type = "item", id = 202046, name = "Lucky Tortollan Charm" },
        { type = "item", id = 132523, name = "Reaves Battery",                  profReq = true },
        { type = "item", id = 144341, name = "Rechargeable Reaves Battery",    profReq = true },
        { type = "item", id = 50287,  name = "Boots of the Bay",              equippable = true },
    },

    ---------------------------------------------------------------------------
    -- TOYS
    ---------------------------------------------------------------------------
    ["Toys"] = {
        -- Unique-destination toys
        { type = "toy", id = 151016, name = "Fractured Necrolyte Skull" },
        { type = "toy", id = 37863,  name = "Direbrew's Remote" },
        { type = "toy", id = 211788, name = "Tess's Peacebloom",               raceReq = "Worgen" },
        { type = "toy", id = 64457,  name = "The Last Relic of Argus" },

        -- Travel Toys
        { type = "toy", id = 243056, name = "Delver's Mana-Bound Ethergate" },
        { type = "toy", id = 48933,  name = "Wormhole Generator: Northrend", profReq = true },
        { type = "toy", id = 87215,  name = "Wormhole Generator: Pandaria", profReq = true },
        { type = "toy", id = 112059, name = "Wormhole Centrifuge", profReq = true },
        { type = "toy", id = 168808, name = "Wormhole Generator: Zandalar", profReq = true },
        { type = "toy", id = 168807, name = "Wormhole Generator: Kul Tiras", profReq = true },
        { type = "toy", id = 172924, name = "Wormhole Generator: Shadowlands", profReq = true },
        { type = "toy", id = 198156, name = "Wyrmhole Generator: Dragon Isles", profReq = true },
        { type = "toy", id = 221966, name = "Wormhole Generator: Khaz Algar", profReq = true },
        { type = "toy", id = 18984,  name = "Dimensional Ripper - Everlook", profReq = true },
        { type = "toy", id = 18986,  name = "Ultrasafe Transporter: Gadgetzan", profReq = true },
        { type = "toy", id = 30542,  name = "Dimensional Ripper - Area 52", profReq = true },
        { type = "toy", id = 30544,  name = "Ultrasafe Transporter: Toshley's Station", profReq = true },
        { type = "toy", id = 151652, name = "Wormhole Generator: Argus", profReq = true },
        { type = "toy", id = 153004, name = "Unstable Portal Emitter" },
        { type = "toy", id = 192443, name = "Element-Infused Rocket Helmet",   profReq = true },
    },

    ---------------------------------------------------------------------------
    -- DUNGEON / RAID TELEPORTS (Hero's Path)
    -- These are dynamically checked at runtime via IsPlayerSpell.
    -- The IDs here cover commonly known teleport spells granted by
    -- completing dungeons/raids on certain difficulties.
    ---------------------------------------------------------------------------
    -- mapID links dungeon teleports to M+ Challenge Mode Map IDs so we can
    -- detect the player's keystone and highlight the matching button.
    -- current = true marks dungeons in the current M+ season.
    ["Dungeons"] = {
        -- TWW Season 3 M+ Pool (current)
        -- mapID = Challenge Mode Map ID from C_ChallengeMode.GetMapTable()
        { type = "spell", id = 1216786, name = "Operation: Floodgate",       current = true, mapID = 525 },
        { type = "spell", id = 1237215, name = "Eco-Dome Al'dani",           current = true, mapID = 542 },
        { type = "spell", id = 445417, name = "Ara-Kara, City of Echoes",    current = true, mapID = 503 },
        { type = "spell", id = 445414, name = "The Dawnbreaker",             current = true, mapID = 505 },
        { type = "spell", id = 445444, name = "Priory of the Sacred Flame",  current = true, mapID = 499 },
        { type = "spell", id = 367416, name = "Tazavesh: Streets of Wonder", current = true, mapID = 391 },
        { type = "spell", id = 367416, name = "Tazavesh: So'leah's Gambit",  current = true, mapID = 392 },
        { type = "spell", id = 354465, name = "Halls of Atonement",          current = true, mapID = 378 },

        -- The War Within (legacy - S1/S2 dungeons)
        { type = "spell", id = 445416, name = "City of Threads",             expansion = "The War Within" },
        { type = "spell", id = 445269, name = "The Stonevault",              expansion = "The War Within" },
        { type = "spell", id = 445440, name = "Cinderbrew Meadery",          expansion = "The War Within" },
        { type = "spell", id = 445441, name = "Darkflame Cleft",             expansion = "The War Within" },
        { type = "spell", id = 445443, name = "The Rookery",                 expansion = "The War Within" },

        -- Legacy Dungeon Teleports (grouped by expansion, newest first)
        -- Dragonflight
        { type = "spell", id = 393267, name = "Brackenhide Hollow",           mapID = 405, expansion = "Dragonflight" },
        { type = "spell", id = 393283, name = "Halls of Infusion",            mapID = 406, expansion = "Dragonflight" },
        { type = "spell", id = 393276, name = "Neltharus",                    mapID = 404, expansion = "Dragonflight" },
        { type = "spell", id = 393222, name = "Uldaman: Legacy of Tyr",       mapID = 403, expansion = "Dragonflight" },
        { type = "spell", id = 424197, name = "Dawn of the Infinite",         mapID = 463, expansion = "Dragonflight" },
        { type = "spell", id = 393279, name = "The Azure Vault",              expansion = "Dragonflight" },
        { type = "spell", id = 393273, name = "Algeth'ar Academy",            expansion = "Dragonflight" },
        { type = "spell", id = 393262, name = "The Nokhud Offensive",         expansion = "Dragonflight" },
        { type = "spell", id = 393256, name = "Ruby Life Pools",              expansion = "Dragonflight" },

        -- Shadowlands
        { type = "spell", id = 354462, name = "The Necrotic Wake",              expansion = "Shadowlands" },
        { type = "spell", id = 354463, name = "Plaguefall",                     expansion = "Shadowlands" },
        { type = "spell", id = 354464, name = "Mists of Tirna Scithe",          expansion = "Shadowlands" },
        { type = "spell", id = 354465, name = "Halls of Atonement",             expansion = "Shadowlands" },
        { type = "spell", id = 354466, name = "Spires of Ascension",            expansion = "Shadowlands" },
        { type = "spell", id = 354467, name = "Theater of Pain",                expansion = "Shadowlands" },
        { type = "spell", id = 354468, name = "De Other Side",                  expansion = "Shadowlands" },
        { type = "spell", id = 354469, name = "Sanguine Depths",                expansion = "Shadowlands" },
        { type = "spell", id = 367416, name = "Tazavesh",                       expansion = "Shadowlands" },

        -- Battle for Azeroth
        { type = "spell", id = 410071, name = "Freehold",                     mapID = 245, expansion = "Battle for Azeroth" },
        { type = "spell", id = 410074, name = "The Underrot",                 mapID = 251, expansion = "Battle for Azeroth" },
        { type = "spell", id = 424167, name = "Waycrest Manor",               mapID = 248, expansion = "Battle for Azeroth" },
        { type = "spell", id = 424187, name = "Atal'Dazar",                   mapID = 244, expansion = "Battle for Azeroth" },
        { type = "spell", id = 373274, name = "Operation: Mechagon",            expansion = "Battle for Azeroth" },
        { type = "spell", id = 445418, name = "Siege of Boralus",               expansion = "Battle for Azeroth" },
        { type = "spell", id = 272268, name = "The MOTHERLODE!!",               expansion = "Battle for Azeroth" },

        -- Legion
        { type = "spell", id = 410078, name = "Neltharion's Lair",             mapID = 206, expansion = "Legion" },
        { type = "spell", id = 424153, name = "Black Rook Hold",               mapID = 199, expansion = "Legion" },
        { type = "spell", id = 424163, name = "Darkheart Thicket",             mapID = 198, expansion = "Legion" },
        { type = "spell", id = 393764, name = "Halls of Valor",                expansion = "Legion" },
        { type = "spell", id = 393766, name = "Court of Stars",                expansion = "Legion" },
        { type = "spell", id = 373262, name = "Return to Karazhan",             expansion = "Legion" },

        -- Warlords of Draenor
        { type = "spell", id = 159901, name = "The Everbloom",                 mapID = 168, expansion = "Warlords of Draenor" },
        { type = "spell", id = 159900, name = "Grimrail Depot",                mapID = 166, expansion = "Warlords of Draenor" },
        { type = "spell", id = 159896, name = "Iron Docks",                    mapID = 169, expansion = "Warlords of Draenor" },
        { type = "spell", id = 159897, name = "Auchindoun",                    expansion = "Warlords of Draenor" },
        { type = "spell", id = 159895, name = "Bloodmaul Slag Mines",          expansion = "Warlords of Draenor" },
        { type = "spell", id = 159899, name = "Shadowmoon Burial Grounds",     expansion = "Warlords of Draenor" },
        { type = "spell", id = 159898, name = "Skyreach",                      expansion = "Warlords of Draenor" },
        { type = "spell", id = 159902, name = "Upper Blackrock Spire",         expansion = "Warlords of Draenor" },

        -- Mists of Pandaria
        { type = "spell", id = 131204, name = "Temple of the Jade Serpent",    mapID = 2,   expansion = "Mists of Pandaria" },
        { type = "spell", id = 131205, name = "Stormstout Brewery",            mapID = 3,   expansion = "Mists of Pandaria" },
        { type = "spell", id = 131206, name = "Shado-Pan Monastery",           mapID = 4,   expansion = "Mists of Pandaria" },
        { type = "spell", id = 131225, name = "Gate of the Setting Sun",       mapID = 5,   expansion = "Mists of Pandaria" },
        { type = "spell", id = 131222, name = "Mogu'shan Palace",              mapID = 6,   expansion = "Mists of Pandaria" },
        { type = "spell", id = 131228, name = "Siege of Niuzao Temple",        expansion = "Mists of Pandaria" },
        { type = "spell", id = 131232, name = "Scholomance",                   expansion = "Mists of Pandaria" },

        -- Cataclysm
        { type = "spell", id = 410080, name = "The Vortex Pinnacle",           mapID = 438, expansion = "Cataclysm" },
        { type = "spell", id = 424142, name = "Throne of the Tides",           mapID = 456, expansion = "Cataclysm" },
        { type = "spell", id = 445424, name = "Grim Batol",                    expansion = "Cataclysm" },
    },

    ---------------------------------------------------------------------------
    -- RAID TELEPORTS (Hero's Path)
    -- current = true marks raids in the current tier.
    ---------------------------------------------------------------------------
    ["Raids"] = {
        -- The War Within (current)
        { type = "spell", id = 1239155, name = "Manaforge Omega",              current = true },
        { type = "spell", id = 1226482, name = "Liberation of Undermine",      current = true },

        -- Legacy Raids (grouped by expansion, newest first)
        -- Dragonflight
        { type = "spell", id = 432254, name = "Vault of the Incarnates",         expansion = "Dragonflight" },
        { type = "spell", id = 432257, name = "Aberrus, the Shadowed Crucible",  expansion = "Dragonflight" },
        { type = "spell", id = 432258, name = "Amirdrassil, the Dream's Hope",   expansion = "Dragonflight" },

        -- Shadowlands
        { type = "spell", id = 373190, name = "Castle Nathria",                  expansion = "Shadowlands" },
        { type = "spell", id = 373191, name = "Sanctum of Domination",           expansion = "Shadowlands" },
        { type = "spell", id = 373192, name = "Sepulcher of the First Ones",     expansion = "Shadowlands" },

        -- Shadowlands Dungeons (legacy)
        -- (Shadowlands dungeon teleports exist but are less commonly held)
    },

    ---------------------------------------------------------------------------
    -- DELVES
    ---------------------------------------------------------------------------
    ["Delves"] = {
        { type = "toy", id = 230850, name = "Delve-O-Bot 7001" },
    },

    ---------------------------------------------------------------------------
    -- HOUSE (populated dynamically from C_Housing API)
    ---------------------------------------------------------------------------
    ["House"] = {},
}

---------------------------------------------------------------------------
-- CHANGELOG (shown once per version, newest first)
---------------------------------------------------------------------------
Porter.ChangelogEntries = {
    {
        version = "1.0.7",
        notes = {
            -- New features
            "Settings moved to WoW's built-in AddOns options (ESC > Options > AddOns > Porter)",
            "Show or hide any category from settings",
            "Added House category with one-click teleport to your player housing",
            "Porter window now auto-resizes when categories are hidden",
            "Added option to hide the minimap icon",
            "\"What's new in Porter?\" changelog popup shows on version updates",
            "Moved Dalaran & Garrison Hearthstones to the Hearthstones section",
            "Random hearthstone now skips cosmetic toys still on cooldown",
            -- Added items/toys/spells
            "Added items: Wrap of Unity, Rechargeable Reaves Battery, Boots of the Bay",
            "Added toys: Direbrew's Remote, Tess's Peacebloom, The Last Relic of Argus, Element-Infused Rocket Helmet, Redeployment Module",
            "Added mage spells: Ancient Teleport/Portal: Dalaran, Teleport: Hall of the Guardian",
            -- Bug fixes
            "Fixed cosmetic hearthstone cooldowns not reflecting guild perk",
            "Fixed Ara-Kara keystone highlight",
        },
    },
    {
        version = "1.0.6",
        notes = {
            "Added random hearthstone feature — uses a random cosmetic hearthstone each time (on by default)",
            "Hearthstone mode configurable in settings: Normal, Random, or a specific cosmetic hearthstone",
            "Random mode now includes the normal Hearthstone spell in the rotation",
            "Added Delve-O-Bot 7001 with random teleport to next bountiful delve",
            "Equippable items now re-equip the previously worn item after casting, or after 12 seconds if interrupted",
            "Re-equip restores the exact item instance (preserving ilvl, enchants, and gems)",
            "Added missing cosmetic hearthstones: Enlightened Hearthstone, Cosmic Hearthstone, and more",
            "Added missing items: Violet Seal of the Grand Magus, Signet of the Kirin Tor, and more",
            "Added Wormhole Generator: Argus to engineering toys",
            "Added Unstable Portal Emitter toy",
            "Added missing Shadowlands and BFA dungeon teleports",
            "Added Return to Karazhan dungeon teleport",
            "Fixed Jaina's Locket item ID",
            "Fixed Holographic Digitalization Hearthstone item ID",
            "Fixed Wormhole Generator: Zandalar and Kul Tiras swapped IDs",
            "Fixed Gate of the Setting Sun and Mogu'shan Palace swapped spell IDs",
            "Removed Brawler's Burly Basilisk (was a mount, not a teleport)",
        },
    },
    {
        version = "1.0.5",
        notes = {
            "Fixed Dalaran Hearthstone and Garrison Hearthstone not appearing for some characters",
            "Engineering toys now correctly hidden on non-Engineer characters",
        },
    },
    {
        version = "1.0.4",
        notes = {
            "Separated cosmetic hearthstones from unique-destination toys",
            "Added settings panel with option to show/hide cosmetic hearthstones",
            "Right-click minimap button now opens settings",
        },
    },
    {
        version = "1.0.3",
        notes = {
            "Fixed cooldown display in instances",
        },
    },
    {
        version = "1.0.2",
        notes = {
            "Fixed taint error when opening Porter inside instanced content",
            "Fixed missing icons for toys on characters where toy data hasn't been cached yet",
            "Fixed flyout overlap where both Teleports and Portals panels could stay visible simultaneously",
            "Fixed Glaive Tosser and Siltwing Albatross incorrectly appearing in the toy list",
            "Made flyout panel fully opaque to prevent clashing with content behind it",
            "Toys now respect usability restrictions",
            "Added zone change detection to refresh cooldowns after dungeon completion",
            "Added Naaru's Embrace to Toys",
        },
    },
    {
        version = "1.0.0",
        notes = {
            "Initial release",
        },
    },
}
