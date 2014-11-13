class Tech_ShockRifleSpark extends Emitter;

simulated function PostBeginPlay()
{
	setTimer(0.15, false);
}

simulated function Timer()
{
  bDynamicLight=false;
  super.Timer();
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=196,G=100,R=107,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.800000,Max=0.800000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=30.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=30.000000,Max=120.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.electric'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.050000,Max=0.200000)
         InitialDelayRange=(Min=0.100000,Max=0.100000)
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=2.000000
     End Object
     Emitters(0)=SpriteEmitter'BMTCustomMut.Tech_ShockRifleSpark.SpriteEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=30.000000,Max=300.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         BranchProbability=(Min=0.500000,Max=1.000000)
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=184,G=87,R=80,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.900000))
         FadeOutStartTime=0.012000
         MaxParticles=80
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=6.000000,Max=12.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.beambolt'
         LifetimeRange=(Min=0.050000,Max=0.100000)
         InitialDelayRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=-10.000000,Max=300.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=2.000000
     End Object
     Emitters(1)=BeamEmitter'BMTCustomMut.Tech_ShockRifleSpark.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=129,G=41,R=70))
         ColorMultiplierRange=(X=(Min=0.950000,Max=0.950000),Y=(Min=0.950000,Max=0.950000))
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.300000)
         StartSizeRange=(X=(Min=300.000000,Max=600.000000),Y=(Min=400.000000,Max=600.000000),Z=(Min=400.000000,Max=600.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.TriFlare'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.120000)
     End Object
     Emitters(2)=SpriteEmitter'BMTCustomMut.Tech_ShockRifleSpark.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Forward
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=230,G=185,R=157,A=255))
         ColorScale(2)=(RelativeTime=0.400000,Color=(B=140,G=91,R=101,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         MaxParticles=4
         StartLocationRange=(Z=(Min=-5.000000,Max=30.000000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=400.000000,Max=500.000000),Y=(Min=400.000000,Max=500.000000),Z=(Min=400.000000,Max=500.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.Blast_1Frame'
         LifetimeRange=(Min=0.200000,Max=0.300000)
         InitialDelayRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=5.000000,Max=250.000000))
     End Object
     Emitters(3)=SpriteEmitter'BMTCustomMut.Tech_ShockRifleSpark.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=159,G=108,R=122,A=255))
         ColorScale(2)=(RelativeTime=0.896429,Color=(B=123,G=83,R=83,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         MaxParticles=6
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=20.000000,Max=30.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=3.000000,Max=6.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Max=150.000000),Y=(Min=300.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.BurnFlare'
         LifetimeRange=(Min=0.300000,Max=1.000000)
         InitialDelayRange=(Min=0.100000,Max=0.150000)
     End Object
     Emitters(4)=SpriteEmitter'BMTCustomMut.Tech_ShockRifleSpark.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=217,G=187,R=168,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=185,G=123,R=123,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=5.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=3.000000,Max=5.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=0.170000,RelativeSize=0.300000)
         SizeScale(3)=(RelativeTime=0.680000,RelativeSize=0.400000)
         SizeScale(4)=(RelativeTime=0.750000,RelativeSize=0.200000)
         SizeScale(5)=(RelativeTime=1.000000,RelativeSize=0.700000)
         SizeScaleRepeats=20.000000
         StartSizeRange=(X=(Min=5.000000,Max=35.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.HardSpot'
         LifetimeRange=(Min=0.600000,Max=1.800000)
         StartVelocityRange=(X=(Min=200.000000,Max=600.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=1.200000,Max=1.700000),Y=(Min=1.200000,Max=1.700000),Z=(Min=1.200000,Max=1.700000))
     End Object
     Emitters(5)=SpriteEmitter'BMTCustomMut.Tech_ShockRifleSpark.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         RespawnDeadParticles=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         UseVelocityScale=True
         Acceleration=(Z=60.000000)
         ColorScale(0)=(Color=(B=199,G=164,R=150))
         ColorScale(1)=(RelativeTime=0.250000,Color=(B=119,G=111,R=114,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=119,G=111,R=114))
         Opacity=0.800000
         MaxParticles=4
         StartLocationOffset=(X=-10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=30.000000)
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=100.000000,Max=250.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
         StartVelocityRadialRange=(Min=200.000000,Max=200.000000)
         VelocityLossRange=(X=(Max=8.000000),Y=(Max=8.000000),Z=(Max=8.000000))
     End Object
     Emitters(6)=SpriteEmitter'BMTCustomMut.Tech_ShockRifleSpark.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=232,G=214,R=206))
         ColorScale(2)=(RelativeTime=0.725000,Color=(B=132,G=79,R=94))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.750000
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=150.000000,Max=200.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'SentryTechTex1.Weapon_ShockRifle.HardSpot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.900000,Max=1.000000)
     End Object
     Emitters(7)=SpriteEmitter'BMTCustomMut.Tech_ShockRifleSpark.SpriteEmitter12'

     AutoDestroy=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=170
     LightSaturation=160
     LightBrightness=260.000000
     LightRadius=16.000000
     bNoDelete=False
     bDynamicLight=True
}
