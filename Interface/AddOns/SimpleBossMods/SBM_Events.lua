-- SimpleBossMods events and slash commands.

local ADDON_NAME = ...
local M = _G[ADDON_NAME]
if not M then return end
local C = M.Const
local L = M.Live
local AG = LibStub and LibStub("AceGUI-3.0", true)

local MANUAL_TIMER_IDS = {
	pull = 9101001,
	["break"] = 9101002,
}

local function printSlashHelp()
	print("|cFF9CDF95Simple|rBossMods: '|cFF9CDF95/sbm|r' for in-game configuration.")
end

local function getCurrentPatchKey()
	local version, _, _, interfaceVersion = GetBuildInfo()
	if type(version) == "string" and version ~= "" then
		return version
	end
	if type(interfaceVersion) == "number" then
		return tostring(interfaceVersion)
	end
	return "unknown"
end

local function maybePrintSlashHelp()
	if type(SimpleBossModsDB) ~= "table" then
		printSlashHelp()
		return
	end
	local patchKey = getCurrentPatchKey()
	if SimpleBossModsDB.lastSlashHelpPatch ~= patchKey then
		SimpleBossModsDB.lastSlashHelpPatch = patchKey
		printSlashHelp()
	end
end

local function trim(s)
	s = tostring(s or "")
	s = s:gsub("^%s+", "")
	s = s:gsub("%s+$", "")
	return s
end

local function getServerTimeSafe()
	if GetServerTime then return GetServerTime() end
	if time then return time() end
	return nil
end

local function parseTimerValue(value)
	if type(value) == "number" then return value end
	if type(value) ~= "string" then return nil end
	local v = value:match("^%s*(.-)%s*$")
	if v == "" then return nil end
	local n = tonumber(v)
	if n then return n end
	local m, s = v:match("^(%d+):(%d+)$")
	if not m then return nil end
	return (tonumber(m) or 0) * 60 + (tonumber(s) or 0)
end

local function shouldAutoSlotKeystone()
	if not L.AUTO_INSERT_KEYSTONE then return false end
	if not (C_ChallengeMode and C_ChallengeMode.SlotKeystone) then return false end
	return true
end

local function getContainerAPIs()
	if C_Container and C_Container.GetContainerNumSlots then
		return C_Container.GetContainerNumSlots, C_Container.GetContainerItemLink, C_Container.PickupContainerItem
	end
	if GetContainerNumSlots and GetContainerItemLink and PickupContainerItem then
		return GetContainerNumSlots, GetContainerItemLink, PickupContainerItem
	end
	return nil, nil, nil
end

local function autoSlotKeystone()
	if not shouldAutoSlotKeystone() then return end
	if GetTime then
		local now = GetTime()
		if M._keystoneAutoSlotAt and (now - M._keystoneAutoSlotAt) < 0.5 then
			return
		end
		M._keystoneAutoSlotAt = now
	end

	local GetContainerNumSlots, GetContainerItemLink, PickupContainerItem = getContainerAPIs()
	if not GetContainerNumSlots then return end

	for bag = 0, 4 do
		local slots = GetContainerNumSlots(bag) or 0
		for slot = 1, slots do
			local itemLink = GetContainerItemLink(bag, slot)
			if itemLink and itemLink:find("Hkeystone", nil, true) then
				if not (C_ChallengeMode.HasSlottedKeystone and C_ChallengeMode.HasSlottedKeystone()) then
					PickupContainerItem(bag, slot)
					pcall(C_ChallengeMode.SlotKeystone)
				end
				return
			end
		end
	end
end

local function setupKeystoneAutoInsert()
	if M._keystoneHooked then return end
	if not (C_ChallengeMode and C_ChallengeMode.SlotKeystone) then return end
	local frame = _G.ChallengesKeystoneFrame
	if not frame then
		if C_Timer and C_Timer.After then
			M._keystoneHookRetry = (M._keystoneHookRetry or 0) + 1
			if M._keystoneHookRetry <= 10 then
				C_Timer.After(0.5, setupKeystoneAutoInsert)
			end
		end
		return
	end

	if not M._keystoneEventFrame then
		local kef = CreateFrame("Frame")
		kef:RegisterEvent("CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN")
		kef:SetScript("OnEvent", function()
			autoSlotKeystone()
		end)
		M._keystoneEventFrame = kef
	end

	frame:HookScript("OnShow", function()
		autoSlotKeystone()
	end)

	M._keystoneHooked = true
	M._keystoneHookRetry = nil
	if frame:IsShown() then
		autoSlotKeystone()
	end
end

M.SetupKeystoneAutoInsert = setupKeystoneAutoInsert

local function isSenderMe(sender)
	if not sender then return false end
	local name, realm = UnitFullName and UnitFullName("player") or UnitName("player")
	if not name then return false end
	if type(realm) == "string" and realm ~= "" then
		if sender == (name .. "-" .. realm) then return true end
	end
	if sender == name then return true end
	if Ambiguate and Ambiguate(sender, "none") == name then return true end
	return false
end

local function canSendAddonMessage()
	if not (C_ChatInfo and C_ChatInfo.SendAddonMessage) then return false end
	if C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown() then return false end
	return true
end

local function getAddonMessageChannel()
	if IsInGroup and IsInGroup(2) and IsInInstance and IsInInstance() then
		return "INSTANCE_CHAT"
	end
	if IsInRaid and IsInRaid() then
		return "RAID"
	end
	if IsInGroup and IsInGroup(1) then
		return "PARTY"
	end
	return nil
end

-- =========================
-- Keystone Sharing (LibKeystone / LRS)
-- =========================
local keystoneData = {} -- [playerName] = { level = number, mapID = number, rating = number, updatedAt = number }
local LibKeystoneListener = {}
local libKeystoneRegistered = false
local formatKeystoneLine
local requestKeystones
local updateKeystoneDisplays
local storeKeystoneInfo
local keystonePopupFrame
local keystonePopupWidget
local currentDungeonKeysFrame
local keystonePopupHideTimer
local keystoneRefreshTimer
local keystonePopupPendingUntil = 0
local currentDungeonKeysSuppressed = false

-- Blizzard difficulty IDs for Mythic dungeons. These are instance difficulty IDs,
-- not keystone level thresholds.
local DUNGEON_DIFFICULTY_MYTHIC = (DifficultyUtil and DifficultyUtil.ID and DifficultyUtil.ID.DungeonMythic) or 23
local DUNGEON_DIFFICULTY_MYTHIC_PLUS = (DifficultyUtil and DifficultyUtil.ID and DifficultyUtil.ID.DungeonChallenge) or 8

local function shouldShowCurrentDungeonKeysForDifficulty(difficultyID)
	return difficultyID == DUNGEON_DIFFICULTY_MYTHIC or difficultyID == DUNGEON_DIFFICULTY_MYTHIC_PLUS
end

local function isKeystoneSharingEnabled()
	return L.SHARE_KEYSTONES
end

local function isPartyGroup()
	if not (IsInGroup and IsInGroup()) then return false end
	if IsInRaid and IsInRaid() then return false end
	return true
end

local function hideKeystoneDisplays()
	if keystonePopupWidget then
		keystonePopupWidget:Hide()
	elseif keystonePopupFrame then
		keystonePopupFrame:Hide()
	end
	if currentDungeonKeysFrame then
		currentDungeonKeysFrame:Hide()
	end
end

local function cancelKeystonePopupHide()
	if keystonePopupHideTimer then
		keystonePopupHideTimer:Cancel()
		keystonePopupHideTimer = nil
	end
end

local function cancelKeystoneRefresh()
	if keystoneRefreshTimer then
		keystoneRefreshTimer:Cancel()
		keystoneRefreshTimer = nil
	end
end

local function getDungeonName(mapID)
	if C_ChallengeMode and C_ChallengeMode.GetMapUIInfo then
		local name = C_ChallengeMode.GetMapUIInfo(mapID)
		if name then return name end
	end
	return tostring(mapID)
