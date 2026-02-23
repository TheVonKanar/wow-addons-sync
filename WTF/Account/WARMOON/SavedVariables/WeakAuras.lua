
WeakAurasSaved = {
["editor_tab_spaces"] = 4,
["displays"] = {
["Tyfon's Character Sheet"] = {
["iconSource"] = -1,
["xOffset"] = 0,
["preferToUpdate"] = true,
["yOffset"] = 0,
["anchorPoint"] = "TOPLEFT",
["displayText_format_p_time_format"] = 0,
["url"] = "https://wago.io/7ozlvrh_H/20",
["actions"] = {
["start"] = {
["do_sound"] = false,
},
["init"] = {
["custom"] = "local aura_env = aura_env\nlocal _G = _G\n\naura_env.characterOpen = false;\n\n-- itemIDs for async loading\naura_env.itemInfoRequested = {}\n\n-- Hooking NotifyInspect to remember the unit last inspected\n-- This will be used async when INSPECT_READY is called\naura_env.inspecting = false;\naura_env.lastInspectUnit = nil\naura_env.lastInspectGuid = nil\n\nhooksecurefunc(\"NotifyInspect\", function(unit)\n    --print(\"NotifyInspect: \" .. unit .. \" (\" .. UnitGUID(unit) .. \")\")\n\n    -- don't run on mouseover\n    if (unit == \"mouseover\") then return end\n\n    -- there's some weird thing where inspect is called on yourself? Ignore these\n    if (unit == GetUnitName(\"player\")) then return end\n\n    aura_env.lastInspectUnit = unit\n    aura_env.lastInspectGuid = UnitGUID(unit)\nend)\n\n-- Get the name of the item frame\nlocal getSlotFrameName = function(unit, slot)\n    local slotName\n    local prefix = \"Inspect\"\n    if (unit == \"player\") then\n        prefix = \"Character\"\n    end\n\n    if (slot == 1) then\n        slotName = \"Head\"\n    elseif (slot == 2) then\n        slotName = \"Neck\"\n    elseif (slot == 3) then\n        slotName = \"Shoulder\"\n    elseif (slot == 4) then\n        slotName = \"Shirt\"\n    elseif (slot == 5) then\n        slotName = \"Chest\"\n    elseif (slot == 6) then\n        slotName = \"Waist\"\n    elseif (slot == 7) then\n        slotName = \"Legs\"\n    elseif (slot == 8) then\n        slotName = \"Feet\"\n    elseif (slot == 9) then\n        slotName = \"Wrist\"\n    elseif (slot == 10) then\n        slotName = \"Hands\"\n    elseif (slot == 11) then\n        slotName = \"Finger0\"\n    elseif (slot == 12) then\n        slotName = \"Finger1\"\n    elseif (slot == 13) then\n        slotName = \"Trinket0\"\n    elseif (slot == 14) then\n        slotName = \"Trinket1\"\n    elseif (slot == 15) then\n        slotName = \"Back\"\n    elseif (slot == 16) then\n        slotName = \"MainHand\"\n    elseif (slot == 17) then\n        slotName = \"SecondaryHand\"\n    elseif (slot == 19) then\n        slotName = \"Tabard\"\n    else\n        return nil\n    end\n\n    return prefix .. slotName .. \"Slot\"\nend\n\n-- Returns true if the slot is on the right side of the character panel\nlocal isRightSide = function(slot)\n    if (slot == 6 or slot == 7 or slot == 8 or slot == 10 or slot == 11 or slot == 12 or slot == 13 or slot == 14 or\n            slot == 16) then\n        return true\n    end\n    return false\nend\n\nlocal fontMap = {\n    nil, -- none\n    \"OUTLINE\",\n    \"THICKOUTLINE\",\n    nil -- drop shadow\n}\n\nlocal getRarityColor = function(level)\n    if (level < 623) then return \"FFFFFFFF\" end\n    if (level < 636) then return \"FF1EFF00\" end\n    if (level < 649) then return \"FF0070DD\" end\n    if (level < 662) then return \"FFA335EE\" end\n    return \"FFFF8000\"\nend\n\n-- Update a Specific Slot\naura_env.updateSlot = function(unit, slot)\n    if (unit == nil or slot == nil) then\n        return\n    end\n\n    local itemLink = GetInventoryItemLink(unit, slot)\n    local slotFrameName = getSlotFrameName(unit, slot)\n    if (slotFrameName == nil or _G[slotFrameName] == nil) then return end\n\n    local rightSide = isRightSide(slot)\n    local framePoint = rightSide and \"RIGHT\" or \"LEFT\"\n    local parentPoint = rightSide and \"LEFT\" or \"RIGHT\"\n    local offsetX = rightSide and -10 or 9\n\n    local LevelText = _G[slotFrameName .. \"TyIlvl\"]\n    local AverageLevelText = _G[\"TyAvgIlvl\"]\n    local EnchantText = _G[slotFrameName .. \"TyEnchant\"]\n    local GemFrames = {}\n    for i = 1, 3 do\n        GemFrames[i] = _G[slotFrameName .. \"TyGem\" .. i]\n    end\n\n    -- create and position frames if they don't exist\n    if (LevelText == nil) then\n        LevelText = _G[slotFrameName]:CreateFontString(slotFrameName .. \"TyIlvl\", \"ARTWORK\", \"GameTooltipText\")\n        if (slot == 16 or slot == 17) then -- weapons put the ilvl on top\n            LevelText:SetPoint(\"BOTTOM\", _G[slotFrameName], \"TOP\", 0, 5)\n        else\n            LevelText:SetPoint(framePoint, _G[slotFrameName], parentPoint, offsetX, 0)\n        end\n    end\n\n    if (_G[\"InspectModelFrame\"] ~= nil) then\n        if (AverageLevelText == nil) then\n            AverageLevelText = _G[\"InspectModelFrame\"]:CreateFontString(\"TyAvgIlvl\", \"OVERLAY\", \"GameTooltipText\")\n        end\n\n        if (aura_env.config.items.showAverage) then\n            AverageLevelText:SetPoint(\"TOP\", _G[\"InspectModelFrame\"], \"TOP\", 0, -5)\n\n            if (aura_env.config.items.fontOutline == 4) then\n                AverageLevelText:SetShadowColor(0, 0, 0)\n                AverageLevelText:SetShadowOffset(0, 0)\n                AverageLevelText:SetShadowOffset(1, -1)\n            end\n            local avgLevelFont = AverageLevelText:GetFont()\n            AverageLevelText:SetFont(avgLevelFont, aura_env.config.items.fontSize,\n                fontMap[aura_env.config.items.fontOutline])\n\n            local averageLevel = C_PaperDollInfo.GetInspectItemLevel(unit)\n            local rarityColor = getRarityColor(averageLevel)\n            AverageLevelText:SetText(\"|c\" .. rarityColor .. averageLevel .. \"|r\")\n            AverageLevelText:Show()\n        else\n            AverageLevelText:SetText(\"\")\n            AverageLevelText:Hide()\n        end\n    end\n\n    if (EnchantText == nil) then\n        EnchantText = _G[slotFrameName]:CreateFontString(slotFrameName .. \"TyEnchant\", \"ARTWORK\", \"GameTooltipText\")\n        EnchantText:SetPoint(framePoint, _G[slotFrameName], parentPoint, offsetX, -12)\n    end\n\n    -- set up gems\n    local ilvlSpacingX = 27 * (aura_env.config.items.fontSize / 12);\n    for i = 1, 3 do\n        if (GemFrames[i] == nil) then\n            GemFrames[i] = CreateFrame(\"Button\", slotFrameName .. \"TyGem\" .. i, _G[slotFrameName],\n                \"UIPanelButtonTemplate\")\n            GemFrames[i]:SetSize(14, 14)\n        end\n        if (slot == 16 or slot == 17) then\n            GemFrames[i]:SetPoint(\"BOTTOM\", _G[slotFrameName], \"TOP\", -14 + (15 * (i - 1)), 18)\n        else\n            local gemOffsetX = rightSide and offsetX - (15 * (i - 1)) or offsetX + (15 * (i - 1))\n            if (aura_env.config.items.enabled) then\n                gemOffsetX = rightSide and gemOffsetX - ilvlSpacingX or gemOffsetX + ilvlSpacingX\n            end\n            GemFrames[i]:SetPoint(framePoint, _G[slotFrameName], parentPoint, gemOffsetX, 0)\n        end\n    end\n\n    -- clear all if no item equipped\n    if (itemLink == nil or itemLink == \"\") then\n        LevelText:SetText(\"\")\n        EnchantText:SetText(\"\")\n        for i = 1, 3 do\n            GemFrames[i]:Hide()\n        end\n        return\n    end\n\n    -- get item information\n    local _, _, itemQuality, itemLevel = C_Item.GetItemInfo(itemLink)\n    if (itemLevel == nil) then\n        local itemId = C_Item.GetItemInfoInstant(itemLink)\n        aura_env.itemInfoRequested[itemId] = { unit = unit, slot = slot }\n        return\n    end\n\n    -- need to parse tooltip for full item info\n    local ItemTooltip = _G[\"TyScanningTooltip\"] or\n        CreateFrame(\"GameTooltip\", \"TyScanningTooltip\", WorldFrame, \"GameTooltipTemplate\") --[[@as GameTooltip]]\n    ItemTooltip:SetOwner(WorldFrame, \"ANCHOR_NONE\");\n    ItemTooltip:ClearLines()\n    ItemTooltip:SetHyperlink(itemLink)\n    local enchant = \"\"\n    for i = 1, ItemTooltip:NumLines() do\n        local foundEnchant = _G[\"TyScanningTooltipTextLeft\" .. i]:GetText():match(ENCHANTED_TOOLTIP_LINE:gsub(\"%%s\",\n            \"(.+)\"))\n        if foundEnchant then\n            enchant = foundEnchant\n        end\n\n        local foundLevel = _G[\"TyScanningTooltipTextLeft\" .. i]:GetText():match(ITEM_LEVEL:gsub(\"%%d\", \"(%%d+)\"))\n        if foundLevel then\n            itemLevel = foundLevel\n        end\n    end\n\n    -- set iLvl\n    if (aura_env.config.items.enabled) then\n        local levelFont = LevelText:GetFont()\n        LevelText:SetFont(levelFont, aura_env.config.items.fontSize, fontMap[aura_env.config.items.fontOutline])\n        if (aura_env.config.items.fontOutline == 4) then\n            LevelText:SetShadowColor(0, 0, 0)\n            LevelText:SetShadowOffset(0, 0)\n            LevelText:SetShadowOffset(1, -1)\n        end\n\n        local colorInfo = ColorManager.GetColorDataForItemQuality(itemQuality)\n        LevelText:SetText(colorInfo.hex .. itemLevel .. \"|r\")\n        LevelText:Show()\n    else\n        LevelText:Hide()\n    end\n\n    -- set enchant\n    if (aura_env.config.enchants.enabled) then\n        if (aura_env.config.enchants.fontOutline == 4) then\n            EnchantText:SetShadowColor(0, 0, 0)\n            EnchantText:SetShadowOffset(0, 0)\n            EnchantText:SetShadowOffset(1, -1)\n        end\n        local enchantFont = EnchantText:GetFont()\n        EnchantText:SetFont(enchantFont, aura_env.config.enchants.fontSize, fontMap\n            [aura_env.config.enchants.fontOutline])\n\n        local color = \"FF00FF00\"\n\n        -- find and strip existing color\n        local newColor, coloredEnchant = enchant:match(\"|c(%x%x%x%x%x%x%x%x)(.+)|r\") -- hex codes\n        if (coloredEnchant == nil) then\n            newColor, coloredEnchant = enchant:match(\"|c(n.+:)(.+)|r\")               -- named color\n        end\n        if (coloredEnchant) then\n            color = newColor\n            enchant = coloredEnchant\n        end\n\n        -- need to check for quality symbols\n        local qualityStart = string.find(enchant, \"|A\")\n        local quality = \"\"\n        if (qualityStart) then\n            quality = string.sub(enchant, qualityStart)\n            enchant = string.sub(enchant, 1, qualityStart - 1)\n        end\n\n        local maxLength = aura_env.config.enchants.maxLength\n        if (maxLength > 0 and strlen(enchant) > maxLength) then\n            enchant = format(\"%.\" .. maxLength .. \"s\", enchant) .. \"...\"\n        end\n        if (aura_env.config.enchants.showQuality) then\n            enchant = enchant .. quality;\n        end\n        EnchantText:SetText(\"|c\" .. color .. enchant .. \"|r\")\n        EnchantText:Show()\n    else\n        EnchantText:Hide()\n    end\n\n    -- set gems\n    local gemCount = C_Item.GetItemNumSockets(itemLink)\n    for i = 1, 3 do\n        if (aura_env.config.gems.enabled and i <= gemCount) then\n            local gemId = C_Item.GetItemGemID(itemLink, i)\n            if (gemId ~= nil) then\n                local gem = Item:CreateFromItemID(gemId);\n\n                -- Gem may not be loaded even if the item is, load async\n                gem:ContinueOnItemLoad(function()\n                    local gemIcon = C_Item.GetItemIconByID(gemId);\n                    local _, gemLink = C_Item.GetItemInfo(gemId)\n                    GemFrames[i]:SetNormalTexture(gemIcon)\n                    GemFrames[i]:SetScript(\"OnEnter\", function()\n                        GameTooltip:SetOwner(GemFrames[i], \"ANCHOR_CURSOR\")\n                        GameTooltip:SetHyperlink(gemLink)\n                        GameTooltip:Show()\n                    end);\n                    GemFrames[i]:SetScript(\"OnLeave\", function()\n                        GameTooltip:Hide()\n                    end)\n                    GemFrames[i]:Show()\n                end)\n            else\n                GemFrames[i]:SetNormalTexture(\"Interface\\\\ITEMSOCKETINGFRAME\\\\UI-EmptySocket-Prismatic.blp\")\n                GemFrames[i]:SetScript(\"OnEnter\", nil)\n                GemFrames[i]:SetScript(\"OnLeave\", nil)\n                GemFrames[i]:Show()\n            end\n        else\n            GemFrames[i]:Hide()\n        end\n    end\nend\n\n-- loop all slots\naura_env.updateAllSlots = function(unit)\n    --print(\"Updating all slots: \" .. unit)\n    for slot = 1, 19 do\n        aura_env.updateSlot(unit, slot)\n    end\nend\n\n-- instead of using triggers, just run when the character frame is shown\nlocal paperDollFrame = _G[\"PaperDollFrame\"]\npaperDollFrame:HookScript(\"OnShow\", function(self)\n    if (not aura_env.characterOpen) then -- OnShow can be called multiple times?\n        aura_env.updateAllSlots(\"player\")\n    end\n\n    aura_env.characterOpen = true\nend)\n\npaperDollFrame:HookScript(\"OnHide\", function(self)\n    aura_env.characterOpen = false\nend)\n\n-- inspect is delay loaded, but we can hook functions instead\nlocal inspectHooked = false;\nhooksecurefunc(\"InspectFrame_LoadUI\", function()\n    if (not inspectHooked) then\n        local inspectPaperDollFrame = _G[\"InspectPaperDollFrame\"]\n        inspectPaperDollFrame:HookScript(\"OnHide\", function(self)\n            aura_env.inspecting = false\n        end)\n        inspectHooked = true\n    end\n\n    aura_env.inspecting = true;\nend)\n",
["do_custom"] = true,
},
["finish"] = {
},
},
["keepAspectRatio"] = false,
["selfPoint"] = "TOPLEFT",
["desaturate"] = false,
["font"] = "Friz Quadrata TT",
["load"] = {
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["shadowXOffset"] = 1,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["cooldownTextDisabled"] = false,
["tocversion"] = 110002,
["alpha"] = 1,
["uid"] = "47B(rNQD9yO",
["displayIcon"] = 134154,
["outline"] = "OUTLINE",
["wagoID"] = "7ozlvrh_H",
["color"] = {
1,
1,
1,
1,
},
["adjustedMin"] = "",
["shadowYOffset"] = -1,
["cooldownSwipe"] = true,
["customTextUpdate"] = "event",
["cooldownEdge"] = false,
["triggers"] = {
{
["trigger"] = {
["custom_hide"] = "timed",
["type"] = "custom",
["use_absorbHealMode"] = true,
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["use_absorbMode"] = true,
["event"] = "Unit Characteristics",
["use_unit"] = true,
["unit"] = "player",
["custom"] = "function(event, arg1)\n    if (aura_env == nil) then\n        return true;\n    end\n\n    if (event == \"PLAYER_EQUIPMENT_CHANGED\" and aura_env.characterOpen and arg1 ~= nil) then -- An equipment slot is changed\n        --print(\"Updating player slot \"..arg1)\n        aura_env.updateSlot(\"player\", arg1)\n        return true\n    elseif (event == \"INSPECT_READY\" and aura_env.inspecting and arg1 == aura_env.lastInspectGuid) then -- Fired, possibly multiple times, when inspect data is ready\n        --print(\"INSPECT_READY: \"..arg1)\n\n        if (aura_env.inspecting and arg1 == aura_env.lastInspectGuid) then\n            aura_env.updateAllSlots(aura_env.lastInspectUnit)\n        end\n        return true\n    elseif (event == \"GET_ITEM_INFO_RECEIVED\" and aura_env.itemInfoRequested[arg1] ~= nil) then -- GetItemInfo for uncached item data is ready\n        local request = aura_env.itemInfoRequested[arg1]\n        aura_env.itemInfoRequested[arg1] = nil\n        if (aura_env.characterOpen) then\n            --print(\"Updating \"..request.unit..\" slot \"..request.slot)\n            aura_env.updateSlot(request.unit, request.slot)\n        end\n        return true\n    elseif (event == \"UNIT_INVENTORY_CHANGED\" and arg1 == \"player\" and aura_env.characterOpen) then -- needed for item enchants\n        aura_env.updateAllSlots(arg1)\n        return true\n    end\nend\n",
["spellIds"] = {
},
["events"] = "PLAYER_EQUIPMENT_CHANGED, INSPECT_READY, GET_ITEM_INFO_RECEIVED, UNIT_INVENTORY_CHANGED",
["check"] = "event",
["names"] = {
},
["custom_type"] = "event",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
["custom"] = "",
},
},
["activeTriggerMode"] = -10,
},
["displayText_format_p_format"] = "timed",
["internalVersion"] = 88,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["version"] = 20,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 14,
["useAdjustededMax"] = false,
["fontSize"] = 12,
["source"] = "import",
["anchorFrameFrame"] = "PaperDollFrame",
["adjustedMax"] = "",
["authorOptions"] = {
{
["type"] = "description",
["text"] = "Tyfon's Character Sheet",
["fontSize"] = "large",
["width"] = 1,
},
{
["useName"] = false,
["type"] = "header",
["text"] = "",
["width"] = 1,
},
{
["type"] = "space",
["variableWidth"] = true,
["height"] = 1,
["width"] = 1,
["useHeight"] = false,
},
{
["subOptions"] = {
{
["type"] = "toggle",
["key"] = "enabled",
["default"] = true,
["useDesc"] = false,
["name"] = "Enabled",
["width"] = 1,
},
{
["type"] = "toggle",
["key"] = "showAverage",
["default"] = true,
["useDesc"] = false,
["name"] = "Show average inspect level",
["width"] = 1,
},
{
["type"] = "range",
["useDesc"] = false,
["max"] = 20,
["step"] = 1,
["width"] = 1,
["min"] = 1,
["key"] = "fontSize",
["name"] = "Font size",
["default"] = 12,
},
{
["type"] = "select",
["values"] = {
"None",
"Outline",
"Thick Outline",
"Shadow",
},
["default"] = 4,
["key"] = "fontOutline",
["useDesc"] = false,
["name"] = "Font outline",
["width"] = 1,
},
},
["hideReorder"] = true,
["useDesc"] = false,
["nameSource"] = 0,
["collapse"] = false,
["width"] = 1,
["useCollapse"] = true,
["noMerge"] = false,
["name"] = "Item levels",
["key"] = "items",
["limitType"] = "none",
["groupType"] = "simple",
["type"] = "group",
["size"] = 10,
},
{
["type"] = "space",
["variableWidth"] = true,
["height"] = 1,
["width"] = 1,
["useHeight"] = false,
},
{
["useName"] = false,
["type"] = "header",
["text"] = "",
["width"] = 1,
},
{
["type"] = "space",
["variableWidth"] = true,
["height"] = 1,
["width"] = 1,
["useHeight"] = false,
},
{
["subOptions"] = {
{
["type"] = "toggle",
["key"] = "enabled",
["default"] = true,
["useDesc"] = false,
["name"] = "Enabled",
["width"] = 2,
},
{
["type"] = "toggle",
["key"] = "showQuality",
["default"] = false,
["useDesc"] = false,
["name"] = "Show quality",
["width"] = 1,
},
{
["type"] = "range",
["useDesc"] = true,
["max"] = 100,
["step"] = 1,
["width"] = 1,
["min"] = 0,
["key"] = "maxLength",
["desc"] = "Truncates the enchant description to prevent ugly overlaps. Set to 0 to disable truncation.",
["name"] = "Max display length",
["default"] = 18,
},
{
["type"] = "range",
["useDesc"] = false,
["max"] = 20,
["step"] = 1,
["width"] = 1,
["min"] = 1,
["key"] = "fontSize",
["name"] = "Font size",
["default"] = 10,
},
{
["type"] = "select",
["values"] = {
"None",
"Outline",
"Thick Outline",
"Shadow",
},
["default"] = 4,
["key"] = "fontOutline",
["useDesc"] = false,
["name"] = "Font outline",
["width"] = 1,
},
},
["hideReorder"] = true,
["useDesc"] = false,
["nameSource"] = 0,
["collapse"] = false,
["width"] = 1,
["useCollapse"] = true,
["noMerge"] = false,
["name"] = "Enchants",
["key"] = "enchants",
["limitType"] = "none",
["groupType"] = "simple",
["type"] = "group",
["size"] = 10,
},
{
["type"] = "space",
["variableWidth"] = true,
["height"] = 1,
["width"] = 1,
["useHeight"] = false,
},
{
["useName"] = false,
["type"] = "header",
["text"] = "",
["width"] = 1,
},
{
["type"] = "space",
["variableWidth"] = true,
["height"] = 1,
["width"] = 1,
["useHeight"] = false,
},
{
["subOptions"] = {
{
["type"] = "toggle",
["key"] = "enabled",
["default"] = true,
["useDesc"] = false,
["name"] = "Enabled",
["width"] = 1,
},
},
["hideReorder"] = true,
["useDesc"] = false,
["nameSource"] = 0,
["collapse"] = false,
["width"] = 1,
["useCollapse"] = true,
["noMerge"] = false,
["name"] = "Gems",
["key"] = "gems",
["limitType"] = "none",
["groupType"] = "simple",
["type"] = "group",
["size"] = 10,
},
{
["type"] = "space",
["variableWidth"] = true,
["height"] = 1,
["width"] = 1,
["useHeight"] = false,
},
},
["displayText_format_p_time_dynamic_threshold"] = 60,
["information"] = {
["forceEvents"] = false,
},
["icon"] = true,
["displayText_format_p_time_precision"] = 1,
["wordWrap"] = "WordWrap",
["zoom"] = 0,
["automaticWidth"] = "Auto",
["justify"] = "LEFT",
["frameStrata"] = 1,
["id"] = "Tyfon's Character Sheet",
["displayText"] = "%p",
["useCooldownModRate"] = true,
["width"] = 14,
["semver"] = "1.4.1",
["anchorFrameType"] = "SELECTFRAME",
["inverse"] = false,
["fixedWidth"] = 200,
["shadowColor"] = {
0,
0,
0,
1,
},
["conditions"] = {
},
["cooldown"] = false,
["config"] = {
["items"] = {
["enabled"] = true,
["fontSize"] = 12,
["showAverage"] = true,
["fontOutline"] = 4,
},
["gems"] = {
["enabled"] = true,
},
["enchants"] = {
["enabled"] = true,
["fontSize"] = 7,
["fontOutline"] = 4,
["showQuality"] = true,
["maxLength"] = 12,
},
},
},
["[UI] Flying Speed"] = {
["user_y"] = 0,
["iconSource"] = -1,
["user_x"] = 0,
["authorOptions"] = {
},
["preferToUpdate"] = true,
["yOffset"] = -2.7743251337612e-05,
["foregroundColor"] = {
0.80784320831299,
0.94117653369904,
1,
1,
},
["displayText_format_p_time_format"] = 0,
["sameTexture"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["icon"] = false,
["icon_color"] = {
1,
1,
1,
1,
},
["wordWrap"] = "WordWrap",
["barColor"] = {
0.30196079611778,
0.63921570777893,
0.7607843875885,
1,
},
["desaturate"] = false,
["rotation"] = 0,
["font"] = "Friz Quadrata TT",
["sparkOffsetY"] = 0,
["load"] = {
["ingroup"] = {
},
["use_zoneIds"] = false,
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["itemtypeequipped"] = {
},
["instance_type"] = {
},
["difficulty"] = {
["single"] = "timewalking",
["multi"] = {
},
},
["use_dragonriding"] = true,
["use_never"] = false,
["use_spellknown"] = false,
["class"] = {
["multi"] = {
},
},
["zoneIds"] = "1978, 2022, 2023, 2024, 2025, 2112, 2093",
["spellknown"] = 372610,
["size"] = {
["single"] = "none",
["multi"] = {
["none"] = true,
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["foregroundTexture"] = "ui-storm-headerfill",
["shadowXOffset"] = 1,
["smoothProgress"] = true,
["useAdjustededMin"] = true,
["regionType"] = "progresstexture",
["blendMode"] = "ADD",
["slantMode"] = "INSIDE",
["texture"] = "Solid",
["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
["spark"] = false,
["tocversion"] = 100002,
["alpha"] = 1,
["auraRotation"] = 0,
["fixedWidth"] = 200,
["backgroundOffset"] = 2,
["outline"] = "OUTLINE",
["crop_y"] = 0.41,
["sparkOffsetX"] = 0,
["wagoID"] = "K-P_CgDIP",
["parent"] = "[UI] Skyriding",
["color"] = {
1,
1,
1,
1,
},
["adjustedMin"] = "0",
["shadowYOffset"] = -1,
["crop_x"] = 0.41,
["desaturateBackground"] = false,
["shadowColor"] = {
0,
0,
0,
1,
},
["sparkRotationMode"] = "AUTO",
["customTextUpdate"] = "event",
["automaticWidth"] = "Auto",
["desaturateForeground"] = false,
["triggers"] = {
{
["trigger"] = {
["type"] = "custom",
["subeventSuffix"] = "_CAST_START",
["debuffType"] = "HELPFUL",
["custom"] = "function(...)\n    return aura_env.trigger1(...)\nend",
["event"] = "Health",
["unit"] = "player",
["customDuration"] = "function()\n    return aura_env.smooth_delta + 0.5, 1, true\nend",
["events"] = "PLAYER_MOUNT_DISPLAY_CHANGED, MOUNT_JOURNAL_USABILITY_CHANGED, LEARNED_SPELL_IN_TAB, UNIT_SPELLCAST_SUCCEEDED:player, DMUI_DRAGONRIDING_UPDATE, VEHICLE_ANGLE_UPDATE",
["spellIds"] = {
},
["names"] = {
},
["check"] = "event",
["subeventPrefix"] = "SPELL",
["custom_type"] = "stateupdate",
["customVariables"] = "{\n    value = \"number\",\n    delta = \"number\",\n    thrill = \"bool\",\n}",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_unit"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["customTriggerLogic"] = "function(t) return (t[2] or t[3]) and t[4] end",
["activeTriggerMode"] = 1,
},
["endAngle"] = 180,
["displayText_format_p_time_legacy_floor"] = false,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["colorR"] = 0.74901962280273,
["scalex"] = 1,
["colorA"] = 1,
["colorG"] = 0,
["type"] = "none",
["easeType"] = "none",
["scaley"] = 1,
["alpha"] = 0,
["use_color"] = false,
["y"] = 0,
["colorType"] = "custom",
["x"] = 0,
["rotate"] = 0,
["colorFunc"] = "function(_, r1, g1, b1, a1, r2, g2, b2, a2)\n    local progress = 1 - math.min(1, math.max(aura_env.smooth_accel + 0.5, 0))\n    if not aura_env.boosting then\n        return WeakAuras.GetHSVTransition(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n    else\n        return r1, g1, b1, a1\n    end\nend",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["colorB"] = 0.015686275437474,
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["zoom"] = 0,
["selfPoint"] = "CENTER",
["anchorPoint"] = "TOP",
["anchorFrameType"] = "SCREEN",
["adjustedMax"] = "100%",
["sparkWidth"] = 10,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_text_format_p_time_precision"] = 1,
["text_text_format_1.speedtext_format"] = "none",
["text_shadowColor"] = {
0,
0,
0,
1,
},
["text_fixedWidth"] = 64,
["text_text_format_1.p_time_format"] = 0,
["text_text_format_p_time_legacy_floor"] = false,
["rotateText"] = "NONE",
["text_text_format_p_decimal_precision"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_shadowYOffset"] = -2,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "None",
["text_fontSize"] = 18,
["anchorXOffset"] = 0,
["text_text_format_p_round_type"] = "floor",
["text_text_format_n_format"] = "none",
["text_text_format_1.p_time_legacy_floor"] = false,
["text_text_format_.speedtext_format"] = "none",
["text_text_format_p_time_mod_rate"] = true,
["text_selfPoint"] = "CENTER",
["text_text_format_1.speedtext1600_format"] = "none",
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["text_text_format_1.p_time_precision"] = 1,
["text_visible"] = true,
["type"] = "subtext",
["text_anchorXOffset"] = 2,
["text_text_format_p_format"] = "Number",
["text_font"] = "Fira Mono Medium",
["text_shadowXOffset"] = 2,
["text_anchorYOffset"] = 6,
["text_text_format_1.p_time_dynamic_threshold"] = 60,
["text_automaticWidth"] = "Auto",
["text_text_format_1.speedtexttoto_format"] = "none",
["text_text_format_1.p_format"] = "timed",
["text_text_format_p_time_format"] = 0,
["anchor_point"] = "CENTER",
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_1.p_time_mod_rate"] = true,
["text_text"] = "%1.speedtext",
},
},
["height"] = 138,
["id"] = "[UI] Flying Speed",
["sparkColor"] = {
1,
1,
1,
1,
},
["sparkBlendMode"] = "ADD",
["useAdjustededMax"] = true,
["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
["source"] = "import",
["justify"] = "LEFT",
["backgroundColor"] = {
0,
0,
0,
0,
},
["displayText_format_p_format"] = "timed",
["mirror"] = false,
["anchorFrameFrame"] = "WeakAuras:Dragonriding UI Pitch",
["sparkRotation"] = 0,
["sparkHeight"] = 30,
["displayText_format_p_time_precision"] = 1,
["icon_side"] = "RIGHT",
["config"] = {
},
["actions"] = {
["start"] = {
["custom"] = "",
["do_custom"] = false,
},
["finish"] = {
["custom"] = "\n    EncounterBar:Show()",
["do_custom"] = true,
},
["init"] = {
["custom"] = "---- Parameters ----\n\nlocal mountEvents = {\n    [\"PLAYER_MOUNT_DISPLAY_CHANGED\"] = true,\n    [\"MOUNT_JOURNAL_USABILITY_CHANGED\"] = true,\n    [\"LEARNED_SPELL_IN_TAB\"] = true,\n}\n\nlocal ascentSpell = 372610\nlocal thrillBuff = 377234\nlocal thrillSpeed = 60\nlocal maxSamples = 5\nlocal ascentDuration = 3.5\nlocal ascentBoostMax = 35\nlocal pollRate = 1 / 10\nlocal updatePeriod = 1 / 10\nlocal speedTextFormat, speedTextFactor = \"%.0f%%\", 100 / 7\n\n---- Variables ----\n\nlocal active = false\nlocal updateHandle = nil\nlocal ascentStart = 0\nlocal lastX, lastY, lastT = 0, 0, 0\nlocal samples = 0\nlocal skipped = false\nlocal smoothSpeed, smoothGSpeed, lastSpeed = 0, 0, 0\n\n---- Localized functions ----\n\nlocal ScanEvents = WeakAuras.ScanEvents\nlocal GetTime = GetTime\nlocal After = C_Timer.After\nlocal GetBestMapForUnit = C_Map.GetBestMapForUnit\nlocal GetPlayerMapPosition = C_Map.GetPlayerMapPosition\nlocal GetMapWorldSize = C_Map.GetMapWorldSize\n\n---- Trigger 1 ----\n\n-- Events:\n--   PLAYER_MOUNT_DISPLAY_CHANGED\n--   MOUNT_JOURNAL_USABILITY_CHANGED\n--   LEARNED_SPELL_IN_TAB\n--   UNIT_SPELLCAST_SUCCEEDED:player\n--   DMUI_DRAGONRIDING_UPDATE\n\nlocal function setActive(allstates, state)\n    active = state\n    After(0, function()\n            ScanEvents(\"DMUI_DRAGONRIDING_SHOW\", state)\n    end)\n    \n    if active then\n        \n        if not updateHandle then\n            updateHandle = C_Timer.NewTicker(pollRate, function()\n                    if active then\n                        ScanEvents(\"DMUI_DRAGONRIDING_UPDATE\", true)\n                    end\n            end)\n        end\n        \n        if not allstates[\"\"] then\n            allstates[\"\"] = {\n                show = true,\n                changed = true,\n                progressType = \"static\",\n                value = 0,\n                accel = 0,\n                total = 100,\n                thrill = false,\n                speedtext = \"\",\n            }\n            return true\n        end\n    else\n        if updateHandle then\n            updateHandle:Cancel()\n            updateHandle = nil\n        end\n        \n        if allstates[\"\"] then\n            allstates[\"\"].show = false\n            allstates[\"\"].changed = true\n            return true\n        end\n    end\nend\n\naura_env.trigger1 = function(allstates, event, _, _, spellId)\n    \n    if event ~= \"DMUI_DRAGONRIDING_UDPATE\" then\n        \n        -- Ensure ticker is stopped on opening WA options\n        if event == \"OPTIONS\" then\n            return setActive(allstates, false)\n        end\n        \n        -- Detect dragonriding start/end\n        if mountEvents[event] then\n            if IsMounted() then\n                for _, mountId in ipairs(C_MountJournal.GetCollectedDragonridingMounts()) do\n                    if select(4, C_MountJournal.GetMountInfoByID(mountId)) then\n                        return setActive(allstates, true)\n                    end\n                end\n            end\n            return setActive(allstates, false)\n        end\n        \n        -- Detect ascent boost\n        if event == \"UNIT_SPELLCAST_SUCCEEDED\" then\n            if spellId == ascentSpell then\n                ascentStart = GetTime()\n            end\n            return false\n        end\n    end\n    \n    local time = GetTime()\n    \n    -- Delta time\n    local dt = time - lastT\n    if dt < updatePeriod then\n        -- Rate limit speed updates!\n        return false\n    end\n    lastT = time\n    \n    if not allstates or not allstates[\"\"] then return false end\n    \n    -- Compute accurate speed if possible\n    local instanced = true\n    local speed, groundSpeed = 0, 0\n    local map = GetBestMapForUnit(\"player\")\n    if map then\n        local position = GetPlayerMapPosition(map, \"player\")\n        if position then\n            instanced = false\n            \n            -- Delta position\n            local x, y = position.x, position.y\n            local w, h = GetMapWorldSize(map)\n            x = x * w\n            y = y * h\n            local dx = x - lastX\n            local dy = y - lastY\n            lastX = x\n            lastY = y\n            \n            -- Compute horizontal speed and adjust for pitch\n            groundSpeed = math.sqrt(dx * dx + dy * dy) / dt\n            if groundSpeed > 0 then\n                local cosTheta = math.cos(math.abs(0))\n                if cosTheta > 0 then\n                    speed = groundSpeed / cosTheta\n                end\n            end\n        end\n    end\n    \n    -- Ignore obviously invalid speeds that occur when jumping zones\n    if speed > 150 then\n        return false\n    end\n    \n    -- If speed can't be detected, reduce exp-avg window size\n    if speed == 0 then\n        samples = math.min(1, samples)\n    end\n    \n    local thrill = C_UnitAuras.GetPlayerAuraBySpellID(thrillBuff)\n    \n    -- Override with ascent boost\n    if thrill and time < ascentStart + ascentDuration then\n        local progress = (time - ascentStart) / ascentDuration\n        local boost = thrillSpeed + (1 - progress) * ascentBoostMax\n        if speed < boost then\n            speed = boost\n            samples = 0\n            skipped = true\n        end\n    end\n    \n    -- Override speed based on Thrill buff\n    if speed < thrillSpeed and thrill then\n        speed = thrillSpeed\n    end\n    \n    if speed > thrillSpeed and not thrill then\n        speed = thrillSpeed\n        samples = 0\n        skipped = true\n    end\n    \n    -- Skip sampling on large apparent speed changes\n    if math.abs(speed - smoothSpeed) > 100 then\n        if skipped then\n            samples = 0\n        else\n            skipped = true\n            return false\n        end\n    end\n    skipped = false\n    \n    -- Compute smooth speed\n    samples = math.min(maxSamples, samples + 1)\n    local lastWeight = (samples - 1) / samples\n    local newWeight = 1 / samples\n    smoothSpeed = smoothSpeed * lastWeight + speed * newWeight\n    smoothGSpeed = smoothGSpeed * lastWeight + groundSpeed * newWeight\n    lastSpeed = smoothSpeed\n    \n    -- Update display variables\n    local s = allstates[\"\"]\n    s.changed = true\n    s.value = smoothSpeed\n    s.thrill = not not thrill\n    local speed = (true or instanced) and smoothSpeed or smoothGSpeed\n    s.speedtext = speed < 1 and \"\" or string.format(speedTextFormat, speed * speedTextFactor)\n    \n    return true\nend",
["do_custom"] = true,
},
},
["anchorFrameParent"] = true,
["xOffset"] = 0,
["internalVersion"] = 88,
["startAngle"] = 180,
["semver"] = "1.0.1",
["fontSize"] = 12,
["sparkHidden"] = "NEVER",
["displayText"] = "Pitch: %p",
["frameStrata"] = 4,
["width"] = 114,
["compress"] = false,
["displayText_format_p_time_mod_rate"] = true,
["inverse"] = false,
["uid"] = "3zWBqp5XEiH",
["orientation"] = "CLOCKWISE",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "thrill",
["value"] = 1,
},
["linked"] = false,
["changes"] = {
{
["value"] = {
0.10588236153126,
0.1803921610117,
1,
1,
},
["property"] = "foregroundColor",
},
},
},
{
["check"] = {
["trigger"] = 2,
["variable"] = "show",
["value"] = 0,
},
["changes"] = {
{
["property"] = "alpha",
},
},
},
},
["information"] = {
["forceEvents"] = true,
},
["displayText_format_p_time_dynamic_threshold"] = 60,
},
["[UI] Skyriding"] = {
["controlledChildren"] = {
"[UI] Background",
"[UI] Surge Forward",
"[UI] Flying Speed",
"[UI] Lightning Rush VFX Left",
"[UI] Lightning Rush VFX Right",
"[UI] Static Charges",
"[UI] Lightning Rush",
"[UI] Whirling Surge",
},
["borderBackdrop"] = "Blizzard Tooltip",
["wagoID"] = "K-P_CgDIP",
["authorOptions"] = {
},
["preferToUpdate"] = true,
["yOffset"] = -300,
["anchorPoint"] = "TOP",
["borderColor"] = {
0,
0,
0,
1,
},
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["unit"] = "player",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["subeventPrefix"] = "SPELL",
["names"] = {
},
["event"] = "Health",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
},
["internalVersion"] = 88,
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["desc"] = "Skyriding aura to keep track of movement speed and Static Charges.\n\nBased on https://wago.io/Afdc0wSAr and modified to suit my own needs.",
["version"] = 2,
["subRegions"] = {
},
["load"] = {
["size"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["talent"] = {
["multi"] = {
},
},
},
["backdropColor"] = {
1,
1,
1,
0.5,
},
["source"] = "import",
["scale"] = 1,
["border"] = false,
["borderEdge"] = "Square Full White",
["regionType"] = "group",
["borderSize"] = 2,
["parent"] = "[UI] WindfuryUI",
["anchorFrameParent"] = false,
["xOffset"] = 0,
["anchorFrameFrame"] = "UIParentBottomManagedFrameContainer",
["borderOffset"] = 4,
["semver"] = "1.0.1",
["tocversion"] = 100002,
["id"] = "[UI] Skyriding",
["selfPoint"] = "CENTER",
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["config"] = {
},
["borderInset"] = 1,
["frameStrata"] = 1,
["uid"] = "CdWFPjG7zKy",
["conditions"] = {
},
["information"] = {
},
["groupIcon"] = "4640477",
},
["[UI] Surge Forward"] = {
["iconSource"] = 0,
["wagoID"] = "K-P_CgDIP",
["xOffset"] = 0,
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = 8,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["cooldownEdge"] = false,
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["debuffType"] = "HELPFUL",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["subeventPrefix"] = "SPELL",
["event"] = "Cooldown Progress (Spell)",
["use_track"] = true,
["spellName"] = 372608,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_unit"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["activeTriggerMode"] = 1,
},
["internalVersion"] = 88,
["progressSource"] = {
-1,
"",
},
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 76,
["load"] = {
["use_dragonriding"] = true,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = false,
["source"] = "import",
["frameStrata"] = 1,
["uid"] = "qxCemCOhc8G",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["preferToUpdate"] = true,
["useAdjustededMin"] = false,
["regionType"] = "icon",
["information"] = {
},
["conditions"] = {
},
["authorOptions"] = {
},
["parent"] = "[UI] Skyriding",
["anchorFrameType"] = "SCREEN",
["alpha"] = 1,
["zoom"] = 0,
["semver"] = "1.0.1",
["cooldownTextDisabled"] = true,
["id"] = "[UI] Surge Forward",
["keepAspectRatio"] = false,
["useCooldownModRate"] = true,
["width"] = 76,
["url"] = "https://wago.io/K-P_CgDIP/2",
["config"] = {
},
["inverse"] = false,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["displayIcon"] = "",
["cooldown"] = true,
["color"] = {
1,
1,
1,
1,
},
},
["[UI] Whirling Surge"] = {
["iconSource"] = -1,
["wagoID"] = "K-P_CgDIP",
["parent"] = "[UI] Skyriding",
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = -33,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 361584,
["use_genericShowOn"] = true,
["event"] = "Cooldown Progress (Spell)",
["unit"] = "player",
["names"] = {
},
["use_spellName"] = true,
["spellIds"] = {
},
["subeventPrefix"] = "SPELL",
["use_exact_spellName"] = true,
["genericShowOn"] = "showAlways",
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_unit"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 88,
["keepAspectRatio"] = false,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_text_format_p_time_precision"] = 1,
["text_text_format_s_format"] = "none",
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["rotateText"] = "NONE",
["text_text_format_p_decimal_precision"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_shadowYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_text_format_p_pad_max"] = 8,
["text_fontSize"] = 15,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_p_round_type"] = "ceil",
["text_text_format_p_pad"] = false,
["text_text_format_p_pad_mode"] = "left",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["type"] = "subtext",
["text_font"] = "Fira Mono Bold",
["text_anchorYOffset"] = 0,
["text_shadowXOffset"] = 0,
["text_fontType"] = "OUTLINE",
["anchorXOffset"] = 0,
["text_text_format_2.s_format"] = "none",
["anchor_point"] = "CENTER",
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_mod_rate"] = true,
["text_text_format_1.s_format"] = "none",
},
},
["height"] = 26,
["load"] = {
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["use_dragonriding"] = true,
["use_exact_not_spellknown"] = true,
["use_not_spellknown"] = true,
["spec"] = {
["multi"] = {
},
},
["not_spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = false,
["source"] = "import",
["config"] = {
},
["cooldownEdge"] = false,
["color"] = {
1,
1,
1,
1,
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["progressSource"] = {
-1,
"",
},
["cooldown"] = true,
["xOffset"] = 0,
["icon"] = true,
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["cooldownTextDisabled"] = true,
["semver"] = "1.0.1",
["useCooldownModRate"] = true,
["id"] = "[UI] Whirling Surge",
["zoom"] = 0,
["alpha"] = 1,
["width"] = 26,
["preferToUpdate"] = true,
["uid"] = "HiRY(MIYD6Y",
["inverse"] = true,
["authorOptions"] = {
},
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["information"] = {
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
},
["[UI] Lightning Rush VFX Left"] = {
["customForegroundFrameWidth"] = 0,
["wagoID"] = "K-P_CgDIP",
["xOffset"] = -30,
["preferToUpdate"] = true,
["adjustedMin"] = "",
["yOffset"] = -18,
["anchorPoint"] = "CENTER",
["desaturateBackground"] = false,
["animationType"] = "loop",
["sameTexture"] = true,
["hideBackground"] = true,
["backgroundColor"] = {
0.5,
0.5,
0.5,
0.5,
},
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["debuffType"] = "HELPFUL",
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["event"] = "Action Usable",
["use_spellName"] = true,
["spellIds"] = {
},
["use_ignoreoverride"] = true,
["names"] = {
},
["unit"] = "player",
["use_track"] = true,
["spellName"] = 418592,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_unit"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["activeTriggerMode"] = 1,
},
["frameRate"] = 15,
["internalVersion"] = 88,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["customForegroundFileHeight"] = 0,
["customBackgroundRows"] = 16,
["customForegroundFileWidth"] = 0,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["startPercent"] = 0,
["selfPoint"] = "CENTER",
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 36,
["customForegroundFrameHeight"] = 0,
["load"] = {
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["use_spellknown"] = true,
["use_dragonriding"] = true,
["spec"] = {
["multi"] = {
},
},
["use_exact_spellknown"] = true,
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["foregroundColor"] = {
1,
1,
1,
1,
},
["useAdjustededMax"] = false,
["backgroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\stopmotion",
["source"] = "import",
["foregroundTexture"] = "dragonriding_sgvigor_decor_flipbook_left",
["backgroundPercent"] = 1,
["customBackgroundColumns"] = 16,
["mirror"] = false,
["useAdjustededMin"] = false,
["regionType"] = "stopmotion",
["adjustedMax"] = "",
["blendMode"] = "BLEND",
["config"] = {
},
["desaturateForeground"] = false,
["customForegroundColumns"] = 16,
["width"] = 36,
["endPercent"] = 1,
["authorOptions"] = {
},
["semver"] = "1.0.1",
["customBackgroundFrames"] = 0,
["id"] = "[UI] Lightning Rush VFX Left",
["url"] = "https://wago.io/K-P_CgDIP/2",
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["customForegroundFrames"] = 0,
["uid"] = "U18CS9tWcbQ",
["inverse"] = false,
["customForegroundRows"] = 16,
["conditions"] = {
},
["information"] = {
},
["parent"] = "[UI] Skyriding",
},
["[UI] Background"] = {
["wagoID"] = "K-P_CgDIP",
["xOffset"] = 0,
["preferToUpdate"] = true,
["yOffset"] = 0,
["anchorPoint"] = "CENTER",
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["names"] = {
},
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_unit"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 88,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["rotation"] = 0,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 138,
["rotate"] = false,
["load"] = {
["use_dragonriding"] = true,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
["source"] = "import",
["mirror"] = false,
["regionType"] = "texture",
["blendMode"] = "BLEND",
["texture"] = "ui-storm-headerorb",
["frameStrata"] = 1,
["semver"] = "1.0.1",
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["id"] = "[UI] Background",
["color"] = {
1,
0.9019608497619629,
0.6666666865348816,
1,
},
["alpha"] = 1,
["width"] = 114,
["anchorFrameType"] = "SCREEN",
["uid"] = "ltOWbcUpYXD",
["authorOptions"] = {
},
["config"] = {
},
["conditions"] = {
},
["information"] = {
},
["parent"] = "[UI] Skyriding",
},
["[UI] Lightning Rush VFX Right"] = {
["customForegroundFrameWidth"] = 0,
["wagoID"] = "K-P_CgDIP",
["authorOptions"] = {
},
["preferToUpdate"] = true,
["adjustedMin"] = "",
["yOffset"] = -18,
["foregroundColor"] = {
1,
1,
1,
1,
},
["desaturateBackground"] = false,
["animationType"] = "loop",
["sameTexture"] = true,
["startPercent"] = 0,
["desaturateForeground"] = false,
["customForegroundRows"] = 16,
["frameRate"] = 15,
["internalVersion"] = 88,
["progressSource"] = {
-1,
"",
},
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["preset"] = "fade",
["easeStrength"] = 3,
},
},
["customForegroundFileHeight"] = 0,
["customBackgroundRows"] = 16,
["customForegroundFileWidth"] = 0,
["url"] = "https://wago.io/K-P_CgDIP/2",
["parent"] = "[UI] Skyriding",
["selfPoint"] = "CENTER",
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["height"] = 36,
["customForegroundFrameHeight"] = 0,
["load"] = {
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["use_dragonriding"] = true,
["use_spellknown"] = true,
["class"] = {
["multi"] = {
},
},
["use_exact_spellknown"] = true,
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["anchorPoint"] = "CENTER",
["useAdjustededMax"] = false,
["backgroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\stopmotion",
["source"] = "import",
["foregroundTexture"] = "dragonriding_sgvigor_decor_flipbook_right",
["backgroundPercent"] = 1,
["customBackgroundColumns"] = 16,
["mirror"] = false,
["useAdjustededMin"] = false,
["regionType"] = "stopmotion",
["adjustedMax"] = "",
["customForegroundFrames"] = 0,
["config"] = {
},
["hideBackground"] = true,
["customForegroundColumns"] = 16,
["anchorFrameType"] = "SCREEN",
["backgroundColor"] = {
0.5,
0.5,
0.5,
0.5,
},
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["semver"] = "1.0.1",
["customBackgroundFrames"] = 0,
["id"] = "[UI] Lightning Rush VFX Right",
["endPercent"] = 1,
["frameStrata"] = 1,
["width"] = 36,
["blendMode"] = "BLEND",
["uid"] = "8X0oZUH69Wn",
["inverse"] = false,
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["spellName"] = 418592,
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["subeventPrefix"] = "SPELL",
["event"] = "Action Usable",
["use_spellName"] = true,
["spellIds"] = {
},
["use_ignoreoverride"] = true,
["unit"] = "player",
["names"] = {
},
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_unit"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["activeTriggerMode"] = 1,
},
["conditions"] = {
},
["information"] = {
},
["xOffset"] = 30,
},
["[UI] Talent Loadout Name"] = {
["outline"] = "OUTLINE",
["wagoID"] = "ih3-YXA_n",
["authorOptions"] = {
},
["displayText_format_p_time_dynamic_threshold"] = 60,
["shadowYOffset"] = 0,
["anchorPoint"] = "TOPLEFT",
["displayText_format_p_time_format"] = 0,
["customTextUpdate"] = "event",
["automaticWidth"] = "Auto",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
["custom"] = "aura_env.retries = 0\n\naura_env.Retry = function()\n    aura_env.Scan()\n    aura_env.retries = aura_env.retries + 1\nend\n\naura_env.Scan = function()\n    C_Timer.After(2, function() WeakAuras.ScanEvents(\"TRAIT_CONFIG_REFRESH\") end)\nend",
["do_custom"] = true,
},
},
["triggers"] = {
{
["trigger"] = {
["type"] = "custom",
["subeventSuffix"] = "_CAST_START",
["event"] = "Health",
["unit"] = "player",
["names"] = {
},
["events"] = "PLAYER_TALENT_UPDATE, TRAIT_CONFIG_UPDATED, TRAIT_CONFIG_REFRESH, ACTIVE_PLAYER_SPECIALIZATION_CHANGED, TRAIT_CONFIG_DELETED, TRAIT_TREE_CHANGED, READY_CHECK",
["spellIds"] = {
},
["custom_type"] = "stateupdate",
["check"] = "event",
["subeventPrefix"] = "SPELL",
["custom"] = "function(allstates, event, configId)\n    if event ~= \"TRAIT_CONFIG_REFRESH\" then\n        aura_env.Scan()\n        return false\n    end\n    \n    local defaultConfig = false\n    local currentSpecID = PlayerUtil.GetCurrentSpecID()\n    \n    if currentSpecID == nil then return false end\n    \n    local lastSelectedSavedConfigID = C_ClassTalents.GetLastSelectedSavedConfigID(currentSpecID)\n    if lastSelectedSavedConfigID == nil then\n        lastSelectedSavedConfigID = C_ClassTalents.GetActiveConfigID()\n        defaultConfig = true\n    end\n    \n    local configInfo = C_Traits.GetConfigInfo(lastSelectedSavedConfigID)\n    \n    if configInfo == nil then\n        if aura_env.retries < 5 then\n            aura_env.Retry()\n            return false\n        end\n    end\n    \n    local configName = configInfo and configInfo.name or \"\"\n    \n    if defaultConfig then\n        configName = configName .. \" (Default)\"\n    end\n    \n    if C_ClassTalents.GetStarterBuildActive() then\n        configName = \"Starter Build\"\n    end\n    \n    allstates[1] = {\n        show = true,\n        changed = true,\n        name = configName\n    }\n    aura_env.retries = 0\n    return true\nend",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "any",
["activeTriggerMode"] = -10,
},
["displayText_format_p_time_mod_rate"] = true,
["displayText_format_p_time_legacy_floor"] = false,
["wordWrap"] = "WordWrap",
["font"] = "Fira Sans Condensed Medium",
["version"] = 5,
["subRegions"] = {
{
["type"] = "subbackground",
},
},
["load"] = {
["use_vehicleUi"] = false,
["level"] = {
"60",
},
["use_level"] = true,
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["level_operator"] = {
">=",
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
["authorMode"] = true,
["fontSize"] = 16,
["source"] = "import",
["displayText_format_n_format"] = "none",
["shadowXOffset"] = 0,
["url"] = "https://wago.io/ih3-YXA_n/5",
["parent"] = "[UI] WindfuryUI",
["regionType"] = "text",
["selfPoint"] = "TOPLEFT",
["conditions"] = {
},
["internalVersion"] = 88,
["yOffset"] = -58,
["displayText_format_p_time_precision"] = 1,
["config"] = {
},
["displayText"] = "%n",
["justify"] = "LEFT",
["semver"] = "1.0.4",
["tocversion"] = 100007,
["id"] = "[UI] Talent Loadout Name",
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["frameStrata"] = 1,
["anchorFrameType"] = "UIPARENT",
["color"] = {
1,
1,
1,
1,
},
["uid"] = "L3RFyWOKMPs",
["displayText_format_p_format"] = "timed",
["xOffset"] = 5,
["shadowColor"] = {
0,
0,
0,
0,
},
["fixedWidth"] = 200,
["information"] = {
},
["preferToUpdate"] = false,
},
["[UI] Static Charges"] = {
["iconSource"] = -1,
["wagoID"] = "K-P_CgDIP",
["color"] = {
1,
1,
1,
1,
},
["adjustedMax"] = "10",
["adjustedMin"] = "0",
["yOffset"] = -33,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["actions"] = {
["start"] = {
},
["init"] = {
},
["finish"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["useStacks"] = true,
["matchesShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["stacks"] = "10",
["match_count"] = "0",
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["stacksOperator"] = "<",
["match_countOperator"] = ">=",
["event"] = "Health",
["use_debuffClass"] = false,
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["names"] = {
},
["auraspellids"] = {
"418590",
},
["unit"] = "player",
["useExactSpellId"] = true,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["use_unit"] = true,
["type"] = "unit",
["use_absorbHealMode"] = true,
["unit"] = "player",
["use_ismoving"] = true,
["use_absorbMode"] = true,
["event"] = "Conditions",
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 88,
["progressSource"] = {
1,
"stacks",
},
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_shadowXOffset"] = 0,
["text_text_format_s_format"] = "none",
["text_text"] = "%s",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["text_fixedWidth"] = 64,
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["rotateText"] = "NONE",
["type"] = "subtext",
["text_color"] = {
1,
1,
1,
1,
},
["text_font"] = "Fira Mono Bold",
["text_shadowYOffset"] = 0,
["text_anchorYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_fontType"] = "OUTLINE",
["text_visible"] = true,
["text_text_format_2.s_format"] = "none",
["anchor_point"] = "CENTER",
["text_fontSize"] = 14,
["anchorXOffset"] = 0,
["text_text_format_1.s_format"] = "none",
},
},
["height"] = 26,
["load"] = {
["use_dragonriding"] = true,
["use_spellknown"] = true,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = true,
["source"] = "import",
["config"] = {
},
["cooldownEdge"] = false,
["authorOptions"] = {
},
["useAdjustededMin"] = true,
["regionType"] = "icon",
["parent"] = "[UI] Skyriding",
["cooldown"] = true,
["xOffset"] = 0,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["type"] = "none",
["easeStrength"] = 3,
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["cooldownTextDisabled"] = true,
["semver"] = "1.0.1",
["useCooldownModRate"] = true,
["id"] = "[UI] Static Charges",
["zoom"] = 0,
["alpha"] = 1,
["width"] = 26,
["preferToUpdate"] = true,
["uid"] = "NscGnzsi2cE",
["inverse"] = false,
["keepAspectRatio"] = false,
["conditions"] = {
},
["information"] = {
},
["icon"] = true,
},
["[UI] WindfuryUI"] = {
["backdropColor"] = {
1,
1,
1,
0.5,
},
["controlledChildren"] = {
"[UI] Skyriding",
"[UI] Talent Loadout Name",
},
["borderBackdrop"] = "Blizzard Tooltip",
["scale"] = 1,
["yOffset"] = 0,
["border"] = false,
["groupIcon"] = 134063,
["regionType"] = "group",
["borderSize"] = 2,
["authorOptions"] = {
},
["borderColor"] = {
0,
0,
0,
1,
},
["borderInset"] = 1,
["borderEdge"] = "Square Full White",
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["triggers"] = {
{
["trigger"] = {
["debuffType"] = "HELPFUL",
["type"] = "aura2",
["spellIds"] = {
},
["subeventSuffix"] = "_CAST_START",
["unit"] = "player",
["subeventPrefix"] = "SPELL",
["event"] = "Health",
["names"] = {
},
},
["untrigger"] = {
},
},
},
["anchorPoint"] = "CENTER",
["borderOffset"] = 4,
["xOffset"] = 0,
["selfPoint"] = "CENTER",
["id"] = "[UI] WindfuryUI",
["internalVersion"] = 88,
["alpha"] = 1,
["anchorFrameType"] = "SCREEN",
["animation"] = {
["start"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
},
["config"] = {
},
["frameStrata"] = 1,
["subRegions"] = {
},
["uid"] = "KMSQhD4asZu",
["conditions"] = {
},
["information"] = {
},
["load"] = {
["talent"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["size"] = {
["multi"] = {
},
},
},
},
["[UI] Lightning Rush"] = {
["iconSource"] = -1,
["wagoID"] = "K-P_CgDIP",
["authorOptions"] = {
},
["adjustedMax"] = "",
["adjustedMin"] = "",
["yOffset"] = -33,
["anchorPoint"] = "CENTER",
["cooldownSwipe"] = true,
["url"] = "https://wago.io/K-P_CgDIP/2",
["icon"] = true,
["triggers"] = {
{
["trigger"] = {
["type"] = "spell",
["subeventSuffix"] = "_CAST_START",
["use_genericShowOn"] = true,
["genericShowOn"] = "showAlways",
["subeventPrefix"] = "SPELL",
["debuffType"] = "HELPFUL",
["use_spellName"] = true,
["spellIds"] = {
},
["names"] = {
},
["unit"] = "player",
["event"] = "Cooldown Progress (Spell)",
["use_track"] = true,
["spellName"] = 418592,
},
["untrigger"] = {
},
},
{
["trigger"] = {
["unit"] = "player",
["type"] = "aura2",
["stacksOperator"] = ">=",
["auraspellids"] = {
"418590",
},
["stacks"] = "10",
["useExactSpellId"] = true,
["useStacks"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
{
["trigger"] = {
["type"] = "unit",
["use_absorbHealMode"] = true,
["use_genericShowOn"] = true,
["genericShowOn"] = "showOnCooldown",
["unit"] = "player",
["use_spellName"] = true,
["use_absorbMode"] = true,
["use_unit"] = true,
["use_ismoving"] = true,
["event"] = "Conditions",
["use_track"] = true,
["debuffType"] = "HELPFUL",
},
["untrigger"] = {
},
},
["disjunctive"] = "all",
["activeTriggerMode"] = 1,
},
["internalVersion"] = 88,
["keepAspectRatio"] = false,
["selfPoint"] = "CENTER",
["desaturate"] = false,
["version"] = 2,
["subRegions"] = {
{
["type"] = "subbackground",
},
{
["text_shadowXOffset"] = 0,
["text_text_format_s_format"] = "none",
["text_text"] = "%p",
["text_shadowColor"] = {
0,
0,
0,
0,
},
["text_fixedWidth"] = 64,
["text_text_format_p_time_legacy_floor"] = false,
["rotateText"] = "NONE",
["text_text_format_p_decimal_precision"] = 0,
["text_color"] = {
1,
1,
1,
1,
},
["text_shadowYOffset"] = 0,
["text_wordWrap"] = "WordWrap",
["text_visible"] = true,
["text_text_format_p_pad_max"] = 8,
["text_fontSize"] = 16,
["text_text_format_p_time_dynamic_threshold"] = 60,
["text_text_format_p_round_type"] = "ceil",
["text_text_format_p_pad"] = false,
["text_text_format_p_pad_mode"] = "left",
["text_text_format_p_format"] = "Number",
["text_selfPoint"] = "AUTO",
["text_automaticWidth"] = "Auto",
["anchorYOffset"] = 0,
["text_justify"] = "CENTER",
["type"] = "subtext",
["text_font"] = "Fira Mono Bold",
["text_anchorYOffset"] = 0,
["text_text_format_p_time_format"] = 0,
["text_text_format_p_time_precision"] = 1,
["text_text_format_p_time_mod_rate"] = true,
["text_text_format_2.s_format"] = "none",
["anchor_point"] = "CENTER",
["anchorXOffset"] = 0,
["text_fontType"] = "OUTLINE",
["text_text_format_1.s_format"] = "none",
},
},
["height"] = 26,
["load"] = {
["use_dragonriding"] = true,
["use_spellknown"] = true,
["use_never"] = false,
["talent"] = {
["multi"] = {
},
},
["class"] = {
["multi"] = {
},
},
["spec"] = {
["multi"] = {
},
},
["spellknown"] = 418592,
["size"] = {
["multi"] = {
},
},
},
["useAdjustededMax"] = false,
["source"] = "import",
["uid"] = "6auuKv1LDOV",
["cooldownEdge"] = false,
["actions"] = {
["start"] = {
},
["finish"] = {
},
["init"] = {
},
},
["useAdjustededMin"] = false,
["regionType"] = "icon",
["xOffset"] = 0,
["information"] = {
},
["color"] = {
1,
1,
1,
1,
},
["progressSource"] = {
-1,
"",
},
["useCooldownModRate"] = true,
["width"] = 26,
["zoom"] = 0,
["semver"] = "1.0.1",
["alpha"] = 1,
["id"] = "[UI] Lightning Rush",
["cooldownTextDisabled"] = true,
["frameStrata"] = 1,
["anchorFrameType"] = "SCREEN",
["preferToUpdate"] = true,
["config"] = {
},
["inverse"] = true,
["parent"] = "[UI] Skyriding",
["conditions"] = {
{
["check"] = {
["trigger"] = 1,
["variable"] = "onCooldown",
["value"] = 1,
},
["changes"] = {
{
["value"] = true,
["property"] = "desaturate",
},
},
},
},
["cooldown"] = true,
["animation"] = {
["start"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
["main"] = {
["easeStrength"] = 3,
["type"] = "none",
["duration_type"] = "seconds",
["easeType"] = "none",
},
["finish"] = {
["type"] = "preset",
["easeType"] = "none",
["duration_type"] = "seconds",
["easeStrength"] = 3,
["preset"] = "fade",
},
},
},
},
["mousePointerFrame"] = {
["xOffset"] = -1095.834838867188,
["yOffset"] = -436.6663208007813,
},
["minimap"] = {
["hide"] = true,
},
["historyCutoff"] = 730,
["personalRessourceDisplayFrame"] = {
["xOffset"] = -574.220530947008,
["yOffset"] = -358.4376147040192,
},
["editor_theme"] = "Monokai",
["dynamicIconCache"] = {
},
["editor_font_size"] = 12,
["lastArchiveClear"] = 1770056227,
["lastUpgrade"] = 1768598316,
["features"] = {
},
["migrationCutoff"] = 730,
["registered"] = {
},
["login_squelch_time"] = 10,
["dbVersion"] = 88,
}
