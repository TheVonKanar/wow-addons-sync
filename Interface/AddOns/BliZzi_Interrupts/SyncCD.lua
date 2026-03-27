-- Copyright (c) 2026 BliZzi1337. All rights reserved.
-- Unauthorized copying, modification, distribution or use of this
-- software, in whole or in part, without prior written permission
-- from the copyright holder is strictly prohibited.
--[[
    SyncCD.lua - BliZzi_Interrupts
    ─────────────────────────────────────────────────────────
    Tracks important defensive/offensive cooldowns for party
    members who also have the addon installed.

    Two display modes (configurable in Settings → Party CDs):
      WINDOW  — standalone draggable frame, one row per player
      ATTACH  — icons anchored to existing party unit frames
                (ElvUI or Blizzard compact frames), with
                configurable side (Left/Right/Top/Bottom)

    Spell detection:
      • Own casts     — UNIT_SPELLCAST_SUCCEEDED for "player"
      • Party casts   — SYNCCD net message from other addon users

    Only players who also have the addon installed are tracked.
    ─────────────────────────────────────────────────────────
]]

BIT.SyncCD      = BIT.SyncCD      or {}
BIT.syncCdState = BIT.syncCdState or {}

------------------------------------------------------------
-- Spell database  (SpecID → list of {id, cd, name})
-- Organised alphabetically by class for readability.
-- Only DEF/OFF cooldowns — interrupts are the main tracker's job.
------------------------------------------------------------
BIT.SYNC_SPELLS = {

    -- ── Death Knight ─────────────────────────────────────
    -- Blood
    [250] = {
        { id = 49028, cd =  90, cat = "DMG", name = "Dancing Rune Weapon",
          talentMods = { [377637] = 30 } },                                  -- Insatiable Blade: -30s
        { id = 51052, cd = 120, cat = "DEF", name = "Anti-Magic Zone",
          talentMods = { [374383] = 60 } },                                  -- Assimilation: -60s
        { id = 49039, cd = 120, cat = "DEF", name = "Lichborne",
          talentMods = { [374268] = 30 } },                                  -- Unholy Ground: -30s
        { id = 55233, cd = 180, cat = "DEF", name = "Vampiric Blood"        },
        { id = 48707, cd =  60, cat = "DEF", name = "Anti-Magic Shell",
          talentMods = { [205727] = 20 } },                                  -- Anti-Magic Barrier: -20s
        { id = 48792, cd = 120, cat = "DEF", name = "Icebound Fortitude"   },
    },
    -- Frost
    [251] = {
        { id = 51052, cd = 120, cat = "DEF", name = "Anti-Magic Zone",
          talentMods = { [374383] = 60 } },                                  -- Assimilation: -60s
        { id = 49039, cd = 120, cat = "DEF", name = "Lichborne",
          talentMods = { [374268] = 30 } },                                  -- Unholy Ground: -30s
        { id = 48707, cd =  60, cat = "DEF", name = "Anti-Magic Shell",
          talentMods = { [205727] = 20 } },                                  -- Anti-Magic Barrier: -20s
        { id = 48792, cd = 120, cat = "DEF", name = "Icebound Fortitude"   },
    },
    -- Unholy
    [252] = {
        { id = 51052, cd = 120, cat = "DEF", name = "Anti-Magic Zone",
          talentMods = { [374383] = 60 } },                                  -- Assimilation: -60s
        { id = 49039, cd = 120, cat = "DEF", name = "Lichborne",
          talentMods = { [374268] = 30 } },                                  -- Unholy Ground: -30s
        { id = 48707, cd =  60, cat = "DEF", name = "Anti-Magic Shell",
          talentMods = { [205727] = 20 } },                                  -- Anti-Magic Barrier: -20s
        { id = 48792, cd = 120, cat = "DEF", name = "Icebound Fortitude"   },
    },

    -- ── Demon Hunter ─────────────────────────────────────
    -- Havoc
    [577] = {
        { id = 198589, cd =  60, cat = "DEF", name = "Blur"                },
        { id = 196555, cd = 180, cat = "DEF", name = "Netherwalk"          },
    },
    -- Vengeance
    [581] = {
        { id = 204021, cd =  60, cat = "DEF", name = "Fiery Brand"         },
        { id = 187827, cd = 120, cat = "DEF", name = "Metamorphosis"       },
        { id = 196718, cd = 300, cat = "DEF", name = "Darkness",
          talentMods = { [212593] = 120 } },                                  -- Pitch Black: -120s
    },

    -- ── Druid ─────────────────────────────────────────────
    -- Balance — Incarnation: Chosen of Elune (102560) replaces Celestial Alignment (194223)
    [102] = {
        { id =  22812, cd =  60, cat = "DEF", name = "Barkskin"                                    },
        { id = 194223, cd = 180, cat = "DMG", name = "Celestial Alignment",
          replacedBy = { id = 102560, cd = 180, name = "Incarnation: Chosen of Elune" } },
    },
    -- Feral
    [103] = {
        { id = 106951, cd = 180, cat = "DMG", name = "Berserk"             },
        { id =  61336, cd = 180, cat = "DEF", name = "Survival Instincts"  },
    },
    -- Guardian
    [104] = {
        { id =  22812, cd =  60, cat = "DEF", name = "Barkskin"            },
        { id = 102558, cd = 180, cat = "DEF", name = "Incarnation"         },
        { id =  61336, cd = 180, cat = "DEF", name = "Survival Instincts"  },
        { id =  22842, cd =  36, cat = "DEF", name = "Frenzied Regeneration"},
    },
    -- Restoration
    [105] = {
        { id =  22812, cd =  60, cat = "DEF", name = "Barkskin"            },
        { id = 102342, cd =  90, cat = "DEF", name = "Ironbark",
          talentMods = { [197061] = 15 } },                                  -- Stonebark: -15s
    },

    -- ── Evoker ────────────────────────────────────────────
    -- Devastation
    [1467] = {
        { id = 363916, cd =  90, cat = "DEF", name = "Obsidian Scales"     },
        { id = 357210, cd = 120, cat = "DMG", name = "Deep Breath"         },
        { id = 374227, cd = 120, cat = "DEF", name = "Zephyr"              },
    },
    -- Preservation
    [1468] = {
        { id = 357170, cd =  60, cat = "DEF", name = "Rewind"              },
        { id = 363916, cd =  90, cat = "DEF", name = "Obsidian Scales"     },
        { id = 374227, cd = 120, cat = "DEF", name = "Zephyr"              },
    },
    -- Augmentation
    [1473] = {
        { id = 363916, cd =  90, cat = "DEF", name = "Obsidian Scales"     },
        { id = 403631, cd = 120, cat = "DMG", name = "Breath of Eons"      },
        { id = 374227, cd = 120, cat = "DEF", name = "Zephyr"              },
    },

    -- ── Hunter ────────────────────────────────────────────
    -- Beast Mastery
    [253] = {
        { id =  19574, cd =  90, cat = "DMG", name = "Bestial Wrath"           },
        { id = 186265, cd = 180, cat = "DEF", name = "Aspect of the Turtle",
          talentMods = { [266921] = 30 } },                                      -- Born To Be Wild: -30s
        { id = 264735, cd = 180, cat = "DEF", name = "Survival of the Fittest",
          talentMods = { [266921] = 30 } },                                      -- Born To Be Wild: -30s
        { id = 109304, cd = 120, cat = "DEF", name = "Exhilaration"            },
        { id =  53480, cd =  60, cat = "DEF", name = "Roar of Sacrifice"       },
    },
    -- Marksmanship
    [254] = {
        { id = 288613, cd = 120, cat = "DMG", name = "Trueshot"                },
        { id = 186265, cd = 180, cat = "DEF", name = "Aspect of the Turtle",
          talentMods = { [266921] = 30 } },                                      -- Born To Be Wild: -30s
        { id = 264735, cd = 180, cat = "DEF", name = "Survival of the Fittest",
          talentMods = { [266921] = 30 } },                                      -- Born To Be Wild: -30s
        { id = 109304, cd = 120, cat = "DEF", name = "Exhilaration"            },
        { id =  53480, cd =  60, cat = "DEF", name = "Roar of Sacrifice"       },
    },
    -- Survival
    [255] = {
        { id = 266779, cd = 120, cat = "DMG", name = "Coordinated Assault"     },
        { id = 186265, cd = 180, cat = "DEF", name = "Aspect of the Turtle",
          talentMods = { [266921] = 30 } },                                      -- Born To Be Wild: -30s
        { id = 264735, cd = 180, cat = "DEF", name = "Survival of the Fittest",
          talentMods = { [266921] = 30 } },                                      -- Born To Be Wild: -30s
        { id = 109304, cd = 120, cat = "DEF", name = "Exhilaration"            },
        { id =  53480, cd =  60, cat = "DEF", name = "Roar of Sacrifice"       },
    },

    -- ── Mage ──────────────────────────────────────────────
    -- Arcane
    [62] = {
        { id = 365350, cd =  90, cat = "DMG", name = "Arcane Surge"        },
        { id =  45438, cd = 180, cat = "DEF", name = "Ice Block",
          replacedBy = { id = 414658, cd = 150, charges = 2, name = "Ice Cold" } }, -- 414658 = Ice Cold (talent, 2 charges)
        { id = 342247, cd =  50, cat = "DEF", name = "Alter Time"          }, -- UNIT_SPELLCAST_SUCCEEDED fires as 342247 (TWW)
        { id =  55342, cd = 120, cat = "DEF", name = "Mirror Image"        },
        { id = 110959, cd = 120, cat = "DEF", name = "Greater Invisibility",
          talentMods = { [210476] = 60 } },                                  -- Master of Escape: -60s
    },
    -- Fire
    [63] = {
        { id = 190319, cd = 120, cat = "DMG", name = "Combustion"          },
        { id =  45438, cd = 180, cat = "DEF", name = "Ice Block",
          replacedBy = { id = 414658, cd = 150, charges = 2, name = "Ice Cold" } }, -- 414658 = Ice Cold (talent, 2 charges)
        { id = 342247, cd =  50, cat = "DEF", name = "Alter Time"          }, -- UNIT_SPELLCAST_SUCCEEDED fires as 342247 (TWW)
        { id =  55342, cd = 120, cat = "DEF", name = "Mirror Image"        },
        { id = 110959, cd = 120, cat = "DEF", name = "Greater Invisibility",
          talentMods = { [210476] = 60 } },                                  -- Master of Escape: -60s
    },
    -- Frost
    [64] = {
        { id =  12472, cd = 120, cat = "DMG", name = "Icy Veins"           },
        { id =  45438, cd = 180, cat = "DEF", name = "Ice Block",
          replacedBy = { id = 414658, cd = 150, charges = 2, name = "Ice Cold" } }, -- 414658 = Ice Cold (talent, 2 charges)
        { id = 342247, cd =  50, cat = "DEF", name = "Alter Time"          }, -- UNIT_SPELLCAST_SUCCEEDED fires as 342247 (TWW)
        { id =  55342, cd = 120, cat = "DEF", name = "Mirror Image"        },
        { id = 110959, cd = 120, cat = "DEF", name = "Greater Invisibility",
          talentMods = { [210476] = 60 } },                                  -- Master of Escape: -60s
    },

    -- ── Monk ──────────────────────────────────────────────
    -- Brewmaster
    [268] = {
        { id = 322507, cd =  60, cat = "DEF", name = "Celestial Brew"      },
        { id = 115203, cd = 420, cat = "DEF", name = "Fortifying Brew"     },
    },
    -- Windwalker
    [269] = {
        { id = 116844, cd =  45, cat = "DEF", name = "Touch of Karma"      },
        { id = 137639, cd =  90, cat = "DMG", name = "Storm, Earth, and Fire"},
        { id = 122783, cd =  90, cat = "DEF", name = "Diffuse Magic"       },
    },
    -- Mistweaver
    [270] = {
        { id = 116844, cd =  45, cat = "DEF", name = "Touch of Karma"      },
        { id = 115310, cd = 180, cat = "DEF", name = "Revival"             },
        { id = 122783, cd =  90, cat = "DEF", name = "Diffuse Magic"       },
        { id = 116849, cd = 120, cat = "DEF", name = "Life Cocoon"         },
    },

    -- ── Paladin ───────────────────────────────────────────
    -- Holy
    [65] = {
        { id =  31821, cd = 180, cat = "DEF", name = "Aura Mastery"                },
        { id =   1022, cd = 300, cat = "DEF", name = "Blessing of Protection"      },
        { id =    642, cd = 300, cat = "DEF", name = "Divine Shield"               },
        { id =    633, cd = 600, cat = "DEF", name = "Lay on Hands"                },
        { id =    498, cd =  60, cat = "DEF", name = "Divine Protection"           },
    },
    -- Protection
    [66] = {
        { id =  31850, cd = 120, cat = "DEF", name = "Ardent Defender"             },
        { id =  86659, cd = 300, cat = "DEF", name = "Guardian of Ancient Kings"   },
        { id =    642, cd = 300, cat = "DEF", name = "Divine Shield"               },
        { id =    633, cd = 600, cat = "DEF", name = "Lay on Hands"                },
        { id =    498, cd =  60, cat = "DEF", name = "Divine Protection"           },
    },
    -- Retribution
    [70] = {
        { id =   1022, cd = 300, cat = "DEF", name = "Blessing of Protection"      },
        { id =    642, cd = 300, cat = "DEF", name = "Divine Shield"               },
        { id =    633, cd = 600, cat = "DEF", name = "Lay on Hands"                },
        { id = 184662, cd = 120, cat = "DEF", name = "Shield of Vengeance",
          talentMods = { [374240] = 30 } },                                          -- Hallowed Ground: -30s
    },

    -- ── Priest ────────────────────────────────────────────
    -- Discipline
    [256] = {
        { id =  10060, cd = 120, cat = "DMG", name = "Power Infusion"      },
        { id =  19236, cd =  90, cat = "DEF", name = "Desperate Prayer"    },
        { id =  33206, cd = 180, cat = "DEF", name = "Pain Suppression"    },
    },
    -- Holy
    [257] = {
        { id =  10060, cd = 120, cat = "DMG", name = "Power Infusion"      },
        { id =  19236, cd =  90, cat = "DEF", name = "Desperate Prayer"    },
        { id =  47788, cd = 180, cat = "DEF", name = "Guardian Spirit"     },
    },
    -- Shadow
    [258] = {
        { id =  10060, cd = 120, cat = "DMG", name = "Power Infusion"      },
        { id =  19236, cd =  90, cat = "DEF", name = "Desperate Prayer"    },
        { id =  47585, cd = 120, cat = "DEF", name = "Dispersion",
          talentMods = { [289162] = 30 } },                                  -- Intangibility: -30s
    },

    -- ── Rogue ─────────────────────────────────────────────
    -- Assassination
    [259] = {
        { id =  31224, cd = 120, cat = "DEF", name = "Cloak of Shadows"    },
        { id =   5277, cd = 120, cat = "DEF", name = "Evasion"             },
        { id =   1856, cd = 120, cat = "DEF", name = "Vanish"              },
    },
    -- Outlaw
    [260] = {
        { id =  13750, cd = 180, cat = "DMG", name = "Adrenaline Rush"     },
        { id =  31224, cd = 120, cat = "DEF", name = "Cloak of Shadows"    },
        { id =   5277, cd = 120, cat = "DEF", name = "Evasion"             },
        { id =   1856, cd = 120, cat = "DEF", name = "Vanish"              },
    },
    -- Subtlety
    [261] = {
        { id =  31224, cd = 120, cat = "DEF", name = "Cloak of Shadows"    },
        { id =   5277, cd = 120, cat = "DEF", name = "Evasion"             },
        { id =   1856, cd = 120, cat = "DEF", name = "Vanish"              },
    },

    -- ── Shaman ────────────────────────────────────────────
    -- Elemental
    [262] = {
        { id = 191634, cd =  60, cat = "DMG", name = "Stormkeeper"         },
        { id = 108271, cd =  90, cat = "DEF", name = "Astral Shift"        },
        { id = 198103, cd = 300, cat = "DEF", name = "Earth Elemental"     },
        { id = 108270, cd =  60, cat = "DEF", name = "Stone Bulwark Totem",
          talentMods = { [383017] = 30 } },                                  -- Guardian Totems: -30s
    },
    -- Enhancement
    [263] = {
        { id = 108271, cd =  90, cat = "DEF", name = "Astral Shift"        },
        { id = 198103, cd = 300, cat = "DEF", name = "Earth Elemental"     },
    },
    -- Restoration
    [264] = {
        { id = 108271, cd =  90, cat = "DEF", name = "Astral Shift"        },
        { id =  98008, cd = 180, cat = "DEF", name = "Spirit Link Totem"   },
        { id = 198103, cd = 300, cat = "DEF", name = "Earth Elemental"     },
        { id = 108270, cd =  60, cat = "DEF", name = "Stone Bulwark Totem",
          talentMods = { [383017] = 30 } },                                  -- Guardian Totems: -30s
    },

    -- ── Warlock ───────────────────────────────────────────
    -- Affliction / Demonology / Destruction (same CDs)
    [265] = {
        { id = 108416, cd =  60, cat = "DEF", name = "Dark Pact",
          talentMods = { [317138] = 15 } },                                  -- Strength of Will: -15s
        { id = 104773, cd = 180, cat = "DEF", name = "Unending Resolve"    },
    },
    [266] = {
        { id = 108416, cd =  60, cat = "DEF", name = "Dark Pact",
          talentMods = { [317138] = 15 } },                                  -- Strength of Will: -15s
        { id = 104773, cd = 180, cat = "DEF", name = "Unending Resolve"    },
    },
    [267] = {
        { id = 108416, cd =  60, cat = "DEF", name = "Dark Pact",
          talentMods = { [317138] = 15 } },                                  -- Strength of Will: -15s
        { id = 104773, cd = 180, cat = "DEF", name = "Unending Resolve"    },
    },

    -- ── Warrior ───────────────────────────────────────────
    -- Arms
    [71] = {
        { id = 118038, cd = 120, cat = "DEF", name = "Die by the Sword"    },
        { id =  97462, cd = 180, cat = "DEF", name = "Rallying Cry",
          talentMods = { [386631] = 30 } },                                  -- Stalwart Guardian: -30s
        { id =  23920, cd =  25, cat = "DEF", name = "Spell Reflection"    },
    },
    -- Fury
    [72] = {
        { id = 184364, cd = 120, cat = "DEF", name = "Enraged Regeneration"},
        { id =  97462, cd = 180, cat = "DEF", name = "Rallying Cry",
          talentMods = { [386631] = 30 } },                                  -- Stalwart Guardian: -30s
        { id =  23920, cd =  25, cat = "DEF", name = "Spell Reflection"    },
    },
    -- Protection
    [73] = {
        { id =    871, cd = 240, cat = "DEF", name = "Shield Wall"         },
        { id =  12975, cd = 180, cat = "DEF", name = "Last Stand"          },
        { id =  97462, cd = 180, cat = "DEF", name = "Rallying Cry",
          talentMods = { [386631] = 30 } },                                  -- Stalwart Guardian: -30s
        { id =  23920, cd =  25, cat = "DEF", name = "Spell Reflection"    },
    },
}

