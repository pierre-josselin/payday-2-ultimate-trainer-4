function UT.menus.time()
    return {
        custom = true,
        title = "time menu",
        button_list = {
            {text = "default", callback_func = UT.Time.reset},
            {no_text = true, no_selection = true},
            {text = "early morning", callback_func = UT.Time.set, callback_data = "environments/pd2_env_hox_02/pd2_env_hox_02"},
            {text = "morning", callback_func = UT.Time.set, callback_data = "environments/pd2_env_morning_02/pd2_env_morning_02"},
            {text = "mid day", callback_func = UT.Time.set, callback_data = "environments/pd2_env_mid_day/pd2_env_mid_day"},
            {text = "afternoon", callback_func = UT.Time.set, callback_data = "environments/pd2_env_afternoon/pd2_env_afternoon"},
            {text = "night", callback_func = UT.Time.set, callback_data = "environments/pd2_env_n2/pd2_env_n2"},
            {text = "misty night", callback_func = UT.Time.set, callback_data = "environments/pd2_env_arm_hcm_02/pd2_env_arm_hcm_02"},
            {text = "foggy night", callback_func = UT.Time.set, callback_data = "environments/pd2_env_foggy_bright/pd2_env_foggy_bright"},
            {no_text = true, no_selection = true},
            {text = "close", cancel_button = true}
        }
    }
end

UTMenuTime = true