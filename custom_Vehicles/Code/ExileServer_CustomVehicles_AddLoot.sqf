if (!isServer) exitWith {};
private ["_vehicle", "_vehicleItemsAllowed", "_maximumItemsPerVehicle", "_allowedItems", "_itemsAdded", "_itemsPerVehicle", "_itemAdd", "_cargoType"];
_vehicle = (_this select 0);
_vehicleItemsAllowed = (_this select 1);
_maximumItemsPerVehicle = (_this select 2);
_allowedItems = (_this select 3);

if (_vehicleItemsAllowed isEqualTo 1) then {
        format ["||BONES CUSTOM VEHICLE SPAWN||Loot Allowed"] call ExileServer_util_log;
		_itemsAdded = 0;
        _itemsPerVehicle = floor (random _maximumItemsPerVehicle);
		format ["||BONES CUSTOM VEHICLE SPAWN||Adding %1 Loot Items",_itemsPerVehicle] call ExileServer_util_log;
        while{_itemsAdded < _itemsPerVehicle} do {
          _itemAdd = _allowedItems select (floor (random (count _allowedItems)));
         _vehicle addItemCargoGlobal [_itemAdd, 1];
          _itemsAdded = _itemsAdded + 1;
		  };
          format ["||BONES CUSTOM VEHICLE SPAWN||Loot items added"] call ExileServer_util_log;
        };