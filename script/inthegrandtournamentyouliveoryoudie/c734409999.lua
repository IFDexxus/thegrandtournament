--Filler Control
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
	
	local group = Duel.GetMatchingGroup(s.filter,tp,LOCATION_DECK,nil,nil)
	if #group < 1 then return end

	if Duel.SelectOption(tp,aux.Stringid(734409999,1),aux.Stringid(734409999,2))==0 then
		local not_group = Duel.GetMatchingGroup(s.not_filter,tp,LOCATION_DECK,nil,nil)
		Duel.MoveToDeckBottom(not_group, tp)
	else
		Duel.MoveToDeckBottom(group, tp)
	end
end

--Sort Filler
function s.filter(c)
	return c:IsCode(99999999)
end

function s.not_filter(c)
	return not c:IsCode(99999999)
end