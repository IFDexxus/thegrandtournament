--G.O.D's Plan
local s,id=GetID()
function s.initial_effect(c)
	--Activate (Its just here to flip the card I guess)
	aux.AddSkillProcedure(c,2,false,nil,nil)
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetCountLimit(1)
	e1:SetRange(0x5f)
	e1:SetLabel(0)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)


	--Place on top of deck
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_STARTUP)
	e2:SetRange(0xff)
	e2:SetOperation(s.stop)
	Duel.RegisterEffect(e2,0)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
		if e:GetLabel()==0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PREDRAW)
			e1:SetCondition(s.flipcon)
			e1:SetOperation(s.flipop)
			Duel.RegisterEffect(e1,tp)
		end
	e:SetLabel(1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return true
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
end


function s.stop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(s.stfilter,tp,LOCATION_DECK,0,c)
	while #g>0 do
		local tc = g:GetFirst()
			Duel.MoveSequence(tc, 0)
			g:Remove(Card.IsCode, nil, tc:GetCode())
	end
end

function s.IsHeaven(c)
	return c:IsCode(511009003)
end

function s.IsMechior(c)
	return c:IsCode(511009006)
end

function s.IsCaspar(c)
	return c:IsCode(511009007)
end

function s.IsBalthazar(c)
	return c:IsCode(511009009)
end

function s.IsHell(c)
	return c:IsCode(511009004)
end

function s.stfilter(c)
 	return s.IsHeaven(c) or s.IsMechior(c) or s.IsCaspar(c) or s.IsBalthazar(c) or s.IsHell(c)
 end