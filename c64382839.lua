--ゼータ・レティキュラント
function c64382839.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64382839,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCondition(c64382839.spcon)
	e1:SetTarget(c64382839.sptg)
	e1:SetOperation(c64382839.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c64382839.hspcon)
	e2:SetOperation(c64382839.hspop)
	c:RegisterEffect(e2)
end
function c64382839.cfilter(c,tp)
	return c:IsPreviousControler(1-tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
		and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_TOKEN)
end
function c64382839.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c64382839.cfilter,1,nil,tp)
end
function c64382839.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c64382839.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,64382840,0,TYPES_TOKEN_MONSTER,500,500,2,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,64382840)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
function c64382839.spfilter(c,ft,tp)
	return c:IsCode(64382840)
		and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5)) and (c:IsControler(tp) or c:IsFaceup())
end
function c64382839.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.CheckReleaseGroupEx(tp,c64382839.spfilter,1,REASON_SPSUMMON,false,nil,ft,tp)
end
function c64382839.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.SelectReleaseGroupEx(tp,c64382839.spfilter,1,1,REASON_SPSUMMON,false,nil,ft,tp)
	Duel.Release(g,REASON_SPSUMMON)
end
