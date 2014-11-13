// Fake AI controller.
Class AmmoBoxAI extends AIController;

var Controller OwnerPlayer;
var AmmoBox Box;
var byte AICounter;
var bool bOwnerRequired;

function Restart()
{
	Super.Restart();
	Box = AmmoBox(Pawn);
	GoToState('Idle');
}

state Idle
{
Ignores SeePlayer,HearNoise,SeeMonster;

	final function GiveGun()
	{
		local AmmoBGun W;
		local Pawn P;
		
		P = OwnerPlayer.Pawn;
		if( Vehicle(P)!=None )
			P = Vehicle(P).Driver;
		if( P==None )
			return;
		
		W = AmmoBGun(P.FindInventoryType(Class'AmmoBGun'));
		if( W!=None && W.Class==Class'AmmoBGun' )
		{
			if( W.CurrentBox!=None && W.CurrentBox!=Box ) // Kill off any duplicate boxes tossed out by player.
			{
				W.CurrentBox.WeaponOwner = None;
				W.CurrentBox.KilledBy(None);
			}
			W.bBoxDeployed = true;
			W.SellValue = 10;
			W.CurrentBox = Box;
			Box.WeaponOwner = W;
			return;
		}
		W = Spawn(Class'AmmoBGun');
		if( W!=None )
		{
			W.GiveTo(P);
			W.CurrentBox = Box;
			W.bBoxDeployed = true;
			W.SellValue = 10; // No refunds after deployed.
			Box.WeaponOwner = W;
		}
	}
	final function UpdateAI()
	{
		local Controller C;
		
		// Alert AI of this box presense.
		// All thanks to a gay update by TWI which makes zombies ignore all non-KFPawns.
		for( C=Level.ControllerList; C!=None; C=C.nextController )
			if( !C.bIsPlayer && Monster(C.Pawn)!=None && VSizeSquared(C.Pawn.Location-Pawn.Location)<500000.f && Rand(3)==0 && FastTrace(C.Pawn.Location,Pawn.Location) )
				C.damageAttitudeTo(Pawn,5);
	}
Begin:
	Sleep(0.25);
	bIsPlayer = true;
	while( bOwnerRequired )
	{
		Sleep(0.5f);
		if( OwnerPlayer==None || OwnerPlayer.bDeleteMe || (OwnerPlayer.PlayerReplicationInfo!=None && OwnerPlayer.PlayerReplicationInfo.bOnlySpectator) )
		{
			Pawn.KilledBy(None);
			stop;
		}
		if( Box.WeaponOwner==None && OwnerPlayer.Pawn!=None && OwnerPlayer.Pawn.Health>0 )
			GiveGun();
		if( ++AICounter>=7 )
		{
			AICounter = 0;
			UpdateAI();
		}
	}
}

defaultproperties
{
}
