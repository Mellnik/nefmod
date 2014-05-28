class SRPlayerReplicationInfo extends KFPlayerReplicationInfo;

var int PlayerArmor;
var string PlayerWeight;

replication
{
	reliable if ( bNetDirty && (Role == Role_Authority) )
		PlayerArmor,PlayerWeight;
}

function Timer()
{
	local Controller C;

	SetTimer(0.5 + FRand(), False);
			
	UpdatePlayerLocation();
	C = Controller(Owner);
	if( C==None )
		Return;
	if( C.Pawn==None )
		PlayerHealth = 0;
	else PlayerHealth = C.Pawn.Health;

	if( !bBot )
	{
		if ( !bReceivedPing )
			Ping = Min(int(0.25 * float(C.ConsoleCommand("GETPING"))),255);
	}

	if( C.Pawn==None )
	{
		PlayerArmor = 0;
		PlayerWeight = "";
	}
	else 
	{
		PlayerArmor = C.Pawn.Shieldstrength;
		if(KFHumanPawn(C.Pawn)!=None)
			PlayerWeight = string(int(KFHumanPawn(C.Pawn).CurrentWeight))$"/"$string(int(KFHumanPawn(C.Pawn).MaxCarryWeight));
		else
			PlayerWeight = string(int(KFHumanPawn(Vehicle(C.Pawn).Driver).CurrentWeight))$"/"$string(int(KFHumanPawn(Vehicle(C.Pawn).Driver).MaxCarryWeight));
	}
	

	if( !bBot )
	{
		if ( !bReceivedPing )
			Ping = Min(int(0.25 * float(C.ConsoleCommand("GETPING"))),255);
	}
}

defaultproperties
{
     PlayerHealth=100
     PlayerName="CHANGEME!"
     VoiceTypeName="KFCoreVoicePack.AussieVoice"	 
}