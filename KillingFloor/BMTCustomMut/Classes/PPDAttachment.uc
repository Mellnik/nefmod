class PPDAttachment extends KFWeaponAttachment;


// Prevents tracers from spawning if player is using the melee function of the weapon. - Thanks Yoyobatty.
simulated event ThirdPersonEffects()
{
 if( FiringMode==1 )
  return;
 Super.ThirdPersonEffects();
}

defaultproperties
{
     mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdMP'
     mTracerClass=Class'KFMod.KFNewTracer'
     MovementAnims(0)="JogF_AA12"
     MovementAnims(1)="JogB_AA12"
     MovementAnims(2)="JogL_AA12"
     MovementAnims(3)="JogR_AA12"
     TurnLeftAnim="TurnL_AA12"
     TurnRightAnim="TurnR_AA12"
     CrouchAnims(0)="CHWalkF_AA12"
     CrouchAnims(1)="CHWalkB_AA12"
     CrouchAnims(2)="CHWalkL_AA12"
     CrouchAnims(3)="CHWalkR_AA12"
     WalkAnims(0)="WalkF_AA12"
     WalkAnims(1)="WalkB_AA12"
     WalkAnims(2)="WalkL_AA12"
     WalkAnims(3)="WalkR_AA12"
     CrouchTurnRightAnim="CH_TurnR_AA12"
     CrouchTurnLeftAnim="CH_TurnL_AA12"
     IdleCrouchAnim="CHIdle_AA12"
     IdleWeaponAnim="Idle_AA12"
     IdleRestAnim="Idle_AA12"
     IdleChatAnim="Idle_AA12"
     IdleHeavyAnim="Idle_AA12"
     IdleRifleAnim="Idle_AA12"
     FireAnims(0)="Fire_AA12"
     FireAnims(1)="Fire_AA12"
     FireAnims(2)="Fire_AA12"
     FireAnims(3)="Fire_AA12"
     FireAltAnims(1)="FastAttack6_Katana"
     FireAltAnims(2)="FastAttack5_Katana"
     FireAltAnims(3)="FastAttack2_Katana"
     FireCrouchAnims(0)="CHFire_AA12"
     FireCrouchAnims(1)="CHFire_AA12"
     FireCrouchAnims(2)="CHFire_AA12"
     FireCrouchAnims(3)="CHFire_AA12"
     FireCrouchAltAnims(0)="CHHardAttack4_Axe"
     FireCrouchAltAnims(1)="CHAttack2_Axe"
     FireCrouchAltAnims(2)="CHAttack3_Chainsaw"
     FireCrouchAltAnims(3)="CHAttack1_Axe"
     HitAnims(0)="HitF_AA12"
     HitAnims(1)="HitB_AA12"
     HitAnims(2)="HitL_AA12"
     HitAnims(3)="HitR_AA12"
     PostFireBlendStandAnim="Blend_AA12"
     PostFireBlendCrouchAnim="CHBlend_AA12"
     bRapidFire=True
     bAltRapidFire=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'KF19453rdAnim.ppd40'
}
