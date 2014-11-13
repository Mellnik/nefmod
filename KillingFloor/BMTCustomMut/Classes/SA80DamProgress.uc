//Weapon progress class
class SA80DamProgress extends WDamProgress;

//requirements to level
simulated function CheckWLevel()
{
	//amount of damage for weapon levels
	
	if(CurrentValue>10000000)
		RepLink.SA80Level=100;
	else if(CurrentValue>9900000)
		RepLink.SA80Level=99;
	else if(CurrentValue>9800000)
		RepLink.SA80Level=98;
	else if(CurrentValue>9700000)
		RepLink.SA80Level=97;
	else if(CurrentValue>9600000)
		RepLink.SA80Level=96;
	else if(CurrentValue>9500000)
		RepLink.SA80Level=95;
	else if(CurrentValue>9400000)
		RepLink.SA80Level=94;
	else if(CurrentValue>9300000)
		RepLink.SA80Level=93;
	else if(CurrentValue>9200000)
		RepLink.SA80Level=92;
	else if(CurrentValue>9100000)
		RepLink.SA80Level=91;
	else if(CurrentValue>9000000)
		RepLink.SA80Level=90;
	else if(CurrentValue>8900000)
		RepLink.SA80Level=89;
	else if(CurrentValue>8800000)
		RepLink.SA80Level=88;
	else if(CurrentValue>8700000)
		RepLink.SA80Level=87;
	else if(CurrentValue>8600000)
		RepLink.SA80Level=86;
	else if(CurrentValue>8500000)
		RepLink.SA80Level=85;
	else if(CurrentValue>8400000)
		RepLink.SA80Level=84;
	else if(CurrentValue>8300000)
		RepLink.SA80Level=83;
	else if(CurrentValue>8200000)
		RepLink.SA80Level=82;
	else if(CurrentValue>8100000)
		RepLink.SA80Level=81;
	else if(CurrentValue>8000000)
		RepLink.SA80Level=80;
	else if(CurrentValue>7900000)
		RepLink.SA80Level=79;
	else if(CurrentValue>7800000)
		RepLink.SA80Level=78;
	else if(CurrentValue>7700000)
		RepLink.SA80Level=77;
	else if(CurrentValue>7600000)
		RepLink.SA80Level=76;
	else if(CurrentValue>7500000)
		RepLink.SA80Level=75;
	else if(CurrentValue>7400000)
		RepLink.SA80Level=74;
	else if(CurrentValue>7300000)
		RepLink.SA80Level=73;
	else if(CurrentValue>7200000)
		RepLink.SA80Level=72;
	else if(CurrentValue>7100000)
		RepLink.SA80Level=71;
	else if(CurrentValue>7000000)
		RepLink.SA80Level=70;
	else if(CurrentValue>6900000)
		RepLink.SA80Level=69;
	else if(CurrentValue>6800000)
		RepLink.SA80Level=68;
	else if(CurrentValue>6700000)
		RepLink.SA80Level=67;
	else if(CurrentValue>6600000)
		RepLink.SA80Level=66;
	else if(CurrentValue>6500000)
		RepLink.SA80Level=65;
	else if(CurrentValue>6400000)
		RepLink.SA80Level=64;
	else if(CurrentValue>6300000)
		RepLink.SA80Level=63;
	else if(CurrentValue>6200000)
		RepLink.SA80Level=62;
	else if(CurrentValue>6100000)
		RepLink.SA80Level=61;
	else if(CurrentValue>6000000)
		RepLink.SA80Level=60;
	else if(CurrentValue>5900000)
		RepLink.SA80Level=59;
	else if(CurrentValue>5800000)
		RepLink.SA80Level=58;
	else if(CurrentValue>5700000)
		RepLink.SA80Level=57;
	else if(CurrentValue>5600000)
		RepLink.SA80Level=56;
	else if(CurrentValue>5500000)
		RepLink.SA80Level=55;
	else if(CurrentValue>5400000)
		RepLink.SA80Level=54;
	else if(CurrentValue>5300000)
		RepLink.SA80Level=53;
	else if(CurrentValue>5200000)
		RepLink.SA80Level=52;
	else if(CurrentValue>5100000)
		RepLink.SA80Level=51;
	else if(CurrentValue>5000000)
		RepLink.SA80Level=50;
	else if(CurrentValue>4900000)
		RepLink.SA80Level=49;
	else if(CurrentValue>4800000)
		RepLink.SA80Level=48;
	else if(CurrentValue>4700000)
		RepLink.SA80Level=47;
	else if(CurrentValue>4600000)
		RepLink.SA80Level=46;
	else if(CurrentValue>4500000)
		RepLink.SA80Level=45;
	else if(CurrentValue>4400000)
		RepLink.SA80Level=44;
	else if(CurrentValue>4300000)
		RepLink.SA80Level=43;
	else if(CurrentValue>4200000)
		RepLink.SA80Level=42;
	else if(CurrentValue>4100000)
		RepLink.SA80Level=41;
	else if(CurrentValue>4000000)
		RepLink.SA80Level=40;
	else if(CurrentValue>3900000)
		RepLink.SA80Level=39;
	else if(CurrentValue>3800000)
		RepLink.SA80Level=38;
	else if(CurrentValue>3700000)
		RepLink.SA80Level=37;
	else if(CurrentValue>3600000)
		RepLink.SA80Level=36;
	else if(CurrentValue>3500000)
		RepLink.SA80Level=35;
	else if(CurrentValue>3400000)
		RepLink.SA80Level=34;
	else if(CurrentValue>3300000)
		RepLink.SA80Level=33;
	else if(CurrentValue>3200000)
		RepLink.SA80Level=32;
	else if(CurrentValue>3100000)
		RepLink.SA80Level=31;
	else if(CurrentValue>3000000)
		RepLink.SA80Level=30;
	else if(CurrentValue>2900000)
		RepLink.SA80Level=29;
	else if(CurrentValue>2800000)
		RepLink.SA80Level=28;
	else if(CurrentValue>2700000)
		RepLink.SA80Level=27;
	else if(CurrentValue>2600000)
		RepLink.SA80Level=26;
	else if(CurrentValue>2500000)
		RepLink.SA80Level=25;
	else if(CurrentValue>2400000)
		RepLink.SA80Level=24;
	else if(CurrentValue>2300000)
		RepLink.SA80Level=23;
	else if(CurrentValue>2200000)
		RepLink.SA80Level=22;
	else if(CurrentValue>2100000)
		RepLink.SA80Level=21;
	else if(CurrentValue>2000000)
		RepLink.SA80Level=20;
	else if(CurrentValue>1900000)
		RepLink.SA80Level=19;
	else if(CurrentValue>1800000)
		RepLink.SA80Level=18;
	else if(CurrentValue>1700000)
		RepLink.SA80Level=17;
	else if(CurrentValue>1600000)
		RepLink.SA80Level=16;
	else if(CurrentValue>1500000)
		RepLink.SA80Level=15;
	else if(CurrentValue>1400000)
		RepLink.SA80Level=14;
	else if(CurrentValue>1300000)
		RepLink.SA80Level=13;
	else if(CurrentValue>1200000)
		RepLink.SA80Level=12;
	else if(CurrentValue>1100000)
		RepLink.SA80Level=11;
	else if(CurrentValue>1000000)
		RepLink.SA80Level=10;
	else if(CurrentValue>900000)
		RepLink.SA80Level=9;
	else if(CurrentValue>800000)
		RepLink.SA80Level=8;
	else if(CurrentValue>700000)
		RepLink.SA80Level=7;
	else if(CurrentValue>600000)
		RepLink.SA80Level=6;
	else if(CurrentValue>500000)
		RepLink.SA80Level=5;		
	else if(CurrentValue>400000)
		RepLink.SA80Level=4;	
	else if(CurrentValue>300000)
		RepLink.SA80Level=3;
	else if(CurrentValue>200000)
		RepLink.SA80Level=2;
	else if(CurrentValue>100000)
		RepLink.SA80Level=1;
	else
		RepLink.SA80Level=0;
}

