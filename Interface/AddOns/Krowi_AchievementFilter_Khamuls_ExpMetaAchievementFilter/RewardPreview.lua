local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local RewardPreview = KhamulsAchievementFilter:NewModule("DecorPreview")

local PREVIEW_ICON_TEXTURE = "Interface\\AddOns\\Krowi_AchievementFilter_Khamuls_ExpMetaAchievementFilter\\Media\\lookingglass.tga"
local PREVIEW_MENU_TEXT = L["Preview Reward"]
local PREVIEW_MISSING_TEXT = L["No preview available for this reward"]
local DECOR_PREVIEW_BUILD = "km2-2026-04-05-2"
local REWARD_TYPE_NPC = 1
local REWARD_TYPE_ITEM = 3
local REWARD_TYPE_SPELL = 6
local REWARD_TYPE_TITLE = 11
local REWARD_TYPE_HOUSING_DECOR = 201

local menuBuilder
local pluginRegistered
local hooksRegistered

local previewableItemCache = {}
local pendingItemLoads = {}
local refreshScheduled
local decorPreviewDataCache = {}
local decorPreviewFrame
local BuildUnifiedModelDataFromReward
local EnsureDecorPreviewFrame
local PositionDecorPreviewWindow
local closeHookedFrames = {}

local function IsDebugEnabled()
    return KhamulsAchievementFilter
        and KhamulsAchievementFilter.db
        and KhamulsAchievementFilter.db.profile
        and KhamulsAchievementFilter.db.profile.debugEnabled == true
end

local function DebugPrint(message)
    if IsDebugEnabled() and KhamulsAchievementFilter and type(KhamulsAchievementFilter.Print) == "function" then
        KhamulsAchievementFilter:Print(message)
    end
end

local function ScheduleAchievementFrameRefresh()
    if refreshScheduled then
        return
    end

    refreshScheduled = true
    C_Timer.After(0.1, function()
        refreshScheduled = nil
        if _G.KrowiAF_AchievementsFrame and type(_G.KrowiAF_AchievementsFrame.ForceUpdate) == "function" then
            _G.KrowiAF_AchievementsFrame:ForceUpdate()
        end
    end)
end

local function EnsureCollectionsLoaded()
    if not C_AddOns or not C_AddOns.IsAddOnLoaded or not C_AddOns.LoadAddOn then
        return
    end

    if not C_AddOns.IsAddOnLoaded("Blizzard_Collections") then
        C_AddOns.LoadAddOn("Blizzard_Collections")
    end
end

local function EnsureHousingUiLoaded()
    if not C_AddOns or not C_AddOns.IsAddOnLoaded or not C_AddOns.LoadAddOn then
        return
    end
    if not C_AddOns.IsAddOnLoaded("Blizzard_HousingUI") then
        pcall(C_AddOns.LoadAddOn, "Blizzard_HousingUI")
    end
end

local function GetRewardDB()
    return KhamulsAchievementFilter and KhamulsAchievementFilter.RewardPreviewDb and KhamulsAchievementFilter.RewardPreviewDb.Achievements
end

local function GetHousingDecorName(decorID)
    if type(decorID) ~= "number" or decorID <= 0 then
        return nil
    end
    if C_HousingDecor and type(C_HousingDecor.GetDecorName) == "function" then
        local ok, name = pcall(C_HousingDecor.GetDecorName, decorID)
        if ok and type(name) == "string" and name ~= "" then
            return name
        end
    end
    return nil
end

local function ExtractNumericByKeys(sourceTable, keys)
    if type(sourceTable) ~= "table" then
        return nil
    end
    for _, key in ipairs(keys) do
        local value = sourceTable[key]
        if type(value) == "number" and value > 0 then
            return value
        end
    end
    return nil
end

local function ExtractTextureByKeys(sourceTable, keys)
    if type(sourceTable) ~= "table" then
        return nil
    end
    for _, key in ipairs(keys) do
        local value = sourceTable[key]
        if (type(value) == "number" and value > 0) or (type(value) == "string" and value ~= "") then
            return value
        end
    end
    return nil
end

local function VisitTablesDeep(root, visitor, visited)
    if type(root) ~= "table" or type(visitor) ~= "function" then
        return
    end
    visited = visited or {}
    if visited[root] then
        return
    end
    visited[root] = true

    visitor(root)
    for _, value in pairs(root) do
        if type(value) == "table" then
            VisitTablesDeep(value, visitor, visited)
        end
    end
end

local function ExtractModelCandidatesDeep(sourceTable)
    local out = {
        displayID = nil,
        modelID = nil,
        modelPath = nil,
        sceneID = nil,
        asset = nil,
        texture = nil,
    }

    VisitTablesDeep(sourceTable, function(tbl)
        for key, value in pairs(tbl) do
            local keyLower = string.lower(tostring(key or ""))
            if type(value) == "number" and value > 0 then
                if (not out.modelID)
                    and string.find(keyLower, "model")
                    and not string.find(keyLower, "scene")
                    and not string.find(keyLower, "display")
                    and not string.find(keyLower, "icon")
                    and not string.find(keyLower, "texture") then
                    out.modelID = value
                elseif (not out.asset) and keyLower == "asset" then
                    out.asset = value
                elseif (not out.displayID)
                    and string.find(keyLower, "display")
                    and not string.find(keyLower, "icon")
                    and not string.find(keyLower, "texture") then
                    out.displayID = value
                elseif (not out.sceneID)
                    and string.find(keyLower, "scene")
                    and string.find(keyLower, "id") then
                    out.sceneID = value
                elseif (not out.texture)
                    and (string.find(keyLower, "icon") or string.find(keyLower, "texture") or string.find(keyLower, "thumbnail")) then
                    out.texture = value
                end
            elseif type(value) == "string" and value ~= "" then
                if (not out.modelPath)
                    and (string.find(keyLower, "model") or string.find(keyLower, "m2"))
                    and not string.find(keyLower, "scene")
                    and not string.find(keyLower, "texture")
                    and not string.find(keyLower, "icon") then
                    out.modelPath = value
                end
            end
        end
    end)

    return out
end

