Class AmmoReplication extends ReplicationInfo
	transient;

var Controller BoxOwner;
var AmmoBox Box;
var transient UI_AmmoWindow ActiveWindow;
var int TotalRefund;
var float RepairValue;

replication
{
	reliable if(Role == ROLE_Authority)
		ClientOpenMenu,Box;
	reliable if(Role < ROLE_Authority)
		ServerBuyAmmo,ServerClosedMenu,ServerRepairCrate;
}

simulated final function ClientOpenMenu( float CostScale, float Value )
{
	local PlayerController PC;

	PC = Level.GetLocalPlayerController();
	if( Level.NetMode!=NM_Client && PC!=Pawn(Owner).Controller )
		return;

	RepairValue = Value;
	PC.Player.GUIController.OpenMenu(string(class'UI_AmmoWindow'));
	ActiveWindow = Class'UI_AmmoWindow'.Default.TempNewMenu;
	Class'UI_AmmoWindow'.Default.TempNewMenu = None;
	if( ActiveWindow!=None )
	{
		ActiveWindow.RepNotify = Self;
		ActiveWindow.InvSelect.List.AmmoCostScale = CostScale;
		ActiveWindow.Timer();
	}
}
final function ServerBuyAmmo( class<Ammunition> AC, bool bClip )
{
	local Inventory I;
	local float Price;
	local Ammunition AM;
	local KFWeapon KW;
	local int c,Old;
	local float UsedMagCapacity;
	local Boomstick DBShotty;
	local KFPlayerReplicationInfo KFPRI;
	local PlayerReplicationInfo PRI;

	if ( AC==None || Pawn(Owner)==None || Pawn(Owner).PlayerReplicationInfo==None )
		return;

	for ( I=Owner.Inventory; (I!=None && (AM==None || KW==None)); I=I.Inventory )
	{
		if ( I.Class == AC )
			AM = Ammunition(I);
		else if ( KW == None && KFWeapon(I) != None && (Weapon(I).GetAmmoClass(0)==AC || Weapon(I).GetAmmoClass(1)== AC) )
			KW = KFWeapon(I);
	}
	if ( KW == none || AM == none )
		return;

    DBShotty = Boomstick(KW);

	AM.MaxAmmo = AM.default.MaxAmmo;

	PRI = Pawn(Owner).PlayerReplicationInfo;
	KFPRI = KFPlayerReplicationInfo(PRI);
	if ( KFPRI!=none && KFPRI.ClientVeteranSkill!=none )
	{
		AM.MaxAmmo = int(float(AM.MaxAmmo) * KFPRI.ClientVeteranSkill.static.AddExtraAmmoFor(KFPRI, AC));
	}

	if ( AM.AmmoAmount >= AM.MaxAmmo )
		return;

	Price = class<KFWeaponPickup>(KW.PickupClass).default.AmmoCost * Class'AmmoBox'.Default.AmmoCostScale; // Clip price.
	if ( KFPRI!=none && KFPRI.ClientVeteranSkill!=none )
		Price *= KFPRI.ClientVeteranSkill.static.GetAmmoCostScaling(KFPRI, KW.PickupClass);

	if ( KW.bHasSecondaryAmmo && AC==KW.GetAmmoClass(1) )
	{
		UsedMagCapacity = 1; // Secondary Mags always have a Mag Capacity of 1? KW.default.SecondaryMagCapacity;
	}
	else
	{
		UsedMagCapacity = KW.default.MagCapacity;
	}

	if( Class<HuskGunPickup>(KW.PickupClass)!=None )
	{
		UsedMagCapacity = class<HuskGunPickup>(KW.PickupClass).default.BuyClipSize;
	}

	if ( bClip )
	{
		if ( KFPRI!= none && KFPRI.ClientVeteranSkill!=none )
		{
			if( Class<HuskGunPickup>(KW.PickupClass)!=None )
            {
                c = UsedMagCapacity * KFPRI.ClientVeteranSkill.static.AddExtraAmmoFor(KFPRI, AC);
            }
            else
            {
                c = UsedMagCapacity * KFPRI.ClientVeteranSkill.static.GetMagCapacityMod(KFPRI, KW);
            }
		}
		else
		{
			c = UsedMagCapacity;
		}
	}
	else
	{
		c = (AM.MaxAmmo-AM.AmmoAmount);
	}

    Price = int(float(c) / UsedMagCapacity * Price);
	PRI.NetUpdateTime = Level.TimeSeconds - 1.f;
	Old = PRI.Score;

	if ( PRI.Score < Price ) // Not enough CASH (so buy the amount you CAN buy).
	{
		c *= (PRI.Score/Price);

		if ( c == 0 )
			return; // Couldn't even afford 1 bullet.

		AM.AddAmmo(c);
		PRI.Score = Max(PRI.Score - (float(c) / UsedMagCapacity * Price), 0);
	}
	else
	{
		PRI.Score = int(PRI.Score-Price);
		AM.AddAmmo(c);
	}
	if( BoxOwner!=Pawn(Owner).Controller )
	{
		Price = (Old - PRI.Score) * Class'AmmoBox'.Default.MoneyRefundScale;
		TotalRefund += int(Price);
	}
	if( DBShotty != none )
        DBShotty.AmmoPickedUp();
}
simulated final function int GetRepairValue()
{
	local float V;
	
	V = float(Box.CrateHealth - Box.Health) * RepairValue;
	return int(V);
}
final function ServerRepairCrate()
{
	local int V;
	local float Scale;
	local PlayerReplicationInfo PRI;
	
	if ( Pawn(Owner)==None || Pawn(Owner).PlayerReplicationInfo==None || Box==None || Box.Health<=0 || Box.Health>=Box.CrateHealth )
		return;
	PRI = Pawn(Owner).PlayerReplicationInfo;
	V = GetRepairValue();

	if ( PRI.Score < V ) // Not enough CASH (so repair the amount you CAN buy).
	{
		Scale = PRI.Score / float(V);
		Scale *= float(Box.CrateHealth-Box.Health);
		V = int(Scale);
		if( V==0 )
			return; // Can't repair one hit point.
		Box.Health = Min(Box.Health+V,Box.CrateHealth);
		PRI.Score = 0;
	}
	else
	{
		PRI.Score = Max(PRI.Score-V,0);
		Box.Health = Box.CrateHealth;
	}
	PRI.NetUpdateTime = Level.TimeSeconds - 1.f;
}
final function ServerClosedMenu()
{
	Destroy();
}

