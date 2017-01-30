/*

 	Name: ExileServer_ClaimVehicle_network_InsertClaimedVehicle.sqf

 	Author: Pb_Magnet
            MezoPlays
    Copyright (c) 2017 Pb_Magnet

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0

*/
private["_sessionID","_package","_objectNetID","_ownerUID","_crate"];
_sessionID = _this select 0;
_package = _this select 1;
_objectNetID = _package select 0;

_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
_ownerUID = getPlayerUID _playerObject;
_crate = objectFromNetId _objectNetID;

try
{
    if !(alive _playerObject) then
    {
        throw "You must be alive to claim a crate!";
    };
    if (_crate isKindOf "AIR" || _crate isKindOf "CAR" || _crate isKindOf "TANK") then
    {
        throw "That's not a crate!";
    };

    _crate setVariable ["ExileOwnerUID", _ownerUID];
    _crate setOwner (owner _playerObject);

    [_sessionID, "toastRequest", ["SuccessTitleOnly", ["You're now the owner of this crate!"]]] call ExileServer_system_network_send_to;

}
catch
{
    [_sessionID, "toastRequest", ["ErrorTitleAndText", ["Claim Crate", _exception]]] call ExileServer_system_network_send_to;
};
