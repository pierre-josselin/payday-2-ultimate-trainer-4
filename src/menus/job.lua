function UT.menus.job()
    local menu1 = {
        custom = true,
        title = "job menu",
        button_list = {}
    }
    for key, value in pairs(UT.Tables.jobs) do
        local contact = (value[1] == "escapes") and "escapes" or managers.localization:text(value[1])
        local menu2 = {
            custom = true,
            title = contact,
            button_list = {}
        }
        for key, value in pairs(value[2]) do
            if type(value[1]) == "string" then
                local job = managers.localization:text(value[1])
                local menu3 = {
                    custom = true,
                    title = job,
                    button_list = {}
                }
                for key, value in pairs(value[2]) do
                    table.insert(menu3.button_list, {
                        text = managers.localization:text(value.name),
                        callback_func = function() UT.Job.createLobby(value.job, value.level, value.day) end,
                        close_button = true
                    })
                end
                table.insert(menu3.button_list, {no_text = true, no_selection = true})
                table.insert(menu3.button_list, {text = "close", cancel_button = true})
                table.insert(menu2.button_list, {
                    text = job,
                    open_menu = menu3
                })
            else
                table.insert(menu2.button_list, {
                    text = managers.localization:text(value.name),
                    callback_func = function() UT.Job.createLobby(value.job, value.level) end,
                    close_button = true
                })
            end
        end
        table.insert(menu2.button_list, {no_text = true, no_selection = true})
        table.insert(menu2.button_list, {text = "close", cancel_button = true})
        table.insert(menu1.button_list, {
            text = contact,
            open_menu = menu2
        })
    end
    table.insert(menu1.button_list, {no_text = true, no_selection = true})
    table.insert(menu1.button_list, {text = "close", cancel_button = true})
    return menu1
end

UTMenuJob = true