------------------------------------------------------------
-- CC Spells  (merged into SYNC_SPELLS at load time)
-- Tracked via COMBAT_LOG_EVENT_UNFILTERED — no addon needed.
------------------------------------------------------------
local CC_SPELLS = {
    -- ── Death Knight ─────────────────────────────────────
    [250] = { { id = 221562, cd = 45, cat = "CC", name = "Asphyxiate" } },
    [251] = { { id = 221562, cd = 45, cat = "CC", name = "Asphyxiate" } },
    [252] = { { id = 221562, cd = 45, cat = "CC", name = "Asphyxiate" } },

    -- ── Demon Hunter ─────────────────────────────────────
    [577]  = {
        { id = 179057, cd = 45, cat = "CC", name = "Chaos Nova" },
        { id = 217832, cd = 45, cat = "CC", name = "Imprison"   },
    },
    [581]  = {
        { id = 179057, cd =  45, cat = "CC", name = "Chaos Nova"       },
        { id = 217832, cd =  45, cat = "CC", name = "Imprison"         },
        { id = 202137, cd =  90, cat = "CC", name = "Sigil of Silence" },
    },
    [1480] = {
        { id = 179057, cd = 45, cat = "CC", name = "Chaos Nova" },
        { id = 217832, cd = 45, cat = "CC", name = "Imprison"   },
    },

    -- ── Druid ─────────────────────────────────────────────
    [102] = {
        { id =   5211, cd = 60, cat = "CC", name = "Mighty Bash"         },
        { id =     99, cd = 30, cat = "CC", name = "Incapacitating Roar" },
        { id = 132469, cd = 30, cat = "CC", name = "Typhoon"             },
    },
    [103] = {
        { id =   5211, cd = 60, cat = "CC", name = "Mighty Bash"         },
        { id =     99, cd = 30, cat = "CC", name = "Incapacitating Roar" },
    },
    [104] = {
        { id =   5211, cd = 60, cat = "CC", name = "Mighty Bash"         },
        { id =     99, cd = 30, cat = "CC", name = "Incapacitating Roar" },
    },
    [105] = {
        { id =     99, cd = 30, cat = "CC", name = "Incapacitating Roar" },
        { id =   5211, cd = 60, cat = "CC", name = "Mighty Bash"         },
    },

    -- ── Evoker ────────────────────────────────────────────
    [1467] = {
        { id = 357214, cd = 45, cat = "CC", name = "Wing Buffet" },
        { id = 361500, cd = 45, cat = "CC", name = "Tail Swipe"  },
    },
    [1468] = {
        { id = 357214, cd = 45, cat = "CC", name = "Wing Buffet" },
        { id = 361500, cd = 45, cat = "CC", name = "Tail Swipe"  },
    },
    [1473] = {
        { id = 357214, cd = 45, cat = "CC", name = "Wing Buffet" },
        { id = 361500, cd = 45, cat = "CC", name = "Tail Swipe"  },
    },

    -- ── Hunter ────────────────────────────────────────────
    [253] = {
        { id =  19577, cd = 60, cat = "CC", name = "Intimidation"  },
        { id =   3355, cd = 30, cat = "CC", name = "Freezing Trap" },
        { id = 109248, cd = 45, cat = "CC", name = "Binding Shot"  },
    },
    [254] = {
        { id =  19577, cd = 60, cat = "CC", name = "Intimidation"  },
        { id =   3355, cd = 30, cat = "CC", name = "Freezing Trap" },
        { id = 109248, cd = 45, cat = "CC", name = "Binding Shot"  },
    },
    [255] = {
        { id =  19577, cd = 60, cat = "CC", name = "Intimidation"  },
        { id =   3355, cd = 30, cat = "CC", name = "Freezing Trap" },
        { id = 109248, cd = 45, cat = "CC", name = "Binding Shot"  },
    },

    -- ── Mage ──────────────────────────────────────────────
    [62] = {
        { id =  31661, cd = 45, cat = "CC", name = "Dragon's Breath" },
        { id = 113724, cd = 45, cat = "CC", name = "Ring of Frost"   },
        { id = 157980, cd = 45, cat = "CC", name = "Supernova"       },
    },
    [63] = {
        { id =  31661, cd = 45, cat = "CC", name = "Dragon's Breath" },
        { id = 113724, cd = 45, cat = "CC", name = "Ring of Frost"   },
        { id = 157980, cd = 45, cat = "CC", name = "Supernova"       },
    },
    [64] = {
        { id =  31661, cd = 45, cat = "CC", name = "Dragon's Breath" },
        { id = 113724, cd = 45, cat = "CC", name = "Ring of Frost"   },
        { id = 157980, cd = 45, cat = "CC", name = "Supernova"       },
    },

    -- ── Monk ──────────────────────────────────────────────
    [268] = {
        { id = 119381, cd = 60, cat = "CC", name = "Leg Sweep"  },
        { id = 115078, cd = 45, cat = "CC", name = "Paralysis"  },
    },
    [269] = {
        { id = 119381, cd = 60, cat = "CC", name = "Leg Sweep"  },
        { id = 115078, cd = 45, cat = "CC", name = "Paralysis"  },
    },
    [270] = {
        { id = 119381, cd = 60, cat = "CC", name = "Leg Sweep"  },
        { id = 115078, cd = 45, cat = "CC", name = "Paralysis"  },
    },

    -- ── Paladin ───────────────────────────────────────────
    [65] = {
        { id =    853, cd =  60, cat = "CC", name = "Hammer of Justice" },
        { id = 115750, cd =  90, cat = "CC", name = "Blinding Light"    },
    },
    [66] = {
        { id =    853, cd =  60, cat = "CC", name = "Hammer of Justice" },
        { id = 115750, cd =  90, cat = "CC", name = "Blinding Light"    },
    },
    [70] = {
        { id =    853, cd =  60, cat = "CC", name = "Hammer of Justice" },
        { id = 115750, cd =  90, cat = "CC", name = "Blinding Light"    },
    },

    -- ── Priest ────────────────────────────────────────────
    [256] = {
        { id = 8122, cd = 45, cat = "CC", name = "Psychic Scream" },
    },
    [257] = {
        { id =  8122, cd = 45, cat = "CC", name = "Psychic Scream"      },
        { id = 88625, cd = 60, cat = "CC", name = "Holy Word: Chastise" },
    },
    [258] = {
        { id = 8122, cd = 45, cat = "CC", name = "Psychic Scream" },
    },

    -- ── Rogue ─────────────────────────────────────────────
    [259] = { { id = 2094, cd = 90, cat = "CC", name = "Blind" } },
    [260] = { { id = 2094, cd = 90, cat = "CC", name = "Blind" } },
    [261] = { { id = 2094, cd = 90, cat = "CC", name = "Blind" } },

    -- ── Shaman ────────────────────────────────────────────
    [262] = {
        { id =  51514, cd = 30, cat = "CC", name = "Hex"             },
        { id = 192058, cd = 60, cat = "CC", name = "Capacitor Totem" },
    },
    [263] = {
        { id =  51514, cd = 30, cat = "CC", name = "Hex"             },
        { id = 192058, cd = 60, cat = "CC", name = "Capacitor Totem" },
    },
    [264] = {
        { id =  51514, cd = 30, cat = "CC", name = "Hex"             },
        { id = 192058, cd = 60, cat = "CC", name = "Capacitor Totem" },
    },

    -- ── Warlock ───────────────────────────────────────────
    [265] = {
        { id =  6789, cd = 45, cat = "CC", name = "Mortal Coil"  },
        { id = 30283, cd = 30, cat = "CC", name = "Shadowfury"   },
        { id =  5484, cd = 20, cat = "CC", name = "Fear"         },
    },
    [266] = {
        { id =  6789, cd = 45, cat = "CC", name = "Mortal Coil"  },
        { id = 30283, cd = 30, cat = "CC", name = "Shadowfury"   },
        { id =  5484, cd = 20, cat = "CC", name = "Fear"         },
    },
    [267] = {
        { id =  6789, cd = 45, cat = "CC", name = "Mortal Coil"  },
        { id = 30283, cd = 30, cat = "CC", name = "Shadowfury"   },
        { id =  5484, cd = 20, cat = "CC", name = "Fear"         },
    },

    -- ── Warrior ───────────────────────────────────────────
    [71] = {
        { id =  5246, cd = 90, cat = "CC", name = "Intimidating Shout" },
        { id = 107570, cd = 30, cat = "CC", name = "Storm Bolt"        },
        { id =  46968, cd = 40, cat = "CC", name = "Shockwave"         },
    },
    [72] = {
        { id =  5246, cd = 90, cat = "CC", name = "Intimidating Shout" },
        { id = 107570, cd = 30, cat = "CC", name = "Storm Bolt"        },
    },
    [73] = {
        { id =  5246, cd = 90, cat = "CC", name = "Intimidating Shout" },
        { id =  46968, cd = 40, cat = "CC", name = "Shockwave"         },
        { id = 107570, cd = 30, cat = "CC", name = "Storm Bolt"        },
    },
}

