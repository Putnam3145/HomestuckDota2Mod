modifier_terezi_pyrope_sniff=class({})

function modifier_terezi_pyrope_sniff:OnCreated( kv )
	self.sniff_range = self:GetAbility():GetSpecialValueFor( "sniff_range" )
	self:StartIntervalThink(0.2)
end

function modifier_terezi_pyrope_sniff:OnRefresh( kv )
	self.sniff_range = self:GetAbility():GetSpecialValueFor( "sniff_range" )
end

function modifier_terezi_pyrope_sniff:OnIntervalThink(kv)
	if IsServer() then
		local parent=self:GetParent()
		AddFOWViewer(parent:GetTeam(),parent:GetCenter(),self.sniff_range,0.2,false)
	end
end

function modifier_terezi_pyrope_sniff:DeclareFunctions()
	local funcs = {}

	return funcs
end
