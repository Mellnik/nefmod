Class AmmoBoxUser extends UseTrigger
	NotPlaceable;

var transient float NextMessageTime;

final function bool AimingAtBox( Pawn Other )
{
	local AmmoBox A;
	local vector HL,Dir,Start;
	
	Start = Other.Location + Other.EyePosition();
	Dir = vector(Other.GetViewRotation());
	foreach Other.TraceActors(Class'AmmoBox',A,HL,HL,Start+Dir*80.f,Start)
	{
		if( A!=None )
			return (A==Owner);
	}
	return false;
}

function UsedBy( Pawn user )
{
	local AmmoReplication R;

	if( user.IsHumanControlled() && AimingAtBox(user) )
	{
		foreach DynamicActors(class'AmmoReplication',R)
			if( R.Owner==user )
				return;
		R = Spawn(Class'AmmoReplication',user);
		R.Box = AmmoBox(Owner);
		R.Box.UserStatus(true);
	}
}

function Touch( Actor Other )
{
	if ( Pawn(Other)!=None && Pawn(Other).IsHumanControlled() && NextMessageTime<Level.TimeSeconds )
	{
		Pawn(Other).ReceiveLocalizedMessage(Class'AmmoMessage',3);
		NextMessageTime = Level.TimeSeconds+0.25;
	}
}

defaultproperties
{
     Physics=PHYS_Trailer
     CollisionRadius=60.000000
     CollisionHeight=50.000000
}
