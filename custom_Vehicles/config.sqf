if (!isServer) exitWith {};

Bones_DistancetoTrader = 500;// Do not spawn vehicles this close to traders
Bones_DistancetoTerritory = 500;// Do not spawn vehicles this close to players territories
Bones_DistancetoSpawnZone = 500;// Do not spawn vehicles this close to Spawn Zones
Bones_groundSpawnRadiusRoad  = 100; //Max Distance to spawn from Roads
Bones_waterSpawnRadiusCoast = 50; //Max Distance to spawn from coast
Bones_airSpawnRadiusAirField = 2000; //Max distance from Airfields (adjust airpirt positions below to match the map)
Bones_Flatness = 0.3; //Defines how flat a location to look for (0 = completely flat, 1 = ~45 degree angle). The lower the number the harder it will be, and longer it will take, to find a spot.

Bones_uid = "";//Enter your personal UID so that Exile has someone to assign the vehicle too to start with.
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
	["Exile_Car_HMMWV_M134_Desert", 3],
	["Exile_Car_HMMWV_M2_Desert", 3],
	["Exile_Car_HMMWV_MEV_Desert", 1],
	["Exile_Car_HMMWV_UNA_Desert", 1],
	["Exile_Car_Offroad_Rusty1", 5],
	["Exile_Car_Offroad_Rusty2", 5],
	["Exile_Car_Offroad_Rusty3", 5],
	["Exile_Car_Lada_Green", 1],
	["Exile_Car_Lada_Taxi", 1],
	["Exile_Car_Lada_Red", 2],
	["Exile_Car_Lada_White", 2],
	["Exile_Car_Lada_Hipster", 2],
	["Exile_Car_Volha_Blue", 2],
	["Exile_Car_Volha_White", 2],
	["Exile_Car_Volha_Black", 2],
	["Exile_Car_UAZ_Green", 5],
	["Exile_Car_UAZ_Open_Green", 5]
];

// Stuff to spawn on water
Bones_waterVehicleArray = 
[
	["Exile_Boat_MotorBoat_Police", 5],
	["Exile_Boat_MotorBoat_Orange", 5],
	["Exile_Boat_MotorBoat_White", 5],
	["Exile_Boat_RubberDuck_CSAT", 8],
	["Exile_Boat_RubberDuck_Digital", 8],
	["Exile_Boat_RubberDuck_Orange", 8],
	["Exile_Boat_RubberDuck_Blue", 8],
	["Exile_Boat_RubberDuck_Black", 8]
];

// Stuff to spawn on airfield
Bones_airVehicleArray = 
[
	["Exile_Chopper_Huey_Green", 3],
	["Exile_Chopper_Huey_Desert", 3],
	["Exile_Chopper_Hummingbird_Green", 6]
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
_airportPositions = [];
Bones_airportPositions = _airportPositions;

Bones_vehicleItemsAllowed = 1;
Bones_maximumItemsPerVehicle = 4;
Bones_allowedItems = ["Exile_Item_MetalBoard", "Exile_Item_DuctTape", "Exile_Item_MetalScrews", "Exile_Item_MetalScrews", "Exile_Item_Screwdriver", "Exile_Item_Screwdriver", "Exile_Item_Wrench","Exile_Item_Wrench", "Exile_Item_JunkMetal", "Exile_Item_JunkMetal", "Exile_Item_JunkMetal", "Exile_Item_OilCanister", "Exile_Item_MetalWire", "Exile_Item_MetalWire", "Exile_Item_Foolbox"];

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