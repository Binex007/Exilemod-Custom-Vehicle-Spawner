if (!isServer) exitWith {};
format ["Starting custom vehicle spawn initialization..."] call ExileServer_util_log;

//Spawn Vehicles
[
Bones_groundVehicleArray,
Bones_airVehicleArray,
Bones_waterVehicleArray,
Bones_chanceFuel,
Bones_chanceDmg,
Bones_maxFuel,
Bones_maxDmg,
Bones_mapPos,
Bones_MapMid,
Bones_groundSpawnRadiusRoad,
Bones_airSpawnRadiusAirField,
Bones_waterSpawnRadiusCoast,
Bones_Flatness,
Bones_chanceWheel,
Bones_airportPositions,
Bones_chanceRotor,
Bones_uid,
Bones_pinCode,
Bones_DistancetoTrader,
Bones_DistancetoTerritory,
Bones_DistancetoSpawnZone,
Bones_vehicleItemsAllowed,
Bones_maximumItemsPerVehicle,
Bones_allowedItems
] call ExileServer_CustomVehicles_SpawnVehicles;

uiSleep 15; // TODO: is this needed?
[
    1800, 
    ExileServer_CustomVehicles_SpawnVehicles, 
    [
	Bones_groundVehicleArray,
	Bones_airVehicleArray,
	Bones_waterVehicleArray,
	Bones_chanceFuel,
	Bones_chanceDmg,
	Bones_maxFuel,
	Bones_maxDmg,
	Bones_mapPos,
	Bones_MapMid,
	Bones_groundSpawnRadiusRoad,
	Bones_airSpawnRadiusAirField,
	Bones_waterSpawnRadiusCoast,
	Bones_Flatness,
	Bones_chanceWheel,
	Bones_airportPositions,
	Bones_chanceRotor,
	Bones_uid,
	Bones_pinCode,
	Bones_DistancetoTrader,
	Bones_DistancetoTerritory,
	Bones_DistancetoSpawnZone,
	Bones_vehicleItemsAllowed,
	Bones_maximumItemsPerVehicle,
	Bones_allowedItems
	], 
    true
] call ExileServer_system_thread_addTask;

true