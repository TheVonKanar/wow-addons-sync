local LibUSC = LibStub and LibStub:NewLibrary("LibUserSpecifiedConditions", 3)
if not LibUSC then return end -- no upgrade necessary

local pairs = _G.pairs;
local ipairs = _G.ipairs;

-- Client Interface --------------------------------------------------------------------------------
function LibUSC:Create(name, ...) 
    assert(type(name) == "string", "Bad param #1 (string expected, got "..tostring(name)..")")
    assert(self.Parameters[name], "Invalid name: "..name)
    
    local Parameter = {
        name = name,
    }
    
    if self.Parameters[name].ParameterTypes then
        Parameter.Parameters = {...}
    else
        Parameter.value = ...
    end
    
    self:Inflate(Parameter)
     
	if Parameter.Init then
		xpcall(function() Parameter:Init() end, geterrorhandler())
	end
    
    return Parameter
end

function LibUSC:Deflate(Param)
    assert(type(Param) == "table", "Bad param #1 (table expected, got "..tostring(Param)..")")
    assert(type(Param.name) == "string", "Name required, got "..tostring(Param.name)..")")
    --assert(getmetatable(Param), "Condition is already deflated")
    
    if Param.Events then
        for _, event in pairs(Param.Events) do
            self:UnregisterEvent(event, Param)
        end
    end
    
    self.UpdateListeners[Param] = nil
    
    Param.ValueListeners = nil
    Param.StructureListeners = nil

    if Param.Parameters then
    
        for _, Parameter in pairs(Param.Parameters) do
            self:Deflate(Parameter)
        end
    end
    
    if not Param.isUserEntered then
        Param.value = nil
    end
    
    setmetatable(Param, nil)
end

