UT.Time = {}

local settings = UT.getSettings()
UT.Time.environment = settings.time

function UT.Time.set(environment)
    UT.Time.environment = environment
    local settings = UT.getSettings()
    settings.time = environment
    UT.setSettings(settings)
    UT.showMessage("time set", UT.colors.info)
end

function UT.Time.reset()
    UT.Time.set(nil)
    if Utils:IsInHeist() then
        UT.showMessage(UT.messages.restartHeist, UT.colors.info)
    end
end

UTClassTime = true