local function ResolveHousingDecorPreviewData(decorID)
    if type(decorID) ~= "number" or decorID <= 0 then
        return nil
    end
    if decorPreviewDataCache[decorID] then
        return decorPreviewDataCache[decorID]
    end

    local result = {
        decorID = decorID,
        name = GetHousingDecorName(decorID),
        displayID = nil,
        modelID = nil,
        modelPath = nil,
        sceneID = nil,
        asset = nil,
        texture = nil
    }

    local displayKeys = {
        "displayID", "modelDisplayID", "creatureDisplayID", "creatureDisplayInfoID",
        "previewDisplayID", "previewModelDisplayID",
    }
    local modelKeys = {
        "modelID", "modelFileID", "previewModelID", "previewModelFileID",
    }
    local textureKeys = {
        "icon", "iconFileID", "iconTexture", "texture", "previewTexture", "thumbnail", "thumbnailID",
    }

    local function ProcessInfoTable(info)
        if type(info) ~= "table" then
            return
        end
        result.displayID = result.displayID or ExtractNumericByKeys(info, displayKeys)
        result.modelID = result.modelID or ExtractNumericByKeys(info, modelKeys)
        result.modelPath = result.modelPath
            or ((type(info.modelPath) == "string" and info.modelPath ~= "" and info.modelPath)
            or (type(info.model) == "string" and info.model ~= "" and info.model)
            or (type(info.previewModelPath) == "string" and info.previewModelPath ~= "" and info.previewModelPath))
        result.asset = result.asset or (type(info.asset) == "number" and info.asset > 0 and info.asset) or nil
        result.sceneID = result.sceneID or (type(info.uiModelSceneID) == "number" and info.uiModelSceneID > 0 and info.uiModelSceneID) or nil
        result.texture = result.texture or ExtractTextureByKeys(info, textureKeys)
        if not result.name and type(info.name) == "string" and info.name ~= "" then
            result.name = info.name
        end

        local deep = ExtractModelCandidatesDeep(info)
        result.modelPath = result.modelPath or deep.modelPath
        result.modelID = result.modelID or deep.modelID
        result.displayID = result.displayID or deep.displayID
        result.asset = result.asset or deep.asset
        result.texture = result.texture or deep.texture
        result.sceneID = result.sceneID or deep.sceneID
    end

    if C_HousingDecor then
        for _, funcName in ipairs({ "GetDecorInfo", "GetDecorData", "GetDecorPreviewInfo", "GetDecorDisplayInfo" }) do
            local func = C_HousingDecor[funcName]
            if type(func) == "function" then
                local ok, a, b, c, d = pcall(func, decorID)
                if ok then
                    if type(a) == "table" then
                        ProcessInfoTable(a)
                    else
                        if type(a) == "number" and a > 0 then
                            result.displayID = result.displayID or a
                        end
                        if type(b) == "number" and b > 0 then
                            result.modelID = result.modelID or b
                        end
                        if type(c) == "number" and c > 0 then
                            result.texture = result.texture or c
                        elseif type(c) == "string" and c ~= "" then
                            result.modelPath = result.modelPath or c
                        end
                        if type(d) == "table" then
                            ProcessInfoTable(d)
                        end
                    end
                end
                if result.modelPath or result.modelID or result.displayID or result.texture then
                    break
                end
            end
        end
    end

    if (not result.modelPath and not result.modelID and not result.displayID and not result.texture)
        and C_HousingCatalog and type(C_HousingCatalog.GetCatalogEntryInfoByRecordID) == "function" then
        local ok, info = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, 1, decorID, true)
        if ok then
            ProcessInfoTable(info)
        end
    end

    if C_HousingCatalog and type(C_HousingCatalog.GetBasicDecorInfo) == "function" then
        local ok, info = pcall(C_HousingCatalog.GetBasicDecorInfo, 1, decorID)
        if ok then
            ProcessInfoTable(info)
        end
    end

    decorPreviewDataCache[decorID] = result
    return result
end
local function GetMountIDFromItem(itemID)
    if not C_MountJournal or type(C_MountJournal.GetMountFromItem) ~= "function" then
        return nil
    end

    local mountID = C_MountJournal.GetMountFromItem(itemID)
    if type(mountID) == "number" and mountID > 0 then
        return mountID
    end

    local spellID
    if type(GetItemSpell) == "function" then
        local _, itemSpellID = GetItemSpell(itemID)
        if type(itemSpellID) == "number" and itemSpellID > 0 then
            spellID = itemSpellID
        end
    end

    if not spellID and C_TooltipInfo and type(C_TooltipInfo.GetItemByID) == "function" then
        local info = C_TooltipInfo.GetItemByID(itemID)
        local lines = info and info.lines
        if type(lines) == "table" then
            for _, line in ipairs(lines) do
                local leftText = line and line.leftText
                local rightText = line and line.rightText
                for _, text in ipairs({ leftText, rightText }) do
                    if type(text) == "string" and text ~= "" then
                        local mountIDFromLink = text:match("|Hmount:(%d+)")
                        if mountIDFromLink then
                            return tonumber(mountIDFromLink)
                        end
                        local spellFromLink = text:match("|Hspell:(%d+)")
                        if spellFromLink then
                            spellID = tonumber(spellFromLink)
                        end
                    end
                end
                if spellID then
                    break
                end
            end
        end
    end

    if spellID and type(C_MountJournal.GetMountFromSpell) == "function" then
        local bySpellMountID = C_MountJournal.GetMountFromSpell(spellID)
        if type(bySpellMountID) == "number" and bySpellMountID > 0 then
            return bySpellMountID
        end
    end

    if spellID and type(C_MountJournal.GetMountIDs) == "function" and type(C_MountJournal.GetMountInfoExtraByID) == "function" then
        local mountIDs = C_MountJournal.GetMountIDs()
        if type(mountIDs) == "table" then
            for _, id in ipairs(mountIDs) do
                local _, _, _, _, _, _, _, _, _, candidateSpellID = C_MountJournal.GetMountInfoExtraByID(id)
                if candidateSpellID == spellID then
                    return id
                end
            end
        end
    end

    return nil
end

local function GetMountIDFromSpell(spellID)
    if type(spellID) ~= "number" or spellID <= 0 or not C_MountJournal then
        return nil
    end

    if type(C_MountJournal.GetMountFromSpell) == "function" then
        local mountID = C_MountJournal.GetMountFromSpell(spellID)
        if type(mountID) == "number" and mountID > 0 then
            return mountID
        end
    end

    if type(C_MountJournal.GetMountIDs) == "function" and type(C_MountJournal.GetMountInfoExtraByID) == "function" then
        local mountIDs = C_MountJournal.GetMountIDs()
        if type(mountIDs) == "table" then
            for _, id in ipairs(mountIDs) do
                local _, _, _, _, _, _, _, _, _, sourceSpellID = C_MountJournal.GetMountInfoExtraByID(id)
                if sourceSpellID == spellID then
                    return id
                end
            end
        end
    end

    return nil
