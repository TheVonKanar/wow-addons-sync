-- Copyright (c) 2026 BliZzi1337. All rights reserved.
-- Unauthorized copying, modification, distribution or use of this
-- software, in whole or in part, without prior written permission
-- from the copyright holder is strictly prohibited.
--[[
    Core.lua - BliZzi Interrupts
    -----------------------------------------------------------------------
    Module-based architecture:
      BIT.Taint    — tainted spell-ID resolution
      BIT.Net      — addon message communication
      BIT.Self     — own player state
      BIT.Registry — party member registry
      BIT.Inspect  — inspect queue
      BIT.Rotation — kick rotation
    -----------------------------------------------------------------------
]]

BIT = BIT or {}
BIT.VERSION    = "3.2.1"
BIT.SyncCD      = BIT.SyncCD      or {}
BIT.SyncCD.users = BIT.SyncCD.users or {}  -- name → {class, specID} — only HELLO senders, never touched by interrupt system
BIT.syncCdState = BIT.syncCdState or {}

------------------------------------------------------------
-- Shared runtime flags
------------------------------------------------------------
BIT.ready     = false
BIT.inCombat  = false
BIT.testMode  = false
BIT.debugMode = false

------------------------------------------------------------
-- BIT.Taint  — resolve tainted spell IDs from C-land
-- Uses a hidden Slider whose OnValueChanged callback fires
-- from C++ context, stripping the taint from secret values.
------------------------------------------------------------
do
    local _slider = CreateFrame("Slider", nil, UIParent)
    _slider:SetMinMaxValues(0, 9999999)
    _slider:SetSize(1, 1)
    _slider:Hide()

    local _result = nil
    _slider:SetScript("OnValueChanged", function(_, v) _result = v end)

    BIT.Taint = {}

    --- Attempt to resolve a (possibly tainted) spell ID.
    --- Returns the canonical interrupt spell ID, or nil.
    function BIT.Taint:Resolve(rawID)
        _result = nil

        -- Fast path: untainted numeric ID works directly
        local directOk, directHit = pcall(function()
            return BIT.ALL_INTERRUPTS[rawID]
        end)
        if directOk and directHit then
            return BIT.SPELL_ALIASES[rawID] or rawID
        end

        -- String path: tostring() often works even on tainted values.
        -- NOTE: tostring() on a tainted value returns a *tainted* string in WoW.
        --       A tainted string still cannot be used as a table index, so every
        --       lookup that uses idStr must itself be wrapped in pcall.
        local strOk, idStr = pcall(tostring, rawID)
        if strOk and idStr then
            local aliasOk, aliasTarget = pcall(function()
                return BIT.SPELL_ALIASES_STR[idStr]
            end)
            if aliasOk and aliasTarget then
                local hitOk, hit = pcall(function()
                    return BIT.ALL_INTERRUPTS[aliasTarget]
                end)
                if hitOk and hit then
                    return aliasTarget
                end
            end
            local hitOk, hit = pcall(function()
                return BIT.ALL_INTERRUPTS_STR[idStr]
            end)
            if hitOk and hit then
                local numOk, num = pcall(tonumber, idStr)
                return (numOk and num) or nil
            end
        end

        -- Slider path: push value through C++ OnValueChanged to strip taint.
        -- IMPORTANT: the two SetValue calls must be in SEPARATE pcalls.
        -- If they share one pcall, SetValue(0) fires OnValueChanged(_result=0),
        -- then SetValue(rawID) fails silently (tainted) — leaving _result=0,
        -- which the _result~=0 guard below rejects, giving a false nil.
        pcall(_slider.SetValue, _slider, 0)   -- reset; may set _result=0
        _result = nil                          -- clear so we know if rawID fires
        local sliderOk = pcall(_slider.SetValue, _slider, rawID)

        if sliderOk and _result and _result ~= 0 then
            local s = tostring(_result)
            if BIT.ALL_INTERRUPTS_STR[s] then
                if BIT.debugMode then
                    print("|cff0091edBliZzi|r|cffffa300Interrupts|r |cFFAAAAAA[DBG]|r Taint.Resolve: " .. BIT.ALL_INTERRUPTS_STR[s].name
                          .. " (str=" .. s .. ") via slider")
                end
                local num = tonumber(s)
                return num and (BIT.SPELL_ALIASES[num] or num) or nil
            end
        end

        return nil
    end
end

------------------------------------------------------------
-- BIT.Net  — addon message communication
--
-- Protocol (v1, pipe-free semicolon format):
--   B1;HELLO;class;spellID;cd    — announce self on join (requires interrupt spell)
--   B1;HELLOSYNC;class           — announce self for Party CDs (works without interrupt)
--   B1;KICK;spellID;cd           — own interrupt cast
--   B1;ROT;p1,p2,...;idx         — full rotation broadcast
--   B1;RIDX;idx                  — rotation index update only
------------------------------------------------------------
local recentCasts = {}   -- name → { t, spellID } — last known interrupt cast per player
------------------------------------------------------------
do
    local PREFIX  = "BliZziIT"
    local HDR     = "B1"
    local SEP     = ";"

    BIT.Net = {}

    -- Send to party; falls back to whispering each member
    -- when SendAddonMessage PARTY is blocked (inside instances).
    local function Transmit(payload)
        if IsInGroup(LE_PARTY_CATEGORY_HOME) then
            local ok, ret = pcall(C_ChatInfo.SendAddonMessage, PREFIX, payload, "PARTY")
            if ok and ret == 0 then return end
        end
        for i = 1, 4 do
            local u = "party" .. i
            if UnitExists(u) and UnitIsPlayer(u) then
                local ok, name, realm = pcall(UnitFullName, u)
                if ok and name then
                    local target = (realm and realm ~= "") and (name .. "-" .. realm) or name
                    pcall(C_ChatInfo.SendAddonMessage, PREFIX, payload, "WHISPER", target)
                end
            end
        end
    end

    local function Msg(...) return table.concat({HDR, ...}, SEP) end

    function BIT.Net:AnnounceHello(class, spellID, cd)
        Transmit(Msg("HELLO", class, spellID, cd))
    end

    function BIT.Net:AnnounceKick(spellID, cd)
        Transmit(Msg("KICK", spellID, cd))
    end

    function BIT.Net:AnnounceFailedKick()
        Transmit(Msg("FAILKICK"))
    end

    function BIT.Net:AnnounceSuccessKick()
        Transmit(Msg("SUCCESSKICK"))
    end

    function BIT.Net:AnnounceSync(spellID, duration)
        Transmit(Msg("SYNCCD", spellID, duration))
    end

    function BIT.Net:AnnounceSyncHello(class)
        Transmit(Msg("HELLOSYNC", class))
    end

    function BIT.Net:SyncRotation(order, idx)
        Transmit(Msg("ROT", table.concat(order, ","), idx))
    end

    function BIT.Net:SyncRotationIndex(idx)
        Transmit(Msg("RIDX", idx))
    end

    -- Dispatch table: command → handler(parts, senderName)
    local dispatch = {}

    dispatch["HELLO"] = function(parts, sender)
        local cls    = parts[3]
        local sid    = tonumber(parts[4])
        local baseCd = tonumber(parts[5])
        if cls and BIT.CLASS_COLORS[cls] and sid and BIT.ALL_INTERRUPTS[sid] then
            local entry      = BIT.Registry:GetOrCreate(sender)
            entry.class      = cls
            entry.spellID    = sid
            entry.isNonAddon = nil   -- upgrade from placeholder if they had no addon before
            if baseCd and baseCd > 0 then entry.baseCd = baseCd end
            BIT.Registry:MarkAddon(sender)
            -- populate SyncCD's own user table (independent of interrupt registry)
            if BIT.SyncCD and BIT.SyncCD.users then
                BIT.SyncCD.users[sender] = BIT.SyncCD.users[sender] or {}
                BIT.SyncCD.users[sender].class     = cls
                BIT.SyncCD.users[sender]._hasAddon = true
            end
            BIT.Self:BroadcastHello()
            -- queue inspect so we get specID, then rebuild SyncCD
            BIT.Inspect:Invalidate(sender)
            C_Timer.After(0.5, function() BIT.Inspect:QueueAll() end)
            -- also rebuild immediately (no spec yet, but shows player),
            -- then again after inspect should be done
            C_Timer.After(0.1, function()
                if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
            end)
            C_Timer.After(3.0, function()
                if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
            end)
        end
    end

    dispatch["HELLOSYNC"] = function(parts, sender)
        local cls = parts[3]
        if not cls or not BIT.CLASS_COLORS[cls] then return end
        if BIT.SyncCD and BIT.SyncCD.users then
            BIT.SyncCD.users[sender] = BIT.SyncCD.users[sender] or {}
            BIT.SyncCD.users[sender].class     = cls
            BIT.SyncCD.users[sender]._hasAddon = true
        end
        -- reply once so the sender also knows about us
        BIT.Self:BroadcastSyncHello()
        -- queue inspect to get specID, then rebuild
        BIT.Inspect:Invalidate(sender)
        C_Timer.After(0.5, function() BIT.Inspect:QueueAll() end)
        C_Timer.After(0.1, function()
            if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
        end)
        C_Timer.After(3.0, function()
            if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
        end)
    end

    dispatch["KICK"] = function(parts, sender)
        local sid = tonumber(parts[3])
        local cd  = tonumber(parts[4])
        if cd and cd > 0 then
            -- update recentCasts for mob-interrupt correlation
            if sid then recentCasts[sender] = { t = GetTime(), spellID = sid } end
            local entry = BIT.Registry:Get(sender)
            if entry then
                local now = GetTime()

                -- Check if sid belongs to an extraKick bar (e.g. Fel Ravager 132409
                -- for a Demonology Warlock whose main spell is Axe Toss 119914).
                -- If so, update that specific extraKick cdEnd instead of the main bar.
                local routedToExtra = false
                if sid and entry.extraKicks then
                    for _, ek in ipairs(entry.extraKicks) do
                        if ek.spellID == sid then
                            ek.cdEnd = now + cd
                            routedToExtra = true
                            break
                        end
                    end
                end

                if not routedToExtra then
                    -- Normal case: update main interrupt bar
                    entry.cdEnd  = now + cd
                    entry.baseCd = cd
                end

                BIT.Rotation:OnKick(sender)
                if BIT.debugMode then
                    local nm = sid and BIT.ALL_INTERRUPTS[sid] and BIT.ALL_INTERRUPTS[sid].name or "?"
                    print("|cff0091edBliZzi|r|cffffa300Interrupts|r |cFFAAAAAA[DBG]|r KICK msg: " .. sender .. " → " .. nm
                          .. " cd=" .. cd .. "s" .. (routedToExtra and " [extraKick]" or ""))
                end
            end
        end
    end

    dispatch["ROT"] = function(parts, sender)
        local playerStr = parts[3]
        local idx       = tonumber(parts[4])
        if playerStr and idx then
            local names = {}
            for n in playerStr:gmatch("[^,]+") do names[#names+1] = n end
            BIT.Rotation:ApplySync(names, idx)
        end
    end

    dispatch["RIDX"] = function(parts, sender)
        local idx = tonumber(parts[3])
        if idx then BIT.Rotation:ApplyIndex(idx) end
    end

    dispatch["FAILKICK"] = function(parts, sender)
        if BIT.db.showFailedKick and BIT.UI and BIT.UI.FlashFailedKick then
            BIT.UI:FlashFailedKick(sender)
        end
    end

    dispatch["SUCCESSKICK"] = function(parts, sender)
        if BIT.db.showFailedKick and BIT.UI and BIT.UI.MarkSuccessKick then
            BIT.UI:MarkSuccessKick(sender)
        end
    end

    dispatch["SYNCCD"] = function(parts, sender)
        local sid = tonumber(parts[3])
        local dur = tonumber(parts[4])
        if sid and dur and BIT.SyncCD and BIT.SyncCD.OnSpellUsed then
            BIT.SyncCD:OnSpellUsed(sender, sid, dur)
        end
    end

    function BIT.Net:OnMessage(msgPrefix, message, channel, sender)
        if msgPrefix ~= PREFIX then return end
        local shortName = Ambiguate(sender, "short")
        local parts = { strsplit(SEP, message) }
        if parts[1] ~= HDR then return end
        local cmd = parts[2]
        if shortName == BIT.Self.name then return end
        local handler = dispatch[cmd]
        if handler then handler(parts, shortName) end
    end

    function BIT.Net:Register()
        C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)
    end
