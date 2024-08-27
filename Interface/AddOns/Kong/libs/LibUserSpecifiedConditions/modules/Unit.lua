local LibUSC = LibStub and LibStub("LibUserSpecifiedConditions", true)
if not LibUSC then return end

local CATEGORY = "Unit"

LibUSC:RegisterParameter("Player", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The player-controlled character",
    value = "player",
})
LibUSC:SetTypeDefault("Unit", "Player")

LibUSC:RegisterParameter("Target", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The currently targeted unit",
    value = "target",
    Events = {"PLAYER_TARGET_CHANGED"},
    OnEvent = function(self)
        self:FireValueChanged()
    end,
})

LibUSC:RegisterParameter("Pet", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The pet of the player-controlled character",
    value = "pet",
})

LibUSC:RegisterParameter("Mouseover Unit", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The unit currently under the mouse cursor",
    value = "mouseover",
    Events = {"UPDATE_MOUSEOVER_UNIT"},
    OnEvent = function(self)
        self:FireValueChanged()
    end,
})

LibUSC:RegisterParameter("Party Member", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The party member at the given index (1-4)",
    ParameterTypes = {
        "Number",
    },
    configString = "Party Member: {1}",
    
    Call = function(self)
        return "party"..self.Parameters[1]:GetValue()
    end,
    
    IsValid = function(self)
        if (self.Parameters[1]:GetValue() < 1) or (self.Parameters[1]:GetValue() > 4) then
            return false, "Party member index must be between 1 and 4"
        end
        return true
    end,
})

LibUSC:RegisterParameter("Pet of Party Member", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The pet of the party member at the given index (1-4)",
    ParameterTypes = {
        "Number",
    },
    configString = "Pet of Party Member: {1}",
    
    Call = function(self)
        return "partypet"..self.Parameters[1]:GetValue()
    end,
    
    IsValid = function(self)
        if (self.Parameters[1]:GetValue() < 1) or (self.Parameters[1]:GetValue() > 4) then
            return false, "Party member index must be between 1 and 4"
        end
        return true
    end,
})

LibUSC:RegisterParameter("Raid Member", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The raid member at the given index (1-40)",
    ParameterTypes = {
        "Number",
    },
    configString = "Raid Member: {1}",
    
    Call = function(self)
        return "raid"..self.Parameters[1]:GetValue()
    end,
    
    IsValid = function(self)
        if (self.Parameters[1]:GetValue() < 1) or (self.Parameters[1]:GetValue() > 40) then
            return false, "Party member index must be between 1 and 40"
        end
        return true
    end,
})

LibUSC:RegisterParameter("Pet of Raid Member", {
    version = 2,
    type = "Unit",
    category = CATEGORY,
    description = "The pet of the raid member at the given index (1-40)",
    ParameterTypes = {
        "Number",
    },
    configString = "Pet of Raid Member: {1}",
    
    Call = function(self)
        return "raidpet"..self.Parameters[1]:GetValue()
    end,
    
    IsValid = function(self)
        if (self.Parameters[1]:GetValue() < 1) or (self.Parameters[1]:GetValue() > 40) then
            return false, "Party member index must be between 1 and 40"
        end
        return true
    end,
})

LibUSC:RegisterParameter("Target of Unit", { 
    version = 4,
    type = "Unit",
    category = CATEGORY,
    description = "The target of the given unit",
    Events = {"UNIT_TARGET"},
    ParameterTypes = {
        "Unit",
    },
    configString = "Target of {1}",
    
    Init = function(self)
        self:SetParameter(1, LibUSC:Create("Target"))
    end,
    
    Call = function(self)
        return self.Parameters[1]:GetValue().."target"
    end,
    
    OnEvent = function(self, event, unit)
        if unit == self.Parameters[1]:GetValue() then
            self:FireValueChanged()
        end
    end,
})

LibUSC:RegisterParameter("Unit Name", { 
    version = 2,
    type = "Text",
    category = CATEGORY,
    description = "The name of the given unit",
    ParameterTypes = {
        "Unit",
    },
    configString = "Name of {1}",
    
    Call = function(self)
        return UnitName(self.Parameters[1]:GetValue())
    end,
})

LibUSC:RegisterParameter("Unit in Combat", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when the player-controlled character is in combat",
    Events = {"PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED"},
    configString = "Player is in Combat",
    
    Call = function(self)
        return not not InCombatLockdown()
    end,
    
    OnEvent = function(self, event)
        self:SetValue(event == "PLAYER_REGEN_DISABLED")
    end,
})

