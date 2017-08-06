
format ["||BONES CUSTOM VEHICLE SPAWN||PostInit started..."] call ExileServer_util_log;

call compile preprocessFileLineNumbers "custom_vehicles\config.sqf";

[] call ExileServer_CustomVehicles_initialise;

format ["||BONES CUSTOM VEHICLE SPAWN||PostInit finished."] call ExileServer_util_log;