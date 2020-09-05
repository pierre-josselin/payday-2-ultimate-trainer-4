if not Utils:IsInGameState() then
    do return end
end

if not Network:is_server() then
    UT.showMessage("host only", UT.colors.error)
    do return end
end

managers.network:session():spawn_players()