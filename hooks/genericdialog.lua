core:module("SystemMenuManager")
require("lib/managers/dialogs/Dialog")

_G.CloneClass(GenericDialog)
function GenericDialog:init(...)
    self.orig.init(self, ...)
    if self._data.custom then
        self.FADE_IN_DURATION = 0.0001
        self.FADE_OUT_DURATION = 0.2
        self._panel_script:set_layer(100)
    end
end

function GenericDialog:button_pressed_callback()
    if not self._data.custom then
        self.orig.button_pressed_callback(self)
        return
    end
	if self._data.no_buttons then return end
    if not self._data.button_list then return end
    local button_index = self._panel_script:get_focus_button()
    local button = self._data.button_list[button_index]
    if not button then return end
    if button.in_game then
        if not Utils:IsInHeist() then
            managers.mission._fading_debug_output:script().log("in-game only", Color.red)
            return
        end
    end
    if button.out_game then
        if Utils:IsInGameState() then
            managers.mission._fading_debug_output:script().log("out-game only", Color.red)
            return
        end
    end
    if button.host then
        if not Network:is_server() then
            managers.mission._fading_debug_output:script().log("host only", Color.red)
            return
        end
    end
    if button.cancel_button or button.close_button then
        self:fade_out_close()
    end
    if button.open_menu then
        self:close()
        managers.menu:post_event("menu_enter")
        if type(button.open_menu) == "table" then
            managers.system_menu:show_buttons(button.open_menu)
        end
    end
    if button.callback_func then
        managers.menu:post_event("menu_enter")
        button.callback_func(button.callback_data)
    end
end