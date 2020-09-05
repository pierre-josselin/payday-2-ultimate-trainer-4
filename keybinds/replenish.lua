if not Utils:IsInGameState() then
    do return end
end

if not Utils:IsInHeist() then
    do return end
end

local playerUnit = managers.player:player_unit()

if not alive(playerUnit) then
    do return end
end

managers.player:add_grenade_amount(99)
managers.player:add_body_bags_amount(99)
managers.player:add_special({name = "cable_tie", amount = 99})
managers.player:set_player_state("standard")
playerUnit:base():replenish()