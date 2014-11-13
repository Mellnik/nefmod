//-----------------------------------------------------------
//
//-----------------------------------------------------------
class HealingKatana extends KFMeleeGun;

var texture ArmedSkin1;

static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount)
{
	default.ArmedSkin1 = texture(DynamicLoadObject("KF_Weapons2_Trip_T.melee.Katana_cmb", class'texture', true));

	super.PreloadAssets(Inv, bSkipRefCount);
}

static function bool UnloadAssets()
{
	if ( super.UnloadAssets() )
	{
		default.ArmedSkin1 = none;
		return true;
	}

	return false;
}

defaultproperties
{
     weaponRange=90.000000
     BloodyMaterial=Combiner'KF_Weapons2_Trip_T.melee.Katana_Bloody_cmb'
     BloodSkinSwitchArray=0
     bSpeedMeUp=True
     Weight=1.000000
     StandardDisplayFOV=75.000000
     TraderInfoTexture=Texture'KillingFloor2HUD.Trader_Weapon_Icons.Trader_Katana'
     SelectSoundRef="KF_KatanaSnd.Katana_Select"
     HudImageRef="KillingFloor2HUD.WeaponSelect.Katana_unselected"
     SelectedHudImageRef="KillingFloor2HUD.WeaponSelect.Katana"
     FireModeClass(0)=Class'BMTCustomMut.HealingKatanaFire'
     FireModeClass(1)=Class'BMTCustomMut.HealingKatanaFireB'
     AIRating=0.400000
     CurrentRating=0.600000
     Description="An incredibly sharp Katana."
     DisplayFOV=75.000000
     Priority=70
     GroupOffset=1
     PickupClass=Class'BMTCustomMut.HealingKatanaPickup'
     BobDamping=8.000000
     AttachmentClass=Class'BMTCustomMut.HealingKatanaAttachment'
     IconCoords=(X1=246,Y1=80,X2=332,Y2=106)
     ItemName="Healing Katana"
     Mesh=SkeletalMesh'KF_Weapons2_Trip.katana_Trip'
     Skins(0)=Combiner'KF_Weapons2_Trip_T.melee.Katana_cmb'
     AmbientGlow=11
}
