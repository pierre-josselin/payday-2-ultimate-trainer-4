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
    UT.showMessage("nothing to copy", UT.colors.warning)
    do return end
end

local unit = crosshairRay.unit

if unit:base()
or UT.Tables.bagsKeys[unit:name():key()]
or UT.Tables.vehicles[unit:name():key()] then
    UT.showMessage("cannot copy this", UT.colors.error)
    do return end
end

if unit:network_sync() == "spawn" then
    UT.Construction.clipboard.synchronized = true
else
    UT.Construction.clipboard.synchronized = false
end

UT.Construction.clipboard.unit = unit
UT.Construction.clipboard.name = unit:name()
UT.Construction.clipboard.key = unit:name():key()
managers.hud:on_crit_confirmed()
UT.playSound("box_tick")