_G.CloneClass(NetworkManager)
function NetworkManager:on_peer_added(peer, peer_id)
	NetworkManager.orig.on_peer_added(self, peer, peer_id)
    if Network:is_server() then
        if UT.checkTable(UT.Driving.units) then
            UT.Driving.removeVehicles()
        end
	end
end