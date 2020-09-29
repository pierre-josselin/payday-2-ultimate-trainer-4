UT.Driving = {}

UT.Driving.units = {}

local settings = UT.getSettings()
UT.Driving.packagesLoaded = settings.loadPackages

function UT.Driving.setPackagesLoading(value)
    local settings = UT.getSettings()
    settings.loadPackages = value
    UT.setSettings(settings)
    if value then
        UT.showMessage("packages loading enabled", UT.colors.enabled)
        if not UT.Driving.packagesLoaded then
            UT.showMessage(UT.messages.restartHeist, UT.colors.info)
        end
    else
        UT.showMessage("packages loading disabled", UT.colors.disabled)
    end
end

function UT.Driving.removeVehicles()
    if game_state_machine:current_state_name() == "ingame_driving" then
        managers.player:set_player_state("standard")
    end
    local count = 0
    for key, unit in pairs(UT.Driving.units) do
        if not alive(unit) then goto continue end
        unit:set_position(Vector3(0, 0, -10000))
        unit:set_rotation(Rotation(0, 0, 0))
        count = count + 1
        ::continue::
    end
    UT.Driving.units = {}
    UT.showMessage("removed " .. tostring(count) .. " vehicle" .. (count > 1 and "s" or ""), UT.colors.info)
end

function UT.Driving.spawnVehicle(id)
    if not UT.Driving.packagesLoaded then
        UT.showMessage("you must first load packages", UT.colors.error)
        return
    end
    if LuaNetworking:GetNumberOfPeers() > 0 then
        UT.showMessage("you must be alone in the game", UT.colors.error)
        return
    end
    local vehiclePosition = UT.getPlayerPosition()
    local vehicleRotation = UT.getCameraRotationFlat()
    local playerPosition = Vector3(vehiclePosition[1], vehiclePosition[2], vehiclePosition[3] + 350)
    local playerRotation = UT.getCameraRotation()
    local unit = UT.spawnUnit(Idstring(id), vehiclePosition, vehicleRotation)
    if not unit then return end
    UT.teleportation(playerPosition, playerRotation)
    table.insert(UT.Driving.units, unit)
end

UTClassDriving = true