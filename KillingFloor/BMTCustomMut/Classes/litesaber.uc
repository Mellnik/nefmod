class litesaber extends KFMeleeGun;

#exec OBJ LOAD FILE=KF_Weapons2_Trip.ukx

simulated function BeginPlay()
{
	LinkSkelAnim(MeshAnimation'katana_anim');
	Super.BeginPlay();
}

simulated function Timer()
{
    Super.Timer();
    if (Instigator != None && ClientState == WS_Hidden)
    {
        LightType = LT_None;
    }
    else
        LightType = LT_SubtlePulse;
}

/*function WeaponFire
{
	local KFPlayerReplicationInfo KFPRI;
	
	KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
	if (KFPRI != none)
	{
		if (KFPRI.ClientVeteranSkill == Class'Jedi')
	     FireModeClass(0)=Class'JediForce.litesaberfire';
		 FireModeClass(1)=Class'JediForce.litesaberfireB';
	}
	else
	     FireModeClass(0)=Class'kfmod.katanafire';
		 FireModeClass(1)=Class'kfmod.katanafireB';
		
	return Super.Weapon;
}*/

defaultproperties
{
     weaponRange=90.000000
     bSpeedMeUp=True
     Weight=4.000000
     StandardDisplayFOV=75.000000
     TraderInfoTexture=Texture'NetskyT3.litesaber_selected'
     bIsTier3Weapon=True
     MeshRef="NetskyT3.LiteSaberMesh1"
     SkinRefs(0)="KF_Weapons2_Trip_T.Special.MP_7_cmb"
     SkinRefs(2)="NetskyT3.LiteSaberSHD"
     SelectSoundRef="NetskyT3.SaberOn"
     HudImageRef="NetskyT3.litesaber_unselected"
     SelectedHudImageRef="NetskyT3.litesaber_selected"
     FireModeClass(0)=Class'BMTCustomMut.litesaberFire'
     FireModeClass(1)=Class'BMTCustomMut.litesaberFireB'
     AIRating=0.400000
     CurrentRating=0.600000
     Description="An incredibly hot sword."
     DisplayFOV=75.000000
     Priority=110
     GroupOffset=4
     PickupClass=Class'BMTCustomMut.litesaberpickup'
     BobDamping=8.000000
     AttachmentClass=Class'BMTCustomMut.litesaberAttachment'
     IconCoords=(X1=246,Y1=80,X2=332,Y2=106)
     ItemName="Litesaber"
     LightType=LT_None
     LightHue=170
     LightSaturation=155
     LightBrightness=200.000000
     LightRadius=5.000000
     bDynamicLight=True
     bUnlit=True
}
