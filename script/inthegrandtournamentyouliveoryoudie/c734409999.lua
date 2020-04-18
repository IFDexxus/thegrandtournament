--Duelist Soul
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    return aux.CanActivateSkill(tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local g=Duel.GetMatchingGroup(s.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		if Duel.SelectOption(tp,aux.Stringid(734409999,1),aux.Stringid(734409999,2))==0 then
			Duel.DisableShuffleCheck()
			Duel.SendtoDeck(g,tp,-2,REASON_RULE)
			Duel.SendtoDeck(g,nil,0,REASON_RULE)
		else
			Duel.DisableShuffleCheck()
			Duel.SendtoDeck(g,tp,-2,REASON_RULE)
			Duel.SendtoDeck(g,nil,1,REASON_RULE)
		end
	end
end
--Sort Filler
function s.filter(c)
	return c:IsCode(99999999)
end