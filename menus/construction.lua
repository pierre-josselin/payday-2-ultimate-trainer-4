function UT.menus.construction()
    return {
        custom = true,
        title = "construction menu",
        button_list = {
            {text = "save", callback_func = UT.Construction.save},
            {
                open_menu = true,
                text = "load",
                callback_func = function()
                    local menu = {
                        custom = true,
                        title = "load",
                        button_list = {}
                    }
                    local constructions = UT.getConstructions()
                    local levelId = managers.job:current_level_id()
                    if not UT.checkTable(constructions[levelId]) then
                        UT.showMessage("no saves", UT.colors.warning)
                        return
                    end
                    for key, value in pairs(constructions[levelId]) do
                        table.insert(menu.button_list, {
                            text = value.name,
                            callback_func = UT.Construction.load,
                            callback_data = value.units,
                            close_button = true
                        })
                    end
                    table.insert(menu.button_list, {no_text = true, no_selection = true})
                    table.insert(menu.button_list, {text = "close", cancel_button = true})
                    UT.openMenu(menu)
                end
            },
            {
                open_menu = true,
                text = "delete",
                callback_func = function()
                    local menu = {
                        custom = true,
                        title = "delete",
                        button_list = {}
                    }
                    local constructions = UT.getConstructions()
                    local levelId = managers.job:current_level_id()
                    if not UT.checkTable(constructions[levelId]) then
                        UT.showMessage("no saves", UT.colors.warning)
                        return
                    end
                    for key, value in pairs(constructions[levelId]) do
                        table.insert(menu.button_list, {
                            open_menu = true,
                            text = value.name,
                            callback_func = function()
                                local menu = {
                                    custom = true,
                                    title = "confirmation",
                                    text = "Deletion is final. Continue ?",
                                    button_list = {
                                        {text = "yes", callback_func = UT.Construction.delete, callback_data = value.time, close_button = true},
                                        {text = "no", cancel_button = true}
                                    }
                                }
                                UT.openMenu(menu)
                            end
                        })
                    end
                    table.insert(menu.button_list, {no_text = true, no_selection = true})
                    table.insert(menu.button_list, {text = "close", cancel_button = true})
                    UT.openMenu(menu)
                end
            },
            {text = "clear", callback_func = UT.Construction.clear},
            {no_text = true, no_selection = true},
            {text = "toggle crosshair", callback_func = UT.Construction.toggleCrosshair},
            {no_text = true, no_selection = true},
            {text = "close", cancel_button = true},
        }
    }
end

UTMenuConstruction = true