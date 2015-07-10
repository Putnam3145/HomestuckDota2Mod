terezi_pyrope_coin_flip = class({})
LinkLuaModifier( "modifier_terezi_pyrope_coin_flip_heads", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_terezi_pyrope_coin_flip_scratch", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_terezi_pyrope_coin_flip_scratch_slow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_terezi_pyrope_coin_flip", LUA_MODIFIER_MOTION_NONE )


function terezi_pyrope_coin_flip:OnSpellStart()
	self:GetCaster():RemoveModifierByName('modifier_terezi_pyrope_coin_flip_heads')
	self:GetCaster():RemoveModifierByName('modifier_terezi_pyrope_coin_flip_scratch')
	if RollPercentage(50) then
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_terezi_pyrope_coin_flip_heads", {}  )	
	else
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_terezi_pyrope_coin_flip_scratch", {}  )
	end
end

function terezi_pyrope_coin_flip:GetIntrinsicModifierName()
	return "modifier_terezi_pyrope_coin_flip"
end