end

------------------------------------------------------------
-- BIT.Registry  — party member state
------------------------------------------------------------
do
    BIT.Registry = {}
    local _data = {}   -- name → entry table
    local _addonUsers = {}  -- name → true, only players who sent HELLO

    function BIT.Registry:Get(name)     return _data[name] end
    function BIT.Registry:Remove(name)  _data[name] = nil end  -- does NOT remove from addonUsers
    function BIT.Registry:All()         return _data end
    function BIT.Registry:AddonUsers()  return _addonUsers end
    function BIT.Registry:MarkAddon(name) _addonUsers[name] = true end
    function BIT.Registry:RemoveFromGroup(name)  -- call when player leaves group
        _data[name] = nil
        _addonUsers[name] = nil
    end

    function BIT.Registry:GetOrCreate(name)
        if not _data[name] then
            _data[name] = { cdEnd = 0 }
        end
        return _data[name]
    end

    function BIT.Registry:Purge(keepNames)
        for name in pairs(_data) do
            if not keepNames[name] then _data[name] = nil end
        end
        -- only remove addon users who are no longer in group
        for name in pairs(_addonUsers) do
            if not keepNames[name] then _addonUsers[name] = nil end
        end
    end

    function BIT.Registry:Clear()
        for k in pairs(_data) do _data[k] = nil end
        for k in pairs(_addonUsers) do _addonUsers[k] = nil end
    end

    -- back-compat alias used by UI.lua / Profile.lua
    BIT.partyAddonUsers = _data
end

