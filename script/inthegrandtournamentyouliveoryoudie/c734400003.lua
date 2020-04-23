--Duel Spirit
Duel.LoadScript("c419.lua")
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--opd check
	if Duel.GetFlagEffect(ep,id)>0 then return end
	--condition
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and aux.CanActivateSkill(tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--flip skill and register opd
	Duel.Hint(HINT_SKILL_FLIP,0,id|(1<<32))
	Duel.Hint(HINT_CARD,0,id)
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	
	-- special summon kozaky and lose the duel if it is destroyed
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.CreateToken(tp,99171160)
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DESTROYED)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e1:SetLabel(1-tp)
		e1:SetLabelObject(e4)
		e1:SetOperation(s.leaveop)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EVENT_REMOVED)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EVENT_RELEASE)
		tc:RegisterEffect(e3)
		local e5=e1:Clone()
		e5:SetCode(EVENT_TO_GRAVE)
		tc:RegisterEffect(e5)
		local e6=e1:Clone()
		e6:SetCode(EVENT_EVENT_BE_MATERIAL)
		tc:RegisterEffect(e6)
		local e7=e1:Clone()
		e7:SetCode(EVENT_CONTROL_CHANGED)
		tc:RegisterEffect(e7)
		local e8=e1:Clone()
		e8:SetCode(EVENT_EQUIP)
		tc:RegisterEffect(e8)
		local e9=e1:Clone()
		e9:SetCode(EVENT_DISCARD)
		tc:RegisterEffect(e9)
	end
end

function s.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_ZERO_GATE=0x53
	Duel.Win(e:GetLabel(),WIN_REASON_ZERO_GATE)
end