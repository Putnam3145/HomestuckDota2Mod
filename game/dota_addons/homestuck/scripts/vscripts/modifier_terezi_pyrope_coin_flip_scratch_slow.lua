modifier_terezi_pyrope_coin_flip_scratch_slow = class({})

function modifier_terezi_pyrope_coin_flip_scratch_slow:IsDebuff()
	return true
end

function modifier_terezi_pyrope_coin_flip_scratch_slow:GetEffectName()
	return "particles/generic_gameplay/generic_minibash.vpcf"
end

function modifier_terezi_pyrope_coin_flip_scratch_slow:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_terezi_pyrope_coin_flip_scratch_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE
	}
 
	return funcs
end

function modifier_terezi_pyrope_coin_flip_scratch_slow:GetModifierMoveSpeedBonus_Percentage( params )
	return -50
end

function modifier_terezi_pyrope_coin_flip_scratch_slow:GetModifierTurnRate_Percentage( params)
	return -50
end