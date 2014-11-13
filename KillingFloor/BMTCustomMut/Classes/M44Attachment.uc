class M44Attachment extends KFWeaponAttachment;

// Prevents tracers from spawning if player is using the melee function of the weapon. - Thanks Yoyobatty.
simulated event ThirdPersonEffects()
{
 if( FiringMode==1 )
  return;
 Super.ThirdPersonEffects();
}

defaultproperties
{
     mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdSTG'
     mTracerClass=Class'KFMod.KFLargeTracer'
     MovementAnims(0)="JogF_Winchester"
     MovementAnims(1)="JogB_Winchester"
     MovementAnims(2)="JogL_Winchester"
     MovementAnims(3)="JogR_Winchester"
     TurnLeftAnim="TurnL_Winchester"
     TurnRightAnim="TurnR_Winchester"
     CrouchAnims(0)="CHwalkF_Winchester"
     CrouchAnims(1)="CHwalkB_Winchester"
     CrouchAnims(2)="CHwalkL_Winchester"
     CrouchAnims(3)="CHwalkR_Winchester"
     WalkAnims(0)="WalkF_Winchester"
     WalkAnims(1)="WalkB_Winchester"
     WalkAnims(2)="WalkL_Winchester"
     WalkAnims(3)="WalkR_Winchester"
     CrouchTurnRightAnim="CH_TurnR_Winchester"
     CrouchTurnLeftAnim="CH_TurnL_Winchester"
     IdleCrouchAnim="CHIdle_Winchester"
     IdleWeaponAnim="Idle_Winchester"
     IdleRestAnim="Idle_Winchester"
     IdleChatAnim="Idle_Winchester"
     IdleHeavyAnim="Idle_Winchester"
     IdleRifleAnim="Idle_Winchester"
     FireAnims(0)="Fire_M14"
     FireAnims(1)="Fire_M14"
     FireAnims(2)="Fire_M14"
     FireAnims(3)="Fire_M14"
     FireAltAnims(0)="Attack4_Pipe"
     FireAltAnims(1)="Attack4_Pipe"
     FireAltAnims(2)="Attack4_Pipe"
     FireAltAnims(3)="Attack4_Pipe"
     FireCrouchAnims(0)="CHFire_M14"
     FireCrouchAnims(1)="CHFire_M14"
     FireCrouchAnims(2)="CHFire_M14"
     FireCrouchAnims(3)="CHFire_M14"
     FireCrouchAltAnims(0)="CHAttack1_Knife"
     FireCrouchAltAnims(1)="CHAttack1_Knife"
     FireCrouchAltAnims(2)="CHAttack1_Knife"
     FireCrouchAltAnims(3)="CHAttack1_Knife"
     HitAnims(0)="HitF_M14"
     HitAnims(1)="HitB_M14"
     HitAnims(2)="HitL_M14"
     HitAnims(3)="HitR_M14"
     PostFireBlendStandAnim="Blend_M14"
     PostFireBlendCrouchAnim="CHBlend_M14"
     bHeavy=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'KF19453rdAnim.M44'
}
