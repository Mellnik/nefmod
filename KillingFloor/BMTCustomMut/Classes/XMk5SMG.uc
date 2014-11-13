class XMk5SMG extends MP7MMedicGun;

#exec OBJ LOAD FILE="..\Animations\XMk5_A.ukx"

simulated event OnZoomOutFinished()
{
	local name anim;
	local float frame, rate;

	GetAnimParams(0, anim, frame, rate);

	if (ClientState == WS_ReadyToFire)
	{
		// Play the regular idle anim when we're finished zooming out
		if (anim == IdleAimAnim)
		{
            PlayIdle();
		}
		// Switch looping fire anims if we switched to/from zoomed
		else if( FireMode[0].IsInState('FireLoop') && anim == 'Fire_Iron_Loop')
		{
            LoopAnim('Fire_Loop', FireMode[0].FireLoopAnimRate, FireMode[0].TweenTime);
		}
	}
}

/**
 * Called by the native code when the interpolation of the first person weapon to the zoomed position finishes
 */
simulated event OnZoomInFinished()
{
	local name anim;
	local float frame, rate;

	GetAnimParams(0, anim, frame, rate);

	if (ClientState == WS_ReadyToFire)
	{
		// Play the iron idle anim when we're finished zooming in
		if (anim == IdleAnim)
		{
		   PlayIdle();
		}
		// Switch looping fire anims if we switched to/from zoomed
		else if( FireMode[0].IsInState('FireLoop') && anim == 'Fire_Loop' )
		{
            LoopAnim('Fire_Iron_Loop', FireMode[0].FireLoopAnimRate, FireMode[0].TweenTime);
		}
	}
}

defaultproperties
{
     HealBoostAmount=50
     HealAmmoCharge=700
     AmmoRegenRate=0.250000
     MagCapacity=50
     ReloadRate=3.530000
     WeaponReloadAnim="Reload_Kriss"
     Weight=2.000000
     SleeveNum=6
     TraderInfoTexture=Texture'XMk5_A.pic_trader'
     bIsTier3Weapon=True
     MeshRef="XMk5_A.oa_smg"
     SkinRefs(0)="XMk5_A.OA-SMG_Main"
     SelectSoundRef="XMk5_A.oa_pullout"
     HudImageRef="XMk5_A.pic_unsel"
     SelectedHudImageRef="XMk5_A.pic_sel"
     FireModeClass(0)=Class'BMTCustomMut.XMk5Fire'
     FireModeClass(1)=Class'BMTCustomMut.XMk5AltFire'
     Description="The XMk5 is often, and is indeed encouraged to be, fitted with all manner of attachments, one of these being the standard medical dart shooter."
     DisplayFOV=75.000000
     Priority=140
     GroupOffset=18
     PickupClass=Class'BMTCustomMut.XMk5Pickup'
     AttachmentClass=Class'BMTCustomMut.XMk5Attachment'
     ItemName="XMk5 Submachine Gun"
}
