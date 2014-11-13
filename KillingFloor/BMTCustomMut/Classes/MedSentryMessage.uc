//================================================================================
// MedSentryMessage.
//================================================================================

class MedSentryMessage extends LocalMessage;

var localized string Message[3];

static function string GetString (optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
  return Default.Message[Switch];
}

defaultproperties
{
     Message(0)="Can't deploy Healing Bot here!"
     Message(1)="Medic Healing Bot Activated!"
     Message(2)="Your Healing Bot has been killed!"
     bIsUnique=True
     bFadeMessage=True
     Lifetime=4
     DrawColor=(B=170,G=170,R=170)
     StackMode=SM_Down
     PosY=0.800000
}
