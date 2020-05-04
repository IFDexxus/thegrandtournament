--The Power of the Orichalcos!
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.condition_to_move_monster,s.place_on_back_row,1)
end

function s.condition_to_move_monster(e,tp,eg,ep,ev,re,r,rp)
	return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,2,nil)
end

function s.place_on_back_row(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local sg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	s.move_to_spell(sg)
end

function s.attack_condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE and Duel.GetTurnPlayer()==tp
end

function s.attack_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()

	Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true,0x20+0x40)
	
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(s.in_your_extra_monster_zone)
	e3:SetOperation(s.return_to_back_row)
	c:RegisterEffect(e3)

	--Card must attack if able (force attack)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e4)
	
	--Other cards cannot attack
	local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_FIELD)
    e5:SetCode(EFFECT_CANNOT_ATTACK)
    e5:SetRange(LOCATION_MZONE)
    e5:SetTargetRange(LOCATION_MZONE,0)
    e5:SetTarget(s.catg)
    e5:SetCondition(s.cacon)
    c:RegisterEffect(e5)
end

-- Ultimate Tyranno's Cannot Attack while this card can attack
function s.catg(e,c)
    return not c:IsCode(e:GetHandler():GetCode())
end

function s.cfilter(c)
    if c:IsFaceup() and (c:GetSequence()>4) and c:CanAttack() then return false end
    local ag,direct=c:GetAttackableTarget()
    return #ag>0 or direct
end

function s.cacon(e)
    return Duel.GetCurrentPhase()>PHASE_MAIN1 and Duel.GetCurrentPhase()<PHASE_MAIN2
        and Duel.IsExistingMatchingCard(s.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
-- Ultimate Tyranno end


function s.in_your_extra_monster_zone(e)
	return e:GetHandler():GetSequence()>4
end

function s.return_to_back_row(e,tp,eg,ep,ev,re,r,rp)
	s.move_to_spell(e:GetHandler())
end

function s.no_more_front_row(e)
	return not Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,nil)
end

function s.move_to_spell(card)
	if card and Duel.MoveToField(card,card:GetControler(),card:GetControler(),LOCATION_SZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(card)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_MONSTER)
		card:RegisterEffect(e1)
		
		local e2=Effect.CreateEffect(card)
		e2:SetType(EFFECT_TYPE_QUICK_O)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetRange(LOCATION_SZONE)
		e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetCountLimit(1)
		e2:SetCondition(s.attack_condition)
		e2:SetOperation(s.attack_op)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		card:RegisterEffect(e2,true)

		local e3=Effect.CreateEffect(card)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetRange(LOCATION_SZONE)
		e3:SetCondition(s.no_more_front_row)
		e3:SetOperation(s.move_to_monster_zone)
		card:RegisterEffect(e3)
	end
end

function s.move_to_monster_zone(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),e:GetHandler():GetControler(),e:GetHandler():GetControler(),LOCATION_MZONE,POS_FACEUP,true)
end