end

local function getOwnKeystoneInfo()
	local keyLevel, keyChallengeMapID, playerRating = 0, 0, 0
	if C_MythicPlus and C_MythicPlus.GetOwnedKeystoneLevel then
		keyLevel = C_MythicPlus.GetOwnedKeystoneLevel() or 0
	end
	if C_MythicPlus and C_MythicPlus.GetOwnedKeystoneChallengeMapID then
		keyChallengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID() or 0
	end
	if C_PlayerInfo and C_PlayerInfo.GetPlayerMythicPlusRatingSummary then
		local summary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
		if type(summary) == "table" and type(summary.currentSeasonScore) == "number" then
			playerRating = summary.currentSeasonScore
		end
	end
	return keyLevel, keyChallengeMapID, playerRating
end

local function isChallengeModeRunning()
	if C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive then
		return C_ChallengeMode.IsChallengeModeActive()
	end
	return false
end

local function refreshCurrentDungeonKeysSuppression()
	local _, instanceType, difficultyID = GetInstanceInfo()
	if instanceType ~= "party" or not shouldShowCurrentDungeonKeysForDifficulty(difficultyID) then
		currentDungeonKeysSuppressed = false
		return
	end
	currentDungeonKeysSuppressed = isChallengeModeRunning()
end

local function getCurrentDungeonContext()
	local activeMapID
	if C_ChallengeMode and C_ChallengeMode.GetActiveChallengeMapID then
		activeMapID = C_ChallengeMode.GetActiveChallengeMapID()
		if type(activeMapID) ~= "number" or activeMapID <= 0 then
			activeMapID = nil
		end
	end

	local instanceName, instanceType, difficultyID = GetInstanceInfo()
	if instanceType ~= "party" then
		instanceName = nil
	end

	return activeMapID, activeMapID and getDungeonName(activeMapID) or instanceName, instanceType, difficultyID
end

local function getLibKeystone()
	if not LibStub then return nil end
	return LibStub("LibKeystone", true)
end

local function getLibOpenRaid()
	if not LibStub then return nil end
	return LibStub("LibOpenRaid-1.0", true)
end

local function shouldUseInternalLrsTransport()
	return isKeystoneSharingEnabled() and not getLibOpenRaid()
end

local function selectKeystoneMapID(primaryMapID, fallbackMapID, finalMapID)
	local mapID = tonumber(primaryMapID or "") or 0
	if mapID <= 0 then
		mapID = tonumber(fallbackMapID or "") or 0
	end
	if mapID <= 0 then
		mapID = tonumber(finalMapID or "") or 0
	end
	return mapID
end

local LibOpenRaidListener = {}
local libOpenRaidRegistered = false

local function syncOpenRaidKeystoneInfo(unitName, keystoneInfo)
	if type(keystoneInfo) ~= "table" then return end
	storeKeystoneInfo(
		unitName,
		tonumber(keystoneInfo.level or "") or 0,
		selectKeystoneMapID(keystoneInfo.challengeMapID, keystoneInfo.mythicPlusMapID, keystoneInfo.mapID),
		tonumber(keystoneInfo.rating or "") or 0
	)
end

function LibOpenRaidListener.OnKeystoneUpdate(unitName, keystoneInfo, _allKeystoneInfo)
	if not isKeystoneSharingEnabled() then return end
	if not isPartyGroup() then return end
	syncOpenRaidKeystoneInfo(unitName, keystoneInfo)
end

function LibOpenRaidListener.OnKeystoneWipe(_allKeystoneInfo)
	if not isKeystoneSharingEnabled() then return end
	if not isPartyGroup() then return end
	wipe(keystoneData)
	if updateKeystoneDisplays then
		updateKeystoneDisplays()
	end
end

local function importOpenRaidKeystoneData()
	local openRaid = getLibOpenRaid()
	if not (openRaid and openRaid.GetAllKeystonesInfo) then return false end
	local allKeystones = openRaid.GetAllKeystonesInfo()
	if type(allKeystones) ~= "table" then return false end

	local sawAny = false
	for unitName, keystoneInfo in pairs(allKeystones) do
		sawAny = true
		syncOpenRaidKeystoneInfo(unitName, keystoneInfo)
	end
	return sawAny
end

local function unregisterLibOpenRaidKeystoneListener()
	if not libOpenRaidRegistered then return end
	local openRaid = getLibOpenRaid()
	if openRaid and openRaid.UnregisterCallback then
		pcall(openRaid.UnregisterCallback, LibOpenRaidListener, "KeystoneUpdate", "OnKeystoneUpdate")
		pcall(openRaid.UnregisterCallback, LibOpenRaidListener, "KeystoneWipe", "OnKeystoneWipe")
	end
	libOpenRaidRegistered = false
end

local function registerLibOpenRaidKeystoneListener()
	if libOpenRaidRegistered then return true end
	local openRaid = getLibOpenRaid()
	if not (openRaid and openRaid.RegisterCallback) then return false end

	local okUpdate = pcall(openRaid.RegisterCallback, LibOpenRaidListener, "KeystoneUpdate", "OnKeystoneUpdate")
	local okWipe = pcall(openRaid.RegisterCallback, LibOpenRaidListener, "KeystoneWipe", "OnKeystoneWipe")
	if not okUpdate or not okWipe then
		if openRaid and openRaid.UnregisterCallback then
			pcall(openRaid.UnregisterCallback, LibOpenRaidListener, "KeystoneUpdate", "OnKeystoneUpdate")
			pcall(openRaid.UnregisterCallback, LibOpenRaidListener, "KeystoneWipe", "OnKeystoneWipe")
		end
		return false
	end

	libOpenRaidRegistered = true
	importOpenRaidKeystoneData()
	return true
end

local function unregisterLibKeystoneListener()
	if not libKeystoneRegistered then return end
	local LibKeystone = getLibKeystone()
	if LibKeystone and LibKeystone.Unregister then
		pcall(LibKeystone.Unregister, LibKeystoneListener)
	end
	libKeystoneRegistered = false
end

local function stripRealm(name)
	return name and (name:match("^([^%-]+)") or name) or ""
end

local function classColoredName(name)
	local shortName = stripRealm(name)
	local unit
	if shortName == UnitName("player") then
		unit = "player"
	else
		local count = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
		for i = 1, count do
			if UnitName("party" .. i) == shortName then
				unit = "party" .. i
				break
			end
		end
	end
	if unit then
		local _, class = UnitClass(unit)
		if class then
			local color = RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
			if color and color.GenerateHexColorMarkup then
				return color:GenerateHexColorMarkup() .. shortName .. "|r"
			elseif color then
				return string.format("|cFF%02x%02x%02x%s|r", (color.r or 1) * 255, (color.g or 1) * 255, (color.b or 1) * 255, shortName)
			end
		end
	end
	return "|cFFFFFFFF" .. shortName .. "|r"
end

local function findStoredKeystoneInfo(name)
	if not name then return nil, nil end
	if keystoneData[name] then
		return keystoneData[name], name
	end
	local shortName = stripRealm(name)
	for storedName, info in pairs(keystoneData) do
		if stripRealm(storedName) == shortName then
			return info, storedName
		end
	end
	return nil, nil
end

local function isCurrentDungeonKey(info, currentMapID, currentDungeonName)
	if type(info) ~= "table" then return false end
	local mapID = info.mapID or 0
	if mapID <= 0 then return false end
	if currentMapID and currentMapID > 0 then
		return mapID == currentMapID
	end
	if type(currentDungeonName) == "string" and currentDungeonName ~= "" then
		return getDungeonName(mapID) == currentDungeonName
	end
	return false
end

