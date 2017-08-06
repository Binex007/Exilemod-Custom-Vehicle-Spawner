private["_code"];

{
    _code = compileFinal (preprocessFileLineNumbers (_x select 1));
    missionNamespace setVariable [(_x select 0), _code];
}
forEach
[
    ['ExileServer_CustomVehicles_CheckPosClear', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_CheckPosClear.sqf'],
    ['ExileServer_CustomVehicles_Initialise', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_Initialise.sqf'],
    ['ExileServer_CustomVehicles_SpawnVehicles', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_SpawnVehicles.sqf'],
	['ExileServer_CustomVehicles_FindRoads', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_FindRoads.sqf'],
	['ExileServer_CustomVehicles_MaintainVehicles', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_MaintainVehicles.sqf'],
	['ExileServer_CustomVehicles_FindPos', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_FindPos.sqf'],
	['ExileServer_CustomVehicles_ApplyDamage', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_ApplyDamage.sqf'],
	['ExileServer_CustomVehicles_AddLoot', 
        'custom_Vehicles\Code\ExileServer_CustomVehicles_AddLoot.sqf']	
];

format ["||BONES CUSTOM VEHICLE SPAWN||PreInit finished."] call ExileServer_util_log;