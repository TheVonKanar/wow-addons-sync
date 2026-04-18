local addonName, addon = ...;

-- luacheck: globals InspectFrame InspectPaperDollItemsFrame CharacterFrame C_PaperDollInfo C_TooltipInfo TooltipUtil IsLevelAtEffectiveMaxLevel InspectPaperDollFrameTalentsButtonMixin INSPECT_TALENTS_BUTTON InspectFrameTab3 RunNextFrame GameFontNormalSmall GameFontHighlightSmall

local oPrint = print;
local function print(...)
	if (true) then
		local msg = strjoin(" ", tostringall(...));
		oPrint("|cff6600ccBetterCharacterPanel|r: " .. GetTime() .. " :", msg);
	end
end

local GetDetailedItemLevelInfo = (C_Item and C_Item.GetDetailedItemLevelInfo) and C_Item.GetDetailedItemLevelInfo or
		GetDetailedItemLevelInfo;
local GetItemQualityColor = (C_Item and C_Item.GetItemQualityColor) and C_Item.GetItemQualityColor or GetItemQualityColor;
local GetItemInfoInstant = (C_Item and C_Item.GetItemInfoInstant) and C_Item.GetItemInfoInstant or GetItemInfo;
local GetInventoryItemDurability = (C_Item and C_Item.GetInventoryItemDurability) and C_Item.GetInventoryItemDurability or
		GetInventoryItemDurability;
local GetInventoryItemQuality = (C_Item and C_Item.GetInventoryItemQuality) and C_Item.GetInventoryItemQuality or
		GetInventoryItemQuality;

local itemLoadQueue = {};

local SPEC_ID_TO_PRIMARY_STAT = {
	-- Death Knight
	[250] = 1, -- Blood (STR)
	[251] = 1, -- Frost (STR)
	[252] = 1, -- Unholy (STR)

	-- Demon Hunter
	[577] = 2, -- Havoc (AGI)
	[581] = 2, -- Vengeance (AGI)
	[1480] = 4, -- Devourer (INT)

	-- Druid
	[102] = 4, -- Balance (INT)
	[103] = 2, -- Feral (AGI)
	[104] = 2, -- Guardian (AGI)
	[105] = 4, -- Restoration (INT)

	-- Evoker
	[1467] = 4, -- Devastation (INT)
	[1468] = 4, -- Preservation (INT)
	[1473] = 4, -- Augmentation (INT)

	-- Hunter
	[253] = 2, -- Beast Mastery (AGI)
	[254] = 2, -- Marksmanship (AGI)
	[255] = 2, -- Survival (AGI)

	-- Mage
	[62] = 4, -- Arcane (INT)
	[63] = 4, -- Fire (INT)
	[64] = 4, -- Frost (INT)

	-- Monk
	[268] = 2, -- Brewmaster (AGI)
	[270] = 4, -- Mistweaver (INT)
	[269] = 2, -- Windwalker (AGI)

	-- Paladin
	[65] = 4, -- Holy (INT)
	[66] = 1, -- Protection (STR)
	[70] = 1, -- Retribution (STR)

	-- Priest
	[256] = 4, -- Discipline (INT)
	[257] = 4, -- Holy (INT)
	[258] = 4, -- Shadow (INT)

	-- Rogue
	[259] = 2, -- Assassination (AGI)
	[260] = 2, -- Outlaw (AGI)
	[261] = 2, -- Subtlety (AGI)

	-- Shaman
	[262] = 4, -- Elemental (INT)
	[263] = 2, -- Enhancement (AGI)
	[264] = 4, -- Restoration (INT)

	-- Warlock
	[265] = 4, -- Affliction (INT)
	[266] = 4, -- Demonology (INT)
	[267] = 4, -- Destruction (INT)

	-- Warrior
	[71] = 1, -- Arms (STR)
	[72] = 1, -- Fury (STR)
	[73] = 1, -- Protection (STR)
};

local ITEMS_STATS_WE_CARE_ABOUT = {
	[INVSLOT_HEAD] = true,
	[INVSLOT_SHOULDER] = true,
	[INVSLOT_CHEST] = true,
	[INVSLOT_BACK] = true,
	[INVSLOT_WRIST] = true,
	[INVSLOT_HAND] = true,
	[INVSLOT_WAIST] = true,
	[INVSLOT_LEGS] = true,
	[INVSLOT_FEET] = true,
	[INVSLOT_MAINHAND] = true,
	[INVSLOT_OFFHAND] = true,
};

