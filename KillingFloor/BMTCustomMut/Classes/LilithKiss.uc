class LilithKiss extends KFWeaponShotgun;

var name altFlashBoneName;
var name altTPAnim;
var Actor altThirdPersonActor;
var name altWeaponAttach;

/**
 * Handles all the functionality for zooming in including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomIn(bool bAnimateTransition)
{
    super.ZoomIn(bAnimateTransition);

    if( bAnimateTransition )
    {
        if( bZoomOutInterrupted )
        {
            PlayAnim('GOTO_Iron',1.0,0.1);
        }
        else
        {
            PlayAnim('GOTO_Iron',1.0,0.1);
        }
    }
}

/**
 * Handles all the functionality for zooming out including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomOut(bool bAnimateTransition)
{
    local float AnimLength, AnimSpeed;
    super.ZoomOut(false);

    if( bAnimateTransition )
    {
        AnimLength = GetAnimDuration('GOTO_Hip', 1.0);

        if( ZoomTime > 0 && AnimLength > 0 )
        {
            AnimSpeed = AnimLength/ZoomTime;
        }
        else
        {
            AnimSpeed = 1.0;
        }
        PlayAnim('GOTO_Hip',AnimSpeed,0.1);
    }
}

function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;
	return (AIRating + 0.00092 * FMin(800 - VSize(B.Enemy.Location - Instigator.Location),650));
}

function byte BestMode()
{
    return 0;
}

function bool RecommendRangedAttack()
{
	return true;
}

function float SuggestAttackStyle()
{
    return -0.7;
}

function AttachToPawn(Pawn P)
{
	local name BoneName;

	Super.AttachToPawn(P);

	if(altThirdPersonActor == None)
	{
		altThirdPersonActor = Spawn(AttachmentClass,Owner);
		InventoryAttachment(altThirdPersonActor).InitFor(self);
	}
	else altThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	BoneName = P.GetOffhandBoneFor(self);
	if(BoneName == '')
	{
		altThirdPersonActor.SetLocation(P.Location);
		altThirdPersonActor.SetBase(P);
	}
	else P.AttachToBone(altThirdPersonActor,BoneName);

	if(altThirdPersonActor != None)
		DualiesAttachment(altThirdPersonActor).bIsOffHand = true;
	if(altThirdPersonActor != None && ThirdPersonActor != None)
	{
		DualiesAttachment(altThirdPersonActor).brother = DualiesAttachment(ThirdPersonActor);
		DualiesAttachment(ThirdPersonActor).brother = DualiesAttachment(altThirdPersonActor);
		altThirdPersonActor.LinkMesh(DualiesAttachment(ThirdPersonActor).BrotherMesh);
	}
}

simulated function DetachFromPawn(Pawn P)
{
	Super.DetachFromPawn(P);
	if ( altThirdPersonActor != None )
	{
		altThirdPersonActor.Destroy();
		altThirdPersonActor = None;
	}
}

simulated function Destroyed()
{
	Super.Destroyed();

	if( ThirdPersonActor!=None )
		ThirdPersonActor.Destroy();
	if( altThirdPersonActor!=None )
		altThirdPersonActor.Destroy();
}

simulated function vector GetEffectStart()
{
    local Vector RightFlashLoc,LeftFlashLoc;

    RightFlashLoc = GetBoneCoords(default.FlashBoneName).Origin;
    LeftFlashLoc = GetBoneCoords(default.altFlashBoneName).Origin;

    // jjs - this function should actually never be called in third person views
    // any effect that needs a 3rdp weapon offset should figure it out itself

    // 1st person
    if (Instigator.IsFirstPerson())
    {
        if ( WeaponCentered() )
            return CenteredEffectStart();

        if( bAimingRifle )
        {
            if( KFFire(GetFireMode(0)).FireAimedAnim != 'FireLeft_Iron' )
            {
                return RightFlashLoc;
            }
            else // Off hand firing.  Moves tracer to the left.
            {
                return LeftFlashLoc;
            }
    	}
    	else
    	{
            if (GetFireMode(0).FireAnim != 'FireLeft')
            {
                return RightFlashLoc;
            }
            else // Off hand firing.  Moves tracer to the left.
            {
                return LeftFlashLoc;
            }
    	}
    }
    // 3rd person
    else
    {
        return (Instigator.Location +
            Instigator.EyeHeight*Vect(0,0,0.5) +
            Vector(Instigator.Rotation) * 40.0);
    }
}

defaultproperties
{
     altFlashBoneName="Tip_Left"
     altTPAnim="DualiesAttackLeft"
     altWeaponAttach="Bone_weapon2"
     MagCapacity=20
     ReloadRate=0.200000
     ReloadAnim="Reload"
     ReloadAnimRate=0.200000
     FlashBoneName="Tip_Right"
     WeaponReloadAnim="Reload_Shotgun"
     HudImage=Texture'LilithKiss_T.pic_unsel'
     SelectedHudImage=Texture'LilithKiss_T.pic_sel'
     Weight=12.000000
     bHasAimingMode=True
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     SleeveNum=0
     TraderInfoTexture=Texture'LilithKiss_T.pic_trader'
     ZoomInRotation=(Pitch=0,Roll=0)
     ZoomedDisplayFOV=65.000000
     FireModeClass(0)=Class'BMTCustomMut.LilithKissFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'LilithKiss_S.lilith_draw'
     AIRating=0.440000
     CurrentRating=0.440000
     bShowChargingBar=True
     Description="Specially modified automatic shotguns, given as a gift for Valentine's Day."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=70.000000
     Priority=32
     InventoryGroup=4
     GroupOffset=2
     PickupClass=Class'BMTCustomMut.LilithKissPickup'
     PlayerViewOffset=(X=20.000000,Z=-7.000000)
     BobDamping=7.000000
     AttachmentClass=Class'BMTCustomMut.LilithKissAttachment'
     IconCoords=(X1=229,Y1=258,X2=296,Y2=307)
     ItemName="Lilith's Kisses"
     Mesh=SkeletalMesh'LilithKiss_A.lilith_kiss'
     DrawScale=0.900000
     Skins(1)=Combiner'LilithKiss_T.warhammer_cmb'
     Skins(3)=Combiner'LilithKiss_T.warhammer_flip_cmb'
     TransientSoundVolume=1.000000
}
