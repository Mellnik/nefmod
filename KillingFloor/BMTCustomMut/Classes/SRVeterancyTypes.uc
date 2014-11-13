// Written by .:..: (2009)
// Base class of all server veterancy types
class SRVeterancyTypes extends KFVeterancyTypes
	abstract;

var() localized string CustomLevelInfo;
var() localized array<string> SRLevelEffects; // Added in ver 5.00, dynamic array for level effects.
var() byte NumRequirements;
var() localized string DisableTag,DisableDescription; // Can be set as a reason to hide inventory from specific players.

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	//log("Recoil bonus"@Other@SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.Ak47Level);
	
	if(AK47Fire(Other)!=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.Ak47Level)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}	
	else if(P57LLIFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.P57Level)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
	else if(KrissMFireA(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.KrissLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(MP7MFireExt(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.WTFMP7Level)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(WTFFlamerFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.WTFFlamerLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(SA80Fire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.SA80Level)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(B94Fire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.B94Level)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(DeagleFireExt(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.DeagleLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(DualDeagleFireExt(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.DualDeagleLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(HK417Fire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.HK417Level)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(BullpupFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.BullpupLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(BizonFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.BizonLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(LilithKissFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.LilithKissLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(WColtFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.WColtLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(M41AFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.M41ALevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(M249Fire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.M249Level)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(Tech_ShockRifleFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.Tech_ShockRifleLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}
		else if(StingerFire(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.StingerLevel)
		{
			case 0: Recoil=1.0; break;
			case 1: Recoil=0.99; break;
			case 2: Recoil=0.99; break;
			case 3: Recoil=0.99; break;
			case 4: Recoil=0.98; break;
			case 5: Recoil=0.98; break;
			case 6: Recoil=0.98; break;
			case 7: Recoil=0.97; break;
			case 8: Recoil=0.97; break;
			case 9: Recoil=0.97; break;
			case 10: Recoil=0.96; break;
			case 11: Recoil=0.96; break;
			case 12: Recoil=0.96; break;
			case 13: Recoil=0.95; break;
			case 14: Recoil=0.95; break;
			case 15: Recoil=0.95; break;
			case 16: Recoil=0.94; break;
			case 17: Recoil=0.94; break;
			case 18: Recoil=0.94; break;
			case 19: Recoil=0.93; break;
			case 20: Recoil=0.93; break;
			case 21: Recoil=0.93; break;
			case 22: Recoil=0.92; break;
			case 23: Recoil=0.92; break;
			case 24: Recoil=0.92; break;
			case 25: Recoil=0.91; break;
			case 26: Recoil=0.91; break;
			case 27: Recoil=0.91; break;
			case 28: Recoil=0.90; break;
			case 29: Recoil=0.90; break;
			case 30: Recoil=0.90; break;
			case 31: Recoil=0.89; break;
			case 32: Recoil=0.89; break;
			case 33: Recoil=0.89; break;
			case 34: Recoil=0.88; break;
			case 35: Recoil=0.88; break;
			case 36: Recoil=0.88; break;
			case 37: Recoil=0.87; break;
			case 38: Recoil=0.87; break;
			case 39: Recoil=0.87; break;
			case 40: Recoil=0.86; break;
			case 41: Recoil=0.86; break;
			case 42: Recoil=0.86; break;
			case 43: Recoil=0.85; break;
			case 44: Recoil=0.85; break;
			case 45: Recoil=0.85; break;
			case 46: Recoil=0.84; break;
			case 47: Recoil=0.84; break;
			case 48: Recoil=0.84; break;
			case 49: Recoil=0.83; break;
			case 50: Recoil=0.83; break;
			case 51: Recoil=0.83; break;
			case 52: Recoil=0.82; break;
			case 53: Recoil=0.82; break;
			case 54: Recoil=0.82; break;
			case 55: Recoil=0.81; break;
			case 56: Recoil=0.81; break;
			case 57: Recoil=0.81; break;
			case 58: Recoil=0.80; break;
			case 59: Recoil=0.80; break;
			case 60: Recoil=0.80; break;
			case 61: Recoil=0.79; break;
			case 62: Recoil=0.79; break;
			case 63: Recoil=0.79; break;
			case 64: Recoil=0.78; break;
			case 65: Recoil=0.78; break;
			case 66: Recoil=0.78; break;
			case 67: Recoil=0.77; break;
			case 68: Recoil=0.77; break;
			case 69: Recoil=0.77; break;
			case 70: Recoil=0.76; break;
			case 71: Recoil=0.76; break;
			case 72: Recoil=0.76; break;
			case 73: Recoil=0.75; break;
			case 74: Recoil=0.75; break;
			case 75: Recoil=0.75; break;
			case 76: Recoil=0.74; break;
			case 77: Recoil=0.74; break;
			case 78: Recoil=0.74; break;
			case 79: Recoil=0.73; break;
			case 80: Recoil=0.73; break;
			case 81: Recoil=0.73; break;
			case 82: Recoil=0.72; break;
			case 83: Recoil=0.72; break;
			case 84: Recoil=0.72; break;
			case 85: Recoil=0.71; break;
			case 86: Recoil=0.71; break;
			case 87: Recoil=0.71; break;
			case 88: Recoil=0.70; break;
			case 89: Recoil=0.70; break;
			case 90: Recoil=0.70; break;
			case 91: Recoil=0.69; break;
			case 92: Recoil=0.69; break;
			case 93: Recoil=0.69; break;
			case 94: Recoil=0.68; break;
			case 95: Recoil=0.68; break;
			case 96: Recoil=0.68; break;
			case 97: Recoil=0.67; break;
			case 98: Recoil=0.67; break;
			case 99: Recoil=0.67; break;
			case 100: Recoil=0.66; break;
			default: Recoil=0.66; break;
		}
		return Recoil;
	}

	Recoil=1.0;
	return Recoil;
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{

	if(AK47AssaultRifle(Other)!=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.Ak47Level)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
	
	else if(P57LLI(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.P57Level)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
	else if(KrissMMedicGunA(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.KrissLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
	else if(MP7MMedicGunExt(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.WTFMP7Level)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(WTFFlamer(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.WTFFlamerLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(SA80(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.SA80Level)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(B94(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.B94Level)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(DeagleExt(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.DeagleLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(DualDeagleExt(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.DualDeagleLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(HK417(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.HK417Level)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(Bullpup(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.BullpupLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(Bizon(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.BizonLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(LilithKiss(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.LilithKissLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(WColt(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.WColtLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(M41AAssaultRifle(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.M41ALevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(M249(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.M249Level)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(Tech_ShockRifle(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.Tech_ShockRifleLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
		else if(Stinger(Other) !=None)
	{
		switch(SRStatsBase(KFPlayerController(KFPRI.Owner).SteamStatsAndAchievements).Rep.StingerLevel)
		{
			case 0: return 1.0;
			case 1: return 1.00;
			case 2: return 1.01;
			case 3: return 1.01;
			case 4: return 1.01;
			case 5: return 1.02;
			case 6: return 1.02;
			case 7: return 1.02;
			case 8: return 1.03;
			case 9: return 1.03;
			case 10: return 1.03;
			case 11: return 1.04;
			case 12: return 1.04;
			case 13: return 1.04;
			case 14: return 1.05;
			case 15: return 1.05;
			case 16: return 1.05;
			case 17: return 1.06;
			case 18: return 1.06;
			case 19: return 1.06;
			case 20: return 1.07;
			case 21: return 1.07;
			case 22: return 1.07;
			case 23: return 1.08;
			case 24: return 1.08;
			case 25: return 1.08;
			case 26: return 1.09;
			case 27: return 1.09;
			case 28: return 1.09;
			case 29: return 1.10;
			case 30: return 1.10;
			case 31: return 1.10;
			case 32: return 1.11;
			case 33: return 1.11;
			case 34: return 1.11;
			case 35: return 1.12;
			case 36: return 1.12;
			case 37: return 1.12;
			case 38: return 1.13;
			case 39: return 1.13;
			case 40: return 1.13;
			case 41: return 1.14;
			case 42: return 1.14;
			case 43: return 1.14;
			case 44: return 1.15;
			case 45: return 1.15;
			case 46: return 1.15;
			case 47: return 1.16;
			case 48: return 1.16;
			case 49: return 1.16;
			case 50: return 1.17;
			case 51: return 1.17;
			case 52: return 1.17;
			case 53: return 1.18;
			case 54: return 1.18;
			case 55: return 1.18;
			case 56: return 1.19;
			case 57: return 1.19;
			case 58: return 1.19;
			case 59: return 1.20;
			case 60: return 1.20;
			case 61: return 1.20;
			case 62: return 1.21;
			case 63: return 1.21;
			case 64: return 1.21;
			case 65: return 1.22;
			case 66: return 1.22;
			case 67: return 1.22;
			case 68: return 1.23;
			case 69: return 1.23;
			case 70: return 1.23;
			case 71: return 1.24;
			case 72: return 1.24;
			case 73: return 1.24;
			case 74: return 1.25;
			case 75: return 1.25;
			case 76: return 1.25;
			case 77: return 1.26;
			case 78: return 1.26;
			case 79: return 1.26;
			case 80: return 1.27;
			case 81: return 1.27;
			case 82: return 1.27;
			case 83: return 1.28;
			case 84: return 1.28;
			case 85: return 1.28;
			case 86: return 1.29;
			case 87: return 1.29;
			case 88: return 1.29;
			case 89: return 1.30;
			case 90: return 1.30;
			case 91: return 1.30;
			case 92: return 1.31;
			case 93: return 1.31;
			case 94: return 1.31;
			case 95: return 1.32;
			case 96: return 1.32;
			case 97: return 1.32;
			case 98: return 1.33;
			case 99: return 1.33;
			case 100: return 1.33;
			default: return 1.33;
		}
	}
	return 1.0;
}

static function string GetWeaponProgress( ClientPerkRepLink StatOther, Name Weapon )
{
	log("SRVet"@Weapon@StatOther);
	if(Weapon=='AK47AssaultRifle')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.Ak47DamProgress');
	else if(Weapon=='WTFKnife')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.KnifeDamProgress');
	else if(Weapon=='P57LLI')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.P57DamProgress');
	else if(Weapon=='KrissMMedicGunA')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.KrissDamProgress');
	else if(Weapon=='MP7MMedicGunExt')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.WTFMP7DamProgress');
	else if(Weapon=='WTFEquipKatana')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.WTFKatanaDamProgress');
	else if(Weapon=='WTFFlamer')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.WTFFlamerDamProgress');
	else if(Weapon=='SA80')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.SA80DamProgress');
	else if(Weapon=='B94')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.B94DamProgress');
	else if(Weapon=='DeagleExt')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.DeagleDamProgress');
	else if(Weapon=='DualDeagleExt')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.DualDeagleDamProgress');
	else if(Weapon=='HK417')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.HK417DamProgress');
	else if(Weapon=='Bullpup')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.BullpupDamProgress');
	else if(Weapon=='Bizon')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.BizonDamProgress');
	else if(Weapon=='LilithKiss')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.LilithKissDamProgress');
	else if(Weapon=='WColt')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.WColtDamProgress');
	else if(Weapon=='M41AAssaultRifle')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.M41ADamProgress');
	else if(Weapon=='M249')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.M249DamProgress');
	else if(Weapon=='litesaber')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.litesaberDamProgress');
	else if(Weapon=='Tech_ShockRifle')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.Tech_ShockRifleDamProgress');
	else if(Weapon=='Stinger')
		return StatOther.GetWeaponProgress(Class'BMTCustomMut.StingerDamProgress');
	else
		return "";
}

static function int GetHM(KFPlayerReplicationInfo KFPRI)
{
	return 0;
}

static function int GetSM(KFPlayerReplicationInfo KFPRI)
{
	return 0;
}

static function int GetAM(KFPlayerReplicationInfo KFPRI)
{
	return 0;
}

// Can be used to add in custom stats.
static function AddCustomStats( ClientPerkRepLink Other )
{
	//if you use custom perks that already have this function you should add line
	//super.AddCustomStats(Other);
	//in start of function
	Other.AddCustomValue(Class'BMTCustomMut.Ak47DamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.KnifeDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.P57DamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.KrissDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.WTFMP7DamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.WTFKatanaDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.WTFFlamerDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.SA80DamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.B94DamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.DeagleDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.DualDeagleDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.HK417DamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.BullpupDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.BizonDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.LilithKissDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.WColtDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.M41ADamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.M249DamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.litesaberDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.Tech_ShockRifleDamProgress');
	Other.AddCustomValue(Class'BMTCustomMut.StingerDamProgress');
}

// Return the level of perk that is available, 0 = perk is n/a.
static function byte PerkIsAvailable( ClientPerkRepLink StatOther )
{
	local byte i;

	// Check which level it fits in to.
	for( i=0; i<StatOther.MaximumLevel; i++ )
	{
		if( !LevelIsFinished(StatOther,i) )
			return Clamp(i,StatOther.MinimumLevel,StatOther.MaximumLevel);
	}
	return StatOther.MaximumLevel;
}

// Return the number of different requirements this level has.
static function byte GetRequirementCount( ClientPerkRepLink StatOther, byte CurLevel )
{
	if( CurLevel==StatOther.MaximumLevel )
		return 0;
	return default.NumRequirements;
}

// Return 0-1 % of how much of the progress is done to gain this perk (for menu GUI).
static function float GetTotalProgress( ClientPerkRepLink StatOther, byte CurLevel )
{
	local byte i,rc,Minimum;
	local int R,V,NegReq;
	local float RV;

	if( CurLevel==StatOther.MaximumLevel )
		return 1.f;
	if( StatOther.bMinimalRequirements )
	{
		Minimum = 0;
		CurLevel = Max(CurLevel-StatOther.MinimumLevel,0);
	}
	else Minimum = StatOther.MinimumLevel;

	rc = GetRequirementCount(StatOther,CurLevel);
	for( i=0; i<rc; i++ )
	{
		V = GetPerkProgressInt(StatOther,R,CurLevel,i);
		R*=StatOther.RequirementScaling;
		if( CurLevel>Minimum )
		{
			GetPerkProgressInt(StatOther,NegReq,(CurLevel-1),i);
			NegReq*=StatOther.RequirementScaling;
			R-=NegReq;
			V-=NegReq;
		}
		if( R<=0 ) // Avoid division by zero error.
			RV+=1.f;
		else RV+=FClamp(float(V)/(float(R)),0.f,1.f);
	}
	return RV/float(rc);
}

// Return true if this level is earned.
static function bool LevelIsFinished( ClientPerkRepLink StatOther, byte CurLevel )
{
	local byte i,rc;
	local int R,V;

	if( CurLevel==StatOther.MaximumLevel )
		return false;
	if( StatOther.bMinimalRequirements )
		CurLevel = Max(CurLevel-StatOther.MinimumLevel,0);
	rc = GetRequirementCount(StatOther,CurLevel);
	for( i=0; i<rc; i++ )
	{
		V = GetPerkProgressInt(StatOther,R,CurLevel,i);
		R*=StatOther.RequirementScaling;
		if( R>V )
			return false;
	}
	return true;
}

// Return 0-1 % of how much of the progress is done to gain this individual task (for menu GUI).
static function float GetPerkProgress( ClientPerkRepLink StatOther, byte CurLevel, byte ReqNum, out int Numerator, out int Denominator )
{
	local byte Minimum;
	local int Reduced,Cur,Fin;

	if( CurLevel==StatOther.MaximumLevel )
	{
		Denominator = 1;
		Numerator = 1;
		return 1.f;
	}
	if( StatOther.bMinimalRequirements )
	{
		Minimum = 0;
		CurLevel = Max(CurLevel-StatOther.MinimumLevel,0);
	}
	else Minimum = StatOther.MinimumLevel;
	Numerator = GetPerkProgressInt(StatOther,Denominator,CurLevel,ReqNum);
	Denominator*=StatOther.RequirementScaling;
	if( CurLevel>Minimum )
	{
		GetPerkProgressInt(StatOther,Reduced,CurLevel-1,ReqNum);
		Reduced*=StatOther.RequirementScaling;
		Cur = Max(Numerator-Reduced,0);
		Fin = Max(Denominator-Reduced,0);
	}
	else
	{
		Cur = Numerator;
		Fin = Denominator;
	}
	if( Fin<=0 ) // Avoid division by zero.
		return 1.f;
	return FMin(float(Cur)/float(Fin),1.f);
}

// Return int progress for this perk level up.
static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	FinalInt = 1;
	return 1;
}
static final function int GetDoubleScaling( byte CurLevel, int InValue )
{
	CurLevel-=6;
	return CurLevel*CurLevel*InValue;
}

// Get display info text for menu GUI
static function string GetVetInfoText( byte Level, byte Type, optional byte RequirementNum )
{
	switch( Type )
	{
	case 0:
		return Default.LevelNames[Min(Level,ArrayCount(Default.LevelNames))]; // This was left in the void of unused...
	case 1:
		if( Level>=Default.SRLevelEffects.Length )
			return GetCustomLevelInfo(Level);
		return Default.SRLevelEffects[Level];
	case 2:
		return Default.Requirements[RequirementNum];
	default:
		return Default.VeterancyName;
	}
}

static function string GetCustomLevelInfo( byte Level )
{
	return Default.CustomLevelInfo;
}
static final function string GetPercentStr( float InValue )
{
	return int(InValue*100.f)$"%";
}

// This function is called for every weapon with and every perk every time trader menu is shown.
// If returned false on any perk, weapon is hidden from the buyable list.
static function bool AllowWeaponInTrader( class<KFWeaponPickup> Pickup, KFPlayerReplicationInfo KFPRI, byte Level )
{
	return true;
}

static function byte PreDrawPerk( Canvas C, byte Level, out Material PerkIcon, out Material StarIcon )
{
	if ( Level>5 )
	{
		PerkIcon = Default.OnHUDGoldIcon;
		StarIcon = Class'HUDKillingFloor'.Default.VetStarGoldMaterial;
		Level = GetPerkColor(C.DrawColor,Level);
	}
	else
	{
		PerkIcon = Default.OnHUDIcon;
		StarIcon = Class'HUDKillingFloor'.Default.VetStarMaterial;
		C.SetDrawColor(255, 255, 255, C.DrawColor.A);
	}
	return Min(Level,15);
}

// Global perk colors.
static final function GetRGB( out color C, byte R, byte G, byte B )
{
	C.R = R;
	C.G = G;
	C.B = B;
}
static final function byte GetPerkColor( out color C, byte Level )
{
	if( Level>45 )
	{
		GetRGB(C,0, 250, 154);
		return (Level-45);
	}
	if( Level>40 )
	{
		GetRGB(C,240, 230, 140);
		return (Level-40);
	}
	if( Level>35 )
	{
		GetRGB(C,49, 79, 79);
		return (Level-35);
	}
	if( Level>30 )
	{
		GetRGB(C,148, 0, 211);
		return (Level-30);
	}
	if( Level>25 )
	{
		GetRGB(C,255, 20, 147);
		return (Level-25);
	}
	if( Level>20 )
	{
		GetRGB(C,255, 165, 0);
		return (Level-20);
	}
	if( Level>15 )
	{
		GetRGB(C,64,64,255);
		return (Level-15);
	}
	if( Level>10 )
	{
		GetRGB(C,0,255,0);
		return (Level-10);
	}
	GetRGB(C,255,255,255);
	return (Level-5);
}	

defaultproperties
{
	NumRequirements=1
	DisableTag="LOCKED"
	DisableDescription="Can't buy this weapon because the perk says no."
}