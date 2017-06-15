# Exile-ClaimCrates

[![Arma 1.70](https://img.shields.io/badge/Arma-1.70-blue.svg)](https://dev.arma3.com/post/spotrep-00067) [![Exile 1.0.3 Lemon](https://img.shields.io/badge/Exile-1.0.3%20Lemon-C72651.svg)](http://www.exilemod.com/announcement/126-exile-103-lemon-has-dropped/)

This Exile server mod allows players to bulk-sell loot crates from DMS/Occupation missions.

The code is adapted from [Exile-ClaimVehicles](https://github.com/MezoPlays/Claim-Vehicles) by MezzoPlays/gianni001
The method used combines the idea of [TheSmoothOperator's R3F-WasteDumpOverride](https://github.com/TheSmoothOperator/R3F-WasteDumpOverride) with [this post](http://www.exilemod.com/topic/17848-release-r3f-waste-dump-override/?do=findComment&comment=147705) and makes it work. I don't use R3F on my server, so I needed another method. None of this code is "mine", I just mashed it together.

## NOTICE
This code is no longer maintained because I no longer have an active Arma server. It works as of the Arma/Exile/etc. components listed below. Feel free to fork this code and/or submit a pull request.

## Installation
* Make ```claimcrates_server.pbo``` using PBO Manager on the ```claimcrates_server``` folder
* Copy ```claimcrates_server.pbo``` into ```@exile_server\addons``` on the ArmA server
* Copy the "Custom" folder into the Exile mission.
* Add the following overrides into ```CfgExileCustomCode``` in the mission's ```config.cpp``` (eg. ```mpmissions\Exile.Altis\config.cpp```:
```cpp
    // sell crates
    ExileClient_gui_traderDialog_updateInventoryDropdown = "Custom\ExileClient_gui_traderDialog_updateInventoryDropdown.sqf";
    ExileClient_gui_wasteDumpDialog_show = "Custom\ExileClient_gui_wasteDumpDialog_show.sqf";
```
* Add the following interactions onto each crate type in ```CfgInteractionMenus``` in ```config.cpp```:
```cpp
            class ClaimCrate: ExileAbstractAction
            {
                title = "Claim Ownership";
                condition = "true";
                action = "call ExileClient_ClaimCrates_network_claimRequestSend";
            };
```
Example interaction code for an ```Exile_Container_SupplyBox```:
```cpp
    class SupplyBox
    {
        targetType = 2;
        target = "Exile_Container_SupplyBox";

        class Actions
        {
            class ClaimCrate: ExileAbstractAction
            {
                title = "Claim Ownership";
                condition = "true";
                action = "call ExileClient_ClaimCrates_network_claimRequestSend";
            };

            class Mount: ExileAbstractAction
            {
                title = "Mount";
                condition = "(isNull (attachedTo ExileClientInteractionObject)) && ((ExileClientInteractionObject getvariable ['ExileOwnerUID',1]) isEqualTo 1)";
                action = "_this call ExileClient_object_supplyBox_mount";
            };

            class Install: ExileAbstractAction
            {
                title = "Install";
                condition = "isNull (attachedTo ExileClientInteractionObject) && ((ExileClientInteractionObject getvariable ['ExileOwnerUID',1]) isEqualTo 1)";
                action = "_this call ExileClient_object_supplyBox_install";
            };

            class Unmount: ExileAbstractAction
            {
                title = "Unmount";
                condition = "!(isNull (attachedTo ExileClientInteractionObject)) && ((ExileClientInteractionObject getvariable ['ExileOwnerUID',1]) isEqualTo 1)";
                action = "_this call ExileClient_object_supplyBox_unmount";
            };
        };
    };
```

## Dependencies
* [Exile](http://www.exilemod.com/downloads/)
* [Defent's Mission System](https://github.com/Defent/DMS_Exile)

## Tested with these Exile mods
* Linux ArmA server
* Exile client/server 1.0.3
* DMS
* Occupation
* InfiSTAR
* ExAd
* Advanced Towing
* Advanced Sling Loading
* Advanced Rappelling
* Advanced Urban Rappelling
* Extended Base Mod
* Enigma's Revive
* Claim Vehicles

## Tools
* [PBO Manager](http://www.armaholic.com/page.php?id=16369)

## License
Apache 2.0 License
