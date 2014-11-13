class Tech_AdvancedWelderAttachment extends  KFMeleeAttachment ;

#exec obj load file="SentryTechTex1.utx"
#exec obj load file="SentryTechAnim1.ukx"
#exec obj load file="SentryTechStatics.usx"
#exec obj load file="SentryTechSounds.uax"

defaultproperties
{
     MovementAnims(0)="JogF_Syringe"
     MovementAnims(1)="JogB_Syringe"
     MovementAnims(2)="JogL_Syringe"
     MovementAnims(3)="JogR_Syringe"
     TurnLeftAnim="TurnL_Syringe"
     TurnRightAnim="TurnR_Syringe"
     CrouchAnims(0)="CHwalkF_Syringe"
     CrouchAnims(1)="CHwalkB_Syringe"
     CrouchAnims(2)="CHwalkL_Syringe"
     CrouchAnims(3)="CHwalkR_Syringe"
     CrouchTurnRightAnim="CH_TurnR_Syringe"
     CrouchTurnLeftAnim="CH_TurnL_Syringe"
     IdleCrouchAnim="CHIdle_Syringe"
     IdleWeaponAnim="Idle_Syringe"
     IdleRestAnim="Idle_Syringe"
     IdleChatAnim="Idle_Syringe"
     IdleHeavyAnim="Idle_Syringe"
     IdleRifleAnim="Idle_Syringe"
     FireAnims(0)="Weld_Welder"
     FireAnims(1)="Weld_Welder"
     FireAnims(2)="Weld_Welder"
     FireAnims(3)="Weld_Welder"
     FireAltAnims(0)="Weld_Welder"
     FireAltAnims(1)="Weld_Welder"
     FireAltAnims(2)="Weld_Welder"
     FireAltAnims(3)="Weld_Welder"
     FireCrouchAnims(0)="CHWeld_Welder"
     FireCrouchAnims(1)="CHWeld_Welder"
     FireCrouchAnims(2)="CHWeld_Welder"
     FireCrouchAnims(3)="CHWeld_Welder"
     FireCrouchAltAnims(0)="CHWeld_Welder"
     FireCrouchAltAnims(1)="CHWeld_Welder"
     FireCrouchAltAnims(2)="CHWeld_Welder"
     FireCrouchAltAnims(3)="CHWeld_Welder"
     HitAnims(0)="HitF_Syringe"
     HitAnims(1)="HitB_Syringe"
     HitAnims(2)="HitL_Syringe"
     HitAnims(3)="HitR_Syringe"
     PostFireBlendStandAnim="Blend_Syringe"
     PostFireBlendCrouchAnim="CHBlend_Syringe"
     LightType=LT_Flicker
     LightEffect=LE_QuadraticNonIncidence
     LightHue=145
     LightSaturation=35
     LightBrightness=200.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'KF_Weapons3rd_Trip.Welder_3rd'
     Skins(0)=Texture'SentryTechTex1.Weapon_AdvancedWelder.AdvancedWelder_3rd'
}
