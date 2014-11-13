Class InstaDeathCard extends SlotCard;

#exec AUDIO IMPORT FILE="Sounds\bellend1.wav" NAME="RevebBell" GROUP="FX"

static function float ExecuteCard( Pawn Target )
{
	local Reaper R;

	R = SummonReaper(Target);
	if( R==None )
		return 0.f; // FAIL!

	R.AddVictim(Target);
	Target.PlaySound(Sound'RevebBell',SLOT_None,2,,1000.f);
	PlayerController(Target.Controller).ReceiveLocalizedMessage(Class'InstaDeathMessage');
	return 10.f;
}

static final function Reaper SummonReaper( Actor A )
{
	local Reaper R;
	local byte i;
	local rotator RR;

	foreach A.DynamicActors(Class'Reaper',R)
		return R;
	RR.Yaw = Rand(65536);
	while( R==None && ++i<5 )
		R = A.Spawn(Class'Reaper',,,GetRandomSpot(A.Level),RR);
	return R;
}
static final function vector GetRandomSpot( LevelInfo L )
{
	local NavigationPoint N;
	local int c;

	for( N=L.NavigationPointList; N!=None; N=N.nextNavigationPoint )
		++c;
	if( c==0 )
		return vect(0,0,0);
	c = Rand(c);
	for( N=L.NavigationPointList; N!=None; N=N.nextNavigationPoint )
		if( c--==0 )
			return N.Location;
	return vect(0,0,0);
}

defaultproperties
{
     Desireability=0.100000
     CardMaterial=Texture'KillingFloorHUD.Achievements.Achievement_27'
}
