class LilithKissAttachment extends DualiesAttachment;

simulated function UpdateTacBeam( float Dist );
simulated function TacBeamGone();

defaultproperties
{
     BrotherMesh=SkeletalMesh'LilithKiss_A.lilith_3rd'
     mTracerClass=None
     mShellCaseEmitterClass=None
     bHeavy=True
     SplashEffect=Class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'LilithKiss_A.lilith_3rd'
}
