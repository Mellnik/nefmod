class UMP45Fire extends KFFire;

// Overwritten to switch damage types for the firebug
function DoTrace(Vector Start, Rotator Dir)
{
	local Vector X,Y,Z, End, HitLocation, HitNormal, ArcEnd;
	local Actor Other;
	local KFWeaponAttachment WeapAttach;
	local array<int> HitPoints;
	local KFPawn HitPawn;

	MaxRange();

	Weapon.GetViewAxes(X, Y, Z);

	DamageType = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.static.GetMAC10DamageType(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));

	if ( Weapon.WeaponCentered() )
	{
		ArcEnd = (Instigator.Location + Weapon.EffectOffset.X * X + 1.5 * Weapon.EffectOffset.Z * Z);
	}
	else
	{
		ArcEnd = (Instigator.Location + Instigator.CalcDrawOffset(Weapon) + Weapon.EffectOffset.X * X + Weapon.Hand * Weapon.EffectOffset.Y * Y +
		Weapon.EffectOffset.Z * Z);
	}

	X = Vector(Dir);
	End = Start + TraceRange * X;
	Other = Instigator.HitPointTrace(HitLocation, HitNormal, End, HitPoints, Start,, 1);

	if ( Other != None && Other != Instigator && Other.Base != Instigator )
	{
		WeapAttach = KFWeaponAttachment(Weapon.ThirdPersonActor);

		if ( !Other.bWorldGeometry )
		{
			// Update hit effect except for pawns
			if ( !Other.IsA('Pawn') && !Other.IsA('HitScanBlockingVolume') &&
			     !Other.IsA('ExtendedZCollision') )
			{
				if( WeapAttach!=None )
				{
			        WeapAttach.UpdateHit(Other, HitLocation, HitNormal);
			    }
			}

			HitPawn = KFPawn(Other);

			if ( HitPawn != none )
			{
				if ( !HitPawn.bDeleteMe )
				{
					HitPawn.ProcessLocationalDamage(DamageMax, Instigator, HitLocation, Momentum * X, DamageType, HitPoints);
				}
			}
			else
			{
				Other.TakeDamage(DamageMax, Instigator, HitLocation, Momentum * X, DamageType);
			}
		}
		else
		{
			HitLocation = HitLocation + 2.0 * HitNormal;

			if ( WeapAttach != None )
			{
				WeapAttach.UpdateHit(Other,HitLocation,HitNormal);
			}
		}
	}
	else
	{
		HitLocation = End;
		HitNormal = Normal(Start - End);
	}
}

defaultproperties
{
     FireAimedAnim="Fire"
     RecoilRate=0.070000
     maxVerticalRecoilAngle=700
     maxHorizontalRecoilAngle=350
     bRecoilRightOnly=True
     ShellEjectClass=Class'ROEffects.KFShellEjectMP5SMG'
     ShellEjectBoneName="Shell_eject"
     bAccuracyBonusForSemiAuto=True
     StereoFireSound=Sound'UMP45_Snd.ump45_shot_stereo'
     bRandomPitchFireSound=False
     DamageType=Class'BMTCustomMut.DamTypeUMP45'
     DamageMin=35
     DamageMax=50
     Momentum=8500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=3.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireSound=Sound'UMP45_Snd.ump45_shot_mono'
     NoAmmoSound=Sound'UMP45_Snd.ump45_empty'
     FireForce="AssaultRifleFire"
     FireRate=0.109000
     AmmoClass=Class'BMTCustomMut.UMP45Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stMP'
     aimerror=42.000000
     Spread=0.015000
     SpreadStyle=SS_Random
}