LibUSC:RegisterParameter("Unit is Resting", { 
    version = 3,
    type = "Truth",
    category = CATEGORY,
    description = "True when the player-controlled character is resting",
    Events = {"PLAYER_UPDATE_RESTING", "PLAYER_ENTERING_WORLD"},
    configString = "Player is Resting",
    
    Call = function(self)
        return not not IsResting()
    end,
})

LibUSC:RegisterParameter("Unit is Casting", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when the given unit is casting",
    Events = {
        "UNIT_SPELLCAST_START", 
        "UNIT_SPELLCAST_STOP", 
        "UNIT_SPELLCAST_CHANNEL_START",
        "UNIT_SPELLCAST_CHANNEL_STOP",
    },
    ParameterTypes = {
        "Unit",
    },
    configString = "{1} is Casting",
    
    Call = function(self)
        return (UnitCastingInfo(self.Parameters[1]:GetValue()) ~= nil)
            or (UnitChannelInfo(self.Parameters[1]:GetValue()) ~= nil)
    end,
    
    OnEvent = function(self, event, unit)
        if (unit == self.Parameters[1]:GetValue()) then
            self:SetValue((event == "UNIT_SPELLCAST_START") 
                       or (event == "UNIT_SPELLCAST_CHANNEL_START"))
        end
    end,
})

LibUSC:RegisterParameter("Unit is Mounted", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when the player-controlled character is mounted",
    Events = {
        "COMPANION_UPDATE",
        "SPELL_UPDATE_USABLE",
    },
    configString = "Player is Mounted",
    
    Call = function(self)
		return IsMounted()
    end,
    
    OnEvent = function(self, event, arg1)
		if ( event == "COMPANION_UPDATE" and arg1 == "MOUNT" ) then
			self._check = true
		elseif ( event == "SPELL_UPDATE_USABLE" and self._check ) then
			self._check = false
			self:SetValue()
		end
    end,
})

LibUSC:RegisterParameter("Unit Exists", { 
    version = 3,
    type = "Truth",
    category = CATEGORY,
    description = "True when the given unit exists",
    ParameterTypes = {
        "Unit",
    },
    configString = "{1} Exists",
    
    Init = function(self)
        self:SetParameter(1, LibUSC:Create("Target"))
    end,
    
    Call = function(self)
        return UnitExists(self.Parameters[1]:GetValue())
    end,
})

LibUSC:RegisterParameter("Unit is Unit", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when two units are the same "
    .."(e.g. Player and Target of Target are often the same unit)",
    ParameterTypes = {
        "Unit",
        "Unit",
    },
    configString = "{1} is the same unit as {2}",
    
    Call = function(self)
        return UnitIsUnit(self.Parameters[1]:GetValue(), self.Parameters[2]:GetValue())
    end,
})

LibUSC:RegisterParameter("Unit Health", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The current health of a given unit",
    Events = {"UNIT_HEALTH"},
    ParameterTypes = {
        "Unit",
    },
    configString = "Health of {1}",
    
    Call = function(self)
        return UnitHealth(self.Parameters[1]:GetValue())
    end,
    
    OnEvent = function(self, event, unit)
        if (unit == self.Parameters[1]:GetValue()) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit Health Maximum", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The maximum health of a given unit",
    Events = {"UNIT_MAXHEALTH"},
    ParameterTypes = {
        "Unit",
    },
    configString = "Maximum Health of {1}",
    
    Call = function(self)
        return UnitHealthMax(self.Parameters[1]:GetValue())
    end,
    
    OnEvent = function(self, event, unit)
        if (unit == self.Parameters[1]:GetValue()) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit Health (Percent)", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The current percent health of a given unit",
    Events = {"UNIT_HEALTH", "UNIT_MAXHEALTH"},
    ParameterTypes = {
        "Unit",
    },
    configString = "Percent Health of {1}",
    
    Call = function(self)
        local unit = self.Parameters[1]:GetValue()
        return UnitHealth(unit)/UnitHealthMax(unit)
    end,
    
    OnEvent = function(self, event, unit)
        if (unit == self.Parameters[1]:GetValue()) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit Health is Low", { 
    version = 1,
    type = "Truth",
    category = CATEGORY,
    description = "True when the current health of a given unit is below a specified threshold",
    Events = {"UNIT_HEALTH", "UNIT_MAXHEALTH"},
    ParameterTypes = {
        "Unit",
        "Number",
    },
    configString = "Health of {1} below {2}%",
    
    Init = function(self)
        self:SetParameter(2, LibUSC:Create("User-Entered Number", 100))
    end,
    
    Call = function(self)
        local unit = self:GetParameter(1):GetValue()
        local percent = self:GetParameter(2):GetValue()
        return UnitHealth(unit)/UnitHealthMax(unit) < percent/100
    end,
    
    OnEvent = function(self, event, unit)
        if (unit == self.Parameters[1]:GetValue()) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit is Moving", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when the given unit is in motion",
    receivesUpdates = true,
    ParameterTypes = {
        "Unit",
    },
    configString = "{1} is Moving",
    
    Call = function(self)
        return GetUnitSpeed(self.Parameters[1]:GetValue()) > 0
    end,
})

