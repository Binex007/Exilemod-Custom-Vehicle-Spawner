if (!isServer) exitWith {};

Bones_DistancetoTrader = 500;// Do not spawn vehicles this close to traders
Bones_DistancetoTerritory = 500;// Do not spawn vehicles this close to players territories
Bones_DistancetoSpawnZone = 500;// Do not spawn vehicles this close to Spawn Zones
Bones_groundSpawnRadiusRoad  = 100; //Max Distance to spawn from Roads
Bones_waterSpawnRadiusCoast = 50; //Max Distance to spawn from coast
Bones_airSpawnRadiusAirField = 200; //Max distance from Airfields (uses map airport marker name location on map as position)
Bones_Flatness = 0.3; //Defines how flat a location to look for (0 = completely flat, 1 = ~45 degree angle). The lower the number the harder it will be, and longer it will take, to find a spot.

Bones_uid = "76561197996158574";//Enter your personal UID so that Exile has someone to assign the vehicle too to start with.
Bones_chanceFuel = 0.4; // % Chance of a Vehicle having Fuel.
Bones_maxFuel = 0.1; // % Amount of fuel vehicle will have if chance set above succeeds.
Bones_chanceDmg = 0.4; //% Chance of a vehicle having no damage (exc wheels/rotors).
Bones_maxDmg = 0.8; // % damage applied to vehicle parts, except rotors and wheels, when the above chance fails.
Bones_chanceWheel = 0.5; // Chance of each wheel being destroyed.
Bones_chanceRotor = 0.5; //Chance of each Rotor being destroyed.
Bones_pinCode = "0000"; //Pincode for all spawned vehicles.
Bones_spawnedPositions = [];
Bones_debug = 1;

// Stuff to spawn on roads.
Bones_groundVehicleArray = 
[
	["B_G_Offroad_01_armed_HUNTER", 7],
	["I_MRAP_03_gmg_F_Hunter", 2],
	["I_MRAP_03_hmg_F_Hunter", 2],
	["I_MRAP_03_F_Hunter", 5],
	["Zhunters_hunt_lfda", 5],
	["Zhunters_huntMed", 5],
	["Exile_Car_HMMWV_M134_Desert", 3],
	["Exile_Car_HMMWV_M2_Desert", 3]
];

// Stuff to spawn on water
Bones_waterVehicleArray = 
[
	["Exile_Boat_MotorBoat_Police", 1],
	["Exile_Boat_MotorBoat_Orange", 1],
	["Exile_Boat_MotorBoat_White", 1],
	["Exile_Boat_RubberDuck_CSAT", 1],
	["Exile_Boat_RubberDuck_Digital", 1],
	["Exile_Boat_RubberDuck_Orange", 1],
	["Exile_Boat_RubberDuck_Blue", 1],
	["Exile_Boat_RubberDuck_Black", 1]
];

// Stuff to spawn on airfield
Bones_airVehicleArray = 
[
	["I_Heli_Transport_02_F_Hunter", 4],
	["I_Heli_light_03_F_Hunter", 4],
	["I_Heli_light_04_F_Hunter", 4]
];

_worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
_middle = _worldSize / 2;
_quarter = _worldSize / 4;
_threeQuarter = _quarter * 3;
_southwestPos = [_quarter,_quarter,0];
_southPos = [_middle,_quarter,0];
_southeastPos = [_threeQuarter,_quarter,0];
_westPos = [_quarter,_middle,0];
_middlPos = [_middle,_middle,0];
_eastPos = [_threeQuarter,_middle,0];
_northwestPos = [_quarter,_threeQuarter,0];
_northPos = [_middle,_threeQuarter,0];
_northeastPos = [_threeQuarter,_threeQuarter,0];
Bones_mapPos = [_southwestPos,_middlPos,_southPos,_middlPos,_southeastPos,_middlPos,_westPos,_middlPos,_eastPos,_middlPos,_northwestPos,_middlPos,_northPos,_middlPos,_northeastPos,_middlPos];
Bones_MapMid = _middle;
//Core Position initialise

//map airport locations
_airportPositions = [[8188.69,10111.8,0],[804.935,12237.5,0]];
Bones_airportPositions = _airportPositions;

Bones_vehicleItemsAllowed = 1;
Bones_maximumItemsPerVehicle = 4;
Bones_allowedItems = ["Exile_Item_CarWheel", "Exile_Item_MetalBoard", "Exile_Item_DuctTape", "Exile_Item_MetalScrews", "Exile_Item_Screwdriver", "Exile_Item_Wrench", "Exile_Item_JunkMetal", "Exile_Item_OilCanister", "Exile_Item_MetalWire", "Exile_Item_Foolbox"];

publicVariable "Bones_mapPos";
publicVariable "Bones_MapMid";
publicVariable "Bones_airportPositions";
publicVariable "Bones_DistancetoTrader";
publicVariable "Bones_DistancetoTerritory";
publicVariable "Bones_DistancetoSpawnZone";
publicVariable "Bones_groundSpawnRadiusRoad";
publicVariable "Bones_waterSpawnRadiusCoast";
publicVariable "Bones_airSpawnRadiusAirField";
publicVariable "Bones_Flatness";
publicVariable "Bones_customAir";
publicVariable "Bones_uid";
publicVariable "Bones_chanceFuel";
publicVariable "Bones_maxFuel";
publicVariable "Bones_chanceDmg";
publicVariable "Bones_maxDmg";
publicVariable "Bones_chanceWheel";
publicVariable "Bones_chanceRotor";
publicVariable "Bones_pinCode";
publicVariable "Bones_groundVehicleArray";
publicVariable "Bones_waterVehicleArray";
publicVariable "Bones_airVehicleArray";
publicVariable "Bones_spawnedPositions";
publicVariable "Bones_vehicleItemsAllowed";
publicVariable "Bones_maximumItemsPerVehicle";
publicVariable "Bones_allowedItems";
publicVariable "Bones_debug";