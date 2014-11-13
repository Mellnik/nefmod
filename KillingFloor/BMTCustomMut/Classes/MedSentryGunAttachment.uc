//================================================================================
// MedSentryGunAttachment.
//================================================================================

class MedSentryGunAttachment extends PipeBombAttachment;

simulated function PostBeginPlay ()
{
  Super.PostBeginPlay();
  TweenAnim('Folded',0.01);
}

defaultproperties
{
}