local CLASS_ARMOR = {
	WARRIOR     = Enum.ItemArmorSubclass.Plate,
	PALADIN     = Enum.ItemArmorSubclass.Plate,
	DEATHKNIGHT = Enum.ItemArmorSubclass.Plate,

	HUNTER      = Enum.ItemArmorSubclass.Mail,
	SHAMAN      = Enum.ItemArmorSubclass.Mail,
	EVOKER      = Enum.ItemArmorSubclass.Mail,

	ROGUE       = Enum.ItemArmorSubclass.Leather,
	DRUID       = Enum.ItemArmorSubclass.Leather,
	MONK        = Enum.ItemArmorSubclass.Leather,
	DEMONHUNTER = Enum.ItemArmorSubclass.Leather,

	MAGE        = Enum.ItemArmorSubclass.Cloth,
	PRIEST      = Enum.ItemArmorSubclass.Cloth,
	WARLOCK     = Enum.ItemArmorSubclass.Cloth,
}

local NUM_SOCKET_TEXTURES = 4;

local expansionRequiredSockets = {
	[11] = {
		[INVSLOT_NECK] = 1,
		[INVSLOT_FINGER1] = 1,
		[INVSLOT_FINGER2] = 1,
	},
	[10] = {
		[INVSLOT_NECK] = 2,
		[INVSLOT_FINGER1] = 2,
		[INVSLOT_FINGER2] = 2,
	},
	[9] = {
		[INVSLOT_NECK] = 3,
	}
}

local expansionEnchantableSlots = {
	[11] = {
		[INVSLOT_MAINHAND] = true,
		[INVSLOT_HEAD] = true,
		[INVSLOT_SHOULDER] = true,
		[INVSLOT_CHEST] = true,
		[INVSLOT_LEGS] = true,
		[INVSLOT_FEET] = true,
		[INVSLOT_FINGER1] = true,
		[INVSLOT_FINGER2] = true,
	},
	[10] = {
		[INVSLOT_BACK] = true,
		[INVSLOT_CHEST] = true,
		[INVSLOT_WRIST] = true,
		[INVSLOT_WRIST] = true,
		[INVSLOT_LEGS] = true,
		[INVSLOT_FEET] = true,
		[INVSLOT_MAINHAND] = true,
		[INVSLOT_FINGER1] = true,
		[INVSLOT_FINGER2] = true,
	},
	[9] = {
		[INVSLOT_HEAD] = true,
		[INVSLOT_BACK] = true,
		[INVSLOT_CHEST] = true,
		[INVSLOT_WRIST] = true,
		[INVSLOT_WAIST] = true,
		[INVSLOT_LEGS] = true,
		[INVSLOT_FEET] = true,
		[INVSLOT_MAINHAND] = true,
		[INVSLOT_FINGER1] = true,
		[INVSLOT_FINGER2] = true,
	},
}

local buttonLayout =
{
	[INVSLOT_HEAD] = "left",
	[INVSLOT_NECK] = "left",
	[INVSLOT_SHOULDER] = "left",
	[INVSLOT_BACK] = "left",
	[INVSLOT_CHEST] = "left",
	[INVSLOT_WRIST] = "left",

	[INVSLOT_HAND] = "right",
	[INVSLOT_WAIST] = "right",
	[INVSLOT_LEGS] = "right",
	[INVSLOT_FEET] = "right",
	[INVSLOT_FINGER1] = "right",
	[INVSLOT_FINGER2] = "right",
	[INVSLOT_TRINKET1] = "right",
	[INVSLOT_TRINKET2] = "right",

	[INVSLOT_MAINHAND] = "center",
	[INVSLOT_OFFHAND] = "center",
};

local stripEnchantPrefixs = {
	["Enchant "] = "",
	["Weapon %- "] = "",
	["Shoulders %- "] = "",
	["Chest %- "] = "",
	["Ring %- "] = "",
	["Boots %- "] = "",
	["Helm %- "] = "",
	["%+"] = "",
};

local alwaysReplaceNames = {
	["Stamina"] = "Stam",
	["Intellect"] = "Int",
	["Agility"] = "Agi",
	["Strength"] = "Str",

	["Mastery"] = "Mast",
	["Versatility"] = "Vers",
	["Critical Strike"] = "Crit",
	["Haste"] = "Haste",
	["Avoidance"] = "Avoid",
};


