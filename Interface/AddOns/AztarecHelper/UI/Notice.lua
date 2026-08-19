-- Azta'rec Helper, copyright 2026 Rothirr, all rights reserved.
-- Read it if you want. Copying any of it into another addon is theft, and
-- running it through an AI tool first does not change that. The timings and
-- coordinates were measured by hand. Nothing here is licensed to anyone.

local _, AZT = ...

-- The reading box. One frame, two things to say: the notice about the 12.1
-- position blackout, which shows itself once on the first delve entry, and
-- the instructions, which wait behind the room view's button.

local box

local NERF_TITLE = "Automatic recording is back"
local NERF = "A 12.1 build stopped the game handing out coordinates inside this delve, which "
    .. "took the automatic recording with it and left you keying the route by hand.\n\n"
    .. "It can record itself again. Dodge the visible waves the way you always would and the "
    .. "route is yours at the end of the channel, no key presses during the Sermon. It "
    .. "needs your minimap set to rotate with you, and the addon offers the whole thing "
    .. "once when you enter the delve. Recording by hand stays the default and the "
    .. "Recording switch in the settings flips between the two any time. The Instructions "
    .. "button on the room view has the rest.\n\n"
    .. "Also, sorry for shouting in your ear with the new spoken cues, I wanted to use "
    .. "real voice instead of TTS for some personality. Whichever sound channel you point "
    .. "the cues at has a volume slider in the settings, and /azt cue shuts me up for good.\n\n"
    .. "Check back on August 19th. This will still be the best addon for this fight.\n\n"
    .. "Fabled Let Me Solo Him: Azta'rec wants him dead on Tier ?? with nobody else in "
    .. "your party, inside the first week of Midnight Season 2. The memory game is the "
    .. "part that ends those runs, and remembering it is the one thing this addon does."

local INSTR_TITLE = "How to use it"
local INSTR = "Azta'rec slams three quarters of the room at once during Sermon of Ula'tek "
    .. "and leaves one safe, a few times in a row with the ground showing you where. "
    .. "Then he repeats the same order with nothing showing, and that is the part this "
    .. "addon remembers with you.\n\n"
    .. "While the ground still shows the safe quarter, tell the addon where you went. "
    .. "Press that quarter's key, or click the quarter on the room view. One answer per "
    .. "wave. The countdown window says which wave it is waiting for and how long you "
    .. "have, because the boss's own channel gives away the timing.\n\n"
    .. "Or let it record on its own. Set Recording to Automatic in the settings and it "
    .. "writes down where you stood for each wave while you dodge, nothing to press during "
    .. "the Sermon. That needs your minimap set to rotate with you, and the keys, marking "
    .. "and calling stand down while it is on.\n\n"
    .. "By hand, answers land in order, so a late one still counts. Miss the third wave and your "
    .. "next press takes the third slot, which means two quick taps get you level again. "
    .. "You cannot answer a wave that has not happened yet, and a wave left blank when "
    .. "the echoes begin can still be filled right up until its own echo plays. Anything "
    .. "you never answer stays unknown.\n\n"
    .. "If naming quarters in the scramble is the hard part, the settings can switch the keys "
    .. "to relative turns, the same reading the arrow and the voice use. A press then says the "
    .. "move you made rather than the place you ended up: north for straight through the boss, "
    .. "east and west for the two sides. The first wave still names its quarter, since there "
    .. "is nothing behind it to turn from, and that is where the route starts. South answers "
    .. "nothing after that, the safe spot never lands twice in the same place. Marking and "
    .. "calling need a quarter, so they switch off while it is on.\n\n"
    .. "When the echoes start, the room view lights the quarter you are due in green and the "
    .. "one after it yellow. The arrow shows the move to make from where the last wave "
    .. "left you and the voice calls it out loud.\n\n"
    .. "The arrow points where the move really is, whichever way you are looking, as long "
    .. "as your minimap rotates. Without that it falls back to talking as if you face the "
    .. "boss, where up means straight through him. The voice always talks that way, so "
    .. "keep him in front of you when you are going by ear.\n\n"
    .. "Your four keys live in the settings panel and in the game's Key Bindings screen "
    .. "under AddOns. Each quarter on the room view shows its own key. The quarters wear "
    .. "markers rather than compass letters, so you can drop the matching world markers in "
    .. "the room, and clicking a marker out of combat changes it. Between pulls, /azt replay "
    .. "walks the last route again at its real speed, /azt review says what it recorded, and "
    .. "/azt practice runs a whole pretend sermon for you to answer and get echoed, no boss "
    .. "needed."

