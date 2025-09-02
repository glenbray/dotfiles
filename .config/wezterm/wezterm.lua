local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Cursor settings (matching Ghostty)
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 0  -- Disable blinking (matching cursor-style-blink = false)

-- Appearance settings (matching Ghostty)
config.color_scheme = 'Custom'
config.colors = {
  background = '#000000',  -- matching background = 000000
}

-- Font settings (matching Ghostty)
config.font_size = 15  -- matching font-size = 15
config.harfbuzz_features = { 'liga=0' }  -- matching font-feature = -liga

-- Window settings (matching Ghostty)
config.window_background_opacity = 1.0  -- matching alpha-blending = linear
config.macos_window_background_blur = 0

-- Tab navigation key bindings (matching Ghostty)
config.keys = {
  -- Tab navigation
  { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'LeftArrow', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  
  -- Moving tabs (matching Ghostty)
  { key = 'LeftArrow', mods = 'CMD|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = wezterm.action.MoveTabRelative(1) },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(1) },
  
  -- Split navigation (matching Ghostty)
  { key = 'h', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'j', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Up' },
  
  -- Split resizing (matching Ghostty)
  { key = 'h', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 15 } },
  { key = 'l', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 15 } },
  { key = 'j', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 15 } },
  { key = 'k', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 15 } },
  
  -- Equalize splits (matching Ghostty)
  { key = '=', mods = 'CMD', action = wezterm.action.PaneSelect { mode = 'Activate' } },
  
  -- Fix Shift+Enter (matching Ghostty)
  { key = 'Enter', mods = 'SHIFT', action = wezterm.action.SendString '\n' },
  
  -- Word navigation with Alt+arrows (like iTerm2)
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.SendString '\x1bb' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.SendString '\x1bf' },
  
  -- Split creation (matching Ghostty)
  { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
}

-- macOS settings (matching Ghostty)
config.send_composed_key_when_left_alt_is_pressed = true  -- matching macos-option-as-alt = true
config.native_macos_fullscreen_mode = true  -- opposite of macos-non-native-fullscreen = false

-- Window decoration (matching Ghostty)
config.window_decorations = "TITLE | RESIZE"  -- matching window-decoration = true

-- Split appearance (matching Ghostty)
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.7,  -- matching unfocused-split-opacity = 0.7
}

-- Shell integration (matching Ghostty)
config.enable_csi_u_key_encoding = false  -- matching shell-integration-features = no-cursor

return config