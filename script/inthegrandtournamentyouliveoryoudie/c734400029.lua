--One-Turn-Kill Death God
local s,id=GetID()
function s.initial_effect(c)
	aux.AddSkillProcedure(c,2,false,nil,nil)
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetCountLimit(1)
	e1:SetRange(0x5f)
	e1:SetCondition(s.con)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
end

function s.con(e,tp,eg,ep,ev,re,r,rp)
	return	Duel.IsExistingMatchingCard(s.IsHell,tp,LOCATION_DECK,0,1,nil) and
			Duel.IsExistingMatchingCard(s.IsBalthazar,tp,LOCATION_DECK,0,1,nil) and
			Duel.IsExistingMatchingCard(s.IsCaspar,tp,LOCATION_DECK,0,1,nil) and
			Duel.IsExistingMatchingCard(s.IsMechior,tp,LOCATION_DECK,0,1,nil) and
			Duel.IsExistingMatchingCard(s.IsHeaven,tp,LOCATION_DECK,0,1,nil)
end

function s.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	
    local c=e:GetHandler()
    local search=Duel.GetFirstMatchingCard
    Duel.MoveSequence(search(s.IsHell,c:GetOwner(),LOCATION_DECK,0,nil), 0)
    Duel.MoveSequence(search(s.IsBalthazar,c:GetOwner(),LOCATION_DECK,0,nil), 0)
    Duel.MoveSequence(search(s.IsCaspar,c:GetOwner(),LOCATION_DECK,0,nil), 0)
    Duel.MoveSequence(search(s.IsMechior,c:GetOwner(),LOCATION_DECK,0,nil), 0)
    Duel.MoveSequence(search(s.IsHeaven,c:GetOwner(),LOCATION_DECK,0,nil), 0)
end

function s.IsHeaven(c)
	return c:IsCode(810000001)
end

function s.IsMechior(c)
	return c:IsCode(511001673)
end

function s.IsCaspar(c)
	return c:IsCode(511001794)
end

function s.IsBalthazar(c)
	return c:IsCode(511002797)
end

function s.IsHell(c)
	return c:IsCode(511600139)
end