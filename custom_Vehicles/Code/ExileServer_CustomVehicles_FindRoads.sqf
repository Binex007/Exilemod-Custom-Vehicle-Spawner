private["_finalPosition", "_position", "_radius", "_roads", "_numberOfRoads", "_road"];
_position = _this select 0;
_radius = _this select 1;
	format ["||BONES CUSTOM VEHICLE SPAWN||Finding Road near %1...",_position] call ExileServer_util_log;
_roads = _position nearRoads _radius;
_numberOfRoads = count _roads;
if (_numberOfRoads > 0) then
{
    _road = _roads select floor(random _numberOfRoads); 
    format ["||BONES CUSTOM VEHICLE SPAWN||Getting Road position..."] call ExileServer_util_log;
	_finalPosition = getPos _road;
	format ["||BONES CUSTOM VEHICLE SPAWN||Got Road position %1",_finalPosition] call ExileServer_util_log;
} else {
format ["||BONES CUSTOM VEHICLE SPAWN||No Road Found, getting a default location..."] call ExileServer_util_log;
_finalPosition = [_Position, 1, _Radius, 2, 0 , 0.3 , 0] call BIS_fnc_findSafePos;
};

_finalPosition