--FillerCard
function c99999999.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCondition(c99999999.stcon)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
--	e1:SetTarget(c99999999.tdtg)
	e1:SetOperation(c99999999.stop)
	c:RegisterEffect(e1)
--	--Shuffle Displacement?
--	local e3=Effect.CreateEffect(c)
--	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
--	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
--	e3:SetCondition(c99999999.con)
--	e3:SetCode(EVENT_DRAW)
--	e3:SetRange(LOCATION_HAND)
--	e3:SetOperation(c99999999.sttop)
--	Duel.RegisterEffect(e3,tp)
end
--function c99999999.cfilter(c)
--	return c:GetCode()~=99999999
--end
--function c99999999.con(e,tp,eg,ep,ev,re,r,rp)
--	return eg:IsContains(e:GetHandler())-- and return Duel.IsExistingMatchingCard(c99999999.cfilter,tp,LOCATION_DECK,0,1,nil)
--end
function c99999999.stcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end
--function c99999999.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
--	if chk==0 then return true end
--	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
--end
function c99999999.stop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lol=LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
--	Duel.MoveSequence(tc,1)
--	Duel.BreakEffect()
	if c:GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
		Duel.SendtoDeck(c,nil,1,REASON_RULE)
	else
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	end
end
--function c99999999.sttop(e,tp,eg,ep,ev,re,r,rp)
--	local c=e:GetHandler()
--	local lol=LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK
--	Duel.DisableShuffleCheck()
--	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
----	Duel.MoveSequence(tc,1)
----	Duel.BreakEffect()
--	if c:GetPreviousLocation()==LOCATION_HAND then
--		Duel.Draw(tp,1,REASON_RULE)
--		Duel.SendtoDeck(c,nil,1,REASON_RULE)
--	else
--	Duel.SendtoDeck(c,nil,1,REASON_RULE)
--	end
--end