function UT.menus.game()
    return {
        custom = true,
        title = "game menu",
        button_list = {
            {
                text = "player state menu",
                open_menu = {
                    custom = true,
                    title = "player state menu",
                    button_list = {
                        {text = "civilian", callback_func = UT.Game.setPlayerState, callback_data = "civilian"},
                        {text = "mask off", callback_func = UT.Game.setPlayerState, callback_data = "mask_off"},
                        {text = "standard", callback_func = UT.Game.setPlayerState, callback_data = "standard"},
                        {text = "handcuffed", callback_func = UT.Game.setPlayerState, callback_data = "arrested"},
                        {text = "electrified", callback_func = UT.Game.setPlayerState, callback_data = "tased"},
                        {text = "incapacitated", callback_func = UT.Game.setPlayerState, callback_data = "incapacitated"},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {text = "access cameras", callback_func = UT.Game.accessCameras, close_button = true},
            {text = "remove invisible walls", callback_func = UT.Game.removeInvisibleWalls, host = true},
            {text = "trigger the alarm", callback_func = UT.Game.triggerAlarm, host = true},
            {no_text = true, no_selection = true},
            {text = "god mode toggle", callback_func = UT.Game.toggleGodMode},
            {text = "overkill mode toggle", callback_func = UT.Game.toggleOverkillMode},
            {text = "flight mode toggle", callback_func = UT.Game.toggleFlightMode},
            {text = "disable ai toggle", callback_func = UT.Game.toggleDisableAI, host = true},
            {text = "instant drilling toggle", callback_func = UT.Game.toggleInstantDrilling, host = true},
            {text = "prevent alarm triggering toggle", callback_func = UT.Game.togglePreventAlarmTriggering, host = true},
            {no_text = true, no_selection = true},
            {text = "close", cancel_button = true}
        }
    }
end

UTMenuGame = true