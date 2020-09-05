if not UT.Time.environment then
    do return end
end

if not Utils:IsInGameState() then
    do return end
end

if not Utils:IsInHeist() then
    do return end
end

if not managers.viewport then
    do return end
end

local environment = managers.environment_controller._vp._env_handler._path
--local environment = managers.viewport:first_active_viewport():get_environment_path()

if not environment then
    do return end
end

if UT.Time.environment == environment then
    do return end
end

managers.viewport:first_active_viewport():set_environment(UT.Time.environment)