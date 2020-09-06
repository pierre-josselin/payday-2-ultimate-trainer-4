UT.Spawn = {}

UT.Spawn.available = {}
UT.Spawn.position = "crosshair"

function UT.Spawn.setMode(mode)
    UT.Spawn.index = 1
    UT.Spawn.mode = mode
    UT.showMessage("spawn mode set to " .. mode, UT.colors.info)
end

function UT.Spawn.setModeEnemies()
    UT.Spawn.setMode("enemies")
end

function UT.Spawn.setModeAllies()
    _G.CloneClass(PlayerManager)
    function PlayerManager:upgrade_value(category, upgrade, default)
        if category == "player" and upgrade == "convert_enemies" then
            return true
        elseif category == "player" and upgrade == "convert_enemies_max_minions" then
            return 1000000
        else
            return PlayerManager.orig.upgrade_value(self, category, upgrade, default)
        end
    end
    UT.Spawn.setMode("allies")
end

function UT.Spawn.setModeCivilians()
    UT.Spawn.available.civilians = {}
    for key, value in pairs(UT.Tables.civilians) do
        if not UT.unitLoaded(Idstring(value)) then goto continue end
        table.insert(UT.Spawn.available.civilians, value)
        ::continue::
    end
    if not UT.checkTable(UT.Spawn.available.civilians) then
        UT.showMessage("no civilians available here", UT.colors.error)
        return
    end
    UT.Spawn.setMode("civilians")
end

function UT.Spawn.setModeLoots()
    UT.Spawn.available.loots = {}
    for key, value in pairs(UT.Tables.loots) do
        if not UT.unitLoaded(Idstring(value)) then goto continue end
        table.insert(UT.Spawn.available.loots, value)
        ::continue::
    end
    if not UT.checkTable(UT.Spawn.available.loots) then
        UT.showMessage("no loots available here", UT.colors.error)
        return
    end
    UT.Spawn.setMode("loots")
end

function UT.Spawn.setModeEquipments()
    UT.Spawn.available.equipments = {}
    for key, value in pairs(UT.Tables.equipments) do
        table.insert(UT.Spawn.available.equipments, value)
    end
    UT.Spawn.setMode("equipments")
end

function UT.Spawn.setModePackages()
    UT.Spawn.available.packages = {}
    for key, value in pairs(UT.Tables.packages) do
        table.insert(UT.Spawn.available.packages, value)
    end
    function tweak_data.gage_assignment:get_num_assignment_units()
        return 1000000
    end
    UT.Spawn.setMode("packages")
end

function UT.Spawn.setModeBags()
    local message = "Your game may crash if another player pick up a bag that doesn't exist in this level."
    managers.chat:_receive_message(1, "Ultimate Trainer", message, UT.colors.danger)
    UT.Spawn.setMode("bags")
end

function UT.Spawn.spawnEnemy(id)
    local position = UT.Spawn.getPosition()
    if not position then return end
    local rotation = UT.getCameraRotationFlat()
    local unit = UT.spawnUnit(Idstring(id), position, rotation)
    if not unit then return end
    UT.Spawn.setTeam(unit, "combatant")
end

function UT.Spawn.spawnAlly(id)
    local position = UT.Spawn.getPosition()
    if not position then return end
    local rotation = UT.getCameraRotationFlat()
    local unit = UT.spawnUnit(Idstring(id), position, rotation)
    if not unit then return end
    UT.Spawn.setTeam(unit, "combatant")
    UT.Spawn.convertEnemy(unit)
end

function UT.Spawn.spawnCivilian(id)
    local position = UT.Spawn.getPosition()
    if not position then return end
    local rotation = UT.getCameraRotationFlat()
    local unit = UT.spawnUnit(Idstring(id), position, rotation)
    if not unit then return end
    UT.Spawn.setTeam(unit, "non_combatant")
    unit:brain():action_request({
        type = "act",
        variant = "cm_sp_stand_idle"
    })
end

function UT.Spawn.spawnLoot(name)
    local position = UT.Spawn.getPosition()
    if not position then return end
    local rotation = UT.getCameraRotationFlat()
    UT.spawnUnit(Idstring(name), position, rotation)
end

