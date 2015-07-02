terezi_pyrope_seer_of_mind = class({})

function terezi_pyrope_seer_of_mind:OnChannelThink(interval)
	local caster=self:GetCaster()
	local heroes=HeroList:GetAllHeroes()
	for k,hero in ipairs(heroes) do
		if hero:GetTeam()~=caster:GetTeam() then
			hero:MakeVisibleToTeam(caster:GetTeam(),interval)
		end
	end
end

function terezi_pyrope_seer_of_mind:OnChannelFinish(interrupted)
	self:StartCooldown(self:GetCooldown())
end

function terezi_pyrope_seer_of_mind:GetCooldown(level)
	level=level or self:GetLevel()-1
	local cooldowns={60,45,30}
	return cooldowns[level+1]
end

function terezi_pyrope_seer_of_mind:GetChannelTime()
	return self:GetCaster():HasScepter() and self:GetSpecialValueFor( "aghs_length" ) or self:GetSpecialValueFor( "standard_length" )
end

function terezi_pyrope_seer_of_mind:GetManaCost(level)
	return 200
end