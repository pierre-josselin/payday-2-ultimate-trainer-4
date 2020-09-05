function UT.menus.main()
    return {
        custom = true,
        title = "ultimate trainer " .. UT.version,
        text = "By ChildOfSorrow",
        button_list = {
            {text = "documentation", callback_func = UT.documentation},
            {text = "configuration", open_menu = UT.menus.configuration()},
            {text = "about", open_menu = UT.menus.about()},
            {no_text = true, no_selection = true},
            {text = "job menu", open_menu = UT.menus.job(), out_game = true},
            {text = "player menu", open_menu = UT.menus.player()},
            {text = "game menu", open_menu = UT.menus.game(), in_game = true},
            {text = "time menu", open_menu = UT.menus.time()},
            {text = "spawn menu", open_menu = UT.menus.spawn(), host = true, in_game = true},
            {text = "driving menu", open_menu = UT.menus.driving(), host = true, in_game = true},
            {text = "construction menu", open_menu = UT.menus.construction(), host = true, in_game = true},
            {no_text = true, no_selection = true},
            {text = "close", cancel_button = true},
        }
    }
end

UTMenuMain = true