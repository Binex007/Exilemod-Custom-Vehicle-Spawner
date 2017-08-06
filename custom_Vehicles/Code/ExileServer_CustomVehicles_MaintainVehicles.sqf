if (!isServer) exitWith {};

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
Bones_DistancetoSpawnZone
] call ExileServer_CustomVehicles_SpawnVehicles;

true