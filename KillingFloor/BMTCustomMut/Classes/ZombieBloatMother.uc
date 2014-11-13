//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieBloatMother extends ZombieBloat;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd.uax

var() int MaxBABIES;

simulated function PostNetBeginPlay()
{
    super.PostNetBeginPlay();
    SetHeadScale(0.7);
    SetBoneScale(2,1.75,'rarm'); //let's put some big beefy arms on there...
    SetBoneScale(3,1.75,'larm');
}

function PlayDyingSound()
{
    if ( Level.NetMode!=NM_Client )
    {
        if ( bGibbed )
        {
            PlaySound(sound'KF_EnemiesFinalSnd.Bloat_DeathPop', SLOT_Pain,2.0,true,525);
            return;
        }

        if ( bDecapitated )
        {
            PlaySound(HeadlessDeathSound, SLOT_Pain,1.30,true,525);
        }
        else
        {
            PlaySound(sound'KF_EnemiesFinalSnd.Bloat_DeathPop', SLOT_Pain,2.0,true,525);
        }
    }
}
function bool TooManyBABIES()
{
    local Controller C;
    local int i;

    For( C=Level.ControllerList; C!=None; C=C.NextController )
    {
        if( C.Pawn!=None && C.Pawn.Class==Class'ZombieBabyFleshPound' )
        {
            i++;
            if( i>MaxBABIES )
                Return True;
        }
    }
    Return False;
}

simulated function Tick(float deltatime)
{
    local vector BileExplosionLoc;
    local FleshHitEmitter GibBileExplosion;

    Super.tick(deltatime);

    // Prevent targetting specimens
    // (Would this be better accomplished in the controller class?)
    if (Controller != none)
    {
        if (KFMonster(Controller.Enemy) != none)
            Controller.Enemy = none;
        if (KFMonster(Controller.Target) != none)
            Controller.Target = none;
    }

    Super.Tick(deltatime);

    if( Role == ROLE_Authority && bMovingPukeAttack )
    {
		// Keep moving toward the target until the timer runs out (anim finishes)
        if( RunAttackTimeout > 0 )
		{
            RunAttackTimeout -= DeltaTime;

            if( RunAttackTimeout <= 0 )
            {
                RunAttackTimeout = 0;
                bMovingPukeAttack=false;
            }
		}

        // Keep the gorefast moving toward its target when attacking
    	if( bShotAnim && !bWaitForAnim )
    	{
    		if( LookTarget!=None )
    		{
    		    Acceleration = AccelRate * Normal(LookTarget.Location - Location);
    		}
        }
    }

    // Hack to force animation updates on the server for the bloat if he is relevant to someone
    // He has glitches when some of his animations don't play on the server. If we
    // find some other fix for the glitches take this out - Ramm
    if( Level.NetMode != NM_Client && Level.NetMode != NM_Standalone )
    {
        if( (Level.TimeSeconds-LastSeenOrRelevantTime) < 1.0  )
        {
            bForceSkelUpdate=true;
        }
        else
        {
            bForceSkelUpdate=false;
        }
    }

    if ( Level.NetMode!=NM_DedicatedServer && /*Gored>0*/Health <= 0 && !bPlayBileSplash &&
        HitDamageType != class'DamTypeBleedOut' )
    {
        if ( !class'GameInfo'.static.UseLowGore() )
        {
			BileExplosionLoc = self.Location;
	        BileExplosionLoc.z += (CollisionHeight - (CollisionHeight * 0.5));

	        GibBileExplosion = Spawn(class 'BileExplosion',self,, BileExplosionLoc );
	        bPlayBileSplash = true;
	    }
	    else
	    {
			BileExplosionLoc = self.Location;
	        BileExplosionLoc.z += (CollisionHeight - (CollisionHeight * 0.5));

	        GibBileExplosion = Spawn(class 'LowGoreBileExplosion',self,, BileExplosionLoc );
	        bPlayBileSplash = true;
		}
    }
}


function SpawnTwoShots()
{
    local vector X,Y,Z, FireStart;
    local rotator FireRotation;
    local KFXmasBloatVomit VOM;

    if( Controller!=None && KFDoorMover(Controller.Target)!=None )
    {
        Controller.Target.TakeDamage(22,Self,Location,vect(0,0,0),Class'DamTypeVomit');//ignorehere
        return;
    }

    GetAxes(Rotation,X,Y,Z);
    FireStart = Location+(vect(30,0,64) >> Rotation)*DrawScale;
    if ( !SavedFireProperties.bInitialized )
    {
        SavedFireProperties.AmmoClass = Class'SkaarjAmmo';
        SavedFireProperties.ProjectileClass = Class'KFBloatVomit';//nvm here
        SavedFireProperties.WarnTargetPct = 1;
        SavedFireProperties.MaxRange = 500;
        SavedFireProperties.bTossed = False;
        SavedFireProperties.bTrySplash = False;
        SavedFireProperties.bLeadTarget = True;
        SavedFireProperties.bInstantHit = True;
        SavedFireProperties.bInitialized = True;
    }

    // Turn off extra collision before spawning vomit, otherwise spawn fails
    ToggleAuxCollision(false);
    FireRotation = Controller.AdjustAim(SavedFireProperties,FireStart,600);
    Spawn(Class'KFXmasBloatVomit',,,FireStart,FireRotation);//leave

    FireStart-=(0.5*CollisionRadius*Y);
    FireRotation.Yaw -= 1200;
    //log("SPAWNING TEH BABY FLESHIES");
    VOM=spawn(Class'KFXmasBloatVomit',,,FireStart, FireRotation);
    if(!TooManyBABIES())
    {
        VOM.TA=True;
    }
    else
    {
        VOM.TA=false;
    }
    
    FireStart+=(CollisionRadius*Y);
    FireRotation.Yaw += 2400;
    spawn(Class'KFXmasBloatVomit',,,FireStart, FireRotation);//leave
    // Turn extra collision back on
    ToggleAuxCollision(true);
}

defaultproperties
{
     MaxBABIES=3
     MeleeDamage=20
     ColRadius=18.000000
     PlayerCountHealthScale=0.150000
     OnlineHeadshotScale=1.300000
     HeadHealth=1312.000000
     ScoringValue=60
     MeleeRange=96.250000
     Health=2000
     MenuName="Mother Bloat"
}
