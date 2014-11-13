class Tech_MachinePistol extends KFWeapon;

#exec obj load file="SentryTechTex1.utx"



var KFPlayerReplicationInfo KFPRI;
var bool LastZTState; //LastZedTimeState

function bool HandlePickupQuery( pickup Item )
{
    if ( Item.InventoryType == Class )
    {
        if ( KFHumanPawn(Owner) != none && !KFHumanPawn(Owner).CanCarry(Class'Tech_MachineDualies'.Default.Weight) )
        {
            PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages', 2);
            return true;
        }

        return false; // Allow to "pickup" so this weapon can be replaced with dualies.
    }
    Return Super(KFWeapon).HandlePickupQuery(Item);
}

simulated function bool PutDown() {
    if ( Instigator.PendingWeapon.class == class'BMTCustomMut.Tech_MachineDualies' ) {
        bIsReloading = false;
    }

    return super(KFWeapon).PutDown();
}
  
simulated function BringUp(optional Weapon PrevWeapon)
{
    local int Mode;
    local KFPlayerController Player;
    local KFPlayerReplicationInfo KFPRI;

    HandleSleeveSwapping();

    // Hint check
    Player = KFPlayerController(Instigator.Controller);
    KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
    
    

    if ( Player != none && ClientGrenadeState != GN_BringUp )
    {
        if ( class == class'Single' )
        {
            Player.CheckForHint(10);
        }
        else if ( class == class'Dualies' )
        {
            Player.CheckForHint(11);
        }
        else if ( class == class'Deagle' )
        {
            Player.CheckForHint(12);
        }
        else if ( class == class'Bullpup' )
        {
            Player.CheckForHint(13);
        }
        else if ( class == class'Shotgun' )
        {
            Player.CheckForHint(14);
        }
        else if ( class == class'Winchester' )
        {
            Player.CheckForHint(15);
        }
        else if ( class == class'Crossbow' )
        {
            Player.CheckForHint(16);
        }
        else if ( class == class'BoomStick' )
        {
            Player.CheckForHint(17);
            Player.WeaponPulloutRemark(21);
        }
        else if ( class == class'FlameThrower' )
        {
            Player.CheckForHint(18);
        }
        else if ( class == class'LAW' )
        {
            Player.CheckForHint(19);
            Player.WeaponPulloutRemark(23);
        }
        else if ( class == class'Knife' && bShowPullOutHint )
        {
            Player.CheckForHint(20);
        }
        else if ( class == class'Machete' )
        {
            Player.CheckForHint(21);
        }
        else if ( class == class'Axe' )
        {
            Player.CheckForHint(22);
            Player.WeaponPulloutRemark(24);
        }
        else if ( class == class'DualDeagle' )
        {
            Player.WeaponPulloutRemark(22);
        }

        bShowPullOutHint = true;
    }

    if ( KFHumanPawn(Instigator) != none )
        KFHumanPawn(Instigator).SetAiming(false);

    bAimingRifle = false;
    bIsReloading = false;
    IdleAnim = default.IdleAnim;
    //Super.BringUp(PrevWeapon);

    // From Weapon.uc
    if ( ClientState == WS_Hidden || ClientGrenadeState == GN_BringUp || KFPawn(Instigator).bIsQuickHealing > 0 )
    {
        PlayOwnedSound(SelectSound, SLOT_Interact,,,,, false);
        ClientPlayForceFeedback(SelectForce);  // jdf

        if ( Instigator.IsLocallyControlled() )
        {
            if ( (Mesh!=None) && HasAnim(SelectAnim) )
            {
                if( ClientGrenadeState == GN_BringUp || KFPawn(Instigator).bIsQuickHealing > 0 )
                {
                    PlayAnim(SelectAnim, SelectAnimRate * (BringUpTime/QuickBringUpTime), 0.0);
                }
                else
                {
                    PlayAnim(SelectAnim, SelectAnimRate, 0.0);
                }
            }
        }

        ClientState = WS_BringUp;
        if( ClientGrenadeState == GN_BringUp || KFPawn(Instigator).bIsQuickHealing > 0 )
        {
            ClientGrenadeState = GN_None;
            SetTimer(QuickBringUpTime, false);
        }
        else
        {
            SetTimer(BringUpTime, false);
        }
    }

    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
    {
        FireMode[Mode].bIsFiring = false;
        FireMode[Mode].HoldTime = 0.0;
        FireMode[Mode].bServerDelayStartFire = false;
        FireMode[Mode].bServerDelayStopFire = false;
        FireMode[Mode].bInstantStop = false;
    }

    if ( (PrevWeapon != None) && PrevWeapon.HasAmmo() && !PrevWeapon.bNoVoluntarySwitch )
        OldWeapon = PrevWeapon;
    else
        OldWeapon = None;
}

simulated function WeaponTick(float dt)
{
    Super.WeaponTick(dt);

    //if we're in the same state as the last time we checked, no need to do anything right now, exit
    
    if (KFGameType(Level.Game) == None)
        return;
    
    if (KFGameType(Level.Game).bZEDTimeActive == LastZTState)
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

defaultproperties
{
     FirstPersonFlashlightOffset=(X=-20.000000,Y=-22.000000,Z=8.000000)
     MagCapacity=16
     ReloadRate=2.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Single9mm"
     ModeSwitchAnim="LightOn"
     Weight=1.000000
     bTorchEnabled=True
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_9mm'
     MeshRef="KF_Weapons_Trip.9mm_Trip"
     SelectSoundRef="KF_9MMSnd.9mm_Select"
     HudImageRef="KillingFloorHUD.WeaponSelect.single_9mm_unselected"
     SelectedHudImageRef="KillingFloorHUD.WeaponSelect.single_9mm"
     ZoomedDisplayFOV=65.000000
     FireModeClass(0)=Class'BMTCustomMut.Tech_MachinePistolFire'
     FireModeClass(1)=Class'KFMod.SingleALTFire'
     PutDownAnim="PutDown"
     AIRating=0.250000
     CurrentRating=0.250000
     bShowChargingBar=True
     Description="A Machine Pistol"
     DisplayFOV=70.000000
     Priority=3
     InventoryGroup=2
     GroupOffset=1
     PickupClass=Class'BMTCustomMut.Tech_MachinePistolPickup'
     PlayerViewOffset=(X=20.000000,Y=25.000000,Z=-10.000000)
     BobDamping=6.000000
     AttachmentClass=Class'BMTCustomMut.Tech_MachinePistolAttachment'
     IconCoords=(X1=434,Y1=253,X2=506,Y2=292)
     ItemName="Machine Pistol"
     Skins(0)=Texture'SentryTechTex1.Weapon_MachinePistol.MachinePistol_D'
}
