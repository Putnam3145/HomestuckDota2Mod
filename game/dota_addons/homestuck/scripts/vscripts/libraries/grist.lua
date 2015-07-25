if Grist == nil then
  Grist = class({})
end

function Grist:GetGristGutter(team)
	self.gristGutter=self.gristGutter or {}
	self.gristGutter[team]=self.gristGutter[team] or {}
	return self.gristGutter[team]
end

function Grist:AdjustGristGutter(gristType,amount,team)
	local gristGutter=self:GetGristGutter(team)
	local curGristAmount=gristGutter[gristType]
	if curGristAmount-amount<0 then
		return false 
	else 
		gristGutter[gristType]=curGristAmount+amount
		gristGutter[total]:insert({amount=amount,color=gristType.color})
		print(gristGutter[gristType])
		return gristGutter[gristType]
	end
end

function Grist:GetGristCache(playerID)
	self.gristCache=self.gristCache or {}
	self.gristCache[playerID]=self.gristCache[playerID] or {}
	return self.gristCache[playerID]
end

function Grist:AdjustGristCache(gristType,amount,playerID)
	local gristCache=self:GetGristCache(playerID)
	gristCache[gristType]=gristCache[gristType] or 0
	local curGristAmount=gristCache[gristType]
	if curGristAmount-amount<0 then
		return false
	end
	if not gristCache[maximum] then self:AdjustGristCacheMax(1000,playerID) end
	local overflow=gristCache[maximum]-(gristCache[gristType]+amount)
	if overflow>0 then
		self:AdjustGristGutter(gristType,overflow,PlayerResource:GetTeam(playerID))
		amount=amount-overflow
	end
	gristCache[gristType]=curGristAmount+amount
	print(gristCache[gristType])
	return gristCache[gristType]
end

function Grist:AdjustGristCacheMax(amount,playerID)
	local gristCache=self:GetGristCache(playerID)
	gristCache[maximum]=gristCache[maximum] and gristCache[maximum]+amount or amount
	return gristCache[maximum]
end

local GristKV=LoadKeyValues('scripts/npc/grist.txt')

local GristTypes=GristKV['Types']

local GristCreatures=GristKV['Creatures']

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function Grist:GetGristType(gristType)
	return deepcopy(GristTypes[gristType])
end

function Grist:GetGristFromCreature(creature)
	return GristCreatures[creature:GetUnitLabel()]
end