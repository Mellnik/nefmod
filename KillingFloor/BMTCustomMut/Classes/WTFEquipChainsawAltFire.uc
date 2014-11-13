class WTFEquipChainsawAltFire extends ChainsawAltFire;

static function PreloadAssets(optional KFMeleeFire Spawned)
{
	super.PreloadAssets(Spawned);

	default.FireEndSound = sound(DynamicLoadObject(default.FireEndSoundRef, class'sound', true));

	if ( ChainsawAltFire(Spawned) != none )
	{
		ChainsawAltFire(Spawned).FireEndSound = default.FireEndSound;
	}
}

static function bool UnloadAssets()
{
	super.UnloadAssets();

	default.FireEndSound = none;

	return true;
}

simulated event ModeDoFire()
{
    local int AnimToPlay;

    if(FireAnims.length > 0)
    {
        AnimToPlay = rand(FireAnims.length);
        FireAnim = FireAnims[AnimToPlay];
    }

    Super.ModeDoFire();

}

simulated function Timer()
{
	local Actor HitActor;
	local vector StartTrace, EndTrace, HitLocation, HitNormal;
	local rotator PointRot;
	local int MyDamage;
	local KFPlayerReplicationInfo KFPRI;
	
	If( !KFWeapon(Weapon).bNoHit )
	{
		hitDamageClass=Class'KFMod.DamTypeAxe'; //set back to default in case it was changed by a firebug doing a death from above attack :P
		MyDamage = MeleeDamage + Rand(MeleeDamage);
		StartTrace = Instigator.Location + Instigator.EyePosition();

		if( Instigator.Controller!=None && PlayerController(Instigator.Controller)==None && Instigator.Controller.Enemy!=None )
		{
        	PointRot = rotator(Instigator.Controller.Enemy.Location-StartTrace); // Give aimbot for bots.
        }
		else
        {
            PointRot = Instigator.GetViewRotation();
        }

		EndTrace = StartTrace + vector(PointRot)*weaponRange;
		HitActor = Instigator.Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);

		if (HitActor!=None)
		{
			ImpactShakeView();

			if( HitActor.IsA('ExtendedZCollision') && HitActor.Base != none &&
                HitActor.Base.IsA('KFMonster') )
            {
                HitActor = HitActor.Base;
            }

			if ( (HitActor.IsA('KFMonster') || HitActor.IsA('KFHumanPawn')) && KFMeleeGun(Weapon).BloodyMaterial!=none )
			{
				Weapon.Skins[KFMeleeGun(Weapon).BloodSkinSwitchArray] = KFMeleeGun(Weapon).BloodyMaterial;
				Weapon.texture = Weapon.default.Texture;
			}
			
			if( (KFMonster(HitActor)!=none) )
			{
				KFPRI = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo);
			
				//special fx; happens on clients and listen server host
				if( Level.NetMode!=NM_DedicatedServer )
				{
					if (Instigator.Velocity.Z < 0)
					{					
						if (KFPRI != none)
						{
							if (KFPRI.ClientVeteranSkill == Class'WTFPerksBerserker')
								Spawn(Class'WTFEquipChainsawBloodExplosion',,, HitLocation, rotator(HitLocation - StartTrace));
						}
					}
				}

				//only server deals the damage
				if( Level.NetMode==NM_Client )
				{
					Return;
				}
				
				if( HitActor.IsA('Pawn') && !HitActor.IsA('Vehicle')
				 && (Normal(HitActor.Location-Instigator.Location) dot vector(HitActor.Rotation))<0 )
				{
					MyDamage*=2; // Backstab >:P
				}
				
				if ( Instigator.Velocity.Z < 0)
				{
					if (KFPRI != None && KFPRI.ClientVeteranSkill == Class'WTFPerksBerserker')
						MyDamage *= 1.15; //bonus damage for falling strike
				}

                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass);
				
            	if(MeleeHitSounds.Length > 0)
            	{
            		Weapon.PlaySound(MeleeHitSounds[Rand(MeleeHitSounds.length)],SLOT_None,MeleeHitVolume,,,,false);
            	}

				if(VSize(Instigator.Velocity) > 300 && KFMonster(HitActor).Mass <= Instigator.Mass)
				{
				    KFMonster(HitActor).FlipOver();
				}

			}
			else
			{
				HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;
				Spawn(HitEffectClass,,, HitLocation, rotator(HitLocation - StartTrace));
				//if( KFWeaponAttachment(Weapon.ThirdPersonActor)!=None )
		        //  KFWeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(HitActor,HitLocation,HitNormal);

		        //Weapon.IncrementFlashCount(ThisModeNum);
			}
		}
	}
}

defaultproperties
{
     MeleeDamage=325
     hitDamageClass=Class'BMTCustomMut.DamTypeWTFEquipChainsaw'
     HitEffectClass=Class'BMTCustomMut.WTFEquipChainsawHitEffect'
}
