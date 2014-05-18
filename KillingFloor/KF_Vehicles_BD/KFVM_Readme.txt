========================================
KILLING FLOOR VEHICLE MOD - VERSION 1001
========================================

Saturday, the 9th of October 2010

The Killing Floor Vehicle Mod is an expansion game mode that enhances the standard Killing Floor game play elements by adding a range of quality made and highly realistic vehicles that act as both your weapon and mode of transport. As part of the Zed clean up crew you will have a sophisticated and fun set of features at your disposal to aid you in your ultimate goal of ridding humanity of the horde.

================
DEVELOPMENT TEAM
================

The Killing Floor Vehicle Mod is the idea of braindead.

braindead's primary role consists of:

- Coding
- Animations
- Modeling
- Texturing
- Public Relations

arramus provides support in the form of:

- Level Editing
- Texturing
- News and Articles
- Server Management

========
FEEDBACK
========
Please post feedback in the following locations:

Tripwire Interactive Forum - http://forums.tripwireinteractive.com/showthread.php?t=36237
Moddb - http://www.moddb.com/mods/killing-floor-vehicle-mod

========
FEATURES
========

Multiple vehicles with specific strengths and weaknesses relative to their build.
(An army lorry, police riot van, ambulance, helicopter, police car, forklift truck, mini, taxi cab, wheelchair, and camper van)

1st person and 3rd person display for inside and outside vehicle visuals.
(Zoom feature for passenger internal view for weapon accuracy)

A 'drag frag' system that rewards high speed collisions and penalises slow crawls.
(If you're driving fast enough you'll be awarded with an instant kill. If not, then the Zeds will either jump out of the way, destroy you and your vehicle, or die as you accelerate)

Fuel cans that can be purchased or possibly looted for refuelling and barbecuing.
(Fill up your vehicle with petrol or lay a trail on the ground and ignite it. If all else fails throw the fuel can on the floor and shoot it for total anihilation)

A mechanic's welding tool for on the spot repairs.
(Vehicles will take time to repair based on their health status. The welder shows the vehicles health as a percentage)

Highly responsive braking for rapid spinning turns.
(180 degree + high speed turns allow for a quick roadkill return in the opposite direction)

Vehicle share with passenger seating.
(Multiple passengers can join depending on the vehicle. Passengers will be armed and be able to shoot the incoming horde)

Land based and airbourne methods of transportation.
(Take to the air to support ground based vehicles)

Mounted user controlled vehicle weapons.
(Vehicles allow for armed passengers with a deadly array of weapons depending on vehicle and seat)

Vehicle damage and destruction relative to collisions and attacks.
(High impact collisions with other vehicles and props cause proportional vehicle damage. Zed attacks cause significant damage and being surrounded on a tight turn may result in sudden death)

Automatic or manual vehicle respawn features can be customised on a map per map basis.
(Random vehicle spawning allows each map to constantly provide different vehicles in different locations. Players will have no way of knowing what will be coming and where)

An abundance of custom and stock maps; both conversions and mod specific.
(High quality community made maps specific to the Vehicle Mod features and game mode)

Completely integrated with the Killing Floor SDK for community mapping.
(Mappers and modders will be able to adapt their creations simply through the Unreal Editor interface)

Destructible objects based on natural map features.
(Destructible fences, fueling pumps, tables, barrels, and anything else the mapper would like to add to a map. Zeds can manually destroy these objects should they be blocking their path)

A quality and bug free experience.
(The Killing Floor Vehicle Mod has been under construction for quite some time and at every step of the way Quality Control has been a major priority. Expect a very decent and stress free gaming experience without game breaking issues)

============
INSTALLATION
============

1. Unzip the KF_Vehicles_BD_Manual_1001 file and place folder content in the matching area of your Killing Floor installation, e.g. Animations to your Animations folder. The KF_Vehicles_BD folder contains source code and has its own separate folder.

2. Unzip the KFVM_Maps file. Place all the map files from within that folder into your Killing Floor Maps folder.

===========================
INSTRUCTIONS ON HOW TO PLAY
===========================

1. Join a dedicated server or launch your own game through Host/Solo (select the 'Killing Floor Vehicle Mod' through Mutators and set Max/Min number of vehicles to spawn).  

2. Spawn.

3. Look for a vehicle. Each map has 30 random spawn points and each spawn point can produce a different array of vehicles as set by the mapper. On some of the larger maps the first wave may require a little foot work. Destroyed vehicles will initiate a random respawn. This feature is currently being tweaked.

4. Enter a vehicle using your USE key.

5. For ground vehicles, use for FORWARD and BACK keys for Accelerate and Brake/Reverse. Use your LEFT and RIGHT keys for Steering. Moving your MOUSE will allow you to look around.

For the helicopter, use your JUMP and CROUCH for your Up and Down and your LEFT and RIGHT for Rolling Sideways. Use the MOUSE to Steer and look around.

The forklift steers from the rear and will require opposite LEFT and RIGHT controls.

6. Switch between outside view or inside view using the RIGHT MOUSE BUTTON for all vehicles.

7. Switch seats using number keys 1 ~ 5. Some seats control a weapon with a zoom feature and alternative inside and outside view.

8. As a helicopter pilot and front passenger, forklift operator, mini passenger, police car passengers, campervan passengers, and army lorry rear guard use your LEFT MOUSE BUTTON to Fire. Use your ALTERNATIVE FIRE BUTTON to use the Zoom function where applicable.

9. Use your JUMP BUTTON to activate your Break. In some vehicles this functions like a handbrake and will allow for some rapid 180 degree turns.

