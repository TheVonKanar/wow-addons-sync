local ACR = LibStub("AceConfigRegistry-3.0")

local function AddLinkTooltip(widget, link)
    if not link then return end

    widget:EnableMouse(true)

    widget:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end)

    widget:SetScript("OnLeave", function() GameTooltip:Hide() end)

end

function MythicPlusUtility:UtilityAbilitiesFrame()
    local BUTTON_SPACING = 8
    local LEFT_PADDING = 5
    local RIGHT_PADDING = 5
    local TOP_PADDING = 5
    local TEXT_WRAP_PADDING = 7
    local CLOSE_BUTTON_SIZE = 15

    local db = self.db
    local profile = self.db.profile

    self:PopulateCurrentAbilitiesListWithInstanceData(profile.instanceID)

    local frame = CreateFrame("Frame", "MythicPlusUtility_UtilityAbilitiesFrame", UIParent, "BackdropTemplate")

    frame:SetPoint("TOPLEFT", UIParent, profile.selectFramePoint, profile.frameXOffset, profile.frameYOffset)
    frame:SetWidth(profile.frameWidth)

    frame:SetHyperlinksEnabled(true)

    frame:SetHeight(profile.frameHeight)
    frame:SetClipsChildren(true)

    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    frame:SetScript("OnDragStart", function(self) if not profile.toggleFrameLock then self:StartMoving() end end)

    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local left = self:GetLeft()
        local top = self:GetTop()
        local screenWidth = GetScreenWidth()
        local screenHeight = GetScreenHeight()
        local x = 0
        local y = 0

        local framePoint = profile.selectFramePoint
        self:ClearAllPoints()

        if framePoint == "TOPLEFT" then
            x = Round(left)
            y = Round(top - screenHeight)
        elseif framePoint == "TOP" then
            x = Round(left - (screenWidth / 2))
            y = Round(top - screenHeight)
        elseif framePoint == "TOPRIGHT" then
            x = Round(left - screenWidth)
            y = Round(top - screenHeight)
        elseif framePoint == "LEFT" then
            x = Round(left)
            y = Round(top - (screenHeight / 2))
        elseif framePoint == "CENTER" then
            x = Round(left - (screenWidth / 2))
            y = Round(top - (screenHeight / 2))
        elseif framePoint == "RIGHT" then
            x = Round(left - screenWidth)
            y = Round(top - (screenHeight / 2))
        elseif framePoint == "BOTTOMLEFT" then
            x = Round(left)
            y = Round(top)
        elseif framePoint == "BOTTOM" then
            x = Round(left - (screenWidth / 2))
            y = Round(top)
        elseif framePoint == "BOTTOMRIGHT" then
            x = Round(left - screenWidth)
            y = Round(top)
        end

        profile.frameXOffset = x
        profile.frameYOffset = y
        self:SetPoint("TOPLEFT", UIParent, framePoint, x, y)

        ACR:NotifyChange("MythicPlusUtility_Options")
    end)

    function frame:ChangeInstance()
        MythicPlusUtility:PopulateCurrentAbilitiesListWithInstanceData(profile.instanceID)
        self.dungeonNameText:SetText(MythicPlusUtility.dungeonIdToName[profile.instanceID] or "")
        self:UpdateButtons()
        self:UpdateLayout()
    end

    function frame:SetShownHandler(show)
        if show then
            if db.char.changedSpec or db.char.changedTalents then
                if db.char.changedSpec then
                    db.char.changedSpec = false
                    db.char.changedTalents = false
                    MythicPlusUtility:CreateCurrentAbilitiesList()
                elseif db.char.changedTalents then
                    db.char.changedTalents = false
                    MythicPlusUtility:UpdateCurrentAbilitiesList()
                end

                self:ChangeInstance()
            end
        end
        self:SetShown(show)
    end

    function frame:UpdatePosition()
        self:SetPoint("TOPLEFT", UIParent, profile.selectFramePoint, profile.frameXOffset, profile.frameYOffset)
    end

    local background = frame:CreateTexture(nil, "ARTWORK")
    background:SetAllPoints()
    background:SetColorTexture(0, 0, 0, profile.frameBackgroundAlpha)

    frame.background = background

    frame.buttons = {}

    function frame:UpdateLayout()
        local currentY = -TOP_PADDING - self:GetTop() + self.dungeonNameText:GetBottom()
        self.listEmptyText:SetPoint("TOPLEFT", LEFT_PADDING + RIGHT_PADDING, currentY)

        for id, _ in ipairs(MythicPlusUtility.buttonsIndices) do
            local button = self.buttons[id]
            button:ClearAllPoints()
            button:SetPoint("TOPLEFT", LEFT_PADDING, currentY)

            currentY = currentY - profile.buttonSize - BUTTON_SPACING

            if button.listFrame:IsShown() then
                button.listFrame:ClearAllPoints()
                button.listFrame:SetPoint("TOPLEFT", LEFT_PADDING + 10, currentY + BUTTON_SPACING - 5)
                button.listFrame:SetHeight(1)

                local listHeight = 0
                if #button.list > 0 then
                    local first = button.listFrame.lines[1]
                    local last = button.listFrame.lines[#button.list]
                    listHeight = first:GetTop() - last:GetBottom()
                end
                button.listFrame:SetHeight(listHeight)

                currentY = currentY - listHeight - BUTTON_SPACING
            end
        end

    end

    function frame:UpdateButtons()

        if #MythicPlusUtility.buttonsIndices == 0 then
            self.listEmptyText:Show()
        else
            self.listEmptyText:Hide()
        end

        if #self.buttons > #MythicPlusUtility.buttonsIndices then
            for i = #MythicPlusUtility.buttonsIndices + 1, #self.buttons do
                self.buttons[i].listFrame:Hide()
                self.buttons[i]:Hide()
            end
        end

        for id, abilityId in ipairs(MythicPlusUtility.buttonsIndices) do
            local currentAbility = MythicPlusUtility.currentAbilitiesList[abilityId]
            local spellId = currentAbility.spellId
            if currentAbility.altSpellId then spellId = currentAbility.altSpellId end

            if self.buttons[id] then
                local button = self.buttons[id]
                button:Show()
                button.texture:SetTexture(MythicPlusUtility:GetSpellIconById(spellId))

                if not currentAbility.isKnown then
                    button.texture:SetDesaturated(true)
                else
                    button.texture:SetDesaturated(false)
                end

                button.list = MythicPlusUtility:tablecopy(currentAbility.list)

                local name = currentAbility.spellName
                if currentAbility.tagsTable.self_only then
                    name = CreateAtlasMarkup("friendslist-recentallies-yellow") .. name
                end
                button.label:SetText(name)

                AddLinkTooltip(button, MythicPlusUtility:GetSpellHyperlinkById(spellId))

                if #button.listFrame.lines > #button.list then
                    for i = #button.list + 1, #button.listFrame.lines do
                        button.listFrame.lines[i]:Hide()
                    end
                end

                for listId, text in ipairs(button.list) do
                    if button.listFrame.lines[listId] then
                        button.listFrame.lines[listId]:Show()
                        button.listFrame.lines[listId]:SetText(text)
                    else
                        local line = button.listFrame:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
                        line:SetJustifyH("LEFT")
                        line:SetWordWrap(true)
                        line:SetWidth(profile.frameWidth - LEFT_PADDING - RIGHT_PADDING - TEXT_WRAP_PADDING)
                        line:SetFont(profile.font, profile.textFontSize, nil)
                        line:SetText(text)

                        if listId == 1 then
                            line:SetPoint("TOPLEFT", 0, 0)
                        else
                            line:SetPoint("TOPLEFT", button.listFrame.lines[listId - 1], "BOTTOMLEFT", 0, -4)
                        end
                        table.insert(button.listFrame.lines, line)
                    end
                end

            else
                local button = CreateFrame("Button", nil, self)
                button:SetSize(profile.buttonSize, profile.buttonSize)

                local texture = button:CreateTexture(nil, "ARTWORK")
                texture:SetAllPoints()
                texture:SetTexture(MythicPlusUtility:GetSpellIconById(spellId))

                if not currentAbility.isKnown then
                    texture:SetDesaturated(true)
                else
                    texture:SetDesaturated(false)
                end

                button.texture = texture
                button.list = MythicPlusUtility:tablecopy(currentAbility.list)

                local label = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                label:SetPoint("TOPLEFT", button, "RIGHT", 10, Round(profile.labelFontSize / 2))
                label:SetJustifyH("LEFT")
                label:SetWordWrap(true)
                label:SetWidth(profile.frameWidth - LEFT_PADDING - profile.buttonSize - RIGHT_PADDING - 5)
                label:SetFont(profile.font, profile.labelFontSize, nil)

                local name = currentAbility.spellName
                if currentAbility.tagsTable.self_only then
                    name = CreateAtlasMarkup("friendslist-recentallies-yellow") .. name
                end
                label:SetText(name)

                button.label = label

                AddLinkTooltip(button, MythicPlusUtility:GetSpellHyperlinkById(spellId))

                local listFrame = CreateFrame("Frame", nil, self)
                listFrame:SetWidth(1)
                listFrame:Hide()
                listFrame.lines = {}

                listFrame:SetHyperlinksEnabled(true)

                listFrame:SetScript("OnHyperlinkEnter", function(self, link, text, region, left, bottom, width, height)
                    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
                    GameTooltip:SetHyperlink(link)
                    GameTooltip:Show()
                end)
                listFrame:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)

                button.listFrame = listFrame

                for i, text in ipairs(button.list) do
                    local line = listFrame:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
                    line:SetJustifyH("LEFT")
                    line:SetWordWrap(true)
                    line:SetWidth(profile.frameWidth - LEFT_PADDING - RIGHT_PADDING - TEXT_WRAP_PADDING)
                    line:SetFont(profile.font, profile.textFontSize, nil)
                    line:SetText(text)

                    if i == 1 then
                        line:SetPoint("TOPLEFT", 0, 0)
                    else
                        line:SetPoint("TOPLEFT", listFrame.lines[i - 1], "BOTTOMLEFT", 0, -4)
                    end
                    table.insert(listFrame.lines, line)
                end

                button:SetScript("OnClick", function(self)
                    self.listFrame:SetShown(not self.listFrame:IsShown())
                    frame:UpdateLayout()
                end)

                table.insert(self.buttons, button)
            end
        end

    end

    function frame:UpdateButtonSize()
        if #self.buttons > 0 then
            for _, button in ipairs(self.buttons) do
                button:SetSize(profile.buttonSize, profile.buttonSize)
                button.label:SetWidth(profile.frameWidth - LEFT_PADDING - profile.buttonSize - RIGHT_PADDING - 5)
            end
            self:UpdateLayout()
        end
    end

    function frame:UpdateFont()
        self.dungeonNameText:SetFont(profile.font, profile.dungeonNameSize, nil)
        self.listEmptyText:SetFont(profile.font, profile.textFontSize, nil)
        if #self.buttons > 0 then
            for _, button in ipairs(self.buttons) do
                button.label:SetFont(profile.font, profile.labelFontSize, nil)
                button.label:SetPoint("TOPLEFT", button, "RIGHT", 10, Round(profile.labelFontSize / 2))
                for _, line in ipairs(button.listFrame.lines) do
                    line:SetFont(profile.font, profile.textFontSize, nil)
                end
            end
        end
        self:UpdateLayout()
    end

    function frame:UpdateTextWrap()
        self.dungeonNameText:SetWidth(profile.frameWidth - 2 * CLOSE_BUTTON_SIZE - TEXT_WRAP_PADDING)
        self.listEmptyText:SetWidth(profile.frameWidth - LEFT_PADDING - RIGHT_PADDING - TEXT_WRAP_PADDING)
        for id, _ in ipairs(MythicPlusUtility.buttonsIndices) do
            local button = self.buttons[id]
            button.label:SetWidth(profile.frameWidth - LEFT_PADDING - profile.buttonSize - RIGHT_PADDING - 1)
            for subId, _ in ipairs(button.list) do
                button.listFrame.lines[subId]:SetWidth(profile.frameWidth - LEFT_PADDING - RIGHT_PADDING
                                                         - TEXT_WRAP_PADDING)
            end
        end
        self:UpdateLayout()
    end

    local closeButton = CreateFrame("Button", nil, frame)
    closeButton:SetSize(CLOSE_BUTTON_SIZE, CLOSE_BUTTON_SIZE)
    closeButton:SetPoint("TOPRIGHT", 1, 1)

    local texture = closeButton:CreateTexture(nil, "ARTWORK")
    texture:SetAllPoints()
    texture:SetAtlas("simplecheckout-close-normal-1x")

    closeButton.texture = texture

    closeButton:SetScript("OnEnter", function(self) self.texture:SetAtlas("simplecheckout-close-hover-1x") end)
    closeButton:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then self.texture:SetAtlas("simplecheckout-close-pressed-1x") end
    end)
    closeButton:SetScript("OnLeave", function(self) self.texture:SetAtlas("simplecheckout-close-normal-1x") end)
    closeButton:SetScript("OnClick", function(self) frame:SetShownHandler(false) end)

    local dungeonNameText = frame:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
    dungeonNameText:SetJustifyH("CENTER")
    dungeonNameText:SetJustifyV("TOP")
    dungeonNameText:SetWordWrap(true)
    dungeonNameText:SetWidth(profile.frameWidth - 2 * CLOSE_BUTTON_SIZE - TEXT_WRAP_PADDING)
    dungeonNameText:SetText(self.dungeonIdToName[profile.instanceID] or "")
    dungeonNameText:SetFont(profile.font, profile.dungeonNameSize, "OUTLINE")
    dungeonNameText:SetPoint("TOP", 0, -TOP_PADDING)

    frame.dungeonNameText = dungeonNameText

    local listEmptyText = frame:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
    listEmptyText:SetJustifyH("LEFT")
    listEmptyText:SetWordWrap(true)
    listEmptyText:SetWidth(profile.frameWidth - LEFT_PADDING - RIGHT_PADDING - TEXT_WRAP_PADDING)
    listEmptyText:SetText("No utility abilities for this dungeon")
    listEmptyText:SetFont(profile.font, profile.textFontSize, nil)
    listEmptyText:SetPoint("TOPLEFT", LEFT_PADDING + RIGHT_PADDING,
                           -TOP_PADDING - frame:GetTop() + frame.dungeonNameText:GetBottom())
    listEmptyText:Hide()

    frame.listEmptyText = listEmptyText

    frame:UpdateButtons()
    frame:UpdateLayout()
    return frame
end