end

local function GetSpellLinkByID(spellID)
    if type(spellID) ~= "number" or spellID <= 0 then
        return nil
    end

    if type(GetSpellLink) == "function" then
        local link = GetSpellLink(spellID)
        if type(link) == "string" and link ~= "" then
            return link
        end
    end

    if C_Spell and type(C_Spell.GetSpellLink) == "function" then
        local link = C_Spell.GetSpellLink(spellID)
        if type(link) == "string" and link ~= "" then
            return link
        end
    end

    return nil
end

local function GetPetInfoFromItem(itemID)
    local info = {
        speciesID = nil,
        creatureID = nil,
        displayID = nil,
        spellID = nil
    }

    if type(GetItemSpell) == "function" then
        local _, spellID = GetItemSpell(itemID)
        if type(spellID) == "number" and spellID > 0 then
            info.spellID = spellID
        end
    end

    if not C_PetJournal then
        return info
    end

    if type(C_PetJournal.GetPetInfoByItemID) == "function" then
        local _, _, _, creatureID, _, _, _, _, _, _, _, displayID, speciesID = C_PetJournal.GetPetInfoByItemID(itemID)
        if type(speciesID) == "number" and speciesID > 0 then
            info.speciesID = speciesID
        end
        if type(creatureID) == "number" and creatureID > 0 then
            info.creatureID = creatureID
        end
        if type(displayID) == "number" and displayID > 0 then
            info.displayID = displayID
        end
    end

    if not info.speciesID and info.spellID and type(C_PetJournal.GetPetInfoBySpellID) == "function" then
        local speciesID = C_PetJournal.GetPetInfoBySpellID(info.spellID)
        if type(speciesID) == "number" and speciesID > 0 then
            info.speciesID = speciesID
        end
    end

    if info.speciesID and (not info.creatureID) and type(C_PetJournal.GetPetInfoBySpeciesID) == "function" then
        local _, _, _, creatureID = C_PetJournal.GetPetInfoBySpeciesID(info.speciesID)
        if type(creatureID) == "number" and creatureID > 0 then
            info.creatureID = creatureID
        end
    end

    return info
end

local function HasSpellAssociation(itemID)
    if type(GetItemSpell) ~= "function" then
        return false
    end

    local spellName, spellID = GetItemSpell(itemID)
    return (type(spellID) == "number" and spellID > 0) or (type(spellName) == "string" and spellName ~= "")
end

local function HasModelAssociation(itemID)
    local itemName, itemLink, _, _, _, _, _, _, equipLoc = GetItemInfo(itemID)
    if itemName and itemLink and type(equipLoc) == "string" and equipLoc ~= "" then
        return true
    end

    if C_Item and type(C_Item.GetItemInfoInstant) == "function" then
        local _, _, _, _, _, _, _, _, equipLocInstant = C_Item.GetItemInfoInstant(itemID)
        if type(equipLocInstant) == "string" and equipLocInstant ~= "" then
            return true
        end
    end

    return false
end

local function ComputePreviewableItem(itemID)
    EnsureCollectionsLoaded()

    if GetMountIDFromItem(itemID) then
        return true
    end

    local petInfo = GetPetInfoFromItem(itemID)
    if petInfo.speciesID or petInfo.creatureID or petInfo.displayID then
        return true
    end

    if HasSpellAssociation(itemID) then
        return true
    end

    if HasModelAssociation(itemID) then
        return true
    end

    return false
end

function RewardPreview:IsPreviewableItem(itemID)
    if type(itemID) ~= "number" or itemID <= 0 then
        return false
    end

    if previewableItemCache[itemID] == true then
        return true
    end

    local previewable = ComputePreviewableItem(itemID)
    if previewable then
        previewableItemCache[itemID] = true
        return true
    end

    if Item and type(Item.CreateFromItemID) == "function" then
        local item = Item:CreateFromItemID(itemID)
        if item and type(item.IsItemDataCached) == "function" and not item:IsItemDataCached() then
            if not pendingItemLoads[itemID] then
                pendingItemLoads[itemID] = true
                item:ContinueOnItemLoad(function()
                    pendingItemLoads[itemID] = nil
                    previewableItemCache[itemID] = ComputePreviewableItem(itemID)
                    ScheduleAchievementFrameRefresh()
                end)
            end
            return false
        end
    end

    return false
end

local function NormalizeRewardEntry(rawEntry)
    if type(rawEntry) ~= "table" then
        return nil
    end

    local rewardType = rawEntry.type or rawEntry.rewardType or rawEntry[1]
    local rewardID = rawEntry.id or rawEntry.rewardID or rawEntry.itemID or rawEntry.ItemID or rawEntry[2] or rawEntry[1]

    if type(rewardType) ~= "number" and type(rawEntry.itemID or rawEntry.ItemID) == "number" then
        rewardType = REWARD_TYPE_ITEM
    end

    if type(rewardType) ~= "number" or type(rewardID) ~= "number" or rewardID <= 0 then
        return nil
    end

    local entry = {
        rewardType = rewardType,
        rewardID = rewardID,
        typeName = rawEntry.typeName,
        name = rawEntry.name or rawEntry.Name or rawEntry.label,
        rewardClass = rawEntry.class or rawEntry.rewardClass,
    }

    for _, key in ipairs({
        "itemID",
        "spellID",
        "speciesID",
        "npcID",
        "modelID",
        "displayID",
        "mvTypeID",
        "decorID",
        "titleID",
        "asset",
        "texture",
        "sceneID",
    }) do
        if rawEntry[key] ~= nil then
            entry[key] = rawEntry[key]
        end
    end

    if rewardType == REWARD_TYPE_ITEM then
        entry.itemID = entry.itemID or rewardID
    end
    if rewardType == REWARD_TYPE_NPC then
        entry.npcID = entry.npcID or rewardID
    end
    if rewardType == REWARD_TYPE_HOUSING_DECOR then
        entry.decorID = entry.decorID or rewardID
    end
    if rewardType == REWARD_TYPE_SPELL then
        entry.spellID = entry.spellID or rewardID
    end

    return entry
end