local function build()
    box = CreateFrame("Frame", "AztarecHelperNotice", UIParent, "BackdropTemplate")
    box:SetSize(480, 100)
    box:SetPoint("CENTER", 0, 140)
    -- above the settings panel, since the Updates button opens it from there
    box:SetFrameStrata("FULLSCREEN_DIALOG")
    box:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    box:SetBackdropColor(0, 0, 0, 0.85)
    box:EnableMouse(true)
    box:SetMovable(true)
    box:RegisterForDrag("LeftButton")
    box:SetScript("OnDragStart", box.StartMoving)
    box:SetScript("OnDragStop", box.StopMovingOrSizing)

    local title = box:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -12)
    box.title = title

    local body = box:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    body:SetPoint("TOPLEFT", 18, -38)
    body:SetPoint("TOPRIGHT", -18, -38)
    body:SetJustifyH("LEFT")
    body:SetSpacing(2)
    box.body = body

    -- one button for reading, two when the box is asking something
    local right = CreateFrame("Button", nil, box, "UIPanelButtonTemplate")
    right:SetSize(150, 22)
    right:SetPoint("BOTTOM", 0, 12)
    box.right = right

    local left = CreateFrame("Button", nil, box, "UIPanelButtonTemplate")
    left:SetSize(150, 22)
    left:SetPoint("RIGHT", right, "LEFT", -8, 0)
    box.left = left

    -- a new frame starts shown, and the queue below reads shown as busy
    box:Hide()
    table.insert(UISpecialFrames, "AztarecHelperNotice")
end

-- text with one dismiss button, or a question with a choice on either side
-- One box, so asks that land together queue up behind it and take their
-- turn as it closes. Delve entry raises up to two at once, the automatic
-- offer and a party role ask.
local queue = {}
local show

local function showNext()
    local nxt = table.remove(queue, 1)
    if nxt then
        show(nxt.title, nxt.text, nxt.ask)
    end
end

