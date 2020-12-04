function UT.menus.player()
    return {
        custom = true,
        title = "player menu",
        button_list = {
            {
                text = "level menu",
                open_menu = {
                    custom = true,
                    title = "level menu",
                    button_list = {
                        {text = "set level 0", callback_func = UT.Player.setLevel, callback_data = 0},
                        {text = "set level 25", callback_func = UT.Player.setLevel, callback_data = 25},
                        {text = "set level 50", callback_func = UT.Player.setLevel, callback_data = 50},
                        {text = "set level 75", callback_func = UT.Player.setLevel, callback_data = 75},
                        {text = "set level 100", callback_func = UT.Player.setLevel, callback_data = 100},
                        {no_text = true, no_selection = true},
                        {text = "set infamy rank v", callback_func = UT.Player.setInfamyRank, callback_data = 5},
                        {text = "set infamy rank x", callback_func = UT.Player.setInfamyRank, callback_data = 10},
                        {text = "set infamy rank xv", callback_func = UT.Player.setInfamyRank, callback_data = 15},
                        {text = "set infamy rank xx", callback_func = UT.Player.setInfamyRank, callback_data = 20},
                        {text = "set infamy rank xxv", callback_func = UT.Player.setInfamyRank, callback_data = 25},
                        {text = "set infamy rank lxv", callback_func = UT.Player.setInfamyRank, callback_data = 65},
                        {text = "set infamy rank c", callback_func = UT.Player.setInfamyRank, callback_data = 100},
                        {text = "set infamy rank d", callback_func = UT.Player.setInfamyRank, callback_data = 500},
                        {text = "reset infamy rank", callback_func = UT.Player.setInfamyRank, callback_data = 0},
                        {no_text = true, no_selection = true},
                        {text = "add 1.000.000 xp", callback_func = UT.Player.addExperience, callback_data = 1000000},
                        {text = "add 10.000.000 xp", callback_func = UT.Player.addExperience, callback_data = 10000000},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {
                text = "skill menu",
                open_menu = {
                    custom = true,
                    title = "skill menu",
                    button_list = {
                        {text = "set total skill points to 120", callback_func = UT.Player.setSkillPoints, callback_data = 120},
                        {text = "set total skill points to 690", callback_func = UT.Player.setSkillPoints, callback_data = 690},
                        {text = "reset skill points hack", callback_func = UT.Player.resetSkillPoints},
                        {no_text = true, no_selection = true},
                        {text = "add 13700 perk points", callback_func = UT.Player.addPerkPoints, callback_data = 13700},
                        {text = "add 287700 perk points", callback_func = UT.Player.addPerkPoints, callback_data = 287700},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {
                text = "money menu",
                open_menu = {
                    custom = true,
                    title = "money menu",
                    button_list = {
                        {text = "add 10.000.000 $", callback_func = UT.Player.addMoney, callback_data = 10000000},
                        {text = "add 100.000.000 $", callback_func = UT.Player.addMoney, callback_data = 100000000},
                        {text = "add 1.000.000.000 $", callback_func = UT.Player.addMoney, callback_data = 1000000000},
                        {text = "add 10.000.000.000 $", callback_func = UT.Player.addMoney, callback_data = 10000000000},
                        {text = "add 100.000.000.000 $", callback_func = UT.Player.addMoney, callback_data = 100000000000},
                        {text = "reset money", callback_func = UT.Player.resetMoney},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {
                text = "inventory menu",
                open_menu = {
                    custom = true,
                    title = "inventory menu",
                    button_list = {
                        {text = "add all items", callback_func = UT.Player.addAllItems},
                        {text = "reset all items", callback_func = UT.Player.resetAllItems},
                        {no_text = true, no_selection = true},
                        {text = "add all weapon mods", callback_func = UT.Player.addItems, callback_data = "weapon_mods"},
                        {text = "add all masks", callback_func = UT.Player.addItems, callback_data = "masks"},
                        {text = "add all materials", callback_func = UT.Player.addItems, callback_data = "materials"},
                        {text = "add all textures", callback_func = UT.Player.addItems, callback_data = "textures"},
                        {text = "add all colors", callback_func = UT.Player.addItems, callback_data = "colors"},
                        {no_text = true, no_selection = true},
                        {text = "reset weapon mods", callback_func = UT.Player.resetItems, callback_data = "weapon_mods"},
                        {text = "reset masks", callback_func = UT.Player.resetItems, callback_data = "masks"},
                        {text = "reset materials", callback_func = UT.Player.resetItems, callback_data = "materials"},
                        {text = "reset textures", callback_func = UT.Player.resetItems, callback_data = "textures"},
                        {text = "reset colors", callback_func = UT.Player.resetItems, callback_data = "colors"},
                        {no_text = true, no_selection = true},
                        {text = "unlock all weapons", callback_func = UT.Player.unlockAllWeapons},
                        {text = "unlock all slots", callback_func = UT.Player.setAllSlots, callback_data = true},
                        {text = "lock all slots", callback_func = UT.Player.setAllSlots, callback_data = false},
                        {no_text = true, no_selection = true},
                        {text = "remove exclamation marks", callback_func = UT.Player.removeExclamationMarks},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {
                text = "continental coins menu",
                open_menu = {
                    custom = true,
                    title = "continental coins menu",
                    button_list = {
                        {text = "add 10 continental coins", callback_func = UT.Player.addContinentalCoins, callback_data = 10},
                        {text = "add 50 continental coins", callback_func = UT.Player.addContinentalCoins, callback_data = 50},
                        {text = "add 100 continental coins", callback_func = UT.Player.addContinentalCoins, callback_data = 100},
                        {text = "add 500 continental coins", callback_func = UT.Player.addContinentalCoins, callback_data = 500},
                        {text = "add 1000 continental coins", callback_func = UT.Player.addContinentalCoins, callback_data = 1000},
                        {text = "reset continental coins", callback_func = UT.Player.resetContinentalCoins},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {
                text = "achievement menu",
                open_menu = {
                    custom = true,
                    title = "achievement menu",
                    button_list = {
                        {text = "unlock all steam achievements", callback_func = UT.Player.unlockAllAchievments},
                        {text = "lock all steam achievements", callback_func = UT.Player.lockAllAchievments},
                        {no_text = true, no_selection = true},
                        {text = "close", cancel_button = true}
                    }
                }
            },
            {no_text = true, no_selection = true},
            {text = "close", cancel_button = true}
        }
    }
end

UTMenuPlayer = true
