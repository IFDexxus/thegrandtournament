--FillerCard
function c99999999.initial_effect(c)
    --Pre-duel
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(LOCATION_DECK)
	e1:SetCountLimit(1, 9999999)
	e1:SetOperation(c99999999.duel_init)
	Duel.RegisterEffect(e1, tp)
end

function c99999999.duel_init(e,tp,eg,ep,ev,re,r,rp)
	local group = Duel.GetMatchingGroup(c99999999.filter,tp,LOCATION_DECK,nil,nil)
	if #group > 0 then
		Duel.DisableShuffleCheck()
		Duel.MoveToDeckBottom(group, tp)
	end
end

function c99999999.filter(c)
	return c:IsCode(99999999)
end