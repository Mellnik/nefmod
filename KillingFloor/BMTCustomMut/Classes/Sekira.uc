class Sekira extends Axe;

#exec OBJ LOAD FILE=Sekira_T.utx
#exec OBJ LOAD FILE=KF_Weapons_Trip_T.utx

defaultproperties
{
     weaponRange=90.000000
     BloodyMaterial=Texture'Sekira_T.ebonybattleaxe'
     HudImage=Texture'Sekira_T.SekiraUnselected'
     SelectedHudImage=Texture'Sekira_T.SekiraSelected'
     Weight=8.000000
     TraderInfoTexture=Texture'Sekira_T.SekiraTraider'
     FireModeClass(0)=Class'BMTCustomMut.SekiraFire'
     FireModeClass(1)=Class'BMTCustomMut.SekiraFireB'
     Description="Melee weapon"
     Priority=244
     PickupClass=Class'BMTCustomMut.SekiraPickup'
     PlayerViewOffset=(X=-7.000000,Y=-2.000000,Z=3.000000)
     AttachmentClass=Class'BMTCustomMut.SekiraAttachment'
     ItemName="Sekira"
     Mesh=SkeletalMesh'Sekira_A.SekiraMesh'
     Skins(0)=Texture'Sekira_T.ebonybattleaxe'
     Skins(1)=Combiner'KF_Weapons_Trip_T.hands.hands_1stP_military_cmb'
}
