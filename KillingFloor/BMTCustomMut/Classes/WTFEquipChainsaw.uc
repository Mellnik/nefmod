class WTFEquipChainsaw extends KFMeleeGun;

#exec OBJ LOAD FILE=WTFTex.utx

var float NextIronTime;

replication
{
	reliable if(Role < ROLE_Authority)
		DoLunge;
}

simulated exec function ToggleIronSights()
{
	local KFPlayerReplicationInfo KFPRI;
	
	//this functionality is available to berserkers only
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI == none || KFPRI.ClientVeteranSkill != Class'WTFPerksBerserker')
		return;
		
	if (
		NextIronTime <= Level.TimeSeconds &&
		!FireMode[0].bIsFiring && FireMode[0].NextFireTime < Level.TimeSeconds &&
		!FireMode[1].bIsFiring && FireMode[1].NextFireTime < Level.TimeSeconds
		)
	{
		if (Instigator != none && Instigator.Physics != PHYS_Falling)
		{
			DoLunge();
			if (ROLE < ROLE_AUTHORITY) //client-side fx, essentially
				FireMode[1].ModeDoFire();
				
			NextIronTime=Level.TimeSeconds+3.0;
		}
	}
}

simulated function DoLunge()
{
	local rotator VR; //ViewRotation
	local vector DirMomentum;
	
	VR = Instigator.Controller.GetViewRotation();

	DirMomentum.X=300.0;
	DirMomentum.Y=0.0;
	DirMomentum.Z= 275.0; //325.0; //default kfhumanpawn jump height
	VR.Pitch=0;
			
	FireMode[1].ModeDoFire();
		
	Instigator.AddVelocity(DirMomentum >> VR);
}

simulated function bool StartFire(int Mode)
{
	if( Mode == 1 )
		return super.StartFire(Mode);

	if( !super.StartFire(Mode) )
	   return false;

	AnimStopLooping();

	if( !FireMode[Mode].IsInState('FireLoop')  )
	{
		FireMode[Mode].StartFiring();
		return true;
	}
	else
	{
		return false;
	}

	return true;
}

simulated function AnimEnd(int channel)
{
	if(!FireMode[0].IsInState('FireLoop'))
	{
	  	Super.AnimEnd(channel);
	}
}

defaultproperties
{
     weaponRange=150.000000
     BloodSkinSwitchArray=0
     bDoCombos=True
     BloodyMaterialRef="WTFTex.Chainsaw_bloody"
     Weight=8.000000
     StandardDisplayFOV=70.000000
     SleeveNum=2
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Chainsaw'
     bIsTier2Weapon=True
     MeshRef="KF_Weapons_Trip.Chainsaw_Trip"
     SkinRefs(0)="WTFTex.Chainsaw"
     SkinRefs(1)="KF_Specimens_Trip_T.scrake_saw_panner"
     SelectSoundRef="KF_ChainsawSnd.Chainsaw_Select"
     HudImageRef="KillingFloorHUD.WeaponSelect.Chainsaw_unselected"
     SelectedHudImageRef="KillingFloorHUD.WeaponSelect.Chainsaw"
     FireModeClass(0)=Class'BMTCustomMut.WTFEquipChainsawFire'
     FireModeClass(1)=Class'BMTCustomMut.WTFEquipChainsawAltFire'
     Description="A gas powered industrial strength chainsaw."
     DisplayFOV=70.000000
     Priority=88
     InventoryGroup=4
     GroupOffset=3
     PickupClass=Class'BMTCustomMut.WTFEquipChainsawPickup'
     PlayerViewOffset=(X=25.000000,Z=-10.000000)
     BobDamping=8.000000
     AttachmentClass=Class'BMTCustomMut.WTFEquipChainsawAttachment'
     IconCoords=(X1=169,Y1=39,X2=241,Y2=77)
     ItemName="WTF Chainsaw"
}