local function RewardUniqueKey(entry)
    if not entry then
        return nil
    end
    return string.format("%d:%d", entry.rewardType or -1, entry.rewardID or -1)
end

function RewardPreview:GetRewardEntriesForAchievement(achievementID)
    if type(achievementID) ~= "number" then
        return {}
    end

    local entries = {}
    local seen = {}

    local rewardDB = GetRewardDB()
    local dbRow = rewardDB and rewardDB[achievementID]
    local dbRewards = dbRow and (dbRow.rewards or dbRow.Rewards or dbRow)
    if type(dbRewards) == "table" then
        for _, raw in ipairs(dbRewards) do
            local entry = NormalizeRewardEntry(raw)
            local key = RewardUniqueKey(entry)
            if key and not seen[key] then
                seen[key] = true
                table.insert(entries, entry)
            end
        end
    end

    return entries
end

local function IsSelectableRewardEntry(reward)
    if type(reward) ~= "table" or type(reward.rewardID) ~= "number" or reward.rewardID <= 0 then
        return false
    end
    return reward.rewardType == REWARD_TYPE_NPC or reward.rewardType == REWARD_TYPE_ITEM or reward.rewardType == REWARD_TYPE_HOUSING_DECOR or reward.rewardType == REWARD_TYPE_SPELL
end

local function IsPreviewableRewardEntry(self, reward)
    if not IsSelectableRewardEntry(reward) then
        return false
    end
    if reward.rewardType == REWARD_TYPE_HOUSING_DECOR then
        local data = ResolveHousingDecorPreviewData(reward.decorID or reward.rewardID)
        return data and (data.asset or data.displayID or data.modelID or data.texture)
    end
    return BuildUnifiedModelDataFromReward(reward) ~= nil
end

function RewardPreview:GetSelectableRewardsForAchievement(achievementID)
    local selectable = {}
    local rewards = self:GetRewardEntriesForAchievement(achievementID)
    for _, reward in ipairs(rewards) do
        if IsSelectableRewardEntry(reward) then
            table.insert(selectable, reward)
        end
    end
    return selectable
end

function RewardPreview:GetPreviewableRewardsForAchievement(achievementID)
    local previewable = {}
    local rewards = self:GetRewardEntriesForAchievement(achievementID)
    for _, reward in ipairs(rewards) do
        if IsPreviewableRewardEntry(self, reward) then
            table.insert(previewable, reward)
        end
    end
    return previewable
end

function RewardPreview:GetRewardItemLink(itemID)
    if type(itemID) ~= "number" or itemID <= 0 then
        return nil
    end

    if C_Item and type(C_Item.GetItemLinkByID) == "function" then
        local itemLink = C_Item.GetItemLinkByID(itemID)
        if itemLink then
            return itemLink
        end
    end

    local _, itemLink = GetItemInfo(itemID)
    if itemLink then
        return itemLink
    end

    -- Fallback for uncollected/unseen rewards where no hyperlink is cached yet.
    return string.format("item:%d", itemID)
end

local function GetRewardTypeLabel(reward)
    if type(reward) ~= "table" then
        return L["Reward"]
    end
    if reward.rewardType == REWARD_TYPE_NPC then return L["NPC"] end
    if reward.rewardType == REWARD_TYPE_ITEM then return L["Item"] end
    if reward.rewardType == REWARD_TYPE_HOUSING_DECOR then return L["Decor"] end
    if reward.rewardType == REWARD_TYPE_TITLE then return L["Title"] end
    if reward.rewardType == REWARD_TYPE_SPELL then return L["Spell"] end
    return L["Reward"]
end

local function IsFallbackRewardLabel(reward, label)
    if type(reward) ~= "table" or type(label) ~= "string" then
        return false
    end
    local rewardID = reward.rewardID
    if type(rewardID) ~= "number" or rewardID <= 0 then
        return false
    end
    local fallback = string.format("%s %d", GetRewardTypeLabel(reward), rewardID)
    return label == fallback
end

function RewardPreview:GetRewardLabel(reward)
    if type(reward) ~= "table" then
        return L["Reward"]
    end

    if type(reward.name) == "string" and reward.name ~= "" then
        return reward.name
    end

    if reward.rewardType == REWARD_TYPE_NPC and reward.rewardID then
        return string.format("%s %d", L["NPC"], reward.rewardID)
    end

    if reward.rewardType == REWARD_TYPE_ITEM and reward.rewardID then
        if C_Item and type(C_Item.GetItemNameByID) == "function" then
            local itemName = C_Item.GetItemNameByID(reward.rewardID)
            if itemName and itemName ~= "" then
                return itemName
            end
        end

        local itemName = GetItemInfo(reward.rewardID)
        if itemName and itemName ~= "" then
            return itemName
        end

        return string.format("%s %d", L["Item"], reward.rewardID)
    end

    if reward.rewardType == REWARD_TYPE_HOUSING_DECOR and reward.rewardID then
        local decorName = GetHousingDecorName(reward.rewardID)
        if decorName and decorName ~= "" then
            return decorName
        end
        return string.format("%s %d", L["Decor"], reward.rewardID)
    end

    if reward.rewardType == REWARD_TYPE_SPELL and reward.rewardID then
        if C_Spell and type(C_Spell.GetSpellName) == "function" then
            local spellName = C_Spell.GetSpellName(reward.rewardID)
            if spellName and spellName ~= "" then
                return spellName
            end
        end
        local spellName = GetSpellInfo and GetSpellInfo(reward.rewardID) or nil
        if spellName and spellName ~= "" then
            return spellName
        end
        return string.format("%s %d", L["Spell"], reward.rewardID)
    end

    if reward.rewardID then
        return string.format("%s %d", GetRewardTypeLabel(reward), reward.rewardID)
    end

    return L["Reward"]
end