local enchantReplacementTable =
{
	["Minor Speed Increase"] = "Speed",
	["Homebound Speed"] = "Speed & HS Red.",
	["Plainsrunner's Breeze"] = "Speed",
	["Graceful Avoidance"] = "Avoid",
	["Regenerative Leech"] = "Leech",
	["Watcher's Loam"] = "Stam",
	["Rider's Reassurance"] = "Mount Speed",
	["Accelerated Agility"] = "Speed & Agi",
	["Reserve of Int"] = "Mana & Int",
	["Sustained Str"] = "Stam & Str",
	["Waking Stats"] = "Primary Stat",

	["Cavalry's March"] = "Mount Speed",
	["Scout's March"] = "Speed",

	["Defender's March"] = "Stam",
	["Stormrider's Agi"] = "Agi & Speed",
	["Council's Intellect"] = "Int & Mana",
	["Crystalline Radiance"] = "Primary Stat",
	["Oathsworn's Strength"] = "Str & Stam",

	["Chant of Armored Avoidance"] = "Avoid",
	["Chant of Armored Leech"] = "Leech",
	["Chant of Armored Speed"] = "Speed",
	["Chant of Winged Grace"] = "Avoid & FallDmg",
	["Chant of Leeching Fangs"] = "Leech & Recup",
	["Chant of Burrowing Rapidity"] = "Speed & HScd",

	["Cursed Haste"] = "Haste & \124cffcc0000-Vers\124r",
	["Cursed Crit"] = "Crit & \124cffcc0000-Haste\124r",
	["Cursed Mastery"] = "Mast & \124cffcc0000-Crit\124r",
	["Cursed Versatility"] = "Vers & \124cffcc0000-Mast\124r",

	["Shadowed Belt Clasp"] = "Stamina",

	["Incandescent Essence"] = "Essence",

	--11
	["Acuity of the Ren'dorei"] = "Proc Prim",
	["Arcane Mastery"] = "Proc Mast",
	["Berserker's Rage"] = "Proc Haste",
	["Flames of the Sin'dorei"] = "Dot->AoE",
	["Jan'alai's Precision"] = "Proc Crit",
	["Strength of Halazzi"] = "Bleed",
	["Worldsoul Aegis"] = "Shield->AoE",
	["Worldsoul Tenacity"] = "Proc Vers",

	["Empowered Blessing of Speed"] = "Speed+Vigor",
	["Blessing of Speed"] = "Speed",
	["Empowered Rune of Avoidance"] = "Avoid+MS",
	["Rune of Avoidance"] = "Avoid",
	["Empowered Hex of Leeching"] = "Leech",
	["Hex of Leeching"] = "Leech",

	["Akil'zon's Swiftness"] = "Speed",
	["Flight of the Eagle"] = "Speed",
	["Amirdrassil's Grace"] = "Avoid",
	["Nature's Grace"] = "Avoid",
	["Thalassian Recovery"] = "Leech",

	["Mark of Nalorakk"] = "Str & Stam",
	["Mark of the Magister"] = "Int & Mana",
	["Mark of the Rootwarden"] = "Agi & Speed",
	["Mark of the Worldsoul"] = "Primary Stat",

	["Arcanoweave Spellthread"] = "Int & Mana",
	["Blood Knight's Armor Kit"] = "Agi/Str & Armor",
	["Forest Hunter's Armor Kit"] = "Ag/Str & Stam",
	["Thalassian Scout Armor Kit"] = "Agi/Str",
	["Bright Linen Spellthread"] = "Int",

	["Shaladrassil's Roots"] = "Leech & Stam",
	["Silvermoon's Mending"] = "Leech",
	["Farstrider's Hunt"] = "Speed & Stam",
	["Lynx's Dexterity"] = "Avoid & Stam",

	["Eyes of the Eagle"] = "Crit%+",
	["Nature's Fury"] = "Crit",
	["Nature's Wrath"] = "Crit",
	["Silvermoon's Alacrity"] = "Haste%",
	["Thalassian Haste"] = "Haste",
	["Zul'jin's Mastery"] = "Mast",
	["Amani Mastery"] = "Mast",
	["Silvermoon's Tenacity"] = "Vers",
	["Thalassian Versatility"] = "Vers",
};

local function ProcessEnchantText(enchantText)
	for seek, replacement in pairs(enchantReplacementTable) do
		enchantText = enchantText:gsub(seek, replacement);
	end

	for index, value in pairs(stripEnchantPrefixs) do
		enchantText = enchantText:gsub(index, value);
	end

	for index in pairs(alwaysReplaceNames) do
		enchantText = enchantText:gsub(index, alwaysReplaceNames[index]);
	end

	return enchantText;
end

local enchantPattern = ENCHANTED_TOOLTIP_LINE:gsub('%%s', '(.*)');
local enchantAtlasPattern = "(.*)%s*|A:(.*):20:20|a";
local enchatColoredPatten = "|cn(.*):(.*)|r";

