class P90Attachment extends KFWeaponAttachment;

simulated function DoFlashEmitter()
{
    if (mMuzFlash3rd == None)
    {
        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, 'ejector');
    }
    if(mMuzFlash3rd != None)
        mMuzFlash3rd.SpawnParticle(1);
}

defaultproperties
{
     mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdMP'
     mTracerClass=Class'KFMod.KFNewTracer'
     mShellCaseEmitterClass=Class'KFMod.KFShellSpewer'
     ShellEjectBoneName="ejector"
     MovementAnims(0)="JogF_MP7"
     MovementAnims(1)="JogB_MP7"
     MovementAnims(2)="JogL_MP7"
     MovementAnims(3)="JogR_MP7"
     TurnLeftAnim="TurnL_MP7"
     TurnRightAnim="TurnR_MP7"
     CrouchAnims(0)="CHWalkF_MP7"
     CrouchAnims(1)="CHWalkB_MP7"
     CrouchAnims(2)="CHWalkL_MP7"
     CrouchAnims(3)="CHWalkR_MP7"
     WalkAnims(0)="WalkF_MP7"
     WalkAnims(1)="WalkB_MP7"
     WalkAnims(2)="WalkL_MP7"
     WalkAnims(3)="WalkR_MP7"
     CrouchTurnRightAnim="CH_TurnR_MP7"
     CrouchTurnLeftAnim="CH_TurnL_MP7"
     IdleCrouchAnim="CHIdle_MP7"
     IdleWeaponAnim="Idle_MP7"
     IdleRestAnim="Idle_MP7"
     IdleChatAnim="Idle_MP7"
     IdleHeavyAnim="Idle_MP7"
     IdleRifleAnim="Idle_MP7"
     FireAnims(0)="Fire_MP7"
     FireAnims(1)="Fire_MP7"
     FireAnims(2)="Fire_MP7"
     FireAnims(3)="Fire_MP7"
     FireAltAnims(0)="Fire_MP7"
     FireAltAnims(1)="Fire_MP7"
     FireAltAnims(2)="Fire_MP7"
     FireAltAnims(3)="Fire_MP7"
     FireCrouchAnims(0)="CHFire_MP7"
     FireCrouchAnims(1)="CHFire_MP7"
     FireCrouchAnims(2)="CHFire_MP7"
     FireCrouchAnims(3)="CHFire_MP7"
     FireCrouchAltAnims(0)="CHFire_MP7"
     FireCrouchAltAnims(1)="CHFire_MP7"
     FireCrouchAltAnims(2)="CHFire_MP7"
     FireCrouchAltAnims(3)="CHFire_MP7"
     HitAnims(0)="HitF_MP7"
     HitAnims(1)="HitB_MP7"
     HitAnims(2)="HitL_MP7"
     HitAnims(3)="HitR_MP7"
     PostFireBlendStandAnim="Blend_MP7"
     PostFireBlendCrouchAnim="CHBlend_MP7"
     bRapidFire=True
     bAltRapidFire=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'P90_A.P90-3rd'
     DrawScale=0.310000
}
