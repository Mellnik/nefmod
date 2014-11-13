class AmmoMessage extends LocalMessage;

var localized string Message[4];

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject )
{
	
	return Default.Message[Switch];
}

defaultproperties
{
     Message(0)="Can't deploy ammo crate here"
     Message(1)="Ammunition crate deployed"
     Message(2)="Ammunition crate destroyed"
     Message(3)="Press '%Use%' to use this ammo crate"
     bIsUnique=True
     bFadeMessage=True
     Lifetime=4
     DrawColor=(B=170)
     StackMode=SM_Down
     PosY=0.800000
}
