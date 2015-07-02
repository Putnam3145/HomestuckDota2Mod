modifier_terezi_pyrope_justice_attack_speed = class({})

function modifier_terezi_pyrope_justice_attack_speed:OnCreated( kv )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "stack_speed" )
end

function modifier_terezi_pyrope_justice_attack_speed:OnRefresh( kv )
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "stack_speed" )
end

function modifier_terezi_pyrope_justice_attack_speed:IsDebuff()
	return false
end

function modifier_terezi_pyrope_justice_attack_speed:IsPurgable()
	return false
end



function modifier_terezi_pyrope_justice_attack_speed:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
 
	return funcs
end

function modifier_terezi_pyrope_justice_attack_speed:GetModifierAttackSpeedBonus_Constant( params )
	return self.attack_speed*self:GetStackCount()
end