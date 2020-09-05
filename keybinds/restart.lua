if not Network:is_server() then
    UT.showMessage("host only", UT.colors.error)
    do return end
end

if managers.system_menu:is_active() then
    managers.system_menu:force_close_all()
end

managers.game_play_central:restart_the_game()