local function GetItemEnchantAsText(unit, slot)
	local data = C_TooltipInfo.GetInventoryItem(unit, slot);
	for _, line in ipairs(data.lines) do
		local text = line.leftText;
		local enchantText = string.match(text, enchantPattern);
		if (enchantText) then
			local maybeEnchantText, atlas;
			local maybeEnchantColor, maybeEnchantTextColored = enchantText:match(enchatColoredPatten);
			if (maybeEnchantColor) then
				enchantText = maybeEnchantTextColored;
			else
				maybeEnchantText, atlas = enchantText:match(enchantAtlasPattern);
				enchantText = maybeEnchantText or enchantText;
			end

			return atlas, ProcessEnchantText(enchantText)
		end
	end

	return nil, nil;
end

local statsWeLookFor = {
	[ITEM_MOD_STRENGTH_SHORT] = 1,
	[ITEM_MOD_AGILITY_SHORT] = 2,
	[ITEM_MOD_INTELLECT_SHORT] = 4,
};

local function ExtractItemData(unit, slot)
	local data = C_TooltipInfo.GetInventoryItem(unit, slot);
	local itemData = {
		sockets = {},
		stats = {},
	};
	for i, line in ipairs(data.lines) do
		if line.type == 3 then
			if (line.gemIcon) then
				table.insert(itemData.sockets, line.gemIcon);
			else
				table.insert(itemData.sockets, string.format("Interface\\ItemSocketingFrame\\UI-EmptySocket-%s", line.socketType));
			end
		elseif line.type == 0 then
			local statValue, stat = line.leftText:match("%+(%d+) (.*)");
			if (stat) then
				local statId = statsWeLookFor[stat];
				if (statId) then
					itemData.stats[statId] = statValue;
				end
			end
		end
	end

	local itemLink = GetInventoryItemLink(unit, slot);
	local itemType, itemSubType = select(6, GetItemInfoInstant(itemLink));
	local unitClass = UnitClassBase(unit);

	-- TODO : FIX THIS
	-- It should be different filter than general all
	if (itemType == Enum.ItemClass.Armor and
				(itemSubType ~= Enum.ItemArmorSubclass.Shield and
					itemSubType ~= Enum.ItemArmorSubclass.Relic and
					itemSubType ~= Enum.ItemArmorSubclass.Cosmetic and
					itemSubType ~= Enum.ItemArmorSubclass.Generic)
			) then
		if (itemSubType ~= CLASS_ARMOR[unitClass]) then
			itemData.invalidStats = true;
		end
	end

	return itemData;
end

local function CanEnchantSlot(unit, slot)
	local expansion = GetExpansionForLevel(UnitLevel(unit));
	local slotsThatHaveEnchants = expansion and expansionEnchantableSlots[expansion] or {};

	-- all classes have something that increases power or survivability on chest/cloak/weapons/rings/wrist/boots/legs
	if (slotsThatHaveEnchants[slot]) then
		return true;
	end

	-- Offhand filtering smile :)
	if (slot == INVSLOT_OFFHAND) then
		local offHandItemLink = GetInventoryItemLink(unit, slot);
		if (offHandItemLink) then
			local itemEquipLoc = select(4, GetItemInfoInstant(offHandItemLink));
			return itemEquipLoc ~= "INVTYPE_HOLDABLE" and itemEquipLoc ~= "INVTYPE_SHIELD";
		end
		return false;
	end

	return false;
end

local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...);
		return r, g, b;
	elseif perc <= 0 then
		local r, g, b = ...;
		return r, g, b;
	end

	local num = select('#', ...) / 3;

	local segment, relperc = math.modf(perc * (num - 1));
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...);

	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc;
end

local function ColorGradientHP(perc)
	return ColorGradient(perc, 1, 0, 0, 1, 1, 0, 0, 1, 0);
end



local function AnchorTextureLeftOfParent(parent, textures)
	textures[1]:SetPoint("RIGHT", parent, "LEFT", -3, 1);
	for i = 2, NUM_SOCKET_TEXTURES do
		textures[i]:SetPoint("RIGHT", textures[i - 1], "LEFT", -2, 0);
	end
end

local function AnchorTextureRightOfParent(parent, textures)
	textures[1]:SetPoint("LEFT", parent, "RIGHT", 3, 1);
	for i = 2, NUM_SOCKET_TEXTURES do
		textures[i]:SetPoint("LEFT", textures[i - 1], "RIGHT", 2, 0);
	end
end

