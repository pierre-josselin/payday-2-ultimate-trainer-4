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

local crosshairRay = Utils:GetCrosshairRay()

if not crosshairRay then
    UT.showMessage("impossible to remove", UT.colors.error)
    do return end
end

local remove = nil
local unit = crosshairRay.unit

for key, value in pairs(UT.Construction.units) do
    if tostring(unit) == tostring(value.unit) then
        remove = {
            key = key,
            unit = value.unit
        }
        break
    end
end

if not remove then
    UT.showMessage("nothing to remove", UT.colors.warning)
    do return end
end

UT.removeUnit(remove.unit)
UT.Construction.units[remove.key] = nil
managers.hud:on_hit_confirmed()
UT.playSound("zoom_out")