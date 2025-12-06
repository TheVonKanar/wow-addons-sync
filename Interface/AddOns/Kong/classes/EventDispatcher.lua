local N, A = ... -- Addon (N)ame, (A)ddon Table


A.CLASSES = A.CLASSES or {}
local R = A.CLASSES -- Class (R)epository


local C = "EventDispatcher" -- (C)lass Name
assert(R[C] == nil)
R[C] = {}
local E, P = {}, R[C] -- (E)ncapusalated Members, (P)ublic Members


-- constructor


function P.construct()
	local self = {
		handlers = {},
	}

	return self
end


-- methods


	-- public


function P.registerEvent(self, event)
	assert(self.handlers[event] == nil)

	self.handlers[event] = {}
end


function P.unregisterEvent(self, event)
	assert(self.handlers[event] ~= nil)

	self.handlers[event] = nil
end


function P.isEventRegistered(self, event)
	return self.handlers[event] ~= nil
end


function P.dispatchEvent(self, event, ...)
	assert(self.handlers[event] ~= nil)

	for obj, handler in pairs(self.handlers[event]) do
		handler(obj, event, ...)
	end
end


function P.addListener(self, event, handler, obj)
	assert(self.handlers[event] ~= nil)
	assert(self.handlers[event][obj] == nil)

	self.handlers[event][obj] = handler
end


function P.removeListener(self, event, obj)
	assert(self.handlers[event] ~= nil)
	assert(self.handlers[event][obj] ~= nil)

	self.handlers[event][obj] = nil
end


function P.isAListener(self, event, obj)
	assert(self.handlers[event] ~= nil)

	return self.handlers[event][obj] ~= nil
end