local function CreateAdditionalDisplayForButton(button)
	local parent = button:GetParent();
	local additionalFrame = CreateFrame("frame", nil, parent);
	additionalFrame:SetWidth(100);

	additionalFrame.ilvlDisplay = additionalFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightOutline");

	additionalFrame.enchantDisplay = additionalFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightOutline");
	additionalFrame.enchantDisplay:SetTextColor(0, 1, 0, 1);

	additionalFrame.invalidSlotDisplay = button:CreateTexture(nil, "OVERLAY");
	additionalFrame.invalidSlotDisplay:SetPoint("CENTER");
	additionalFrame.invalidSlotDisplay:SetAtlas("common-icon-redx");
	local scale = 0.8;
	additionalFrame.invalidSlotDisplay:SetSize(button:GetWidth() * scale, button:GetHeight() * scale);

	additionalFrame.durabilityDisplay = CreateFrame("StatusBar", nil, additionalFrame);
	additionalFrame.durabilityDisplay:SetMinMaxValues(0, 1);
	additionalFrame.durabilityDisplay:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar");
	additionalFrame.durabilityDisplay:GetStatusBarTexture():SetHorizTile(false);
	additionalFrame.durabilityDisplay:GetStatusBarTexture():SetVertTile(false);
	additionalFrame.durabilityDisplay:SetHeight(40);
	additionalFrame.durabilityDisplay:SetWidth(2.3);
	additionalFrame.durabilityDisplay:SetOrientation("VERTICAL");

	additionalFrame.socketDisplay = {};

	for i = 1, NUM_SOCKET_TEXTURES do
		additionalFrame.socketDisplay[i] = additionalFrame:CreateTexture();
		additionalFrame.socketDisplay[i]:SetWidth(14);
		additionalFrame.socketDisplay[i]:SetHeight(14);
	end

	return additionalFrame;
end

local function positonLeft(button)
	local additionalFrame = button.BCPDisplay;

	additionalFrame:SetPoint("TOPLEFT", button, "TOPRIGHT");
	additionalFrame:SetPoint("BOTTOMLEFT", button, "BOTTOMRIGHT");

	additionalFrame.ilvlDisplay:SetPoint("BOTTOMLEFT", additionalFrame, "BOTTOMLEFT", 10, 2);
	additionalFrame.enchantDisplay:SetPoint("TOPLEFT", additionalFrame, "TOPLEFT", 10, -7);

	additionalFrame.durabilityDisplay:SetPoint("TOPLEFT", button, "TOPLEFT", -6, 0);
	additionalFrame.durabilityDisplay:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", -6, 0);

	AnchorTextureRightOfParent(additionalFrame.ilvlDisplay, additionalFrame.socketDisplay);
end

local function positonRight(button)
	local additionalFrame = button.BCPDisplay;

	additionalFrame:SetPoint("TOPRIGHT", button, "TOPLEFT");
	additionalFrame:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT");

	additionalFrame.ilvlDisplay:SetPoint("BOTTOMRIGHT", additionalFrame, "BOTTOMRIGHT", -10, 2);
	additionalFrame.enchantDisplay:SetPoint("TOPRIGHT", additionalFrame, "TOPRIGHT", -10, -7);

	additionalFrame.durabilityDisplay:SetWidth(1.2);
	additionalFrame.durabilityDisplay:SetPoint("TOPRIGHT", button, "TOPRIGHT", 4, 0);
	additionalFrame.durabilityDisplay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 4, 0);

	AnchorTextureLeftOfParent(additionalFrame.ilvlDisplay, additionalFrame.socketDisplay);
end

local function positonCenter(button)
	local additionalFrame = button.BCPDisplay;

	additionalFrame:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", -100, 0);
	additionalFrame:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, -100);

	additionalFrame.durabilityDisplay:SetHeight(2);
	additionalFrame.durabilityDisplay:SetWidth(40);
	additionalFrame.durabilityDisplay:SetOrientation("HORIZONTAL");
	additionalFrame.durabilityDisplay:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 0, -2);
	additionalFrame.durabilityDisplay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, -2);

	additionalFrame.ilvlDisplay:SetPoint("BOTTOM", button, "TOP", 0, 7);

	if (button:GetID() == INVSLOT_MAINHAND) then
		additionalFrame.enchantDisplay:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", -5, 0);
		AnchorTextureLeftOfParent(additionalFrame.ilvlDisplay, additionalFrame.socketDisplay);
	else
		additionalFrame.enchantDisplay:SetPoint("BOTTOMLEFT", button, "BOTTOMRIGHT", 5, 0);
		AnchorTextureRightOfParent(additionalFrame.ilvlDisplay, additionalFrame.socketDisplay);
	end
end

local function AnchorAdditionalDisplay(button)
	local layout = buttonLayout[button:GetID()];
	if (layout == "left") then
		positonLeft(button);
	elseif (layout == "right") then
		positonRight(button);
	elseif (layout == "center") then
		positonCenter(button);
	end
end

