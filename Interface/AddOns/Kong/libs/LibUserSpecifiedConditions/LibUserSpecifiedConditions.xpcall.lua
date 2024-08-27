local LibUSC = LibStub and LibStub:NewLibrary("LibUserSpecifiedConditions", 1)
if not LibUSC then return end -- no upgrade necessary

-- Client Interface --------------------------------------------------------------------------------
function LibUSC:CreateCondition(class, name, ...)
    
    local Condition = self:CreateFunction("Boolean", "Condition")
    
    if class then
        Condition:SetParameter(1, self:CreateFunction(class, name, ...))
    end
    
    return Condition
end

function LibUSC:Deflate(Param)
    assert(type(Param) == "table", "Bad param #1 (table expected, got "..tostring(Param)..")")
    assert(type(Param.type) == "string", "Type required, got "..tostring(Param.type)..")")
    assert(type(Param.name) == "string", "Name required, got "..tostring(Param.name)..")")
    assert(getmetatable(Param), "Condition is already deflated")
    
    if Param.events then
        for _, event in pairs(Param.events) do
            self:UnregisterEvent(event, Param)
        end
    end
    
    self.UpdateListeners[Param] = nil
    
    if Param.Parameters then
        for _, Parameter in pairs(Param.Parameters) do
            self:Deflate(Parameter)
        end
    end
    
    for key in pairs(Param) do
        if (key ~= "type") and (key ~= "name") and (key ~= "version") and (key ~= "Parameters")
            and not (key == "value" and Param.isUserEntered) then
            Param[key] = nil
        end
    end
end

function LibUSC:Inflate(Param)
    assert(type(Param) == "table", "Bad param #1 (table expected, got "..tostring(Param)..")")
    assert(type(Param.type) == "string", "Type required, got "..tostring(Param.type)..")")
    assert(type(Param.name) == "string", "Name required, got "..tostring(Param.name)..")")
    assert(getmetatable(Param) == nil, "Condition is already inflated")
    assert(self.Parameters[Param.type] and self.Parameters[Param.type][Param.name], 
        "Invalid Function type/name pair: "..Param.type..", "..Param.name)

    setmetatable(Param, {__index=self.Parameters[Param.type][Param.name]})
    if Param.Events then
        for _, event in pairs(Param.Events) do
            self:RegisterEvent(event, Param)
        end
    end
    
    if Param.OnUpdate or Param.updatePeriod then
        Param.updatePeriod = Param.updatePeriod or .1
        self.UpdateListeners[Param] = Param.updatePeriod
    end
    
    Param.ValueListeners = {}
    Param.StructureListeners = {}

    Param.Parameters = Param.Parameters or {}
    if Param.ParameterTypes then
        for i, paramType in ipairs(Param.ParameterTypes) do
            if not Param.Parameters[i] then
                if paramType == "Any" then
                    Param.Parameters[i] = LibUSC:CreateFunction("Boolean", LibUSC:GetTypeDefault("Boolean"))
                else
                    Param.Parameters[i] = LibUSC:CreateFunction(paramType, LibUSC:GetTypeDefault(paramType))
                end
            else
                self:Inflate(Param.Parameters[i])
            end

            if Param.Parameters[i].AddListener then
                Param.Parameters[i]:AddListener(Param.SetValue, Param)
            end
            if Param.Parameters[i].AddStructureListener then
                Param.Parameters[i]:AddStructureListener(Param.FireStructureChanged, Param)
            end
        end
    end
 
    if Param.Call then
        xpcall(function() Param:SetValue() end, geterrorhandler())
    end
end

-- Base Function -----------------------------------------------------------------------------------
LibUSC.BaseParameter = LibUSC.BaseParameter or {}
LibUSC.BaseParameter.category = "Uncategorized"

function LibUSC.BaseParameter:SetParameter(index, Parameter)
    assert(type(index) == "number", "Bad param #1 (number expected, got "..tostring(index)..")")
    assert(type(Parameter) == "table", "Bad param #1 (table expected, got "..tostring(Parameter)..")")
  
    -- Remove the old parameter
    if self.Parameters[index] then
        if self.Parameters[index].RemoveListener then
            self.Parameters[index]:RemoveListener(self.SetValue, self)
        end
        if self.Parameters[index].RemoveStructureListener then
            self.Parameters[index]:RemoveStructureListener(self.FireStructureChanged, self)
        end
        LibUSC:Deflate(self.Parameters[index])
    end
    
    -- Add the new parameter
    self.Parameters[index] = Parameter
    if Parameter.AddListener then
        Parameter:AddListener(self.SetValue, self)
    end
    if Parameter.AddStructureListener then
        Parameter:AddStructureListener(self.FireStructureChanged, self)
    end
    
    self:SetValue()
    self:FireStructureChanged()
