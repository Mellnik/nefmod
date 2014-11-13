//=============================================================================
// SCAR MK17 Inventory class
//=============================================================================
class M41AAssaultRifle extends KFWeapon
	config(user);


var() ScriptedTexture MyScriptedTexture;
var() Shader AmmoCounter;
var string MyMessage;
var int MyHealth;
var   Font MyFont;
var   Font MyFont2;
var   Font SmallMyFont;
var  color MyFontColor;
var  color MyFontColor2;
var int OldValue;
var Texture    SecAmmo1, SecAmmo2, SecAmmo3;



simulated function bool ConsumeAmmo(int Mode, float load, optional bool bAmountNeededIsMax)
{

       if  ( Mode  == 1 )
       {
          MagAmmoRemaining += 1;
          super.ConsumeAmmo(Mode, load, bAmountNeededIsMax);
       }
	else
       {
        return super.ConsumeAmmo(Mode, load, bAmountNeededIsMax);
       }

}


simulated function bool StartFire(int Mode)
{
	if( Mode == 1 )
                
		return super.StartFire(Mode);

	if( !super.StartFire(Mode) )  // returns false when mag is empty
	   return false;

	if( AmmoAmount(0) <= 0 )
	{
    	return false;
        }

	AnimStopLooping();

	if( !FireMode[Mode].IsInState('FireLoop') && (AmmoAmount(0) > 0) )
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



simulated final function SetTextColor( byte R, byte G, byte B )
{
	MyFontColor.R = R;
	MyFontColor.G = G;
	MyFontColor.B = B;
	MyFontColor.A = 255;


}

simulated final function SetTextColor2( byte R, byte G, byte B )
{
	MyFontColor2.R = R;
	MyFontColor2.G = G;
	MyFontColor2.B = B;
	MyFontColor2.A = 255;

 }

simulated function RenderOverlays( Canvas Canvas )
{


    local float fHeight;
    local float fWidth;
    local float fwidth2;
    local float fheight2;
    local float fX;
    local float fY;
    local float fy2;
    local float fx2;



    fX = Canvas.ClipX * 0.725;
    fY = Canvas.ClipY * 0.940;
    fX2 = Canvas.ClipX * 0.725;
    fY2 = Canvas.ClipY * 0.935;
    fWidth = Canvas.ClipX * 0.0500000;
    fHeight = Canvas.ClipY * 0.03500000;
    fwidth2 = canvas.clipx * 0.05000000;
    fHeight2 = canvas.clipy * 0.0475000;

    //-----------------------------------------------------------

      Canvas.SetPos(fX2, fY2);
//    Canvas.Style = ERenderStyle.STY_Masked;		  
    Canvas.DrawTile(Texture'KillingFloorHud.HUD.Hud_BOX_128x64', fWidth2, fHeight2, 0, 0, 128, 64);   


    if(AmmoAmount(1) == 1)
    {
	Canvas.SetPos(fX, fY);		  
        Canvas.DrawTile(SecAmmo1, fWidth, fHeight, 0, 0, 128, 64);
    }	  

	    if(AmmoAmount(1) == 2)
    {
  	Canvas.SetPos(fX, fY);		  
    	Canvas.DrawTile(SecAmmo2, fWidth, fHeight, 0, 0, 128, 64);
    }	 
	
	    if(AmmoAmount(1) >= 3)
    {
	Canvas.SetPos(fX, fY);		  
        Canvas.DrawTile(SecAmmo3, fWidth, fHeight, 0, 0, 128, 64);
    }	 
        

		  
 	if( AmmoAmount(0) <= 0 )
	{
		if( OldValue!=-5 )
		{
			OldValue = -5;
	//		Skins[5] = ScopeRed;
			MyFont = SmallMyFont;
			SetTextColor(218,18,18);
			MyMessage = "Empty";
			++MyScriptedTexture.Revision;
		}
	}
	else if( bIsReloading )
	{
		if( OldValue!=-4 )
		{
			OldValue = -4;
			MyFont = SmallMyFont;
			SetTextColor(32,187,112);
			MyMessage = "RL";
			++MyScriptedTexture.Revision;
		}
	}
	else if( OldValue!=(MagAmmoRemaining+1) )
	{
		OldValue = MagAmmoRemaining+1;
//		Skins[5] = ScopeGreen;
		MyFont = Default.MyFont;

		if ((MagAmmoRemaining ) <= (MagCapacity/2))
			SetTextColor(32,187,112);
		if ((MagAmmoRemaining ) <= (MagCapacity/3))
		{
			SetTextColor(218,18,18);
//			Skins[5] = ScopeRed;
		}
		if ((MagAmmoRemaining ) >= (MagCapacity/2))
			SetTextColor(76,148,177);
		MyMessage = String(MagAmmoRemaining);

		++MyScriptedTexture.Revision;
	}

	MyScriptedTexture.Client = Self;
	//Skins[5] = AmmoCounter;
	Super.RenderOverlays(Canvas);
	MyScriptedTexture.Client = None;
	//Skins[5] = None;
}
simulated function RenderTexture( ScriptedTexture Tex )


{
	local int w, h;
/*
	// Ammo
	Tex.TextSize( MyMessage, MyFont,  w, h );
	Tex.DrawText( ( Tex.USize / 2 ) - ( w / 2 ), ( Tex.VSize / 2 ) - ( h / 1.2 ),MyMessage, MyFont, MyFontColor );

*/

	Tex.TextSize( MyMessage, MyFont2,  w, h );	
//	Tex.TextSize(AmmoAmount(1), MyFont2,w,h); 
	Tex.DrawText( ( Tex.USize / 2 ) - ( w / 2.2 ), ( Tex.VSize / 2 ) - ( h / 2.0 ),/*AmmoAmount(1)*/MyMessage, MyFont, MyFontColor2 );
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
     MyScriptedTexture=ScriptedTexture'M41ATex.AmmoText'
     MyFont=Font'BDFonts.DigitalMed'
     MyFont2=Font'BDFonts.DigitalMed'
     SmallMyFont=Font'BDFonts.DigitalMed'
     MyFontColor=(B=177,G=148,R=76,A=255)
     MyFontColor2=(B=18,G=18,R=218,A=255)
     SecAmmo1=Texture'M41ATex.HUD.Single'
     SecAmmo2=Texture'M41ATex.HUD.Dual'
     SecAmmo3=Texture'M41ATex.HUD.Triple'
     MagCapacity=50
     ReloadRate=2.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.500000
     WeaponReloadAnim="Reload_SCAR"
     HudImage=Texture'M41ATex.HUD.M41A_unselected'
     SelectedHudImage=Texture'M41ATex.HUD.M41A_selected'
     Weight=6.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=55.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'M41ATex.HUD.Trader_M41A'
     PlayerIronSightFOV=70.000000
     ZoomedDisplayFOV=45.000000
     FireModeClass(0)=Class'BMTCustomMut.M41AFire'
     FireModeClass(1)=Class'BMTCustomMut.M41AALTFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'M41ASnd.Select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     AmmoClass(0)=Class'BMTCustomMut.M41AAmmo'
     AmmoClass(1)=Class'BMTCustomMut.M41AProjectileAmmo'
     Description="The M41A Pulse Rifle from the movie Aliens."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=15
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=7
     PickupClass=Class'BMTCustomMut.M41APickup'
     PlayerViewOffset=(X=20.000000,Y=19.000000,Z=3.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.M41AAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="M41A"
     Mesh=SkeletalMesh'M41AAnims.M41APulseRifle'
     Skins(0)=Combiner'M41ATex.M41A_cmb_final'
     TransientSoundVolume=5.250000
}
