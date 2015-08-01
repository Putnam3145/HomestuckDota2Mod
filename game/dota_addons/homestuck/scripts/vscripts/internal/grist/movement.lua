function Movement(args)
	local caster = args.caster
	local pickupTargets = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(),caster,50,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS,FIND_CLOSEST,false)
	for k,v in pairs(pickupTargets) do
		Grist:AdjustGristCache(caster.gristType,caster.gristAmount,v:GetPlayerID() or v:GetMainControllingPlayer())
		caster:Kill(caster,caster)
		return true
	end
	local targets = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(),caster,5000,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS,FIND_CLOSEST,false)
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
	if averageTargetPos then
		averageTargetPos=averageTargetPos/#targets
		local direction = averageTargetPos - casterPos
		local gravitationalConstant=4200 --arbitrary number chosen to Feel Right
		local vec=direction:Normalized()*math.ceil(gravitationalConstant*(1/direction:Length()))
		
		caster:SetAbsOrigin(casterPos+vec)
		return true
	else
		return false
	end
end