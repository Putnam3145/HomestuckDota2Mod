function Movement(args)
	local caster = args.caster
	local pickupTargets = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(),caster,50,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS,FIND_CLOSEST,false)
	for k,v in pairs(pickupTargets) do
		Grist:AdjustGristCache(caster.gristType,caster.gristAmount,v:GetPlayerID() or v:GetMainControllingPlayer())
		caster:Kill(caster,caster)
		return true
	end
	local targets = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(),caster,600,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS,FIND_CLOSEST,false)
	local casterPos = caster:GetAbsOrigin()
	local direction = casterPos
	local averageTargetPos = nil
	for k,v in pairs(targets) do
		if not averageTargetPos then
			averageTargetPos=v:GetAbsOrigin()
		else
			averageTargetPos=averageTargetPos+v:GetAbsOrigin()
		end
	end
	averageTargetPos=averageTargetPos/#targets
	local direction = averageTargetPos - casterPos
	local vec=direction:Normalized()*5.0
	
	caster:SetAbsOrigin(casterPos+vec)
	return false
end