storeKeystoneInfo = function(playerName, keyLevel, mapID, rating)
	if not playerName then return end
	local senderName = playerName
	if UnitNameUnmodified and senderName == UnitNameUnmodified("player") then
		senderName = UnitName("player") or senderName
	end
	keystoneData[senderName] = {
		level = keyLevel or 0,
		mapID = mapID or 0,
		rating = rating or 0,
		updatedAt = (GetTime and GetTime()) or 0,
	}
	if updateKeystoneDisplays then
		updateKeystoneDisplays()
	end
end

local function registerLibKeystoneListener()
	if libKeystoneRegistered then return true end
	local LibKeystone = getLibKeystone()
	if not LibKeystone then return false end
	LibKeystone.Register(LibKeystoneListener, function(keyLevel, mapID, rating, playerName, channel)
		if not isKeystoneSharingEnabled() then return end
		if channel ~= "PARTY" then return end
		if not isPartyGroup() then return end
		storeKeystoneInfo(playerName, keyLevel, mapID, rating)
	end)
	libKeystoneRegistered = true
	return true
end

-- Also share keys via the LibOpenRaid / LRS protocol used by Details.
-- We only need LibDeflate here; SBM already owns CHAT_MSG_ADDON.
local _lrsLibDeflate
local _lrsAceComm
local _lrsAceCommBridge
local registerLrsKeystoneListener
local handleLrsKeystoneMessage
local _lrsUsesAceComm = false
local function getLrsLibDeflate()
	if _lrsLibDeflate then return _lrsLibDeflate end
	if not LibStub then return nil end
	_lrsLibDeflate = LibStub("LibDeflate", true)
	return _lrsLibDeflate
end

local function getLrsAceComm()
	if _lrsAceComm ~= nil then
		return _lrsAceComm or nil
	end
	if not LibStub then
		_lrsAceComm = false
		return nil
	end
	_lrsAceComm = LibStub("AceComm-3.0", true) or false
	return _lrsAceComm or nil
end

local function getLrsCommChannel()
	if not isPartyGroup() then return nil end
	if LE_PARTY_CATEGORY_INSTANCE and IsInGroup and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
		return "INSTANCE_CHAT"
	end
	return "PARTY"
end

local function encodeLrsPayload(payload)
	if type(payload) ~= "string" or payload == "" then return nil end
	local LibDeflate = getLrsLibDeflate()
	if not LibDeflate then return nil end
	local compressed = LibDeflate:CompressDeflate(payload, {level = 9})
	if not compressed then return nil end
	return LibDeflate:EncodeForWoWAddonChannel(compressed)
end

local function decodeLrsPayload(message)
	if type(message) ~= "string" or message == "" then return nil end
	local LibDeflate = getLrsLibDeflate()
	if not LibDeflate then return nil end
	local decoded = LibDeflate:DecodeForWoWAddonChannel(message)
	if not decoded then return nil end
	return LibDeflate:DecompressDeflate(decoded)
end

local function getOwnedLrsMythicPlusMapID()
	local getContainerNumSlots = (C_Container and C_Container.GetContainerNumSlots) or GetContainerNumSlots
	local getContainerItemID = (C_Container and C_Container.GetContainerItemID) or GetContainerItemID
	local getContainerItemLink = (C_Container and C_Container.GetContainerItemLink) or GetContainerItemLink
	local isItemKeystoneByID = C_Item and C_Item.IsItemKeystoneByID
	if not (getContainerNumSlots and getContainerItemID and getContainerItemLink and isItemKeystoneByID) then
		return 0
	end

	for bag = 0, 4 do
		local slots = getContainerNumSlots(bag) or 0
		for slot = 1, slots do
			local itemID = getContainerItemID(bag, slot)
			if itemID and isItemKeystoneByID(itemID) then
				local itemLink = getContainerItemLink(bag, slot)
				if type(itemLink) == "string" then
					local destroyedItemLink = itemLink:gsub("|", "")
					local _, _, mythicPlusMapID = strsplit(":", destroyedItemLink)
					mythicPlusMapID = tonumber(mythicPlusMapID or "") or 0
					if mythicPlusMapID > 0 then
						return mythicPlusMapID
					end

					local keystoneMapID = tonumber(itemLink:match("Hkeystone:(%d+)") or "") or 0
					if keystoneMapID > 0 then
						return keystoneMapID
					end
				end
			end
		end
	end

	return 0
end

local function buildLrsKeystonePayload()
	local keyLevel = (C_MythicPlus and C_MythicPlus.GetOwnedKeystoneLevel and C_MythicPlus.GetOwnedKeystoneLevel()) or 0
	local mapID = (C_MythicPlus and C_MythicPlus.GetOwnedKeystoneMapID and C_MythicPlus.GetOwnedKeystoneMapID()) or 0
	local challengeMapID = (C_MythicPlus and C_MythicPlus.GetOwnedKeystoneChallengeMapID and C_MythicPlus.GetOwnedKeystoneChallengeMapID()) or 0
	local _, _, classID = UnitClass("player")
	classID = classID or 0
	local ratingSummary = C_PlayerInfo and C_PlayerInfo.GetPlayerMythicPlusRatingSummary and C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
	local rating = (ratingSummary and ratingSummary.currentSeasonScore) or 0
	local mythicPlusMapID = getOwnedLrsMythicPlusMapID()
	if mythicPlusMapID <= 0 then
		mythicPlusMapID = challengeMapID
	end
	local specID = 0
	if GetSpecializationInfo and GetSpecialization then
		specID = GetSpecializationInfo(GetSpecialization()) or 0
	end
	return "K," .. keyLevel .. "," .. mapID .. "," .. challengeMapID .. "," .. classID .. "," .. rating .. "," .. mythicPlusMapID .. "," .. specID
end

local function parseLrsKeystonePayload(payload)
	if type(payload) ~= "string" or payload == "" then return nil end
	local payloadType, keyLevelStr, mapIDStr, challengeMapIDStr, _classIDStr, ratingStr, mythicPlusMapIDStr = strsplit(",", payload)
	if payloadType ~= "K" then return nil end

	local keyLevel = tonumber(keyLevelStr or "")
	if not keyLevel then return nil end

	local mapID = tonumber(mapIDStr or "") or 0
	local challengeMapID = tonumber(challengeMapIDStr or "") or 0
	local mythicPlusMapID = tonumber(mythicPlusMapIDStr or "") or 0
	local rating = tonumber(ratingStr or "") or 0
	local bestMapID = selectKeystoneMapID(challengeMapID, mythicPlusMapID, mapID)

	return keyLevel, bestMapID, rating
end

local function storeOwnKeystoneInfo()
	local playerName = UnitName("player")
	if not playerName then return end
	local keyLevel, mapID, rating = getOwnKeystoneInfo()
	storeKeystoneInfo(playerName, keyLevel, mapID, rating)
end

local function sendLrsEncodedMessage(encoded, channel)
	if not (encoded and channel) then return false end
	local AceComm = getLrsAceComm()
	if AceComm then
		AceComm:SendCommMessage("LRS", encoded, channel, nil, "ALERT")
	else
		C_ChatInfo.SendAddonMessage("LRS", encoded, channel)
	end
	return true
end

local function sendOwnKeystoneViaLrs()
	if not shouldUseInternalLrsTransport() then return end
	if not isPartyGroup() then return end
	if not canSendAddonMessage() then return end
	if not registerLrsKeystoneListener() then return end

	local encoded = encodeLrsPayload(buildLrsKeystonePayload())
	local channel = getLrsCommChannel()
	sendLrsEncodedMessage(encoded, channel)
end

local function sendLrsKeystoneRequest()
	if not shouldUseInternalLrsTransport() then return false end
	if not isPartyGroup() then return false end
	if not canSendAddonMessage() then return false end
	if not registerLrsKeystoneListener() then return false end

	local encoded = encodeLrsPayload("J")
	local channel = getLrsCommChannel()
	return sendLrsEncodedMessage(encoded, channel)
end

