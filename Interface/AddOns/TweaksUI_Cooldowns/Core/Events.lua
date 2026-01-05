-- ============================================================================
-- TweaksUI: Cooldowns - Event System
-- Simple callback-based event system
-- ============================================================================

local ADDON_NAME, TUICD = ...

TUICD.Events = {}
local Events = TUICD.Events

-- Event definitions
TUICD.EVENTS = {
    ADDON_LOADED = "ADDON_LOADED",
    SETTINGS_CHANGED = "SETTINGS_CHANGED",
    TRACKER_SETTINGS_CHANGED = "TRACKER_SETTINGS_CHANGED",
    LAYOUT_UPDATE_NEEDED = "LAYOUT_UPDATE_NEEDED",
    CUSTOM_ENTRIES_CHANGED = "CUSTOM_ENTRIES_CHANGED",
    MIGRATION_COMPLETE = "MIGRATION_COMPLETE",
}

-- Internal storage
local callbacks = {}

-- Register a callback for an event
function Events:Register(event, callback, owner)
    if not callbacks[event] then
        callbacks[event] = {}
    end
    
    table.insert(callbacks[event], {
        callback = callback,
        owner = owner,
    })
end

-- Unregister callbacks for an owner
function Events:Unregister(event, owner)
    if not callbacks[event] then return end
    
    for i = #callbacks[event], 1, -1 do
        if callbacks[event][i].owner == owner then
            table.remove(callbacks[event], i)
        end
    end
end

-- Unregister all callbacks for an owner (all events)
function Events:UnregisterAll(owner)
    for event, eventCallbacks in pairs(callbacks) do
        for i = #eventCallbacks, 1, -1 do
            if eventCallbacks[i].owner == owner then
                table.remove(eventCallbacks, i)
            end
        end
    end
end

-- Fire an event
function Events:Fire(event, ...)
    if not callbacks[event] then return end
    
    for _, entry in ipairs(callbacks[event]) do
        local success, err = pcall(entry.callback, ...)
        if not success then
            TUICD:PrintError("Event callback error (" .. event .. "): " .. tostring(err))
        end
    end
end
