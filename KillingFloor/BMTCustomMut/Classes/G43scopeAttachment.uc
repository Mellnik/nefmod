class G43ScopeAttachment extends KFWeaponAttachment;


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
     MovementAnims(0)="JogF_M14"
     MovementAnims(1)="JogB_M14"
     MovementAnims(2)="JogL_M14"
     MovementAnims(3)="JogR_M14"
     TurnLeftAnim="TurnL_M14"
     TurnRightAnim="TurnR_M14"
     CrouchAnims(0)="CHWalkF_M14"
     CrouchAnims(1)="CHWalkB_M14"
     CrouchAnims(2)="CHWalkL_M14"
     CrouchAnims(3)="CHWalkR_M14"
     WalkAnims(0)="WalkF_M14"
     WalkAnims(1)="WalkB_M14"
     WalkAnims(2)="WalkL_M14"
     WalkAnims(3)="WalkR_M14"
     CrouchTurnRightAnim="CH_TurnR_M14"
     CrouchTurnLeftAnim="CH_TurnL_M14"
     IdleCrouchAnim="CHIdle_M14"
     IdleWeaponAnim="Idle_M14"
     IdleRestAnim="Idle_M14"
     IdleChatAnim="Idle_M14"
     IdleHeavyAnim="Idle_M14"
     IdleRifleAnim="Idle_M14"
     FireAnims(0)="Fire_M14"
     FireAnims(1)="Fire_M14"
     FireAnims(2)="Fire_M14"
     FireAnims(3)="Fire_M14"
     FireAltAnims(1)="FastAttack6_Katana"
     FireAltAnims(2)="FastAttack5_Katana"
     FireAltAnims(3)="FastAttack2_Katana"
     FireCrouchAnims(0)="CHFire_M14"
     FireCrouchAnims(1)="CHFire_M14"
     FireCrouchAnims(2)="CHFire_M14"
     FireCrouchAnims(3)="CHFire_M14"
     FireCrouchAltAnims(0)="CHHardAttack4_Axe"
     FireCrouchAltAnims(1)="CHAttack2_Axe"
     FireCrouchAltAnims(2)="CHAttack3_Chainsaw"
     FireCrouchAltAnims(3)="CHAttack1_Axe"
     HitAnims(0)="HitF_M14"
     HitAnims(1)="HitB_M14"
     HitAnims(2)="HitL_M14"
     HitAnims(3)="HitR_M14"
     PostFireBlendStandAnim="Blend_M14"
     PostFireBlendCrouchAnim="CHBlend_M14"
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'KF19453rdAnim.g43scope'
}