local _lrsListenerRegistered = false
registerLrsKeystoneListener = function()
	if _lrsListenerRegistered then return true end
	if not getLrsLibDeflate() then return false end

	local AceComm = getLrsAceComm()
	if AceComm then
		_lrsAceCommBridge = _lrsAceCommBridge or {}
		if not _lrsAceCommBridge._embedded then
			AceComm:Embed(_lrsAceCommBridge)
			_lrsAceCommBridge._embedded = true
		end
		if not _lrsAceCommBridge._registered then
			_lrsAceCommBridge:RegisterComm("LRS", function(_prefix, message, _distribution, sender)
				handleLrsKeystoneMessage(message, sender)
			end)
			_lrsAceCommBridge._registered = true
		end
		_lrsUsesAceComm = true
	elseif C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
		local result = C_ChatInfo.RegisterAddonMessagePrefix("LRS")
		if result == false then return false end
		if type(result) == "number" and result > 1 then return false end
		_lrsUsesAceComm = false
	else
		return false
	end
	_lrsListenerRegistered = true
	return true
end

handleLrsKeystoneMessage = function(message, sender)
	if not _lrsListenerRegistered then return end
	if not shouldUseInternalLrsTransport() then return end
	if not isPartyGroup() then return end

	local leadByte = type(message) == "string" and string.byte(message, 1) or nil
	if leadByte and leadByte >= 1 and leadByte <= 9 then
		if leadByte == 4 then
			message = message:sub(2)
		else
			return
		end
	end

	local payload = decodeLrsPayload(message)
	if not payload then return end

	local payloadType = payload:sub(1, 1)
	if payloadType == "J" then
		sendOwnKeystoneViaLrs()
		return
	end
	if payloadType ~= "K" then return end

	local keyLevel, mapID, rating = parseLrsKeystonePayload(payload)
	if not keyLevel then return end
	storeKeystoneInfo(sender, keyLevel, mapID, rating)
end

requestKeystones = function()
	if not isKeystoneSharingEnabled() then return false end
	if not isPartyGroup() then return false end

	storeOwnKeystoneInfo()

	local requested = false
	if registerLibKeystoneListener() then
		local LibKeystone = getLibKeystone()
		if LibKeystone then
			requested = true
			LibKeystone.Request("PARTY")
		end
	end
	if registerLibOpenRaidKeystoneListener() then
		local openRaid = getLibOpenRaid()
		importOpenRaidKeystoneData()
		if openRaid and openRaid.RequestKeystoneDataFromParty then
			local ok, sent = pcall(openRaid.RequestKeystoneDataFromParty)
			if ok and sent then
				requested = true
			end
		end
	elseif registerLrsKeystoneListener() then
		requested = sendLrsKeystoneRequest() or requested
	end

	return requested
end

local function getGroupMemberNames()
	local members = {}
	if not isPartyGroup() then return members end

	local function addUnit(unit)
		local name, realm = UnitFullName and UnitFullName(unit)
		if not name then
			name, realm = UnitName(unit)
		end
		if name then
			members[name] = true
			if type(realm) == "string" and realm ~= "" then
				members[name .. "-" .. realm] = true
			end
		end
	end

	addUnit("player")
	local count = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, count do
		addUnit("party" .. i)
	end
	return members
end

local function clearStaleKeystoneData()
	if not isPartyGroup() then
		wipe(keystoneData)
		return
	end
	local members = getGroupMemberNames()
	for name in pairs(keystoneData) do
		if not members[name] then
			keystoneData[name] = nil
		end
	end
end

local function getPartyRosterEntries(includeMissing)
	local entries = {}
	if not isPartyGroup() then return entries end

	local function addUnit(unit)
		local name, realm = UnitFullName and UnitFullName(unit)
		if not name then
			name, realm = UnitName(unit)
		end
		if not name then return end

		local fullName = (type(realm) == "string" and realm ~= "") and (name .. "-" .. realm) or name
		local info, storedName = findStoredKeystoneInfo(fullName)
		if not info then
			info, storedName = findStoredKeystoneInfo(name)
		end

		if info or includeMissing then
			entries[#entries + 1] = {
				name = storedName or fullName,
				info = info,
				unit = unit,
			}
		end
	end

	addUnit("player")
	local count = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, count do
		addUnit("party" .. i)
	end
	return entries
end

local function getKeystoneMissingLabel()
	local now = (GetTime and GetTime()) or 0
	if now < (keystonePopupPendingUntil or 0) then
		return "Waiting..."
	end
	return "No response"
end

local function styleKeystoneText(fs, size, r, g, b, a)
	fs:SetFont(C.FONT_PATH, size, C.FONT_FLAGS)
	fs:SetTextColor(r or 1, g or 1, b or 1, a or 1)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	fs:SetWordWrap(false)
	fs:SetSpacing(1)
end

local function sizeKeystoneFrame(frame, minWidth)
	local width = 0
	local height = 8
	if frame.title then
		width = math.max(width, frame.title:GetStringWidth() or 0)
		height = height + (frame.title:GetStringHeight() or 0) + 6
	end
	for _, line in ipairs(frame.lines) do
		if line:IsShown() then
			width = math.max(width, line:GetStringWidth() or 0)
			height = height + (line:GetStringHeight() or 0) + 4
		end
	end
	local widget = frame._aceWidget
	if widget then
		widget:SetWidth(math.max(minWidth or 320, width + 58))
		widget:SetHeight(math.max(140, height + 73))
	else
		frame:SetSize(math.max(minWidth or 220, width + 28), math.max(44, height + 12))
	end
end

local function ensureKeystonePopupFrame()
	if keystonePopupFrame then return keystonePopupFrame end
	if not AG then return nil end

	local widget = AG:Create("Frame")
	widget:SetTitle("Party Keystones")
	widget:SetStatusText("Party only")
	widget:SetLayout("Fill")
	widget:SetWidth(340)
	widget:SetHeight(180)
	widget:EnableResize(false)
	widget:SetCallback("OnClose", function()
		cancelKeystonePopupHide()
	end)
	widget.frame:SetClampedToScreen(true)
	widget.frame:SetFrameStrata("DIALOG")
	widget.frame:ClearAllPoints()
	widget.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	widget:Hide()

	local frame = widget.content
	frame._aceWidget = widget

	frame.lines = {}
	for i = 1, 5 do
		local line = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		if i == 1 then
			line:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -12)
		else
			line:SetPoint("TOPLEFT", frame.lines[i - 1], "BOTTOMLEFT", 0, -4)
		end
		line:SetPoint("RIGHT", frame, "RIGHT", -12, 0)
		styleKeystoneText(line, 13, 1, 1, 1, 1)
		line:Hide()
		frame.lines[i] = line
	end

	keystonePopupWidget = widget
	keystonePopupFrame = frame
	return frame
end

local function ensureCurrentDungeonKeysFrame()
	if currentDungeonKeysFrame then return currentDungeonKeysFrame end
	local frame = CreateFrame("Frame", ADDON_NAME .. "_CurrentDungeonKeys", UIParent)
	frame:SetPoint("TOP", UIParent, "TOP", 0, -165)
	frame:SetFrameStrata("MEDIUM")
	frame:EnableMouse(false)
	frame:Hide()

	frame.bg = frame:CreateTexture(nil, "BACKGROUND")
	frame.bg:SetAllPoints()
	frame.bg:SetColorTexture(0, 0, 0, 0.65)

	frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -8)
	frame.title:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
	styleKeystoneText(frame.title, 16, 1, 0.82, 0.2, 1)
	frame.title:SetJustifyH("CENTER")

	frame.lines = {}
	for i = 1, 5 do
		local line = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		if i == 1 then
			line:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 0, -6)
		else
			line:SetPoint("TOPLEFT", frame.lines[i - 1], "BOTTOMLEFT", 0, -3)
		end
		line:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
		styleKeystoneText(line, 13, 1, 1, 1, 1)
		line:SetJustifyH("CENTER")
		line:Hide()
		frame.lines[i] = line
	end

	if M.ensureFullBorder then
		M.ensureFullBorder(frame, 1, 1, 0.82, 0.2, 1)
	end

	currentDungeonKeysFrame = frame
	return frame
