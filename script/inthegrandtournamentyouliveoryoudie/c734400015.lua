-- Restricted Field
local s,id=GetID()
function s.initial_effect(c)
	--Activate
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
	return Duel.GetCurrentChain()==0 and Duel.GetTurnCount()==1
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,0,id|(1<<32))
    Duel.Hint(HINT_CARD,0,id)
    local c=e:GetHandler()
    local dis=Duel.SelectFieldZone(tp,2,LOCATION_ONFIELD+LOCATION_PZONE,0,0)
    Duel.Hint(HINT_ZONE,tp,dis)
    --Ground Collapse
    --disable field
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_DISABLE_FIELD)
    e2:SetOperation(s.disop)
    e2:SetLabel(dis)
    Duel.RegisterEffect(e2,tp)
end
function s.disop(e,tp)
    return e:GetLabel()
end