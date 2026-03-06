MythicPlusUtility = LibStub("AceAddon-3.0"):NewAddon("MythicPlusUtility", "AceEvent-3.0", "AceConsole-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

function MythicPlusUtility:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("MythicPlusUtilityDB", self.defaults, true)

    AC:RegisterOptionsTable("MythicPlusUtility_Options", self.options)

    self.optionsFrame = ACD:AddToBlizOptions("MythicPlusUtility_Options", "Mythic Plus Utility")
    ACD:SetDefaultSize("MythicPlusUtility_Options", 650, 540)

    -- adds a child options table, in this case our profiles panel
    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    AC:RegisterOptionsTable("MythicPlusUtility_Profiles", profiles)
    -- To add profiles later
    -- ACD:AddToBlizOptions("MythicPlusUtility_Profiles", "Profiles", "Mythic Plus Utility")

    self:RegisterChatCommand("mpu", "SlashCommand")

    self:InitializeMinimapIcon()

    self:GetCharacterInfo()

    self:ExtractSpellsFromDB()

    self:CheckLocalisation()

    self:FormatInstanceData()

    self:FormatSpellsData()

    C_Timer.NewTimer(1, function()
        if MythicPlusUtility.db.char.class == "HUNTER" or MythicPlusUtility.db.char.class == "WARLOCK" then
            MythicPlusUtility:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
        end
        MythicPlusUtility:CreateCurrentAbilitiesList()
    end)

end

function MythicPlusUtility:OnEnable()
    self.db.profile.font = GetLocale() == "ruRU" and "Fonts\\FRIZQT___CYR.TTf" or "Fonts\\FRIZQT__.TTf" -- temporary hotfix
    self:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")
    self:RegisterEvent("TRAIT_CONFIG_UPDATED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("CHALLENGE_MODE_START")
end

function MythicPlusUtility:ACTIVE_PLAYER_SPECIALIZATION_CHANGED(event)
    self.db.char.currentSpec = C_SpecializationInfo.GetSpecializationInfo(C_SpecializationInfo.GetSpecialization())
    if self.Frame and self.Frame:IsVisible() then
        self:CreateCurrentAbilitiesList()
        self.Frame:ChangeInstance()
    else
        self.db.char.changedSpec = true
    end

end

function MythicPlusUtility:TRAIT_CONFIG_UPDATED(event)
    if self.Frame and self.Frame:IsVisible() then
        self:UpdateCurrentAbilitiesList()
        self.Frame:ChangeInstance()
    else
        self.db.char.changedTalents = true
    end
end

function MythicPlusUtility:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
    C_Timer.NewTimer(0.5, function()
        if not (isInitialLogin or isReloadingUi) then
            local _, _, difficultyID, _, _, _, _, instanceID = GetInstanceInfo()
            if MythicPlusUtility.db.profile.difficultyID[difficultyID] and MythicPlusUtility.instancesData[instanceID] then
                MythicPlusUtility.db.profile.instanceID = instanceID
                if not MythicPlusUtility.MythicPlusUtility then
                    MythicPlusUtility.Frame = MythicPlusUtility:UtilityAbilitiesFrame()
                end
                MythicPlusUtility.Frame:SetShownHandler(true)
                MythicPlusUtility.Frame:ChangeInstance()
            else
                if MythicPlusUtility.Frame and MythicPlusUtility.Frame:IsVisible() then
                    MythicPlusUtility.Frame:SetShownHandler(false)
                end
            end
        end
    end)
end

function MythicPlusUtility:CHALLENGE_MODE_START(event)
    if self.Frame and self.db.profile.hideOnStart and self.Frame:IsVisible() then self.Frame:SetShownHandler(false) end
end

function MythicPlusUtility:UPDATE_VEHICLE_ACTIONBAR(event)
    if self.Frame and self.Frame:IsVisible() then
        self:UpdateCurrentAbilitiesList(true)
        self.Frame:ChangeInstance()
    else
        self.db.char.changedTalents = true
    end
end

function MythicPlusUtility:CheckLocalisation()
    self.db.global.buildNumber = (select(2, GetBuildInfo()))
    if (not self.db.locale.buildNumber) or (self.db.locale.buildNumber ~= self.db.global.buildNumber) then
        self.db.locale.buildNumber = self.db.global.buildNumber
        self.db.locale.spellIdToName = {}
        self.db.locale.spellIdToHyperlink = {}
        self.db.locale.spellIdToIconId = {}
        self.db.locale.npcIdToName = {}
        self.db.locale.npcIdToHyperlink = {}
    end
    self:PopulateLocalisation()
    C_Timer.NewTimer(0.5, function() MythicPlusUtility:PopulateLocalisation() end)
end

function MythicPlusUtility:ExtractSpellsFromDB()

    local function extract(spellId, entry)
        self.db.char.availableSpells[spellId] = true
        if entry.alternatives and #entry.alternatives > 0 then
            for _, subSpellId in pairs(entry.alternatives) do self.db.char.availableSpells[subSpellId] = true end
        end
    end

    self.db.char.availableSpells = {}

    for spellId, entry in pairs(self.utilityAbilities[self.db.char.class]) do extract(spellId, entry) end
    for specId, _ in pairs(self.classSpecialisations[self.db.char.class]) do
        for spellId, entry in pairs(self.utilityAbilities[specId]) do extract(spellId, entry) end
    end
end

function MythicPlusUtility:PopulateLocalisation()
    for spellId, _ in pairs(self.db.char.availableSpells) do
        self:GetSpellNameById(spellId)
        self:GetSpellIconById(spellId)
        self:GetSpellHyperlinkById(spellId)
    end
end

function MythicPlusUtility:GetCharacterInfo()
    self.db.char.class = UnitClassBase("player")
    C_Timer.NewTimer(0.5, function()
        MythicPlusUtility.db.char.currentSpec = C_SpecializationInfo.GetSpecializationInfo(
                                                  C_SpecializationInfo.GetSpecialization())
        MythicPlusUtility:ExtractSpellsFromDB()
    end)

end

function MythicPlusUtility:ToggleAbilitiesFrame()
    if not self.Frame then
        self.Frame = self:UtilityAbilitiesFrame()
        self.Frame:SetShownHandler(true)

        return
    end
    self.Frame:SetShownHandler(not self.Frame:IsVisible())
end

function MythicPlusUtility:OpenSettings(inCombat)
    if not inCombat then
        if ACD.OpenFrames["MythicPlusUtility_Options"] then
            ACD:Close("MythicPlusUtility_Options")
        else
            ACD:Open("MythicPlusUtility_Options")
        end
    end
end

function MythicPlusUtility:SlashCommand(input, editbox)
    if input == "show" then
        self:ToggleAbilitiesFrame()
    elseif input == "minimap" then
        self:ToggleMinimapIcon()
    else
        self:OpenSettings(UnitAffectingCombat("player"))
    end
end
