//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ZombieBoss_XMas2 extends ZombieBoss;

#exec OBJ LOAD FILE=KF_EnemiesFinalSnd_Xmas.uax

simulated function CloakBoss()
{
	local Controller C;
	local int Index;

	if ( bSpotted )
	{
		Visibility = 120;

		if ( Level.NetMode==NM_DedicatedServer )
		{
			Return;
		}

		Skins[0] = Finalblend'KFX.StalkerGlow';
		Skins[1] = Finalblend'KFX.StalkerGlow';
		bUnlit = true;

		return;
	}

	Visibility = 1;
	bCloaked = true;

	if ( Level.NetMode!=NM_Client )
	{
		for ( C=Level.ControllerList; C!=None; C=C.NextController )
		{
			if ( C.bIsPlayer && C.Enemy==Self )
			{
				C.Enemy = None; // Make bots lose sight with me.
			}
		}
	}

	if( Level.NetMode==NM_DedicatedServer )
	{
		Return;
	}

	Skins[1] = Shader'KF_Specimens_Trip_T.patriarch_invisible_gun';
	Skins[0] = Shader'KF_Specimens_Trip_XMAS_T.patriarch_Santa.patriarch_santa_invisible_shdr';

	// Invisible - no shadow
	if(PlayerShadow != none)
	{
		PlayerShadow.bShadowActive = false;
	}

	// Remove/disallow projectors on invisible people
	Projectors.Remove(0, Projectors.Length);
	bAcceptsProjectors = false;
	SetOverlayMaterial(FinalBlend'KF_Specimens_Trip_T.patriarch_fizzle_FB', 1.0, true);

	// Randomly send out a message about Patriarch going invisible(10% chance)
	if ( FRand() < 0.10 )
	{
		// Pick a random Player to say the message
		Index = Rand(Level.Game.NumPlayers);

		for ( C = Level.ControllerList; C != none; C = C.NextController )
		{
			if ( PlayerController(C) != none )
			{
				if ( Index == 0 )
				{
					PlayerController(C).Speech('AUTO', 8, "");
					break;
				}

				Index--;
			}
		}
	}
}

// Speech notifies called from the anims
function PatriarchKnockDown()
{
	PlaySound(SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_KnockedDown', SLOT_Misc, 2.0,true,500.0);
}

function PatriarchEntrance()
{
	PlaySound(SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_Entrance', SLOT_Misc, 2.0,true,500.0);
}

function PatriarchVictory()
{
	PlaySound(SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_Victory', SLOT_Misc, 2.0,true,500.0);
}

function PatriarchMGPreFire()
{
	PlaySound(SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_WarnGun', SLOT_Misc, 2.0,true,1000.0);
}

function PatriarchMisslePreFire()
{
	PlaySound(SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_WarnRocket', SLOT_Misc, 2.0,true,1000.0);
}

state KnockDown // Knocked
{
	function bool ShouldChargeFromDamage()
	{
		return false;
	}

Begin:
	if ( Health > 0 )
	{
		Sleep(GetAnimDuration('KnockDown'));
		CloakBoss();
		PlaySound(sound'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_SaveMe', SLOT_Misc, 2.0,,500.0);

		if ( KFGameType(Level.Game).FinalSquadNum == SyringeCount )
		{
		   KFGameType(Level.Game).AddBossBuddySquad();
		}

		GotoState('Escaping');
	}
	else
	{
	   GotoState('');
	}
}

defaultproperties
{
     RocketFireSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_FireRocket'
     MiniGunFireSound=Sound'KF_BasePatriarch_xmas.Attack.Kev_MG_GunfireLoop'
     MiniGunSpinSound=Sound'KF_BasePatriarch_xmas.Attack.Kev_MG_TurbineFireLoop'
     MeleeImpaleHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_HitPlayer_Impale'
     MoanVoice=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_Talk'
     MeleeAttackHitSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_HitPlayer_Fist'
     JumpSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_Jump'
     DetachedArmClass=Class'BMTCustomMut.SeveredArmPatriarch_XMas'
     DetachedLegClass=Class'BMTCustomMut.SeveredLegPatriarch_XMas'
     DetachedHeadClass=Class'BMTCustomMut.SeveredHeadPatriarch_XMas'
     HitSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_Pain'
     DeathSound(0)=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_Death'
     MenuName="Christmas Patriarch"
     AmbientSound=SoundGroup'KF_EnemiesFinalSnd_Xmas.Patriarch.Kev_IdleLoop'
     Mesh=SkeletalMesh'KF_Freaks_Trip_Xmas.SantaClause_Patriarch'
     Skins(0)=Combiner'KF_Specimens_Trip_XMAS_T.patriarch_Santa.patriarch_Santa_cmb'
     Skins(1)=Combiner'KF_Specimens_Trip_XMAS_T.gatling_cmb'
}