LibUSC:RegisterParameter("Unit Speed", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The current speed of the given unit in yards per second",
    receivesUpdates = true,
    ParameterTypes = {
        "Unit",
    },
    configString = "Speed of {1}",
    
    Call = function(self)
        return GetUnitSpeed(self.Parameters[1]:GetValue())
    end,
})

LibUSC:RegisterParameter("Unit Speed (Percent)", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The current percent speed of the given unit, where running is 100%",
    receivesUpdates = true,
    ParameterTypes = {
        "Unit",
    },
    configString = "Speed of {1}",
    
    Call = function(self)
        return GetUnitSpeed(self.Parameters[1]:GetValue()) / 7
    end,
})

local POWER_NAMES = {
[0] = "MANA",
"RAGE",
"FOCUS",
"ENERGY",
"HAPPINESS",
"RUNES",
"RUNIC_POWER",
"SOUL_SHARDS",
"ECLIPSE",
"HOLY_POWER",
}

LibUSC:RegisterParameter("Unit Power", { 
    version = 3,
    type = "Number",
    category = CATEGORY,
    description = "The current power level (mana, rage, etc.) of a given unit",
    Events = {"UNIT_POWER_UPDATE"},
    ParameterTypes = {
        "Power",
        "Unit",
    },
    configString = "{1} of {2}",
    
    Call = function(self)
        return UnitPower(self.Parameters[2]:GetValue(), self.Parameters[1]:GetValue())
    end,
    
    OnEvent = function(self, event, unit, power)
        if (unit == self.Parameters[2]:GetValue()) and (power == POWER_NAMES[self.Parameters[1]:GetValue()]) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit Power Maximum", { 
    version = 3,
    type = "Number",
    category = CATEGORY,
    description = "The maximum power level (mana, rage, etc.) of a given unit",
    Events = {"UNIT_MAXPOWER"},
    ParameterTypes = {
        "Power",
        "Unit",
    },
    configString = "Maximum {1} of {2}",
    
    Call = function(self)
        return UnitPowerMax(self.Parameters[2]:GetValue(), self.Parameters[1]:GetValue())
    end,
    
    OnEvent = function(self, event, unit, power)
        if (unit == self.Parameters[2]:GetValue()) and (power == POWER_NAMES[self.Parameters[1]:GetValue()]) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit Power (Percent)", { 
    version = 3,
    type = "Number",
    category = CATEGORY,
    description = "The current percent power (mana, rage, etc.) of a given unit",
    Events = {"UNIT_POWER_UPDATE", "UNIT_MAXPOWER"},
    ParameterTypes = {
        "Power",
        "Unit",
    },
    configString = "Percent {1} of {2}",
    
    Call = function(self)
        local power = self.Parameters[1]:GetValue()
        local unit = self.Parameters[2]:GetValue()
        return UnitPower(unit, power)/UnitPowerMax(unit, power)
    end,
    
    OnEvent = function(self, event, unit, power)
        if (unit == self.Parameters[2]:GetValue()) and (power == POWER_NAMES[self.Parameters[1]:GetValue()]) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit Power is Low", { 
    version = 1,
    type = "Truth",
    category = CATEGORY,
    configString = "{1} of {2} below {3}%",
    description = "True when the current power (mana, rage, etc.) of a given unit is below a specified threshold",
    ParameterTypes = {
        "Power",
        "Unit",
        "Number",
    },
    Events = {"UNIT_POWER_UPDATE", "UNIT_MAXPOWER"},
    
    Init = function(self)
        self:SetParameter(3, LibUSC:Create("User-Entered Number", 100))
    end,
    
    Call = function(self)
        local power = self:GetParameter(1):GetValue()
        local unit = self:GetParameter(2):GetValue()
        local percent = self:GetParameter(3):GetValue()
        return UnitPower(unit, power)/UnitPowerMax(unit, power) < percent/100
    end,
    
    OnEvent = function(self, event, unit, power)
        if (unit == self:GetParameter(2):GetValue()) 
        and (power == POWER_NAMES[self:GetParameter(1):GetValue()]) then
            self:SetValue()
        end
    end,
})

