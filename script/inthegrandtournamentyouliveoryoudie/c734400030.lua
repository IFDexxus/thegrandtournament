--IT'S A GOD
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--opd check
	if Duel.GetFlagEffect(ep,id)>0 then return end
	--condition
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and aux.CanActivateSkill(tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--flip skill and register opd
	Duel.Hint(HINT_SKILL_FLIP,0,id|(1<<32))
	Duel.Hint(HINT_CARD,0,id)
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	
	-- special summon kozaky and lose the duel if it is destroyed
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.CreateToken(tp,513000135)
	if tc and Duel.SendtoDeck(sc,tp,0,REASON_RULE) then
	end
end