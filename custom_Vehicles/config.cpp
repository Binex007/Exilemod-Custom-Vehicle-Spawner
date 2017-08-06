class CfgPatches
{
	class custom_Vehicles 
	{
	requiredVersion = 0.1;
	requiredAddons[] = {"exile_server"};
	units[] = {};
	weapons[] = {};
	};
};

class CfgFunctions 
{
	class custom_Vehicles 
	{
		class main 
		{
			file = "custom_Vehicles\Bootstrap";
			class preinit
			{
				preinit = 1;
			}
			class postinit 
			{
				postInit = 1;
			};
		};
	};
};