-- Config.lua
-- Handles saved variables (window position, minimap icon settings, per-character profiles).
-- PorterDB is declared as a SavedVariable in the TOC, so WoW persists it
-- across sessions automatically. We provide defaults and profile management here.

local _, Porter = ...

-- Global defaults (shared across all characters)
-- Note: lastSeenVersion is stored at PorterDB.lastSeenVersion (global, not per-character)
Porter.defaults = {
    minimap = {
        hide = false,  -- whether the minimap icon is hidden
    },
    position = {
        point = "CENTER",  -- anchor point on the screen
        x = 0,             -- x offset from anchor
        y = 0,             -- y offset from anchor
    },
}

-- Per-character profile defaults
Porter.profileDefaults = {
    hideAfterPort = true,
    hideBankItems = false,
    showCosmeticHearthstones = false,
    hearthstoneMode = "Random",     -- "Normal", "Random", or "Specific"
    hearthstoneChoice = nil,        -- toy ID for Specific mode
    defaultView = "category",       -- "category" or "zone" — startup view & tab order
    viewMode = "category",          -- "category" or "zone"
    zoneOrder = "recent",           -- "recent" (most recent first) or "alpha" (alphabetical)
    currentSeason = "midnight",     -- "tww" or "midnight" — which season's dungeons/raids show as Current
    categoryVisibility = {
        ["Hearthstones"] = true,
        ["Class & Racial"] = true,
        ["Items"] = true,
        ["Toys"] = true,
        ["Dungeons"] = true,
        ["Raids"] = true,
        ["Delves"] = true,
        ["House"] = true,
    },
}

-- Deep copy a table (used for profile copying and default merging)
local function DeepCopy(src)
    if type(src) ~= "table" then return src end
    local copy = {}
    for k, v in pairs(src) do
        copy[k] = DeepCopy(v)
    end
    return copy
end

-- Merge defaults into a target table without overwriting existing values
local function MergeDefaults(target, defaults)
    for k, v in pairs(defaults) do
        if target[k] == nil then
            target[k] = DeepCopy(v)
        elseif type(v) == "table" and type(target[k]) == "table" then
            MergeDefaults(target[k], v)
        end
    end
end

-- Get the profile key for the current character ("Name-Realm")
function Porter:GetProfileKey()
    local name = UnitName("player")
    local realm = GetRealmName()
    return name .. "-" .. realm
end

-- Get a sorted list of all profile keys
function Porter:GetProfileList()
    local profiles = {}
    if PorterDB and PorterDB.profiles then
        for key in pairs(PorterDB.profiles) do
            tinsert(profiles, key)
        end
    end
    table.sort(profiles)
    return profiles
end

-- Copy settings from another character's profile into the current profile
function Porter:CopyProfileFrom(sourceKey)
    if not PorterDB.profiles[sourceKey] then return end
    local copy = DeepCopy(PorterDB.profiles[sourceKey])
    local myKey = self:GetProfileKey()
    PorterDB.profiles[myKey] = copy
    -- Re-alias self.db.settings to the new profile table
    self.db.settings = PorterDB.profiles[myKey]
end

-- Check if the current character is using the global profile
function Porter:IsUsingGlobalProfile()
    return PorterDB.useGlobalProfile[self:GetProfileKey()] == true
end

-- Toggle between global and per-character profile
function Porter:SetUseGlobalProfile(enabled)
    local key = self:GetProfileKey()
    if enabled then
        PorterDB.useGlobalProfile[key] = true
        self.db.settings = PorterDB.globalProfile
    else
        -- Copy global settings into per-character profile so nothing is lost
        PorterDB.profiles[key] = DeepCopy(PorterDB.globalProfile)
        PorterDB.useGlobalProfile[key] = false
        self.db.settings = PorterDB.profiles[key]
    end
end

