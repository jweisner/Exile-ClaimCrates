/**
 * ExileClient_gui_wasteDumpDialog_show
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_nearVehicles","_localVehicles","_display","_revenue","_sellButton","_dropdown","_vehicleObject","_vehicleName","_index"];
disableSerialization;
_nearVehicles = nearestObjects [player, ["LandVehicle", "Air", "Ship",
	"Box_NATO_WpsSpecial_F","Box_NATO_Ammo_F","Box_NATO_Uniforms_F","Box_East_Wps_F",
	"Exile_Container_Storagecrate","Exile_Container_SupplyBox","Box_IND_Support_F","Box_East_Support_F",
	"Land_CargoBox_V1_F","Box_IND_Wps_F","Box_FIA_Ammo_F","CargoNet_01_box_F","Box_Syndicate_Wps_F",
	"Box_NATO_AmmoVeh_F","B_supplyCrate_F","Box_NATO_Wps_F","C_supplyCrate_F","C_T_supplyCrate_F",
	"IG_supplyCrate_F","Box_IND_AmmoVeh_F","I_SupplyCrate_F","Box_FIA_Wps_F","Box_Syndicate_Ammo_F",
	"Box_Syndicate_WpsLaunch_F","Box_IED_Exp_F","Box_NATO_Equip_F","Box_GEN_Equip_F","Box_AAF_Equip_F",
	"Box_CSAT_Equip_F","Box_AAF_Uniforms_F","Box_CSAT_Uniforms_F","Box_FIA_Support_F","Box_T_East_Ammo_F",
	"Box_T_East_Wps_F","Box_T_East_WpsSpecial_F","Box_T_NATO_Wps_F","Box_T_NATO_WpsSpecial_F",
	"Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F","Box_IND_WpsLaunch_F",
	"Box_NATO_WpsLaunch_F","Box_East_AmmoVeh_F","Box_IND_WpsSpecial_F","Land_Box_AmmoOld_F",
	"O_supplyCrate_F","I_supplyCrate_F","B_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","I_CargoNet_01_ammo_F",
	"Land_MetalCase_01_large_F","Land_MetalCase_01_small_F","Box_East_Grenades_F","Box_IND_Grenades_F",
	"Box_East_Ammo_F","Box_IND_Ammo_F","Box_East_AmmoOrd_F","Box_IND_AmmoOrd_F","Box_East_WpsLaunch_F"], 150];
_localVehicles = [];
{
	if (local _x) then
	{
		if (alive _x) then
		{
			_localVehicles pushBack _x;
		};
	};
}
forEach _nearVehicles;
	
if (_localVehicles isEqualTo []) exitWith
{
	["ErrorTitleAndText", ["Whoops!", "No crates or vehicles within 50m. Get in as driver first for vehicles."]] call ExileClient_gui_toaster_addTemplateToast;
};
ExileClientCurrentTrader = _this;
createDialog "RscExileWasteDumpDialog";
waitUntil { !isNull findDisplay 24011 };
_display = uiNameSpace getVariable ["RscExileWasteDumpDialog", displayNull];
_revenue = _display displayCtrl 4001;
_revenue ctrlSetStructuredText (parseText "<t size='1.4'>0<img image='\exile_assets\texture\ui\poptab_notification_ca.paa' size='1' shadow='true' /></t>");
_sellButton = _display displayCtrl 4000;
_sellButton ctrlEnable false;
_dropdown = _display displayCtrl 4002;
lbClear _dropdown;
{
	_vehicleObject = _x;
	_vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicleObject) >> "displayName");
	if (_vehicleObject isKindOf "AIR" || _vehicleObject isKindOf "CAR" || _vehicleObject isKindOf "TANK") then
    {
		_index = _dropdown lbAdd (format ["Cargo: %1", _vehicleName]);
		_dropdown lbSetData [_index, netId _vehicleObject];
		_dropdown lbSetValue [_index, 1];
		_index = _dropdown lbAdd (format ["Vehicle + Cargo: %1", _vehicleName]);
		_dropdown lbSetData [_index, netId _vehicleObject];
		_dropdown lbSetValue [_index, 2];
	}
	else // object is a crate, sell only crate + cargo
	{
		_index = _dropdown lbAdd (format ["Crate contents: %1", _vehicleName]);
		_dropdown lbSetData [_index, netId _vehicleObject];
		_dropdown lbSetValue [_index, 2];
	}; 
}
forEach _localVehicles;
true call ExileClient_gui_postProcessing_toggleDialogBackgroundBlur;
true