local function UpdateAdditionalDisplayForReal(button, unit)
	if (not button:IsShown()) then return end

	local additionalFrame = button.BCPDisplay;
	local slot = button:GetID();
	local itemLink = GetInventoryItemLink(unit, slot);

	local itemiLvlText = "";
	if (itemLink) then
		local ilvl = GetDetailedItemLevelInfo(itemLink);
		local quality = GetInventoryItemQuality(unit, slot);
		if (quality) then
			local hex = select(4, GetItemQualityColor(quality));
			itemiLvlText = "|c" .. hex .. ilvl .. "|r";
		else
			itemiLvlText = ilvl;
		end
	end
	additionalFrame.ilvlDisplay:SetText(itemiLvlText);

	local atlas, enchantText
	if itemLink then
		atlas, enchantText = GetItemEnchantAsText(unit, slot);
	end

	local canEnchant = CanEnchantSlot(unit, slot);

	if (not enchantText) then
		local shouldDisplayEchantMissingText = canEnchant and itemLink and IsLevelAtEffectiveMaxLevel(UnitLevel(unit));
		additionalFrame.enchantDisplay:SetText(shouldDisplayEchantMissingText and "|cffff0000No Enchant|r" or "");
	else
		--trim size
		local maxSize = 18;
		local containsColor = string.find(enchantText, "|c");
		if (containsColor) then
			maxSize = maxSize + strlen("|cffffffff|r");
		end
		enchantText = string.sub(enchantText, 1, maxSize);

		local enchantQuality = "";
		if atlas then
			enchantQuality = "|A:" .. atlas .. ":12:12|a";
		end

		-- for symmetry, put quality on the left of offhand
		if slot == INVSLOT_OFFHAND then
			additionalFrame.enchantDisplay:SetText(enchantQuality .. enchantText);
		else
			additionalFrame.enchantDisplay:SetText(enchantText .. enchantQuality);
		end
	end

	local itemData = ExtractItemData(unit, slot);
	local textures = itemData.sockets;
	for i = 1, NUM_SOCKET_TEXTURES do
		local socketTexture = additionalFrame.socketDisplay[i];
		if (#textures >= i) then
			socketTexture:SetTexture(textures[i]);
			socketTexture:SetVertexColor(1, 1, 1);
			socketTexture:Show();
		else
			local expansion = GetExpansionForLevel(UnitLevel(unit));
			local expansionSocketRequirement = expansion and expansionRequiredSockets[expansion];
			if (expansionSocketRequirement and expansionSocketRequirement[slot] and i <= expansionSocketRequirement[slot]) then
				socketTexture:SetTexture("Interface\\ItemSocketingFrame\\UI-EmptySocket-Red");
				socketTexture:SetVertexColor(1, 0, 0);
				socketTexture:Show();
			else
				socketTexture:Hide();
			end
		end
	end


	local statMatch = false;
	local isInspecting = not UnitIsUnit("player", unit);

	-- Need to do this because wow doesent really do inspecting properlly over long range :))))))))))))))))))))))))))))))))))))))))))))
	if (isInspecting) then
		local playerMap = C_Map.GetBestMapForUnit("player");
		local inspectMap = C_Map.GetBestMapForUnit(unit);

		if (playerMap ~= inspectMap) then
			statMatch = true;
		end
	end

	if (ITEMS_STATS_WE_CARE_ABOUT[slot] and not statMatch) then
		local primaryStat;
		if (isInspecting) then
			local specId = GetInspectSpecialization(unit);
			primaryStat = specId and SPEC_ID_TO_PRIMARY_STAT[specId];
		else
			local specId = C_SpecializationInfo.GetSpecializationInfo(GetSpecialization());
			primaryStat = specId and SPEC_ID_TO_PRIMARY_STAT[specId];
		end

		if (primaryStat) then
			local itemPrimaryStat = itemData.stats;
			for stat, value in pairs(itemPrimaryStat) do
				if (stat == primaryStat) then
					statMatch = true;
					break;
				end
			end
		end
		statMatch = statMatch and (not itemData.invalidStats or slot == INVSLOT_BACK);
	else
		statMatch = true;
	end

	if (not statMatch) then
		additionalFrame.invalidSlotDisplay:Show();
		button.icon:SetDesaturated(true);
	else
		additionalFrame.invalidSlotDisplay:Hide();
		button.icon:SetDesaturated(false);
	end
end