LibUSC:RegisterParameter("Unit in Range of Spell", {
	type = "Truth",
	category = CATEGORY,
	description = "True when a specific unit is in range of the given spell",
	configString = "{2} is in Range of {1}",
	receivesUpdates = true,
	
	ParameterTypes = {
		{"Spell", "Pet Spell"},
		"Unit",
	},
	
	Init = function(self)
		self:SetParameter(2, LibUSC:Create("Target"))
	end,
	
	Call = function(self)
		local index = self:GetParameter(1):GetValue()
		
		if ( index ~= nil ) then
			local bookType = self:GetParameter(1):GetType() == "Spell" and "spell" or "pet"
			local unitId = self:GetParameter(2):GetValue()
			
			return IsSpellInRange(index, bookType, unitId) == 1 -- NOTE: IsSpellInRange returns: 1 = in range; 0 = not in range; nil = invalid or inapplicable arguments
		end
	end,
	
	IsValid = function(self)
		if ( self:GetParameter(1):GetValue() ~= nil ) then
			return true
		else
			return false, "Invalid spell"
		end
	end,
})

LibUSC:RegisterParameter("Unit in Instance", {
    version = 1,
    type = "Truth",
    category = CATEGORY,
    configString = "Player in {1}",
    description = "True when the player is in the given type of instance",
    ParameterTypes = {
        "Instance",
    },
    Events = {"ZONE_CHANGED_NEW_AREA"},
    
    Call = function(self)
        local isInInstance, instanceType = IsInInstance()
        local parameterValue = self:GetParameter(1):GetValue()
        return (isInInstance and parameterValue == "any") or parameterValue == instanceType
    end,
})

LibUSC:RegisterParameter("Unit is Dead", {
	type = "Truth",
	category = CATEGORY,
	description = "True when the given unit is dead",
	configString = "{1} is Dead",
	receivesUpdates = true,
	
	ParameterTypes = {
		"Unit",
	},
	
	Call = function(self)
		return UnitIsDead(self.Parameters[1]:GetValue())
	end,
})

LibUSC:RegisterParameter("Unit is Ghost", {
	type = "Truth",
	category = CATEGORY,
	description = "True when the given unit is a ghost",
	configString = "{1} is a Ghost",
	receivesUpdates = true,
	
	ParameterTypes = {
		"Unit",
	},
	
	Call = function(self)
		return UnitIsGhost(self.Parameters[1]:GetValue())
	end,
})

LibUSC:RegisterParameter("Unit is Dead or Ghost", {
	type = "Truth",
	category = CATEGORY,
	description = "True when the given unit is dead or a ghost",
	configString = "{1} is Dead or a Ghost",
	receivesUpdates = true,
	
	ParameterTypes = {
		"Unit",
	},
	
	Call = function(self)
		return UnitIsDeadOrGhost(self.Parameters[1]:GetValue())
	end,
})

