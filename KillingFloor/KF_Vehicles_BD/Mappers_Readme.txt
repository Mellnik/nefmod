=========================================
MAPPING FOR THE KILLING FLOOR VEHICLE MOD
=========================================

This is for mappers who are already familiar with the SDK. 

The easiest way to map for the Killing Floor Vehicle Mod is to open two instances of the Unreal Editor and bring over actors from an existing KFVM map. Be advised that you'll first need to go to your Actor Classes and open the KF_Vehicle_BD.u file in both UE windows.

Important assets to bring over.

1) BDLevelRules.
This asset ensures the Fuel Can appears in the Trader Shop and is essential.

2) KFRandomSpawn.
This standard asset requires properties changes from default settings to ensure the Fuel Can spawns. Changes are as follows:

KFRandomSpawn > bForceDefault = False
KFRandomSpawn > PickupClasses - [8] Class'KF_Vehicles_BD.BDFuelCan_WeaponPickup'
KFRandomSpawn > PickupWeight - [8] 2

3) BDRandomVehicleTrigger (Under *SVehicleFactory)
For most efficient random vehicle spawning you should place 30 BDRandomVehicleTrigger actors in your map. Don't add more than 30 as extras won't be utilised and will make spawning unbalanced. Using the right click 'Add BDRandomVehicleTrigger here' feature will place the actor in your map. In the properties there will be a list of 14 vehicles. You can tweak this list by adding and deleting entries under the BDRandomVehicleTrigger > RandomVehicles properties. To ensure more proportional spawning remove some minis as there are 6 of them. If you look in a map like KF-DeathBasin_KFVM you will see actors placed in patterns of 3 with 2 different minis in each actor. This ensures more variety.

4) It is also possible to add Vehicles and Fuel Cans as placable actors and tweak their properties for 'easter egg' type features. Check the *Pawn > *Vehicle > *SVehicle > *ROVehicle list for Vehicle choices and *Pickup > WeaponPickup > *KFWeaponPickup for the Fuel Can (*BDFuelCan_WeaponPickup).

5) Open the KF-FenceTespmap (in the Maps folder) to view a variety of destructible items. These actors can be added to your map to provide a more 'destructive' experience. Be warned that these actors can be temporamental from time to time and may appear not to have been destroyed. The object will be dragged along with your vehicle. This appears to be a client side update issue and may be more pronounced playing on a high ping server.

Enjoy and get mapping. If you have any questions then visit the Tripwire Interactive Forum - http://forums.tripwireinteractive.com/showthread.php?t=36237

Braindead and arramus