-- Merge CC spells into SYNC_SPELLS
for specID, ccList in pairs(CC_SPELLS) do
    if not BIT.SYNC_SPELLS[specID] then BIT.SYNC_SPELLS[specID] = {} end
    local tbl = BIT.SYNC_SPELLS[specID]
    for _, s in ipairs(ccList) do
        tbl[#tbl + 1] = s
    end
end

-- reverse lookup: replacedBy.id → base spell id (for party member CD tracking)
local replacedByToBase = {}
for _, spells in pairs(BIT.SYNC_SPELLS) do
    for _, s in ipairs(spells) do
        if s.replacedBy then
            replacedByToBase[s.replacedBy.id] = s.id
        end
    end
end

-- collect all unique spells across all specs (used by settings page)
local function CollectAllSpells()
    local seen, list = {}, {}
    for _, spells in pairs(BIT.SYNC_SPELLS) do
        for _, s in ipairs(spells) do
            if not seen[s.id] then
                seen[s.id] = true
                list[#list+1] = { id = s.id, name = s.name, cd = s.cd }
            end
        end
    end
    table.sort(list, function(a, b) return a.name < b.name end)
    return list
end
BIT.SyncCD.allSpells = CollectAllSpells


------------------------------------------------------------
-- Constants
------------------------------------------------------------
local NAME_W   = 80
local function ICON_SIZE() return (BIT.db and BIT.db.syncCdIconSize) or 28 end
local function ICON_PAD()  return (BIT.db and BIT.db.syncCdIconSpacing ~= nil) and BIT.db.syncCdIconSpacing or 4 end
local function ROW_H()     return ICON_SIZE() + 6 end

------------------------------------------------------------
-- Helpers
------------------------------------------------------------
local function IsSpellEnabled(sid)
    return not (BIT.db.syncCdDisabled and BIT.db.syncCdDisabled[sid])
end

local function GetCatRow(cat)
    if cat == "DMG" then return tonumber(BIT.db.syncCdCatRowDMG) or 1 end
    if cat == "DEF" then return tonumber(BIT.db.syncCdCatRowDEF) or 2 end
    if cat == "CC"  then return tonumber(BIT.db.syncCdCatRowCC)  or 1 end
    return 1
end

local function IsCatEnabled(cat)
    if cat == "CC"  then return BIT.db.syncCdShowCC  ~= false end
    if cat == "DEF" then return BIT.db.syncCdShowDEF ~= false end
    if cat == "DMG" then return BIT.db.syncCdShowDMG ~= false end
    return true
end

local function GetSpecForPlayer(name)
    -- check registry entry first (set by inspect scan)
    local entry = BIT.SyncCD.users and BIT.SyncCD.users[name]
    if entry and entry.specID and entry.specID > 0 then
        return entry.specID
    end
    -- own player
    if name == BIT.myName then
        local idx = GetSpecialization()
        return idx and select(1, GetSpecializationInfo(idx))
    end
    -- fallback: check party unit frames directly and cache the result
    for i = 1, 4 do
        local u = "party" .. i
        if UnitExists(u) and UnitName(u) == name then
            local sid = GetInspectSpecialization(u)
            if sid and sid > 0 then
                if not BIT.SyncCD.users then BIT.SyncCD.users = {} end
                if not BIT.SyncCD.users[name] then BIT.SyncCD.users[name] = {} end
                BIT.SyncCD.users[name].specID = sid
                return sid
            end
            return nil
        end
    end
end

local function GetSpellsForPlayer(name)
    local specID = GetSpecForPlayer(name)
    if not specID then return {} end
    local spells = BIT.SYNC_SPELLS[specID]
    if not spells then return {} end
    local isOwnPlayer = (name == BIT.myName)
    local out = {}
    for _, s in ipairs(spells) do
        if s.replacedBy then
            if not IsCatEnabled(s.cat) then
                -- skip entire entry (base + replacement) when category is hidden
            elseif isOwnPlayer then
                -- own player: check spellbook to see which version is active
                local ok, known = pcall(C_SpellBook.IsSpellKnown, s.replacedBy.id)
                if ok and known then
                    if IsSpellEnabled(s.replacedBy.id) then out[#out+1] = s.replacedBy end
                else
                    if IsSpellEnabled(s.id) then out[#out+1] = s end
                end
            else
                -- party member: combine cast-history (knownReplacements) and inspect talent data (knownSpells)
                local userEntry = BIT.SyncCD.users and BIT.SyncCD.users[name]
                local ks        = userEntry and userEntry.knownSpells
                local knownRepl = userEntry and userEntry.knownReplacements and userEntry.knownReplacements[s.id]
                -- Replacement shown if: seen casting it, or talent scan confirms it (and not the base)
                local hasRepl = knownRepl or (ks and ks[s.replacedBy.id])
                -- Base shown if: no scan data (safe default), or scan explicitly lists it
                local hasBase = not ks or ks[s.id]
                if hasRepl and IsSpellEnabled(s.replacedBy.id) and IsCatEnabled(s.replacedBy.cat or s.cat) then
                    out[#out+1] = s.replacedBy
                elseif hasBase and IsSpellEnabled(s.id) then
                    out[#out+1] = s
                end
            end
        elseif IsSpellEnabled(s.id) and IsCatEnabled(s.cat) then
            -- Own player: verify the spell is actually learned/talented
            -- Party member: filter by inspect talent scan when available
            if isOwnPlayer then
                local ok, known = pcall(C_SpellBook.IsSpellKnown, s.id)
                if ok and known then out[#out+1] = s end
            else
                local userEntry = BIT.SyncCD.users and BIT.SyncCD.users[name]
                local ks = userEntry and userEntry.knownSpells
                if not ks or ks[s.id] then out[#out+1] = s end
            end
        end
    end
    return out
end

local function GetCdForSpell(name, sid)
    local specID = GetSpecForPlayer(name)
    local spells = specID and BIT.SYNC_SPELLS[specID]
    if spells then
        for _, s in ipairs(spells) do
            if s.id == sid then return s.cd end
        end
    end
    return 30
end

------------------------------------------------------------
-- Frame detection (ElvUI, DandersFrames, or Blizzard)
------------------------------------------------------------
local function IsElvUIActive()
    return _G["ElvUI"] ~= nil or _G["ElvUF_PartyGroup1"] ~= nil
end

local function IsDandersActive()
    return _G["DandersPartyHeader"] ~= nil
end

local function IsGrid2Active()
    return _G["Grid2LayoutFrame"] ~= nil
end

-- Generic scan: iterate numbered unit buttons from an addon, match by .unit property
local function ScanUnitButtons(prefix, unit, maxSlots)
    for i = 1, maxSlots do
        local btn = _G[prefix .. i]
        if btn and btn.unit and UnitIsUnit(btn.unit, unit) then return btn end
    end
end

-- Grid2 can have multiple layout headers (Header1, Header2 … for raids)
local function ScanGrid2(unit)
    for h = 1, 8 do
        local f = ScanUnitButtons("Grid2LayoutHeader" .. h .. "UnitButton", unit, 40)
        if f then return f end
    end
end

local function GetPartyUnitFrame(unit)
    -- Only attach to frames that are actually visible on screen.
    local function visible(f) return f and f:IsVisible() end

    -- ── ElvUI ────────────────────────────────────────────────────────
    if IsElvUIActive() then
        -- Party group children first (covers both normal members AND
        -- "show player in party" mode where the player slot is in the group).
        local group = _G["ElvUF_PartyGroup1"]
        if group then
            for i = 1, group:GetNumChildren() do
                local child = select(i, group:GetChildren())
                if visible(child) and child.unit and UnitIsUnit(child.unit, unit) then
                    return child
                end
            end
        end
        -- Dedicated player frame (solo or "hide player in party" mode).
        if unit == "player" then
            local pf = _G["ElvUF_Player"]
            if visible(pf) then return pf end
        end
        -- Fallback: named globals (older ElvUI builds).
        local f = ScanUnitButtons("ElvUF_PartyGroup1UnitButton", unit, 5)
        if visible(f) then return f end
    end

    -- ── DandersFrames ────────────────────────────────────────────────
    if IsDandersActive() then
        local f = ScanUnitButtons("DandersPartyHeaderUnitButton", unit, 5)
        if visible(f) then return f end
        local playerBtn = _G["DandersPartyHeaderUnitButton0"] or _G["DandersPlayerFrame"]
        if visible(playerBtn) and unit == "player" then return playerBtn end
    end

    -- ── Grid2 ────────────────────────────────────────────────────────
    if IsGrid2Active() then
        local f = ScanGrid2(unit)
        if visible(f) then return f end
    end

    -- ── Blizzard New Party Frames (10.0+ / Midnight 12.0) ────────────
    -- PartyFrame.MemberFrame1–4 replaced CompactPartyFrameMember in 10.0
    local pf = _G["PartyFrame"]
    if pf then
        for i = 1, 4 do
            local f = pf["MemberFrame" .. i]
            if visible(f) and f.unit and UnitIsUnit(f.unit, unit) then return f end
        end
    end

    -- ── Blizzard player frame (solo / no party addon) ─────────────────
    if unit == "player" then
        local pf = _G["PlayerFrame"]
        if visible(pf) then return pf end
    end

    -- ── Blizzard Compact Frames (legacy / raid) ────────────────────
    -- Scan by .unit property — compact frame order ≠ party slot number
    for i = 1, 5 do
        local f = _G["CompactPartyFrameMember" .. i]
        if visible(f) and f.unit and UnitIsUnit(f.unit, unit) then return f end
    end
    for i = 1, 40 do
        local f = _G["CompactRaidFrame" .. i]
        if visible(f) and f.unit and UnitIsUnit(f.unit, unit) then return f end
    end
end

-- Spells whose icon texture should come from a different spell ID
local SPELL_ICON_OVERRIDE = {
    [342247] = 110909,  -- Alter Time: use original spell icon (FileID 609811)
}

------------------------------------------------------------
-- Icon creation
------------------------------------------------------------
local function CreateIcon(parent, spellID)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(ICON_SIZE(), ICON_SIZE())

    f.tex = f:CreateTexture(nil, "ARTWORK")
    f.tex:SetAllPoints()
    f.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    local iconSrc = SPELL_ICON_OVERRIDE[spellID] or spellID
    local icon = C_Spell.GetSpellTexture(iconSrc)
    if icon then f.tex:SetTexture(icon) end

    f.cd = CreateFrame("Cooldown", nil, f, "CooldownFrameTemplate")
    f.cd:SetAllPoints()
    f.cd:SetDrawEdge(true)
    f.cd:SetReverse(false)
    f.cd:SetHideCountdownNumbers(true)  -- suppress built-in numbers; we draw our own

    -- text holder frame above the cooldown swipe layer
    local textHolder = CreateFrame("Frame", nil, f)
    textHolder:SetAllPoints()
    textHolder:SetFrameLevel(f.cd:GetFrameLevel() + 5)

    f.cdText = textHolder:CreateFontString(nil, "OVERLAY")
    local cSize = (BIT.db and BIT.db.syncCdCounterSize and BIT.db.syncCdCounterSize > 0)
                  and BIT.db.syncCdCounterSize or 14
    BIT.Media:SetFont(f.cdText, cSize)
    f.cdText:SetPoint("CENTER")
    f.cdText:Hide()

    -- Charge count badge (bottom-right corner, only shown for multi-charge spells)
    f.chargeBadge = textHolder:CreateFontString(nil, "OVERLAY")
    BIT.Media:SetFont(f.chargeBadge, 10)
    f.chargeBadge:SetTextColor(1, 0.82, 0, 1)  -- gold
    f.chargeBadge:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 1)
    f.chargeBadge:Hide()
    f._maxCharges = 0

    local border = f:CreateTexture(nil, "BORDER")
    border:SetPoint("TOPLEFT",     f, "TOPLEFT",     -1,  1)
    border:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",  1, -1)
    border:SetColorTexture(0, 0, 0, 1)
    f.border = border

    f:EnableMouse(true)
    f:SetScript("OnEnter", function()
        if not BIT.db.syncCdTooltip then return end
        GameTooltip:SetOwner(f, "ANCHOR_RIGHT")
        GameTooltip:SetSpellByID(f.spellID)
        GameTooltip:Show()
    end)
    f:SetScript("OnLeave", function() GameTooltip:Hide() end)
    f:SetScript("OnMouseDown", function(self, button)
        if button ~= "LeftButton" or not BIT.db.syncCdClickAnnounce then return end
        if BIT.db.antiSpam and f.announceLockedUntil and GetTime() < f.announceLockedUntil then return end
        local playerName = f._playerName or "?"
        local spellName  = f._spellName  or (f.spellID and C_Spell.GetSpellName(f.spellID)) or "?"
        local cdState = BIT.syncCdState and BIT.syncCdState[playerName]
        local cdEnd   = cdState and cdState[f.spellID]
        local rem     = cdEnd and math.max(0, cdEnd - GetTime()) or 0
        local msg
        if rem > 0.5 then
            msg = string.format(BIT.L["MSG_ANNOUNCE_CD"], playerName, spellName, rem)
        else
            msg = string.format(BIT.L["MSG_ANNOUNCE_READY"], playerName, spellName)
        end
        local channel = BIT.db.announceChannel or "PARTY"
        if channel == "YELL" or (IsInGroup() and (channel == "PARTY" or channel == "SAY")) then
            C_ChatInfo.SendChatMessage(msg, channel)
        else
            print("|cff0091edBliZzi|r|cffffa300Interrupts|r " .. msg)
        end
        if BIT.db.antiSpam then
            f.announceLockedUntil = GetTime() + (rem > 0.5 and rem or 5)
        end
    end)

    f.spellID = spellID
    return f
end

local function FormatCdTime(sec)
    if BIT.db and BIT.db.syncCdTimeFormat == "MMSS" and sec >= 60 then
        return string.format("%d:%02d", math.floor(sec / 60), sec % 60)
    end
    return tostring(sec)
end

------------------------------------------------------------
-- Shared state tables (declared here so buff system and both modes can access them)
------------------------------------------------------------
local syncRows     = {}  -- name → { frame, nameText, icons={spellID→ico} }
local attachedBars = {}  -- unit → { frame, icons={spellID→ico} }

------------------------------------------------------------
-- Buff-based green highlight system
-- Spells that also apply a visible buff: spellID → buffAuraID
------------------------------------------------------------
local SPELL_BUFF_MAP = {
    [187827] = 187827,  -- Metamorphosis (Vengeance DH / Last Resort)
    [342247] = 110909,  -- Alter Time: cast ID → buff aura ID
}

local activeBuffs = {}  -- name → { [buffID] = true }

local function HighlightIcon(ico, active)
    if not ico or not ico.border then return end
    if active then
        ico.border:SetColorTexture(0, 0.85, 0.2, 1)
    else
        ico.border:SetColorTexture(0, 0, 0, 1)
    end
end

local function RefreshBuffHighlights(name)
    local buffs = activeBuffs[name]
    local function applyIcons(icons)
        for _, ico in pairs(icons) do
            local buffID = SPELL_BUFF_MAP[ico.spellID]
            HighlightIcon(ico, buffs and buffs[buffID] == true)
        end
    end
    local row = syncRows[name]
    if row then applyIcons(row.icons) end
    for unit, bar in pairs(attachedBars) do
        local n = (unit == "player") and BIT.myName or UnitName(unit)
        if n == name then applyIcons(bar.icons) end
    end
end

do
    local buffAuraFrame = CreateFrame("Frame")
    buffAuraFrame:RegisterEvent("UNIT_AURA")
    buffAuraFrame:SetScript("OnEvent", function(_, _, unit)
        if not unit then return end
        local isPlayer = (unit == "player")
        if not isPlayer and not unit:find("^party%d$") then return end

        local name = isPlayer and BIT.myName or UnitName(unit)
        if not name then return end

        local changed = false
        if not activeBuffs[name] then activeBuffs[name] = {} end

        for spellID, buffID in pairs(SPELL_BUFF_MAP) do
            local wasActive = activeBuffs[name][buffID]
            local ok, auraData = pcall(C_UnitAuras.GetAuraDataBySpellID, unit, buffID, "HELPFUL")
            local nowActive = ok and auraData ~= nil
            if BIT.debugMode and (buffID == 110909 or buffID == 342247) then
                print("|cff0091edBIT|r |cFFAAAAAA[SyncCD-AURA]|r unit=" .. tostring(unit)
                      .. " buffID=" .. tostring(buffID) .. " now=" .. tostring(nowActive)
                      .. " was=" .. tostring(wasActive ~= nil))
            end

            if nowActive ~= wasActive then
                activeBuffs[name][buffID] = nowActive or nil
                changed = true

                -- Last Resort detection: Meta buff appeared but no tracked CD running
                -- (manual cast would have set syncCdState via AnnounceSync/OnSpellUsed)
                if nowActive and buffID == 187827 then
                    local delay = isPlayer and 0 or 0.5
                    C_Timer.After(delay, function()
                        if not (activeBuffs[name] and activeBuffs[name][187827]) then return end
                        local cdState = BIT.syncCdState and BIT.syncCdState[name]
                        local cdEnd   = cdState and cdState[187827]
                        if not cdEnd or cdEnd <= GetTime() then
                            -- Last Resort triggered Meta — start CD tracking + announce for own player
                            BIT.SyncCD:OnSpellUsed(name, 187827, 120)
                            if isPlayer and BIT.Net then BIT.Net:AnnounceSync(187827, 120) end
                        end
                    end)
                elseif nowActive and spellID == 342247 then
                    -- Alter Time: buff 110909 appeared — UNIT_SPELLCAST_SUCCEEDED can miss this
                    -- (spell is still castable while buff is active, so GetSpellCooldown returns 0)
                    local delay = isPlayer and 0 or 0.5
                    C_Timer.After(delay, function()
                        if not (activeBuffs[name] and activeBuffs[name][110909]) then return end
                        local cdState = BIT.syncCdState and BIT.syncCdState[name]
                        local cdEnd   = cdState and cdState[342247]
                        if not cdEnd or cdEnd <= GetTime() then
                            BIT.SyncCD:OnSpellUsed(name, 342247, 50)
                            if isPlayer and BIT.Net then BIT.Net:AnnounceSync(342247, 50) end
                        end
                    end)
                end
            end
        end

        -- Also check buff 342246 (alternative Alter Time aura ID in TWW, per MRT data)
        do
            local altID  = 342246
            local wasAlt = activeBuffs[name][altID]
            local okA, adA = pcall(C_UnitAuras.GetAuraDataBySpellID, unit, altID, "HELPFUL")
            local nowAlt   = okA and adA ~= nil
            if BIT.debugMode then
                print("|cff0091edBIT|r |cFFAAAAAA[SyncCD-AURA]|r unit=" .. tostring(unit)
                      .. " buffID=342246(alt) now=" .. tostring(nowAlt)
                      .. " was=" .. tostring(wasAlt ~= nil))
            end
            if nowAlt ~= wasAlt then
                activeBuffs[name][altID] = nowAlt or nil
                changed = true
                if nowAlt then
                    local delay = isPlayer and 0 or 0.5
                    C_Timer.After(delay, function()
                        if not (activeBuffs[name] and activeBuffs[name][altID]) then return end
                        local cdState = BIT.syncCdState and BIT.syncCdState[name]
                        local cdEnd   = cdState and cdState[342247]
                        if not cdEnd or cdEnd <= GetTime() then
                            if BIT.debugMode then
                                print("|cff0091edBIT|r |cFFAAAAAA[SyncCD-AURA]|r Alter Time via 342246 → OnSpellUsed")
                            end
                            BIT.SyncCD:OnSpellUsed(name, 342247, 50)
                            if isPlayer and BIT.Net then BIT.Net:AnnounceSync(342247, 50) end
                        end
                    end)
                end
            end
        end

        if changed then RefreshBuffHighlights(name) end
    end)
end

local function UpdateIcon(ico, cdEnd)
    local now = GetTime()
    if cdEnd > now then
        local rem = cdEnd - now
        if not ico._cdRunning then
            local cd = ico._cd or 30
            ico.cd:SetCooldown(cdEnd - cd, cd)
            ico._cdRunning = true
        end
        local sec = math.floor(rem + 0.5)
        if ico._lastSec ~= sec then
            ico._lastSec = sec
            local txt = sec > 0 and FormatCdTime(sec) or ""
            ico.cdText:SetText(txt)
            ico.cdText:Show()
        end
        ico.tex:SetAlpha(0.3)
    else
        if ico._cdRunning then
            ico.cd:Clear()
            ico._cdRunning = false
            ico._lastSec   = nil
            ico.cdText:Hide()
            ico.tex:SetAlpha(1.0)
        end
    end
end

------------------------------------------------------------
-- Helper: returns the active display mode for the current group type
------------------------------------------------------------
local _cachedMode    = nil   -- last mode used; nil = not yet set
local _rebuildTimer  = nil   -- debounce handle
local _ownTalentVer  = 0     -- bumped on PLAYER_TALENT_UPDATE / TRAIT_CONFIG_UPDATED

local function GetEffectiveMode()
    if IsInRaid() then
        return BIT.db.syncCdModeRaid or "BARS"
    else
        return BIT.db.syncCdModeGroup or "ATTACH"
    end
end

------------------------------------------------------------
-- Mode A: Standalone Window
------------------------------------------------------------
local syncFrame = nil

local function RebuildWindowRow(name)
    -- get class: own player, registry entry, or direct UnitClass
    local class = (name == BIT.myName) and BIT.myClass
    if not class then
        local entry = BIT.SyncCD.users and BIT.SyncCD.users[name]
        class = entry and entry.class
    end
    if not class then
        for i = 1, 4 do
            local u = "party"..i
            if UnitExists(u) and UnitName(u) == name then
                local _, cls = UnitClass(u)
                class = cls
                break
            end
        end
    end

    local row = syncRows[name]
    local currentSpec = GetSpecForPlayer(name)

    if not row then
        row = { icons = {}, _lastSpec = nil }
        row.frame = CreateFrame("Frame", nil, syncFrame)
        row.frame:SetHeight(ROW_H())
        -- Forward drag to syncFrame so the window is draggable from any row area
        row.frame:EnableMouse(true)
        row.frame:RegisterForDrag("LeftButton")
        row.frame:SetScript("OnDragStart", function()
            if not BIT.db.syncCdBarsLocked then syncFrame:StartMoving() end
        end)
        row.frame:SetScript("OnDragStop", function()
            syncFrame:StopMovingOrSizing()
            if BIT.charDb then
                BIT.charDb.syncCdPosX = syncFrame:GetLeft()
                BIT.charDb.syncCdPosY = syncFrame:GetBottom()
            end
        end)
        row.nameText = row.frame:CreateFontString(nil, "OVERLAY")
        BIT.Media:SetFont(row.nameText, 11)
        row.nameText:SetPoint("LEFT", row.frame, "LEFT", 2, 0)
        row.nameText:SetWidth(NAME_W)
        row.nameText:SetJustifyH("LEFT")
        row.nameText:SetWordWrap(false)
        syncRows[name] = row
    end

    local cc = class and BIT.CLASS_COLORS and BIT.CLASS_COLORS[class]
    if cc then row.nameText:SetTextColor(cc[1], cc[2], cc[3])
    else        row.nameText:SetTextColor(1, 1, 1) end
    row.nameText:SetText(name)

    -- only rebuild icons if spec, icon size, spacing, counter size, disabled-filter, or talents changed
    local curSize        = ICON_SIZE()
    local curSpacing     = ICON_PAD()
    local curCounterSz   = BIT.db.syncCdCounterSize or 14
    local curDisabledVer = BIT.db.syncCdDisabledVer or 0
    local curCatVer      = BIT.db.syncCdCatVer      or 0
    local curTalentVer   = (name == BIT.myName) and _ownTalentVer or 0
    if row._lastSpec ~= currentSpec or row._lastIconSize ~= curSize
       or row._lastSpacing ~= curSpacing
       or row._lastCounterSz ~= curCounterSz or row._lastDisabledVer ~= curDisabledVer
       or row._lastCatVer ~= curCatVer or row._lastTalentVer ~= curTalentVer then
        row._lastSpec        = currentSpec
        row._lastIconSize    = curSize
        row._lastSpacing     = curSpacing
        row._lastCounterSz   = curCounterSz
        row._lastDisabledVer = curDisabledVer
        row._lastCatVer      = curCatVer
        row._lastTalentVer   = curTalentVer

        for _, ico in pairs(row.icons) do ico:Hide() end
        row.icons = {}

        local spells = GetSpellsForPlayer(name)
        local x = NAME_W + 4
        for _, s in ipairs(spells) do
            local ico = CreateIcon(row.frame, s.id)
            ico:SetSize(ICON_SIZE(), ICON_SIZE())
            ico:SetPoint("LEFT", row.frame, "LEFT", x, 0)
            ico._cd = s.cd
            ico._maxCharges = s.charges or 0
            ico:Show()
            row.icons[s.id] = ico
            x = x + ICON_SIZE() + ICON_PAD()
        end

        row.frame:SetWidth(x + 4)
        RefreshBuffHighlights(name)
    end

    return row
end

local function ApplyWindowStyle()
    if not syncFrame then return end
    local locked  = BIT.db.syncCdBarsLocked or false
    local compact = BIT.db.syncCdWindowCompact or false

    -- Lock: SetMovable(false) is the reliable WoW way — StartMoving() becomes a no-op
    syncFrame:SetMovable(not locked)

    -- Drag handle: compact-only, and must be both hidden AND mouse-disabled when locked
    -- (SetShown(false) alone does NOT disable mouse in WoW)
    local handleActive = compact and not locked
    if syncFrame._dragHandle then
        syncFrame._dragHandle:SetShown(handleActive)
        syncFrame._dragHandle:EnableMouse(handleActive)
    end

    if compact then
        syncFrame:SetBackdropColor(0, 0, 0, 0)
        syncFrame:SetBackdropBorderColor(0, 0, 0, 0)
        if syncFrame._title then syncFrame._title:Hide() end
    else
        syncFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
        syncFrame:SetBackdropBorderColor(0.8, 0.5, 0, 0.7)
        if syncFrame._title then syncFrame._title:Show() end
    end
end

-- Expose for Config callbacks that toggle lock/compact without a full rebuild
BIT.SyncCD.ApplyStyle = ApplyWindowStyle

local function RebuildWindow(forceFallback)
    if not syncFrame then return end
    if not BIT.db.showSyncCDs or (GetEffectiveMode() == "ATTACH" and not forceFallback) then
        syncFrame:Hide()
        return
    end
    -- Hide when solo if "only in group" is enabled
    if BIT.db.syncOnlyInGroup and not IsInGroup() then
        syncFrame:Hide()
        return
    end

    for _, row in pairs(syncRows) do row.frame:Hide() end

    local entries = {}
    -- Own row: whenever "Show own CDs" is enabled
    if BIT.myName and BIT.myClass and BIT.db.showOwnSyncCD ~= false then
        entries[#entries+1] = BIT.myName
    end
    for name in pairs(BIT.SyncCD.users or {}) do
        if name ~= BIT.myName then entries[#entries+1] = name end
    end

    local y, maxW = -4, 200
    for _, name in ipairs(entries) do
        local row = RebuildWindowRow(name)
        row.frame:ClearAllPoints()
        row.frame:SetPoint("TOPLEFT", syncFrame, "TOPLEFT", 4, y)
        row.frame:Show()
        y    = y - (ROW_H() + 2)
        local rw = row.frame:GetWidth() or 0
        if rw > maxW then maxW = rw end
    end

    if #entries == 0 then
        syncFrame:SetSize(200, 40)
    else
        syncFrame:SetSize(maxW + 8, math.abs(y) + 4)
    end

    ApplyWindowStyle()
    syncFrame:Show()
end

local function UpdateWindow()
    if not syncFrame or not syncFrame:IsShown() then return end
    local now = GetTime()
    for name, row in pairs(syncRows) do
        if row.frame:IsShown() then
            local state = BIT.syncCdState[name] or {}
            for sid, ico in pairs(row.icons) do
                UpdateIcon(ico, state[sid] or 0)
            end
        end
    end
end

local function CreateWindowFrame()
    if syncFrame then return end

    syncFrame = CreateFrame("Frame", "BliZziSyncCDFrame", UIParent, "BackdropTemplate")
    syncFrame:SetSize(200, 40)
    syncFrame:SetFrameStrata("MEDIUM")
    syncFrame:SetClampedToScreen(true)
    syncFrame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    syncFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
    syncFrame:SetBackdropBorderColor(0.8, 0.5, 0, 0.7)

    local title = syncFrame:CreateFontString(nil, "OVERLAY")
    BIT.Media:SetFont(title, 10)
    title:SetPoint("BOTTOMLEFT", syncFrame, "TOPLEFT", 4, 2)
    title:SetText("|cffffaa00Party CDs|r")
    syncFrame._title = title

    -- Compact-mode drag handle: thin bar at top, only shown when compact
    local dragHandle = CreateFrame("Frame", nil, syncFrame, "BackdropTemplate")
    dragHandle:SetHeight(5)
    dragHandle:SetPoint("TOPLEFT",  syncFrame, "TOPLEFT",  0, 0)
    dragHandle:SetPoint("TOPRIGHT", syncFrame, "TOPRIGHT", 0, 0)
    dragHandle:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    dragHandle:SetBackdropColor(0.8, 0.5, 0, 0.5)
    dragHandle:SetFrameLevel(syncFrame:GetFrameLevel() + 20)
    dragHandle:EnableMouse(true)
    dragHandle:RegisterForDrag("LeftButton")
    dragHandle:SetScript("OnDragStart", function()
        if not BIT.db.syncCdBarsLocked then syncFrame:StartMoving() end
    end)
    dragHandle:SetScript("OnDragStop", function()
        syncFrame:StopMovingOrSizing()
        if BIT.charDb then
            BIT.charDb.syncCdPosX = syncFrame:GetLeft()
            BIT.charDb.syncCdPosY = syncFrame:GetBottom()
        end
    end)
    dragHandle:Hide()
    syncFrame._dragHandle = dragHandle

    syncFrame:SetMovable(true)
    syncFrame:EnableMouse(true)
    syncFrame:RegisterForDrag("LeftButton")
    syncFrame:SetScript("OnDragStart", function(self)
        if not BIT.db.syncCdBarsLocked then self:StartMoving() end
    end)
    syncFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        if BIT.charDb then
            BIT.charDb.syncCdPosX = self:GetLeft()
            BIT.charDb.syncCdPosY = self:GetBottom()
        end
    end)

    if BIT.charDb and BIT.charDb.syncCdPosX then
        syncFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",
            BIT.charDb.syncCdPosX, BIT.charDb.syncCdPosY)
    else
        syncFrame:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    end

    syncFrame:Hide()
    BIT.SyncCD.frame = syncFrame
end

------------------------------------------------------------
-- Mode B: Attach to party unit frames
------------------------------------------------------------

local function HideAllAttached()
    for _, bar in pairs(attachedBars) do
        if bar.frame then bar.frame:Hide() end
    end
    attachedBars = {}
end

-- position anchor config: attach position → { point, relPoint, x, y, horizontal }
local ATTACH_CONFIG = {
    RIGHT  = { point = "LEFT",   relPoint = "RIGHT",  ox =  4, oy = 0, horiz = true },
    LEFT   = { point = "RIGHT",  relPoint = "LEFT",   ox = -4, oy = 0, horiz = true },
    TOP    = { point = "BOTTOM", relPoint = "TOP",    ox =  0, oy = 4, horiz = true },
    BOTTOM = { point = "TOP",    relPoint = "BOTTOM", ox =  0, oy =-4, horiz = true },
}

local function BuildAttachedBar(unit, name)
    local currentSpec   = GetSpecForPlayer(name)
    local curPos        = BIT.db.syncCdAttachPos or "LEFT"
    local curIconSize   = ICON_SIZE()
    local curSpacing    = ICON_PAD()
    local curCounterSz  = BIT.db.syncCdCounterSize or 14
    local curDisabledVer= BIT.db.syncCdDisabledVer or 0
    local curCatVer     = BIT.db.syncCdCatVer or 0
    local curRowGap     = BIT.db.syncCdAttachRowGap  or 4
    local curOffsetX    = BIT.db.syncCdAttachOffsetX or 0
    local curOffsetY    = BIT.db.syncCdAttachOffsetY or 0
    local _ue           = BIT.SyncCD.users and BIT.SyncCD.users[name]
    local curTalentVer  = (name == BIT.myName) and _ownTalentVer
                          or (_ue and _ue._talentVer or 0)
    local isNonAddon    = (name ~= BIT.myName) and not (_ue and _ue._hasAddon)
    local parentFrame   = GetPartyUnitFrame(unit)
    local existing      = attachedBars[unit]

    -- reuse existing bar only if ALL display settings AND the parent frame are unchanged
    if existing and existing.frame
       and existing._lastParentFrame == parentFrame
       and existing._lastSpec        == currentSpec
       and existing._lastPos         == curPos
       and existing._lastIconSize    == curIconSize
       and existing._lastSpacing     == curSpacing
       and existing._lastCounterSz   == curCounterSz
       and existing._lastDisabledVer == curDisabledVer
       and existing._lastCatVer      == curCatVer
       and existing._lastRowGap      == curRowGap
       and existing._lastOffsetX     == curOffsetX
       and existing._lastOffsetY     == curOffsetY
       and existing._lastTalentVer   == curTalentVer
       and existing._lastIsNonAddon  == isNonAddon then
        existing.frame:Show()
        return
    end

    if existing and existing.frame then existing.frame:Hide() end

    if not parentFrame then return end

    local spells = GetSpellsForPlayer(name)
    if #spells == 0 then return end

    local pos = curPos
    local cfg = ATTACH_CONFIG[pos] or ATTACH_CONFIG.LEFT

    local bar = {
        icons            = {},
        _lastParentFrame = parentFrame,
        _lastSpec        = currentSpec,
        _lastPos         = curPos,
        _lastIconSize    = curIconSize,
        _lastSpacing     = curSpacing,
        _lastCounterSz   = curCounterSz,
        _lastDisabledVer = curDisabledVer,
        _lastCatVer      = curCatVer,
        _lastRowGap      = curRowGap,
        _lastOffsetX     = curOffsetX,
        _lastOffsetY     = curOffsetY,
        _lastTalentVer   = curTalentVer,
        _lastIsNonAddon  = isNonAddon,
    }
    bar.frame = CreateFrame("Frame", nil, parentFrame)
    bar.frame:SetFrameLevel(parentFrame:GetFrameLevel() + 10)

    -- ── Multi-row layout: each category on its own configurable row ──
    local iSize   = ICON_SIZE()
    local iPad    = ICON_PAD()
    local ROW_GAP = curRowGap

    -- Group spells by their assigned row number
    local rowMap = {}
    for _, s in ipairs(spells) do
        local rn = GetCatRow(s.cat)
        if not rowMap[rn] then rowMap[rn] = {} end
        rowMap[rn][#rowMap[rn] + 1] = s
    end

    -- Sort row numbers so rows are always drawn top-to-bottom in order
    local rowNums = {}
    for rn in pairs(rowMap) do rowNums[#rowNums + 1] = rn end
    table.sort(rowNums)

    bar.frame:SetPoint(cfg.point, parentFrame, cfg.relPoint, cfg.ox + curOffsetX, cfg.oy + curOffsetY)

    if pos == "TOP" or pos == "BOTTOM" then
        -- ── TOP / BOTTOM: rows become vertical columns, left to right ──
        -- Row 1 = leftmost column, Row 2 = middle, Row 3 = rightmost.
        -- TOP:    icons fill bottom-to-top (flush against unit frame at bottom).
        -- BOTTOM: icons fill top-to-bottom (flush against unit frame at top).
        local maxIconsInCol = 0
        for _, rn in ipairs(rowNums) do
            if #rowMap[rn] > maxIconsInCol then maxIconsInCol = #rowMap[rn] end
        end
        local totalW = math.max(iSize, #rowNums * iSize + math.max(0, #rowNums - 1) * ROW_GAP)
        local totalH = math.max(iSize, maxIconsInCol * iSize + math.max(0, maxIconsInCol - 1) * iPad)
        bar.frame:SetSize(totalW, totalH)

        local reverseY = (pos == "TOP")
        for colIdx, rn in ipairs(rowNums) do
            local xOff = (colIdx - 1) * (iSize + ROW_GAP)
            for iconIdx, s in ipairs(rowMap[rn]) do
                local ico = CreateIcon(bar.frame, s.id)
                ico:SetSize(iSize, iSize)
                if reverseY then
                    -- build upward: first icon sits at the bottom (closest to unit frame)
                    local yOff = (iconIdx - 1) * (iSize + iPad)
                    ico:SetPoint("BOTTOMLEFT", bar.frame, "BOTTOMLEFT", xOff, yOff)
                else
                    -- build downward: first icon sits at the top (closest to unit frame)
                    local yOff = -(iconIdx - 1) * (iSize + iPad)
                    ico:SetPoint("TOPLEFT", bar.frame, "TOPLEFT", xOff, yOff)
                end
                ico._cd          = s.cd
                ico._maxCharges  = s.charges or 0
                ico._playerName  = name
                ico._spellName   = s.name
                if isNonAddon then ico.tex:SetDesaturated(true) end
                ico:Show()
                bar.icons[s.id] = ico
            end
        end
    else
        -- ── LEFT / RIGHT: rows are horizontal strips stacked top-to-bottom ──
        -- LEFT attach:  icons fill right-to-left (flush against unit frame).
        -- RIGHT attach: icons fill left-to-right.
        local maxCols = 0
        for _, rn in ipairs(rowNums) do
            if #rowMap[rn] > maxCols then maxCols = #rowMap[rn] end
        end
        local totalW = math.max(iSize, maxCols * iSize + math.max(0, maxCols - 1) * iPad)
        local totalH = math.max(iSize, #rowNums * iSize + math.max(0, #rowNums - 1) * ROW_GAP)
        bar.frame:SetSize(totalW, totalH)

        local reverseX = (pos == "LEFT")
        for rowIdx, rn in ipairs(rowNums) do
            local yOff = -(rowIdx - 1) * (iSize + ROW_GAP)
            for colIdx, s in ipairs(rowMap[rn]) do
                local ico = CreateIcon(bar.frame, s.id)
                ico:SetSize(iSize, iSize)
                local xOff
                if reverseX then
                    xOff = totalW - colIdx * iSize - (colIdx - 1) * iPad
                else
                    xOff = (colIdx - 1) * (iSize + iPad)
                end
                ico:SetPoint("TOPLEFT", bar.frame, "TOPLEFT", xOff, yOff)
                ico._cd         = s.cd
                ico._maxCharges = s.charges or 0
                ico._playerName = name
                ico._spellName  = s.name
                if isNonAddon then ico.tex:SetDesaturated(true) end
                ico:Show()
                bar.icons[s.id] = ico
            end
        end
    end

    RefreshBuffHighlights(name)
    bar.frame:Show()
    attachedBars[unit] = bar
end

local function RebuildAttached()
    if not BIT.db.showSyncCDs or GetEffectiveMode() ~= "ATTACH" then
        HideAllAttached()
        return
    end
    if BIT.db.syncOnlyInGroup and not IsInGroup() then
        HideAllAttached()
        return
    end

    -- Build name→unit map
    local nameToUnit = {}
    if BIT.myName then nameToUnit[BIT.myName] = "player" end
    for i = 1, 4 do
        local u = "party" .. i
        if UnitExists(u) then
            local n = UnitName(u)
            if n then nameToUnit[n] = u end
        end
    end

    -- Determine which units should be active
    local activeUnits = {}
    if BIT.myName and BIT.myClass and BIT.db.showOwnSyncCD ~= false then
        local unit = nameToUnit[BIT.myName]
        if unit then activeUnits[unit] = BIT.myName end
    end
    for name in pairs(BIT.SyncCD.users or {}) do
        if name ~= BIT.myName then
            local unit = nameToUnit[name]
            if unit then activeUnits[unit] = name end
        end
    end
    -- Also include party members who don't have the addon (not in SyncCD.users)
    for i = 1, 4 do
        local u = "party" .. i
        if UnitExists(u) and not activeUnits[u] then
            local n = UnitName(u)
            if n then activeUnits[u] = n end
        end
    end

    -- Hide bars for units no longer active (player left group etc.)
    for unit, bar in pairs(attachedBars) do
        if not activeUnits[unit] then
            if bar.frame then bar.frame:Hide() end
            attachedBars[unit] = nil
        end
    end

    -- Check if ANY unit frame actually exists before attaching
    local anyFrameFound = false
    for unit in pairs(activeUnits) do
        if GetPartyUnitFrame(unit) then
            anyFrameFound = true
            break
        end
    end

    -- No unit frames detected → fall back to standalone window
    if not anyFrameFound then
        RebuildWindow(true)
        return
    end

    -- Hide standalone window if it was showing as fallback
    if syncFrame then syncFrame:Hide() end

    -- Build/reuse bars for active units (BuildAttachedBar skips rebuild if spec unchanged)
    for unit, name in pairs(activeUnits) do
        BuildAttachedBar(unit, name)
    end
end

local function UpdateAttached()
    if not BIT.db.showSyncCDs or GetEffectiveMode() ~= "ATTACH" then return end
    for unit, bar in pairs(attachedBars) do
        if bar.frame and bar.frame:IsShown() then
            local name = (unit == "player") and BIT.myName or UnitName(unit)
            if name then
                local state = BIT.syncCdState[name] or {}
                for sid, ico in pairs(bar.icons) do
                    UpdateIcon(ico, state[sid] or 0)
                end
            end
        end
    end
end

------------------------------------------------------------
-- GROUP BARS mode — one fill-progress bar per spell per player
-- Fully configurable, matching the interrupt-tracker feature set.
------------------------------------------------------------
local barsFrame      = nil
local groupSpellBars = {}  -- currently active spell-bar frames
local barPool        = {}  -- hidden reusable frames (never destroyed)
local barsTitle      = nil -- title FontString reference

local function GROUP_BAR_W()   return (BIT.db and BIT.db.frameWidth) or 250  end
local function GROUP_BAR_H()   return math.max(12, (BIT.db and BIT.db.barHeight) or 22) end
local function GROUP_BAR_GAP() return (BIT.db and BIT.db.barGap) or 0  end

local function GetPlayerClass(name)
    if name == BIT.myName then return BIT.myClass end
    if BIT.SyncCD.users and BIT.SyncCD.users[name] then
        return BIT.SyncCD.users[name].class
    end
    local e = BIT.Registry and BIT.Registry:Get(name)
    return e and e.class
end

-- Returns {r,g,b} fill color for a given class, respecting useClassColors setting
local function GetFillColor(class)
    local db = BIT.db or {}
    if db.useClassColors ~= false then
        local c = BIT.CLASS_COLORS[class or ""] or {0.4, 0.8, 1.0}
        return c[1], c[2], c[3]
    end
    return db.customColorR or 0.4, db.customColorG or 0.8, db.customColorB or 1.0
end
local function GetBgColor(class)
    local db = BIT.db or {}
    if db.useClassColors ~= false then
        local c = BIT.CLASS_COLORS[class or ""] or {0.1, 0.1, 0.1}
        return c[1] * 0.15, c[2] * 0.15, c[3] * 0.15
    end
    return db.customBgColorR or 0.1, db.customBgColorG or 0.1, db.customBgColorB or 0.1
end

-- Apply frame-level settings (title, opacity, lock) to existing barsFrame
local function ApplyBarsFrameSettings()
    if not barsFrame then return end
    local db = BIT.db or {}
    barsFrame:SetAlpha(db.alpha or 1.0)
    if barsTitle then
        if db.showTitle ~= false then
            local fs = (db.titleFontSize and db.titleFontSize > 0) and db.titleFontSize or 12
            BIT.Media:SetFont(barsTitle, fs)
            local align  = db.titleAlign or "CENTER"
            local titleY = -2 + (db.titleOffsetY or 0)
            barsTitle:ClearAllPoints()
            if align == "LEFT" then
                barsTitle:SetPoint("BOTTOMLEFT", barsFrame, "TOPLEFT", 4, titleY)
            elseif align == "RIGHT" then
                barsTitle:SetPoint("BOTTOMRIGHT", barsFrame, "TOPRIGHT", -4, titleY)
            else
                barsTitle:SetPoint("BOTTOM", barsFrame, "TOP", 0, titleY)
            end
            barsTitle:SetTextColor(db.titleColorR or 0, db.titleColorG or 0.867, db.titleColorB or 0.867)
            barsTitle:Show()
        else
            barsTitle:Hide()
        end
    end
end

local function CreateBarsFrame()
    if barsFrame then return end
    barsFrame = CreateFrame("Frame", "BliZziSyncCDBarsFrame", UIParent)
    barsFrame:SetSize(GROUP_BAR_W() + 4, 40)
    barsFrame:SetFrameStrata("MEDIUM")
    barsFrame:SetClampedToScreen(true)
    barsFrame:SetScale((BIT.db and BIT.db.frameScale or 100) / 100)

    barsTitle = barsFrame:CreateFontString(nil, "OVERLAY")
    BIT.Media:SetFont(barsTitle, 12)
    barsTitle:SetShadowOffset(0, 0)
    barsTitle:SetText("Party CDs")

    barsFrame:SetMovable(true)
    barsFrame:EnableMouse(true)
    barsFrame:RegisterForDrag("LeftButton")
    barsFrame:SetScript("OnDragStart", function(self)
        if not (BIT.db and BIT.db.syncCdBarsLocked) then self:StartMoving() end
    end)
    barsFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        if BIT.charDb then
            BIT.charDb.syncCdBarsPosX = self:GetLeft()
            BIT.charDb.syncCdBarsPosY = self:GetBottom()
        end
    end)

    if BIT.charDb and BIT.charDb.syncCdBarsPosX then
        barsFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",
            BIT.charDb.syncCdBarsPosX, BIT.charDb.syncCdBarsPosY)
    else
        barsFrame:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    end

    ApplyBarsFrameSettings()
    barsFrame:Hide()
end

-- Creates one fill-progress spell bar.  All visual settings read from BIT.db at creation time.
local function CreateSpellBar(parent, barW, barH, spellID, playerName, class, baseCd)
    local db       = BIT.db or {}
    local iconSide = (BIT.db and BIT.db.iconSide) or "LEFT"
    local iSize    = barH
    local fontSize = (db.nameFontSize and db.nameFontSize > 0) and db.nameFontSize or 11
    local nameOffX = db.nameOffsetX or 0
    local nameOffY = db.nameOffsetY or 0
    local timerOffX= db.cdOffsetX or 0
    local timerOffY= db.cdOffsetY or 0
    local showName = db.showName ~= false

    local fr, fg, fb = GetFillColor(class)
    local bgr, bgg, bgb = GetBgColor(class)

    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(barW, barH)

    -- icon anchors depend on side
    local iconL, iconR, barL
    if iconSide == "RIGHT" then
        iconL = barW - iSize; iconR = 0; barL = 0
    else
        iconL = 0;            iconR = -barW + iSize; barL = iSize
    end

    -- spell icon
    local icon = f:CreateTexture(nil, "ARTWORK")
    if iconSide == "RIGHT" then
        icon:SetPoint("TOPLEFT",     f, "TOPRIGHT",   -iSize, 0)
        icon:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",  0,    0)
    else
        icon:SetPoint("TOPLEFT",     f, "TOPLEFT",    0,     0)
        icon:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT", iSize, 0)
    end
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    local spellTex = C_Spell.GetSpellTexture(spellID)
    if spellTex then icon:SetTexture(spellTex) end
    f.icon = icon

    -- icon dark bg
    local iconBg = f:CreateTexture(nil, "BACKGROUND")
    if iconSide == "RIGHT" then
        iconBg:SetPoint("TOPLEFT",     f, "TOPRIGHT",   -iSize, 0)
        iconBg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",  0,    0)
    else
        iconBg:SetPoint("TOPLEFT",     f, "TOPLEFT",    0,     0)
        iconBg:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT", iSize, 0)
    end
    iconBg:SetTexture(BIT.Media.flatTexture)
    iconBg:SetVertexColor(0.1, 0.1, 0.1, 1)

    -- bar solid bg
    local barBg = f:CreateTexture(nil, "BACKGROUND", nil, -1)
    if iconSide == "RIGHT" then
        barBg:SetPoint("TOPLEFT",     f, "TOPLEFT",   0,      0)
        barBg:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -iSize,  -barH)
    else
        barBg:SetPoint("TOPLEFT",     f, "TOPLEFT",    iSize, 0)
        barBg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0,    0)
    end
    barBg:SetTexture(BIT.Media.flatTexture)
    barBg:SetVertexColor(0, 0, 0, 1)

    -- bar tinted bg (class or custom)
    local barBgTex = f:CreateTexture(nil, "BACKGROUND", nil, 0)
    if iconSide == "RIGHT" then
        barBgTex:SetPoint("TOPLEFT",     f, "TOPLEFT",   0,      0)
        barBgTex:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -iSize, -barH)
    else
        barBgTex:SetPoint("TOPLEFT",     f, "TOPLEFT",    iSize, 0)
        barBgTex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0,    0)
    end
    BIT.Media:SetBarTexture(barBgTex)
    barBgTex:SetVertexColor(bgr, bgg, bgb, 0.9)
    f.barBgTex = barBgTex

    -- fill StatusBar
    local sb = CreateFrame("StatusBar", nil, f)
    if iconSide == "RIGHT" then
        sb:SetPoint("TOPLEFT",     f, "TOPLEFT",   0,      0)
        sb:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -iSize, -barH)
    else
        sb:SetPoint("TOPLEFT",     f, "TOPLEFT",    iSize, 0)
        sb:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0,    0)
    end
    BIT.Media:SetBarTexture(sb)
    sb:SetStatusBarColor(fr, fg, fb, 0.85)
    sb:SetMinMaxValues(0, 1)
    sb:SetValue(0)
    sb:SetFrameLevel(f:GetFrameLevel() + 1)
    if sb.NineSlice   then sb.NineSlice:SetAtlas("")  sb.NineSlice:Hide() end
    if sb.BorderFrame then sb.BorderFrame:Hide() end
    f.cdBar    = sb
    f._fillR   = fr; f._fillG = fg; f._fillB = fb
    -- Pool compatibility tags
    f._iconSide = iconSide
    f._barH     = barH
    f._barW     = barW

    -- content frame (text layer above StatusBar)
    local content = CreateFrame("Frame", nil, f)
    if iconSide == "RIGHT" then
        content:SetPoint("TOPLEFT",     f, "TOPLEFT",   0,      0)
        content:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -iSize, -barH)
    else
        content:SetPoint("TOPLEFT",     f, "TOPLEFT",    iSize, 0)
        content:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0,    0)
    end
    content:SetFrameLevel(sb:GetFrameLevel() + 10)

    -- player name text
    local nm = content:CreateFontString(nil, "OVERLAY")
    BIT.Media:SetFont(nm, fontSize)
    nm:SetPoint("LEFT", content, "LEFT", 4 + nameOffX, nameOffY)
    nm:SetJustifyH("LEFT")
    nm:SetWordWrap(false)
    nm:SetTextColor(1, 1, 1)
    if showName then nm:SetText(playerName) else nm:SetText("") end
    f.nameText = nm

    -- timer / ready text
    local timer = content:CreateFontString(nil, "OVERLAY")
    local timerFontSize = (db.readyFontSize and db.readyFontSize > 0) and db.readyFontSize or fontSize
    BIT.Media:SetFont(timer, timerFontSize)
    timer:SetPoint("RIGHT", content, "RIGHT", -4 + timerOffX, timerOffY)
    timer:SetJustifyH("RIGHT")
    timer:SetTextColor(1, 1, 1)
    f.timerText = timer

    f.playerName = playerName
    f.spellID    = spellID
    f.baseCd     = baseCd
    f._class     = class
    f._cdEnd     = 0
    f._lastSec   = nil

    -- Border overlays (above StatusBar, below text content)
    local borderOverlay = CreateFrame("Frame", nil, f, "BackdropTemplate")
    borderOverlay:SetAllPoints(f)
    borderOverlay:SetFrameLevel(sb:GetFrameLevel() + 10)
    borderOverlay:EnableMouse(false)
    f.borderOverlay = borderOverlay

    local iconBorderOverlay = CreateFrame("Frame", nil, f, "BackdropTemplate")
    if iconSide == "RIGHT" then
        iconBorderOverlay:SetPoint("TOPLEFT",     f, "TOPRIGHT",    -iSize - 1, 0)
        iconBorderOverlay:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",  0,         0)
    else
        iconBorderOverlay:SetPoint("TOPLEFT",     f, "TOPLEFT",    0,         0)
        iconBorderOverlay:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT", iSize + 1, 0)
    end
    iconBorderOverlay:SetFrameLevel(sb:GetFrameLevel() + 11)
    iconBorderOverlay:EnableMouse(false)
    f.iconBorderOverlay = iconBorderOverlay

    BIT.UI:ApplyBorderToFrame(f)

    return f
end

-- Returns a bar frame: reuses a compatible one from barPool (no destroy/recreate)
-- or creates a fresh one.  Updates its content and resets state in both cases.
local function AcquireBar(barW, barH, spellID, playerName, class, baseCd)
    local iconSide = (BIT.db and BIT.db.iconSide) or "LEFT"

    -- Look for a pooled frame with matching layout (iconSide + size)
    for i = #barPool, 1, -1 do
        local b = barPool[i]
        if b._iconSide == iconSide and b._barH == barH and b._barW == barW then
            table.remove(barPool, i)
            -- Update identity
            b.spellID    = spellID
            b.playerName = playerName
            b._class     = class
            b.baseCd     = baseCd
            -- Reset per-tick caches so UpdateGroupBars re-evaluates immediately
            b._lastReady     = nil
            b._lastSec       = nil
            b._lastNameShown = nil
            -- Update icon texture
            local spellTex = C_Spell.GetSpellTexture(spellID)
            if spellTex then b.icon:SetTexture(spellTex) end
            -- Update fill / bg colours
            local fr, fg, fb    = GetFillColor(class)
            local bgr, bgg, bgb = GetBgColor(class)
            b._fillR = fr; b._fillG = fg; b._fillB = fb
            b.cdBar:SetStatusBarColor(fr, fg, fb, 0.85)
            if b.barBgTex then b.barBgTex:SetVertexColor(bgr, bgg, bgb, 0.9) end
            if b.nameText  then b.nameText:SetText(playerName) end
            BIT.UI:ApplyBorderToFrame(b)
            return b
        end
    end

    -- No compatible frame in pool — create a new one
    return CreateSpellBar(barsFrame, barW, barH, spellID, playerName, class, baseCd)
end

-- Returns a bar to the pool (hidden, ready for reuse)
local function ReleaseBar(bar)
    bar:Hide()
    table.insert(barPool, bar)
end

local function RebuildGroupBars()
    if not barsFrame then return end
    if not BIT.db.showSyncCDs or GetEffectiveMode() ~= "BARS" then
        barsFrame:Hide(); return
    end
    if BIT.db.syncOnlyInGroup and not IsInGroup() then
        barsFrame:Hide(); return
    end

    ApplyBarsFrameSettings()

    -- Return all active bars to the pool (hidden, not destroyed)
    for _, b in ipairs(groupSpellBars) do ReleaseBar(b) end
    groupSpellBars = {}

    local entries = {}
    if BIT.myName and BIT.myClass and BIT.db.showOwnSyncCD ~= false then
        entries[#entries+1] = BIT.myName
    end
    for name in pairs(BIT.SyncCD.users or {}) do
        if name ~= BIT.myName then entries[#entries+1] = name end
    end

    local db       = BIT.db or {}
    local barW     = GROUP_BAR_W()
    local barH     = GROUP_BAR_H()
    local barGap   = GROUP_BAR_GAP()
    local growUp   = db.growUpward or false
    local fillMode = db.barFillMode or "DRAIN"
    local y        = growUp and 0 or -2

    -- sort entries by CD if requested
    local sortMode = db.sortMode or "NONE"
    if sortMode ~= "NONE" then
        table.sort(entries, function(a, b)
            local ra = math.max(0, (BIT.syncCdState[a] and next(BIT.syncCdState[a]) and 0) or 0)
            local rb = math.max(0, (BIT.syncCdState[b] and next(BIT.syncCdState[b]) and 0) or 0)
            return sortMode == "CD_ASC" and ra < rb or ra > rb
        end)
    end

    local totalBars = 0
    for _, name in ipairs(entries) do
        local spells = GetSpellsForPlayer(name)
        for _, s in ipairs(spells) do
            if not (BIT.db.syncCdDisabled and BIT.db.syncCdDisabled[s.id]) then
                totalBars = totalBars + 1
            end
        end
    end

    local now = GetTime()
    local idx = 0
    for _, name in ipairs(entries) do
        local class  = GetPlayerClass(name)
        local spells = GetSpellsForPlayer(name)
        for _, s in ipairs(spells) do
            if not (BIT.db.syncCdDisabled and BIT.db.syncCdDisabled[s.id]) then
                local bar = AcquireBar(barW, barH, s.id, name, class, s.cd)
                bar:ClearAllPoints()
                if growUp then
                    bar:SetPoint("BOTTOMLEFT", barsFrame, "BOTTOMLEFT", 2, idx * (barH + barGap) + 2)
                else
                    bar:SetPoint("TOPLEFT", barsFrame, "TOPLEFT", 2, y)
                    y = y - (barH + barGap)
                end

                -- Set the correct CD state immediately so the bar never flashes empty
                local cdState = BIT.syncCdState and BIT.syncCdState[name]
                local cdEnd   = (cdState and cdState[s.id]) or 0
                if cdEnd > now then
                    local rem = cdEnd - now
                    bar.cdBar:SetMinMaxValues(0, s.cd)
                    bar.cdBar:SetValue(fillMode == "FILL" and (s.cd - rem) or rem)
                    bar._lastReady = false
                else
                    bar.cdBar:SetMinMaxValues(0, 1)
                    bar.cdBar:SetValue(1)
                    -- _lastReady = nil → UpdateGroupBars will apply ready styling on first tick
                end

                bar:Show()
                groupSpellBars[#groupSpellBars+1] = bar
                idx = idx + 1
            end
        end
    end

    local totalH = totalBars > 0 and (totalBars * (barH + barGap) - barGap + 4) or 40
    barsFrame:SetSize(barW + 4, totalH)
    barsFrame:Show()
end

local function UpdateGroupBars()
    if not barsFrame or not barsFrame:IsShown() then return end
    local now       = GetTime()
    local db        = BIT.db or {}
    local fillMode  = db.barFillMode or "DRAIN"
    local showReady = db.showReady ~= false
    local showName  = db.showName ~= false
    local showTitle = db.showTitle ~= false
    local rr = db.readyColorR or 0.2
    local rg = db.readyColorG or 1.0
    local rb = db.readyColorB or 0.2

    -- Title show/hide dynamically
    if barsTitle then
        if showTitle then barsTitle:Show() else barsTitle:Hide() end
    end

    for _, bar in ipairs(groupSpellBars) do
        if bar:IsShown() then
            -- Name text: only set when state changes to avoid flicker
            if bar.nameText then
                local wantName = showName and bar.playerName or ""
                if bar._lastNameShown ~= wantName then
                    bar._lastNameShown = wantName
                    bar.nameText:SetText(wantName)
                end
            end

            local state  = BIT.syncCdState[bar.playerName]
            local cdEnd  = (state and state[bar.spellID]) or 0
            local baseCd = bar.baseCd or 30

            if cdEnd > now then
                -- On cooldown: drain or fill bar.
                -- SetMinMaxValues and SetStatusBarColor are cached — only called once
                -- when first entering CD state (from ready/initial) to avoid marking the
                -- bar texture dirty every tick, which causes visible flickering.
                local rem = cdEnd - now
                if bar._lastReady ~= false then
                    -- just transitioned into CD state: set min/max and colour once
                    bar.cdBar:SetMinMaxValues(0, baseCd)
                    bar.cdBar:SetStatusBarColor(bar._fillR, bar._fillG, bar._fillB, 0.85)
                end
                bar.cdBar:SetValue(fillMode == "FILL" and (baseCd - rem) or rem)

                local sec = math.floor(rem + 0.5)
                if bar._lastSec ~= sec then
                    bar._lastSec = sec
                    local fmt = (BIT.db and BIT.db.syncCdTimeFormat) or "SECONDS"
                    if fmt == "MMSS" and sec >= 60 then
                        bar.timerText:SetText(string.format("%d:%02d", math.floor(sec/60), sec%60))
                    else
                        bar.timerText:SetText(tostring(sec))
                    end
                    bar.timerText:SetTextColor(1, 1, 1)
                end
                bar.timerText:Show()
                bar._lastReady = false
            else
                -- Ready: only update once on transition to avoid per-tick re-renders.
                if not bar._lastReady then
                    bar._lastReady = true
                    bar._lastSec   = nil
                    bar.cdBar:SetMinMaxValues(0, 1)
                    bar.cdBar:SetValue(1)
                    bar.cdBar:SetStatusBarColor(bar._fillR, bar._fillG, bar._fillB, 0.85)
                    bar.timerText:SetTextColor(rr, rg, rb)
                    bar.timerText:SetText(BIT.L and BIT.L["READY"] or "Ready")
                end
                -- show/hide checked every tick so the toggle responds immediately
                if showReady then bar.timerText:Show() else bar.timerText:Hide() end
            end
        end
    end
end

-- Called by settings changes that don't need a full rebuild (title, opacity, lock)
function BIT.SyncCD:ApplyBarsSettings()
    ApplyBarsFrameSettings()
end

-- Center-preserving scale change — mirrors the Interrupt Tracker's Frame Scale logic.
function BIT.SyncCD:ScaleFrame(newPct)
    if not barsFrame then return end
    local newS = newPct / 100
    local oldS = barsFrame:GetScale()
    local cx, cy = barsFrame:GetCenter()
    if cx then
        local screenCX = cx * oldS
        local screenCY = cy * oldS
        barsFrame:SetScale(newS)
        barsFrame:ClearAllPoints()
        barsFrame:SetPoint("CENTER", UIParent, "BOTTOMLEFT",
            screenCX / newS, screenCY / newS)
        if BIT.charDb then
            BIT.charDb.syncCdBarsPosX = barsFrame:GetLeft()
            BIT.charDb.syncCdBarsPosY = barsFrame:GetBottom()
        end
    else
        barsFrame:SetScale(newS)
    end
end

-- Lightweight in-place color update — no frame destroy/recreate, no flicker.
-- Called when color or class-color-mode settings change.
function BIT.SyncCD:UpdateColors()
    if not barsFrame or not barsFrame:IsShown() then return end
    for _, bar in ipairs(groupSpellBars) do
        local fr, fg, fb   = GetFillColor(bar._class)
        local bgr, bgg, bgb = GetBgColor(bar._class)
        bar._fillR = fr; bar._fillG = fg; bar._fillB = fb
        bar.cdBar:SetStatusBarColor(fr, fg, fb, 0.85)
        if bar.barBgTex then bar.barBgTex:SetVertexColor(bgr, bgg, bgb, 0.9) end
        bar._lastReady = nil  -- force ready-color text to re-evaluate on next tick
    end
end

------------------------------------------------------------
-- Public API
------------------------------------------------------------
local function DoRebuild()
    _rebuildTimer = nil
    local mode = GetEffectiveMode()
    _cachedMode = mode
    if mode == "OFF" then
        HideAllAttached()
        if syncFrame then syncFrame:Hide() end
        if barsFrame then barsFrame:Hide() end
    elseif mode == "ATTACH" then
        if syncFrame  then syncFrame:Hide()  end
        if barsFrame  then barsFrame:Hide()  end
        RebuildAttached()
    elseif mode == "BARS" then
        HideAllAttached()
        if syncFrame then syncFrame:Hide() end
        RebuildGroupBars()
    else  -- WINDOW
        HideAllAttached()
        if barsFrame then barsFrame:Hide() end
        RebuildWindow()
    end
    BIT.SyncCD:RefreshCharges()
end

-- Debounced rebuild: multiple rapid calls (e.g. INSPECT_READY for each raid member)
-- collapse into a single rebuild after 50 ms, eliminating flicker storms.
function BIT.SyncCD:Rebuild()
    if _rebuildTimer then _rebuildTimer:Cancel() end
    _rebuildTimer = C_Timer.NewTimer(0.05, DoRebuild)
end

-- Called when the local player's talents change (PLAYER_TALENT_UPDATE / TRAIT_CONFIG_UPDATED).
-- Bumps _ownTalentVer so RebuildWindowRow sees a change and recreates icons from the spellbook.
function BIT.SyncCD:OnTalentChanged()
    _ownTalentVer = _ownTalentVer + 1
    BIT.SyncCD:Rebuild()
end

-- Update charge count badges for the local player's icons.
-- Called after rebuild, on SPELL_UPDATE_CHARGES, and after casting a charge-based spell.
function BIT.SyncCD:RefreshCharges()
    local function applyCharges(icons)
        for sid, ico in pairs(icons) do
            if ico._maxCharges and ico._maxCharges > 1 then
                local ok, charges, maxCharges = pcall(C_Spell.GetSpellCharges, ico.spellID or sid)
                if ok and charges and maxCharges and maxCharges > 1 then
                    if charges < maxCharges then
                        ico.chargeBadge:SetText(charges)
                        ico.chargeBadge:Show()
                    else
                        ico.chargeBadge:Hide()
                    end
                else
                    ico.chargeBadge:Hide()
                end
            end
        end
    end
    local row = syncRows[BIT.myName]
    if row then applyCharges(row.icons) end
    for unit, bar in pairs(attachedBars) do
        local n = (unit == "player") and BIT.myName or UnitName(unit)
        if n == BIT.myName then applyCharges(bar.icons) end
    end
end

function BIT.SyncCD:UpdateDisplay()
    if not BIT.db.showSyncCDs then return end
    local mode = GetEffectiveMode()
    -- If the group type changed (party ↔ raid), rebuild immediately instead of
    -- drawing the wrong display mode until the next GROUP_ROSTER_UPDATE fires.
    if _cachedMode and mode ~= _cachedMode then
        BIT.SyncCD:Rebuild()
        return
    end
    _cachedMode = mode
    if mode == "ATTACH" then
        UpdateAttached()
    elseif mode == "BARS" then
        UpdateGroupBars()
    else
        UpdateWindow()
    end
end

local function ApplySpellUsed(icons, spellID, duration)
    local ico = icons[spellID]
    if not ico then
        local baseID = replacedByToBase[spellID]
        if baseID then ico = icons[baseID] end
    end
    if ico then
        local iconSrc = SPELL_ICON_OVERRIDE[spellID] or spellID
        local tex = C_Spell.GetSpellTexture(iconSrc)
        if tex then ico.tex:SetTexture(tex) end
        ico.spellID  = spellID   -- keep tooltip in sync with the actual cast spell
        ico._cd = duration
        ico.cd:SetCooldown(GetTime(), duration)
        ico._cdRunning = true
        ico.tex:SetAlpha(0.3)
    end
end

function BIT.SyncCD:OnSpellUsed(name, spellID, duration)
    if not BIT.syncCdState[name] then BIT.syncCdState[name] = {} end
    BIT.syncCdState[name][spellID] = GetTime() + duration
    if BIT.debugMode and spellID == 342247 then
        print("|cff0091edBIT|r |cFFAAAAAA[SyncCD]|r OnSpellUsed: name=" .. tostring(name)
              .. " spellID=" .. tostring(spellID) .. " dur=" .. tostring(duration)
              .. " row=" .. tostring(syncRows[name] ~= nil))
    end
    -- If a party member casts a spell not yet in their knownSpells, their talents
    -- changed → invalidate the inspect cache so a fresh scan triggers on next inspect.
    if name ~= BIT.myName then
        local userEntry = BIT.SyncCD.users and BIT.SyncCD.users[name]
        local ks = userEntry and userEntry.knownSpells
        if ks and not ks[spellID] then
            -- New spell seen that wasn't in talent scan → re-inspect this player
            if BIT.Inspect and BIT.Inspect.Invalidate then
                BIT.Inspect:Invalidate(name)
                for i = 1, 4 do
                    local u = "party" .. i
                    if UnitExists(u) and UnitName(u) == name then
                        BIT.Inspect:Enqueue(u)
                        BIT.Inspect:Process()
                        break
                    end
                end
            end
        end
    end

    -- When a replacedBy spell fires, also write the base-spell key
    -- so UpdateWindow/UpdateAttached can find it via the row icon keyed by the base ID.
    local baseID = replacedByToBase[spellID]
    if baseID then
        BIT.syncCdState[name][baseID] = BIT.syncCdState[name][spellID]
        -- Remember permanently that this player has the replacement talent,
        -- so future rebuilds show the correct icon without needing another inspect.
        if name ~= BIT.myName then
            if not BIT.SyncCD.users then BIT.SyncCD.users = {} end
            if not BIT.SyncCD.users[name] then BIT.SyncCD.users[name] = {} end
            local u = BIT.SyncCD.users[name]
            if not u.knownReplacements then u.knownReplacements = {} end
            if u.knownReplacements[baseID] ~= spellID then
                u.knownReplacements[baseID] = spellID
                -- Invalidate this player's row so the next Rebuild swaps the icon
                local row = syncRows[name]
                if row then row._lastSpec = nil end
                BIT.SyncCD:Rebuild()
            end
        end
    end

    -- update window row immediately
    local row = syncRows[name]
    if row then ApplySpellUsed(row.icons, spellID, duration) end

    -- update group bars immediately (find matching spell bar by name+spellID)
    for _, bar in ipairs(groupSpellBars) do
        if bar.playerName == name and (bar.spellID == spellID or (replacedByToBase[spellID] and bar.spellID == replacedByToBase[spellID])) then
            bar._cdEnd   = GetTime() + duration
            bar._lastSec = nil
        end
    end

    -- update attached bar icon immediately
    for unit, bar in pairs(attachedBars) do
        local n = (unit == "player") and BIT.myName or UnitName(unit)
        if n == name then ApplySpellUsed(bar.icons, spellID, duration) end
    end
end

function BIT.SyncCD:Create()
    CreateWindowFrame()
    CreateBarsFrame()
end
