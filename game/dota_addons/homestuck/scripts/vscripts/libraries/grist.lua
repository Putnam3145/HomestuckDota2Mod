if Grist == nil then
  Grist = class({})
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

function Grist:GetGristGutter(team)
	self.gristGutter=self.gristGutter or {}
	self.gristGutter[team]=self.gristGutter[team] or {}
	self.gristGutter[team].total=self.gristGutter[team].total or {}
	self.gristGutter[team].current=self.gristGutter[team].current or {}
	return self.gristGutter[team]
end

function Grist:AdjustGristGutter(gristType,amount,team)
	local gristGutter=self:GetGristGutter(team)
	local gristInfo=self:GetGristType(gristType)
	if (not gristType) or gristGutter.current.name==gristType then
		local curGristAmount=gristGutter.current.amount
		if not curGristAmount then
			return 0
		elseif curGristAmount+amount<=0 then
			local totalTotalAmounts=#gristGutter.total
			gristGutter.current=gristGutter.total[totalTotalAmounts-1]
			gristGutter.total[totalTotalAmounts]=nil
			CustomGameEventManager:Send_ServerToTeam(team,"grist_gutter_changed",gristGutter.total)
			if curGristAmount+amount < 0 then
				return -(amount+curGristAmount)
			else
				return amount
			end
		else
			gristGutter.current.amount=gristGutter.current.amount+amount
			CustomGameEventManager:Send_ServerToTeam(team,"grist_gutter_changed",gristGutter.total)
			return amount
		end
	else
		if amount<0 then 
			return 0
		else
			local addition={amount=amount,color=gristInfo.color,name=gristType}
			table.insert(gristGutter.total,addition)
			self.gristGutter[team].current=addition
			CustomGameEventManager:Send_ServerToTeam(team,"grist_gutter_changed",gristGutter.total)
			return amount
		end
	end
end

function Grist:GetGristCache(playerID)
	self.gristCache=self.gristCache or {}
	self.gristCache[playerID]=self.gristCache[playerID] or {}
	self.gristCache[playerID].maximum=self.gristCache[playerID].maximum or 1000
	return self.gristCache[playerID]
end

function Grist:AdjustGristCache(gristType,amount,playerID)
	if not gristType then return 0 end
	local gristCache=self:GetGristCache(playerID)
	gristCache[gristType]=gristCache[gristType] or 0
	local curGristAmount=gristCache[gristType]
	if curGristAmount+amount<0 then
		return 0
	end
	if not gristCache.maximum then self:AdjustGristCacheMax(1000,playerID) end
	local overflow=(gristCache[gristType]+amount)-gristCache.maximum
	if overflow>0 then
		self:AdjustGristGutter(gristType,overflow,PlayerResource:GetTeam(playerID))
		amount=amount-overflow
	end
	gristCache[gristType]=curGristAmount+amount
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID),"grist_cache_changed",gristCache)
	return gristCache[gristType]
end

function Grist:AdjustGristCacheMax(amount,playerID)
	local gristCache=self:GetGristCache(playerID)
	gristCache.maximum=gristCache.maximum and gristCache.maximum+amount or amount
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID),"grist_cache_changed",gristCache)
	return gristCache.maximum
end

function Grist:GristTorrent()
	if IsServer() then
		local heroes=HeroList:GetAllHeroes()
		for _,hero in pairs(heroes) do
			local team=hero:GetTeamNumber()
			local curGutter=self:GetGristGutter(team).current
			if not curGutter then return end
			local playerID=hero:GetPlayerID()
			local gristCache=self:GetGristCache(playerID)
			local cacheAddition=math.min(2,gristCache.maximum-self:AdjustGristCache(curGutter.name,0,playerID)) --yeah this'll probably be upgradable, this it being here
			cacheAddition=math.min(cacheAddition,-self:AdjustGristGutter(nil,-cacheAddition,team))
			self:AdjustGristCache(curGutter.name,cacheAddition,playerID)
		end
	end
end

function Grist:GetGristFromCreature(creature)
	return GristCreatures[creature:GetUnitLabel()]
end