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

if not UT.checkTable(UT.Construction.clipboard) then
    UT.showMessage("no unit copied", UT.colors.warning)
    do return end
end

local crosshairRay = Utils:GetCrosshairRay()

if not crosshairRay then
    UT.showMessage("impossible to paste", UT.colors.error)
    do return end
end

local position = crosshairRay.position
local rotation = UT.getCameraRotationFlat()
local unit = UT.spawnUnit(UT.Construction.clipboard.name, position, rotation)

if not unit then
    UT.showMessage("paste failed", UT.colors.error)
    do return end
end

table.insert(UT.Construction.units, {
    key = UT.Construction.clipboard.key,
    position = {position[1], position[2], position[3]},
    rotation = rotation:yaw(),
    unit = unit
})

managers.hud:on_crit_confirmed()
UT.playSound("zoom_in")