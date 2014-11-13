class TT33Attachment extends KFWeaponAttachment;


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
     mShellCaseEmitterClass=Class'KFMod.KFShellSpewer'
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
     FireAltAnims(0)="Attack3_Pipe"
     FireAltAnims(1)="Attack2_Pipe"
     FireAltAnims(2)="FastAttack1_Machete"
     FireAltAnims(3)="Attack1_Pipe"
     FireCrouchAnims(0)="CHFire_Single9mm"
     FireCrouchAnims(1)="CHFire_Single9mm"
     FireCrouchAnims(2)="CHFire_Single9mm"
     FireCrouchAnims(3)="CHFire_Single9mm"
     FireCrouchAltAnims(0)="CHFastAttack1_machete"
     FireCrouchAltAnims(1)="CHFastAttack2_machete"
     FireCrouchAltAnims(2)="CHFastAttack3_machete"
     FireCrouchAltAnims(3)="CHFastAttack4_machete"
     HitAnims(0)="HitF_Single9mm"
     HitAnims(1)="HitB_Single9mm"
     HitAnims(2)="HitL_Single9mm"
     HitAnims(3)="HitR_Single9mm"
     PostFireBlendStandAnim="Blend_Single9mm"
     PostFireBlendCrouchAnim="CHBlend_Single9mm"
     bAltRapidFire=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'KF19453rdAnim.tt33'
}
