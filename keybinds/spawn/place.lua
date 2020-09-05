if managers.system_menu:is_active() then
    do return end
end

if not Utils:IsInGameState() then
    do return end
end

if not Utils:IsInHeist() then
    do return end
end

if not Network:is_server() then
    UT.showMessage("host only", UT.colors.error)
    do return end
end

if UT.Spawn.mode == "enemies" then
    UT.Spawn.spawnEnemy(UT.Tables.enemies[UT.Spawn.index])
elseif UT.Spawn.mode == "allies" then
    UT.Spawn.spawnAlly(UT.Tables.enemies[UT.Spawn.index])
elseif UT.Spawn.mode == "civilians" then
    UT.Spawn.spawnCivilian(UT.Spawn.available.civilians[UT.Spawn.index])
elseif UT.Spawn.mode == "loots" then
    UT.Spawn.spawnLoot(UT.Spawn.available.loots[UT.Spawn.index])
elseif UT.Spawn.mode == "equipments" then
    UT.Spawn.spawnEquipment(UT.Spawn.available.equipments[UT.Spawn.index])
elseif UT.Spawn.mode == "packages" then
    UT.Spawn.spawnPackage(UT.Spawn.available.packages[UT.Spawn.index])
else
    UT.showMessage("no mode selected", UT.colors.warning)
end