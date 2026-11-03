local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = 'Catppuccin Mocha'
-- Non-"Mono" variant so Nerd Font icons render at full width
config.font = wezterm.font 'JetBrainsMono Nerd Font'
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

-- Panes: dim inactive ones so the focused pane is obvious
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.6 }
config.scrollback_lines = 10000

-- Ctrl-h/j/k/l: move between panes, handing off to nvim when it's focused
-- (smart-splits.nvim sets IS_NVIM). With no pane in that direction the key
-- passes through, so Ctrl-L still clears a lone shell.
local directions = { h = 'Left', j = 'Down', k = 'Up', l = 'Right' }

local function nav(key)
  return {
    key = key,
    mods = 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      local dir = directions[key]
      if pane:get_user_vars().IS_NVIM ~= 'true' and pane:tab():get_pane_direction(dir) then
        win:perform_action(act.ActivatePaneDirection(dir), pane)
      else
        win:perform_action(act.SendKey { key = key, mods = 'CTRL' }, pane)
      end
    end),
  }
end

-- Keys
config.keys = {
  -- Make Option-Left/Right work for word skipping
  { key = 'LeftArrow', mods = 'OPT', action = act.SendString '\x1bb' },
  { key = 'RightArrow', mods = 'OPT', action = act.SendString '\x1bf' },

  -- Splits
  { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = false } },
  { key = 'Enter', mods = 'CMD|SHIFT', action = act.TogglePaneZoomState },

  -- Resize
  { key = 'LeftArrow', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'DownArrow', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'UpArrow', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },

  nav 'h',
  nav 'j',
  nav 'k',
  nav 'l',
}

return config
