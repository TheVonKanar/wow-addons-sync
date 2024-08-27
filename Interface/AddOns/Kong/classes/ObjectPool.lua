local N, A = ... -- Addon (N)ame, (A)ddon Table


A.CLASSES = A.CLASSES or {}
local R = A.CLASSES -- Class (R)epository


local C = "ObjectPool" -- (C)lass Name
assert(R[C] == nil)
R[C] = {}
local E, P = {}, R[C] -- (E)ncapusalated Members, (P)ublic Members


-- constructor


function P.construct(constructFunc, constructObj, setUpFunc, setUpObj, tearDownFunc, tearDownObj)
	local self = {
		constructFunc = constructFunc,
		constructObj = constructObj,
		setUpFunc = setUpFunc,
		setUpObj = setUpObj,
		tearDownFunc = tearDownFunc,
		tearDownObj = tearDownObj,
		--
		pool = {}, -- set
	}

	return self
end


-- instance members


	-- public methods


function P.acquire(self)
	local obj = next(self.pool)
	local isFresh = obj == nil

	obj = obj or self.constructFunc(self.constructObj)
	self.pool[obj] = nil

	if ( self.setUpFunc ~= nil ) then
		self.setUpFunc(self.setUpObj, obj)
	end

	return obj, isFresh
end


function P.release(self, obj)
	if ( self.tearDownFunc ~= nil ) then
		self.tearDownFunc(self.tearDownObj, obj)
	end

	self.pool[obj] = 1
end