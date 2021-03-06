//-----------------------------------------------------------
//
//-----------------------------------------------------------
class InvPS extends Inventory;

function PostBeginPlay()
{
	Super.PostBeginPlay();
    if (Instigator==none || KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) == None)
    {
        Destroy();
        return;
    }
}

function InitTimer()
{
	// TICK EVERY X SECONDS
    SetTimer(3.0, true);
}

function Timer()
{
	local KFHumanPawn P;
	local class<SRVeterancyTypes> WTFP;
	local Inventory CurInv;
	local int am;
	
	WTFP = class<SRVeterancyTypes>(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill);
	
	if(WTFP.default.PerkIndex!=51)
	{
		Destroy();
		return;
	}
	
	//EFFECT RADIUS
	foreach Instigator.VisibleCollidingActors( class 'KFHumanPawn', P, 189600)
	{		
		if(P.Health<100)
			P.Health+=WTFP.static.GetHM(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));
		if(P.Health>100)
			P.Health=100;
		if(P.ShieldStrength<100)
			P.ShieldStrength+=WTFP.static.GetSM(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));
		if(P.ShieldStrength>100)
			P.ShieldStrength=100;
		am = WTFP.static.GetAM(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));
		for ( CurInv = P.Inventory; CurInv != none; CurInv = CurInv.Inventory )
		{
			if ( KFAmmunition(CurInv) != none && KFAmmunition(CurInv).bAcceptsAmmoPickups )
			{
				if ( KFAmmunition(CurInv).AmmoPickupAmount > 1 )
				{
					if ( KFAmmunition(CurInv).AmmoAmount < KFAmmunition(CurInv).MaxAmmo )
					{
						KFAmmunition(CurInv).AmmoAmount = Min(KFAmmunition(CurInv).MaxAmmo, KFAmmunition(CurInv).AmmoAmount + am);
						//return;
					}
				}
			}
		}
	}    
}

defaultproperties
{
}
