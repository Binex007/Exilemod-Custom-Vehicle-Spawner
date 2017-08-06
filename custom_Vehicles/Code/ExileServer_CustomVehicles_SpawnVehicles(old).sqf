if (!isServer) exitWith {};

private ["_groundVehicleArray", "_airVehicleArray", "_waterVehicleArray", "_chanceFuel", "_chanceDmg", "_maxFuel", "_maxDmg", "_mapPos", "_middle" ,"_groundSpawnRadiusRoad", "_airSpawnRadiusAirField", "_waterSpawnRadiusCoast", "_flatness", "_chanceWheel", "_airportPositions", "_chanceRotor", "_uid", "_pinCode", "_vehicles", "_spawnedPositions", "_vehicleClass", "_targetVehicleCount", "_countAlive", "_fuelAmount", "_vehicleDamage", "_pos", "_vehicleObject", "_positionReal", "_spawnControl", "_wheels", "_wheelDamage", "_rotors", "_rotorDamage"];

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
_spawnedPositions = [];


format ["||BONES CUSTOM VEHICLE SPAWN||Commencing spawning of ground units......."] call ExileServer_util_log;
{
	scopeName "Loop1";
	_vehicles = allMissionObjects (_x select 0);
	_targetVehicleCount = _x select 1;
	_countAlive = count _vehicles;
	_fuelAmount = if (Random 1 < _chanceFuel) then {_maxFuel} else {0};
	_vehicleDamage = if (Random 1 < _chanceDmg) then {0} else {_maxDmg};
	while {_countAlive < _targetVehicleCount} do
	{
		scopeName "Loop2";
		format ["||BONES CUSTOM VEHICLE SPAWN||Getting Position..."] call ExileServer_util_log;
		_vehicleClass = _x select 0;
		_pos = selectRandom _mapPos;
		format ["||BONES CUSTOM VEHICLE SPAWN||Finding Road Position..."] call ExileServer_util_log;
		_vehiclePosition = [_pos, _middle] call ExileServer_CustomVehicles_FindRoads;
		format ["||BONES CUSTOM VEHICLE SPAWN||Found Road Position! Finding Safe Position...."] call ExileServer_util_log;
		_positionReal = [_vehiclePosition, 1, _groundSpawnRadiusRoad, 2, 0 , _flatness , 0, _spawnedPositions] call BIS_fnc_findSafePos;
		format ["||BONES CUSTOM VEHICLE SPAWN||Found Safe Position!"] call ExileServer_util_log;
		if(count _positionReal isEqualTo 2) then
		{
			_positionReal pushback 0;
		};
		format ["||BONES CUSTOM VEHICLE SPAWN||Remembering Position..."] call ExileServer_util_log;
		_spawnControl = [[(_positionReal select 0) - 50, (_positionReal select 1) + 50],[(_positionReal select 0) + 50,(_positionReal select 1) - 50]];
		_spawnedPositions pushback _spawnControl;
		format ["||BONES CUSTOM VEHICLE SPAWN||Let's Check the Position..."] call ExileServer_util_log;
		_posCheck = [[_positionReal select 0, _positionReal select 1, _positionReal select 2],_minimumDistanceToTraderZones,_minimumDistanceToTerritories,_minimumDistanceToSpawns] Call ExileServer_CustomVehicles_CheckPosClear;
		if!(_posCheck) then {format ["||BONES CUSTOM VEHICLE SPAWN||Can't Spawn at this location!"] call ExileServer_util_log; breakto "loop1"};
		format ["||BONES CUSTOM VEHICLE SPAWN||Attempting to Spawn a %1 at %2",_vehicleClass,_positionReal] call ExileServer_util_log;
		_vehicleObject = [_vehicleClass, _positionReal, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
		_vehicleObject setDamage _vehicleDamage;
		_vehicleObject setFuel _fuelAmount;		
		_wheels = ["HitLF2Wheel","HitLFWheel","HitRFWheel","HitRF2Wheel","HitLMWheel","HitLBWheel","HitRMWheel","HitRBWheel"];
		{
			_wheelDamage = if (Random 1 < _chanceWheel) then {0} else {1};
			_vehicleObject setHitPointDamage [_x,_wheelDamage];
		} forEach _wheels;
		_vehicleObject setVariable ["ExileOwnerUID", _uid];
		_vehicleObject setVariable ["ExileIsLocked",0];
		_vehicleObject lock 0;
		_vehicleObject call ExileServer_object_vehicle_database_insert;
		_vehicleObject call ExileServer_object_vehicle_database_update;
		_vehicleObject enableSimulationGlobal True;
		_countAlive = _countAlive +1;
		format ["||BONES CUSTOM VEHICLE SPAWN||Spawned a %1 at %2, current count is %3 of %4",(_x select 0),_positionReal,_countAlive,_targetVehicleCount] call ExileServer_util_log;
		sleep 1;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Vehicle type %1 Checked and completed Spawning, Final vehicle count is %2 of %3",(_x select 0),_countAlive,_targetVehicleCount] call ExileServer_util_log;
}forEach _groundVehicleArray;

format ["||BONES CUSTOM VEHICLE SPAWN||Commencing spawning of air units......."] call ExileServer_util_log;
{
	scopeName "Loop3";
	_vehicles = allMissionObjects (_x select 0);
	_targetVehicleCount = _x select 1;
	_countAlive = count _vehicles;
	_fuelAmount = if (Random 1 < _chanceFuel) then {_maxFuel} else {0};
	_vehicleDamage = if (Random 1 < _chanceDmg) then {0} else {_maxDmg};
	while {_countAlive < _targetVehicleCount} do
	{
		scopeName "Loop4";
		_vehicleClass = _x select 0;
		_pos = selectRandom _airportPositions;
		_vehiclePosition = [_pos, _middle] call ExileServer_CustomVehicles_FindRoads;
		_positionReal = [_vehiclePosition, 1, _airSpawnRadiusAirField, 2, 0 , _flatness , 0] call BIS_fnc_findSafePos;
		if(count _positionReal isEqualTo 2) then
		{
			_positionReal pushback 0;
		};
		_posCheck = [[_positionReal select 0, _positionReal select 1, _positionReal select 2]] Call ExileServer_CustomVehicles_CheckPosClear;
		if!(_posCheck) then {breakto "loop3"};
		_spawnControl = [[(_positionReal select 0) - 50, (_positionReal select 1) + 50],[(_positionReal select 0) + 50,(_positionReal select 1) - 50]];
		_spawnedPositions pushback _spawnControl;
		format ["||BONES CUSTOM VEHICLE SPAWN||Attempting to Spawn a %1 at %2",_vehicleClass,_positionReal] call ExileServer_util_log;
		_vehicleObject = [_vehicleClass, _positionReal, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
		_vehicleObject setDamage _vehicleDamage;
		_vehicleObject setFuel _fuelAmount;		
		_rotors = ["HitHrotor","HitVRotor"];
		{
			_rotorDamage = if (Random 1 < _chanceRotor) then {0} else {1};
			_vehicleObject setHitPointDamage [_x,_rotorDamage];
		} forEach _rotors;
		_vehicleObject setVariable ["ExileOwnerUID", _uid];
		_vehicleObject setVariable ["ExileIsLocked",0];
		_vehicleObject lock 0;
		_vehicleObject call ExileServer_object_vehicle_database_insert;
		_vehicleObject call ExileServer_object_vehicle_database_update;
		_vehicleObject enableSimulationGlobal True;
		_countAlive = _countAlive +1;		
		format ["||BONES CUSTOM VEHICLE SPAWN||Spawned a %1 at %2, current count is %3 of %4",(_x select 0),_positionReal,_countAlive,_targetVehicleCount] call ExileServer_util_log;
		sleep 1;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Vehicle type %1 Checked and completed Spawning, Final vehicle count is %2 of %3",(_x select 0),_countAlive,_targetVehicleCount] call ExileServer_util_log;
}forEach _airVehicleArray;

format ["||BONES CUSTOM VEHICLE SPAWN||Commencing spawning of water units......."] call ExileServer_util_log;
{
	scopeName "Loop5";
	_vehicles = allMissionObjects (_x select 0);
	_targetVehicleCount = _x select 1;
	_countAlive = count _vehicles;
	while {_countAlive < _targetVehicleCount} do
	{
		scopeName "Loop6";
		_vehicleClass = _x select 0;
		_pos = selectRandom _mapPos;
		_vehiclePosition = [_pos, 1, _middle, 2, 1, 0, 1] call BIS_fnc_findSafePos;
		_posSafe = _vehiclePosition call ExileClient_util_world_findCoastPosition;
		_positionReal = [_posSafe, 1, _waterSpawnRadiusCoast, 1, 2 , 0 , 0 ] call BIS_fnc_findSafePos;
		if(count _positionReal isEqualTo 2) then
		{
			_positionReal pushback 0;
		};
		_posCheck = [[_positionReal select 0, _positionReal select 1, _positionReal select 2]] Call ExileServer_CustomVehicles_CheckPosClear;
		if!(_posCheck) then {breakto "loop5"};
		_spawnControl = [[(_positionReal select 0) - 50, (_positionReal select 1) + 50],[(_positionReal select 0) + 50,(_positionReal select 1) - 50]];
		_spawnedPositions pushback _spawnControl;
		format ["||BONES CUSTOM VEHICLE SPAWN||Attempting to Spawn a %1 at %2",_vehicleClass,_positionReal] call ExileServer_util_log;
		_vehicleObject = [_vehicleClass, _positionReal, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
		_vehicleObject setVariable ["ExileOwnerUID", _uid];
		_vehicleObject setVariable ["ExileIsLocked",0];
		_vehicleObject lock 0;
		_vehicleObject call ExileServer_object_vehicle_database_insert;
		_vehicleObject call ExileServer_object_vehicle_database_update;
		_vehicleObject enableSimulationGlobal True;
		_countAlive = _countAlive +1;		
		format ["||BONES CUSTOM VEHICLE SPAWN||Spawned a %1 at %2, current count is %3 of %4",(_x select 0),_positionReal,_countAlive,_targetVehicleCount] call ExileServer_util_log;
		sleep 1;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Vehicle type %1 Checked and completed Spawning, Final vehicle count is %2 of %3",(_x select 0),_countAlive,_targetVehicleCount] call ExileServer_util_log;
}forEach _waterVehicleArray;

format ["||CUSTOMSPAWN||All Vehicle Spawning Complete!"] call ExileServer_util_log;

true