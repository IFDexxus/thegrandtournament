--The Reaper's Hand
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,2,false,nil,nil)
	
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetCountLimit(1)
	e1:SetRange(0x5f)
	e1:SetOperation(s.flipop)
	c:RegisterEffect(e1)
	
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetCountLimit(1)
	e2:SetCondition(s.draw_con)
	e2:SetOperation(s.draw)
	Duel.RegisterEffect(e2, tp)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
end

function s.filter(c)
    return true
end

function s.draw_con(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetTurnCount()>1 and Duel.GetDrawCount(tp)>0
end

function s.draw(e,tp,eg,ep,ev,re,r,rp)
	local dt=Duel.GetDrawCount(tp)
	if dt==0 then return false end

    if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,dt,dt,nil)
		Duel.ShuffleDeck(tp)
		Duel.MoveToDeckTop(g)
    end
end

--draw overwrite, credit to Edo and AlphaKretin
local ddr=Duel.Draw
Duel.Draw = function(...)
    local tb={...}
    local tp=tb[1]
    local count=tb[2]
    if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
        local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,count,count,nil)
		Duel.ShuffleDeck(tp)
		Duel.MoveToDeckTop(g)
        return ddr(...)
    else
        return ddr(...)
    end
end
