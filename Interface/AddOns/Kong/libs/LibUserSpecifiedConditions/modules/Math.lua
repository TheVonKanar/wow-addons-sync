local LibUSC = LibStub and LibStub("LibUserSpecifiedConditions", true)
if not LibUSC then return end

local CATEGORY = "Math"

LibUSC:RegisterParameter("User-Entered Number", { 
    version = 2,
    type = "Number",
    category = "User-Entered",
    description = "A number that is input by the user",
    isUserEntered = true,
    GetConfigString = function(self)
        return tostring(self:GetValue())
    end,
    
    Call = function(self)
        return self:GetValue() or 0
    end,
})
LibUSC:SetTypeDefault("Number", "User-Entered Number")

LibUSC:RegisterParameter("Percent", {
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "Converts a given number to a percent (equivalent to dividing by 100)",
    ParameterTypes = {
        "Number",
    },
    configString = "{1}%",
    
    Call = function(self)
        return self.Parameters[1]:GetValue()/100
    end,
})

LibUSC:RegisterParameter("Addition", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The sum of two numbers",
    ParameterTypes = {
        "Number",
        "Number",
    },
    configString = "{1} + {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() + self.Parameters[2]:GetValue()
    end,
})

LibUSC:RegisterParameter("Subtraction", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The difference of two numbers",
    ParameterTypes = {
        "Number",
        "Number",
    },
    configString = "{1} - {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() - self.Parameters[2]:GetValue()
    end,
})

LibUSC:RegisterParameter("Multiplication", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The product of two numbers",
    ParameterTypes = {
        "Number",
        "Number",
    },
    configString = "{1} x {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() * self.Parameters[2]:GetValue()
    end,
})

LibUSC:RegisterParameter("Division", { 
    version = 2,
    type = "Number",
    category = CATEGORY,
    description = "The quotient of two numbers",
    ParameterTypes = {
        "Number",
        "Number",
    },
    configString = "{1} \195\183 {2}",
    
    Call = function(self)
        return self.Parameters[1]:GetValue() / self.Parameters[2]:GetValue()
    end,
})
