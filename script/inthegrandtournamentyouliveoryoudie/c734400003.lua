--Duel Spirit
Duel.LoadScript("c419.lua")
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    return aux.CanActivateSkill(tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,0,id|(1<<32))
	Duel.Hint(HINT_CARD,0,id)
	--aroma effect
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(511002521)
	e1:SetOperation(s.activate)
	e1:SetValue(LOCATION_SZONE)
	c:RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCode(id)
	e2:SetLabel(0)
	e2:SetLabelObject(e1)
	Duel.RegisterEffect(e2,0)
	local e3=e2:Clone()
	e3:SetLabel(1)
	Duel.RegisterEffect(e3,1)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.CreateToken(tp,81020646)
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DESTROYED)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e1:SetLabel(1-tp)
		e1:SetLabelObject(e4)
		e1:SetOperation(s.leaveop)
		tc:RegisterEffect(e1)
	end
end
function s.lcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetLabelObject():IsReason(REASON_DESTROY)
end
function s.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_ZERO_GATE=0x53
	Duel.Win(e:GetLabel(),WIN_REASON_ZERO_GATE)
end