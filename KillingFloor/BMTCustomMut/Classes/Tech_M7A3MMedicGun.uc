class Tech_M7A3MMedicGun extends KFWeapon;

var ()      float       AmmoRegenRate;  // How quickly the healing charge regenerates
var ()      int         HealBoostAmount;// How much we heal a player by default with the heal dart
Const MaxAmmoCount=500;                 // Maximum healing charge count
var         float       RegenTimer;     // Tracks regeneration
var         int         HealAmmoCharge; // Current healing charger
var localized   string  SuccessfulHealMessage;
var localized   string  ReloadMessage;
var localized   string  EmptyMessage;

var() Material ScopeGreen;
var() Material ScopeRed;
var() ScriptedTexture MyScriptedTexture;
//var() Shader AmmoCounter;
var string MyMessage;
var int MyHealth;
var   Font MyFont;
var   Font MyFont2;
var   Font SmallMyFont;
var  color MyFontColor;
var  color MyFontColor2;
var int OldValue;

replication
{
	// Things the server should send to the client.
	reliable if( Role==ROLE_Authority )
		HealAmmoCharge;

 	reliable if( Role == ROLE_Authority )
		ClientSuccessfulHeal;
}

static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount)
{
	default.ScopeGreen = Material(DynamicLoadObject("KF_Weapons5_Scopes_Trip_T.M7A3.Scope_Finall", class'Material', true));
	default.ScopeRed = Material(DynamicLoadObject("KF_Weapons5_Scopes_Trip_T.M7A3.ScopeRed_Shader", class'Material', true));
	default.MyScriptedTexture = ScriptedTexture(DynamicLoadObject("KF_Weapons5_Scopes_Trip_T.M7A3_Ammo_Script.AmmoNumber", class'ScriptedTexture', true));
	default.MyFont = Font(DynamicLoadObject("IJCFonts.DigitalBig", class'Font', true));
	default.MyFont2 = Font(DynamicLoadObject("IJCFonts.DigitalBig", class'Font', true));
	default.SmallMyFont = Font(DynamicLoadObject("IJCFonts.DigitalMed", class'Font', true));

	if ( M7A3MMedicGun(Inv) != none )
	{
		M7A3MMedicGun(Inv).ScopeGreen = default.ScopeGreen;
		M7A3MMedicGun(Inv).ScopeRed = default.ScopeRed;
		M7A3MMedicGun(Inv).MyScriptedTexture = default.MyScriptedTexture;
		M7A3MMedicGun(Inv).MyFont = default.MyFont;
		M7A3MMedicGun(Inv).MyFont2 = default.MyFont2;
		M7A3MMedicGun(Inv).SmallMyFont = default.SmallMyFont;
	}

	super.PreloadAssets(Inv, bSkipRefCount);
}

static function bool UnloadAssets()
{
	if ( super.UnloadAssets() )
	{
    	default.ScopeGreen = none;
    	default.ScopeRed = none;
    	default.MyScriptedTexture = none;
    	default.MyFont = none;
    	default.MyFont2 = none;
    	default.SmallMyFont = none;
		return true;
	}

	return false;
}


// The server lets the client know they successfully healed someone
simulated function ClientSuccessfulHeal(String HealedName)
{
    if( PlayerController(Instigator.Controller) != none )
    {
        PlayerController(Instigator.controller).ClientMessage(SuccessfulHealMessage@HealedName, 'CriticalEvent');
    }
}

// Return a float value representing the current healing charge amount
simulated function float ChargeBar()
{
	return FClamp(float(HealAmmoCharge)/float(MaxAmmoCount),0,1);
}

simulated function MaxOutAmmo()
{
	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = MaxAmmo(0);
		return;
	}
	if ( Ammo[0] != None )
		Ammo[0].AmmoAmount = Ammo[0].MaxAmmo;

	HealAmmoCharge = MaxAmmoCount;
}

