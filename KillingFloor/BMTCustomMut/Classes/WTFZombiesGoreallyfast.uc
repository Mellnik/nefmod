class WTFZombiesGoreallyFast extends ZombieGoreFast;

#exec OBJ LOAD FILE=WTFTex.utx

//charge from farther away
function RangedAttack(Actor A)
{
	Super.RangedAttack(A);
	if( !bShotAnim && !bDecapitated && VSize(A.Location-Location)<=1400 )
		GoToState('RunningState');
}

defaultproperties
{
     GroundSpeed=200.000000
     WaterSpeed=200.000000
     MenuName="Goreallyfast"
     Skins(0)=Texture'WTFTex.WTFZombies.Goreallyfast'
}