------------------------------------------------------------
-- BIT.Self  — own player state + helpers
------------------------------------------------------------
do
    BIT.Self = {
        name        = nil,
        class       = nil,
        spellID     = nil,
        baseCd      = nil,
        cachedCd    = nil,
        kickCdEnd   = 0,
        isPetSpell  = false,
        extraKicks  = {},   -- spellID → { baseCd, cdEnd, name, icon }
        lastHello   = 0,
    }

    -- Back-compat aliases used by UI.lua and other modules
    -- (kept as references so mutations stay in sync)
    local S = BIT.Self
    BIT.myName       = nil  -- updated on init
    BIT.myClass      = nil
    BIT.mySpellID    = nil
    BIT.myCachedCD   = nil
    BIT.myBaseCd     = nil
    BIT.myKickCdEnd  = 0
    BIT.myIsPetSpell = false
    BIT.myExtraKicks = {}

    local function SyncCompat()
        BIT.myName       = S.name
        BIT.myClass      = S.class
        BIT.mySpellID    = S.spellID
        BIT.myCachedCD   = S.cachedCd
        BIT.myBaseCd     = S.baseCd
        BIT.myKickCdEnd  = S.kickCdEnd
        BIT.myIsPetSpell = S.isPetSpell
        BIT.myExtraKicks = S.extraKicks
    end

    function BIT.Self:UpdateFromPlayer()
        self.name  = UnitName("player")
        local _, cls = UnitClass("player")
        self.class = cls
        SyncCompat()
    end

    function BIT.Self:ReadBaseCd()
        if not self.spellID then return end
        -- Trust spec-override CD; only let cachedCd refine it
        local specIndex = GetSpecialization()
        local specID    = specIndex and GetSpecializationInfo(specIndex)
        local ov = specID and BIT.SPEC_INTERRUPT_OVERRIDES[specID]
        if ov and ov.id == self.spellID then
            if self.cachedCd and self.cachedCd > 1.5 then
                self.baseCd = self.cachedCd
            end
            SyncCompat(); return
        end
        local ok, ms = pcall(GetSpellBaseCooldown, self.spellID)
        if ok and ms then
            local clean = tonumber(string.format("%.0f", ms))
            if clean and clean > 0 then self.baseCd = clean / 1000 end
        end
        if self.cachedCd and self.cachedCd > 1.5 then
            self.baseCd = self.cachedCd
        end
        SyncCompat()
    end

    function BIT.Self:CacheCooldown()
        if not self.spellID or InCombatLockdown() then return end
        if self.isPetSpell or not C_SpellBook.IsSpellInSpellBook(self.spellID, Enum.SpellBookSpellBank.Player) then return end
        local ok, info = pcall(C_Spell.GetSpellCooldown, self.spellID)
        if not ok or not info then return end
        local ok2, dur = pcall(function() return info.duration end)
        if not ok2 or not dur then return end
        local clean = tonumber(string.format("%.1f", dur))
        if clean and clean > 1.5 then
            self.cachedCd = clean
            self.baseCd   = clean
            SyncCompat()
        end
    end

    function BIT.Self:BroadcastHello()
        if not self.class or not self.spellID then return end
        local now = GetTime()
        if now - self.lastHello < 3 then return end
        self.lastHello = now
        self:ReadBaseCd()
        local cd = self.baseCd or BIT.ALL_INTERRUPTS[self.spellID].cd
        BIT.Net:AnnounceHello(self.class, self.spellID, cd)
    end

    function BIT.Self:BroadcastSyncHello()
        if not self.class then return end
        local now = GetTime()
        -- separate rate limit so it doesn't conflict with interrupt HELLO
        if self.lastSyncHello and now - self.lastSyncHello < 3 then return end
        self.lastSyncHello = now
        BIT.Net:AnnounceSyncHello(self.class)
    end

    function BIT.Self:OnOwnKick(spellID)
        local now = GetTime()

        -- mark own bar green immediately, revert to red if no mob interrupt in 0.6s
        local function markAndWatch(barSpellID)
            if BIT.db.showFailedKick and BIT.UI and BIT.UI.SetPendingKickColor then
                BIT.UI:SetPendingKickColor(self.name)
            end
            self._pendingKickAt = now
            C_Timer.After(0.6, function()
                if self._pendingKickAt == now then
                    self._pendingKickAt = nil
                    if BIT.db.showFailedKick and BIT.UI and BIT.UI.FlashFailedKick then
                        BIT.UI:FlashFailedKick(self.name)
                        BIT.Net:AnnounceFailedKick()
                    end
                end
            end)
        end

        if self.extraKicks[spellID] then
            local cd = self.extraKicks[spellID].baseCd
            self.extraKicks[spellID].cdEnd = now + cd
            SyncCompat()
            BIT.Net:AnnounceKick(spellID, cd)
            BIT.Rotation:OnKick(self.name)
            markAndWatch(spellID)
            return
        end
        if self.spellID and spellID ~= self.spellID then
            local data = BIT.ALL_INTERRUPTS[spellID]
            if data then
                self.extraKicks[spellID] = { baseCd=data.cd, cdEnd=now+data.cd }
                SyncCompat()
                BIT.Net:AnnounceKick(spellID, data.cd)
                BIT.Rotation:OnKick(self.name)
                markAndWatch(spellID)
                return
            end
        end
        local cd = self.cachedCd or self.baseCd or BIT.ALL_INTERRUPTS[spellID].cd
        self.kickCdEnd = now + cd
        SyncCompat()
        BIT.Net:AnnounceKick(spellID, cd)
        BIT.Rotation:OnKick(self.name)
        markAndWatch(spellID)
    end

    function BIT.Self:FindInterrupt()
        local prevSpell    = self.spellID
        local prevExtras   = self.extraKicks
        self.spellID       = nil
        self.isPetSpell    = false
        self.extraKicks    = {}

        local specIndex = GetSpecialization()
        local specID    = specIndex and GetSpecializationInfo(specIndex)

        if specID and BIT.SPEC_NO_INTERRUPT[specID] then
            if prevSpell then self.cachedCd = nil; self.baseCd = nil end
            SyncCompat(); return
        end

        -- Spec override
        local ov = specID and BIT.SPEC_INTERRUPT_OVERRIDES[specID]
        if ov then
            if ov.isPet then
                local known = C_SpellBook.IsSpellInSpellBook(ov.id, Enum.SpellBookSpellBank.Pet)
                    or (ov.petSpellID and C_SpellBook.IsSpellInSpellBook(ov.petSpellID, Enum.SpellBookSpellBank.Pet))
                    or C_SpellBook.IsSpellInSpellBook(ov.id, Enum.SpellBookSpellBank.Player)
                if not known then
                    if C_SpellBook.IsSpellKnown(ov.id) then known=true end
                end
                if known then
                    self.spellID    = ov.id
                    self.baseCd     = ov.cd
                    self.isPetSpell = true
                end
            else
                self.spellID    = ov.id
                self.baseCd     = ov.cd
                self.isPetSpell = false
            end
        end

        -- Spec extra kicks (always present for this spec)
        local specExtras = specID and BIT.SPEC_EXTRA_KICKS[specID]
        local specManaged = {}
        if specExtras then
            for _, ex in ipairs(specExtras) do
                specManaged[ex.spellID] = true
                local checkID = ex.talentCheck or ex.spellID
                local known   = C_SpellBook.IsSpellInSpellBook(checkID, Enum.SpellBookSpellBank.Player) or C_SpellBook.IsSpellInSpellBook(checkID, Enum.SpellBookSpellBank.Pet)
                if not known then
                    if C_SpellBook.IsSpellKnown(checkID) then known=true end
                end
                if known then
                    self.extraKicks[ex.spellID] = {
                        baseCd      = ex.cd,
                        cdEnd       = (prevExtras[ex.spellID] and prevExtras[ex.spellID].cdEnd) or 0,
                        name        = ex.name,
                        icon        = ex.icon,
                        talentCheck = ex.talentCheck,
                    }
                end
            end
        end

        -- Class spell list
        local spellList = self.class and BIT.CLASS_INTERRUPT_LIST[self.class]
        if spellList then
            for _, sid in ipairs(spellList) do
                local known = C_SpellBook.IsSpellInSpellBook(sid, Enum.SpellBookSpellBank.Player) or C_SpellBook.IsSpellInSpellBook(sid, Enum.SpellBookSpellBank.Pet)
                if not known then
                    if C_SpellBook.IsSpellKnown(sid) then known=true end
                end
                if known then
                    if not self.spellID then
                        self.spellID = sid
                    elseif sid ~= self.spellID and not self.extraKicks[sid] and not specManaged[sid] then
                        local data = BIT.ALL_INTERRUPTS[sid]
                        if data then
                            self.extraKicks[sid] = {
                                baseCd = data.cd,
                                cdEnd  = (prevExtras[sid] and prevExtras[sid].cdEnd) or 0,
                            }
                        end
                    end
                end
            end
        end

        if self.spellID ~= prevSpell then
            self.cachedCd = nil
            if not self.baseCd and self.spellID then self:ReadBaseCd() end
        end

        -- Own talent scan
        self:ScanOwnTalents()
        SyncCompat()
    end

    function BIT.Self:ScanOwnTalents()
        if not self.spellID then return end
        if not (C_ClassTalents and C_ClassTalents.GetActiveConfigID) then return end
        local ok0, cid = pcall(C_ClassTalents.GetActiveConfigID)
        if not ok0 or not cid then return end
        local ok1, cfg = pcall(C_Traits.GetConfigInfo, cid)
        if not ok1 or not cfg or not cfg.treeIDs or #cfg.treeIDs == 0 then return end
        local ok2, nodes = pcall(C_Traits.GetTreeNodes, cfg.treeIDs[1])
        if not ok2 or not nodes then return end

        for _, nodeID in ipairs(nodes) do
            local ok3, node = pcall(C_Traits.GetNodeInfo, cid, nodeID)
            if ok3 and node and node.activeEntry and node.activeRank and node.activeRank > 0 then
                local ok4, entry = pcall(C_Traits.GetEntryInfo, cid, node.activeEntry.entryID)
                if ok4 and entry and entry.definitionID then
                    local ok5, def = pcall(C_Traits.GetDefinitionInfo, entry.definitionID)
                    if ok5 and def and def.spellID then
                        local dsid = def.spellID
                        local dsidStr; do local ok,s = pcall(tostring, dsid); if ok then dsidStr=s end end
                        local talent = (pcall(function() return BIT.CD_REDUCTION_TALENTS[dsid] end)
                                        and BIT.CD_REDUCTION_TALENTS[dsid])
                                        or (dsidStr and BIT.CD_REDUCTION_TALENTS_STR[dsidStr])
                        if talent and talent.affects == self.spellID then
                            local base = self.baseCd or BIT.ALL_INTERRUPTS[self.spellID].cd
                            local newCd
                            if talent.pctReduction then
                                newCd = math.floor(base * (1 - talent.pctReduction/100) + 0.5)
                            else
                                newCd = base - talent.reduction
                            end
                            self.baseCd = math.max(1, newCd)
                            -- also reduce extra kicks if talent says so
                            if talent.affectsExtraKicks and self.extraKicks then
                                for _, ek in pairs(self.extraKicks) do
                                    local ekBase = ek.baseCd or 0
                                    if ekBase > 0 then
                                        local ekNew
                                        if talent.pctReduction then
                                            ekNew = math.floor(ekBase * (1 - talent.pctReduction/100) + 0.5)
                                        else
                                            ekNew = ekBase - talent.reduction
                                        end
                                        ek.baseCd = math.max(1, ekNew)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

