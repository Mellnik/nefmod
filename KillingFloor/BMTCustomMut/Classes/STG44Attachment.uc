class STG44Attachment extends KFWeaponAttachment;

// Prevents tracers from spawning if player is using the melee function of the weapon. - Thanks Yoyobatty.
simulated event ThirdPersonEffects()
{
 if( FiringMode==1 )
  return;
 Super.ThirdPersonEffects();
}

simulated function DoFlashEmitter()
{
    if (mMuzFlash3rd == None)
    {
        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, 'muzzle');
    }
    if(mMuzFlash3rd != None)
        mMuzFlash3rd.SpawnParticle(1);
}

defaultproperties
{
     mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdMP'
     mTracerClass=Class'KFMod.KFNewTracer'
     mShellCaseEmitterClass=Class'KFMod.KFShellSpewer'
     MovementAnims(0)="JogF_AK47"
     MovementAnims(1)="JogB_AK47"
     MovementAnims(2)="JogL_AK47"
     MovementAnims(3)="JogR_AK47"
     TurnLeftAnim="TurnL_AK47"
     TurnRightAnim="TurnR_AK47"
     CrouchAnims(0)="CHWalkF_AK47"
     CrouchAnims(1)="CHWalkB_AK47"
     CrouchAnims(2)="CHWalkL_AK47"
     CrouchAnims(3)="CHWalkR_AK47"
     WalkAnims(0)="WalkF_AK47"
     WalkAnims(1)="WalkB_AK47"
     WalkAnims(2)="WalkL_AK47"
     WalkAnims(3)="WalkR_AK47"
     CrouchTurnRightAnim="CH_TurnR_AK47"
     CrouchTurnLeftAnim="CH_TurnL_AK47"
     IdleCrouchAnim="CHIdle_AK47"
     IdleWeaponAnim="Idle_AK47"
     IdleRestAnim="Idle_AK47"
     IdleChatAnim="Idle_AK47"
     IdleHeavyAnim="Idle_AK47"
     IdleRifleAnim="Idle_AK47"
     FireAnims(0)="Fire_AK47"
     FireAnims(1)="Fire_AK47"
     FireAnims(2)="Fire_AK47"
     FireAnims(3)="Fire_AK47"
     FireAltAnims(1)="FastAttack6_Katana"
     FireAltAnims(2)="FastAttack5_Katana"
     FireAltAnims(3)="FastAttack2_Katana"
     FireCrouchAnims(0)="CHFire_AK47"
     FireCrouchAnims(1)="CHFire_AK47"
     FireCrouchAnims(2)="CHFire_AK47"
     FireCrouchAnims(3)="CHFire_AK47"
     FireCrouchAltAnims(0)="CHHardAttack4_Axe"
     FireCrouchAltAnims(1)="CHAttack2_Axe"
     FireCrouchAltAnims(2)="CHAttack3_Chainsaw"
     FireCrouchAltAnims(3)="CHAttack1_Axe"
     HitAnims(0)="HitF_AK47"
     HitAnims(1)="HitB_AK47"
     HitAnims(2)="HitL_AK47"
     HitAnims(3)="HitR_AK47"
     PostFireBlendStandAnim="Blend_AK47"
     PostFireBlendCrouchAnim="CHBlend_AK47"
     bRapidFire=True
     bAltRapidFire=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'KF19453rdAnim.stg44'
}
