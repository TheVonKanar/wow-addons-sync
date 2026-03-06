MythicPlusUtility.classSpecialisations = {
    DEATHKNIGHT = {
        [250] = true, -- Blood
        [251] = true, -- Frost
        [252] = true, -- Unholy
    },
    DEMONHUNTER = {
        [577] = true, -- Havoc
        [581] = true, -- Vengeance
        [1480] = true, -- Devourer
    },
    DRUID = {
        [102] = true, -- Balance
        [103] = true, -- Feral
        [104] = true, -- Guardian
        [105] = true, -- Restoration
    },
    EVOKER = {
        [1467] = true, -- Devastation
        [1468] = true, -- Preservation
        [1473] = true, -- Augmentation
    },
    HUNTER = {
        [253] = true, -- Beast Mastery
        [254] = true, -- Marksmanship
        [255] = true, -- Survival
    },
    MAGE = {
        [62] = true, -- Arcane
        [63] = true, -- Fire
        [64] = true, -- Frost
    },
    MONK = {
        [268] = true, -- Brewmaster
        [270] = true, -- Mistweaver
        [269] = true, -- Windwalker
    },
    PALADIN = {
        [65] = true, -- Holy
        [66] = true, -- Protection
        [70] = true, -- Retribution
    },
    PRIEST = {
        [256] = true, -- Discipline
        [257] = true, -- Holy
        [258] = true, -- Shadow
    },
    ROGUE = {
        [259] = true, -- Assassination
        [260] = true, -- Outlaw
        [261] = true, -- Subtlety
    },
    SHAMAN = {
        [262] = true, -- Elemental
        [263] = true, -- Enhancement
        [264] = true, -- Restoration
    },
    WARLOCK = {
        [265] = true, -- Affliction
        [266] = true, -- Demonology
        [267] = true, -- Destruction
    },
    WARRIOR = {
        [71] = true, -- Arms
        [72] = true, -- Fury
        [73] = true, -- Protection
    },
}

