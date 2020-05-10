--IT'S A GOD
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,2,false,nil,nil)
	
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetCountLimit(1)
	e2:SetCondition(s.draw_con)
	e2:SetOperation(s.draw)
	Duel.RegisterEffect(e2, tp)
end

function s.draw_con(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(ep,id)>0 then return end
	return tp==Duel.GetTurnPlayer() and Duel.GetTurnCount()>1 and Duel.GetDrawCount(tp)>0
end

function s.draw(e,tp,eg,ep,ev,re,r,rp)
	local dt=Duel.GetDrawCount(tp)
	if dt==0 then return false end

    if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.Hint(HINT_SKILL_FLIP,0,id|(1<<32))
		Duel.Hint(HINT_CARD,tp,id)
		Duel.RegisterFlagEffect(ep,id,tp,0,0)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.CreateToken(tp,513000135)
		Duel.SendtoDeck(tc,tp,0,REASON_RULE)
    end
end