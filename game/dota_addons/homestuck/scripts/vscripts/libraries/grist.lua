if Grist == nil then
  Grist = class({})
end

function Grist:AdjustGristGutter(gristType,amount,team)
	local gristGutter=self.gristGutter[team]
	local gristName=gristType.name
	local curGristAmount=gristGutter[gristName]
	if curGristAmount-amount<0 then
		return false 
	else 
		gristGutter[gristName]=curGristAmount+amount
		gristGutter[total]:insert({amount=amount,color=gristType.color})
		return gristGutter[gristName]
	end
end

function Grist:AdjustGristCache(gristType,amount,playerID)
	local gristCache=self.gristCache[playerID]
	local gristName=gristType.name
	local curGristAmount=gristCache[gristName]
	if curGristAmount-amount<0 then
		return false
	end
	local overflow=gristCache[maximum]-(gristCache[gristName]+amount)
	if overflow>0 then
		self:AdjustGristGutter(gristName,overflow,PlayerResource:GetTeam(playerID))
		amount=amount-overflow
	end
	gristCache[gristName]=curGristAmount+amount
	return gristCache[gristName]
end

function Grist:AdjustGristCacheMax(amount,playerID)
	local gristCache=self.gristCache[playerID]
	gristCache[maximum]=gristCache[maximum]+amount
	return gristCache[maximum]
end

local GristTypes=LoadKeyValues('scripts/npc/grist.txt')

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