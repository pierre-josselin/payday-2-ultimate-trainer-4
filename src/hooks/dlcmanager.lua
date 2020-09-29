dofile(ModPath .. "/classes/UT.lua")

local settings = UT.getSettings()

if not settings.DLCUnlocker == true then
    do return end
end

function WINDLCManager:_verify_dlcs()
    for key, value in pairs(Global.dlc_manager.all_dlc_data) do
        value.verified = true
    end
end