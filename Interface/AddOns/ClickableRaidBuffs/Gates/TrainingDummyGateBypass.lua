-- ====================================
-- \Gates\TrainingDummyGateBypass.lua
-- ====================================

local addonName, ns = ...

ns._trainingDummyBypass = false

local TRAINING_DUMMY_IDS = {
  [17578]=true,[24792]=true,[30527]=true,[31144]=true,[31146]=true,[32541]=true,
  [32542]=true,[32543]=true,[32545]=true,[32546]=true,[32666]=true,[32667]=true,
  [44171]=true,[44389]=true,[44548]=true,[44614]=true,[44703]=true,[44794]=true,
  [44820]=true,[44848]=true,[44937]=true,[46647]=true,[48304]=true,[60197]=true,
  [64446]=true,[67127]=true,[70245]=true,[79414]=true,[79987]=true,[83565]=true,
  [83571]=true,[83573]=true,[83574]=true,[83576]=true,[87317]=true,[87318]=true,
  [87320]=true,[87321]=true,[87322]=true,[87329]=true,[87760]=true,[87761]=true,
  [87762]=true,[88288]=true,[88289]=true,[88314]=true,[88316]=true,[88835]=true,
  [88836]=true,[88837]=true,[88967]=true,[89078]=true,[89321]=true,[92164]=true,
  [92165]=true,[92166]=true,[92167]=true,[92168]=true,[92169]=true,[93828]=true,
  [94457]=true,[96442]=true,[97668]=true,[98581]=true,[101956]=true,[102045]=true,
  [102048]=true,[102052]=true,[103397]=true,[103402]=true,[103404]=true,[104770]=true,
  [107202]=true,[107483]=true,[107484]=true,[107555]=true,[107556]=true,[107557]=true,
  [108420]=true,[109092]=true,[109093]=true,[109094]=true,[109095]=true,[109096]=true,
  [109097]=true,[109595]=true,[111824]=true,[112439]=true,[113636]=true,[113647]=true,
  [113673]=true,[113674]=true,[113676]=true,[113687]=true,[113858]=true,[113859]=true,
  [113860]=true,[113862]=true,[113863]=true,[113864]=true,[113871]=true,[113963]=true,
  [113964]=true,[113966]=true,[113967]=true,[114832]=true,[114840]=true,[117631]=true,
  [117881]=true,[126340]=true,[126712]=true,[126781]=true,[127019]=true,[129485]=true,
  [131975]=true,[131983]=true,[131985]=true,[131989]=true,[131990]=true,[131992]=true,
  [131994]=true,[131997]=true,[131998]=true,[132036]=true,[132976]=true,[134324]=true,
  [138048]=true,[143509]=true,[143947]=true,[144074]=true,[144075]=true,[144076]=true,
  [144077]=true,[144078]=true,[144079]=true,[144080]=true,[144081]=true,[144082]=true,
  [144083]=true,[144085]=true,[144086]=true,[149860]=true,[151022]=true,[153285]=true,
  [153292]=true,[154564]=true,[154567]=true,[154580]=true,[154583]=true,[154585]=true,
  [154586]=true,[155281]=true,[160325]=true,[160432]=true,[160434]=true,[160435]=true,
  [163534]=true,[171961]=true,[173072]=true,[173866]=true,[173867]=true,[173870]=true,
  [173873]=true,[173877]=true,[173879]=true,[173942]=true,[174435]=true,[174484]=true,
  [174487]=true,[174488]=true,[174489]=true,[174491]=true,[174565]=true,[174566]=true,
  [174567]=true,[174568]=true,[174569]=true,[174570]=true,[174571]=true,[175449]=true,
  [175450]=true,[175451]=true,[175452]=true,[175453]=true,[175455]=true,[175456]=true,
  [175462]=true,[188352]=true,[189082]=true,[189617]=true,[189632]=true,[190621]=true,
  [190623]=true,[190624]=true,[193563]=true,[194643]=true,[194644]=true,[194645]=true,
  [194646]=true,[194648]=true,[194649]=true,[196394]=true,[197833]=true,[197834]=true,
  [198594]=true,[213574]=true,[216367]=true,[219250]=true,[219251]=true,[222275]=true,
  [225976]=true,[225977]=true,[225978]=true,[225979]=true,[225980]=true,[225982]=true,
  [225983]=true,[225984]=true,[225985]=true,[232675]=true,[235830]=true,[237743]=true,
  [241333]=true,[242190]=true,[242758]=true,[242759]=true,[242760]=true,[242761]=true,
  [243166]=true,[243167]=true,[243168]=true,[243205]=true,[243206]=true,[243207]=true,
  [243208]=true,[243211]=true,[243212]=true,[243214]=true,[243940]=true,[244536]=true,
  [248169]=true,[249245]=true,[250220]=true,[250221]=true,[250222]=true,[250223]=true,
  [253159]=true,[255824]=true,[255825]=true,[256302]=true,[259653]=true,[260139]=true,
}

local function SafeEvaluate()
  if C_Secrets and C_Secrets.ShouldAurasBeSecret and C_Secrets.ShouldAurasBeSecret() then
    return false
  end

  if not UnitExists("target") then
    return false
  end

  local npcID = UnitCreatureID and UnitCreatureID("target")
  if not npcID then
    return false
  end

  if ns.Compat and ns.Compat.IsSecret and ns.Compat.IsSecret(npcID) then
    return false
  end

  if type(npcID) ~= "number" then
    return false
  end

  return TRAINING_DUMMY_IDS[npcID] == true
end

local function ApplyState(bypass)
  if ns._trainingDummyBypass ~= bypass then
    ns._trainingDummyBypass = bypass

    if type(ns.MarkGatesDirty) == "function" then
      ns.MarkGatesDirty()
    end
    if type(ns.MarkBagsDirty) == "function" then
      ns.MarkBagsDirty()
    end
    if type(ns.MarkRosterDirty) == "function" then
      ns.MarkRosterDirty()
    end
    if type(ns.MarkAurasDirty) == "function" then
      ns.MarkAurasDirty("player")
    end
    if type(ns.BypassEventThrottle) == "function" then
      ns.BypassEventThrottle()
    end
    if type(ns.PokeUpdateBus) == "function" then
      ns.PokeUpdateBus()
    end
  end
end

local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_TARGET")
f:RegisterEvent("PLAYER_REGEN_ENABLED")

f:SetScript("OnEvent", function(self, event, unit)
  if event == "UNIT_TARGET" and unit ~= "player" then
    return
  end
  C_Timer.After(0.1, function()
    ApplyState(SafeEvaluate())
  end)
end)

C_Timer.After(0.1, function()
  ApplyState(SafeEvaluate())
end)

local origPassesGates = ns.PassesGates

ns.PassesGates = function(data, playerLevel, inInstance, rested)
  if ns._trainingDummyBypass and data and data.gates then
    for i = 1, #data.gates do
      local name = data.gates[i]
      if name == "group" or name == "instance" or name == "rested" then
        return true
      end
    end
  end
  return origPassesGates(data, playerLevel, inInstance, rested)
end