function LibUSC:Inflate(Param)
    assert(type(Param) == "table", "Bad param #1 (table expected, got "..tostring(Param)..")")
    assert(type(Param.name) == "string", "Name required, got "..tostring(Param.name)..")")
    assert(self.Parameters[Param.name], "Invalid name: "..Param.name)

    if not getmetatable(Param) then
        setmetatable(Param, {__index=self.Parameters[Param.name]})
        if Param.Events then
            for _, event in pairs(Param.Events) do
                self:RegisterEvent(event, Param)
            end
        end
        
        if Param.receivesUpdates then
            self.UpdateListeners[Param] = Param.updatePeriod
        end
        
        Param.ValueListeners = {}
        Param.StructureListeners = {}

        Param.Parameters = Param.Parameters or {}
        if Param.ParameterTypes then
            for i, paramType in ipairs(Param.ParameterTypes) do
                if not Param.Parameters[i] then
                    if paramType == "Any" then
                        Param.Parameters[i] = LibUSC:Create(
                            LibUSC:GetTypeDefault("Truth"):GetName())
                    else
                        Param.Parameters[i] = LibUSC:Create(
                            LibUSC:GetTypeDefault(paramType):GetName())
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
		
		-- remove extra parameters from saved variables; ticket #6
		local numTypes = (Param.ParameterTypes and #Param.ParameterTypes or 0) + 1
		for i = #Param.Parameters, numTypes, -1 do
			table.remove(Param.Parameters, i)
		end
        
        if Param.Call and not Param.value then
            xpcall(function() Param:SetValue() end, geterrorhandler())
        end
    end
end

-- Base Function -----------------------------------------------------------------------------------
LibUSC.BaseParameter = LibUSC.BaseParameter or {}
LibUSC.BaseParameter.category = "Misc"

function LibUSC.BaseParameter:GetName()
    return self.name
end

function LibUSC.BaseParameter:GetType()
    return self.type
end

function LibUSC.BaseParameter:GetCategory()
    return self.category
end

function LibUSC.BaseParameter:GetVersion()
    return self.version or 1
end

function LibUSC.BaseParameter:GetEvents()
    return self.Events
end

function LibUSC.BaseParameter:GetParameterTypes()
    return self.ParameterTypes
end

function LibUSC.BaseParameter:GetConfigString()
    return self.ConfigString
end


function LibUSC.BaseParameter:GetDescription()
    return self.description
end

function LibUSC.BaseParameter:GetParameter(index)
    return self.Parameters[index]
end

function LibUSC.BaseParameter:SetParameter(index, Parameter, preservePrevious)
    assert(type(index) == "number", "Bad param #1 (number expected, got "..tostring(index)..")")
    assert(type(Parameter) == "table", "Bad param #2 (table expected, got "..tostring(Parameter)..")")
  
    previousParam = self.Parameters[index]
    
    -- Remove the old parameter
    if previousParam then
        if previousParam.RemoveListener then
            previousParam:RemoveListener(self.SetValue, self)
        end
        if previousParam.RemoveStructureListener then
            previousParam:RemoveStructureListener(self.FireStructureChanged, self)
        end
        if not preservePrevious then
            LibUSC:Deflate(previousParam)
        end
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
    
    return previousParam
end

function LibUSC.BaseParameter:IsValid()
    return true
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

local TempCallback, TempParams
local function FireValueChanged()
    TempCallback(unpack(TempParams))
end

function LibUSC.BaseParameter:FireValueChanged()
    for Callback, Instances in pairs(self.ValueListeners) do
        TempCallback = Callback
        for Instance, Params in pairs(Instances) do
            TempParams = Params
            xpcall(FireValueChanged, geterrorhandler())
        end
    end
end

function LibUSC.BaseParameter:GetValue()
    return self.value
end

function LibUSC.BaseParameter:SetValue(value)
    if nil == value then
        local status, result = pcall(self.Call, self)
        if status then
            value = result
        else
            value = self.value
            geterrorhandler()(result)
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

local function FireStructureChanged()
    TempCallback(unpack(TempParams))
end

function LibUSC.BaseParameter:FireStructureChanged()
    for Callback, Params in pairs(self.StructureListeners) do
        TempCallback, TempParams = Callback, Params
        xpcall(FireStructureChanged, geterrorhandler())
    end
end

function LibUSC.BaseParameter:GetConfigString()
    return self.configString or self.name
end

function LibUSC.BaseParameter:GetMenuOverrideString()
    return self.menuOverrideString
end

function LibUSC.BaseParameter:OnEvent(event)
    self:SetValue(self:Call())
end

LibUSC.BaseParameter.updatePeriod = .1   
function LibUSC.BaseParameter:OnUpdate(elapsed)
    self:SetValue(self:Call())
end

function LibUSC.BaseParameter:Clone()
    local clonedParams = {}
    for i, Param in ipairs(self.Parameters) do
        tinsert(clonedParams, Param:Clone())
    end
    if self.isUserEntered then
        tinsert(clonedParams, self.value)
    end
    return LibUSC:Create(self.name, unpack(clonedParams))
end

-- Condition API -----------------------------------------------------------------------------------
function LibUSC:RegisterParameter(name, Param)
    assert(type(name) == "string", "Bad param #1 (string expected, got "..tostring(name)..")")
    assert(type(Param) == "table", "Bad param #2 (table expected, got "..tostring(Param)..")")
    assert(type(Param.type) == "string", "Type required, got "..tostring(Param.type)..")")
    
    Param.name = name
    setmetatable(Param, {__index=LibUSC.BaseParameter})
    if Param:GetVersion() > self:GetParameterVersion(Param.name) then
        self.Parameters[name] = Param
        self.TypeDefaults[Param.type] = self.TypeDefaults[Param.type] or Param
    end
end

function LibUSC:GetParameterVersion(name)
    assert(type(name) == "string", "Bad param #1 (string expected, got "..tostring(name)..")")
    
    if self.Parameters[name] then
        return self.Parameters[name].version or 1
    end
    return 0
end

function LibUSC:SetTypeDefault(class, name)
    assert(type(class) == "string", "Bad param #1 (string expected, got "..tostring(class)..")")
    assert(type(name) == "string", "Bad param #1 (string expected, got "..tostring(name)..")")
    assert(self.Parameters[name], "Invalid Function name: "..name)
    
    self.TypeDefaults[class] = self.Parameters[name]
end

-- Internal ----------------------------------------------------------------------------------------
function LibUSC:GetTypeDefault(class) 
    assert(type(class) == "string" or type(class) == "table", 
        "Bad param #1 (string or table expected, got "..tostring(class)..")")
    
    if (type(class) == "table") then
        return self.TypeDefaults[class[1]] or error("Unknown type: "..class[1])
    else 
        return self.TypeDefaults[class] or error("Unknown type: "..class)
    end
end

function LibUSC:RegisterEvent(event, Param)

    if not self.EventListeners[event] then
        self.EventListeners[event] = {}
        LibUSC.frame:RegisterEvent(event)
    end
    
    assert(not self.EventListeners[event][Param])
    self.EventListeners[event][Param] = true
end

function LibUSC:UnregisterEvent(event, Param)

    assert(self.EventListeners[event][Param])
    self.EventListeners[event][Param] = nil
    
    if not next(self.EventListeners[event]) then
        self.EventListeners[event] = nil
        LibUSC.frame:UnregisterEvent(event)
    end
end

LibUSC.frame = CreateFrame("Frame");

LibUSC.frame:SetScript("OnEvent", function(_, event, ...)
    if LibUSC.EventListeners[event] then
        for Param, Args in pairs(LibUSC.EventListeners[event]) do
            local result, errMsg = pcall(Param.OnEvent, Param, event, ...)
            if not result then
                geterrorhandler()(errMsg)
            end
        end
    end
end)

LibUSC.frame:SetScript("OnUpdate", function(_, elapsed)
    for Param, timer in pairs(LibUSC.UpdateListeners) do
        timer = timer - elapsed
        if timer <= 0 then
            timer = Param.updatePeriod
            local result, errMsg = pcall(Param.OnUpdate, Param, elapsed)
            if not result then
                geterrorhandler()(errMsg)
            end
        end
        LibUSC.UpdateListeners[Param] = timer
    end
end)

LibUSC.Parameters = {}
LibUSC.TypeDefaults = {}
LibUSC.EventListeners = {}
LibUSC.UpdateListeners = {}