if not Utils:IsInGameState() then
    do return end
end

if not Network:is_server() then
    UT.showMessage("host only", UT.colors.error)
    do return end
end

local amountOfAlivePlayers = managers.network:session():amount_of_alive_players()
managers.network:session():send_to_peers("mission_ended", true, amountOfAlivePlayers)
game_state_machine:change_state_by_name("victoryscreen", {num_winners = amountOfAlivePlayers, personal_win = true})