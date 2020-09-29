UT.Job = {}

function UT.Job.createLobby(job, level, day)
    local result = managers.job:activate_job(job, day)
    if not result then return end
	Global.game_settings.level_id = level or managers.job:current_level_id()
	Global.game_settings.mission = managers.job:current_mission()
	Global.game_settings.world_setting = managers.job:current_world_setting()
    Global.game_settings.difficulty = "sm_wish"
    Global.game_settings.permission = "private"
    if managers.platform then
        managers.platform:update_discord_heist()
    end
    local attributes = MenuCallbackHandler:get_matchmake_attributes()
	if Network:is_server() then
		managers.network:session():send_to_peers(
            "sync_game_settings",
            tweak_data.narrative:get_index_from_job_id(managers.job:current_job_id()),
            tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id),
            tweak_data:difficulty_to_index(Global.game_settings.difficulty),
            Global.game_settings.one_down,
            Global.game_settings.weekly_skirmish
        )
		managers.network.matchmake:set_server_attributes(attributes)
		managers.mutators:update_lobby_info()
		managers.menu_component:on_job_updated()
		managers.menu:open_node("lobby")
		managers.menu:active_menu().logic:refresh_node("lobby", true)
    else
        managers.network.matchmake:create_lobby(attributes)
	end
    managers.platform:refresh_rich_presence()
end

UTClassJob = true