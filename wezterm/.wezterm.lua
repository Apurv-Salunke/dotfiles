local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.font_size = 14.0
config.line_height = 1.2

-- Window
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.window_close_confirmation = 'NeverPrompt'

-- Tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Keys
config.keys = {
  -- Make Option-Left/Right work for word skipping
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1bb',
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1bf',
  },
}

return config
