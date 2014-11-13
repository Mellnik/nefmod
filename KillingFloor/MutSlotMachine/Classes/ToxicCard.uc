Class ToxicCard extends SlotCard;

static function float ExecuteCard( Pawn Target )
{
	Target.TakeDamage(30,None,Target.Location,vect(0,0,0),Class'DamTypeVomit');
	PlayerController(Target.Controller).ReceiveLocalizedMessage(Class'ToxicMessage');
	return 0;
}

defaultproperties
{
     CardMaterial=Texture'KillingFloorHUD.Achievements.Achievement_4'
}
