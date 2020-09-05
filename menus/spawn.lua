function UT.menus.spawn()
    return {
        custom = true,
        title = "spawn menu",
        button_list = {
            {text = "enemies", callback_func = UT.Spawn.setModeEnemies},
            {text = "allies", callback_func = UT.Spawn.setModeAllies},
            {text = "civilians", callback_func = UT.Spawn.setModeCivilians},
            {text = "loots", callback_func = UT.Spawn.setModeLoots},
            {text = "equipments", callback_func = UT.Spawn.setModeEquipments},
            {text = "packages", callback_func = UT.Spawn.setModePackages},
            {no_text = true, no_selection = true},
            {text = "remove npcs", callback_func = UT.Spawn.removeNPCs},
            {text = "remove loots", callback_func = UT.Spawn.removeLoots},
            {text = "remove equipments", callback_func = UT.Spawn.removeEquipments},
            {text = "remove packages", callback_func = UT.Spawn.removePackages},
            {text = "dispose corpses", callback_func = UT.Spawn.disposeCorpses},
            {no_text = true, no_selection = true},
            {
                text = "set spawn position",
                open_menu = {
                    custom = true,
                    title = "set spawn position",
                    button_list = {
                        {text = "spawn on crosshair", callback_func = UT.Spawn.setPosition, callback_data = "crosshair", close_button = true},
                        {text = "spawn on self", callback_func = UT.Spawn.setPosition, callback_data = "self", close_button = true},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {no_text = true, no_selection = true},
            {text = "close", cancel_button = true},
        }
    }
end

UTMenuSpawn = true