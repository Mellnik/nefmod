class Tech_BioLauncherProjEmitter extends Emitter;

var bool bFlashed;

simulated function PostBeginPlay()
{
	Super.Postbeginplay();
	NadeLight();
}
simulated function NadeLight()
{
	if ( !Level.bDropDetail && (Instigator != None)
		&& ((Level.TimeSeconds - LastRenderTime < 0.2) || (PlayerController(Instigator.Controller) != None)) )
	{
		bDynamicLight = true;
		SetTimer(0.25, false);
	}
	else Timer();
}
simulated function Timer()
{
	bDynamicLight = false;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=24,G=224,R=45))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=57,G=238,R=57))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=2,G=253,R=71))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=41,G=216,R=72))
         FadeOutFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=5.000000
         SpinsPerSecondRange=(Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.250000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'kf_fx_trip_t.Misc.smoke_animated'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         StartVelocityRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000))
         VelocityLossRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BMTCustomMut.Tech_BioLauncherProjEmitter.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=24,G=224,R=45))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=57,G=238,R=57))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=2,G=253,R=71))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=41,G=216,R=72))
         FadeOutFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=5.000000
         MaxParticles=1
         StartLocationRange=(Z=(Min=20.000000,Max=20.000000))
         SpinsPerSecondRange=(Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.100000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'kf_fx_trip_t.Misc.smoke_animated'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         VelocityLossRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(1)=SpriteEmitter'BMTCustomMut.Tech_BioLauncherProjEmitter.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=24,G=224,R=45))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=57,G=238,R=57))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=2,G=253,R=71))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=41,G=216,R=72))
         FadeOutFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=5.000000
         MaxParticles=1
         StartLocationRange=(Z=(Max=20.000000))
         SpinsPerSecondRange=(Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'kf_fx_trip_t.Misc.smoke_animated'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=750.000000,Max=750.000000))
         VelocityLossRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
     End Object
     Emitters(2)=SpriteEmitter'BMTCustomMut.Tech_BioLauncherProjEmitter.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter86
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=24,G=224,R=45))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=57,G=238,R=57))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=2,G=253,R=71))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=41,G=216,R=72))
         FadeOutStartTime=0.102500
         FadeInEndTime=0.050000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.140000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.impact_2frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(Z=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(3)=SpriteEmitter'BMTCustomMut.Tech_BioLauncherProjEmitter.SpriteEmitter86'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter87
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=24,G=224,R=45))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=57,G=238,R=57))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=2,G=253,R=71))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=41,G=216,R=72))
         FadeOutStartTime=0.336000
         FadeInEndTime=0.064000
         MaxParticles=1
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         ScaleSizeByVelocityMultiplier=(X=0.010000,Y=0.010000)
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.shrapnel3'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=100.000000,Max=500.000000))
     End Object
     Emitters(4)=SpriteEmitter'BMTCustomMut.Tech_BioLauncherProjEmitter.SpriteEmitter87'

     AutoDestroy=True
     LightType=LT_Steady
     LightHue=30
     LightSaturation=100
     LightBrightness=500.000000
     LightRadius=8.000000
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
     bNotOnDedServer=False
}