local function RefreshPreviewTitleWhenAvailable(frame, reward)
    if not frame or type(frame.Title) ~= "table" or type(frame.Title.SetText) ~= "function" then
        return
    end
    if type(reward) ~= "table" then
        return
    end

    local attempts = 0
    local maxAttempts = 10

    local function Tick()
        attempts = attempts + 1
        if not frame:IsShown() then
            return
        end

        local label = RewardPreview:GetRewardLabel(reward)
        if type(label) == "string" and label ~= "" then
            frame.Title:SetText(label)
            if not IsFallbackRewardLabel(reward, label) then
                return
            end
        end

        if attempts < maxAttempts then
            C_Timer.After(0.2, Tick)
        end
    end

    if reward.rewardType == REWARD_TYPE_ITEM then
        local itemID = reward.itemID or reward.rewardID
        if type(itemID) == "number" and itemID > 0 and Item and type(Item.CreateFromItemID) == "function" then
            local item = Item:CreateFromItemID(itemID)
            if item and type(item.IsItemDataCached) == "function" and not item:IsItemDataCached() and type(item.ContinueOnItemLoad) == "function" then
                item:ContinueOnItemLoad(function()
                    if frame:IsShown() then
                        Tick()
                    end
                end)
            end
        end
    end

    Tick()
end

BuildUnifiedModelDataFromReward = function(reward, fallbackLabel)
    if type(reward) ~= "table" then
        return nil
    end

    local data = {
        title = fallbackLabel or RewardPreview:GetRewardLabel(reward),
        name = reward.name,
        typeName = reward.typeName,
        displayID = reward.displayID,
        modelID = reward.modelID,
        npcID = reward.npcID,
        speciesID = reward.speciesID,
        spellID = reward.spellID,
        sceneID = reward.sceneID,
        texture = reward.texture,
        asset = reward.asset,
        mvTypeID = reward.mvTypeID,
        itemID = reward.itemID,
    }

    if reward.rewardType == REWARD_TYPE_NPC and (not data.npcID) then
        data.npcID = reward.rewardID
    elseif reward.rewardType == REWARD_TYPE_SPELL and (not data.spellID) then
        data.spellID = reward.rewardID
    elseif reward.rewardType == REWARD_TYPE_ITEM and (not data.itemID) then
        data.itemID = reward.rewardID
    end

    local hasVisual = (type(data.displayID) == "number" and data.displayID > 0)
        or (type(data.modelID) == "number" and data.modelID > 0)
        or (type(data.npcID) == "number" and data.npcID > 0)
        or (type(data.speciesID) == "number" and data.speciesID > 0)
        or (type(data.asset) == "number" and data.asset > 0)
        or (data.texture ~= nil)

    if hasVisual then
        return data
    end

    -- Fallback only for legacy spell rewards where DB has no display info.
    if type(data.spellID) == "number" and data.spellID > 0 and type(C_MountJournal.GetMountFromSpell) == "function" and type(C_MountJournal.GetMountInfoExtraByID) == "function" then
        local mountID = C_MountJournal.GetMountFromSpell(data.spellID)
        if type(mountID) == "number" and mountID > 0 then
            local displayID = C_MountJournal.GetMountInfoExtraByID(mountID)
            if type(displayID) == "number" and displayID > 0 then
                data.displayID = displayID
                return data
            end
        end
    end

    return nil
end

