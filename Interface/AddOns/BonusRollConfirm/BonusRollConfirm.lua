local addonName = ...

StaticPopupDialogs["BONUS_ROLL_CONFIRM"] = {
    text = "Are you sure you want to use a bonus roll?\n\nLoot spec: |cffffd100%s|r",
    button1 = "Confirm",
    button2 = "Cancel",
    OnAccept = nil,
    OnCancel = function()
        print("|cff00ccffBonusRollConfirm:|r Bonus roll cancelled.")
    end,
    timeout = 0,
    whileDead = false,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["BONUS_PASS_CONFIRM"] = {
    text = "Are you sure you want to pass on this bonus roll?",
    button1 = "Confirm",
    button2 = "Cancel",
    OnAccept = nil,
    OnCancel = function()
        print("|cff00ccffBonusRollConfirm:|r Pass cancelled.")
    end,
    timeout = 0,
    whileDead = false,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Returns the name of the spec loot will be awarded for, so the prompt can
-- remind the player to check it before spending the roll.
local function LootSpecText()
    local specID = GetLootSpecialization and GetLootSpecialization()
    if specID and specID > 0 then
        local _, name = GetSpecializationInfoByID(specID)
        if name then return name end
    else
        local index = GetSpecialization and GetSpecialization()
        if index then
            local _, name = GetSpecializationInfo(index)
            if name then return name .. " (current spec)" end
        end
    end
    return "unknown"
end

local hooked = false
-- Cached copy of the saved setting; loaded from BonusRollConfirmDB on ADDON_LOADED
local passPromptEnabled = true

local function HookButton(btn, isRoll)
    if not btn or btn._brcHooked then return end
    btn._brcHooked = true

    local originalOnClick = btn:GetScript("OnClick")
    if not originalOnClick then return end

    local dialog = isRoll and "BONUS_ROLL_CONFIRM" or "BONUS_PASS_CONFIRM"
    local confirmMsg = isRoll and "|cff00ccffBonusRollConfirm:|r Bonus roll used." or "|cff00ccffBonusRollConfirm:|r Bonus roll passed."

    btn:SetScript("OnClick", function(self, button, down)
        if not isRoll and not passPromptEnabled then
            originalOnClick(self, button, down)
            print(confirmMsg)
            return
        end
        StaticPopupDialogs[dialog].OnAccept = function()
            originalOnClick(self, button, down)
            print(confirmMsg)
        end
        StaticPopup_Show(dialog, isRoll and LootSpecText() or nil)
    end)
end

local function HookRollFrame()
    if hooked then return end
    if not BonusRollFrame then return end

    -- Try known named paths for the roll button first
    local rollBtn = (BonusRollFrame.PromptFrame and BonusRollFrame.PromptFrame.RollButton)
                 or BonusRollFrame.RollButton

    -- Iterate all children and hook every button we find
    local function HookChildren(frame)
        for i = 1, frame:GetNumChildren() do
            local child = select(i, frame:GetChildren())
            local name = child:GetName()
            -- Skip buttons belonging to other addons
            if name and name ~= addonName and not name:find("BonusRollConfirm") then
                -- named button from another addon, skip
            elseif child:IsObjectType("Button") then
                local isRoll = (child == rollBtn)
                HookButton(child, isRoll)
            end
            HookChildren(child)
        end
    end

    HookChildren(BonusRollFrame)

    -- If we found and hooked any button, consider it done
    hooked = true
end

if BonusRollFrame_StartBonusRoll then
    hooksecurefunc("BonusRollFrame_StartBonusRoll", HookRollFrame)
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("BONUS_ROLL_STARTED")
f:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        BonusRollConfirmDB = BonusRollConfirmDB or {}
        if BonusRollConfirmDB.passPromptEnabled == nil then
            BonusRollConfirmDB.passPromptEnabled = true
        end
        passPromptEnabled = BonusRollConfirmDB.passPromptEnabled
        HookRollFrame()
        if BonusRollFrame_StartBonusRoll and not hooked then
            hooksecurefunc("BonusRollFrame_StartBonusRoll", HookRollFrame)
        end
    elseif event == "BONUS_ROLL_STARTED" then
        HookRollFrame()
    end
end)

local testButton

local function ShowTestButton()
    if testButton then testButton:Show() return end
    testButton = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
    testButton:SetSize(160, 32)
    testButton:SetPoint("CENTER", 0, 100)
    testButton:SetText("TEST Bonus Roll")
    testButton:SetScript("OnClick", function(self, button, down)
        StaticPopupDialogs["BONUS_ROLL_CONFIRM"].OnAccept = function()
            print("|cff00ccffBonusRollConfirm:|r Bonus roll used.")
            testButton:Hide()
        end
        StaticPopupDialogs["BONUS_ROLL_CONFIRM"].OnCancel = function()
            print("|cff00ccffBonusRollConfirm:|r Bonus roll cancelled.")
        end
        StaticPopup_Show("BONUS_ROLL_CONFIRM", LootSpecText())
    end)
end

SLASH_BONUSROLLCONFIRM1 = "/brc"
SlashCmdList["BONUSROLLCONFIRM"] = function(msg)
    msg = strtrim(msg or ""):lower()

    if msg == "nopass" then
        passPromptEnabled = not passPromptEnabled
        BonusRollConfirmDB.passPromptEnabled = passPromptEnabled
        if passPromptEnabled then
            print("|cff00ccffBonusRollConfirm:|r Pass confirmation enabled.")
        else
            print("|cff00ccffBonusRollConfirm:|r Pass confirmation disabled.")
        end
        return
    end

    if msg == "test" then
        ShowTestButton()
        print("|cff00ccffBonusRollConfirm:|r Test button shown. Click it to test the confirmation.")
        return
    end

    if not BonusRollFrame then
        print("|cff00ccffBonusRollConfirm:|r BonusRollFrame does not exist")
        return
    end
    print("|cff00ccffBonusRollConfirm:|r BonusRollFrame children:")
    local function PrintChildren(frame, indent)
        for i = 1, frame:GetNumChildren() do
            local child = select(i, frame:GetChildren())
            print(indent .. (child:GetName() or "[unnamed]") .. " (" .. child:GetObjectType() .. ")")
            PrintChildren(child, indent .. "  ")
        end
    end
    PrintChildren(BonusRollFrame, "  ")
    print("|cff00ccffBonusRollConfirm:|r hooked =", tostring(hooked))
end
