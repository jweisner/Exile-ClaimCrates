/*
    Insert this into CfgExileCustomCode
*/
    // sell crates
    ExileClient_gui_traderDialog_updateInventoryDropdown = "Custom\ExileClient_gui_traderDialog_updateInventoryDropdown.sqf";
    ExileClient_gui_wasteDumpDialog_show = "Custom\ExileClient_gui_wasteDumpDialog_show.sqf";

/*
    Insert this action into all crate objects in CfgInteractionMenus
        
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
            ...
        };
    };
*/
            class ClaimCrate: ExileAbstractAction
            {
                title = "Claim Ownership";
                condition = "true";
                action = "call ExileClient_ClaimCrates_network_claimRequestSend";
            };

