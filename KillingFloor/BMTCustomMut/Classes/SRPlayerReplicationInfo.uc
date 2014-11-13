//-----------------------------------------------------------
//
//-----------------------------------------------------------
class SRPlayerReplicationInfo extends KFPlayerReplicationInfo;

var string Status, CSkins;
var int PlayerArmor,buffed;
var Color STColor;

replication
{
	// Things the server should send to the client.
	reliable if ( bNetDirty && (Role == Role_Authority) )
		Status,
		CSkins,
		PlayerArmor,
		STColor;
}

function Timer()
{
	local Controller C;
	
	C = Controller(Owner);
	
	if( C.Pawn==None )
		PlayerArmor = 0;
	else PlayerArmor = C.Pawn.Shieldstrength;
	
	super.Timer();
}

defaultproperties
{
}