simulated function SuperMaxOutAmmo()
{
   HealAmmoCharge = 999;

	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = 999;
		return;
	}
	if ( Ammo[0] != None )
		Ammo[0].AmmoAmount = 999;
}

simulated function int MaxAmmo(int mode)
{
    if( Mode == 1 )
    {
	   return MaxAmmoCount;
	}
	else
	{
	   return super.MaxAmmo(mode);
	}
}

simulated function FillToInitialAmmo()
{
	if ( bNoAmmoInstances )
	{
		if ( AmmoClass[0] != None )
			AmmoCharge[0] = Max(AmmoCharge[0], AmmoClass[0].Default.InitialAmount);
        HealAmmoCharge = MaxAmmoCount;

		return;
	}

	if ( Ammo[0] != None )
        Ammo[0].AmmoAmount = Ammo[0].AmmoAmount;

    HealAmmoCharge = MaxAmmoCount;

}

simulated function int AmmoAmount(int mode)
{
    if( Mode == 1 )
    {
	   return HealAmmoCharge;
	   MyHealth = ChargeBar() * 100;
	}
	else
	{
	   return super.AmmoAmount(mode);
	}
}

simulated function bool AmmoMaxed(int mode)
{
    if( Mode == 1 )
    {
	   return HealAmmoCharge>=MaxAmmoCount;
	}
	else
	{
	   return super.AmmoMaxed(mode);
	}
}

simulated function float AmmoStatus(optional int Mode) // returns float value for ammo amount
{
    if( Mode == 1 )
    {
	   return float(HealAmmoCharge)/float(MaxAmmoCount);
	}
	else
	{
	   return super.AmmoStatus(Mode);
	}
}

simulated function bool ConsumeAmmo(int Mode, float load, optional bool bAmountNeededIsMax)
{
    if( Mode == 1 )
    {
        if( Load>HealAmmoCharge )
        {
            return false;
        }

    	HealAmmoCharge-=Load;
    	Return True;
	}
	else
	{
	   return super.ConsumeAmmo(Mode, load, bAmountNeededIsMax);
	}
}

function bool AddAmmo(int AmmoToAdd, int Mode)
{
    if( Mode == 1 )
    {
    	if( HealAmmoCharge<MaxAmmoCount )
    	{
    		HealAmmoCharge+=AmmoToAdd;
    		if( HealAmmoCharge>MaxAmmoCount )
    		{
    			HealAmmoCharge = MaxAmmoCount;
    		}
    	}
        return true;
    }
    else
    {
        return super.AddAmmo(AmmoToAdd,Mode);
    }
}

simulated function bool HasAmmo()
{
    if( HealAmmoCharge > 0 )
    {
        return true;
    }

	if ( bNoAmmoInstances )
	{
    	return ( (AmmoClass[0] != none && FireMode[0] != none && AmmoCharge[0] >= FireMode[0].AmmoPerFire) );
	}
    return (Ammo[0] != none && FireMode[0] != none && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire);
}

simulated function CheckOutOfAmmo()
{
    return;
}

