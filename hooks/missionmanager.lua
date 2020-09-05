function MissionManager:_show_debug_subtitle(debug, color)
    self._debug_subtitle_text = self._debug_subtitle_text or self._workspace:panel():text({
        font_size = 20,
        wrap = true,
        word_wrap = true,
        align = "center",
        font = "fonts/font_large_mf",
        halign = "center",
        valign = "center",
        text = debug,
        color = color or Color.white
    })
    
    self._debug_subtitle_text:set_w(self._workspace:panel():w() / 2)
    self._debug_subtitle_text:set_text(debug)
    
    local subtitle_time = 2
    local _, _, w, h = self._debug_subtitle_text:text_rect()
    
    self._debug_subtitle_text:set_h(h)
    self._debug_subtitle_text:set_center_x(self._workspace:panel():w() / 2)
    self._debug_subtitle_text:set_top(self._workspace:panel():h() / 1.4)
    self._debug_subtitle_text:set_color(color or Color.white)
    self._debug_subtitle_text:set_alpha(1)
    self._debug_subtitle_text:stop()
    self._debug_subtitle_text:animate(function (o)
        _G.wait(subtitle_time)
        self._debug_subtitle_text:set_alpha(0)
    end)
end