class WTFEquipBulldog extends Bullpup;

replication
{
	 reliable if(Role < ROLE_Authority)
        ServerSetAutoMode;
}

// Use alt fire to switch fire modes
simulated function AltFire(float F)
{
    if(ReadyToFire(0))
    DoToggle();
}

simulated function DoToggle ()
{
	local PlayerController Player;
	local WTFEquipBulldogFire FM;
	local KFPlayerReplicationInfo KFPRI;
	local byte MyAutoMode;
	local bool bIsCommando;
     
        FM = WTFEquipBulldogFire(FireMode[0]);
        MyAutoMode = FM.AutoMode;
        KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
        bIsCommando = (KFPRI != none && KFPRI.ClientVeteranSkill == Class'WTFPerksCommando');
        Player = Level.GetLocalPlayerController();
     
        MyAutoMode++;
        if(MyAutoMode >= 3 || (MyAutoMode >=2 && !bIsCommando) )
                MyAutoMode = 0;
     
        if ( Player!=None )
            Player.ReceiveLocalizedMessage(class'BMTCustomMut.WTFEquipBulldogSwitchMessage', MyAutoMode);
            PlayOwnedSound(ToggleSound,SLOT_None,2.0,,,,false);
            FM.SetAutoMode(MyAutoMode);
     
        if( Level.NetMode==NM_Client ) // tell server of firemode change.
            ServerSetAutoMode(MyAutoMode);
}

// Set the new fire mode on the server
function ServerSetAutoMode( byte NewMode )
{
            PlayOwnedSound(ToggleSound,SLOT_None,2.0,,,,false);
            WTFEquipBulldogFire(FireMode[0]).SetAutoMode(NewMode);
}

// Set the new fire mode on the server
function ServerChangeFireMode(bool bNewWaitForRelease)
{
    FireMode[0].bWaitForRelease = bNewWaitForRelease;
}

function bool RecommendRangedAttack()
{
	return true;
}

//TODO: LONG ranged?
function bool RecommendLongRangedAttack()
{
	return true;
}

function float SuggestAttackStyle()
{
	return -1.0;
}

exec function SwitchModes()
{
	DoToggle();
}

function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	return AIRating;
}

function byte BestMode()
{
	return 0;
}

simulated function SetZoomBlendColor(Canvas c)
{
	local Byte    val;
	local Color   clr;
	local Color   fog;

	clr.R = 255;
	clr.G = 255;
	clr.B = 255;
	clr.A = 255;

	if( Instigator.Region.Zone.bDistanceFog )
	{
		fog = Instigator.Region.Zone.DistanceFogColor;
		val = 0;
		val = Max( val, fog.R);
		val = Max( val, fog.G);
		val = Max( val, fog.B);
		if( val > 128 )
		{
			val -= 128;
			clr.R -= val;
			clr.G -= val;
			clr.B -= val;
		}
	}
	c.DrawColor = clr;
}

simulated function SuperMaxOutAmmo()
{
	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = 10000;
		if ( (AmmoClass[1] != None) && (AmmoClass[0] != AmmoClass[1]) )
			AmmoCharge[1] = 10000;
		return;
	}
	if ( Ammo[0] != None )
		Ammo[0].AmmoAmount = 10000;
	if ( Ammo[1] != None )
		Ammo[1].AmmoAmount = 10000;
}

defaultproperties
{
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipBulldogFire'
     PickupClass=Class'BMTCustomMut.WTFEquipBulldogPickup'
     AttachmentClass=Class'BMTCustomMut.WTFEquipBulldogAttachment'
     ItemName="Bulldog profession"
}
