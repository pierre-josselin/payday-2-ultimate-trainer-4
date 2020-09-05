_G.CloneClass(IngameWaitingForPlayersState)
function IngameWaitingForPlayersState:at_exit(...)
    IngameWaitingForPlayersState.orig.at_exit(self, ...)
    if not managers.player then return end
    if not managers.player.player_unit then return end
    if not managers.player:player_unit().character_damage then return end
    if not managers.player:player_unit():character_damage().set_god_mode then return end
    managers.player:player_unit():character_damage():set_god_mode(false)
end