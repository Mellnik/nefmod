//-----------------------------------------------------------
//
//-----------------------------------------------------------
class PoliceAK47Pawn extends BDCarWeaponPawn;

function AltFire(optional float F)
{
	local PlayerController PC;

	PC = PlayerController(Controller);
	if (PC == None)
		return;

	bWeaponIsAltFiring = true;
	PC.ToggleZoom();
}

function ClientVehicleCeaseFire(bool bWasAltFire)
{
	local PlayerController PC;

	if (!bWasAltFire)
	{
		Super.ClientVehicleCeaseFire(bWasAltFire);
		return;
	}

	PC = PlayerController(Controller);
	if (PC == None)
		return;

	bWeaponIsAltFiring = false;
	PC.StopZoom();
}

simulated function ClientKDriverLeave(PlayerController PC)
{
	Super.ClientKDriverLeave(PC);

	bWeaponIsAltFiring = false;
	PC.EndZoom();
}

simulated exec function ToggleIronSights()
{

	local PlayerController PC;

	PC = PlayerController(Controller);
	if (PC == None)
		return;

//	bWeaponIsAltFiring = true;
////	PC.ToggleZoom();
	PC.ToggleBehindView();
}

defaultproperties
{
     GunClass=Class'KF_Vehicles_BD.Passenger_Police_AK47c'
     CameraBone="Camera"
     bDrawDriverInTP=False
     DrivePos=(Y=80.000000,Z=90.000000)
     DriveAnim="passenger"
     ExitPositions(0)=(Y=-165.000000,Z=100.000000)
     ExitPositions(1)=(Y=165.000000,Z=100.000000)
     ExitPositions(2)=(Y=-165.000000,Z=100.000000)
     ExitPositions(3)=(Y=165.000000,Z=100.000000)
     EntryRadius=160.000000
     FPCamPos=(X=20.000000,Y=16.000000,Z=-15.000000)
     TPCamDistance=320.000000
     TPCamLookat=(Z=50.000000)
     TPCamWorldOffset=(Z=120.000000)
     DriverDamageMult=0.600000
     VehiclePositionString="Has an AK47"
     VehicleNameString="AK47 Passenger"
     bDontPossess=False
}