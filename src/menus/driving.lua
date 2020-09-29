function UT.menus.driving()
    local menu = {
        custom = true,
        title = "driving menu",
        text = "Packages are " .. (UT.Driving.packagesLoaded and "loaded" or "not loaded"),
        button_list = {}
    }
    local settings = UT.getSettings()
    table.insert(menu.button_list, {
        text = (settings.loadPackages and "disable" or "enable") .. " packages loading",
        callback_func = UT.Driving.setPackagesLoading,
        callback_data = not settings.loadPackages,
        close_button = true
    })
    table.insert(menu.button_list, {text = "remove vehicles", callback_func = UT.Driving.removeVehicles})
    table.insert(menu.button_list, {no_text = true, no_selection = true})
    for key, value in pairs(UT.Tables.vehicles) do
        table.insert(menu.button_list, {
            text = string.sub(UT.getFilename(value), 13, -3),
            callback_func = UT.Driving.spawnVehicle,
            callback_data = value
        })
    end
    table.insert(menu.button_list, {no_text = true, no_selection = true})
    table.insert(menu.button_list, {text = "close", cancel_button = true})
    return menu
end

UTMenuDriving = true