function show(title, text, ask)
    if not box then
        build()
        box:SetScript("OnHide", showNext)
    end
    if box:IsShown() then
        queue[#queue + 1] = { title = title, text = text, ask = ask }
        return
    end
    box.title:SetText(title)
    box.body:SetText(text)
    box:SetHeight(38 + box.body:GetStringHeight() + 48)
    box.left:SetShown(ask and true or false)
    box.right:ClearAllPoints()
    if ask then
        box.left:SetText(ask.leftText)
        box.left:SetScript("OnClick", function()
            box:Hide()
            ask.left()
        end)
        -- shifted right so the pair sits centred with the left button
        box.right:SetPoint("BOTTOM", 79, 12)
        box.right:SetText(ask.rightText)
        box.right:SetScript("OnClick", function()
            box:Hide()
            ask.right()
        end)
    else
        box.right:SetPoint("BOTTOM", 0, 12)
        box.right:SetText("Got it")
        box.right:SetScript("OnClick", function()
            box:Hide()
        end)
    end
    box:Show()
end

-- the options panel's Updates button reopens the notice any time
function AZT.ShowNotice()
    show(NERF_TITLE, NERF)
end

function AZT.ShowInstructions()
    show(INSTR_TITLE, INSTR)
end

-- The compass arrow changes what the arrow points at, but the voice has no
-- compass mode, it keeps talking as if you face the boss. Said once when
-- the compass is first ticked, with the choice in hand, instead of
-- silently mixing the two readings. Anyone who ran the compass before this
-- ask existed is grandfathered by the bootstrap and keeps their cue toggle
-- as it stands.
local COMPASS_TITLE = "Compass arrow and the spoken cues"
local COMPASS_CUES = "With compass arrow, the arrow points the way the room view does "
    .. "but the voices still talk as if you are facing the boss. "
    .. "Disable Solo spoken cues in options if you want the arrow to be the only cue. "

function AZT.ShowCompassCueAsk()
    AztarecHelperDB.compassCueAsked = true
    show(COMPASS_TITLE, COMPASS_CUES, {
        leftText = "Turn cues off",
        left = function()
            AztarecHelperDB.cues = false
            AZT.chat("solo spoken cues: OFF")
        end,
        rightText = "Keep the cues",
        right = function() end,
    })
end

-- Party play, offered when the role calls for it: the leader hears about
-- calling, everyone else about following. Core/Follow.lua decides when to
-- show these, once per stint in a role, and the options keep both
-- changeable at any time.
local CALL_TITLE = "Call the route for your party?"
local CALL_TEXT = "You lead this group. With calling on, your answer keys also name each"
    .. " quarter in party chat as you record, by its marker number or as a direction if you"
    .. " switch that on, and party members running the addon see your route on the boss's"
    .. " timing. The keys work"
    .. " as before otherwise. One ask for the group: keep party chat quiet during the"
    .. " fight, since stray lines land on the followers' boards as garbage. Declining"
    .. " keeps the semi automatic mode, where you record and answer for yourself only."
    .. " Either way you can change your mind under Party in the options."

function AZT.ShowCallAsk()
    show(CALL_TITLE, CALL_TEXT, {
        leftText = "Call the route",
        left = function()
            AZT.SetCallRoute(true)
            AZT.chat("route calling: ON while you lead")
        end,
        rightText = "Stay semi automatic",
        right = function() end,
    })
end

local FOLLOW_TITLE = "Follow the leader's calls?"
local FOLLOW_TEXT = "Someone else leads this group. With following on, their route calls show"
    .. " on a board of their own and on the wave countdown, timed by the boss like always."
    .. " A leader who calls directions rather than markers gets read out loud as well, which"
    .. " is its own tickbox under Party. The addon can show the calls but never read them, so"
    .. " the arrow and the solo cues lock off while you follow,"
    .. " and any party chat during the sermon lands on the board. Declining keeps the semi"
    .. " automatic mode, where you record and answer for yourself like when solo. Either way"
    .. " you can change your mind under Party in the options."

function AZT.ShowFollowAsk()
    show(FOLLOW_TITLE, FOLLOW_TEXT, {
        leftText = "Follow the calls",
        left = function()
            AZT.SetFollow(true)
            AZT.chat("following the leader: ON")
        end,
        rightText = "Stay semi automatic",
        right = function() end,
    })
end

-- Automatic recording is offered once, in the delve and out of combat,
-- rather than switched on behind the player's back. It needs the minimap
-- set to rotate, so saying yes turns that on too when it is off.
local AUTO_TITLE = "Record the route automatically?"
local AUTO = "This addon can record the route on its own while you dodge, so you never touch a key "
    .. "during the Sermon. It reads which way you face off the minimap, which means your minimap "
    .. "has to rotate with you. Saying yes turns that on for the delve if yours does not, and "
    .. "puts it back the way it was when you leave. Nothing else changes.\n\n"
    .. "One rule: keep the boss in front of you while you dodge. The quarter behind you, the "
    .. "one glowing at the bottom of the room view, is what each wave records as safe.\n\n"
    .. "The quarter keys, marking and calling belong to recording by hand and stand down while "
    .. "the route records itself. The Recording switch in the settings flips between the two "
    .. "whenever you like."

function AZT.ShowAutoOffer()
    show(AUTO_TITLE, AUTO, {
        leftText = "Record automatically",
        left = function()
            AZT.LendRotation()
            AZT.SetManualMode(false)
        end,
        rightText = "Keep recording by hand",
        right = function()
            AztarecHelperDB.autoAsked = true
            -- the party role ask stood aside for this box, its turn now
            if AZT.Follow then
                AZT.Follow.Sync()
            end
        end,
    })
end

-- Automatic recording with a minimap that does not rotate records nothing.
-- Comes up when the switch is flipped with rotation off, and on entering
-- the delve if rotation went off since and the addon is not already
-- turning it on for the visit, once a session so it does not nag
local ROTATE_TITLE = "One setting to turn on"
local ROTATE = "The route records itself only while your minimap rotates with you, and yours does "
    .. "not right now.\n\n"
    .. "Turning it on changes nothing else. Your minimap spins as you turn instead of holding north "
    .. "up while you are in here, and it goes back to the way it was when you leave.\n\n"
    .. "If you would rather leave it alone, the addon records by hand instead and you press a "
    .. "quarter key for each wave. Either way the callouts work the same."

function AZT.ShowRotateOffer()
    show(ROTATE_TITLE, ROTATE, {
        leftText = "Turn rotation on",
        left = function()
            AZT.LendRotation()
        end,
        rightText = "Record by hand",
        right = function()
            AZT.SetManualMode(true)
        end,
    })
end

local rotateOffered -- this session

local ef = CreateFrame("Frame")
ef:RegisterEvent("PLAYER_ENTERING_WORLD")
ef:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ef:SetScript("OnEvent", function()
    if not AZT.InDelve() then
        return
    end
    if not AztarecHelperDB.nerfNoticeSeen then
        AztarecHelperDB.nerfNoticeSeen = true
        AZT.ShowNotice()
        return
    end
    -- the offers wait their turn, one box at a time
    if not AztarecHelperDB.autoAsked and not AZT.Safe.IsAuto() then
        AZT.ShowAutoOffer()
    elseif AZT.Safe.IsAuto() and not AztarecHelperDB.autoRotate and not rotateOffered then
        -- past this point the addon is not lending the rotation itself
        if GetCVar("rotateMinimap") ~= "1" then
            rotateOffered = true
            AZT.ShowRotateOffer()
        end
    end
end)
