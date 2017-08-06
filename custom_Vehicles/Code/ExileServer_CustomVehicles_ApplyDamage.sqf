private ["_chanceWheel", "_vehicleObject", "_wheels", "_vehicleDamage", "_fuelAmount", "_wheelDamage"];

_chanceDmg = (_this select 0);
_objectsToDamage = (_this select 1);
_vehicleObject = (_this select 2);
_vehicleDamage = (_this select 3);
_fuelAmount = (_this select 4);

_vehicleObject setDamage _vehicleDamage;
_vehicleObject setFuel _fuelAmount;		
{
	_Damage = if (Random 1 < _chanceDmg) then {0} else {1};
	_vehicleObject setHitPointDamage [_x,_Damage];
} forEach _objectsToDamage;

true