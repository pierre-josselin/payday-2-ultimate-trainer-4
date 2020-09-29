UT.Construction = {}

UT.Construction.units = {}
UT.Construction.clipboard = {}
UT.Construction.crosshair = {}

function UT.Construction.save()
    if not UT.checkTable(UT.Construction.units) then
        UT.showMessage("nothing to save", UT.colors.warning)
        return
    end
    local constructions = UT.getConstructions()
    local levelId = managers.job:current_level_id()
    if not constructions[levelId] then
        constructions[levelId] = {}
    end
    table.insert(constructions[levelId], {
        time = UT.getTime(),
        name = UT.getDateTime(),
        units = UT.Construction.units
    })
    local result = UT.setConstructions(constructions)
    if result then
        UT.showMessage("save success", UT.colors.success)
    else
        UT.showMessage("save fail", UT.colors.error)
    end
end

function UT.Construction.load(units)
    local constructions = UT.getConstructions()
    local levelId = managers.job:current_level_id()
    if not constructions[levelId] then
        constructions[levelId] = {}
    end
    local result = true
    for key, value in pairs(units) do
        local name = UT.getNameByKey(value.key)
        if not name then
            result = false
            goto continue
        end
        local position = Vector3(unpack(value.position))
        local rotation = Rotation(value.rotation, 0, 0)
        local unit = UT.spawnUnit(name, position, rotation)
        if not unit then
            result = false
            goto continue
        end
        table.insert(UT.Construction.units, {
            key = value.key,
            position = value.position,
            rotation = value.rotation,
            unit = unit
        })
        ::continue::
    end
    if result then
        UT.showMessage("load success", UT.colors.success)
    else
        UT.showMessage("load fail", UT.colors.error)
    end
end

function UT.Construction.delete(time)
    local constructions = UT.getConstructions()
    local levelId = managers.job:current_level_id()
    if not constructions[levelId] then
        constructions[levelId] = {}
    end
    for key, value in pairs(constructions[levelId]) do
        if time == value.time then
            constructions[levelId][key] = nil
        end
    end
    local result = UT.setConstructions(constructions)
    if result then
        UT.showMessage("delete success", UT.colors.success)
    else
        UT.showMessage("delete fail", UT.colors.error)
    end
end

function UT.Construction.clear()
    if not UT.checkTable(UT.Construction.units) then
        UT.showMessage("nothing to clear", UT.colors.warning)
        return
    end
    for key, value in pairs(UT.Construction.units) do
        if not alive(value.unit) then
            goto continue
        end
        UT.removeUnit(value.unit)
        UT.Construction.units[key] = nil
        ::continue::
    end
    UT.showMessage("construction clear", UT.colors.info)
end

function UT.Construction.toggleCrosshair()
    if not UT.Construction.crosshair.workspace then
        local options = {visible = true, color = UT.colors.white:with_alpha(0.5), w = 7, h = 7}
        UT.Construction.crosshair.workspace = Overlay:newgui():create_screen_workspace():panel()
        UT.Construction.crosshair.workspace:bitmap(options):set_center(UT.Construction.crosshair.workspace:center())
    end
    if UT.Construction.crosshair.enabled then
        UT.Construction.crosshair.workspace:hide()
        UT.Construction.crosshair.enabled = false
        UT.showMessage("crosshair disabled", UT.colors.disabled)
    else
        UT.Construction.crosshair.workspace:show()
        UT.Construction.crosshair.enabled = true
        UT.showMessage("crosshair enabled", UT.colors.enabled)
    end
end

UTClassConstruction = true