function UT.Spawn.spawnEquipment(name)
    local position = UT.Spawn.getPosition()
    if not position then return end
    local rotation = UT.getCameraRotationFlat()
    if name == "ammo_bag" then
        AmmoBagBase.spawn(position, rotation, 1)
    elseif name == "doctor_bag" then
        DoctorBagBase.spawn(position, rotation, 4)
    elseif name == "first_aid_kit" then
        FirstAidKitBase.spawn(position, rotation, 1)
    elseif name == "body_bags_bag" then
        BodyBagsBagBase.spawn(position, rotation)
    elseif name == "grenade_crate" then
        GrenadeCrateBase.spawn(position, rotation)
    elseif name == "trip_mine" then
        if UT.Spawn.position == "crosshair" then
            local crosshairRay = Utils:GetCrosshairRay()
            if not crosshairRay then return end
            rotation = Rotation(crosshairRay.normal, math.UP)
        elseif UT.Spawn.position == "self" then
            rotation = Rotation(UT.getCameraRotation():yaw(), 90, 0)
        end
        local unit = TripMineBase.spawn(position, rotation, true)
        if not unit then return end
        local playerUnit = managers.player:player_unit()
        unit:base():set_active(true, playerUnit)
    elseif name == "sentry_gun" then
        UT.Spawn.setEquipment("sentry_gun")
        local playerUnit = managers.player:player_unit()
        local unit = SentryGunBase.spawn(playerUnit, position, rotation)
        if not unit then return end
        managers.network:session():send_to_peers_synched("from_server_sentry_gun_place_result", 1, 0, unit, 2, 2, true, 2)
    end
end

function UT.Spawn.spawnPackage(id)
    local position = UT.Spawn.getPosition()
    if not position then return end
    local rotation = UT.getCameraRotationFlat()
    UT.spawnUnit(Idstring(id), position, rotation)
end

function UT.Spawn.spawnBag(name)
    local position = UT.getCameraPosition()
    local rotation = UT.getCameraRotation()
    local forward = UT.getCameraForward()
    managers.player:server_drop_carry(name, managers.money:get_bag_value(name), true, true, 1, position, rotation, forward, 100, nil, nil)
end

function UT.Spawn.removeNPCs()
    local units = {}
    for key, value in pairs(managers.enemy:all_civilians()) do
        table.insert(units, value.unit)
    end
    for key, value in pairs(managers.enemy:all_enemies()) do
        if value.unit:brain()._attention_handler._team.id == "neutral1" then
            goto continue
        end
        table.insert(units, value.unit)
        ::continue::
    end
    local count = UT.removeUnits(units)
    UT.showMessage("removed " .. tostring(count) .. " npc" .. (count > 1 and "s" or ""), UT.colors.info)
end

function UT.Spawn.removeLoots()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then goto continue end
        if not UT.Tables.loots[unit:name():key()] then goto continue end
        table.insert(units, unit)
        ::continue::
    end
    local count = UT.removeUnits(units)
    UT.showMessage("removed " .. tostring(count) .. " loot" .. (count > 1 and "s" or ""), UT.colors.info)
end

function UT.Spawn.removeEquipments()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then goto continue end
        if not UT.Tables.equipments[unit:name():key()] then goto continue end
        table.insert(units, unit)
        ::continue::
    end
    local count = UT.removeUnits(units)
    UT.showMessage("removed " .. tostring(count) .. " equipment" .. (count > 1 and "s" or ""), UT.colors.info)
end

function UT.Spawn.removePackages()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then goto continue end
        if not UT.Tables.packages[unit:name():key()] then goto continue end
        table.insert(units, unit)
        ::continue::
    end
    local count = UT.removeUnits(units)
    UT.showMessage("removed " .. tostring(count) .. " package" .. (count > 1 and "s" or ""), UT.colors.info)
end

function UT.Spawn.removeBags()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then goto continue end
        if not UT.Tables.bagsKeys[unit:name():key()] then goto continue end
        table.insert(units, unit)
        ::continue::
    end
    local count = UT.removeUnits(units)
    UT.showMessage("removed " .. tostring(count) .. " bag" .. (count > 1 and "s" or ""), UT.colors.info)
end

function UT.Spawn.disposeCorpses()
    managers.enemy:dispose_all_corpses()
    UT.showMessage("corpses disposed", UT.colors.info)
end

function UT.Spawn.getPosition()
    if UT.Spawn.position == "crosshair" then
        local crosshairRay = Utils:GetCrosshairRay()
        if not crosshairRay then
            UT.showMessage("impossible to spawn", UT.colors.error)
            return
        end
        return crosshairRay.position
    elseif UT.Spawn.position == "self" then
        return UT.getPlayerPosition()
    end
end

function UT.Spawn.setPosition(position)
    UT.Spawn.position = position
    UT.showMessage("spawn position set to " .. position, UT.colors.info)
end

function UT.Spawn.setTeam(unit, team)
    if not alive(unit) then return end
    local teamId = tweak_data.levels:get_default_team_ID(team)
    local teamData = managers.groupai:state():team_data(teamId)
	unit:movement():set_team(teamData)
end

function UT.Spawn.convertEnemy(unit)
    if not alive(unit) then return end
    managers.groupai:state():convert_hostage_to_criminal(unit)
    managers.groupai:state():sync_converted_enemy(unit)
    unit:contour():add("friendly", true)
end

function UT.Spawn.setEquipment(equipment)
    managers.player:clear_equipment()
    managers.player._equipment.selections = {}
    managers.player:add_equipment({equipment = equipment})
end

UTClassSpawn = true