local function UpdateAdditionalDisplay(button, unit)
	local additionalFrame = button.BCPDisplay;

	-- This should never happen, but apparently it does sometimes for some reason.
	-- Cant reproduce it, but it happens.
	if (not additionalFrame) then return; end

	local slot = button:GetID();
	local itemLink = GetInventoryItemLink(unit, slot);

	if (itemLink) then
		local itemId = GetItemInfoInstant(itemLink);
		itemLoadQueue[itemId] = { button = button, unit = unit };
		C_Item.RequestLoadItemDataByID(itemId);
	else
		additionalFrame.ilvlDisplay:SetText("");
		additionalFrame.enchantDisplay:SetText("");
		for i = 1, NUM_SOCKET_TEXTURES do
			additionalFrame.socketDisplay[i]:Hide();
		end
		additionalFrame.invalidSlotDisplay:Hide();
	end

	local currentDurablity, maxDurability = GetInventoryItemDurability(slot);
	local percDurability = currentDurablity and currentDurablity / maxDurability;

	if (not additionalFrame.prevDurability or additionalFrame.prevDurability ~= percDurability) then
		if (UnitIsUnit("player", unit) and percDurability and percDurability < 1) then
			additionalFrame.durabilityDisplay:Show();
			additionalFrame.durabilityDisplay:SetValue(percDurability);
			additionalFrame.durabilityDisplay:SetStatusBarColor(ColorGradientHP(percDurability));
		else
			additionalFrame.durabilityDisplay:Hide();
		end
		additionalFrame.prevDurability = percDurability;
	end
end

local function CreateInspectIlvlDisplay()
	local parent = InspectPaperDollItemsFrame;
	if (not parent.ilvlDisplay) then
		parent.ilvlDisplay = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightOutline22");
		parent.ilvlDisplay:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -20);
		parent.ilvlDisplay:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT", -80, -67);
	end
end

local LEGENDARY_ITEM_LEVEL = 287;
local STEP_ITEM_LEVEL = 17;

local levelThresholds = {};
for i = 4, 1, -1 do
	levelThresholds[i] = LEGENDARY_ITEM_LEVEL - (STEP_ITEM_LEVEL * (i - 1));
end


local function UpdateInspectIlvlDisplay(unit)
	local ilvl = C_PaperDollInfo.GetInspectItemLevel(unit);
	local color;
	if (ilvl < levelThresholds[4]) then
		color = "fafafa";
	elseif (ilvl < levelThresholds[3]) then
		color = "1eff00";
	elseif (ilvl < levelThresholds[2]) then
		color = "0070dd";
	elseif (ilvl < levelThresholds[1]) then
		color = "a335ee";
	else
		color = "ff8000";
	end

	local parent = InspectPaperDollItemsFrame;
	parent.ilvlDisplay:SetText(string.format("|cff%s%d|r", color, ilvl));
end

local updateButton = function(button, unit)
	if (not buttonLayout[button:GetID()]) then
		return;
	end

	if (not button.BCPDisplay) then
		button.BCPDisplay = CreateAdditionalDisplayForButton(button);
		AnchorAdditionalDisplay(button);
	end

	UpdateAdditionalDisplay(button, unit);
end

hooksecurefunc("PaperDollItemSlotButton_Update", function(button) updateButton(button, "player"); end);