end

function LibUSC.BaseParameter:AddListener(arg1, arg2, ...)

    local Instance, Callback, Parameters
    
    if type(arg1) == "table" then
        assert(type(arg2) == "function", 
            "Bad param #2 (function expected, got "..tostring(arg2)..")")
        
        Instance = arg1
        Callback = arg2
        Parameters = {arg1, ...}
    else
        assert(type(arg1) == "function", 
            "Bad param #1 (table or function expected, got "..tostring(arg1)..")")
            
        Instance = 1
        Callback = arg1
        Parameters = {arg2, ...}
    end
        
    self.ValueListeners[Callback] = self.ValueListeners[Callback] or {}
    assert(nil == self.ValueListeners[Callback][Instance], "Listener already registered")
    self.ValueListeners[Callback][Instance] = Parameters
end

function LibUSC.BaseParameter:RemoveListener(arg1, arg2)

    local Instance, Callback
    
    if type(arg1) == "table" then
        assert(type(arg2) == "function", 
            "Bad param #2 (function expected, got "..tostring(arg2)..")")
        
        Instance = arg1
        Callback = arg2
        
    else
        assert(type(arg1) == "function", 
            "Bad param #1 (table or function expected, got "..tostring(arg1)..")")
            
        Instance = 1
        Callback = arg1
    end
    
    assert(self.ValueListeners[Callback][Instance], "No such listener")
    self.ValueListeners[Callback][Instance] = nil
    
    if not next(self.ValueListeners[Callback]) then
        self.ValueListeners[Callback] = nil
    end
end

function LibUSC.BaseParameter:FireValueChanged()
    for Callback, Instances in pairs(self.ValueListeners) do
        for Instance, Parameters in pairs(Instances) do
            xpcall(function() Callback(unpack(Parameters)) end, geterrorhandler())
        end
    end
end

function LibUSC.BaseParameter:SetValue(value)
    if nil == value then
        local status, result = pcall(self.Call, self)
        if status then
            value = result
        else
            value = self.value
            self.error = result
        end 
    end
    if value ~= self.value then
-- print(self.name, value)
        self.value = value
        self:FireValueChanged()
    end
end