EnsureDecorPreviewFrame = function()
    if decorPreviewFrame then
        return decorPreviewFrame
    end

    local frame = CreateFrame("Frame", "KAF_KhamulDecorPreviewFrame", UIParent, "BackdropTemplate")
    frame:SetSize(360, 520)
    frame:SetFrameStrata("HIGH")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.04, 0.04, 0.05, 0.96)
    frame:SetBackdropBorderColor(0.55, 0.55, 0.55, 1)
    frame:Hide()

    frame.Title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.Title:SetPoint("TOPLEFT", 14, -12)
    frame.Title:SetPoint("TOPRIGHT", -44, -12)
    frame.Title:SetJustifyH("LEFT")
    frame.Title:SetTextColor(1, 0.82, 0)

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -2, -2)
    closeButton:SetSize(26, 26)

    local bg = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    bg:SetPoint("TOPLEFT", 4, -4)
    bg:SetPoint("BOTTOMRIGHT", -4, 4)
    bg:SetAtlas("catalog-list-preview-bg")

    EnsureHousingUiLoaded()

    local modelScene
    local modelSceneOk, createdModelScene = pcall(CreateFrame, "ModelScene", nil, frame, "PanningModelSceneMixinTemplate")
    if modelSceneOk and createdModelScene then
        modelScene = createdModelScene
    else
        modelScene = CreateFrame("ModelScene", nil, frame)
    end
    modelScene:SetPoint("TOPLEFT", 10, -42)
    modelScene:SetPoint("BOTTOMRIGHT", -10, 46)
    modelScene:Hide()
    frame.ModelScene = modelScene

    local controls
    local controlOk, controlFrame = pcall(CreateFrame, "Frame", nil, frame, "ModelSceneControlFrameTemplate")
    if controlOk and controlFrame then
        controlFrame:SetPoint("BOTTOM", frame, "BOTTOM", 0, 12)
        pcall(controlFrame.SetModelScene, controlFrame, modelScene)
        controlFrame:Hide()
        controls = controlFrame
    end
    frame.Controls = controls

    local fallbackTexture = frame:CreateTexture(nil, "ARTWORK")
    fallbackTexture:SetPoint("TOPLEFT", modelScene, "TOPLEFT", 0, 0)
    fallbackTexture:SetPoint("BOTTOMRIGHT", modelScene, "BOTTOMRIGHT", 0, 0)
    fallbackTexture:SetTexCoord(0.06, 0.94, 0.06, 0.94)
    fallbackTexture:Hide()
    frame.FallbackTexture = fallbackTexture

    frame.UnavailableText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.UnavailableText:SetPoint("CENTER")
    frame.UnavailableText:SetText(PREVIEW_MISSING_TEXT)
    frame.UnavailableText:Hide()

    local function GetDefaultSceneID()
        if Constants and Constants.HousingCatalogConsts and Constants.HousingCatalogConsts.HOUSING_CATALOG_DECOR_MODELSCENEID_DEFAULT then
            return Constants.HousingCatalogConsts.HOUSING_CATALOG_DECOR_MODELSCENEID_DEFAULT
        end
        return 859
    end

    local function TryApplyActorModel(actor, modelData)
        if not actor or type(modelData) ~= "table" then
            return false
        end

        if type(modelData.displayID) == "number" and modelData.displayID > 0 and type(actor.SetModelByCreatureDisplayID) == "function" then
            local ok = pcall(actor.SetModelByCreatureDisplayID, actor, modelData.displayID)
            if ok then
                return true
            end
        end

        if type(modelData.npcID) == "number" and modelData.npcID > 0 and type(actor.SetModelByCreatureID) == "function" then
            local ok = pcall(actor.SetModelByCreatureID, actor, modelData.npcID)
            if ok then
                return true
            end
        end

        local fileID = nil
        if type(modelData.asset) == "number" and modelData.asset > 0 then
            fileID = modelData.asset
        elseif type(modelData.modelID) == "number" and modelData.modelID > 0 then
            fileID = modelData.modelID
        end
        if fileID and type(actor.SetModelByFileID) == "function" then
            local ok = pcall(actor.SetModelByFileID, actor, fileID)
            if ok then
                return true
            end
        end

        return false
    end

    local function BuildSceneCandidates(modelData)
        local sceneIDs = {}
        local seen = {}
        local function AddScene(sceneID)
            if type(sceneID) == "number" and sceneID > 0 and not seen[sceneID] then
                seen[sceneID] = true
                table.insert(sceneIDs, sceneID)
            end
        end

        AddScene(modelData.sceneID)
        if type(modelData.speciesID) == "number" and modelData.speciesID > 0 and C_PetJournal and type(C_PetJournal.GetPetModelSceneInfoBySpeciesID) == "function" then
            local ok, petSceneID = pcall(C_PetJournal.GetPetModelSceneInfoBySpeciesID, modelData.speciesID)
            if ok then
                AddScene(petSceneID)
            end
        end
        AddScene(GetDefaultSceneID())
        AddScene(290)
        return sceneIDs
    end

    local function ResetPreviewView(camera, actor)
        if actor then
            if type(actor.SetPosition) == "function" then
                pcall(actor.SetPosition, actor, 0, 0, 0)
            end
            if type(actor.SetYaw) == "function" then
                pcall(actor.SetYaw, actor, 0)
            end
            if type(actor.SetPitch) == "function" then
                pcall(actor.SetPitch, actor, 0)
            end
            if type(actor.SetRoll) == "function" then
                pcall(actor.SetRoll, actor, 0)
            end
            if type(actor.SetScale) == "function" then
                pcall(actor.SetScale, actor, 1)
            end
        end

        if camera then
            if type(camera.SetNormalizedZoom) == "function" then
                pcall(camera.SetNormalizedZoom, camera, 0)
            elseif type(camera.SetZoom) == "function" then
                pcall(camera.SetZoom, camera, 0)
            elseif type(camera.SetTargetZoom) == "function" then
                pcall(camera.SetTargetZoom, camera, 0)
            end

            if type(camera.SetTargetOffsets) == "function" then
                pcall(camera.SetTargetOffsets, camera, 0, 0, 0)
            end
        end
    end

    local function ApplyInitialUnifiedView(camera, actor, modelData)
        ResetPreviewView(camera, actor)
    end

    frame.ShowDecor = function(self, decorData)
        if type(decorData) ~= "table" then
            return false
        end

        self.Title:SetText(decorData.name or string.format("%s %d", L["Decor"], decorData.decorID or 0))
        self.ModelScene:Hide()
        self.FallbackTexture:Hide()
        self.UnavailableText:Hide()
        if self.Controls then
            self.Controls:Hide()
        end

        local shown = false
        if decorData.asset and self.ModelScene and self.ModelScene.TransitionToModelSceneID then
            local sceneID = decorData.sceneID or GetDefaultSceneID()
            local sceneOK = pcall(function()
                self.ModelScene:TransitionToModelSceneID(sceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, true)
            end)
            if sceneOK then
                local camera = self.ModelScene.GetActiveCamera and self.ModelScene:GetActiveCamera() or nil
                if camera and camera.SetLeftMouseButtonYMode then
                    camera:SetLeftMouseButtonYMode(ORBIT_CAMERA_MOUSE_MODE_PITCH_ROTATION, true)
                end
                local actor = self.ModelScene.GetActorByTag and self.ModelScene:GetActorByTag("decor") or nil
                if actor and actor.SetModelByFileID then
                    ResetPreviewView(camera, actor)
                    actor:SetPreferModelCollisionBounds(true)
                    actor:SetModelByFileID(decorData.asset)
                    self.ModelScene:Show()
                    if self.Controls then
                        self.Controls:Show()
                    end
                    shown = true
                end
            end
        end

        if not shown and decorData.texture then
            self.FallbackTexture:SetTexture(decorData.texture)
            self.FallbackTexture:Show()
            shown = true
        end

        if not shown then
            self.UnavailableText:Show()
        end

        return shown
    end

    frame.ShowUnifiedModel = function(self, modelData)
        if type(modelData) ~= "table" then
            return false
        end

        self.Title:SetText(modelData.name or modelData.title or L["Preview Reward"])
        self.ModelScene:Hide()
        self.FallbackTexture:Hide()
        self.UnavailableText:Hide()
        if self.Controls then
            self.Controls:Hide()
        end

        local shown = false
        local sceneIDs = BuildSceneCandidates(modelData)
        for _, sceneID in ipairs(sceneIDs) do
            local sceneOK = false
            if self.ModelScene and self.ModelScene.TransitionToModelSceneID then
                sceneOK = pcall(function()
                    self.ModelScene:TransitionToModelSceneID(sceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, true)
                end)
            end
            if sceneOK then
                local camera = self.ModelScene.GetActiveCamera and self.ModelScene:GetActiveCamera() or nil
                if camera and camera.SetLeftMouseButtonYMode then
                    camera:SetLeftMouseButtonYMode(ORBIT_CAMERA_MOUSE_MODE_PITCH_ROTATION, true)
                end

                local actor = nil
                if self.ModelScene.GetActorByTag then
                    actor = self.ModelScene:GetActorByTag("unwrapped")
                        or self.ModelScene:GetActorByTag("mount")
                        or self.ModelScene:GetActorByTag("pet")
                        or self.ModelScene:GetActorByTag("npc")
                        or self.ModelScene:GetActorByTag("decor")
                        or self.ModelScene:GetActorByTag("player")
                end
                if (not actor) and self.ModelScene.GetPlayerActor then
                    actor = self.ModelScene:GetPlayerActor()
                end

                if actor and TryApplyActorModel(actor, modelData) then
                    ResetPreviewView(camera, actor)
                    if type(actor.SetAnimation) == "function" then
                        pcall(actor.SetAnimation, actor, 0, -1)
                    end
                    ApplyInitialUnifiedView(camera, actor, modelData)
                    self.ModelScene:Show()
                    if self.Controls then
                        self.Controls:Show()
                    end
                    shown = true
                    break
                end
            end
        end

        if not shown and modelData.texture then
            self.FallbackTexture:SetTexture(modelData.texture)
            self.FallbackTexture:Show()
            shown = true
        end

        if not shown then
            self.UnavailableText:Show()
        end

        return shown
    end

    decorPreviewFrame = frame
    return frame
