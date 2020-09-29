_G.CloneClass(BootupState)
function BootupState:at_enter()
    BootupState.orig.at_enter(self)
    
    local settings = UT.getSettings()
    if settings.initialized ~= UT.version then
        local bltData = UT.getBltData()
        bltData.keybinds = {}
        for key, value in pairs(UT.keybinds) do
            table.insert(bltData.keybinds, value)
        end
        settings.initialized = UT.version
        local result1 = UT.setBltData(bltData)
        local result2 = UT.setSettings(settings)
        if not result1 or not result2 then
            do return end
        end
        local text = ""
        text = text .. "FIRST LAUNCH\n"
        text = text .. "Keys have been successfully binded.\n"
        text = text .. "Please restart the game."
        local menu = {
            custom = true,
            title = "ultimate trainer " .. UT.version,
            text = text,
            button_list = {
                {text = "exit", callback_func = os.exit},
            }
        }
        UT.openMenu(menu)
    end
    
    UT.Updater.checkUpdate()
end