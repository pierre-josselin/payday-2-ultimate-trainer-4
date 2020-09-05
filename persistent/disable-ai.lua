if not UT.Game.disableAI then
    do return end
end

if not Utils:IsInGameState() then
    do return end
end

if not Utils:IsInHeist() then
    do return end
end

for key, value in pairs(managers.enemy:all_civilians()) do
    value.unit:brain():set_active(false)
end

for key, value in pairs(managers.enemy:all_enemies()) do
    value.unit:brain():set_active(false)
end

for key, unit in pairs(managers.groupai:state():turrets()) do
    unit:brain():set_active(false)
end

for key, unit in pairs(SecurityCamera.cameras) do
    unit:base()._detection_interval = 1000000
end