simulated function Tick(float dt)
{
	if ( Level.NetMode!=NM_Client && HealAmmoCharge<MaxAmmoCount && RegenTimer<Level.TimeSeconds )
	{
		RegenTimer = Level.TimeSeconds + AmmoRegenRate;

		if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
		{
			HealAmmoCharge += 10 * KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.GetSyringeChargeRate(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));
		}
		else
		{
			HealAmmoCharge += 10;
		}
		if ( HealAmmoCharge > MaxAmmoCount )
		{
			HealAmmoCharge = MaxAmmoCount;
		}
	}
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
    if( HealAmmoCharge >=250 )
    {
        MyHealth = ChargeBar() * 100;
        SetTextColor2(76,148,177);
        ++MyScriptedTexture.Revision;
    }
    else
    {
        MyHealth = ChargeBar() * 100;
        SetTextColor2(218,18,18);
        ++MyScriptedTexture.Revision;
    }
	if( AmmoAmount(0) <= 0 )
	{
		if( OldValue!=-5 )
		{
			OldValue = -5;
			Skins[2] = ScopeRed;
			MyFont = SmallMyFont;
			SetTextColor(218,18,18);
			MyMessage = EmptyMessage;
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
			MyMessage = ReloadMessage;
			++MyScriptedTexture.Revision;
		}
	}
	else if( OldValue!=(MagAmmoRemaining+1) )
	{
		OldValue = MagAmmoRemaining+1;
		Skins[2] = ScopeGreen;
		MyFont = Default.MyFont;

		if ((MagAmmoRemaining ) <= (MagCapacity/2))
			SetTextColor(32,187,112);
		if ((MagAmmoRemaining ) <= (MagCapacity/3))
		{
			SetTextColor(218,18,18);
			Skins[2] = ScopeRed;
		}
		if ((MagAmmoRemaining ) >= (MagCapacity/2))
			SetTextColor(76,148,177);
		MyMessage = String(MagAmmoRemaining);

		++MyScriptedTexture.Revision;
	}

	MyScriptedTexture.Client = Self;
	Super.RenderOverlays(Canvas);
	MyScriptedTexture.Client = None;
}

simulated function RenderTexture( ScriptedTexture Tex )
{
	local int w, h;

	// Ammo
	Tex.TextSize( MyMessage, MyFont, w, h );
	Tex.DrawText( ( Tex.USize / 2 ) - ( w / 2 ), ( Tex.VSize / 2 ) - ( h / 1.2 ),MyMessage, MyFont, MyFontColor );
	// Health
	Tex.TextSize( MyHealth, MyFont2, w, h );
	Tex.DrawText( ( Tex.USize / 2 ) - ( w / 2 ), ( Tex.VSize / 2 ) - 8 ,MyHealth, MyFont2, MyFontColor2 );
}

defaultproperties
{
     AmmoRegenRate=0.300000
     HealBoostAmount=20
     HealAmmoCharge=500
     SuccessfulHealMessage="You healed "
     ReloadMessage="REL"
     EmptyMessage="Empty"
     MyFontColor=(B=177,G=148,R=76,A=255)
     MyFontColor2=(B=177,G=148,R=76,A=255)
     MagCapacity=15
     ReloadRate=3.066000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_M7A3"
     Weight=6.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=55.000000
     bModeZeroCanDryFire=True
     SleeveNum=3
     TraderInfoTexture=Texture'KillingFloor2HUD.Trader_Weapon_Icons.Trader_M7A3'
     bIsTier3Weapon=True
     MeshRef="KF_Wep_M7A3.M7A3"
     SkinRefs(0)="KF_Weapons5_Trip_T.Weapons.M7A3_cmb"
     SkinRefs(1)="KF_Weapons5_Scopes_Trip_T.M7A3_Ammo_Script.AmmoShader"
     SkinRefs(2)="KF_Weapons5_Scopes_Trip_T.M7A3.Scope_Finall"
     SelectSoundRef="KF_M7A3Snd.M7A3_Select"
     HudImageRef="KillingFloor2HUD.WeaponSelect.M7A3_unselected"
     SelectedHudImageRef="KillingFloor2HUD.WeaponSelect.M7A3"
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=45.000000
     FireModeClass(0)=Class'BMTCustomMut.Tech_M7A3MFire'
     FireModeClass(1)=Class'BMTCustomMut.Tech_M7A3MAltFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="An advanced Horzine prototype assault rifle."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=100
     InventoryGroup=4
     GroupOffset=13
     PickupClass=Class'BMTCustomMut.Tech_M7A3MPickup'
     PlayerViewOffset=(X=20.000000,Y=15.000000,Z=-5.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.Tech_M7A3MAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="M7A3 Medic Gun"
     TransientSoundVolume=1.250000
}