function addon:MoveTalentButton(talentButton)
	talentButton:SetSize(72, 32);

	talentButton.Left:SetTexture(nil);
	talentButton.Left:SetTexCoord(0, 1, 0, 1);
	talentButton.Left:ClearAllPoints();
	talentButton.Left:SetPoint("TOPLEFT");
	talentButton.Left:SetAtlas("uiframe-tab-left", true);
	talentButton.Left:SetHeight(36);

	talentButton.Right:SetTexture(nil);
	talentButton.Right:SetTexCoord(0, 1, 0, 1);
	talentButton.Right:ClearAllPoints();
	talentButton.Right:SetPoint("TOPRIGHT", 6);
	talentButton.Right:SetAtlas("uiframe-tab-right", true);
	talentButton.Right:SetHeight(36);

	talentButton.Middle:SetTexture(nil);
	talentButton.Middle:SetTexCoord(0, 1, 0, 1);
	talentButton.Middle:ClearAllPoints();
	talentButton.Middle:SetPoint("LEFT", talentButton.Left, "RIGHT");
	talentButton.Middle:SetPoint("RIGHT", talentButton.Right, "LEFT");
	talentButton.Middle:SetAtlas("_uiframe-tab-center", true);
	talentButton.Middle:SetHeight(36);

	talentButton.LeftHighlight = talentButton:CreateTexture();
	talentButton.LeftHighlight:SetAtlas("uiframe-tab-left", true);
	talentButton.LeftHighlight:SetAlpha(0.4);
	talentButton.LeftHighlight:SetBlendMode("ADD");
	talentButton.LeftHighlight:SetPoint("TOPLEFT");
	talentButton.LeftHighlight:Hide();

	talentButton.RightHighlight = talentButton:CreateTexture();
	talentButton.RightHighlight:SetAtlas("uiframe-tab-right", true);
	talentButton.RightHighlight:SetAlpha(0.4);
	talentButton.RightHighlight:SetBlendMode("ADD");
	talentButton.RightHighlight:SetPoint("TOPRIGHT", 6);
	talentButton.RightHighlight:Hide();

	talentButton.MiddleHighlight = talentButton:CreateTexture();
	talentButton.MiddleHighlight:SetAtlas("_uiframe-tab-center", true);
	talentButton.MiddleHighlight:SetAlpha(0.4);
	talentButton.MiddleHighlight:SetBlendMode("ADD");
	talentButton.MiddleHighlight:SetPoint("LEFT", talentButton.Left, "RIGHT");
	talentButton.MiddleHighlight:SetPoint("RIGHT", talentButton.Right, "LEFT");
	talentButton.MiddleHighlight:Hide();

	talentButton:SetNormalFontObject(GameFontNormalSmall);
	talentButton:SetHighlightFontObject(GameFontHighlightSmall);
	talentButton:ClearHighlightTexture();
	talentButton.Text:ClearAllPoints();
	talentButton.Text:SetPoint("CENTER", 0, 2);
	talentButton.Text:SetHeight(10);

	talentButton:HookScript("OnEnter", function(self)
		for _, v in ipairs({ "MiddleHighlight", "LeftHighlight", "RightHighlight" }) do
			self[v]:Show();
		end
	end);

	talentButton:HookScript("OnLeave", function(self)
		for _, v in ipairs({ "MiddleHighlight", "LeftHighlight", "RightHighlight" }) do
			self[v]:Hide();
		end
	end);

	talentButton:SetScript("OnMouseDown", nil);
	talentButton:SetScript("OnMouseUp", nil);
	talentButton:SetScript("OnShow", nil);
	talentButton:SetScript("OnEnable", nil);
	talentButton:SetScript("OnDisable", nil);

	talentButton:ClearAllPoints();
	talentButton:SetPoint("LEFT", InspectFrameTab3, "RIGHT", 3, 0);
end

function addon:ADDON_LOADED(addonName)
	if (addonName == "Blizzard_InspectUI") then
		local talentButton = InspectPaperDollItemsFrame.InspectTalents;
		if (talentButton) then
			addon:MoveTalentButton(talentButton);
		end

		hooksecurefunc("InspectPaperDollItemSlotButton_Update", function(button)
			updateButton(button, InspectFrame.unit);
		end);

		hooksecurefunc("InspectPaperDollFrame_SetLevel", function()
			if (not InspectFrame.unit) then return; end
			CreateInspectIlvlDisplay();
			UpdateInspectIlvlDisplay(InspectFrame.unit);
		end);
	end
end

local characterSlots = {
	"CharacterHeadSlot",
	"CharacterNeckSlot",
	"CharacterShoulderSlot",
	"CharacterChestSlot",
	"CharacterWaistSlot",
	"CharacterLegsSlot",
	"CharacterFeetSlot",
	"CharacterWristSlot",
	"CharacterHandsSlot",
	"CharacterFinger0Slot",
	"CharacterFinger1Slot",
	"CharacterTrinket0Slot",
	"CharacterTrinket1Slot",
	"CharacterBackSlot",
	"CharacterMainHandSlot",
	"CharacterSecondaryHandSlot",
};

local function updateAllCharacterSlots()
	for _, slot in ipairs(characterSlots) do
		local button = _G[slot];
		if (button) then
			UpdateAdditionalDisplay(button, "player");
		end
	end
end

local lastUpdate = 0;
function addon:SOCKET_INFO_UPDATE()
	if (CharacterFrame:IsShown()) then
		local time = GetTime();
		if (time ~= lastUpdate) then
			updateAllCharacterSlots();
			lastUpdate = time;
		end
	end
end

-- fired when enchants are applied
function addon:UNIT_INVENTORY_CHANGED(unit)
	if (unit == "player") then
		addon:SOCKET_INFO_UPDATE()
	end
end

function addon:ITEM_DATA_LOAD_RESULT(itemID, success)
	local queuedItem = itemLoadQueue[itemID];
	if (queuedItem) then
		UpdateAdditionalDisplayForReal(queuedItem.button, queuedItem.unit);
		itemLoadQueue[itemID] = nil;
	end
end

local eventListener = CreateFrame("frame");
eventListener:SetScript("OnEvent", function(self, event, ...)
	addon[event](addon, ...);
end);
eventListener:RegisterEvent("ADDON_LOADED");
eventListener:RegisterEvent("SOCKET_INFO_UPDATE");
eventListener:RegisterEvent("UNIT_INVENTORY_CHANGED");
eventListener:RegisterEvent("ITEM_DATA_LOAD_RESULT");
