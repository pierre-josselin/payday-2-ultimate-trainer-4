UT.Player = {}

function UT.Player.setLevel(value)
    managers.experience:reset()
    managers.experience:_set_current_level(value)
    UT.showMessage("level set to " .. tostring(value), UT.colors.info)
    UT.showMessage(UT.messages.restartGame, UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.setInfamyRank(value)
    managers.experience:set_current_rank(value)
    UT.showMessage("infamy rank set to " .. tostring(value), UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.addExperience(value)
    managers.experience:debug_add_points(value)
    UT.showMessage("added " .. tostring(value) .. " xp", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.setSkillPoints(value)
    managers.skilltree:_set_points(value - managers.skilltree:total_points_spent())
    local settings = UT.getSettings()
    settings.skillPoints = value
    UT.setSettings(settings)
    UT.showMessage("total skill points set to " .. tostring(value), UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.resetSkillPoints()
    local settings = UT.getSettings()
    settings.skillPoints = nil
    UT.setSettings(settings)
    UT.showMessage("skill points reset", UT.colors.info)
    UT.showMessage(UT.messages.restartGame, UT.colors.info)
end

function UT.Player.addPerkPoints(value)
    managers.skilltree:give_specialization_points(value * 1000)
    UT.showMessage("added " .. tostring(value) .. " perk points", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.setInfamyPoints(value)
    managers.infamy:_set_points(value)
    UT.showMessage("set infamy points to " .. tostring(value), UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.addMoney(value)
    managers.money:_add_to_total(value)
    UT.showMessage("added " .. tostring(value) .. " $", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.resetMoney()
    managers.money:reset()
    UT.showMessage("money reset", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.addItems(type)
    for key, value in pairs(tweak_data.blackmarket[type]) do
        local globalValue = "normal"
        if value.global_value then
            globalValue = value.global_value
        elseif value.infamous then
            globalValue = "infamous"
        elseif value.dlcs or value.dlc then
            local dlcs = value.dlcs or {}
            if value.dlc then table.insert(dlcs, value.dlc) end
            globalValue = dlcs[math.random(#dlcs)]
        end
        managers.blackmarket:add_to_inventory(globalValue, type, key)
    end
    UT.showMessage("added all " .. type, UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.addAllItems()
    local types = {"weapon_mods", "masks", "materials", "textures", "colors"}
    for key, value in pairs(types) do
        UT.Player.addItems(value)
    end
end

function UT.Player.resetItems(type)
    for globalValue, data in pairs(Global.blackmarket_manager.inventory) do
        if not data[type] then
            goto continue
        end
        for key, value in pairs(data[type]) do
            Global.blackmarket_manager.inventory[globalValue][type][key] = nil
        end
        ::continue::
    end
    UT.showMessage("reset " .. type, UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.resetAllItems()
    local types = {"weapon_mods", "masks", "materials", "textures", "colors"}
    for key, value in pairs(types) do
        UT.Player.resetItems(value)
    end
end

function UT.Player.unlockAllWeapons()
    for key, value in pairs(tweak_data.upgrades.definitions) do
        if value.category == "weapon"
        and not string.find(key, "_primary")
        and not string.find(key, "_secondary") then
            if not managers.upgrades:aquired(key) then
                managers.upgrades:aquire(key)
            end
        end
    end
    UT.showMessage("unlocked all weapons", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.setAllSlots(value)
    for i = 1, 160 do
        Global.blackmarket_manager.unlocked_weapon_slots.primaries[i] = value
        Global.blackmarket_manager.unlocked_weapon_slots.secondaries[i] = value
        Global.blackmarket_manager.unlocked_mask_slots[i] = value
    end
    UT.showMessage((value and "unlocked" or "locked") .. " all slots", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.removeExclamationMarks()
    Global.blackmarket_manager.new_drops = {}
    UT.showMessage("removed exclamation marks", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.addContinentalCoins(value)
	local current = Application:digest_value(managers.custom_safehouse._global.total)
	Global.custom_safehouse_manager.total = Application:digest_value(current + value, true)
    UT.showMessage("added " .. tostring(value) .. " continental coins", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.resetContinentalCoins()
	Global.custom_safehouse_manager.total = Application:digest_value(0, true)
    UT.showMessage("continental coins reset", UT.colors.info)
    UT.Player.saveAndRefresh()
end

function UT.Player.unlockAllAchievments()
    for key, value in pairs(managers.achievment.achievments) do
        managers.achievment:award(key)
    end
    UT.showMessage("unlocked all steam achievments", UT.colors.info)
end

function UT.Player.lockAllAchievments()
    managers.achievment:clear_all_steam()
    UT.showMessage("locked all steam achievments", UT.colors.info)
end

function UT.Player.saveAndRefresh()
    if managers.savefile then
        managers.savefile:save_progress()
    end
    if managers.menu_component then
        managers.menu_component:refresh_player_profile_gui()
    end
end

UTClassPlayer = true