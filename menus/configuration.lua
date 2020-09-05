function UT.menus.configuration()
    local settings = UT.getSettings()
    return {
        custom = true,
        title = "configuration",
        button_list = {
            {
                text = (settings.DLCUnlocker and "disable" or "enable") .. " dlc unlocker",
                callback_func = UT.Configuration.setDLCUnlocker,
                callback_data = not settings.DLCUnlocker,
                close_button = true
            },
            {no_text = true, no_selection = true},
            {text = "close", cancel_button = true},
        }
    }
end

UTMenuConfiguration = true