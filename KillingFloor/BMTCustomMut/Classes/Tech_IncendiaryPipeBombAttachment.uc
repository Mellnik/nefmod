class Tech_IncendiaryPipeBombAttachment extends KFWeaponAttachment;


#exec obj load file="SentryTechTex1.utx"



// No muzzle flash for this!!!
simulated function WeaponLight(){}
simulated function DoFlashEmitter(){}

defaultproperties
{
     MovementAnims(0)="JogF_PipeBomb"
     MovementAnims(1)="JogB_PipeBomb"
     MovementAnims(2)="JogL_PipeBomb"
     MovementAnims(3)="JogR_PipeBomb"
     TurnLeftAnim="TurnL_PipeBomb"
     TurnRightAnim="TurnR_PipeBomb"
     CrouchAnims(0)="CHWalkF_PipeBomb"
     CrouchAnims(1)="CHWalkB_PipeBomb"
     CrouchAnims(2)="CHWalkL_PipeBomb"
     CrouchAnims(3)="CHWalkR_PipeBomb"
     WalkAnims(0)="WalkF_PipeBomb"
     WalkAnims(1)="WalkB_PipeBomb"
     WalkAnims(2)="WalkL_PipeBomb"
     WalkAnims(3)="WalkR_PipeBomb"
     CrouchTurnRightAnim="CH_TurnR_PipeBomb"
     CrouchTurnLeftAnim="CH_TurnL_PipeBomb"
     IdleCrouchAnim="CHIdle_PipeBomb"
     IdleWeaponAnim="Idle_PipeBomb"
     IdleRestAnim="Idle_PipeBomb"
     IdleChatAnim="Idle_PipeBomb"
     IdleHeavyAnim="Idle_PipeBomb"
     IdleRifleAnim="Idle_PipeBomb"
     FireAnims(0)="Fire_PipeBomb"
     FireAnims(1)="Fire_PipeBomb"
     FireAnims(2)="Fire_PipeBomb"
     FireAnims(3)="Fire_PipeBomb"
     FireAltAnims(0)="Fire_PipeBomb"
     FireAltAnims(1)="Fire_PipeBomb"
     FireAltAnims(2)="Fire_PipeBomb"
     FireAltAnims(3)="Fire_PipeBomb"
     FireCrouchAnims(0)="CHFire_PipeBomb"
     FireCrouchAnims(1)="CHFire_PipeBomb"
     FireCrouchAnims(2)="CHFire_PipeBomb"
     FireCrouchAnims(3)="CHFire_PipeBomb"
     FireCrouchAltAnims(0)="CHFire_PipeBomb"
     FireCrouchAltAnims(1)="CHFire_PipeBomb"
     FireCrouchAltAnims(2)="CHFire_PipeBomb"
     FireCrouchAltAnims(3)="CHFire_PipeBomb"
     HitAnims(0)="HitF_PipeBomb"
     HitAnims(1)="HitB_PipeBomb"
     HitAnims(2)="HitL_PipeBomb"
     HitAnims(3)="HitR_PipeBomb"
     PostFireBlendStandAnim="Blend_PipeBomb"
     PostFireBlendCrouchAnim="CHBlend_PipeBomb"
     MeshRef="KF_Weapons3rd2_Trip.pipebomb_3rd"
     Skins(0)=Texture'SentryTechTex1.Weapon_IncendiaryPipeBomb.IncendiaryPipeBomb_3rd'
}
