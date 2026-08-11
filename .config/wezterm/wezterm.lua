local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'nightfox'

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'

config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

return config