end

local function HidePreviewFrame()
    if decorPreviewFrame and decorPreviewFrame.Hide then
        decorPreviewFrame:Hide()
    end
end

local function TryHookAchievementFrameClose()
    local frames = {}
    local function AddFrame(frame)
        if not frame then
            return
        end
        table.insert(frames, frame)
        local parent = frame.GetParent and frame:GetParent() or nil
        if parent then
            table.insert(frames, parent)
            local grandParent = parent.GetParent and parent:GetParent() or nil
            if grandParent then
                table.insert(frames, grandParent)
            end
        end
    end

    AddFrame(_G.KrowiAF_AchievementsFrame)
    AddFrame(_G.AchievementFrame)
    local hookedAny = false

    for _, frame in ipairs(frames) do
        if frame and frame.GetName and frame.HookScript then
            local frameName = frame:GetName() or tostring(frame)
            if not closeHookedFrames[frameName] then
                frame:HookScript("OnHide", HidePreviewFrame)
                closeHookedFrames[frameName] = true
                hookedAny = true
            end
        end
    end

    return hookedAny
end

PositionDecorPreviewWindow = function(frame)
    if not frame or not frame.ClearAllPoints then
        return
    end
    local achievementsFrame = _G.KrowiAF_AchievementsFrame or _G.AchievementFrame
    if not achievementsFrame then
        return
    end

    -- Parent to the achievements frame so closing/hiding achievements reliably hides preview too.
    if frame.GetParent and frame.SetParent and frame:GetParent() ~= achievementsFrame then
        frame:SetParent(achievementsFrame)
    end

    frame:ClearAllPoints()
    frame:SetPoint("TOPLEFT", achievementsFrame, "TOPRIGHT", 12, 0)
end

local function OpenHousingDecorPreview(decorID, reward)
    EnsureHousingUiLoaded()

    local decorData = ResolveHousingDecorPreviewData(decorID)
    if not decorData then
        return false
    end

    DebugPrint(string.format("[DecorPreview] decorID=%d name=%s asset=%s modelPath=%s modelID=%s displayID=%s sceneID=%s texture=%s",
        decorID,
        tostring(decorData.name),
        tostring(decorData.asset),
        tostring(decorData.modelPath),
        tostring(decorData.modelID),
        tostring(decorData.displayID),
        tostring(decorData.sceneID),
        tostring(decorData.texture)))

    local frame = EnsureDecorPreviewFrame()
    local shown = frame:ShowDecor(decorData)
    if shown then
        PositionDecorPreviewWindow(frame)
        frame:Show()
        local rewardForTitle = reward or {
            rewardType = REWARD_TYPE_HOUSING_DECOR,
            rewardID = decorID,
            decorID = decorID,
        }
        RefreshPreviewTitleWhenAvailable(frame, rewardForTitle)
        return true
    end

    return false
end
function RewardPreview:OpenPreviewForReward(reward)
    if type(reward) ~= "table" or type(reward.rewardType) ~= "number" or type(reward.rewardID) ~= "number" then
        return
    end
    DebugPrint(string.format("[DecorPreview] OpenPreviewForReward type=%s id=%s build=%s", tostring(reward.rewardType), tostring(reward.rewardID), DECOR_PREVIEW_BUILD))

    if reward.rewardType == REWARD_TYPE_HOUSING_DECOR then
        local decorID = reward.decorID or reward.rewardID
        if not OpenHousingDecorPreview(decorID, reward) then
            KhamulsAchievementFilter:Print(string.format("%s (%s %d)", PREVIEW_MISSING_TEXT, GetRewardTypeLabel(reward), reward.rewardID))
        end
        return
    end

    local modelData = BuildUnifiedModelDataFromReward(reward, self:GetRewardLabel(reward))
    if not modelData then
        KhamulsAchievementFilter:Print(string.format("%s (%s %d)", PREVIEW_MISSING_TEXT, GetRewardTypeLabel(reward), reward.rewardID))
        return
    end

    local frame = EnsureDecorPreviewFrame()
    local shown = frame:ShowUnifiedModel(modelData)
    if shown then
        PositionDecorPreviewWindow(frame)
        frame:Show()
        RefreshPreviewTitleWhenAvailable(frame, reward)
        return
    end

    KhamulsAchievementFilter:Print(string.format("%s (%s %d)", PREVIEW_MISSING_TEXT, GetRewardTypeLabel(reward), reward.rewardID))
end
function RewardPreview:OpenPreviewForAchievement(achievementID)
    if type(achievementID) ~= "number" then
        return
    end
    DebugPrint(string.format("[DecorPreview] OpenPreviewForAchievement id=%d build=%s", achievementID, DECOR_PREVIEW_BUILD))

    local rewards = self:GetSelectableRewardsForAchievement(achievementID)
    if #rewards == 0 then
        KhamulsAchievementFilter:Print(string.format("%s (ID: %d)", PREVIEW_MISSING_TEXT, achievementID))
        return
    end

    local previewable = self:GetPreviewableRewardsForAchievement(achievementID)
    self:OpenPreviewForReward(previewable[1] or rewards[1])
end

local function EnsureMenuBuilder()
    if menuBuilder then
        return menuBuilder
    end

    local menuLib = _G.KROWI_LIBMAN and _G.KROWI_LIBMAN:GetLibrary("Krowi_Menu_2")
    local menuBuilderClass = menuLib and menuLib.MenuBuilder
    if not menuBuilderClass then
        return nil
    end

    menuBuilder = menuBuilderClass:New({})
    return menuBuilder
end

