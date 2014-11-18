// subclassing ROBallisticProjectile so we can do the ambient volume scaling
class RTLAWProj extends LAWProj;

/* HurtRadius()
 Hurt locally authoritative actors within the radius.
*/
simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dirs;
	local int NumKilled;
	local KFMonster KFMonsterVictim;
	local Pawn P;
	local KFPawn KFP;
	local array<Pawn> CheckedPawns;
	local int i;
	local bool bAlreadyChecked;

	if ( bHurtEntry )
		return;

	bHurtEntry = true;

	foreach CollidingActors (class 'Actor', Victims, DamageRadius, HitLocation)
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo')
		 && ExtendedZCollision(Victims)==None )
		{
			dirs = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dirs));
			dirs = dirs/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			if ( Victims == LastTouched )
				LastTouched = None;

			P = Pawn(Victims);

			if( P != none )
			{
		        for (i = 0; i < CheckedPawns.Length; i++)
				{
		        	if (CheckedPawns[i] == P)
					{
						bAlreadyChecked = true;
						break;
					}
				}

				if( bAlreadyChecked )
				{
					bAlreadyChecked = false;
					P = none;
					continue;
				}

				KFMonsterVictim = KFMonster(Victims);

				if( KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
				{
					KFMonsterVictim = none;
				}

				KFP = KFPawn(Victims);

				if( KFMonsterVictim != none )
				{
					damageScale *= KFMonsterVictim.GetExposureTo(HitLocation/*Location + 15 * -Normal(PhysicsVolume.Gravity)*/);
				}
				else if( KFP != none )
				{
				    damageScale *= KFP.GetExposureTo(HitLocation/*Location + 15 * -Normal(PhysicsVolume.Gravity)*/);
				}

				CheckedPawns[CheckedPawns.Length] = P;

				if ( damageScale <= 0)
				{
					P = none;
					continue;
				}
				else
				{
					//Victims = P;
					P = none;
				}
			}


			Victims.TakeDamage
			(
				damageScale * DamageAmount,
				RTurretAI(Instigator.Controller).Turret.OwnerPawn,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dirs,
				(damageScale * Momentum * dirs),
				DamageType
			);
			
			KFSteamStatsAndAchievements(PlayerController(RTurretAI(Instigator.Controller).Turret.OwnerPawn.Controller).SteamStatsAndAchievements).AddExplosivesDamage(damageScale * DamageAmount);

			if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

			if( Role == ROLE_Authority && KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
			{
				NumKilled++;
			}
		}
	}
	if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
	{
		Victims = LastTouched;
		LastTouched = None;
		dirs = Victims.Location - HitLocation;
		dist = FMax(1,VSize(dirs));
		dirs = dirs/dist;
		damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
		if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);
		Victims.TakeDamage
		(
			damageScale * DamageAmount,
			RTurretAI(Instigator.Controller).Turret.OwnerPawn,
			Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dirs,
			(damageScale * Momentum * dirs),
			DamageType
		);
		KFSteamStatsAndAchievements(PlayerController(RTurretAI(Instigator.Controller).Turret.OwnerPawn.Controller).SteamStatsAndAchievements).AddExplosivesDamage(damageScale * DamageAmount);
		if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
			Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
	}

	if( Role == ROLE_Authority )
	{
		if( NumKilled >= 4 )
		{
			KFGameType(Level.Game).DramaticEvent(0.05);
		}
		else if( NumKilled >= 2 )
		{
			KFGameType(Level.Game).DramaticEvent(0.03);
		}
	}

	bHurtEntry = false;
}

simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
	// Don't let it hit this player, or blow up on another player
	if ( Other == none || Other == Instigator || Other.Base == Instigator )
		return;

    // Don't collide with bullet whip attachments
    if( KFBulletWhipAttachment(Other) != none )
    {
        return;
    }

    // Don't allow hits on poeple on the same team
    if( KFHumanPawn(Other) != none && Instigator != none
        && KFHumanPawn(Other).PlayerReplicationInfo.Team.TeamIndex == Instigator.PlayerReplicationInfo.Team.TeamIndex )
    {
        return;
    }

	// Use the instigator's location if it exists. This fixes issues with
	// the original location of the projectile being really far away from
	// the real Origloc due to it taking a couple of milliseconds to
	// replicate the location to the client and the first replicated location has
	// already moved quite a bit.
	if( Instigator != none )
	{
		OrigLoc = Instigator.Location;
	}

	if( !bDud && ((VSizeSquared(Location - OrigLoc) < ArmDistSquared) || OrigLoc == vect(0,0,0)) )
	{
		if( Role == ROLE_Authority )
		{
			AmbientSound=none;
			PlaySound(Sound'ProjectileSounds.PTRD_deflect04',,2.0);
			Other.TakeDamage( ImpactDamage, RTurretAI(Instigator.Controller).Turret.OwnerPawn, HitLocation, Normal(Velocity), ImpactDamageType );
			
		}

		bDud = true;
		Velocity = vect(0,0,0);
		LifeSpan=1.0;
		SetPhysics(PHYS_Falling);
	}

	if( !bDud )
	{
	   Explode(HitLocation,Normal(HitLocation-Other.Location));
	}
}

defaultproperties
{
     /*ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetTime=0.00000
     RotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     RotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     RotTime=0.000000
     OffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     OffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
     OffsetTime=0.00000*/
	 //damage options
     ImpactDamage=100 //damage from unexploding rocket
     Damage=450.000000 //damage from rocket exploding
     DamageRadius=150.000000 // radius of exloding damage	 
	 ArmDistSquared=100 // close distande there rocket can't explode
	 Speed=2600.000000 // start speed
     MaxSpeed=3000.000000 // max speed
}
