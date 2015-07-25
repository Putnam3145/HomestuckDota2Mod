modifier_terezi_pyrope_coin_flip = class({})

function modifier_terezi_pyrope_coin_flip:OnCreated(kv)
	self:StartIntervalThink(0.2)
end

function modifier_terezi_pyrope_coin_flip:IsHidden()
	return true
end

function modifier_terezi_pyrope_coin_flip:OnIntervalThink()
	if IsServer() then
		local ability=self:GetAbility()
		local parent=self:GetParent()
		if ability:GetAutoCastState() and ability:IsCooldownReady() and not (parent:HasModifier('modifier_terezi_pyrope_coin_flip_heads') or parent:HasModifier('modifier_terezi_pyrope_coin_flip_scratch')) then
			ability:CastAbility()
		end
	end
end