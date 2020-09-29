if not UT or not UT.Driving then
    do return end
end

if not UT.Driving.packagesLoaded then
    UTPersistentAlert = true
    do return end
end

if not Utils:IsInHeist() then
    do return end
end

if not managers.chat then
    do return end
end

local message = "Loading time is longer because packages loading is enabled."
managers.chat:_receive_message(1, "Ultimate Trainer", message, UT.colors.warning)

UTPersistentAlert = true