MythicPlusUtility.utilityAbilities = {
    DEATHKNIGHT = {
        [49039] = {tags = "[self_only][charm][fear][sleep]"}, -- Lichborne
        [45524] = {tags = "[creature_slow]"}, -- Chains of Ice
        [49576] = {tags = "[creature_grip]"}, -- Death Grip
        [207167] = {tags = "[creature_incapacitate]"}, -- Blinding Sleet
        [212552] = {tags = "[self_only][root]"}, -- Wraith Walk
        [111673] = {tags = "[cc_undead]"}, -- Control Undead
        [454786] = {tags = "[creature_slow][creature_root]", override = 45524}, -- Ice Prison
        [221562] = {tags = "[creature_stun]"}, -- Asphyxiate
        [273952] = {tags = "[creature_slow]"}, -- Grip of the Dead
        [48265] = {tags = "[self_only][player_movement_immune]"}, -- Death's Advance
    },
    [250] = {
        [108199] = {tags = "[creature_grip]", override = 1263569}, -- Gorefiend's Grasp
        [1263569] = {tags = "[creature_grip]", override = 108199}, -- Abomination Limb
    }, -- Blood
    [251] = {}, -- Frost
    [252] = {}, -- Unholy
    DEMONHUNTER = {
        [188501] = {tags = "[stealth]"}, -- Spectral Sight
        [198793] = {tags = "[self_only][snare]"}, -- Vengeful Retreat
        [207684] = {tags = "[creature_fear]"}, -- Sigil of Misery
        [217832] = {tags = "[cc_demon][cc_beast][cc_humanoid]"}, -- Imprison
        [179057] = {tags = "[creature_stun]"}, -- Chaos Nova
        [278326] = {tags = "[purge]"}, -- Consume Magic
        [1266316] = {tags = "[self_only][disease]"}, -- Burn It Out
        [1266496] = {tags = "[self_only][curse]"}, -- Soul Cleanse
        [131347] = {tags = "[self_only][player_jump]"}, -- Glide
    },
    [577] = {}, -- Havoc
    [581] = {}, -- Vengeance
    [1480] = {}, -- Devourer
    DRUID = {
        [22570] = {tags = "[creature_stun]"}, -- Maim
        [2637] = {tags = "[cc_beast][cc_dragonkin]"}, -- Hibernate
        [2908] = {tags = "[enrage]"}, -- Soothe
        [33786] = {
            tags = "[cc_aberration][cc_beast][cc_critter][cc_demon][cc_dragonkin][cc_elemental][cc_giant][cc_humanoid][cc_mechanical][cc_undead][cc_other]",
        }, -- Cyclone
        [132469] = {tags = "[creature_grip][creature_slow]"}, -- Typhoon
        [102793] = {tags = "[creature_slow][creature_root]"}, -- Ursol's Vortex
        [339] = {tags = "[creature_root]"}, -- Entangling Roots
        [102359] = {tags = "[creature_root]"}, -- Mass Entanglement
        [99] = {tags = "[creature_incapacitate]"}, -- Incapacitating Roar
        [5211] = {tags = "[creature_stun]"}, -- Mighty Bash
        [768] = {tags = "[self_only][slow][snare][root]"}, -- Cat Form (as a general shapeshift)
    },
    [102] = {
        [2782] = {tags = "[curse][poison]"}, -- Remove Corruption
    }, -- Balance
    [103] = {
        [2782] = {tags = "[curse][poison]"}, -- Remove Corruption
    }, -- Feral
    [104] = {
        [2782] = {tags = "[curse][poison]"}, -- Remove Corruption
    }, -- Guardian
    [105] = {
        [392378] = {tags = "[curse][poison]"}, -- Improved Nature's Cure
    }, -- Restoration
    EVOKER = {
        [368970] = {tags = "[creature_stun]"}, -- Tail Swipe
        [357214] = {tags = "[creature_grip]"}, -- Wing Buffet
        [358385] = {tags = "[creature_root]"}, -- Landslide
        [374251] = {tags = "[bleed][poison][curse][disease]"}, -- Cauterizing Flame
        [360806] = {
            tags = "[cc_aberration][cc_beast][cc_critter][cc_demon][cc_dragonkin][cc_elemental][cc_giant][cc_humanoid][cc_mechanical][cc_undead][cc_other]",
        }, -- Sleep Walk
        [387341] = {tags = "[creature_slow]"}, -- Walloping Blow
        [374346] = {tags = "[enrage]"}, -- Overawe
        [357210] = {tags = "[self_only][slow][snare][root][player_movement_immune]", override = 357210}, -- Deep Breath
        [365585] = {tags = "[poison]"}, -- Expunge
        [358733] = {tags = "[self_only][player_jump]"}, -- Glide
    },
    [1467] = {}, -- Devastation
    [1468] = {
        [403631] = {tags = "[self_only][slow][snare][root][player_movement_immune]"}, -- Dream Flight
    }, -- Preservation
    [1473] = {
        [357210] = {tags = "[self_only][slow][snare][root][player_movement_immune]", override = 357210}, -- Breath of Eons
    }, -- Augmentation
    HUNTER = {
        [1543] = {tags = "[stealth]"}, -- Flare
        [187650] = {tags = "[creature_incapacitate]"}, -- Freezing Trap
        [195645] = {tags = "[creature_slow]", alternatives = {5116}}, -- Wing Clip
        [53271] = {tags = "[slow][snare][root]", pet = true}, -- Master's Call (pet)
        [109215] = {tags = "[self_only][slow][snare][root]"}, -- Posthaste
        [19801] = {tags = "[enrage][purge]"}, -- Tranquilizing Shot
        [187698] = {tags = "[creature_slow]"}, -- Tar Trap
        [1513] = {tags = "[cc_beast]"}, -- Scare Beast
        [19577] = {tags = "[creature_stun]"}, -- Intimidation
        [109248] = {tags = "[creature_root]"}, -- Binding Shot
        [459517] = {tags = "[self_only][poison][disease]"}, -- Emergency Salve
        [781] = {tags = "[self_only][player_jump]"}, -- Disengage
        [24423] = {
            tags = "[creature_mortal_strike]",
            pet = true,
            alternatives = {
                263863, 159936, 160060, 263856, 263861, 279362, 160018, 263853, 54680, 263857, 263854, 263858,
            },
        }, -- Mortal Wounds ability (pet)
    },
    [253] = {}, -- Beast Mastery
    [254] = {}, -- Marksmanship
    [255] = {}, -- Survival
    MAGE = {
        [1953] = {tags = "[self_only][root][player_jump]", alternatives = {212653}}, -- Blink
        [122] = {tags = "[creature_root]"}, -- Frost Nova
        [118] = {tags = "[cc_beast][cc_humanoid][cc_critter]"}, -- Polymorph
        [120] = {tags = "[creature_slow]"}, -- Cone of Cold
        [45438] = {
            tags = "[self_only][bleed][charm][curse][disease][enrage][fear][incapacitate][poison][sleep][slow][snare]",
        }, -- Ice Block
        [30449] = {tags = "[purge]"}, -- Spellsteal
        [31661] = {tags = "[creature_incapacitate]"}, -- Dragon's Breath
        [157980] = {tags = "[creature_grip]"}, -- Supernova
        [475] = {tags = "[curse]"}, -- Remove Curse
        [157997] = {tags = "[creature_root]"}, -- Ice Nova
        [386763] = {tags = "[creature_root]"}, -- Freezing Cold
        [113724] = {tags = "[creature_incapacitate]"}, -- Ring of Frost
        [386828] = {tags = "[self_only][snare]"}, -- Energized Barriers
        [342245] = {tags = "[player_movement_immune]"}, -- Alter Time
    },
    [62] = {}, -- Arcane
    [63] = {}, -- Fire
    [64] = {}, -- Frost
    MONK = {
        [119381] = {tags = "[creature_stun]"}, -- Leg Sweep
        [115078] = {
            tags = "[cc_aberration][cc_beast][cc_critter][cc_demon][cc_dragonkin][cc_elemental][cc_giant][cc_humanoid][cc_mechanical][cc_undead][cc_other]",
        }, -- Paralysis
        [116841] = {tags = "[root][snare]"}, -- Tiger's Lust
        [116095] = {tags = "[creature_slow]"}, -- Disable
        [450432] = {tags = "[enrage]"}, -- Pressure Points
        [116844] = {tags = "[creature_grip]"}, -- Ring of Peace
        [198898] = {tags = "[creature_incapacitate]"}, -- Song of Chi-Ji
        [450622] = {tags = "[self_only][snare]"}, -- Swift Art
        [450595] = {tags = "[creature_slow]"}, -- Spirit's Essence
        [449582] = {tags = "[self_only][player_jump]"}, -- Lighter Than Air
    },
    [268] = {
        [218164] = {tags = "[poison][disease]"}, -- Detox
    }, -- Brewmaster
    [270] = {
        [388874] = {tags = "[poison][disease]"}, -- Improved Detox
        [107428] = {tags = "[creature_mortal_strike]"}, -- Rising Sun Kick
    }, -- Mistweaver
    [269] = {
        [218164] = {tags = "[poison][disease]"}, -- Detox
        [107428] = {tags = "[creature_mortal_strike]"}, -- Rising Sun Kick
    }, -- Windwalker
    PALADIN = {
        [853] = {tags = "[creature_stun]"}, -- Hammer of Justice
        [115750] = {tags = "[creature_incapacitate]"}, -- Blinding Light
        [10326] = {tags = "[cc_undead][cc_aberration][cc_demon]"}, -- Turn Evil
        [469304] = {tags = "[self_only][slow][snare][root]"}, -- Steed of Liberty
        [1044] = {tags = "[slow][snare][root]"}, -- Blessing of Freedom
        [1022] = {tags = "[bleed]"}, -- Blessing of Protection
        [642] = {
            tags = "[self_only][bleed][charm][curse][disease][enrage][fear][incapacitate][poison][sleep][slow][snare]",
        }, -- Divine Shield
        [469321] = {tags = "[poison][disease]"}, -- Righteous Protection
    },
    [65] = {
        [393024] = {tags = "[disease][poison]"}, -- Improved Cleanse
    }, -- Holy
    [66] = {
        [213644] = {tags = "[poison][disease]"}, -- Cleanse Toxins
        [204018] = {tags = "[charm][curse][disease][enrage][fear][incapacitate][poison][sleep][slow][snare]"}, -- Blessing of Spellwarding
    }, -- Protection
    [70] = {
        [213644] = {tags = "[poison][disease]"}, -- Cleanse Toxins
    }, -- Retribution
    PRIEST = {
        [8122] = {tags = "[creature_fear]"}, -- Psychic Scream
        [528] = {tags = "[purge]"}, -- Dispel Magic
        [32375] = {tags = "[purge]"}, -- Mass Dispel
        [605] = {
            tags = "[cc_aberration][cc_beast][cc_critter][cc_dragonkin][cc_elemental][cc_giant][cc_humanoid][cc_other]",
            override = 205364,
        }, -- Mind Control
        [205364] = {
            tags = "[cc_aberration][cc_beast][cc_critter][cc_dragonkin][cc_elemental][cc_giant][cc_humanoid][cc_other]",
            override = 605,
        }, -- Dominate Mind
        [1250691] = {tags = "[creature_root]"}, -- Void Tendrils
        [9484] = {tags = "[cc_aberration][cc_undead]"}, -- Shackle Horror
        [108942] = {tags = "[self_only][snare]"}, -- Phantasm
    },
    [256] = {
        [390632] = {tags = "[disease]"}, -- Improved Purify
    }, -- Discipline
    [257] = {
        [390632] = {tags = "[disease]"}, -- Improved Purify
    }, -- Holy
    [258] = {
        [213634] = {tags = "[disease]"}, -- Purify Disease
    }, -- Shadow
    ROGUE = {
        [1856] = {tags = "[self_only][slow][snare][root]"}, -- Vanish
        [408] = {tags = "[creature_stun]"}, -- Kidney Shot
        [3408] = {tags = "[creature_slow]"}, -- Crippling Poison
        [5938] = {tags = "[enrage]"}, -- Shiv
        [2094] = {
            tags = "[cc_aberration][cc_beast][cc_critter][cc_demon][cc_dragonkin][cc_elemental][cc_giant][cc_humanoid][cc_mechanical][cc_undead][cc_other]",
        }, -- Blind
    },
    [259] = {}, -- Assassination
    [260] = {}, -- Outlaw
    [261] = {}, -- Subtlety
    SHAMAN = {
        [192058] = {tags = "[creature_stun]"}, -- Capacitor Totem
        [2484] = {tags = "[creature_slow]"}, -- Earthbind Totem
        [370] = {tags = "[purge]"}, -- Purge
        [378075] = {tags = "[self_only][snare]"}, -- Thunderous Paws
        [383013] = {tags = "[poison]"}, -- Poison Cleansing Totem
        [462817] = {tags = "[snare]"}, -- Jet Stream for Wind Rush Totem
        [51485] = {tags = "[creature_slow][creature_root]", override = 2484}, -- Earthgrab Totem
        [51514] = {tags = "[cc_humanoid][cc_beast]"}, -- Hex
        [8143] = {tags = "[fear][charm][sleep]"}, -- Tremor Totem
        [58875] = {tags = "[self_only][slow][snare][root]"}, -- Spirit Walk
        [192063] = {tags = "[self_only][player_jump]"}, -- Gust of Wind
    },
    [262] = {
        [51490] = {tags = "[creature_grip]"}, -- Thunderstorm
        [51886] = {tags = "[curse]"}, -- Cleanse Spirit
    }, -- Elemental
    [263] = {
        [51886] = {tags = "[curse]"}, -- Cleanse Spirit
    }, -- Enhancement
    [264] = {
        [383016] = {tags = "[curse]"}, -- Improved Purify Spirit
    }, -- Restoration
    WARLOCK = {
        [5782] = {tags = "[creature_fear]"}, -- Fear
        [710] = {tags = "[cc_demon][cc_aberration][cc_elemental]"}, -- Banish
        [334275] = {tags = "[creature_slow]"}, -- Curse of Exhaustion
        [6789] = {tags = "[creature_incapacitate]"}, -- Mortal Coil
        [268358] = {tags = "[self_only][slow][snare][root]"}, -- Demonic Circle
        [5484] = {tags = "[creature_fear]"}, -- Howl of Terror
        [30283] = {tags = "[creature_stun]"}, -- Shadowfury
        [6358] = {tags = "[cc_humanoid]", pet = true}, -- Seduction (pet)
        [19505] = {tags = "[purge]", pet = true}, -- Devour Magic (pet)
    },
    [265] = {}, -- Affliction
    [266] = {
        [89766] = {tags = "[creature_stun]", pet = true}, -- Axe Toss (pet)
    }, -- Demonology
    [267] = {}, -- Destruction
    WARRIOR = {
        [46968] = {tags = "[creature_stun]"}, -- Shockwave
        [107570] = {tags = "[creature_stun]"}, -- Storm Bolt
        [18499] = {tags = "[self_only][fear][incapacitate]"}, -- Berserker Rage
        [5246] = {tags = "[creature_fear]"}, -- Intimidating Shout
        [383762] = {tags = "[self_only][disease][poison][curse]"}, -- Bitter Immunity
        [384100] = {tags = "[fear]"}, -- Berserker Shout
        [12323] = {tags = "[creature_slow]"}, -- Piercing Howl
        [6544] = {tags = "[self_only][player_jump]"}, -- Heroic Leap
    },
    [71] = {
        [12294] = {tags = "[creature_mortal_strike]"}, -- Mortal Strike
    }, -- Arms
    [72] = {}, -- Fury
    [73] = {}, -- Protection
}