end

formatKeystoneLine = function(name, info, currentMapID, currentDungeonName, missingLabel)
	local coloredName = classColoredName(name)
	if type(info) ~= "table" then
		return string.format("%s: |cFF888888%s|r", coloredName, missingLabel or "No data yet")
	end

	local level = info.level or 0
	local mapID = info.mapID or 0
	local rating = info.rating or 0
	if level > 0 and mapID > 0 then
		local dungeonName = getDungeonName(mapID)
		if isCurrentDungeonKey(info, currentMapID, currentDungeonName) then
			dungeonName = "|cFF9CDF95" .. dungeonName .. "|r"
		end
		local ratingStr = (rating and rating > 0) and string.format(" (|cFFFFD100%d|r io)", rating) or ""
		return string.format("%s: +%d %s%s", coloredName, level, dungeonName, ratingStr)
	elseif level == 0 then
		return string.format("%s: |cFF888888No keystone|r", coloredName)
	end

	return string.format("%s: |cFF888888No data yet|r", coloredName)
end

local function updateKeystonePopup()
	local frame = keystonePopupFrame
	if not frame or not frame:IsShown() then return end
	if not isKeystoneSharingEnabled() or not isPartyGroup() then
		if keystonePopupWidget then
			keystonePopupWidget:Hide()
		end
		return
	end

	local currentMapID, currentDungeonName = getCurrentDungeonContext()
	local entries = getPartyRosterEntries(true)

	if keystonePopupWidget then
		keystonePopupWidget:SetTitle("Party Keystones")
		keystonePopupWidget:SetStatusText("Party only")
	end
	for i, line in ipairs(frame.lines) do
		local entry = entries[i]
		if entry then
			line:SetText(formatKeystoneLine(entry.name, entry.info, currentMapID, currentDungeonName, getKeystoneMissingLabel()))
			line:Show()
		else
			line:SetText("")
			line:Hide()
		end
	end

	sizeKeystoneFrame(frame, 300)
end

