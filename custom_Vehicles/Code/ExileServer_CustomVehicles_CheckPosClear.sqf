private["_position","_minimumDistanceToTraderZones","_minimumDistanceToTerritories","_minimumDistanceToSpawns", "_check"];
format ["||BONES CUSTOM VEHICLE SPAWN||Commencing position check...."] call ExileServer_util_log;
_position = (_this select 0);
_minimumDistanceToTraderZones = (_this select 1);
_minimumDistanceToTerritories = (_this select 2);
_minimumDistanceToSpawns = (_this select 3);

_check = true;
if (_minimumDistanceToTraderZones > 0) then
{
	if ([_position, _minimumDistanceToTraderZones] call ExileClient_util_world_isTraderZoneInRange) exitwith
	{
		_check = false;
	};
};
if (_minimumDistanceToTerritories > 0) then
{
	if ([_position, _minimumDistanceToTerritories] call ExileClient_util_world_isTerritoryInRange) exitwith
	{
		_check = false;
	};
};
if (_minimumDistanceToSpawns > 0) then
{
	if ([_position, _minimumDistanceToSpawns] call ExileClient_util_world_isSpawnZoneInRange) exitwith
	{
		_check = false;
	};
};
if !(_check) then 
{
format ["||BONES CUSTOM VEHICLE SPAWN||Position check failed!"] call ExileServer_util_log;
} else {_check = true; format ["||BONES CUSTOM VEHICLE SPAWN||Position check passed!"] call ExileServer_util_log;};

_check