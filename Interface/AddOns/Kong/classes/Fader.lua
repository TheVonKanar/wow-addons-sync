local N, A = ... -- Addon (N)ame, (A)ddon Table


A.CLASSES = A.CLASSES or {}
local R = A.CLASSES -- Class (R)epository


local C = "Fader" -- (C)lass Name
assert(R[C] == nil)
R[C] = {}
local E, P = {}, R[C] -- (E)ncapusalated Members, (P)ublic Members


-- constructor


function P.construct()
	local self = {
		events = R.EventDispatcher.construct(),
		groupPool = R.ObjectPool.construct(),
		--
		frame = CreateFrame("Frame"),
		activeGroups = {}, -- map
	}
	
	R.EventDispatcher.registerEvent(self.events, "FADE_STARTED")
	R.EventDispatcher.registerEvent(self.events, "FADE_STOPPED")
	R.EventDispatcher.registerEvent(self.events, "FADE_FINISHED")
	
	self.groupPool.constructFunc = E.constructAnimationGroup
	self.groupPool.constructObj = self
	self.groupPool.tearDownFunc = E.tearDownAnimationGroup
	self.groupPool.tearDownObj = self
	
	return self
end


-- private methods


function E.constructAnimationGroup(self)
	local group = self.frame:CreateFontString():CreateAnimationGroup()
	local animation = group:CreateAnimation("Alpha")
	
	group:SetToFinalAlpha(true)
	group:SetScript("OnPlay", function(...) E.animationGroup_onPlay(self, ...) end)
	group:SetScript("OnStop", function(...) E.animationGroup_onStop(self, ...) end)
	group:SetScript("OnFinished", function(...) E.animationGroup_onFinshed(self, ...) end)
	group:SetScript("OnUpdate", function(...) E.animationGroup_onUpdate(self, ...) end)
	group.animation = animation
	
	return group
end


function E.tearDownAnimationGroup(self, group)
	self.activeGroups[group.region] = nil
	group.region = nil
end


-- public methods


function P.addListener(self, event, handler, obj) R.EventDispatcher.addListener(self.events, event, handler, obj) end
function P.removeListener(self, event, obj) R.EventDispatcher.removeListener(self.events, event, obj) end
function P.isAListener(self, event, obj) R.EventDispatcher.isAListener(self.events, event, obj) end


function P.fade(self, region, fromAlpha, toAlpha, duration, smoothing, startDelay, endDelay)
	fromAlpha = fromAlpha or self.frame.GetAlpha(region)
	duration = duration == 0 and 0.001 or duration -- edge case: convert 0 to a millisecond
	smoothing = smoothing or "NONE"
	startDelay = startDelay or 0
	endDelay = endDelay or 0
	
	P.stopFade(self, region)
	
	local group = R.ObjectPool.acquire(self.groupPool)
	local animation = group.animation
	
	animation:SetFromAlpha(fromAlpha)
	animation:SetToAlpha(toAlpha)
	animation:SetDuration(duration)
	animation:SetSmoothing(smoothing)
	animation:SetStartDelay(startDelay)
	animation:SetEndDelay(endDelay)
	
	self.activeGroups[region] = group
	group.region = region
	
	group:Play()
end


function P.stopFade(self, region)
	if ( not P.isFading(self, region) ) then return end
	self.activeGroups[region]:Stop()
end


function P.isFading(self, region)
	return self.activeGroups[region] ~= nil
end


-- animationGroup events


function E.animationGroup_onPlay(self, group)
	local region = group.region
	local animation = group.animation
	local fromAlpha = animation:GetFromAlpha()
	local toAlpha = animation:GetToAlpha()
	local duration = animation:GetDuration()
	local smoothing = animation:GetSmoothing()
	local startDelay = animation:GetStartDelay()
	local endDelay = animation:GetEndDelay()
	
	R.EventDispatcher.dispatchEvent(self.events, "FADE_STARTED", region, fromAlpha, toAlpha, duration, smoothing, startDelay, endDelay)
end


function E.animationGroup_onStop(self, group)
	local region = group.region
	
	R.ObjectPool.release(self.groupPool, group)
	R.EventDispatcher.dispatchEvent(self.events, "FADE_STOPPED", region)
end


function E.animationGroup_onFinshed(self, group)
	local region = group.region
	local animation = group.animation
	local toAlpha = animation:GetToAlpha()
	
	self.frame.SetAlpha(region, toAlpha)
	R.ObjectPool.release(self.groupPool, group)
	R.EventDispatcher.dispatchEvent(self.events, "FADE_FINISHED", region)
end


function E.animationGroup_onUpdate(self, group)
	local animation = group.animation
	local fromAlpha = animation:GetFromAlpha()
	local displacement = animation:GetToAlpha() - fromAlpha
	local alpha = fromAlpha + (displacement * animation:GetSmoothProgress())
	
	self.frame.SetAlpha(group.region, alpha)
end