------------------------------------------------------------
-- BIT.Inspect  — inspect queue management
------------------------------------------------------------
do
    BIT.Inspect = {
        queue   = {},
        busy    = false,
        current = nil,
        done    = {},   -- name → true (inspected this session)
        noKick  = {},   -- name → true (healer / no interrupt)
    }

    -- back-compat
    BIT.inspectQueue       = BIT.Inspect.queue
    BIT.inspectBusy        = false
    BIT.inspectUnit        = nil
    BIT.inspectedPlayers   = BIT.Inspect.done
    BIT.noInterruptPlayers = BIT.Inspect.noKick

    local I = BIT.Inspect

    function BIT.Inspect:Enqueue(unit)
        local name = UnitName(unit)
        if name and not self.done[name] then
            self.queue[#self.queue+1] = unit
        end
    end

    function BIT.Inspect:QueueAll()
        self.queue = {}
        for i = 1, 4 do
            local u = "party" .. i
            if UnitExists(u) then self:Enqueue(u) end
        end
        self:Process()
    end

    function BIT.Inspect:Process()
        if self.busy then return end
        while #self.queue > 0 do
            local unit = table.remove(self.queue, 1)
            if UnitExists(unit) and UnitIsConnected(unit) then
                local name = UnitName(unit)
                if name and not self.done[name] then
                    self.busy    = true
                    self.current = unit
                    BIT.inspectBusy = true
                    BIT.inspectUnit = unit
                    NotifyInspect(unit)
                    return
                end
            end
        end
    end

    function BIT.Inspect:OnReady()
        if not self.busy or not self.current then return end
        pcall(function() BIT.Inspect:ScanTalents(self.current) end)
        ClearInspectPlayer()
        self.busy    = false
        self.current = nil
        BIT.inspectBusy = false
        BIT.inspectUnit = nil
        C_Timer.After(0.5, function() BIT.Inspect:Process() end)
    end

    function BIT.Inspect:Invalidate(name)
        self.done[name]   = nil
        self.noKick[name] = nil
    end

    function BIT.Inspect:ScanTalents(unit)
        local name = UnitName(unit)
        if not name then return end
        local entry = BIT.Registry:Get(name)
        if not entry then return end

        local specID = GetInspectSpecialization(unit)
        if specID and specID > 0 then
            -- store specID in SyncCD's own table (independent of interrupt system)
            if BIT.SyncCD and BIT.SyncCD.users and BIT.SyncCD.users[name] then
                BIT.SyncCD.users[name].specID = specID
                BIT.SyncCD.users[name].class  = BIT.SyncCD.users[name].class
                    or (function() local _, c = UnitClass(unit); return c end)()
            end
            -- Clear old talent-gated extra kicks
            if entry.extraKicks and BIT.SPEC_EXTRA_KICKS[specID] then
                for _, ex in ipairs(BIT.SPEC_EXTRA_KICKS[specID]) do
                    if ex.talentCheck then
                        for j = #entry.extraKicks, 1, -1 do
                            if entry.extraKicks[j].spellID == ex.spellID then
                                table.remove(entry.extraKicks, j)
                            end
                        end
                    end
                end
            end

            if BIT.SPEC_NO_INTERRUPT[specID] then
                BIT.Registry:Remove(name)
                self.done[name]   = true
                self.noKick[name] = true
                return
            end

            local ov = BIT.SPEC_INTERRUPT_OVERRIDES[specID]
            if ov then
                local apply = true
                if ov.isPet then
                    local petIdx = unit:match("party(%d)")
                    local petUnit = petIdx and ("partypet" .. petIdx)
                    if petUnit and UnitExists(petUnit) then
                        local family = UnitCreatureFamily(petUnit)
                        if ov.id == 119914 and family and family ~= "Felguard" then
                            apply = false
                        end
                    else
                        apply = false
                    end
                end
                if apply then
                    entry.spellID = ov.id
                    entry.baseCd  = ov.cd
                else
                    local fb = 19647
                    if BIT.ALL_INTERRUPTS[fb] then
                        entry.spellID = fb
                        entry.baseCd  = BIT.ALL_INTERRUPTS[fb].cd
                    end
                end
            end

            local specExtras = BIT.SPEC_EXTRA_KICKS[specID]
            if specExtras then
                if not entry.extraKicks then entry.extraKicks = {} end
                for _, ex in ipairs(specExtras) do
                    if not ex.talentCheck then
                        local found = false
                        for _, ek in ipairs(entry.extraKicks) do
                            if ek.spellID == ex.spellID then found=true; break end
                        end
                        if not found then
                            entry.extraKicks[#entry.extraKicks+1] = {
                                spellID=ex.spellID, baseCd=ex.cd, cdEnd=0, name=ex.name, icon=ex.icon
                            }
                        end
                    end
                end
            end
        end

        -- Talent tree scan
        local ok1, cfg = pcall(C_Traits.GetConfigInfo, -1)
        if not ok1 or not cfg or not cfg.treeIDs or #cfg.treeIDs == 0 then
            self.done[name] = true; return
        end
        local ok2, nodes = pcall(C_Traits.GetTreeNodes, cfg.treeIDs[1])
        if not ok2 or not nodes then self.done[name] = true; return end

        local knownSpells = {}   -- collect every spell ID from active talent nodes
        for _, nodeID in ipairs(nodes) do
            local ok3, node = pcall(C_Traits.GetNodeInfo, -1, nodeID)
            if ok3 and node and node.activeEntry and node.activeRank and node.activeRank > 0 then
                local ok4, entryInfo = pcall(C_Traits.GetEntryInfo, -1, node.activeEntry.entryID)
                if ok4 and entryInfo and entryInfo.definitionID then
                    local ok5, def = pcall(C_Traits.GetDefinitionInfo, entryInfo.definitionID)
                    if ok5 and def and def.spellID then
                        local sid = def.spellID
                        knownSpells[sid] = true
                        local sidStr; do local ok,s = pcall(tostring,sid); if ok then sidStr=s end end

                        local redTalent = (pcall(function() return BIT.CD_REDUCTION_TALENTS[sid] end)
                                          and BIT.CD_REDUCTION_TALENTS[sid])
                                          or (sidStr and BIT.CD_REDUCTION_TALENTS_STR[sidStr])
                        if redTalent then
                            local newCd
                            if redTalent.pctReduction then
                                newCd = math.floor(entry.baseCd * (1 - redTalent.pctReduction/100) + 0.5)
                            else
                                newCd = entry.baseCd - redTalent.reduction
                            end
                            entry.baseCd = math.max(1, newCd)
                        end

                        local kickTalent = (pcall(function() return BIT.CD_ON_KICK_TALENTS[sid] end)
                                           and BIT.CD_ON_KICK_TALENTS[sid])
                                           or (sidStr and BIT.CD_ON_KICK_TALENTS_STR[sidStr])
                        if kickTalent then entry.onKickReduction = kickTalent.reduction end

                        local extraTalent = (pcall(function() return BIT.EXTRA_KICK_TALENTS[sid] end)
                                            and BIT.EXTRA_KICK_TALENTS[sid])
                                            or (sidStr and BIT.EXTRA_KICK_TALENTS_STR[sidStr])
                        if extraTalent then
                            if not entry.extraKicks then entry.extraKicks = {} end
                            entry.extraKicks[#entry.extraKicks+1] = {
                                spellID=extraTalent.id, baseCd=extraTalent.cd, cdEnd=0, name=extraTalent.name
                            }
                        end

                        -- Spec-gated talent extras
                        if specID and BIT.SPEC_EXTRA_KICKS[specID] then
                            for _, ex in ipairs(BIT.SPEC_EXTRA_KICKS[specID]) do
                                if ex.talentCheck then
                                    local match = false
                                    local ok, eq = pcall(function() return ex.talentCheck == sid end)
                                    if ok and eq then match=true end
                                    if not match and sidStr then
                                        match = (tostring(ex.talentCheck) == sidStr)
                                    end
                                    if match then
                                        if not entry.extraKicks then entry.extraKicks = {} end
                                        local found = false
                                        for _, ek in ipairs(entry.extraKicks) do
                                            if ek.spellID == ex.spellID then found=true; break end
                                        end
                                        if not found then
                                            entry.extraKicks[#entry.extraKicks+1] = {
                                                spellID=ex.spellID, baseCd=ex.cd, cdEnd=0,
                                                name=ex.name, icon=ex.icon,
                                            }
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        -- Store talent-granted spell IDs for SyncCD icon filtering
        if next(knownSpells) then
            if not BIT.SyncCD.users then BIT.SyncCD.users = {} end
            if not BIT.SyncCD.users[name] then BIT.SyncCD.users[name] = {} end
            BIT.SyncCD.users[name].knownSpells = knownSpells
            -- Bump version so BuildAttachedBar detects the talent change and rebuilds
            BIT.SyncCD.users[name]._talentVer = (BIT.SyncCD.users[name]._talentVer or 0) + 1
        end

        self.done[name] = true
    end
end

------------------------------------------------------------
-- BIT.Rotation  — kick rotation logic
------------------------------------------------------------
do
    BIT.Rotation = {
        order = {},
        index = 1,
    }

    -- back-compat
    BIT.rotationOrder = BIT.Rotation.order
    BIT.rotationIndex = BIT.Rotation.index

    local function Persist()
        BIT.db.rotationOrder = BIT.Rotation.order
        BIT.db.rotationIndex = BIT.Rotation.index
        BIT.rotationOrder    = BIT.Rotation.order
        BIT.rotationIndex    = BIT.Rotation.index
        if BIT.UI and BIT.UI.MarkRotationDirty then BIT.UI:MarkRotationDirty() end
    end

    function BIT.Rotation:OnKick(kickerName)
        if not BIT.db or not BIT.db.rotationEnabled then return end
        if #self.order == 0 then return end
        if self.order[self.index] ~= kickerName then return end
        self.index = self.index % #self.order + 1
        Persist()
        BIT.Net:SyncRotationIndex(self.index)
    end

    function BIT.Rotation:Broadcast()
        if #self.order == 0 then return end
        BIT.Net:SyncRotation(self.order, self.index)
    end

    function BIT.Rotation:ApplySync(names, idx)
        self.order = names
        self.index = math.max(1, math.min(idx, #names))
        Persist()
    end

    function BIT.Rotation:ApplyIndex(idx)
        if #self.order == 0 then return end
        self.index = math.max(1, math.min(idx, #self.order))
        Persist()
    end

    function BIT.Rotation:Restore()
        self.order = BIT.db.rotationOrder or {}
        self.index = BIT.db.rotationIndex or 1
        BIT.rotationOrder = self.order
        BIT.rotationIndex = self.index
        if BIT.UI and BIT.UI.MarkRotationDirty then BIT.UI:MarkRotationDirty() end
    end

    -- Public back-compat wrappers used by UI.lua
    BIT.AdvanceRotation   = function(name) BIT.Rotation:OnKick(name) end
    BIT.BroadcastRotation = function()     BIT.Rotation:Broadcast()  end
end

------------------------------------------------------------
-- Party management helpers
------------------------------------------------------------
function BIT:CleanPartyList()
    if self.testMode then return end
    local active = {}
    for i = 1, 4 do
        local u = "party" .. i
        if UnitExists(u) then active[UnitName(u)] = true end
    end
    BIT.Registry:Purge(active)
    -- also remove from SyncCD.users if they left the group
    if BIT.SyncCD and BIT.SyncCD.users then
        for name in pairs(BIT.SyncCD.users) do
            if not active[name] then BIT.SyncCD.users[name] = nil end
        end
    end
    for name in pairs(BIT.Inspect.noKick) do
        if not active[name] then
            BIT.Inspect.noKick[name] = nil
            BIT.Inspect.done[name]   = nil
        end
    end
    for name in pairs(BIT.Inspect.done) do
        if not active[name] then BIT.Inspect.done[name] = nil end
    end
    BIT.Self:BroadcastHello()
    C_Timer.After(0.1, function()
        if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
    end)
end

function BIT:AutoRegisterPartyByClass()
    local addonUsers = BIT.Registry:AddonUsers()
    for i = 1, 4 do
        local u = "party" .. i
        if UnitExists(u) then
            local name  = UnitName(u)
            local _, cls = UnitClass(u)
            if name and cls and BIT.CLASS_INTERRUPTS[cls] then
                local role       = UnitGroupRolesAssigned(u)
                local skipHealer = (role == "HEALER" and not BIT.HEALER_KEEPS_KICK[cls])
                if not skipHealer and not BIT.Inspect.noKick[name] then
                    local kick     = BIT.CLASS_INTERRUPTS[cls]
                    local isAddon  = addonUsers[name]
                    local existing = BIT.Registry:Get(name)
                    if isAddon then
                        -- Full addon user: register or upgrade from non-addon placeholder
                        if not existing or existing.isNonAddon then
                            local entry      = BIT.Registry:GetOrCreate(name)
                            entry.class      = cls
                            entry.spellID    = kick.id
                            entry.baseCd     = kick.cd
                            entry.isNonAddon = nil   -- clear placeholder flag
                        end
                    else
                        -- No addon: show a desaturated "No Addon" placeholder bar
                        if not existing then
                            local entry      = BIT.Registry:GetOrCreate(name)
                            entry.class      = cls
                            entry.spellID    = kick.id
                            entry.baseCd     = kick.cd
                            entry.cdEnd      = 0
                            entry.isNonAddon = true
                        end
                    end
                end
            end
        end
    end
end

------------------------------------------------------------
-- Spell cast handling (own + party)
------------------------------------------------------------
function BIT:HandlePartyCast(unit, spellID, memberName)
    local now = GetTime()
    if memberName == BIT.Self.name then return end

    local resolvedID = BIT.SPELL_ALIASES[spellID] or spellID

    -- Demo Warlock edge-case: primary is Axe Toss (119914, pet).
    -- When the Felhunter is active instead of Felguard, Spell Lock fires
    -- as 19647 — but the extra-kick bar tracks 132409. Remap here so
    -- the correct bar gets updated without globally aliasing 19647.
    if resolvedID == 19647 then
        local e = BIT.Registry:Get(memberName)
        if e and e.spellID == 119914 then resolvedID = 132409 end
    end
    local entry = BIT.Registry:Get(memberName)

    if entry then
        local isExtra = false
        if entry.extraKicks then
            for _, ek in ipairs(entry.extraKicks) do
                if resolvedID == ek.spellID or spellID == ek.spellID then
                    ek.cdEnd = now + ek.baseCd
                    isExtra  = true
                    break
                end
            end
        end
        if not isExtra then
            local spellData = BIT.ALL_INTERRUPTS[resolvedID]
            if entry.spellID and resolvedID ~= entry.spellID and spellData then
                -- The observed spell differs from what we have registered.
                -- Check if this spell belongs to the same class as a known
                -- spec-specific main interrupt (e.g. Balance Solar Beam vs
                -- Feral Skull Bash).  If it does, this is a spec-switch:
                -- update the main bar rather than creating a spurious extra bar.
                local cls = entry.class
                local isClassMainInterrupt = cls and (function()
                    local list = BIT.CLASS_INTERRUPT_LIST[cls]
                    if not list then return false end
                    for _, id in ipairs(list) do
                        if id == resolvedID then return true end
                    end
                    return false
                end)()

                if isClassMainInterrupt then
                    -- Spec switch detected via cast — correct the registry entry
                    -- so the bar shows the right spell and CD from now on.
                    entry.spellID = resolvedID
                    entry.baseCd  = spellData.cd
                    entry.cdEnd   = now + spellData.cd
                    entry.lastKickAt = now
                    -- Re-queue inspect so we get the full talent picture soon
                    BIT.Inspect:Invalidate(memberName)
                    C_Timer.After(1, function() BIT.Inspect:QueueAll() end)
                else
                    -- Genuinely different spell (extra kick talent etc.)
                    if not entry.extraKicks then entry.extraKicks = {} end
                    local found = false
                    for _, ek in ipairs(entry.extraKicks) do
                        if ek.spellID == resolvedID then
                            ek.cdEnd = now + ek.baseCd
                            found = true; break
                        end
                    end
                    if not found then
                        local d = BIT.ALL_INTERRUPTS[resolvedID]
                        entry.extraKicks[#entry.extraKicks+1] = {
                            spellID=resolvedID, baseCd=d.cd, cdEnd=now+d.cd, name=d.name
                        }
                    end
                end
            else
                -- Spell matches registered spell — use the spell's own CD,
                -- NOT entry.baseCd which may be stale from a previous spec.
                local cd = (spellData and spellData.cd)
                        or entry.baseCd
                        or 15
                entry.cdEnd      = now + cd
                entry.lastKickAt = now
            end
        end
    end
    -- Non-addon users are intentionally not tracked.
    -- Only players who sent a HELLO (addon users) appear in the registry.
end

------------------------------------------------------------
-- Mob-interrupt correlation
-- Tracks recent party casts to match a mob interrupt event
-- back to the player who kicked.
------------------------------------------------------------
local function OnMobInterrupted(unit)
    -- defer one frame so UNIT_SPELLCAST_SUCCEEDED can fire first
    -- (mob interrupt event can arrive in the same frame before the player cast event)
    C_Timer.After(0, function()
    local now     = GetTime()
    local bestName, bestDelta = nil, 999

    -- own player: use _pendingKickAt flag (independent of event ordering)
    if BIT.Self and BIT.Self._pendingKickAt then
        BIT.Self._pendingKickAt = nil
        if BIT.db.showFailedKick and BIT.UI and BIT.UI.MarkSuccessKick then
            BIT.UI:MarkSuccessKick(BIT.Self.name)
            BIT.Net:AnnounceSuccessKick()
        end
    end

    for name, rc in pairs(recentCasts) do
        local t = type(rc) == "table" and rc.t or rc
        local delta = now - t
        if delta > 2.0 then
            recentCasts[name] = nil
        elseif delta < bestDelta then
            bestDelta = delta
            bestName  = name
        end
    end

    if bestName and bestDelta < 1.0 then
        local entry   = BIT.Registry:Get(bestName)
        if entry and entry.onKickReduction then
            entry.cdEnd = math.max(now, entry.cdEnd - entry.onKickReduction)
        elseif entry and entry.spellID then
            local rc     = recentCasts[bestName]
            local castID = type(rc) == "table" and rc.spellID or nil
            local updated = false
            if castID and castID ~= entry.spellID and entry.extraKicks then
                for _, ek in ipairs(entry.extraKicks) do
                    if ek.spellID == castID and ek.cdEnd <= now then
                        local ekData = BIT.ALL_INTERRUPTS[castID]
                        ek.cdEnd  = now + (ek.baseCd or (ekData and ekData.cd) or 15)
                        updated   = true
                        break
                    end
                end
            end
            if not updated and entry.cdEnd <= now then
                local sid       = castID or entry.spellID
                local spellData = BIT.ALL_INTERRUPTS[sid]
                local cd        = (spellData and spellData.cd) or entry.baseCd or 15
                entry.baseCd     = cd   -- keep baseCd in sync so the bar renders correctly
                entry.cdEnd      = now + cd
                entry.lastKickAt = now
            end
        end -- if entry and entry.onKickReduction / elseif entry and entry.spellID
    end
    end) -- end C_Timer.After(0)
end

------------------------------------------------------------
-- Party cast tracking — recentCasts only (mob interrupt correlation).
-- CDs are started ONLY via addon KICK messages, never from local
-- UNIT_SPELLCAST events. This prevents white countdown bars from
-- appearing for players who haven't actually kicked.
------------------------------------------------------------
local _partyFrames    = {}
local _partyPetFrames = {}
BIT._slotWatcherActive = {}
for i = 1, 4 do
    _partyFrames[i]    = CreateFrame("Frame")
    _partyPetFrames[i] = CreateFrame("Frame")
end

function BIT:RegisterPartyWatchers()
    BIT._slotWatcherActive = BIT._slotWatcherActive or {}
    for i = 1, 4 do
        BIT._slotWatcherActive["party" .. i] = false
    end

    for i = 1, 4 do
        local unit    = "party" .. i
        local petUnit = "partypet" .. i

        _partyFrames[i]:UnregisterAllEvents()
        if UnitExists(unit) then
            -- UNIT_SPELLCAST_SENT: untainted spell name — only update recentCasts
            -- for mob-interrupt correlation. Do NOT call HandlePartyCast here.
            _partyFrames[i]:RegisterUnitEvent("UNIT_SPELLCAST_SENT", unit)
            _partyFrames[i]:SetScript("OnEvent", function(_, event, _, _, spellArg)
                local memberName = UnitName("party" .. i)
                if not memberName then return end
                local data = BIT.ALL_INTERRUPTS_BY_NAME[spellArg]
                if data then
                    recentCasts[memberName] = { t = GetTime(), spellID = data.id }
                end
            end)
            BIT._slotWatcherActive[unit] = true
        end

        _partyPetFrames[i]:UnregisterAllEvents()
    end
end

------------------------------------------------------------
-- Mob interrupt frames
------------------------------------------------------------
local _mobFrame = CreateFrame("Frame")
_mobFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "target", "focus")
for i = 1, 5 do
    _mobFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED",   "boss" .. i)
    _mobFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "boss" .. i)
    _mobFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP",  "boss" .. i)
end
_mobFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "target", "focus")
_mobFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP",  "target", "focus")

local _activeChannels = {}  -- unit → expected end time

_mobFrame:SetScript("OnEvent", function(_, event, unit)
    if event == "UNIT_SPELLCAST_INTERRUPTED" then
        OnMobInterrupted(unit)
    elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
        local ok, _, _, _, _, endMs = pcall(GetUnitChannelInfo, unit)
        if ok and endMs and endMs > 0 then
            _activeChannels[unit] = endMs / 1000
            if BIT.debugMode then
                print("|cff0091edBliZzi|r|cffffa300Interrupts|r |cFFAAAAAA[DBG]|r CHANNEL_START " .. unit .. " endAt=" .. string.format("%.1f", endMs/1000))
            end
        end
    elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
        local expectedEnd = _activeChannels[unit]
        _activeChannels[unit] = nil
        if BIT.debugMode then
            print("|cff0091edBliZzi|r|cffffa300Interrupts|r |cFFAAAAAA[DBG]|r CHANNEL_STOP " .. unit .. " expectedEnd=" .. tostring(expectedEnd) .. " now=" .. string.format("%.1f", GetTime()))
        end
        -- always treat CHANNEL_STOP as potential interrupt
        -- CHANNEL_START may not fire reliably in Midnight for mob units
        OnMobInterrupted(unit)
    end
end)

-- Pre-create all 40 nameplate frames at load time so no event is missed
local _npFrames = {}
for i = 1, 40 do
    local npUnit = "nameplate" .. i
    _npFrames[npUnit] = CreateFrame("Frame")
    _npFrames[npUnit]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED",   npUnit)
    _npFrames[npUnit]:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", npUnit)
    _npFrames[npUnit]:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP",  npUnit)
    _npFrames[npUnit]:SetScript("OnEvent", function(_, event, eUnit)
        if event == "UNIT_SPELLCAST_INTERRUPTED" then
            OnMobInterrupted(eUnit)
        elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
            local ok, _, _, _, _, endMs = pcall(GetUnitChannelInfo, eUnit)
            if ok and endMs and endMs > 0 then
                _activeChannels[eUnit] = endMs / 1000
                if BIT.debugMode then
                    print("|cff0091edBliZzi|r|cffffa300Interrupts|r |cFFAAAAAA[DBG]|r CHANNEL_START " .. eUnit .. " endAt=" .. string.format("%.1f", endMs/1000))
                end
            end
        elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
            local expectedEnd = _activeChannels[eUnit]
            _activeChannels[eUnit] = nil
            if BIT.debugMode then
                print("|cff0091edBliZzi|r|cffffa300Interrupts|r |cFFAAAAAA[DBG]|r CHANNEL_STOP " .. eUnit .. " expectedEnd=" .. tostring(expectedEnd) .. " now=" .. string.format("%.1f", GetTime()))
            end
            -- always treat CHANNEL_STOP as potential interrupt
            OnMobInterrupted(eUnit)
        end
    end)
end

------------------------------------------------------------
-- Own cast frame
------------------------------------------------------------
local _playerFrame = CreateFrame("Frame")
_playerFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player", "pet")
_playerFrame:SetScript("OnEvent", function(_, _, unit, castGUID, spellID)
    if unit == "pet" then
        -- Pet spellID is tainted in WoW 12.0 Midnight
        local usedID

        -- Try direct numeric hit first
        local ok, hit = pcall(function() return BIT.ALL_INTERRUPTS[spellID] end)
        if ok and hit then usedID = spellID end

        -- Try alias via string
        if not usedID then
            local ok2, s = pcall(tostring, spellID)
            if ok2 and s then
                local target = BIT.SPELL_ALIASES_STR[s]
                if target and BIT.ALL_INTERRUPTS[target] then usedID = target end
                if not usedID and BIT.ALL_INTERRUPTS_STR[s] then usedID = tonumber(s) end
            end
        end

        -- Slider fallback
        if not usedID then usedID = BIT.Taint:Resolve(spellID) end

        if usedID then
            BIT.Self:OnOwnKick(usedID)
        end
    else
        -- Player cast: spellID is untainted.
        -- Check ALL_INTERRUPTS directly first, then fall back to SPELL_ALIASES
        -- (e.g. Grimoire: Fel Ravager fires as 1276467 which aliases to 132409).
        local usedID
        if BIT.ALL_INTERRUPTS[spellID] then
            usedID = spellID
        else
            local alias = BIT.SPELL_ALIASES[spellID]
            if alias and BIT.ALL_INTERRUPTS[alias] then
                usedID = alias
            end
        end
        if usedID then
            BIT.Self:OnOwnKick(usedID)
        end
        -- check SyncCD spells
        if BIT.db.showSyncCDs and BIT.SyncCD and BIT.SyncCD.OnSpellUsed then
            if BIT.debugMode then
                print("|cff0091edBIT|r |cFFAAAAAA[SyncCD]|r player cast spellID=" .. tostring(spellID))
            end
            local specIdx = GetSpecialization()
            local specID  = specIdx and select(1, GetSpecializationInfo(specIdx))
            local spells  = specID and BIT.SYNC_SPELLS and BIT.SYNC_SPELLS[specID]
            if spells then
                for _, s in ipairs(spells) do
                    local matchedSpell = nil
                    if s.id == spellID then
                        matchedSpell = s
                    elseif s.replacedBy and s.replacedBy.id == spellID then
                        matchedSpell = s.replacedBy
                    end
                    if matchedSpell then
                        local realDur = matchedSpell.cd
                        local cdFromApi = false
                        local ok, cdInfo = pcall(C_Spell.GetSpellCooldown, spellID)
                        if ok and cdInfo then
                            local ok2, safeDur = pcall(function()
                                if cdInfo.duration and cdInfo.duration > 1.5 then
                                    return tonumber(string.format("%.1f", cdInfo.duration))
                                end
                            end)
                            if ok2 and safeDur then
                                realDur  = safeDur
                                cdFromApi = true
                            end
                        end
                        -- Fallback: API unavailable (tainted) → apply talent reductions manually
                        if not cdFromApi and matchedSpell.talentMods then
                            for talentID, reduction in pairs(matchedSpell.talentMods) do
                                local okT, known = pcall(IsSpellKnown, talentID)
                                if okT and known then
                                    realDur = math.max(0, realDur - reduction)
                                end
                            end
                        end
                        if BIT.debugMode then
                            print("|cff0091edBIT|r |cFFAAAAAA[SyncCD]|r MATCH " .. tostring(matchedSpell.name or "?")
                                  .. " realDur=" .. tostring(realDur) .. " cdFromApi=" .. tostring(cdFromApi))
                        end
                        -- Charge-based spells: only start CD when ALL charges are spent.
                        -- If charges remain, just refresh the badge and skip CD tracking.
                        if matchedSpell.charges and matchedSpell.charges > 1 then
                            local ck, cCharges, _, _, cDur = pcall(C_Spell.GetSpellCharges, spellID)
                            if ck and cCharges then
                                if cCharges > 0 then
                                    if BIT.SyncCD and BIT.SyncCD.RefreshCharges then BIT.SyncCD:RefreshCharges() end
                                    break
                                elseif cDur and cDur > 1.5 then
                                    realDur = cDur  -- use actual per-charge recharge time
                                end
                            end
                        end
                        -- Don't restart if CD is already running (e.g. Alter Time recast during buff)
                        local _existing = BIT.syncCdState and BIT.syncCdState[BIT.myName]
                        if not (_existing and _existing[spellID] and _existing[spellID] > GetTime()) then
                            BIT.SyncCD:OnSpellUsed(BIT.myName, spellID, realDur)
                            BIT.Net:AnnounceSync(spellID, realDur)
                        end

                        break
                    end
                end
            end
        end
    end
end)

------------------------------------------------------------
-- Initialize
------------------------------------------------------------
function BIT:Initialize()
    BIT.UI     = BIT.UI     or {}
    BIT.Media  = BIT.Media  or {}
    BIT.Config = BIT.Config or {}

    BliZziInterruptsSavedVars     = BliZziInterruptsSavedVars     or {}
    BliZziInterruptsSavedVarsChar = BliZziInterruptsSavedVarsChar or {}
    self.db     = BliZziInterruptsSavedVars
    self.charDb = BliZziInterruptsSavedVarsChar

    for k, v in pairs(BIT.DEFAULTS) do
        if self.db[k] == nil then self.db[k] = v end
    end

    -- Per-character profile: build a stable key and load saved settings if present
    local pName  = UnitName("player") or "Unknown"
    local pRealm = GetNormalizedRealmName() or GetRealmName() or "Unknown"
    BIT.charKey  = pName .. "-" .. pRealm
    if self.db.charProfiles and self.db.charProfiles[BIT.charKey] then
        local snap = self.db.charProfiles[BIT.charKey]
        for k in pairs(BIT.DEFAULTS) do
            if snap[k] ~= nil then self.db[k] = snap[k] end
        end
        -- fontPath/fontName are not in DEFAULTS (nil default) but are saved explicitly by SaveCharProfile
        if snap.fontPath then self.db.fontPath = snap.fontPath end
        if snap.fontName then self.db.fontName = snap.fontName end
    end

    -- Remove old anchor keys; positions stored as absolute coords only
    self.db.posPoint    = nil
    self.db.posRelPoint = nil

    -- One-time migration: posX/posY global → per-char
    if self.db.posX and not self.charDb.posX then
        self.charDb.posX = self.db.posX
        self.charDb.posY = self.db.posY
    end
    self.db.posX = nil
    self.db.posY = nil

    BIT:ApplyLocale()
    BIT.Net:Register()

    -- rebuild spell name lookup with localized names
    do
        BIT.ALL_INTERRUPTS_BY_NAME = {}
        for id, v in pairs(BIT.ALL_INTERRUPTS) do
            local info = C_Spell.GetSpellInfo(id)
            local localName = info and info.name
            if localName then
                local existing = BIT.ALL_INTERRUPTS_BY_NAME[localName]
                if not existing or v.cd < existing.cd then
                    BIT.ALL_INTERRUPTS_BY_NAME[localName] = { id = id, cd = v.cd }
                end
            end
        end
    end

    BIT.Self:UpdateFromPlayer()
    BIT.Media:Load()
    BIT.UI:Create()
    if BIT.SyncCD and BIT.SyncCD.Create then BIT.SyncCD:Create() end
    C_Timer.After(0.5, function()
        if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
    end)
    BIT.UI:ApplyAutoScale()
    -- Apply saved frame scale (SetScale on mainFrame, default 100%)
    if BIT.UI.mainFrame then
        BIT.UI.mainFrame:SetScale((self.db.frameScale or 100) / 100)
    end
    BIT.Config:RegisterBlizzardOptions()

    -- register settings commands here, after category is registered (like BugSack does)
    SlashCmdList["BLIZZI"] = function()
        Settings.OpenToCategory(BIT.Config.mainCat:GetID())
    end
    SLASH_BLIZZI1 = "/blizzi"
    SLASH_BLIZZI2 = "/bitset"
    SLASH_BLIZZI3 = "/interrupts"
    SLASH_BLIZZI4 = "/bliset"
    BIT.Self:FindInterrupt()
    BIT.Rotation:Restore()

    self.ready = true

    if self.updateTicker then self.updateTicker:Cancel() end
    self.updateTicker = C_Timer.NewTicker(0.1, function()
        BIT.UI:UpdateDisplay()
        if BIT.SyncCD and BIT.SyncCD.UpdateDisplay then BIT.SyncCD:UpdateDisplay() end
    end)

    -- Periodic re-inspect to pick up spec changes
    C_Timer.NewTicker(30, function()
        if not IsInGroup() then return end
        BIT.Inspect.done = {}
        BIT.Inspect:QueueAll()
    end)

    C_Timer.After(2, function() BIT.Self:BroadcastHello() end)
end

------------------------------------------------------------
-- Main event dispatcher  (table-driven, not if/elseif)
------------------------------------------------------------
local eventHandlers = {}

eventHandlers["ADDON_LOADED"] = function(addon)
    if addon == "BliZzi_Interrupts" then BIT:Initialize() end
end

eventHandlers["PLAYER_LOGIN"] = function()
    if BIT.ready and BIT.db and not BIT.db.fontPath then
        BIT.Media:Load()
        BIT.UI:RebuildBars()
    end
    if BIT.db and BIT.db.showWelcome ~= false then
        print(string.format(BIT.L["MSG_WELCOME"] or "|cff0091edBliZzi|r|cffffa300Interrupts|r v%s — type |cFFFFD700/blizzi|r to open settings.", BIT.VERSION))
    end
end

eventHandlers["CHAT_MSG_ADDON"] = function(prefix, msg, channel, sender)
    BIT.Net:OnMessage(prefix, msg, channel, sender)
end
eventHandlers["CHAT_MSG_ADDON_LOGGED"] = eventHandlers["CHAT_MSG_ADDON"]

eventHandlers["SPELL_UPDATE_COOLDOWN"] = function()
    BIT.Self:CacheCooldown()
    BIT.UI:UpdateDisplay()
end

eventHandlers["SPELLS_CHANGED"] = function()
    BIT.Self:FindInterrupt()
    BIT.Self:BroadcastHello()
    if BIT.Self.class == "WARLOCK" then
        C_Timer.After(1.5, function() BIT.Self:FindInterrupt() end)
        C_Timer.After(3.0, function() BIT.Self:FindInterrupt() end)
    end
    if BIT.SyncCD and BIT.SyncCD.OnTalentChanged then BIT.SyncCD:OnTalentChanged() end
end

eventHandlers["PLAYER_TALENT_UPDATE"] = function()
    if BIT.SyncCD and BIT.SyncCD.OnTalentChanged then BIT.SyncCD:OnTalentChanged() end
end

eventHandlers["TRAIT_CONFIG_UPDATED"] = function()
    if BIT.SyncCD and BIT.SyncCD.OnTalentChanged then BIT.SyncCD:OnTalentChanged() end
end

eventHandlers["SPELL_UPDATE_CHARGES"] = function()
    if BIT.SyncCD and BIT.SyncCD.RefreshCharges then BIT.SyncCD:RefreshCharges() end
end

eventHandlers["PLAYER_REGEN_ENABLED"] = function()
    BIT.inCombat = false
    BIT.Self:CacheCooldown()
    BIT.UI:CheckZoneVisibility()
end

eventHandlers["PLAYER_REGEN_DISABLED"] = function()
    BIT.inCombat = true
    BIT.UI:CheckZoneVisibility()
end

eventHandlers["INSPECT_READY"] = function()
    BIT.Inspect:OnReady()
    -- spec is now set in entry.specID → rebuild SyncCD with correct spells
    C_Timer.After(0.1, function()
        if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
    end)
end

eventHandlers["PLAYER_SPECIALIZATION_CHANGED"] = function(unit)
    if unit and unit ~= "player" then
        local name = UnitName(unit)
        if name then
            BIT.Inspect:Invalidate(name)
            if not BIT.Registry:AddonUsers()[name] then return end
            local _, cls = UnitClass(unit)
            -- Use GetInspectSpecialization if available (fires slightly later
            -- than the event, so fall back to class default if 0/nil).
            -- Do NOT blindly apply CLASS_INTERRUPTS[cls] — for Druids that
            -- would randomly pick Solar Beam or Skull Bash depending on which
            -- spec was compiled first.  Instead just reset cdEnd and let the
            -- incoming inspect fill in the correct spellID.
            local specID = GetInspectSpecialization(unit)
            local entry  = BIT.Registry:GetOrCreate(name)
            entry.class  = cls
            entry.cdEnd  = 0   -- reset bar; inspect will set the right spell

            if specID and specID > 0 then
                local ov = BIT.SPEC_INTERRUPT_OVERRIDES[specID]
                if ov and not ov.isPet then
                    entry.spellID = ov.id
                    entry.baseCd  = ov.cd
                elseif BIT.SPEC_NO_INTERRUPT[specID] then
                    BIT.Registry:Remove(name)
                    BIT.Inspect.noKick[name] = true
                end
                -- extraKicks may be stale after spec change — clear them
                entry.extraKicks = {}
            end

            C_Timer.After(1, function() BIT.Inspect:QueueAll() end)
            -- spec changed → update specID in entry then rebuild SyncCD
            C_Timer.After(3, function()
                if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
            end)
        end
    end
end

eventHandlers["UNIT_PET"] = function(unit)
    if unit == "player" then
        C_Timer.After(0.5, function() BIT.Self:FindInterrupt() end)
        C_Timer.After(1.5, function() BIT.Self:FindInterrupt() end)
        C_Timer.After(3.0, function() BIT.Self:FindInterrupt() end)
    end
    BIT:RegisterPartyWatchers()
    if unit and unit:find("^party") then
        local name = UnitName(unit)
        if name then
            BIT.Inspect:Invalidate(name)
            C_Timer.After(1, function() BIT.Inspect:QueueAll() end)
        end
    end
end

eventHandlers["ROLE_CHANGED_INFORM"] = function()
    for i = 1, 4 do
        local u = "party" .. i
        if UnitExists(u) then
            local name   = UnitName(u)
            local _, cls = UnitClass(u)
            local role   = UnitGroupRolesAssigned(u)
            if name and role == "HEALER" and cls ~= "SHAMAN" and BIT.Registry:Get(name) then
                BIT.Registry:Remove(name)
                BIT.Inspect.noKick[name] = true
            end
        end
    end
end

eventHandlers["GROUP_ROSTER_UPDATE"] = function()
    BIT:CleanPartyList()
    BIT:RegisterPartyWatchers()
    BIT:AutoRegisterPartyByClass()
    C_Timer.After(1, function()
        BIT.Self:BroadcastHello()
        BIT.Self:BroadcastSyncHello()
        BIT.Inspect:QueueAll()
        if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
    end)
    C_Timer.After(5, function()
        if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end
    end)
end

eventHandlers["PLAYER_LOGOUT"] = function()
    -- Auto-save current settings + positions as this character's profile snapshot
    BIT.SaveCharProfile()
end

eventHandlers["PLAYER_ENTERING_WORLD"] = function()
    BIT.inCombat = InCombatLockdown()
    BIT.Net:Register()

    -- Clear stale healer/no-kick and inspect state on every zone transition.
    -- Specs can change between dungeons; a Holy Paladin might be Retribution next run.
    BIT.Inspect.noKick = {}
    BIT.Inspect.done   = {}
    BIT.noInterruptPlayers = BIT.Inspect.noKick
    BIT.inspectedPlayers   = BIT.Inspect.done

    BIT.UI:CheckZoneVisibility()
    BIT:RegisterPartyWatchers()
    BIT:AutoRegisterPartyByClass()

    -- Re-apply saved frame position after zone transition.
    -- WoW can reset frame anchors when loading into a new instance/area,
    -- causing the tracker to drift. A short delay lets the UI fully settle first.
    C_Timer.After(0.2, function()
        if BIT.UI.ApplyFramePosition then
            BIT.UI.ApplyFramePosition()
        end
    end)

    C_Timer.After(1, function() BIT:AutoRegisterPartyByClass() end)
    C_Timer.After(2, function() BIT.Inspect:QueueAll() end)
    C_Timer.After(3, function()
        BIT.Self:FindInterrupt()
        BIT.Self:BroadcastHello()
        BIT.Self:BroadcastSyncHello()
        BIT:AutoRegisterPartyByClass()
    end)
    -- staggered SyncCD rebuilds to catch late HELLO + inspect completion
    C_Timer.After(4,  function() if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end end)
    C_Timer.After(8,  function() if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end end)
    C_Timer.After(15, function() if BIT.SyncCD and BIT.SyncCD.Rebuild then BIT.SyncCD:Rebuild() end end)
end

local ef = CreateFrame("Frame")
ef:RegisterEvent("ADDON_LOADED")
ef:RegisterEvent("PLAYER_LOGIN")
ef:RegisterEvent("GROUP_ROSTER_UPDATE")
ef:RegisterEvent("PLAYER_ENTERING_WORLD")
ef:RegisterEvent("CHAT_MSG_ADDON")
ef:RegisterEvent("CHAT_MSG_ADDON_LOGGED")
ef:RegisterEvent("SPELL_UPDATE_COOLDOWN")
ef:RegisterEvent("SPELLS_CHANGED")
ef:RegisterEvent("PLAYER_REGEN_ENABLED")
ef:RegisterEvent("PLAYER_REGEN_DISABLED")
ef:RegisterEvent("INSPECT_READY")
ef:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
ef:RegisterEvent("PLAYER_TALENT_UPDATE")
ef:RegisterEvent("TRAIT_CONFIG_UPDATED")
ef:RegisterEvent("SPELL_UPDATE_CHARGES")
ef:RegisterEvent("UNIT_PET")
ef:RegisterEvent("ROLE_CHANGED_INFORM")
ef:RegisterEvent("PLAYER_LOGOUT")

ef:SetScript("OnEvent", function(_, event, a1, a2, a3, a4)
    local h = eventHandlers[event]
    if h then h(a1, a2, a3, a4) end
end)

------------------------------------------------------------
-- Test Mode
------------------------------------------------------------
local TEST_POOL = {
    { name="Jvyx",       class="DRUID",       spellID=106839 },
    { name="Klââsaim",   class="HUNTER",      spellID=187707 },
    { name="Kînglóuie",  class="DRUID",       spellID=106839 },
    { name="Mírajane",   class="MAGE",        spellID=2139   },
    { name="Hoschling",  class="MAGE",        spellID=2139   },
    { name="Frozenerza", class="DEATHKNIGHT", spellID=47528  },
    { name="Pandavii",   class="DEMONHUNTER", spellID=183752 },
    { name="Skytecc",    class="PALADIN",     spellID=96231  },
    { name="Wyrax",      class="WARRIOR",     spellID=6552   },
    { name="Àdrîk",     class="DRUID",       spellID=106839 },
    { name="Schmidich",  class="WARRIOR",     spellID=6552   },
    { name="Saddihunt",  class="HUNTER",      spellID=147362 },
    { name="Ragebûrn",  class="WARLOCK",     spellID=19647  },
    { name="Weebz",      class="MAGE",        spellID=2139   },
    { name="Akhíra",    class="WARLOCK",     spellID=119914 },
}

local _testSlots     = {}
local _testLoopTimer = nil

local function TestNextPlayer()
    local avail = {}
    for _, p in ipairs(TEST_POOL) do
        if not BIT.Registry:Get(p.name) then avail[#avail+1] = p end
    end
    if #avail == 0 then return TEST_POOL[math.random(1, #TEST_POOL)] end
    return avail[math.random(1, #avail)]
end

local function TestLoop()
    if not BIT.testMode then return end
    local now = GetTime()

    for i, name in ipairs(_testSlots) do
        local entry = BIT.Registry:Get(name)
        if entry then
            if entry.waitUntil then
                if now >= entry.waitUntil then
                    entry.cdEnd     = now + entry.baseCd
                    entry.waitUntil = nil
                end
            elseif now >= entry.cdEnd then
                BIT.Registry:Remove(name)
                local p    = TestNextPlayer()
                local data = BIT.ALL_INTERRUPTS[p.spellID]
                local cd   = data and data.cd or 15
                local e    = BIT.Registry:GetOrCreate(p.name)
                e.class     = p.class
                e.spellID   = p.spellID
                e.baseCd    = cd
                e.cdEnd     = now
                e.waitUntil = now + math.random(1, 6)
                _testSlots[i] = p.name
            end
        end
    end

    if now >= BIT.Self.kickCdEnd then
        BIT.Self.kickCdEnd = now + (BIT.Self.baseCd or 15)
        BIT.myKickCdEnd    = BIT.Self.kickCdEnd
    end

    BIT.UI:UpdateDisplay()
    _testLoopTimer = C_Timer.After(0.5, TestLoop)
end

function BIT:StartTestMode()
    if self.testMode then self:StopTestMode(); return end
    self.testMode = true
    self.ready    = true

    self._savedRegistry  = {}
    for k, v in pairs(BIT.Registry:All()) do self._savedRegistry[k] = v end
    self._savedSelf = {
        spellID   = BIT.Self.spellID,
        kickCdEnd = BIT.Self.kickCdEnd,
        name      = BIT.Self.name,
    }

    -- Use real player name/class so the own bar shows correctly
    local realName  = UnitName("player") or "You"
    local _, realCls = UnitClass("player")
    local testOwnSpell = BIT.Self.spellID
    local testOwnCd    = BIT.Self.baseCd or 15
    -- Fallback if no interrupt found (e.g. Holy Paladin in test)
    if not testOwnSpell then
        testOwnSpell = realCls and BIT.CLASS_INTERRUPTS[realCls] and BIT.CLASS_INTERRUPTS[realCls].id or 183752
        testOwnCd    = realCls and BIT.CLASS_INTERRUPTS[realCls] and BIT.CLASS_INTERRUPTS[realCls].cd or 15
    end

    BIT.Registry:Clear()
    _testSlots = {}
    local now = GetTime()

    local pool = {}
    for _, p in ipairs(TEST_POOL) do pool[#pool+1] = p end
    for i = #pool, 2, -1 do
        local j = math.random(1, i)
        pool[i], pool[j] = pool[j], pool[i]
    end

    for i = 1, 4 do
        local p  = pool[i]
        local d  = BIT.ALL_INTERRUPTS[p.spellID]
        local cd = d and d.cd or 15
        local e  = BIT.Registry:GetOrCreate(p.name)
        e.class   = p.class
        e.spellID = p.spellID
        e.baseCd  = cd
        if i % 2 == 0 then
            e.cdEnd = now + (cd * i / 4)
        else
            e.cdEnd     = now
            e.waitUntil = now + math.random(2, 6)
        end
        _testSlots[i] = p.name
    end

    BIT.Self.name      = realName
    BIT.Self.spellID   = testOwnSpell
    BIT.Self.baseCd    = testOwnCd
    BIT.Self.kickCdEnd = now + 8
    BIT.myName         = BIT.Self.name
    BIT.mySpellID      = BIT.Self.spellID
    BIT.myKickCdEnd    = BIT.Self.kickCdEnd

    BIT.UI:CheckZoneVisibility(true)
    _testLoopTimer = C_Timer.After(0.5, TestLoop)
    print(BIT.L["MSG_TEST_ON"])
end

function BIT:StopTestMode()
    self.testMode  = false
    _testLoopTimer = nil
    _testSlots     = {}

    BIT.Registry:Clear()
    if self._savedRegistry then
        for k, v in pairs(self._savedRegistry) do
            BIT.Registry:GetOrCreate(k)
            for field, val in pairs(v) do
                BIT.Registry:Get(k)[field] = val
            end
        end
    end

    if self._savedSelf then
        BIT.Self.spellID   = self._savedSelf.spellID
        BIT.Self.kickCdEnd = self._savedSelf.kickCdEnd
        BIT.Self.name      = self._savedSelf.name
        BIT.mySpellID      = BIT.Self.spellID
        BIT.myKickCdEnd    = BIT.Self.kickCdEnd
        BIT.myName         = BIT.Self.name
    end

    self._savedRegistry = nil
    self._savedSelf     = nil

    BIT.UI:CheckZoneVisibility()
    BIT.UI:UpdateDisplay()
    print(BIT.L["MSG_TEST_OFF"])
end

------------------------------------------------------------
-- Slash commands
------------------------------------------------------------
SLASH_BLIZZITEST1 = "/bittest"
SlashCmdList["BLIZZITEST"] = function() BIT:StartTestMode() end

SLASH_BITROTATION1 = "/bitrotation"
SlashCmdList["BITROTATION"] = function() BIT.UI:ShowRotationPanel() end

SLASH_BITPROFILE1 = "/bitprofile"
SlashCmdList["BITPROFILE"] = function() BIT.UI:ShowProfilePanel() end

SLASH_BLIZZIDEBUG1 = "/bitdebug"
SlashCmdList["BLIZZIDEBUG"] = function()
    BIT.debugMode = not BIT.debugMode
    if BIT.debugMode then
        print(BIT.L["MSG_DEBUG_ON"])
        local count = 0
        for _ in pairs(BIT.Registry:All()) do count = count + 1 end
        print(BIT.L["MSG_DEBUG_PARTY"] .. " " .. count)
        for name, info in pairs(BIT.Registry:All()) do
            print("  |cFFAAAAFF" .. name .. "|r " .. tostring(info.class)
                  .. " sid=" .. tostring(info.spellID)
                  .. " baseCd=" .. tostring(info.baseCd))
        end
    else
        print(BIT.L["MSG_DEBUG_OFF"])
    end
end
