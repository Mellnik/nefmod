//-----------------------------------------------------------
//
//-----------------------------------------------------------
class litesaberAttachment  extends KatanaAttachment;

/*simulated function Timer()
{
	Super.Timer();
	if (Instigator != None && ClientState == WS_Hidden)
	{
		LightType = LT_None;
	}
	else
		LightType = LT_SubtlePulse;
}

simulated function DoFlashEmitter()
{
    if (mMuzFlash3rd == None)
    {
        mMuzFlash3rd = Spawn(mMuzFlashClass);
        AttachToBone(mMuzFlash3rd, 'katana');
    }
    if(mMuzFlash3rd != None)
        mMuzFlash3rd.SpawnParticle(1);
}*/

defaultproperties
{
     Mesh=SkeletalMesh'NetskyT3.LiteSaber_3rd'
     Skins(1)=Combiner'KF_Weapons2_Trip_T.Special.MP_7_cmb'
     Skins(2)=Shader'NetskyT3.LiteSaberSHD'
     bUnlit=True
}
