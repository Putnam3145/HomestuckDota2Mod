modifier_terezi_pyrope_coin_flip_heads = class({})

function modifier_terezi_pyrope_coin_flip_heads:OnCreated( kv )
	self.hitdam = self:GetAbility():GetSpecialValueFor( "HeadsDamage" )
end

--------------------------------------------------------------------------------

function modifier_terezi_pyrope_coin_flip_heads:OnRefresh( kv )
	self.hitdam = self:GetAbility():GetSpecialValueFor( "HeadsDamage" )
end

function modifier_terezi_pyrope_coin_flip_heads:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end

function modifier_terezi_pyrope_coin_flip_heads:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then

			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				ApplyDamage({victim=target, attacker=params.attacker, damage=self.hitdam, damage_type=DAMAGE_TYPE_PURE})
				self:GetCaster():RemoveModifierByName('modifier_terezi_pyrope_coin_flip_heads')
			end
		end
	end
	
	return 0
end

function modifier_terezi_pyrope_coin_flip_heads:GetTexture( kv )
	return 'terezi_pyrope_coin_flip_heads'
end