-- Mainline
if ( WOW_PROJECT_ID == WOW_PROJECT_MAINLINE ) then
	LibUSC:RegisterParameter("Boss", { 
		version = 2,
		type = "Unit",
		category = CATEGORY,
		description = "The boss of the current encounter at the given index (1-4)",
		ParameterTypes = {
			"Number",
		},
		configString = "Boss: {1}",
		
		Call = function(self)
			return "boss"..self.Parameters[1]:GetValue()
		end,
		
		IsValid = function(self)
			if (self.Parameters[1]:GetValue() < 1) or (self.Parameters[1]:GetValue() > 4) then
				return false, "Boss index must be between 1 and 4"
			end
			return true
		end,
	})

	LibUSC:RegisterParameter("Vehicle", {
		version = 2,
		type = "Unit",
		category = CATEGORY,
		description = "The vehicle in which the player-controlled character is currently riding",
		value = "vehicle",
		Events = {"UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE"},
		OnEvent = function(self)
			self:FireValueChanged()
		end,
	})

	LibUSC:RegisterParameter("Player is Interacting with NPC", {
		type = "Truth",
		category = CATEGORY,
		description = "True when the player interacts with a NPC",
		configString = "Player is interacting with a NPC",
		
		Events = {
			"PLAYER_TARGET_CHANGED",
			"GOSSIP_SHOW",
			"GOSSIP_CLOSED",
			"QUEST_COMPLETE",
			"QUEST_DETAIL",
			"QUEST_FINISHED",
			"QUEST_GREETING",
			"QUEST_PROGRESS",
			"BANKFRAME_OPENED",
			"BANKFRAME_CLOSED",
			"MERCHANT_SHOW",
			"MERCHANT_CLOSED",
			"TRAINER_SHOW",
			"TRAINER_CLOSED",
			"SHIPMENT_CRAFTER_OPENED",
			"SHIPMENT_CRAFTER_CLOSED"
		},
		
		Call = function(self)
			return UnitExists("npc")
		end,
	})

	LibUSC:RegisterParameter("Unit in Vehicle", { 
		version = 2,
		type = "Truth",
		category = CATEGORY,
		description = "True when the given unit is riding in a vehicle",
		Events = {"UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE"},
		ParameterTypes = {
			"Unit",
		},
		configString = "{1} is in a Vehicle",
		
		Call = function(self)
			return not not UnitInVehicle(self.Parameters[1]:GetValue())
		end,
		
		OnEvent = function(self, event, unit)
			if (unit == self.Parameters[1]:GetValue()) then
				self:SetValue(event == "UNIT_ENTERED_VEHICLE")
			end
		end,
	})
end

-- Mainline or Burning Crusade Classic
if ( WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC ) then
	LibUSC:RegisterParameter("Focus Unit", {
		version = 2,
		type = "Unit",
		category = CATEGORY,
		description = "The currently focus-targeted unit",
		value = "focus",
		Events = {"PLAYER_FOCUS_CHANGED"},
		OnEvent = function(self)
			self:FireValueChanged()
		end,
	})

	LibUSC:RegisterParameter("Arena Opponent", {
		version = 2,
		type = "Unit",
		category = CATEGORY,
		description = "The arena opponent at the given index (1-5)",
		ParameterTypes = {
			"Number",
		},
		configString = "Arena Opponent: {1}",
		
		Call = function(self)
			return "arena"..self.Parameters[1]:GetValue()
		end,
		
		IsValid = function(self)
			if (self.Parameters[1]:GetValue() < 1) or (self.Parameters[1]:GetValue() > 5) then
				return false, "Arena opponent index must be between 1 and 5"
			end
			return true
		end,
	})
end

-- Classic or Burning Crusade Classic
if ( WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC ) then
	LibUSC:RegisterParameter("Player is Interacting with NPC", {
		type = "Truth",
		category = CATEGORY,
		description = "True when the player interacts with a NPC",
		configString = "Player is interacting with a NPC",
		
		Events = {
			"PLAYER_TARGET_CHANGED",
			"GOSSIP_SHOW",
			"GOSSIP_CLOSED",
			"QUEST_COMPLETE",
			"QUEST_DETAIL",
			"QUEST_FINISHED",
			"QUEST_GREETING",
			"QUEST_PROGRESS",
			"BANKFRAME_OPENED",
			"BANKFRAME_CLOSED",
			"MERCHANT_SHOW",
			"MERCHANT_CLOSED",
			"TRAINER_SHOW",
			"TRAINER_CLOSED",
		},
		
		Call = function(self)
			return UnitExists("npc")
		end,
	})
end

-- LibUSC:RegisterParameter("Unit in Zone", { 
    -- version = 1,
    -- type = "Truth",
    -- category = CATEGORY,
    -- configString = "Player in {1}",
    -- description = "True when the player is in the given zone (e.g. Arathi Basin)",
    -- ParameterTypes = {
        -- "Text",
    -- },
    -- Events = {"ZONE_CHANGED"},
    
    -- Call = function(self)
        -- local _, instance = IsInInstance()
        -- return instance == self:GetParameter(1):GetValue()
    -- end,
-- })
