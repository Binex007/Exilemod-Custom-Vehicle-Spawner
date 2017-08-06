if (!isServer) exitWith {};

private ["_groundVehicleArray", "_airVehicleArray", "_waterVehicleArray", "_chanceFuel", "_chanceDmg", "_maxFuel", "_maxDmg", "_mapPos", "_middle" ,"_groundSpawnRadiusRoad", "_airSpawnRadiusAirField", "_waterSpawnRadiusCoast", "_flatness", "_chanceWheel", "_airportPositions", "_chanceRotor", "_uid", "_pinCode", "_vehicles", "_spawnedPositions", "_vehicleClass", "_targetVehicleCount", "_countAlive", "_fuelAmount", "_vehicleDamage", "_pos", "_vehicleObject", "_positionReal", "_spawnControl", "_wheels", "_wheelDamage", "_rotors", "_rotorDamage", "_airportPos", "_vehicleItemsAllowed", "_maximumItemsPerVehicle", "_allowedItems"];

//Get Settings
_groundVehicleArray = (_this select 0);
_airVehicleArray = (_this select 1);
_waterVehicleArray = (_this select 2);
_chanceFuel = (_this select 3);
_chanceDmg = (_this select 4);
_maxFuel = (_this select 5);
_maxDmg = (_this select 6);
_mapPos = (_this select 7);
_middle = (_this select 8);
_groundSpawnRadiusRoad = (_this select 9);
_airSpawnRadiusAirField = (_this select 10);
_waterSpawnRadiusCoast = (_this select 11);
_flatness = (_this select 12);
_chanceWheel = (_this select 13);
_airportPositions = (_this select 14);
_chanceRotor = (_this select 15);
_uid = (_this select 16);
_pinCode = (_this select 17);
_minimumDistanceToTraderZones = (_this select 18);
_minimumDistanceToTerritories = (_this select 19);
_minimumDistanceToSpawns = (_this select 20);
_vehicleItemsAllowed = (_this select 21);
_maximumItemsPerVehicle = (_this select 22);
_allowedItems = (_this select 23);

