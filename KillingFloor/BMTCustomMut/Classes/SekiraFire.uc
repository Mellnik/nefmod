class SekiraFire extends AxeFire;

var array<Actor> HitActors;
var bool IsSoundPlayed;

simulated function Timer()
{
	local Actor HitActor;
	local vector StartTrace, EndTrace, HitLocation, HitNormal;
	local rotator PointRot;
	local int MyDamage, dalpha, tempalpha; // angle calculating	
	
	MyDamage = MeleeDamage + Rand(MeleeDamage);

	If( !KFWeapon(Weapon).bNoHit )
	{
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
		HitActors[HitActors.Length] = HitActor;

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
			if( Level.NetMode==NM_Client )
            {
                Return;
            }

			if( HitActor.IsA('Pawn') && !HitActor.IsA('Vehicle')
			 && (Normal(HitActor.Location-Instigator.Location) dot vector(HitActor.Rotation))<0 )
			{
				MyDamage*=2; // Backstab >:P
			}

			if( (KFMonster(HitActor)!=none) )
			{
			
                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;

            	Weapon.PlaySound(MeleeHitSounds[0],SLOT_None,MeleeHitVolume,,,,false);
            	
				if(VSize(Instigator.Velocity) > 300 && KFMonster(HitActor).Mass <= Instigator.Mass)
				{
				    KFMonster(HitActor).FlipOver();
				}

			}
			else
			{
				HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;
				Spawn(HitEffectClass,,, HitLocation, rotator(HitLocation - StartTrace));				
			}
			
		}
		// recall hit in horizontal directions with shift
		IsSoundPlayed = false;
		for(dalpha=5;dalpha<=32728;dalpha+=180)
		{
			tempalpha=PointRot.Yaw+dalpha;
			if(tempalpha>65535) // if angle more then 360
				AdditionalHit(tempalpha-65535);
			else
				AdditionalHit(tempalpha);
			AdditionalHit(PointRot.Yaw+dalpha);
			tempalpha=PointRot.Yaw-dalpha;
			if(tempalpha<0) // if angle negative
				AdditionalHit(65535+tempalpha);
			else
				AdditionalHit(tempalpha);
		}			
		clearHitted();
	}
}

function AdditionalHit(int dYaw)
{
	local Actor HitActor;
	local vector StartTrace, EndTrace, HitLocation, HitNormal;
	local rotator PointRot;
	local int MyDamage;

	MyDamage = (MeleeDamage + Rand(MeleeDamage))/2;

	If( !KFWeapon(Weapon).bNoHit )
	{
		MyDamage = (MeleeDamage + Rand(MeleeDamage))/2;		
		StartTrace = Instigator.Location + Instigator.EyePosition();

		if( Instigator.Controller!=None && PlayerController(Instigator.Controller)==None && Instigator.Controller.Enemy!=None )
		{
        	PointRot = rotator(Instigator.Controller.Enemy.Location-StartTrace); // Give aimbot for bots.
			PointRot.Yaw=dYaw;
        }
		else
        {
            PointRot = Instigator.GetViewRotation();
			PointRot.Yaw=dYaw;
        }

		EndTrace = StartTrace + vector(PointRot)*weaponRange;
		HitActor = Instigator.Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);
		
		if (HitActor!=None)
		{
			if (IsHitted(HitActor)) // prevent multiple hits
			{
				return;
			}
			else 		
			{				
				HitActors[HitActors.Length] = HitActor;
			}
			
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
			if( Level.NetMode==NM_Client )
            {
                Return;
            }

			if( HitActor.IsA('Pawn') && !HitActor.IsA('Vehicle')
			 && (Normal(HitActor.Location-Instigator.Location) dot vector(HitActor.Rotation))<0 )
			{
				MyDamage*=2; // Backstab >:P
			}

			if( (KFMonster(HitActor)!=none) )
			{
			
                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;

				/*if(!IsSoundPlayed)
				{
					Weapon.PlaySound(MeleeHitSounds[0],SLOT_None,MeleeHitVolume,,,,false);
					IsSoundPlayed = true;
				}*/
				
            	if(VSize(Instigator.Velocity) > 300 && KFMonster(HitActor).Mass <= Instigator.Mass)
				{
				    KFMonster(HitActor).FlipOver();
				}

			}
			else
			{
				HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;
				Spawn(HitEffectClass,,, HitLocation, rotator(HitLocation - StartTrace));
			}
		}
	}
}


//detect if actor be hitted
function bool IsHitted(Actor Hitted)
{
	local int j;

    for( j=0; j<HitActors.Length; j++ )
        if( HitActors[j]==Hitted )
            return true;
    return false;
}

function clearHitted()
{
	while( HitActors.Length>0 )
    {
		HitActors.Remove(0,1);
	}
}

defaultproperties
{
     weaponRange=130.000000
}
