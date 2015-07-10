terezi_pyrope_sniff = class({})
LinkLuaModifier( "modifier_terezi_pyrope_sniff", LUA_MODIFIER_MOTION_NONE )

function terezi_pyrope_sniff:OnSpellStart()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_terezi_pyrope_sniff", { duration=self:GetSpecialValueFor( "duration" ) }  )
end