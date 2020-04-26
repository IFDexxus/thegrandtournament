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
	
	local group = Duel.GetMatchingGroup(c99999999.filter,tp,LOCATION_DECK,nil,nil)
	if #group < 1 then return end

	local send_to_top = Duel.SelectOption(tp,aux.Stringid(734409999,1),aux.Stringid(734409999,2))==0
	send_to_top = send_to_top == true and 1 or send_to_top == false and 0
	local not_group = Duel.GetMatchingGroup(c99999999.not_filter,tp,LOCATION_DECK,nil,nil)
	Duel.DisableShuffleCheck()

	Debug.Message(send_to_top)
	if #group < #not_group then
		Duel.Remove(group, POS_FACEDOWN, REASON_RULE)
		Duel.SendtoDeck(group,tp,1-send_to_top,REASON_RULE)
	else
		Duel.Remove(not_group, POS_FACEDOWN, REASON_RULE)
		Duel.SendtoDeck(not_group,tp,send_to_top,REASON_RULE)
	end
end

--Sort Filler
function s.filter(c)
	return c:IsCode(99999999)
end

function s.not_filter(c)
	return c:IsCode(99999999)
end