10. You may find a Fuel Can spawned around the map or can buy one from the Trader. All vehicles except the helicopter run out of fuel and require a top up from time to time. Simply select the Fuel Can from your inventory, stand beside your vehicle and hit the LEFT MOUSE BUTTON to begin Refueling.

11. The Fuel Can also acts as a weapon. Pour your fuel onto the ground and hit the ALTERNATIVE FIRE BUTTON to initiate striking a match and setting the fuel alight. This will roast the Zeds as well as you should you be in its vicinity.

12. If your vehicle is damaged select the default welder. Stand beside your vehicle and use the LEFT MOUSE BUTTON to make vehicle repairs.

13. Run over the Zeds at full speed and they'll die instantly. Run over them at anything less and you'll be at the mercy of the 'Drag Frag' system whereby the Zeds will be dragged along and may attack your vehicle in the process. You'll either reach full speed and make a kill, lose the Zeds through steering, see the Zeds jump over the vehicle or out of the way, or be destroyed.

14. Once all Zeds are destroyed in a wave, go to the Trader and spend your hard earned cash.

15. Repeat.

16. Take on the big bad Patty and save the world or end up as maggot meat.

========================
DEDICATED SERVER HOSTING
========================

We've vigorously tested the Killing Floor Vehicle Mod on numerous dedicated servers with with player counts from 1 ~ 6 and pings from 20 ~ 300.
CPU load is comparable to a standard Killing Floor server and default Killing Floor.ini settings appear sufficient. By all means tweak as you see fit.

1. Install the Killing Floor dedicated server files as per the instructions in this thread.
http://forums.tripwireinteractive.com/showthread.php?t=30579

2. Add the Mapname_KFVM maps to your map folder.

3. Delete all other maps in the map folder except entry.rom map. The Killing Floor Vehicle Mod will automatically add all maps in the folder to a map list and update your KillingFloor.ini automatically once the server is launched.

4. Use the following command line in place of the one suggested in the above tutorial.

This command line is for server admin who only want to go with the default car spawn count of a minimum of 6 and maximum of 9 per map.
-------------------------------------------------------------------------------------------------------------
ucc server KF-WestLondon_KFVM.rom?game=KF_Vehicles_BD.BDGameType?VACSecured=true?MaxPlayers=6 -log=server.log
-------------------------------------------------------------------------------------------------------------

This command line launches the SP Mutator that will also allow the Max/Min settings on a dedicated server. Server admin have flexibility with how many cars spawn at one time.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
ucc server KF-WestLondon_KFVM.rom?game=KF_Vehicles_BD.BDGameType?VACSecured=true?MaxPlayers=6?Mutator=KF_Vehicles_BD.SPGameMut.KF_Vehicles_BD.SPGameMut -log=server.log
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

You will also need to make a KF_Vehicles_BD.ini file and add it to the system folder with the following entry:

--------------------------
[KF_Vehicles_BD.SPGameMut]
MaxCarLimit=9
MinCarLimit=3
--------------------------

The MaxCarLimit for maximum vehicle count is from 1~12.
The MinCarLimit for minimum vehicle count is from 1~8.

It is also possible to set these parameters from the Web Based Admin after launching your server. This will force the server to create a KF_Vehicles_BD.ini file which you can manually update.

5. Manage your server using the Web Admin Interface and other Admin tools.

=================================
MAP CREDITS IN ALPHABETICAL ORDER
=================================

KF-Abandoned-Base-MacabreDay by THEDDLE. Modded to KF-TheddlePedal_KFVM by arramus.
KF-CornerMarket by Clément "Corwin" Melendez (http://www.clement-melendez.com). Modded with the _KFVM suffix by arramus.
KF-Farm by Tripwire Interactive. Modded to KF-FarmFuzz_KFVM by arramus.
KF-Manor by Tripwire Interactive. Modded to ManorForkliftFrenzy_KFVM and KF-ManorMini_KFVM by arramus.
KF-MountainPassDay and KF-MountainPassNight by Kevin 'DrGuppy' Butt. Modded with the _KFVM suffix by arramus.
KF-Multistorey_Carpark by Ricky and AXEL. Modded with the _KFVM suffix by arramus.
KF-Suburbia by ZiO. Modded with the _KFVM suffix by arramus.
KF-Tricky by Ben Beckwith. Modded by Sambopukka and edited for the mod with the _KFVM suffix by arramus.
KF-WestLondon by Tripwire Interactive. Modded with the _KFVM suffix by arramus.

KF-BloodMOuntain_KFVM by arramus
KF-DeathBasin_KFVM by arramus
KF-DeathBasinSandsNight_KFVM by arramus
KF-MosEisleyScum_KFVM by arramus

===========
MOD CREDITS
===========

BlackCheetah for the original code that inspired the creation of this mod.
Jaun Gauthier and the RKW team for allowing the use of the fuel can code and pure inspiration.
Glenn 'SuperApe' Storm for the original Team Vehicle Factory code.
TWI for the original vehicle models and RO Coding base.
Marco for inspiriation with coding techniques and gameplay elements

==========================================
BETA TESTING CREDITS IN ALPHABETICAL ORDER
==========================================

Thank you so much to the following BETA TESTERS and Tripwire Staff/Admin who ensured this release is as bug free and enjoyable as possible.

celcy
Greg2k2
gusone
h3lli0n
JustFilth
Marco
Ricky(SCO)
Sambopukka
Sandcrawler
THEDDLE
vellsus
yakiimo
Yoshiro
Zips

Thank you also to Tripwire Interactive Staff who checked the Killing Floor Vehicle Mod in the office as well as TW forum members and moddb members for your continued support, advice, and direction.

And a final BIG thank you to Jestservers.com for server hosting and Sandcrawler.net for file hosting and continued support.