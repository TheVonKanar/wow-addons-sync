local LibUSC = LibStub and LibStub("LibUserSpecifiedConditions", true)
if not LibUSC then return end

local CATEGORY = "Logic"

-- The hidden root parameter for all conditions
LibUSC:RegisterParameter("Condition", { 
    version = 2,
    type = "Truth",
    isHidden = true,
    ParameterTypes = {
        "Truth",
    },
    configString = "{1}",

    Call = function(self)
        return self.Parameters[1]:GetValue() == true
    end,
    
    IsMet = function(self)
        return self:GetValue()
    end,
})
	
LibUSC:RegisterParameter("True", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    value = true,
    description = "Always True",
})

LibUSC:RegisterParameter("False", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    value = false,
    description = "Always False",
})
LibUSC:SetTypeDefault("Truth", "False")

LibUSC:RegisterParameter("And", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when two values are both true",
    ParameterTypes = {
        "Truth",
        "Truth",
    },
    configString = "{1} And {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() and self.Parameters[2]:GetValue()
    end,
})

LibUSC:RegisterParameter("Or", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when either of two values is true",
    ParameterTypes = {
        "Truth",
        "Truth",
    },
    configString = "{1} Or {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() or self.Parameters[2]:GetValue()
    end,
})

LibUSC:RegisterParameter("Not", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when the given value is false",
    ParameterTypes = {
        "Truth",
    },
    configString = "Not {1}",
    
    Call = function(self)
        return not self.Parameters[1]:GetValue()
    end,
})

LibUSC:RegisterParameter("Equal", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when two values are the same",
    ParameterTypes = {
        "Any",
        "Any",
    },
    configString = "{1} = {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() == self.Parameters[2]:GetValue()
    end,
    
    IsValid = function(self)
        if self.Parameters[1]:GetType() ~= self.Parameters[2]:GetType() then
            return false, "Cannot compare type "..self.Parameters[1]:GetType().." to type "
                          ..self.Parameters[2]:GetType()..".  Both types must be the same."
        end
        return true
    end,
})

LibUSC:RegisterParameter("Not Equal", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when two values are not the same",
    ParameterTypes = {
        "Any",
        "Any",
    },
    configString = "{1} =/= {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() ~= self.Parameters[2]:GetValue()
    end,
    
    IsValid = function(self)
        if self.Parameters[1]:GetType() ~= self.Parameters[2]:GetType() then
            return false, "Cannot compare type "..self.Parameters[1]:GetType().." to type "
                          ..self.Parameters[2]:GetType()..".  Both types must be the same."
        end
        return true
    end,
})

LibUSC:RegisterParameter("Less Than", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when the left-side number is less than the right",
    ParameterTypes = {
        "Number",
        "Number",
    },
    configString = "{1} < {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() < self.Parameters[2]:GetValue()
    end,
})

LibUSC:RegisterParameter("Greater Than", { 
    version = 2,
    type = "Truth",
    category = CATEGORY,
    description = "True when the left-side number is greater than the right",
    ParameterTypes = {
        "Number",
        "Number",
    },
    configString = "{1} > {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() > self.Parameters[2]:GetValue()
    end,
})
