UT.Configuration = {}

function UT.Configuration.setDLCUnlocker(value)
    local settings = UT.getSettings()
    settings.DLCUnlocker = value
    UT.setSettings(settings)
    if value then
        UT.showMessage("dlc unlocker enabled", UT.colors.enabled)
    else
        UT.showMessage("dlc unlocker disabled", UT.colors.disabled)
    end
    UT.showMessage(UT.messages.restartGame, UT.colors.info)
end

UTClassConfiguration = true