format ["||BONES CUSTOM VEHICLE SPAWN||Commencing spawning of air units......."] call ExileServer_util_log;
{
	_vehicles = allMissionObjects (_x select 0);
	_targetVehicleCount = _x select 1;
	_countAlive = count _vehicles;
	_fuelAmount = if (Random 1 < _chanceFuel) then {_maxFuel} else {0};
	_vehicleDamage = if (Random 1 < _chanceDmg) then {0} else {_maxDmg};
	while {_countAlive < _targetVehicleCount} do
	{
		_vehicleClass = _x select 0;
		_positionReal = [_airportPositions, _middle, _vehicleClass, _airSpawnRadiusAirField, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;
		if((count _positionReal) == 2) then {_positionReal = [_airportPositions, _middle, _vehicleClass, _airSpawnRadiusAirField, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;};
		if((count _positionReal) == 2) then {_positionReal = [_airportPositions, _middle, _vehicleClass, _airSpawnRadiusAirField, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;};
		if((count _positionReal) == 2) then {_positionReal = [_airportPositions, _middle, _vehicleClass, _airSpawnRadiusAirField, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;};
		if((count _positionReal) == 2) then {_positionReal = [_airportPositions, _middle, _vehicleClass, _airSpawnRadiusAirField, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;};
		if((count _positionReal) == 2) exitwith {format ["||BONES CUSTOM VEHICLE SPAWN||Can't find location for vehicle, will try again next time"] call ExileServer_util_log};
		format ["||BONES CUSTOM VEHICLE SPAWN||Attempting to Spawn a %1 at %2",_vehicleClass,_positionReal] call ExileServer_util_log;
		_vehicleObject = [_vehicleClass, _positionReal, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
// Add Damage
		format ["||BONES CUSTOM VEHICLE SPAWN||Adding Vehicle Damage"] call ExileServer_util_log;
		_rotors = ["HitHrotor","HitVRotor"];
		[_chanceRotor, _rotors, _vehicleObject, _vehicleDamage, _fuelAmount] call ExileServer_CustomVehicles_ApplyDamage;
//Add Loot (soon tm)
		format ["||BONES CUSTOM VEHICLE SPAWN||Adding Loot"] call ExileServer_util_log;
		[_vehicleObject, _vehicleItemsAllowed, _maximumItemsPerVehicle, _allowedItems] call ExileServer_CustomVehicles_AddLoot;
//Set Variables
		_vehicleObject setVariable ["ExileOwnerUID", _uid];
		_vehicleObject setVariable ["ExileIsLocked",0];
		_vehicleObject lock 0;
		_vehicleObject call ExileServer_object_vehicle_database_insert;
		_vehicleObject call ExileServer_object_vehicle_database_update;
		_vehicleObject enableSimulationGlobal True;
		_countAlive = _countAlive +1;
//Add Marker (soon tm)
		format ["||BONES CUSTOM VEHICLE SPAWN||Spawned a %1 at %2, current count is %3 of %4",(_x select 0),_positionReal,_countAlive,_targetVehicleCount] call ExileServer_util_log;
		sleep 1;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Vehicle type %1 Checked and completed Spawning, Final vehicle count is %2 of %3",(_x select 0),_countAlive,_targetVehicleCount] call ExileServer_util_log;
}forEach _airVehicleArray;

format ["||BONES CUSTOM VEHICLE SPAWN||Commencing spawning of ground units......."] call ExileServer_util_log;
{
	_vehicles = allMissionObjects (_x select 0);
	_targetVehicleCount = _x select 1;
	_countAlive = count _vehicles;
	_fuelAmount = if (Random 1 < _chanceFuel) then {_maxFuel} else {0};
	_vehicleDamage = if (Random 1 < _chanceDmg) then {0} else {_maxDmg};
	while {_countAlive < _targetVehicleCount} do
	{
		_vehicleClass = _x select 0;
		_positionReal = [_mapPos, _middle, _vehicleClass, _groundSpawnRadiusRoad, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;
		if((count _positionReal) == 2) then {_positionReal = [_mapPos, _middle, _vehicleClass, _groundSpawnRadiusRoad, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;};
		if((count _positionReal) == 2) exitwith {format ["||BONES CUSTOM VEHICLE SPAWN||Can't find location for vehicle, will try again next time"] call ExileServer_util_log};
		format ["||BONES CUSTOM VEHICLE SPAWN||Attempting to Spawn a %1 at %2",_vehicleClass,_positionReal] call ExileServer_util_log;
		_vehicleObject = [_vehicleClass, _positionReal, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
// Add Damage
		format ["||BONES CUSTOM VEHICLE SPAWN||Adding Vehicle Damage"] call ExileServer_util_log;
		_wheels = ["HitLF2Wheel","HitLFWheel","HitRFWheel","HitRF2Wheel","HitLMWheel","HitLBWheel","HitRMWheel","HitRBWheel"];
		[_chanceWheel, _wheels, _vehicleObject, _vehicleDamage, _fuelAmount] call ExileServer_CustomVehicles_ApplyDamage;
//Add Loot (soon tm)
		format ["||BONES CUSTOM VEHICLE SPAWN||Adding Vehicle Loot"] call ExileServer_util_log;
		[_vehicleObject, _vehicleItemsAllowed, _maximumItemsPerVehicle, _allowedItems] call ExileServer_CustomVehicles_AddLoot;
//Set Variables
		_vehicleObject setVariable ["ExileOwnerUID", _uid];
		_vehicleObject setVariable ["ExileIsLocked",0];
		_vehicleObject lock 0;
		_vehicleObject call ExileServer_object_vehicle_database_insert;
		_vehicleObject call ExileServer_object_vehicle_database_update;
		_vehicleObject enableSimulationGlobal True;
		_countAlive = _countAlive +1;
//Add Marker (soon tm)
		

		format ["||BONES CUSTOM VEHICLE SPAWN||Spawned a %1 at %2, current count is %3 of %4",(_x select 0),_positionReal,_countAlive,_targetVehicleCount] call ExileServer_util_log;
		sleep 1;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Vehicle type %1 Checked and completed Spawning, Final vehicle count is %2 of %3",(_x select 0),_countAlive,_targetVehicleCount] call ExileServer_util_log;
}forEach _groundVehicleArray;

format ["||BONES CUSTOM VEHICLE SPAWN||Commencing spawning of water units......."] call ExileServer_util_log;
{
	_vehicles = allMissionObjects (_x select 0);
	_targetVehicleCount = _x select 1;
	_countAlive = count _vehicles;
	_fuelAmount = if (Random 1 < _chanceFuel) then {_maxFuel} else {0};
	_vehicleDamage = if (Random 1 < _chanceDmg) then {0} else {_maxDmg};
	while {_countAlive < _targetVehicleCount} do
	{
		_vehicleClass = _x select 0;
		_positionReal = [_mapPos, _middle, _vehicleClass, _waterSpawnRadiusCoast, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;
		if((count _positionReal) == 2) then {_positionReal = [_mapPos, _middle, _vehicleClass, _waterSpawnRadiusCoast, _flatness, Bones_spawnedPositions] call ExileServer_CustomVehicles_FindPos;};
		if((count _positionReal) == 2) exitwith {format ["||BONES CUSTOM VEHICLE SPAWN||Can't find location for vehicle, will try again next time"] call ExileServer_util_log};
		format ["||BONES CUSTOM VEHICLE SPAWN||Attempting to Spawn a %1 at %2",_vehicleClass,_positionReal] call ExileServer_util_log;
		_vehicleObject = [_vehicleClass, _positionReal, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
// Add Damage

//Add Loot (soon tm)

//Set Variables
		_vehicleObject setVariable ["ExileOwnerUID", _uid];
		_vehicleObject setVariable ["ExileIsLocked",0];
		_vehicleObject lock 0;
		_vehicleObject call ExileServer_object_vehicle_database_insert;
		_vehicleObject call ExileServer_object_vehicle_database_update;
		_vehicleObject enableSimulationGlobal True;
		_countAlive = _countAlive +1;
//Add Marker (soon tm)
		format ["||BONES CUSTOM VEHICLE SPAWN||Spawned a %1 at %2, current count is %3 of %4",(_x select 0),_positionReal,_countAlive,_targetVehicleCount] call ExileServer_util_log;
		sleep 1;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Vehicle type %1 Checked and completed Spawning, Final vehicle count is %2 of %3",(_x select 0),_countAlive,_targetVehicleCount] call ExileServer_util_log;
}forEach _waterVehicleArray;

format ["||CUSTOMSPAWN||All Vehicle Spawning Complete!"] call ExileServer_util_log;

true