simulated function Destroyed()
{
	if( ActiveWindow!=None )
	{
		ActiveWindow.RepNotify = None;
		GUIController(Level.GetLocalPlayerController().Player.GUIController).RemoveMenu(ActiveWindow,true);
		ActiveWindow = None;
	}
	if( Box!=None && Box.Health>0 )
	{
		Box.UserStatus(false);
		Box = None;
	}
	if( TotalRefund>0 && BoxOwner!=None && BoxOwner.PlayerReplicationInfo!=None )
	{
		BoxOwner.PlayerReplicationInfo.Score+=TotalRefund;
		BoxOwner.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1.f;
		if( Pawn(Owner)!=None && Pawn(Owner).Health>0 )
			Spawn(Class'AmmoRefundMsg',BoxOwner,,Owner.Location+(vect(0,0,1)*Owner.CollisionHeight),rot(0,0,0)).TotalDosh = TotalRefund;
		TotalRefund = 0;
	}
}
auto state BeginRep
{
	final function bool ToucingAmmoUser()
	{
		local AmmoBoxUser U;

		if( Box==None || Box.Health<=0 || Owner==None || Pawn(Owner).Health<=0 )
			return false;
		foreach Owner.TouchingActors(class'AmmoBoxUser',U)
			if( U.Owner==Box )
				return true;
		return false;
	}
Begin:
	Sleep(0.5);
	if( Box!=None )
	{
		RepairValue = Class'AmmoBox'.Default.RepairValuePerHP;
		BoxOwner = Box.OwnerController;
	}
	if( ToucingAmmoUser() )
		ClientOpenMenu(Class'AmmoBox'.Default.AmmoCostScale,RepairValue);
	Sleep(0.5);
	while( ToucingAmmoUser() )
		Sleep(0.65);
	Destroy();
}

defaultproperties
{
     RepairValue=999.000000
     bOnlyRelevantToOwner=True
     bAlwaysRelevant=False
}
