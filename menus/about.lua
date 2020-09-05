function UT.menus.about()
    return {
        custom = true,
        title = "about",
        text = UT.about,
        button_list = {
            {text = "close", cancel_button = true}
        }
    }
end

UTMenuAbout = true