local function AddRightClickMenuForRewards(menu, rewards)
    local builder = EnsureMenuBuilder()
    if not builder or #rewards == 0 then
        return
    end

    if #rewards == 1 then
        local reward = rewards[1]
        builder:CreateButtonAndAdd(menu, PREVIEW_MENU_TEXT, function()
            RewardPreview:OpenPreviewForReward(reward)
        end, true)
        return
    end

    if type(builder.CreateSubmenuButton) == "function" then
        local submenu = builder:CreateSubmenuButton(menu, PREVIEW_MENU_TEXT)
        if submenu then
            for _, reward in ipairs(rewards) do
                local label = RewardPreview:GetRewardLabel(reward)
                builder:CreateButtonAndAdd(submenu, label, function()
                    RewardPreview:OpenPreviewForReward(reward)
                end, true)
            end
            if type(builder.AddChildMenu) == "function" then
                builder:AddChildMenu(menu, submenu)
            end
            return
        end
    end

    for index, reward in ipairs(rewards) do
        local label = string.format("%s %d: %s", PREVIEW_MENU_TEXT, index, RewardPreview:GetRewardLabel(reward))
        builder:CreateButtonAndAdd(menu, label, function()
            RewardPreview:OpenPreviewForReward(reward)
        end, true)
    end
end

local plugin = {}
function plugin:AddAchievementRightClickMenuItems(menu, achievement)
    local achievementID = achievement and achievement.Id
    if type(achievementID) ~= "number" then
        return
    end

    local rewards = RewardPreview:GetSelectableRewardsForAchievement(achievementID)
    AddRightClickMenuForRewards(menu, rewards)
end

local function PositionPreviewButton(button)
    if not button or not button.RewardPreviewButton then
        return
    end

    local previewButton = button.RewardPreviewButton
    previewButton:ClearAllPoints()

    if button.Reward and button.Reward:IsShown() then
        previewButton:SetPoint("LEFT", button.Reward, "RIGHT", -15, 0)
        return
    end

    if button.RewardBackground and button.RewardBackground:IsShown() then
        previewButton:SetPoint("LEFT", button.RewardBackground, "RIGHT", -15, 0)
        return
    end

    previewButton:SetPoint("RIGHT", button, "RIGHT", -10, 0)
end

local function ShowPreviewDropDown(previewButton, rewards)
    if not previewButton or #rewards <= 1 then
        return
    end

    local menuLib = _G.KROWI_LIBMAN and _G.KROWI_LIBMAN:GetLibrary("Krowi_Menu_2")
    if not menuLib then
        return
    end

    menuLib:Clear()
    for _, reward in ipairs(rewards) do
        local label = RewardPreview:GetRewardLabel(reward)
        menuLib:AddFull({
            Text = label,
            Func = function()
                RewardPreview:OpenPreviewForReward(reward)
            end,
            NotCheckable = true
        })
    end

    menuLib:Open(previewButton, 0, 0, "TOPLEFT", "BOTTOMLEFT", previewButton:GetFrameStrata(), previewButton:GetFrameLevel() + 30)
end

local function EnsurePreviewButton(button)
    if button.RewardPreviewButton then
        PositionPreviewButton(button)
        return button.RewardPreviewButton
    end

    local previewButton = CreateFrame("Button", nil, button)
    previewButton:SetSize(24, 24)
    previewButton:SetFrameStrata(button:GetFrameStrata())
    previewButton:SetFrameLevel(button:GetFrameLevel() + 7)

    previewButton.Icon = previewButton:CreateTexture(nil, "ARTWORK")
    previewButton.Icon:SetPoint("TOPLEFT", 2, -2)
    previewButton.Icon:SetPoint("BOTTOMRIGHT", -2, 2)
    previewButton.Icon:SetTexture(PREVIEW_ICON_TEXTURE)
    previewButton.Icon:SetTexCoord(0, 1, 0, 1)

    previewButton:SetScript("OnEnter", function(self)
        if GameTooltip then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(PREVIEW_MENU_TEXT)
            GameTooltip:Show()
        end
    end)

    previewButton:SetScript("OnLeave", function()
        if GameTooltip then
            GameTooltip:Hide()
        end
    end)

    previewButton:SetScript("OnClick", function(self)
        if type(self.AchievementID) ~= "number" then
            return
        end
        DebugPrint(string.format("[DecorPreview] PreviewButtonClick achievementID=%d build=%s", self.AchievementID, DECOR_PREVIEW_BUILD))

        local rewards = RewardPreview:GetSelectableRewardsForAchievement(self.AchievementID)
        if #rewards == 0 then
            KhamulsAchievementFilter:Print(string.format("%s (ID: %d)", PREVIEW_MISSING_TEXT, self.AchievementID))
            return
        end

        if #rewards == 1 then
            local previewable = RewardPreview:GetPreviewableRewardsForAchievement(self.AchievementID)
            RewardPreview:OpenPreviewForReward(previewable[1] or rewards[1])
            return
        end

        ShowPreviewDropDown(self, rewards)
    end)

    button.RewardPreviewButton = previewButton
    PositionPreviewButton(button)
    return previewButton
end

local function UpdatePreviewButton(button, achievement)
    if not button then
        return
    end

    local previewButton = EnsurePreviewButton(button)

    local achievementID = achievement and achievement.Id
    if type(achievementID) ~= "number" then
        previewButton.AchievementID = nil
        previewButton:Hide()
        return
    end

    local rewards = RewardPreview:GetSelectableRewardsForAchievement(achievementID)
    if #rewards == 0 then
        previewButton.AchievementID = nil
        previewButton:Hide()
        return
    end

    previewButton.AchievementID = achievementID
    previewButton:SetEnabled(true)
    previewButton:Show()
end

function RewardPreview:RegisterPlugin()
    if pluginRegistered then
        return
    end

    if not _G.KrowiAF or not _G.KrowiAF.PluginsApi then
        return
    end

    _G.KrowiAF.PluginsApi:RegisterPlugin("Khamuls_RewardPreview", plugin)
    pluginRegistered = true
end

function RewardPreview:RegisterHooks()
    if hooksRegistered then
        return
    end

    if not _G.KrowiAF_AchievementButtonMixin or type(_G.KrowiAF_AchievementButtonMixin.SetAchievementData) ~= "function" then
        return
    end

    hooksecurefunc(_G.KrowiAF_AchievementButtonMixin, "SetAchievementData", function(button, achievement)
        UpdatePreviewButton(button, achievement)
    end)

    hooksRegistered = true
end

function RewardPreview:Initialize()
    self:RegisterPlugin()
    self:RegisterHooks()
    DebugPrint(string.format("[DecorPreview] loaded build=%s", DECOR_PREVIEW_BUILD))

    if not TryHookAchievementFrameClose() then
        C_Timer.After(0.5, TryHookAchievementFrameClose)
        C_Timer.After(2.0, TryHookAchievementFrameClose)
    end

    ScheduleAchievementFrameRefresh()
end