//Hud display info
simulated function string GetWProgress()
{
	local string s;
	
	s=string(CurrentValue);
	
	if(CurrentValue>10000000)
		s="MaxLevel";
	else if(CurrentValue>9800000)
		s$="/9900000";
	else if(CurrentValue>9700000)
		s$="/9800000";
	else if(CurrentValue>9600000)
		s$="/9700000";
	else if(CurrentValue>9500000)
		s$="/9600000";
	else if(CurrentValue>9400000)
		s$="/9500000";
	else if(CurrentValue>9300000)
		s$="/9400000";
	else if(CurrentValue>9200000)
		s$="/9300000";
	else if(CurrentValue>9100000)
		s$="/9200000";
	else if(CurrentValue>9000000)
		s$="/9100000";
	else if(CurrentValue>8900000)
		s$="/9000000";
	else if(CurrentValue>8800000)
		s$="/8900000";
	else if(CurrentValue>8700000)
		s$="/8800000";
	else if(CurrentValue>8600000)
		s$="/8700000";
	else if(CurrentValue>8500000)
		s$="/8600000";
	else if(CurrentValue>8400000)
		s$="/8500000";
	else if(CurrentValue>8300000)
		s$="/8400000";
	else if(CurrentValue>8200000)
		s$="/8300000";
	else if(CurrentValue>8100000)
		s$="/8200000";
	else if(CurrentValue>8000000)
		s$="/8100000";
	else if(CurrentValue>7900000)
		s$="/8000000";
	else if(CurrentValue>7800000)
		s$="/7900000";
	else if(CurrentValue>7700000)
		s$="/7800000";
	else if(CurrentValue>7600000)
		s$="/7700000";
	else if(CurrentValue>7500000)
		s$="/7600000";
	else if(CurrentValue>7400000)
		s$="/7500000";
	else if(CurrentValue>7300000)
		s$="/7400000";
	else if(CurrentValue>7200000)
		s$="/7300000";
	else if(CurrentValue>7100000)
		s$="/7200000";
	else if(CurrentValue>7000000)
		s$="/7100000";
	else if(CurrentValue>6900000)
		s$="/7000000";
	else if(CurrentValue>6800000)
		s$="/6900000";
	else if(CurrentValue>6700000)
		s$="/6800000";
	else if(CurrentValue>6600000)
		s$="/6700000";
	else if(CurrentValue>6500000)
		s$="/6600000";
	else if(CurrentValue>6400000)
		s$="/6500000";
	else if(CurrentValue>6300000)
		s$="/6400000";
	else if(CurrentValue>6200000)
		s$="/6300000";
	else if(CurrentValue>6100000)
		s$="/6200000";
	else if(CurrentValue>6000000)
		s$="/6100000";
	else if(CurrentValue>5900000)
		s$="/6000000";
	else if(CurrentValue>5800000)
		s$="/5900000";
	else if(CurrentValue>5700000)
		s$="/5800000";
	else if(CurrentValue>5600000)
		s$="/5700000";
	else if(CurrentValue>5500000)
		s$="/5600000";
	else if(CurrentValue>5400000)
		s$="/5500000";
	else if(CurrentValue>5300000)
		s$="/5400000";
	else if(CurrentValue>5200000)
		s$="/5300000";
	else if(CurrentValue>5100000)
		s$="/5200000";
	else if(CurrentValue>5000000)
		s$="/5100000";
	else if(CurrentValue>4900000)
		s$="/5000000";
	else if(CurrentValue>4800000)
		s$="/4900000";
	else if(CurrentValue>4700000)
		s$="/4800000";
	else if(CurrentValue>4600000)
		s$="/4700000";
	else if(CurrentValue>4500000)
		s$="/4600000";
	else if(CurrentValue>4400000)
		s$="/4500000";
	else if(CurrentValue>4300000)
		s$="/4400000";
	else if(CurrentValue>4200000)
		s$="/4300000";
	else if(CurrentValue>4100000)
		s$="/4200000";
	else if(CurrentValue>4000000)
		s$="/4100000";
	else if(CurrentValue>3900000)
		s$="/4000000";
	else if(CurrentValue>3800000)
		s$="/3900000";
	else if(CurrentValue>3700000)
		s$="/3800000";
	else if(CurrentValue>3600000)
		s$="/3700000";
	else if(CurrentValue>3500000)
		s$="/3600000";
	else if(CurrentValue>3400000)
		s$="/3500000";
	else if(CurrentValue>3300000)
		s$="/3400000";
	else if(CurrentValue>3200000)
		s$="/3300000";
	else if(CurrentValue>3100000)
		s$="/3200000";
	else if(CurrentValue>3000000)
		s$="/3100000";
	else if(CurrentValue>2900000)
		s$="/3000000";
	else if(CurrentValue>2800000)
		s$="/2900000";
	else if(CurrentValue>2700000)
		s$="/2800000";
	else if(CurrentValue>2600000)
		s$="/2700000";
	else if(CurrentValue>2500000)
		s$="/2600000";
	else if(CurrentValue>2400000)
		s$="/2500000";
	else if(CurrentValue>2300000)
		s$="/2400000";
	else if(CurrentValue>2200000)
		s$="/2300000";
	else if(CurrentValue>2100000)
		s$="/2200000";
	else if(CurrentValue>2000000)
		s$="/2100000";
	else if(CurrentValue>1900000)
		s$="/2000000";
	else if(CurrentValue>1800000)
		s$="/1900000";
	else if(CurrentValue>1700000)
		s$="/1800000";
	else if(CurrentValue>1600000)
		s$="/1700000";
	else if(CurrentValue>1500000)
		s$="/1600000";
	else if(CurrentValue>1400000)
		s$="/1500000";
	else if(CurrentValue>1300000)
		s$="/1400000";
	else if(CurrentValue>1200000)
		s$="/1300000";
	else if(CurrentValue>1100000)
		s$="/1200000";
	else if(CurrentValue>1000000)
		s$="/1100000";
	else if(CurrentValue>900000)
		s$="/1000000";
	else if(CurrentValue>800000)
		s$="/900000";
	else if(CurrentValue>700000)
		s$="/800000";
	else if(CurrentValue>600000)
		s$="/700000";
	else if(CurrentValue>500000)
		s$="/600000";
	else if(CurrentValue>400000)
		s$="/500000";
	else if(CurrentValue>300000)
		s$="/400000";
	else if(CurrentValue>200000)
		s$="/300000";
	else if(CurrentValue>100000)
		s$="/200000";
	else
		s$="/100000";
	
	return s;
}


defaultproperties
{
     ProgressName="SA80 Weapon Damage"
}