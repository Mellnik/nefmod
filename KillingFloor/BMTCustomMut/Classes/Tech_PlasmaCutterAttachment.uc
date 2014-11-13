class Tech_PlasmaCutterAttachment extends KFWeaponAttachment;

simulated function DoFlashEmitter()
{
    if (mMuzFlash3rd == None)
    {

        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, 'MainTip');

        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, 'TopTip');

        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, 'BottomTip');

    }
    if(mMuzFlash3rd != None)
        mMuzFlash3rd.SpawnParticle(1);
}

defaultproperties
{
     mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdKar'
     mShellCaseEmitterClass=Class'KFMod.KFShotgunShellSpewer'
     MovementAnims(0)="JogF_Single9mm"
     MovementAnims(1)="JogB_Single9mm"
     MovementAnims(2)="JogL_Single9mm"
     MovementAnims(3)="JogR_Single9mm"
     TurnLeftAnim="TurnL_Single9mm"
     TurnRightAnim="TurnR_Single9mm"
     CrouchAnims(0)="CHwalkF_Single9mm"
     CrouchAnims(1)="CHwalkB_Single9mm"
     CrouchAnims(2)="CHwalkL_Single9mm"
     CrouchAnims(3)="CHwalkR_Single9mm"
     CrouchTurnRightAnim="CH_TurnR_Single9mm"
     CrouchTurnLeftAnim="CH_TurnL_Single9mm"
     IdleCrouchAnim="CHIdle_Single9mm"
     IdleWeaponAnim="Idle_Single9mm"
     IdleRestAnim="Idle_Single9mm"
     IdleChatAnim="Idle_Single9mm"
     IdleHeavyAnim="Idle_Single9mm"
     IdleRifleAnim="Idle_Single9mm"
     FireAnims(0)="Fire_Single9mm"
     FireAnims(1)="Fire_Single9mm"
     FireAnims(2)="Fire_Single9mm"
     FireAnims(3)="Fire_Single9mm"
     FireAltAnims(0)="Fire_Single9mm"
     FireAltAnims(1)="Fire_Single9mm"
     FireAltAnims(2)="Fire_Single9mm"
     FireAltAnims(3)="Fire_Single9mm"
     FireCrouchAnims(0)="CHFire_Single9mm"
     FireCrouchAnims(1)="CHFire_Single9mm"
     FireCrouchAnims(2)="CHFire_Single9mm"
     FireCrouchAnims(3)="CHFire_Single9mm"
     FireCrouchAltAnims(0)="CHFire_Single9mm"
     FireCrouchAltAnims(1)="CHFire_Single9mm"
     FireCrouchAltAnims(2)="CHFire_Single9mm"
     FireCrouchAltAnims(3)="CHFire_Single9mm"
     HitAnims(0)="HitF_Single9mm"
     HitAnims(1)="HitB_Single9mm"
     HitAnims(2)="HitL_Single9mm"
     HitAnims(3)="HitR_Single9mm"
     PostFireBlendStandAnim="Blend_Single9mm"
     PostFireBlendCrouchAnim="CHBlend_Single9mm"
     bHeavy=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'SentryTechAnim1.PlasmaCutter3rd'
     RelativeLocation=(Y=-8.300000,Z=6.500000)
}
