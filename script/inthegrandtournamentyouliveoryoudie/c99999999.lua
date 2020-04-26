--FillerCard
local s,id=GetID()
function s.initial_effect(c)
    --Pre-duel
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(LOCATION_DECK)
	e1:SetCountLimit(1, 9999999)
	e1:SetOperation(s.duel_init)
	Duel.RegisterEffect(e1, tp)
end

function s.duel_init(e,tp,eg,ep,ev,re,r,rp)
	local not_group = Duel.GetMatchingGroup(s.topf,tp,LOCATION_DECK,nil,nil)
	if #not_group > 0 then
		Duel.MoveToDeckBottom(not_group, tp)
	end
	local group = Duel.GetMatchingGroup(s.filter,tp,LOCATION_DECK,nil,nil)
	if #group > 0 then
		Duel.MoveToDeckBottom(group, tp)
	end
end

function s.filter(c)
	return c:IsCode(99999999)
end

function s.topf(c)
	return not c:IsCode(51100904) or c:IsCode(51100903)or c:IsCode(51100906)or c:IsCode(51100907)or c:IsCode(51100909)
end