function LibUSC.BaseParameter:Equals(Condition)

    if (self.type ~= Condition.type) or (self.name ~= Condition.name) 
    or (self:GetConfigString() ~= Condition:GetConfigString()) 
    or (#self.Parameters ~= #Condition.Parameters) then
        return false
    end
    
    for i=1,#self.Parameters do
        if not self.Parameters[i]:Equals(Condition.Parameters[i]) then
            return false
        end
    end
    
    return true
end

function LibUSC.BaseParameter:AddStructureListener(Callback, ...)
    assert(type(Callback) == "function", "Bad param #1 (function expected, got "..tostring(Callback)..")")
    
    local Args = {...}
    self.StructureListeners[Callback] = Args
end

function LibUSC.BaseParameter:RemoveStructureListener(Callback)
    for i, Listener in ipairs(self.StructureListeners) do
        if Listener == Callback then
            tremove(self.StructureListeners, i)
            break
        end
    end
end

function LibUSC.BaseParameter:FireStructureChanged()
    for Callback, Args in pairs(self.StructureListeners) do
        xpcall(function() Callback(unpack(Args)) end, geterrorhandler())
    end
end

function LibUSC.BaseParameter:GetConfigString()
    return self.configString or self.name
end

function LibUSC.BaseParameter:OnEvent(event)
    self:SetValue(self:Call())
end
   
function LibUSC.BaseParameter:OnUpdate(elapsed)
    self:SetValue(self:Call())
end
 
-- Widgets TODO remove -----------------------------------------------------------------------------
function LibUSC:CreateUnitDropDown(multiSelect)
    assert(nil == multiSelect, "multiSelect not yet supported") 

    local AceGUI = LibStub("AceGUI-3.0")
    local DropDown = AceGUI:Create("EasyMenuDropDown")
    
    DropDown:AddItem("player")
    DropDown:AddItem("target")
    DropDown:AddItem("focus")
    DropDown:AddItem("pet")
    DropDown:AddItem("vehicle")
    DropDown:AddItem("mouseover")
    
    local partyItem = DropDown:AddItem("party")
    for i=1,4 do
        DropDown:AddItem("party"..i, partyItem)
    end
    
    local raidItem = DropDown:AddItem("raid")
    for i=1,8 do
        local groupItem = DropDown:AddItem("group"..i, raidItem)
        for j=1,5 do 
            DropDown:AddItem("raid"..((i*5)-5+j), groupItem)
        end
    end
    
    local targetOfItem = DropDown:AddItem("target of")
    for _, item in ipairs(DropDown.menuList) do
        DropDown:AddItem(item, targetOfItem)
    end
    
    return DropDown
end

-- Condition API -----------------------------------------------------------------------------------
function LibUSC:RegisterParameter(Param)
    assert(type(Param) == "table", "Bad param #1 (table expected, got "..tostring(Param)..")")
    assert(type(Param.type) == "string", "Type required, got "..tostring(Param.type)..")")
    assert(type(Param.name) == "string", "Name required, got "..tostring(Param.name)..")")
    assert(type(Param.version) == "number", 
        "Version required, got "..tostring(Param.version)..")")
    assert((type(Param.Call) == "function") or (Param.value ~= nil), 
        "Either a preset 'value' field or 'Call' method are required")
    
    if Param.version > self:GetParameterVersion(Param.type, Param.name) then
        setmetatable(Param, {__index=LibUSC.BaseParameter})
        self.Parameters[Param.type] = self.Parameters[Param.type] or {}
        self.Parameters[Param.type][Param.name] = Param
        self.TypeDefaults[Param.type] = self.TypeDefaults[Param.type] or Param
    end
end

function LibUSC:SetTypeDefault(class, name)
    assert(type(class) == "string", "Bad param #1 (string expected, got "..tostring(class)..")")
    assert(type(name) == "string", "Bad param #2 (string expected, got "..tostring(name)..")")
    assert(self.Parameters[class] and self.Parameters[class][name], 
        "Invalid Function type/name pair: "..class..", "..name)
    
    self.TypeDefaults[class] = self.Parameters[class][name]
end

function LibUSC:GetParameterVersion(class, name)
    assert(type(class) == "string", "Bad param #1 (string expected, got "..tostring(class)..")")
    assert(type(name) == "string", "Bad param #2 (string expected, got "..tostring(name)..")")
    
    if self.Parameters[class] and self.Parameters[class][name] then
        return self.Parameters[class][name].version
    end
    return 0
end

-- Internal ----------------------------------------------------------------------------------------
function LibUSC:CreateFunction(class, name, ...) 
    assert(type(class) == "string", "Bad param #1 (string expected, got "..tostring(class)..")")
    assert(type(name) == "string", "Bad param #2 (string expected, got "..tostring(name)..")")
    assert(self.Parameters[class] and self.Parameters[class][name], 
        "Invalid Function type/name pair: "..class..", "..name)
    
    local Function = {
        name = name,
        type = class,
    }
    if select("#", ...) > 0 then
        Function.Parameters = {...}
    end
    self:Inflate(Function)
    
    return Function
end

function LibUSC:GetTypeDefault(class) 
    assert(type(class) == "string", "Bad param #1 (string expected, got "..tostring(class)..")")
    
    if self.TypeDefaults[class] then
        return self.TypeDefaults[class].name
    end
    
    error("Unknown type: "..class)
end

function LibUSC:RegisterEvent(event, Function)

    if not self.EventListeners[event] then
        self.EventListeners[event] = {}
        LibUSC.frame:RegisterEvent(event)
    end
    
    assert(not self.EventListeners[event][Function])
    self.EventListeners[event][Function] = true
end

function LibUSC:UnregisterEvent(event, Function)

    assert(self.EventListeners[event][Function])
    self.EventListeners[event][Function] = nil
    
    if not next(self.EventListeners[event]) then
        self.EventListeners[event] = nil
        LibUSC.frame:UnregisterEvent(event)
    end
end

LibUSC.frame = CreateFrame("Frame");

local upParam, upEvent
local Args = {}
local function OnEvent()
    upParam:OnEvent(upEvent, unpack(Args))
end

LibUSC.frame:SetScript("OnEvent", function(_, event, ...)
    if LibUSC.EventListeners[event] then
        upEvent = event
        wipe(Args)
        for i=1,select("#",...) do
            local arg = select(i, ...)
            tinsert(Args, arg)
        end
        for Param in pairs(LibUSC.EventListeners[event]) do
            upParam = Param
            xpcall(OnEvent, geterrorhandler())
        end
    end
end)

local upElapsed
local function OnUpdate()
    upParam:OnUpdate(upElapsed) 
end

LibUSC.frame:SetScript("OnUpdate", function(_, elapsed)
    upElapsed = elapsed
    for Param, timer in pairs(LibUSC.UpdateListeners) do
        timer = timer - elapsed
        if timer <= 0 then
            timer = Param.updatePeriod
            upParam = Param
            xpcall(OnUpdate, geterrorhandler())
        end
        LibUSC.UpdateListeners[Param] = timer
    end
end)

LibUSC.Parameters = {}
LibUSC.TypeDefaults = {}
LibUSC.EventListeners = {}
LibUSC.UpdateListeners = {}