//=============================================================================
// Deagle Fire
//=============================================================================
class OutlawDeagleFire extends DeagleFire;

/*
function DoTrace(Vector Start, Rotator Dir)
{
	local Vector X,Y,Z, End, HitLocation, HitNormal, ArcEnd;
	local Actor Other,TraceStartA;
	local byte HitCount,HCounter;
	local float HitDamage;
	local Actor IgnoredHitActor;

	MaxRange();

	Weapon.GetViewAxes(X, Y, Z);
	if ( Weapon.WeaponCentered() )
	{
		ArcEnd = (Instigator.Location + Weapon.EffectOffset.X * X + 1.5 * Weapon.EffectOffset.Z * Z);
	}
	else
    {
        ArcEnd = (Instigator.Location + Instigator.CalcDrawOffset(Weapon) + Weapon.EffectOffset.X * X +
		 Weapon.Hand * Weapon.EffectOffset.Y * Y + Weapon.EffectOffset.Z * Z);
    }

	X = Vector(Dir);
	End = Start + TraceRange * X;
	TraceStartA = Weapon;
	HitDamage = DamageMax;
	While( (HitCount++)<10 )
	{
		Other = TraceStartA.Trace(HitLocation, HitNormal, End, Start, true);
		if( Other==None )
		{
			Break;
		}
		else if( Other==Instigator || Other==IgnoredHitActor )
		{
			TraceStartA = Other;
			Start = HitLocation;
			Continue;
		}

		if( ExtendedZCollision(Other)!=None && Other.Owner!=None )
		{
			if( Other.Owner==IgnoredHitActor )
			{
				Start = HitLocation;
				TraceStartA = Other;
				Continue;
			}
			IgnoredHitActor = Other.Owner;
		}

		if ( !Other.bWorldGeometry && Other!=Level )
		{
			if( KFMonster(Other)!=None )
			{
				IgnoredHitActor = Other;
			}
			Other.TakeDamage(int(HitDamage), Instigator, HitLocation, Momentum*X, DamageType);
			//Weapon.Spawn(class'KFHitEffect',,, HitLocation);
			if( (HCounter++)>=4 || Pawn(Other)==None )
			{
				Break;
			}
			HitDamage/=2;
			Start = HitLocation;
			TraceStartA = Other;
		}
		else if ( HitScanBlockingVolume(Other)==None )
		{
			if( KFWeaponAttachment(Weapon.ThirdPersonActor)!=None )
		      KFWeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other,HitLocation,HitNormal);
			Break;
		}
	}
}
*/

defaultproperties
{
     DamageType=Class'BMTCustomMut.DamTypeOutlawDeagle'
}
