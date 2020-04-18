--Gate Guardian
local s,id=GetID()
function s.initial_effect(c)
	aux.AddMonsterSkillProcedure(c,2,false)
	--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e3)
end