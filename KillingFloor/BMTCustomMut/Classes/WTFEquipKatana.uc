class WTFEquipKatana extends KFMeleeGun;

var KFPlayerReplicationInfo KFPRI;
var bool LastZTState; //LastZedTimeState
var float NextIronTime;

replication
{
	reliable if(Role < ROLE_Authority)
		ZEDTime;
}

simulated function WeaponTick(float dt)
{
	Super.WeaponTick(dt);

	//if we're in the same state as the last time we checked, no need to do anything right now, exit
	
	if (KFGameType(Level.Game) == None)
		return;
	
	if (KFGameType(Level.Game).bZEDTimeActive == LastZTState)
		return;
	
	//*berserker only*
	//doing the check here so it isn't running constantly-
	//	only checks when entering/exiting ZEDTime
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI == none || KFPRI.ClientVeteranSkill != Class'WTFPerksBerserker')
		return;
	
	//record new state
	LastZTState = KFGameType(Level.Game).bZEDTimeActive;
		
	//set movement speed
	if (KFGameType(Level.Game).bZEDTimeActive)
	{
		//InventorySpeedModifier is a straight + to speed and it is unregulated outside of changing weapons!
		KFHumanPawn(Instigator).InventorySpeedModifier=500; //it is an INT
		Instigator.AccelRate=100000.0;
		KFHumanPawn(Instigator).ModifyVelocity(dt, Instigator.Velocity);
	}
	else
	{
		ResetMovement();
	}
}

function ResetMovement()
{
	local KFHumanPawn P;
	P = KFHumanPawn(Instigator);
	
	P.InventorySpeedModifier = ((P.default.GroundSpeed * P.BaseMeleeIncrease) - Weight * 2);
	P.AccelRate=P.Default.AccelRate;
	P.AirControl=P.Default.AirControl;
	P.AirSpeed=P.Default.AirSpeed;
	P.ModifyVelocity(Level.TimeSeconds, P.Velocity);
}

simulated function Weapon WeaponChange( byte F, bool bSilent )
{
	ResetMovement();
	return Super.WeaponChange(F,bSilent);
}

simulated function bool PutDown()
{
	ResetMovement();
	return Super.PutDown();
}

simulated function bool CanThrow()
{
	ResetMovement();
	return Super.CanThrow();
}

simulated function ClientWeaponThrown()
{
	ResetMovement();
	Super.ClientWeaponThrown();
}

function DropFrom(vector StartLocation)
{
	ResetMovement();
	Super.DropFrom(StartLocation);
}

simulated exec function ToggleIronSights()
{
	//this functionality is available to berserkers only
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI == none || KFPRI.ClientVeteranSkill != Class'WTFPerksBerserker')
		return;
	
	//less restrictive than chainsaw/axe because we aren't actually doing an attack
	if ( NextIronTime <= Level.TimeSeconds )
	{
		if (Instigator != none)
		{
			ZEDTime();
				
			NextIronTime=Level.TimeSeconds+60.0;
		}
	}
}

simulated function ZEDTime()
{
	if (KFGameType(Level.Game) != None && KFGameType(Level.Game).bWaveInProgress)
	{
		KFGameType(Level.Game).DramaticEvent(1.0);
		if (Instigator.Health > 20)
			Instigator.Health = Instigator.Health - 20;
	}
}

simulated event RenderOverlays(Canvas Canvas)
{
	Super.RenderOverlays(Canvas);
	
	Canvas.Style = 255;

	//Draw some text.
	Canvas.Font = Canvas.SmallFont;
	Canvas.SetDrawColor(200,150,0);

	Canvas.SetPos(Canvas.SizeX * 0.5, Canvas.SizeY * 0.1);
	if (Level.TimeSeconds < NextIronTime)
		Canvas.DrawText( String(Int(NextIronTime - Level.TimeSeconds)) );
}

defaultproperties
{
     ChopSlowRate=1.000000
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipKatanaFire'
     FireModeClass(1)=Class'BMTCustomMut.WTFEquipKatanaFireB'
     Description="A deadly weapon"
     Priority=144
     PickupClass=Class'BMTCustomMut.WTFEquipKatanaPickup'
     ItemName="WTF Katana"
     BloodyMaterialRef="KF_Weapons_Gold_T.Gold_Bloody_Katana_cmb"
     TraderInfoTexture=Texture'KillingFloor2HUD.Trader_Weapon_Icons.Trader_Gold_Katana'
     SkinRefs(0)="KF_Weapons_Gold_T.Weapons.Gold_Katana_cmb"
     HudImageRef="KillingFloor2HUD.WeaponSelect.Gold_Katana_unselected"
     SelectedHudImageRef="KillingFloor2HUD.WeaponSelect.Gold_Katana"
     bKFNeverThrow=false
	 weaponRange=90.000000
     BloodSkinSwitchArray=0
     bSpeedMeUp=True
     //WeaponIdleMovementAnim="IdleMoveSyringe"
     Weight=3.000000
     SelectSoundRef="KF_KatanaSnd.Katana_Select"
     SmallViewOffset=(X=0.000000,Y=0.000000,Z=0.000000)
     GroupOffset=4
     PlayerViewOffset=(X=0.000000,Y=0.000000,Z=0.000000)
     BobDamping=8.000000
     AttachmentClass=Class'BMTCustomMut.WTFEquipKatanaAttachment'
     IconCoords=(X1=246,Y1=80,X2=332,Y2=106)
     MeshRef="KF_Weapons2_Trip.Katana_Trip"
     AmbientGlow=0
     AIRating=0.4
     CurrentRating=0.6
     DisplayFOV=75.000000
     StandardDisplayFOV=75.0
	 // Achievement Helpers
	 bIsTier2Weapon=true
}
