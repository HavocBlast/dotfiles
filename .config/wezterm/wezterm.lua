local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.font_size = 18.0
config.color_scheme = "Catppuccin Macchiato"
--config.window_background_opacity = 0.6
return config
