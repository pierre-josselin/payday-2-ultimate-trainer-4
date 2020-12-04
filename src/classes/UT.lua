UT = {}

UT.menus = {}
UT.version = "4.1.4"
UT.url = "https://www.unknowncheats.me/forum/payday-2-a/390014-payday-2-ultimate-trainer-4-a.html"
UT.colors = {
    white = Color("ffffff"),
    info = Color("00ffff"),
    success = Color("00ff00"),
    warning = Color("ffff00"),
    danger = Color("ff0000"),
    error = Color("ff0000"),
    enabled = Color("00ff00"),
    disabled = Color("ffa500")
}
UT.filenames = {
    bltData = SavePath .. "blt_data.txt",
    settings = SavePath .. "UTSettings.json",
    constructions = SavePath .. "UTConstructions.json"
}
UT.keybinds = {
    {id = "UTKeybindConstructionCopy", pc = "f2"},
    {id = "UTKeybindConstructionPaste", pc = "f3"},
    {id = "UTKeybindConstructionRemove", pc = "f4"},
    {id = "UTKeybindSpawnPrevious", pc = "mouse wheel up"},
    {id = "UTKeybindSpawnNext", pc = "mouse wheel down"},
    {id = "UTKeybindSpawnPlace", pc = "mouse 2"},
    {id = "UTKeybindStart", pc = "insert"},
    {id = "UTKeybindRestart", pc = "home"},
    {id = "UTKeybindFinish", pc = "end"},
    {id = "UTKeybindLeave", pc = "delete"},
    {id = "UTKeybindMenuMain", pc = "f1"},
    {id = "UTKeybindTeleportation", pc = "5"},
    {id = "UTKeybindReplenish", pc = "right alt"}
}
UT.messages = {
    restartHeist = "restart the heist to apply changes",
    restartGame = "restart the game to apply changes"
}

function UT.getTime()
    return os.time()
end

function UT.getDateTime()
    return os.date("%c")
end

function UT.getFilename(path)
    return path:match("[^/]+$")
end

function UT.readFile(filename)
    if not io.file_is_readable(filename) then return end
    local file = io.open(filename, "r")
    if not file then return end
    local content = file:read("*all")
    file:close()
    return content
end

function UT.writeFile(filename, content, mode)
    file = io.open(filename, mode or "w+")
    if not file then return false end
    file:write(content)
    file:close()
    return true
end

function UT.getTable(filename)
    local content = UT.readFile(filename)
    if not content then return {} end
    return json.decode(content)
end

function UT.setTable(filename, table)
    local content = json.encode(table)
    return UT.writeFile(filename, content)
end

function UT.getBltData()
    return UT.getTable(UT.filenames.bltData)
end

function UT.setBltData(bltData)
    return UT.setTable(UT.filenames.bltData, bltData)
end

function UT.getSettings()
    return UT.getTable(UT.filenames.settings)
end

function UT.setSettings(settings)
    return UT.setTable(UT.filenames.settings, settings)
end

function UT.getConstructions()
    return UT.getTable(UT.filenames.constructions)
end

function UT.setConstructions(constructions)
    return UT.setTable(UT.filenames.constructions, constructions)
end

function UT.inTable(element, table)
    for key, value in pairs(table) do
        if value == element then return true end
    end
    return false
end

function UT.checkTable(table)
    if not table then return false end
    if type(table) ~= "table" then return false end
    if next(table) == nil then return false end
    return true
end

function UT.countTable(table)
    local count = 0
    for key, value in pairs(table) do
        count = count + 1
    end
    return count
end

function UT.debugOutput(output, color)
    managers.mission._fading_debug_output:script().log(UT.getDateTime() .. " " .. tostring(output), color)
end

function UT.showMessage(message, color)
    managers.mission._fading_debug_output:script().log(message, color)
end

function UT.showSubtitle(subtitle, color)
    managers.mission:_show_debug_subtitle(subtitle, color)
end

function UT.openMenu(menu)
    managers.system_menu:show_buttons(menu)
end

function UT.playSound(name)
    managers.menu_component:post_event(name)
end

function UT.getCameraPosition()
    return managers.player:player_unit():camera():position()
end

function UT.getCameraRotation()
    return managers.player:player_unit():camera():rotation()
end

function UT.getCameraRotationFlat()
    return Rotation(UT.getCameraRotation():yaw(), 0, 0)
end

function UT.getCameraForward()
    return managers.player:player_unit():camera():forward()
end

function UT.getPlayerPosition()
    return managers.player:player_unit():position()
end

function UT.getPlayerRotation()
    return managers.player:player_unit():rotation()
end

function UT.unitExists(id)
    return DB:has("unit", id)
end

function UT.unitLoaded(name)
    return PackageManager:has(Idstring("unit"), name)
end

function UT.spawnUnit(name, position, rotation)
    if not UT.unitLoaded(name) then return end
    return World:spawn_unit(name, position, rotation)
end

function UT.removeUnit(unit)
    if not alive(unit) then return end
    World:delete_unit(unit)
    managers.network:session():send_to_peers_synched("remove_unit", unit)
end

function UT.removeUnits(units)
    local count = 0
    for key, unit in pairs(units) do
        UT.removeUnit(unit)
        count = count + 1
    end
    return count
end

function UT.getNameByKey(unitKey)
    local units = World:find_units_quick("all")
    for key, unit in ipairs(units) do
        if unit:name():key() == unitKey then
            return unit:name()
        end
    end
end

function UT.teleportation(position, rotation)
    managers.player:warp_to(position, rotation)
end

function UT.enableUnlimitedConversions()
    _G.CloneClass(PlayerManager)
    function PlayerManager:upgrade_value(category, upgrade, default)
        if category == "player" and upgrade == "convert_enemies" then
            return true
        elseif category == "player" and upgrade == "convert_enemies_max_minions" then
            return 1000000
        else
            return PlayerManager.orig.upgrade_value(self, category, upgrade, default)
        end
    end
end

function UT.getInteractiveUnits()
    local units = {}
    for key, unit in pairs(managers.interaction._interactive_units) do
        if not alive(unit) then goto continue end
        table.insert(units, unit)
        ::continue::
    end
    return units
end

function UT.documentation()
	if not MenuCallbackHandler:is_overlay_enabled() then
		managers.menu:show_enable_steam_overlay()
		return
	end
    Steam:overlay_activate("url", UT.url)
end

UT.about = [[
PAYDAY 2 - Ultimate Trainer 4
Author: ChildOfSorrow.

This is a free software. If you paid to get it, please contact me quickly.

I developed this version 4 from scratch.
What is not in this list has been developed or found by me.
If I forgot someone please tell me.

hard to find originals authors
- player menu functions
- set team of unit
- unlimited conversions

rogerxiii
- list of invisible wall keys
- idea of testing if a key exists in a table

transcend
- overkill mode functions
- instant drilling

zReko
- change environment without restarting the heist
- units outlines in construction mode
- his help and advices

Kwhali
- functions to load packages

test1, Tast, Motherflowers, Undeadsewer
- list of packages to load for time mode stability

stumpy3toes
- for his guide "Drawing on the GUI"

paofcbab, isopropilick
- help with debugging

other names important to mention
SirGoodSmoke, B1313, Simplity, PirateCaptain...
]]

UTClassUT = true