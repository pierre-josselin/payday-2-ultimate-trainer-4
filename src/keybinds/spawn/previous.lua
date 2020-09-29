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
    if UT.Spawn.index == 1 then UT.Spawn.index = UT.countTable(UT.Tables.enemies)
    else UT.Spawn.index = UT.Spawn.index - 1 end
    UT.showSubtitle(UT.getFilename(UT.Tables.enemies[UT.Spawn.index]), UT.colors.info)
elseif UT.Spawn.mode == "allies" then
    if UT.Spawn.index == 1 then UT.Spawn.index = UT.countTable(UT.Tables.enemies)
    else UT.Spawn.index = UT.Spawn.index - 1 end
    UT.showSubtitle(UT.getFilename(UT.Tables.enemies[UT.Spawn.index]), UT.colors.info)
elseif UT.Spawn.mode == "civilians" then
    if UT.Spawn.index == 1 then UT.Spawn.index = UT.countTable(UT.Spawn.available.civilians)
    else UT.Spawn.index = UT.Spawn.index - 1 end
    UT.showSubtitle(UT.getFilename(UT.Spawn.available.civilians[UT.Spawn.index]), UT.colors.info)
elseif UT.Spawn.mode == "loots" then
    if UT.Spawn.index == 1 then UT.Spawn.index = UT.countTable(UT.Spawn.available.loots)
    else UT.Spawn.index = UT.Spawn.index - 1 end
    UT.showSubtitle(UT.getFilename(UT.Spawn.available.loots[UT.Spawn.index]), UT.colors.info)
elseif UT.Spawn.mode == "equipments" then
    if UT.Spawn.index == 1 then UT.Spawn.index = UT.countTable(UT.Spawn.available.equipments)
    else UT.Spawn.index = UT.Spawn.index - 1 end
    UT.showSubtitle(UT.Spawn.available.equipments[UT.Spawn.index], UT.colors.info)
elseif UT.Spawn.mode == "packages" then
    if UT.Spawn.index == 1 then UT.Spawn.index = UT.countTable(UT.Spawn.available.packages)
    else UT.Spawn.index = UT.Spawn.index - 1 end
    UT.showSubtitle(UT.getFilename(UT.Spawn.available.packages[UT.Spawn.index]), UT.colors.info)
elseif UT.Spawn.mode == "bags" then
    if UT.Spawn.index == 1 then UT.Spawn.index = UT.countTable(UT.Tables.bags)
    else UT.Spawn.index = UT.Spawn.index - 1 end
    UT.showSubtitle(UT.Tables.bags[UT.Spawn.index], UT.colors.info)
else
    UT.showMessage("no mode selected", UT.colors.warning)
end