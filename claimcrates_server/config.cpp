class CfgPatches
{
	class ClaimCrates_Server
	{
		requiredVersion=0.1;
		requiredAddons[]=
		{
			"exile_client",
			"exile_assets",
			"exile_server_config"
		};
		units[]={};
		weapons[]={};
		magazines[]={};
		ammo[]={};
	};
};
class CfgFunctions
{
	class ClaimCrates_Server
	{
		class Bootstrap
		{
			file="ClaimCrates_Server\bootstrap";
			class preInit
			{
				preInit=1;
			};
			class postInit
			{
				postInit=1;
			};
		};
	};
};
class CfgNetworkMessages
{
	class claimCrateRequest
	{
		module="ClaimCrates";
		parameters[]=
		{
			"STRING"
		};
	};
};
