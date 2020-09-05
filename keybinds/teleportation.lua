if not Utils:IsInGameState() then
    do return end
end

if not Utils:IsInHeist() then
    do return end
end

local crosshairRay = Utils:GetCrosshairRay()

if not crosshairRay then
    do return end
end

local offset = Vector3()
mvector3.set(offset, UT.getCameraForward())
mvector3.multiply(offset, 100)
mvector3.add(crosshairRay.hit_position, offset)
UT.teleportation(crosshairRay.hit_position, UT.getCameraRotation())