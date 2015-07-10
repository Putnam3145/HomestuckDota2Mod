dirk_strider_issues_of_self = class({})
--------------------------------------------------------------------------------

function dirk_strider_issues_of_self:CastFilterResultTarget(hTarget)
	if hTarget:IsIllusion() and hTarget:GetMainControllingPlayer()==self:GetCaster():GetPlayerID() then
		return UF_SUCCESS
	else
		return UF_FAIL_CUSTOM
	end
end

function dirk_strider_issues_of_self:GetCustomCastErrorTarget(hTarget)
	if hTarget:IsIllusion() then
		return '#dota_hud_error_must_be_own_illusion'
	else
		return '#dota_hud_error_must_be_illusion'
	end
end

function dirk_strider_issues_of_self:OnSpellStart()
	local caster=self:GetCaster()
	local target=self:GetCursorTarget()
	if not (caster and target) then return end
	local newPos=target:GetOrigin()
	local newHealth=target:GetHealth()
	target:Kill(self,self:GetCaster())
	caster:SetOrigin(newPos)
	FindClearSpaceForUnit(caster,newPos,true)
	caster:SetHealth(newHealth)
	self:StartCooldown(self:GetCooldown())
end

function dirk_strider_issues_of_self:GetCooldown(level)
	level=level or self:GetLevel()-1
	local cooldowns={120,100,80,60}
	return cooldowns[level+1]
end

function dirk_strider_issues_of_self:GetManaCost(level)
	return 200
end