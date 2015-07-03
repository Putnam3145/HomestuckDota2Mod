modifier_terezi_pyrope_justice = class({})

function modifier_terezi_pyrope_justice:OnCreated( kv )
	self.max_mult = self:GetAbility():GetSpecialValueFor( "max_mult" )
end

--------------------------------------------------------------------------------

function modifier_terezi_pyrope_justice:OnRefresh( kv )
	self.max_mult = self:GetAbility():GetSpecialValueFor( "max_mult" )
end

--------------------------------------------------------------------------------

function modifier_terezi_pyrope_justice:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_terezi_pyrope_justice:OnAttack( params )
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent:IsIllusion() ) then
			if self:GetParent():PassivesDisabled() or not params.target:IsHero() then
				self:GetParent():RemoveModifierByName('modifier_terezi_pyrope_justice_attack_speed')
				return 0
			end

			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				local mult = math.min((PlayerResource:GetStreak(target:GetPlayerID())),self.max_mult)
				if mult>0 then
					local caster=self:GetParent()
					local ability=self:GetAbility()
					local modifierName='modifier_terezi_pyrope_justice_attack_speed'
					if not caster:HasModifier(modifierName) then 
						caster:AddNewModifier(caster,ability,modifierName,{})
					end
					caster:SetModifierStackCount(modifierName,ability,mult)
				else
					self:GetParent():RemoveModifierByName('modifier_terezi_pyrope_justice_attack_speed')
				end
			end
		end
	end
	
	return 0
end

function modifier_terezi_pyrope_justice:IsHidden()
	return true
end
