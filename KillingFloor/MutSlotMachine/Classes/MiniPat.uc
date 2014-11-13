Class MiniPat extends ZombieBoss;

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
    super(ZombieBossBase).Died(Killer,damageType,HitLocation);
}
function bool MakeGrandEntry()
{
	return false;
}

defaultproperties
{
     ScoringValue=350
     Health=3000
     MenuName="Patriarch Jr."
}