local function updateCurrentDungeonKeys()
	local frame = ensureCurrentDungeonKeysFrame()
	if not isKeystoneSharingEnabled() or not isPartyGroup() then
		frame:Hide()
		return
	end

	local currentMapID, currentDungeonName, instanceType, difficultyID = getCurrentDungeonContext()
	if instanceType ~= "party"
		or not shouldShowCurrentDungeonKeysForDifficulty(difficultyID)
		or currentDungeonKeysSuppressed
		or not currentDungeonName
		or currentDungeonName == "" then
		frame:Hide()
		return
	end

	local matched = {}
	for _, entry in ipairs(getPartyRosterEntries(false)) do
		if isCurrentDungeonKey(entry.info, currentMapID, currentDungeonName) then
			matched[#matched + 1] = entry
		end
	end

	if #matched == 0 then
		frame:Hide()
		return
	end

	frame.title:SetText(currentDungeonName .. " Keys")
	for i, line in ipairs(frame.lines) do
		local entry = matched[i]
		if entry then
			local info = entry.info or {}
			line:SetText(string.format("%s |cFF9CDF95+%d|r", classColoredName(entry.name), info.level or 0))
			line:Show()
		else
			line:SetText("")
			line:Hide()
		end
	end

	sizeKeystoneFrame(frame, 220)
	frame:Show()
end

updateKeystoneDisplays = function()
	clearStaleKeystoneData()
	if keystonePopupFrame and keystonePopupFrame:IsShown() then
		updateKeystonePopup()
	end
	updateCurrentDungeonKeys()
end

local function showKeystonePopup(duration)
	local frame = ensureKeystonePopupFrame()
	if not frame then return end
	local widget = frame._aceWidget
	if widget then
		widget:Show()
		if widget.frame and widget.frame.Raise then
			widget.frame:Raise()
		end
	else
		frame:Show()
	end
	updateKeystonePopup()

	cancelKeystonePopupHide()
	if C_Timer and C_Timer.NewTimer then
		keystonePopupHideTimer = C_Timer.NewTimer(duration or 12, function()
			keystonePopupHideTimer = nil
			if keystonePopupWidget then
				keystonePopupWidget:Hide()
			elseif keystonePopupFrame then
				keystonePopupFrame:Hide()
			end
		end)
	end
end

local function queueKeystoneRefresh(delay)
	cancelKeystoneRefresh()
	if not isKeystoneSharingEnabled() then
		hideKeystoneDisplays()
		return
	end
	if not isPartyGroup() then
		updateKeystoneDisplays()
		hideKeystoneDisplays()
		return
	end

	local waitTime = tonumber(delay) or 0.6
	if not (C_Timer and C_Timer.NewTimer) then
		requestKeystones()
		return
	end

	keystoneRefreshTimer = C_Timer.NewTimer(waitTime, function()
		keystoneRefreshTimer = nil
		requestKeystones()
	end)
end

local function doKeysCommand()
	if not L.SHARE_KEYSTONES then
		print("|cFF9CDF95Simple|rBossMods: Keystone sharing is disabled. Enable it in /sbm > Dungeon.")
		return
	end
	if not isPartyGroup() then
		print("|cFF9CDF95Simple|rBossMods: /key only works in a 5-player party.")
		hideKeystoneDisplays()
		return
	end

	ensureCurrentDungeonKeysFrame()
	keystonePopupPendingUntil = ((GetTime and GetTime()) or 0) + 6
	showKeystonePopup(12)
	if not requestKeystones() then
		local frame = ensureKeystonePopupFrame()
		if not frame then
			print("|cFF9CDF95Simple|rBossMods: Could not create the keystone window.")
			return
		end
		if keystonePopupWidget then
			keystonePopupWidget:SetTitle("Party Keystones")
			keystonePopupWidget:SetStatusText("No compatible protocol")
		end
		frame.lines[1]:SetText("|cFFFF7070No compatible keystone protocol is available.|r")
		frame.lines[1]:Show()
		for i = 2, #frame.lines do
			frame.lines[i]:Hide()
		end
		sizeKeystoneFrame(frame, 260)
	end
	updateKeystoneDisplays()
end

local function sendDbmBreakSync(seconds)
	if not canSendAddonMessage() then return end
	local channel = getAddonMessageChannel()
	if not channel then return end
	local secs = math.floor((tonumber(seconds) or 0) + 0.5)
	if secs < 0 or secs > 3600 then return end
	C_ChatInfo.SendAddonMessage("D5", "SBM\t1\tBT\t" .. tostring(secs), channel)
end

local function sendBigWigsBreakSync(seconds)
	if not canSendAddonMessage() then return end
	local channel = getAddonMessageChannel()
	if not channel then return end
	local secs = math.floor((tonumber(seconds) or 0) + 0.5)
	if secs < 0 then return end
	C_ChatInfo.SendAddonMessage("BigWigs", "B^" .. tostring(secs), channel)
end

local function getManualTimersStore()
	if not SimpleBossModsDB then return nil end
	if type(SimpleBossModsDB.manualTimers) ~= "table" then
		SimpleBossModsDB.manualTimers = {}
	end
	return SimpleBossModsDB.manualTimers
end

local function buildManualTimerEventInfo(kind)
	local icon = (M.GetManualTimerIcon and M:GetManualTimerIcon(kind))
		or ((kind == "pull") and C.PULL_ICON or C.BREAK_ICON)
	return {
		name = (kind == "pull") and (C.PULL_LABEL or "Pull") or (C.BREAK_LABEL or "Break"),
		icon = icon,
	}
end

local function setCVarBool(name, enabled)
	if not name then return end
	local value = enabled and "1" or "0"
	if C_CVar and C_CVar.GetCVar and C_CVar.SetCVar then
		local ok, current = pcall(C_CVar.GetCVar, name)
		if ok and tostring(current) == value then return end
		pcall(C_CVar.SetCVar, name, value)
	elseif SetCVar then
		pcall(SetCVar, name, value)
	end
end

local function trySetEncounterTimelineViewBars()
	if not (EditModeManagerFrame and EditModeManagerFrame.IsInitialized and EditModeManagerFrame:IsInitialized()) then
		return false
	end
	if not (Enum and Enum.EditModeSystem and Enum.EditModeEncounterEventsSystemIndices and Enum.EditModeEncounterEventsSetting and Enum.EncounterEventsViewType) then
		return false
	end
	local systemFrame = EditModeManagerFrame:GetRegisteredSystemFrame(
		Enum.EditModeSystem.EncounterEvents,
		Enum.EditModeEncounterEventsSystemIndices.Timeline
	)
	if not systemFrame then return false end
	EditModeManagerFrame:OnSystemSettingChange(systemFrame, Enum.EditModeEncounterEventsSetting.ViewType, Enum.EncounterEventsViewType.Bars)
	return true
end

local function ensureBlizzardTimelineSettings()
	-- Ensure timeline feature is enabled via CVars.
	setCVarBool("combatWarningsEnabled", true)
	setCVarBool("encounterTimelineEnabled", true)

	-- Ensure the Encounter Timeline view type is set to Bars in Edit Mode settings.
	if trySetEncounterTimelineViewBars() then
		M._timelineSettingsRetries = nil
		return
	end

	M._timelineSettingsRetries = (M._timelineSettingsRetries or 0) + 1
	if M._timelineSettingsRetries <= 10 and C_Timer and C_Timer.After then
		C_Timer.After(0.5, ensureBlizzardTimelineSettings)
	end
end

local function deferredTick()
	C_Timer.After(0, function() M:Tick() end)
end

local function getUseRecommendedTimelineSettings()
	local cfg = SimpleBossModsDB and SimpleBossModsDB.cfg
	local general = cfg and cfg.general
	if type(general) == "table" and general.useRecommendedTimelineSettings ~= nil then
		return general.useRecommendedTimelineSettings ~= false
	end
	return true
end

local function hideBlizzardEncounterTimeline()
	local frame = _G.EncounterTimeline
	if not frame then return end
	if not frame._sbmHideHooked then
		frame._sbmHideHooked = true
		frame:HookScript("OnShow", function(self)
			if getUseRecommendedTimelineSettings() then
				self:Hide()
			end
		end)
	end
	if frame:IsShown() and getUseRecommendedTimelineSettings() then
		frame:Hide()
	end
end

local function applyTimelineRecommendedMode()
	if not getUseRecommendedTimelineSettings() then
		return
	end
	ensureBlizzardTimelineSettings()
	hideBlizzardEncounterTimeline()
end

function M:ApplyTimelineRecommendedMode()
	applyTimelineRecommendedMode()
end

local function ensureManualTimerRecord(kind)
	local id = MANUAL_TIMER_IDS[kind]
	if not id then return nil end

	M.events = M.events or {}
	local rec = M.events[id]
	if not rec then
		rec = { id = id }
		M.events[id] = rec
	end

	rec.isManual = true
	rec.forceBar = true
	rec.kind = kind

	return rec, id
end

local function initManualTimer(kind, seconds, opts)
	local rec, id = ensureManualTimerRecord(kind)
	if not rec then return nil end

	local now = (opts and opts.now) or GetTime()
	rec.suppressCountdown = not not (opts and opts.suppressCountdown)
	rec.source = opts and opts.source or nil
	rec.eventInfo = buildManualTimerEventInfo(kind)

	rec.duration = seconds
	rec.startTime = (opts and opts.startTime) or now
	rec.endTime = (opts and opts.endTime) or (rec.startTime + seconds)
	rec.remaining = (opts and opts.remaining) or seconds

	return rec, id, now
end

local function persistManualTimer(kind, seconds, source, suppressCountdown)
	local nowServer = getServerTimeSafe()
	if not nowServer then return nil end
	M:SaveManualTimerState(kind, nowServer + seconds, seconds, {
		suppressCountdown = suppressCountdown,
		source = source,
	})
	return nowServer
end

function M:SaveManualTimerState(kind, endServerTime, duration, opts)
	local store = getManualTimersStore()
	if not store or not kind then return end
	if type(endServerTime) ~= "number" or endServerTime <= 0 then return end
	opts = opts or {}
	store[kind] = {
		endTime = endServerTime,
		duration = tonumber(duration) or 0,
		suppressCountdown = opts.suppressCountdown or false,
		source = opts.source,
	}
end

function M:ClearManualTimerState(kind)
	local store = getManualTimersStore()
	if not store or not kind then return end
	store[kind] = nil
end

local function cancelManualCountdown(rec)
	if not rec then return end
	if rec.countdownTimer and rec.countdownTimer.Cancel then
		rec.countdownTimer:Cancel()
	end
	rec.countdownTimer = nil
end

local function canStartCountdown()
	if not (C_PartyInfo and C_PartyInfo.DoCountdown) then return false end
	if C_PartyInfo.CanStartCountdown then
		return C_PartyInfo.CanStartCountdown()
	end
	return true
end

local function startCountdown(len)
	local secs = math.floor((tonumber(len) or 0) + 0.5)
	if secs <= 0 then return end
	if not canStartCountdown() then return end
	C_PartyInfo.DoCountdown(secs)
end

local function schedulePullCountdown(rec, seconds, endServerTime)
	cancelManualCountdown(rec)
	local secs = tonumber(seconds) or 0
	if secs <= 0 then return end
	if not canStartCountdown() then return end

	if endServerTime then
		local nowServer = getServerTimeSafe()
		if nowServer and nowServer >= endServerTime then
			return
		end
	end

	startCountdown(secs)
end

local function handleManualTimer(kind, msg)
	local raw = trim(msg):lower()
	if raw == "" then
		if kind == "pull" then
			M:StartManualTimer("pull", 10)
		else
			M:StartManualTimer("break", 5 * 60)
		end
		return
	end

	if raw == "stop" or raw == "cancel" or raw == "end" or raw == "0" then
		M:StopManualTimer(kind)
		return
	end

	local n = tonumber(raw)
	if not n then
		print(ADDON_NAME .. " usage: /" .. kind .. " <" .. (kind == "pull" and "sec" or "min") .. "> (or 0/stop)")
		return
	end
	if n <= 0 then
		M:StopManualTimer(kind)
		return
	end

	if kind == "pull" then
		M:StartManualTimer("pull", n)
	else
		M:StartManualTimer("break", n * 60)
	end
end

function M:StartManualTimer(kind, seconds)
	if type(seconds) ~= "number" or seconds <= 0 then return end
	if kind == "pull" then
		self:StopManualTimer("break")
	end

	local rec, id, now = initManualTimer(kind, seconds, { now = GetTime(), suppressCountdown = false })
	if not rec then return end

	local nowServer = persistManualTimer(kind, seconds, rec.source, rec.suppressCountdown)

	if kind == "pull" then
		rec.ignoreCountdownUntil = now + 1
		local endServer = nowServer and (nowServer + seconds) or nil
		schedulePullCountdown(rec, seconds, endServer)
	else
		cancelManualCountdown(rec)
		sendDbmBreakSync(seconds)
		sendBigWigsBreakSync(seconds)
	end

	self:updateRecord(id, rec.eventInfo, seconds)
	self:LayoutAll()
end

function M:StopManualTimer(kind, suppressBroadcast)
	local id = MANUAL_TIMER_IDS[kind]
	if not id then return end
	if self.events[id] then
		cancelManualCountdown(self.events[id])
		self:ClearManualTimerState(kind)
		self:removeEvent(id)
		self:LayoutAll()
	end
	if not suppressBroadcast and kind == "break" then
		sendDbmBreakSync(0)
		sendBigWigsBreakSync(0)
	end
end

function M:StartExternalManualTimer(kind, seconds, source, suppressCountdown)
	if type(seconds) ~= "number" or seconds <= 0 then return end
	if kind == "pull" then
		self:StopManualTimer("break")
	end

	local rec, id, now = initManualTimer(kind, seconds, {
		now = GetTime(),
		suppressCountdown = suppressCountdown,
		source = source,
	})
	if not rec then return end

	local nowServer = persistManualTimer(kind, seconds, rec.source, rec.suppressCountdown)

	if kind == "pull" then
		rec.ignoreCountdownUntil = now + 1
		if rec.suppressCountdown then
			cancelManualCountdown(rec)
		else
			local endServer = nowServer and (nowServer + seconds) or nil
			schedulePullCountdown(rec, seconds, endServer)
		end
	else
		cancelManualCountdown(rec)
	end

	self:updateRecord(id, rec.eventInfo, seconds)
	self:LayoutAll()
end

local function restoreManualTimer(kind, info)
	if type(info) ~= "table" then return end
	local nowServer = getServerTimeSafe()
	if not nowServer then return end
	local endServer = tonumber(info.endTime)
	local duration = tonumber(info.duration)
	local suppressCountdown = not not info.suppressCountdown
	if type(endServer) ~= "number" or type(duration) ~= "number" or duration <= 0 then return end
	local remaining = endServer - nowServer
	if remaining <= 0 then
		M:ClearManualTimerState(kind)
		return
	end
	if remaining > duration then
		remaining = duration
	end

	local now = GetTime()
	local rec, id = initManualTimer(kind, duration, {
		now = now,
		startTime = now - (duration - remaining),
		endTime = now + remaining,
		remaining = remaining,
		suppressCountdown = suppressCountdown,
		source = info.source,
	})
	if not rec then return end

	if kind == "pull" then
		rec.ignoreCountdownUntil = now + 1
		if rec.suppressCountdown then
			cancelManualCountdown(rec)
		else
			schedulePullCountdown(rec, remaining, endServer)
		end
	else
		cancelManualCountdown(rec)
	end

	M:updateRecord(id, rec.eventInfo, remaining)
	M:LayoutAll()
end

-- =========================
-- Events
-- =========================
local ef = CreateFrame("Frame")
ef:SetScript("OnEvent", function(_, event, ...)
	if event == "PLAYER_LOGIN" then
		M:EnsureDefaults()
		M.SyncLiveConfig()
		applyTimelineRecommendedMode()

		M:ApplyGeneralConfig(
			SimpleBossModsDB.cfg.general.gap or 6,
			SimpleBossModsDB.cfg.general.autoInsertKeystone
		)
		M:ApplyIconConfig(SimpleBossModsDB.cfg.icons.size, SimpleBossModsDB.cfg.icons.fontSize, SimpleBossModsDB.cfg.icons.borderThickness)
		M:ApplyBarConfig(SimpleBossModsDB.cfg.bars.width, SimpleBossModsDB.cfg.bars.height, SimpleBossModsDB.cfg.bars.fontSize, SimpleBossModsDB.cfg.bars.borderThickness)
		M:ApplyIndicatorConfig(SimpleBossModsDB.cfg.indicators.iconSize or 0, SimpleBossModsDB.cfg.indicators.barSize or 0)
		if M.UpdateIconsAnchorPosition then
			M:UpdateIconsAnchorPosition()
		end
		if M.UpdateBarsAnchorPosition then
			M:UpdateBarsAnchorPosition()
		end
		if M.ApplyPrivateAuraConfig then
			local pc = SimpleBossModsDB.cfg.privateAuras
			M:ApplyPrivateAuraConfig(pc.size, pc.gap, pc.growDirection, pc.x, pc.y)
		end
		if M.UpdateCombatTimerAppearance then
			M:UpdateCombatTimerAppearance()
		end
		if M.UpdateCombatTimerState then
			M:UpdateCombatTimerState()
		end

		M:CreateSettingsPanel()
		if not (InCombatLockdown and InCombatLockdown()) then
			local now = (GetTime and GetTime()) or 0
			M._suppressTimelineUntil = now + 0.5
		end
		M:Tick()
		M:LayoutAll()
		
		-- Force build on login/reload
		if M and M.BuildEncounterEventCache then
			M:BuildEncounterEventCache()
		end

		if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
			C_ChatInfo.RegisterAddonMessagePrefix("D5")
			C_ChatInfo.RegisterAddonMessagePrefix("BigWigs")
		end
		refreshCurrentDungeonKeysSuppression()
		registerLibKeystoneListener()
		registerLibOpenRaidKeystoneListener()
		if shouldUseInternalLrsTransport() then
			registerLrsKeystoneListener()
		end
		updateKeystoneDisplays()
		queueKeystoneRefresh(2)
		if type(SimpleBossModsDB.manualTimers) == "table" then
			for kind, info in pairs(SimpleBossModsDB.manualTimers) do
				restoreManualTimer(kind, info)
			end
		end

		local enableKeys = SimpleBossModsDB.cfg.general.enableKeyCommands ~= false
		if type(hash_SlashCmdList) == "table" then
			if not hash_SlashCmdList["/pull"] then
				SLASH_SIMPLEBOSSMODSPULL1 = "/pull"
			end
			if not hash_SlashCmdList["/break"] then
				SLASH_SIMPLEBOSSMODSBREAK1 = "/break"
			end
			if enableKeys then
				if not hash_SlashCmdList["/keys"] then
					SLASH_SIMPLEBOSSMODSKEYS1 = "/keys"
				end
				if not hash_SlashCmdList["/key"] then
					SLASH_SIMPLEBOSSMODSKEYS2 = "/key"
				end
			end
		else
			SLASH_SIMPLEBOSSMODSPULL1 = "/pull"
			SLASH_SIMPLEBOSSMODSBREAK1 = "/break"
			if enableKeys then
				SLASH_SIMPLEBOSSMODSKEYS1 = "/keys"
				SLASH_SIMPLEBOSSMODSKEYS2 = "/key"
			end
		end
		maybePrintSlashHelp()
	elseif event == "ADDON_LOADED" then
		local name = ...
		if name == "Blizzard_ChallengesUI" then
			if M.SetupKeystoneAutoInsert then
				M:SetupKeystoneAutoInsert()
			end
		elseif name == "Blizzard_EditMode" then
			applyTimelineRecommendedMode()
		elseif name == "Blizzard_EncounterTimeline" then
			applyTimelineRecommendedMode()
		elseif name == "Blizzard_EncounterEvents" then
			applyTimelineRecommendedMode()
			if M and M.EnsureEncounterEventCache then
				M:EnsureEncounterEventCache()
			end
		elseif name == "Details" then
			registerLibOpenRaidKeystoneListener()
			updateKeystoneDisplays()
			queueKeystoneRefresh(1)
		end
	elseif event == "ENCOUNTER_TIMELINE_EVENT_ADDED" then
		deferredTick()
	elseif event == "ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED" then
		local eventID = ...
		if M.SetTimelineEventTerminalState then
			M:SetTimelineEventTerminalState(eventID)
		end
		deferredTick()
	elseif event == "ENCOUNTER_TIMELINE_EVENT_TRACK_CHANGED"
		or event == "ENCOUNTER_TIMELINE_EVENT_BLOCK_STATE_CHANGED" then
		deferredTick()
	elseif event == "ENCOUNTER_TIMELINE_EVENT_REMOVED" then
		local eventID = ...
		if type(eventID) == "number" then
			M:removeEvent(eventID, "timeline-removed", false)
		end
		deferredTick()
	elseif event == "ENCOUNTER_END" then
		if M and M.ClearEncounterEventFallbackCache then
			M:ClearEncounterEventFallbackCache()
		end
		if M and M.events and M.removeEvent then
			local pendingRemovals = {}
			for eventID, rec in pairs(M.events) do
				if rec and not rec.isManual then
					pendingRemovals[#pendingRemovals + 1] = eventID
				end
			end
			for _, eventID in ipairs(pendingRemovals) do
				M:removeEvent(eventID, "encounter-end", true)
			end
		end
		if M and M.ClearTimelineAnimationState then
			M:ClearTimelineAnimationState()
		end
		if M and M.LayoutAll then
			M:LayoutAll()
		end
	elseif event == "ENCOUNTER_TIMELINE_LAYOUT_UPDATED"
		or event == "ENCOUNTER_TIMELINE_STATE_UPDATED"
		or event == "ENCOUNTER_TIMELINE_VIEW_ACTIVATED" then
		deferredTick()
	elseif event == "ENCOUNTER_TIMELINE_VIEW_DEACTIVATED" then
		if M.clearAll then
			M:clearAll()
		end
		if M.LayoutAll then
			M:LayoutAll()
		end
	elseif event == "EDIT_MODE_LAYOUTS_UPDATED" then
		applyTimelineRecommendedMode()
	elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" or event == "CHALLENGE_MODE_START" then
		if event == "CHALLENGE_MODE_START" then
			currentDungeonKeysSuppressed = true
			if currentDungeonKeysFrame then
				currentDungeonKeysFrame:Hide()
			end
		else
			refreshCurrentDungeonKeysSuppression()
		end
		if M.BuildEncounterEventCache then
			M:BuildEncounterEventCache()
		end
		updateKeystoneDisplays()
		queueKeystoneRefresh(2)
		if isKeystoneSharingEnabled() and isPartyGroup() then
			C_Timer.After(2, sendOwnKeystoneViaLrs)
		end
	elseif event == "GROUP_ROSTER_UPDATE" then
		clearStaleKeystoneData()
		updateKeystoneDisplays()
		queueKeystoneRefresh(1)
	elseif event == "PLAYER_REGEN_DISABLED" then
		if M.StartCombatTimer then
			M:StartCombatTimer(true)
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		if M.StopCombatTimer then
			M:StopCombatTimer()
		end
		if M.RefreshTooltipFrameMouse then
			M:RefreshTooltipFrameMouse()
		end
		if M.EnsureEncounterEventCache then
			M:EnsureEncounterEventCache()
		end
	elseif event == "START_PLAYER_COUNTDOWN" then
		local _, timeSeconds = ...
		local secs = parseTimerValue(timeSeconds)
		if secs and secs > 0 then
			local rec = M.events and M.events[MANUAL_TIMER_IDS.pull] or nil
			if rec then
				if rec.ignoreCountdownUntil and GetTime() <= rec.ignoreCountdownUntil then
					return
				end
				local remaining = rec.endTime and (rec.endTime - GetTime()) or rec.remaining
				if type(remaining) == "number" and remaining >= (secs - 0.5) then
					return
				end
			end
			M:StartExternalManualTimer("pull", secs, "blizzard", true)
		end
	elseif event == "CANCEL_PLAYER_COUNTDOWN" then
		local rec = M.events and M.events[MANUAL_TIMER_IDS.pull] or nil
		if rec and rec.source == "blizzard" then
			M:StopManualTimer("pull", true)
		end
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, msg, channel, sender = ...
		if isSenderMe(sender) then
			return
		end
		if prefix == "D5" then
			local _, proto, syncPrefix, payload = strsplit("\t", msg or "")
			if tonumber(proto) then
				if syncPrefix == "PT" then
					local secs = parseTimerValue(payload)
					if secs ~= nil then
						if secs > 0 then
							if secs >= 3 then
								M:StartExternalManualTimer("pull", secs, "dbm", true)
							end
						else
							M:StopManualTimer("pull", true)
						end
					end
				elseif syncPrefix == "BT" then
					local secs = parseTimerValue(payload)
					if secs ~= nil then
						if secs > 0 then
							if secs <= 3600 then
								M:StartExternalManualTimer("break", secs, "dbm", true)
							end
						else
							M:StopManualTimer("break", true)
						end
					end
				end
			end
		elseif prefix == "BigWigs" then
			local bwPrefix, bwMsg, bwExtra = strsplit("^", msg or "")
			if bwPrefix then
				bwPrefix = bwPrefix:upper()
				local BW_PULL = { P = true, PULL = true, PT = true }
				local BW_BREAK = { BT = true, BR = true, BREAK = true }
				local function handleBWSync(kind, secsStr)
					local secs = parseTimerValue(secsStr)
					if secs ~= nil then
						if secs > 0 then
							M:StartExternalManualTimer(kind, secs, "bigwigs", true)
						else
							M:StopManualTimer(kind, true)
						end
					end
				end
				if BW_PULL[bwPrefix] then
					handleBWSync("pull", bwMsg)
				elseif BW_BREAK[bwPrefix] then
					handleBWSync("break", bwMsg)
				elseif bwPrefix == "B" and bwMsg then
					local inner = bwMsg:upper()
					if BW_PULL[inner] then
						handleBWSync("pull", bwExtra)
					elseif BW_BREAK[inner] or inner == "B" then
						handleBWSync("break", bwExtra)
					end
				end
			end
		elseif prefix == "LRS" and not _lrsUsesAceComm then
			handleLrsKeystoneMessage(msg, sender)
		end
	end
end)
ef:RegisterEvent("PLAYER_LOGIN")
ef:RegisterEvent("PLAYER_ENTERING_WORLD")
ef:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ef:RegisterEvent("GROUP_ROSTER_UPDATE")
ef:RegisterEvent("ADDON_LOADED")
ef:RegisterEvent("CHALLENGE_MODE_START")
ef:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_ADDED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_REMOVED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_TRACK_CHANGED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_EVENT_BLOCK_STATE_CHANGED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_LAYOUT_UPDATED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_STATE_UPDATED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_VIEW_ACTIVATED")
ef:RegisterEvent("ENCOUNTER_TIMELINE_VIEW_DEACTIVATED")
ef:RegisterEvent("ENCOUNTER_END")
ef:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
ef:RegisterEvent("PLAYER_REGEN_DISABLED")
ef:RegisterEvent("PLAYER_REGEN_ENABLED")
ef:RegisterEvent("START_PLAYER_COUNTDOWN")
ef:RegisterEvent("CANCEL_PLAYER_COUNTDOWN")
ef:RegisterEvent("CHAT_MSG_ADDON")

-- =========================
-- Slash
-- =========================
SLASH_SIMPLEBOSSMODS1 = "/sbm"
SLASH_SIMPLEBOSSMODS2 = "/simplebossmods"
SlashCmdList["SIMPLEBOSSMODS"] = function(msg)
	msg = (msg or ""):lower()

	if msg == "" or msg == "settings" or msg == "config" or msg == "options" then
		M:OpenSettings()
		return
	end

	if msg == "test" or msg == "test start" or msg == "starttest" then
		M:StartTest()
		return
	end
	if msg == "test stop" or msg == "test end" or msg == "test off" or msg == "stoptest" then
		M:StopTest()
		return
	end
	if msg:sub(1, 4) == "pull" then
		handleManualTimer("pull", msg:sub(5))
		return
	end
	if msg:sub(1, 5) == "break" then
		handleManualTimer("break", msg:sub(6))
		return
	end

	if msg == "keys" or msg == "key" or msg == "keystones" then
		doKeysCommand()
		return
	end

	if msg == "color events" or msg == "set colors" or msg == "apply colors" then
		if M.BuildEncounterEventCache then
			M:BuildEncounterEventCache()
			print(ADDON_NAME .. ": Applying encounter event colors")
		else
			print(ADDON_NAME .. ": Encounter color build not available")
		end
		return
	end
end

SlashCmdList["SIMPLEBOSSMODSPULL"] = function(msg)
	handleManualTimer("pull", msg)
end

SlashCmdList["SIMPLEBOSSMODSBREAK"] = function(msg)
	handleManualTimer("break", msg)
end

SlashCmdList["SIMPLEBOSSMODSKEYS"] = function()
	doKeysCommand()
end
