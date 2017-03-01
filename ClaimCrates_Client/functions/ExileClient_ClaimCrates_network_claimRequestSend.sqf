/*

 	Name: ExileClient_ClaimCrates_network_claimRequestSend.sqf

 	Author: Pb_Magnet
            MezoPlays
    Copyright (c) 2017 Pb_Magnet

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0

*/
_object = cursorTarget;
_crateObj = _object;
_objectNetId = netId _object;
_object = typeOf _object;

try
{
    if (_object isKindOf "AIR" || _object isKindOf "CAR" || _object isKindOf "TANK") then
    {
        throw "That's not a crate... derp!";
    };

    if (ExilePlayerInSafezone) then
    {
        throw "You can't claim crates inside a safe zone. This is to prevent shenanigans."
    };

    ["claimCrateRequest",[_objectNetId]] call ExileClient_system_network_send;
}
catch
{
    ["ErrorTitleAndText", ["Claim Crate", _exception]] call ExileClient_gui_toaster_addTemplateToast;
};
