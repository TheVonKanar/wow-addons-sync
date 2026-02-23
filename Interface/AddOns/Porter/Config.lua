-- Config.lua
-- Handles saved variables (window position, minimap icon settings).
-- PorterDB is declared as a SavedVariable in the TOC, so WoW persists it
-- across sessions automatically. We just provide defaults here.

local _, Porter = ...

-- Default settings applied on first load or if a key is missing
Porter.defaults = {
    minimap = {
        hide = false,  -- whether the minimap icon is hidden
    },
    position = {
        point = "CENTER",  -- anchor point on the screen
        x = 0,             -- x offset from anchor
        y = 0,             -- y offset from anchor
    },
    settings = {
        showCosmeticHearthstones = true,
        hearthstoneMode = "Random",     -- "Normal", "Random", or "Specific"
        hearthstoneChoice = nil,        -- toy ID for Specific mode
        lastSeenVersion = nil,          -- tracks which version's changelog was shown
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
    },
}

-- Called once during ADDON_LOADED to merge defaults into saved data
function Porter:InitDB()
    -- PorterDB is the global SavedVariable table loaded from disk by WoW.
    -- If the player has never used the addon before, it will be nil.
    if not PorterDB then
        PorterDB = {}
    end

    -- Fill in any missing keys from defaults (preserves existing user values)
    for section, sectionDefaults in pairs(self.defaults) do
        if type(sectionDefaults) ~= "table" then
            -- Top-level non-table defaults (shouldn't exist, but guard against it)
            if PorterDB[section] == nil then
                PorterDB[section] = sectionDefaults
            end
        else
        if not PorterDB[section] then
            PorterDB[section] = {}
        end
        for key, value in pairs(sectionDefaults) do
            if PorterDB[section][key] == nil then
                PorterDB[section][key] = value
            elseif type(value) == "table" and type(PorterDB[section][key]) == "table" then
                -- Deep merge for nested tables (e.g. categoryVisibility)
                for k, v in pairs(value) do
                    if PorterDB[section][key][k] == nil then
                        PorterDB[section][key][k] = v
                    end
                end
            end
        end
        end -- else (table section)
    end

    -- Migrate lastSeenVersion from top-level to settings (v1.0.7 fix)
    if PorterDB.lastSeenVersion and type(PorterDB.lastSeenVersion) ~= "table" then
        PorterDB.settings.lastSeenVersion = PorterDB.lastSeenVersion
        PorterDB.lastSeenVersion = nil
    elseif PorterDB.lastSeenVersion then
        -- Clean up the empty table left by the old broken InitDB
        PorterDB.lastSeenVersion = nil
    end

    self.db = PorterDB
end

-- Save the current window position so it restores on next login
function Porter:SavePosition(frame)
    local point, _, _, x, y = frame:GetPoint()
    self.db.position.point = point
    self.db.position.x = x
    self.db.position.y = y
end
