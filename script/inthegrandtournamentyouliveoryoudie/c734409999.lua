--Filler Control
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
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetOperation(s.ignitionop)
	Duel.RegisterEffect(e2, tp)

	local e3=e2:Clone()
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetOperation(s.chainop)
	Duel.RegisterEffect(e3, tp)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
end

function s.ignitionop(e,tp,eg,ep,ev,re,r,rp)
	s.sort(tp)
end

function s.chainop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		s.sort(tp)
	end
end

function s.sort(tp)
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