-- Called once during ADDON_LOADED to set up saved data and profiles
function Porter:InitDB()
    -- Detect brand new install before we create anything
    local isNewInstall = (PorterDB == nil)

    -- PorterDB is the global SavedVariable table loaded from disk by WoW.
    -- If the player has never used the addon before, it will be nil.
    if not PorterDB then
        PorterDB = {}
    end

    -- Migrate from old format (pre-profiles): PorterDB.settings → first profile
    if PorterDB.settings and not PorterDB.profiles then
        local oldSettings = PorterDB.settings
        PorterDB.profiles = {}
        local key = self:GetProfileKey()
        PorterDB.profiles[key] = oldSettings
        -- Move lastSeenVersion to global if it was in the old settings
        if oldSettings.lastSeenVersion then
            PorterDB.lastSeenVersion = oldSettings.lastSeenVersion
            oldSettings.lastSeenVersion = nil
        end
        PorterDB.settings = nil
    end

    -- Ensure profiles table exists
    if not PorterDB.profiles then
        PorterDB.profiles = {}
    end

    -- Ensure global profile exists (seeded from defaults)
    if not PorterDB.globalProfile then
        PorterDB.globalProfile = DeepCopy(self.profileDefaults)
    end
    MergeDefaults(PorterDB.globalProfile, self.profileDefaults)

    -- Ensure useGlobalProfile table exists
    if not PorterDB.useGlobalProfile then
        PorterDB.useGlobalProfile = {}
    end

    -- Determine global profile usage for this character
    local key = self:GetProfileKey()
    if PorterDB.useGlobalProfile[key] == nil then
        -- New character: use global if this is a fresh install, per-character if existing
        PorterDB.useGlobalProfile[key] = isNewInstall
    end

    -- Ensure current character has a per-character profile (needed if they toggle off global)
    if not PorterDB.profiles[key] then
        PorterDB.profiles[key] = DeepCopy(self.profileDefaults)
    end

    -- Merge profile defaults into the per-character profile (adds new settings from updates)
    MergeDefaults(PorterDB.profiles[key], self.profileDefaults)

    -- Merge global defaults into PorterDB
    for section, sectionDefaults in pairs(self.defaults) do
        if type(sectionDefaults) ~= "table" then
            if PorterDB[section] == nil then
                PorterDB[section] = sectionDefaults
            end
        else
            if not PorterDB[section] then
                PorterDB[section] = {}
            end
            MergeDefaults(PorterDB[section], sectionDefaults)
        end
    end

    -- Legacy migration: lastSeenVersion was moved from settings to global in v1.0.7,
    -- then from global non-table cleanup. Handle any leftover states.
    if PorterDB.lastSeenVersion and type(PorterDB.lastSeenVersion) == "table" then
        PorterDB.lastSeenVersion = nil
    end

    -- Migrate currentSeason from "tww" to "midnight" (v1.1.1)
    if PorterDB.globalProfile and PorterDB.globalProfile.currentSeason == "tww" then
        PorterDB.globalProfile.currentSeason = "midnight"
    end
    for _, profile in pairs(PorterDB.profiles) do
        if profile.currentSeason == "tww" then
            profile.currentSeason = "midnight"
        end
    end

    -- Point self.db.settings at global or per-character profile based on the flag
    local activeProfile
    if PorterDB.useGlobalProfile[key] then
        activeProfile = PorterDB.globalProfile
    else
        activeProfile = PorterDB.profiles[key]
    end

    -- Build self.db as a wrapper so all existing self.db.settings.* references keep working
    -- Note: lastSeenVersion is accessed via PorterDB.lastSeenVersion directly (global, not per-profile)
    self.db = {
        minimap = PorterDB.minimap,
        position = PorterDB.position,
        settings = activeProfile,
    }
end

-- Save the current window position so it restores on next login
function Porter:SavePosition(frame)
    local point, _, _, x, y = frame:GetPoint()
    self.db.position.point = point
    self.db.position.x = x
    self.db.position.y = y
end
