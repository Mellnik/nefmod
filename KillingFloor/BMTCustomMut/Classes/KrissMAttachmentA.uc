//=============================================================================
// KrissMAttachment
//=============================================================================
// Kriss medic gun third person attachment class
//=============================================================================
// Killing Floor Source
// Copyright (C) 2012 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class KrissMAttachmentA extends KFWeaponAttachment;

defaultproperties
{
     mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdMP'
     mTracerClass=Class'KFMod.KFNewTracer'
     mShellCaseEmitterClass=Class'KFMod.KFShellSpewer'
     MovementAnims(0)="JogF_Kriss"
     MovementAnims(1)="JogB_Kriss"
     MovementAnims(2)="JogL_Kriss"
     MovementAnims(3)="JogR_Kriss"
     TurnLeftAnim="TurnL_Kriss"
     TurnRightAnim="TurnR_Kriss"
     CrouchAnims(0)="CHWalkF_Kriss"
     CrouchAnims(1)="CHWalkB_Kriss"
     CrouchAnims(2)="CHWalkL_Kriss"
     CrouchAnims(3)="CHWalkR_Kriss"
     WalkAnims(0)="WalkF_Kriss"
     WalkAnims(1)="WalkB_Kriss"
     WalkAnims(2)="WalkL_Kriss"
     WalkAnims(3)="WalkR_Kriss"
     CrouchTurnRightAnim="CH_TurnR_Kriss"
     CrouchTurnLeftAnim="CH_TurnL_Kriss"
     IdleCrouchAnim="CHIdle_Kriss"
     IdleWeaponAnim="Idle_Kriss"
     IdleRestAnim="Idle_Kriss"
     IdleChatAnim="Idle_Kriss"
     IdleHeavyAnim="Idle_Kriss"
     IdleRifleAnim="Idle_Kriss"
     FireAnims(0)="Fire_Kriss"
     FireAnims(1)="Fire_Kriss"
     FireAnims(2)="Fire_Kriss"
     FireAnims(3)="Fire_Kriss"
     FireAltAnims(0)="Fire_Kriss"
     FireAltAnims(1)="Fire_Kriss"
     FireAltAnims(2)="Fire_Kriss"
     FireAltAnims(3)="Fire_Kriss"
     FireCrouchAnims(0)="CHFire_Kriss"
     FireCrouchAnims(1)="CHFire_Kriss"
     FireCrouchAnims(2)="CHFire_Kriss"
     FireCrouchAnims(3)="CHFire_Kriss"
     FireCrouchAltAnims(0)="CHFire_Kriss"
     FireCrouchAltAnims(1)="CHFire_Kriss"
     FireCrouchAltAnims(2)="CHFire_Kriss"
     FireCrouchAltAnims(3)="CHFire_Kriss"
     HitAnims(0)="HitF_Kriss"
     HitAnims(1)="HitB_Kriss"
     HitAnims(2)="HitL_Kriss"
     HitAnims(3)="HitR_Kriss"
     PostFireBlendStandAnim="Blend_Kriss"
     PostFireBlendCrouchAnim="CHBlend_Kriss"
     MeshRef="KF_Weapons3rd6_Trip.Kriss_3rd"
     WeaponAmbientScale=2.000000
     bRapidFire=True
     bAltRapidFire=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
}