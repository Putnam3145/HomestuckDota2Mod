modifier_terezi_pyrope_coin_flip_scratch = class({})

function modifier_terezi_pyrope_coin_flip_scratch:OnCreated( kv )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "SlowTime" )
end

--------------------------------------------------------------------------------

function modifier_terezi_pyrope_coin_flip_scratch:OnRefresh( kv )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "SlowTime" )
end

function modifier_terezi_pyrope_coin_flip_scratch:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end

function modifier_terezi_pyrope_coin_flip_scratch:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then

			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				target:AddNewModifier( self:GetCaster(), self, "modifier_terezi_pyrope_coin_flip_scratch_slow", {duration=self.slow_duration}  )
				self:GetCaster():RemoveModifierByName('modifier_terezi_pyrope_coin_flip_scratch')
			end
		end
	end
	
	return 0
end