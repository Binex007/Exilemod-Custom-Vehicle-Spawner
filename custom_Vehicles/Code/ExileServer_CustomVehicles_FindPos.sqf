private ["_mapPos", "_middle", "_vehicleClass", "_spawnRadius", "_flatness", "_spawnedPositions","_pos", "_posSafe", "_positionReal", "_spawnControl", "_posCheck"];

_mapPos = (_this Select 0);
_middle = (_this select 1);
_vehicleClass = (_this select 2);
_spawnRadius = (_this select 3);
_flatness = (_this select 4);
_spawnedPositions = (_this select 5);

if(_vehicleClass iskindof "ship") then 
{
	_pos = selectRandom _mapPos;
	_vehiclePosition = [_pos, 1, _middle, 0, 1, 0, 1, Bones_spawnedPositions,[]] call BIS_fnc_findSafePos;
	format ["||BONES CUSTOM VEHICLE SPAWN||Finding Coast Position..."] call ExileServer_util_log;
	_posSafe = _vehiclePosition call ExileClient_util_world_findCoastPosition;
	format ["||BONES CUSTOM VEHICLE SPAWN||Found Coast Position! Finding Safe Position...."] call ExileServer_util_log;
	_positionReal = [_posSafe, 1, _SpawnRadius, 1, 2 , 0 , 0, Bones_spawnedPositions, []] call BIS_fnc_findSafePos;
	format ["||BONES CUSTOM VEHICLE SPAWN||Found Safe Position!"] call ExileServer_util_log;
	if(count _positionReal isEqualTo 2) then
	{
		_positionReal pushback 0;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Remembering Position..."] call ExileServer_util_log;
	_spawnControl = [[(_positionReal select 0) - 50, (_positionReal select 1) + 50],[(_positionReal select 0) + 50,(_positionReal select 1) - 50]];
	Bones_spawnedPositions pushback _spawnControl;
	publicVariable "Bones_spawnedPositions";
	format ["||BONES CUSTOM VEHICLE SPAWN||Let's Check the Position..."] call ExileServer_util_log;
	_posCheck = [[_positionReal select 0, _positionReal select 1, _positionReal select 2],_minimumDistanceToTraderZones,_minimumDistanceToTerritories,_minimumDistanceToSpawns] Call ExileServer_CustomVehicles_CheckPosClear;
	if!(_posCheck) then 
	{
		format ["||BONES CUSTOM VEHICLE SPAWN||Can't Spawn at this location!"] call ExileServer_util_log;
		_positionReal = [0,0];
	};
}
else 
{
	_pos = selectRandom _mapPos;
	if(_vehicleClass iskindof "air") then {_middle = 1000;};
	_vehiclePosition = [_pos, 1, _middle, 0, 0 , _flatness , 0, Bones_spawnedPositions, []] call BIS_fnc_findSafePos;
	format ["||BONES CUSTOM VEHICLE SPAWN||Finding Road Position..."] call ExileServer_util_log;
	_posSafe = [_vehiclePosition, _middle] call ExileServer_CustomVehicles_FindRoads;
	format ["||BONES CUSTOM VEHICLE SPAWN||Found Road Position %1! Finding Safe Position....",_vehiclePosition] call ExileServer_util_log;
	_positionReal = [_posSafe, 1, _spawnRadius, 2, 0 , _flatness , 0, Bones_spawnedPositions, []] call BIS_fnc_findSafePos;
	format ["||BONES CUSTOM VEHICLE SPAWN||Found Safe Position %1!", _positionReal] call ExileServer_util_log;
	if(count _positionReal isEqualTo 2) then
	{
		_positionReal pushback 0;
	};
	format ["||BONES CUSTOM VEHICLE SPAWN||Remembering Position..."] call ExileServer_util_log;
	_spawnControl = [[(_positionReal select 0) - 50, (_positionReal select 1) + 50],[(_positionReal select 0) + 50,(_positionReal select 1) - 50]];
	Bones_spawnedPositions pushback _spawnControl;
	publicVariable "Bones_spawnedPositions";
	format ["||BONES CUSTOM VEHICLE SPAWN||Let's Check the Position..."] call ExileServer_util_log;

	//check position isn't in a spawn, trader or territory zone
	_posCheck = [[_positionReal select 0, _positionReal select 1, _positionReal select 2],_minimumDistanceToTraderZones,_minimumDistanceToTerritories,_minimumDistanceToSpawns] Call ExileServer_CustomVehicles_CheckPosClear;
	if!(_posCheck) then 
	{
		format ["||BONES CUSTOM VEHICLE SPAWN||Can't Spawn at this location!"] call ExileServer_util_log;
		_positionReal = [0,0];
	};
};
	
_positionReal

	