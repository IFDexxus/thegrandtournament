--FillerCard
function c99999999.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCondition(c99999999.stcon)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1, 99999999)
	e1:SetOperation(c99999999.stop)
	c:RegisterEffect(e1)
end

function c99999999.stcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end

function c99999999.filter(c)
	return c:IsCode(99999999)
end

function c99999999.not_filter(c)
	return not c:IsCode(99999999)
end

function c99999999.stop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DisableShuffleCheck()

	local not_group = Duel.GetMatchingGroup(c99999999.not_filter,tp,LOCATION_DECK,nil,nil)
	local group = Duel.GetMatchingGroup(c99999999.filter,tp,LOCATION_DECK,nil,nil)

	if #group < #not_group then
		Duel.Remove(group, POS_FACEDOWN, REASON_RULE)
		Duel.SendtoDeck(group,tp,1,REASON_RULE)
	else
		Duel.Remove(not_group, POS_FACEDOWN, REASON_RULE)
		Duel.SendtoDeck(not_group,tp,0,REASON_RULE)
	end

	local filler_cards_in_hand = Duel.GetMatchingGroup(c99999999.filter,tp,LOCATION_HAND,nil,nil)
	Duel.SendtoDeck(filler_cards_in_hand,tp,1,REASON_RULE)
	Duel.Draw(tp,#filler_cards_in_hand,REASON_RULE)
end