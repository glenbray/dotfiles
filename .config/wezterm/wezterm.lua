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
  { key = 'j', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 3 } },
  { key = 'k', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
  
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

-- Enable mouse for hyperlinks
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- Use some simple heuristics to determine if we should open it
-- with a text editor in the terminal.
-- Take note! The code in this file runs on your local machine,
-- but a URI can appear for a remote, multiplexed session.
-- WezTerm can spawn the editor in that remote session, but doesn't
-- have access to the file locally, so we can't probe inside the
-- file itself, so we are limited to simple heuristics based on
-- the filename appearance.
function editable(filename)
  -- "foo.bar" -> ".bar"
  local extension = filename:match("^.+(%..+)$")
  if extension then
    -- ".bar" -> "bar"
    extension = extension:sub(2)
    wezterm.log_info(string.format("extension is [%s]", extension))
    local binary_extensions = {
      jpg = true,
      jpeg = true,
      png = true,
      gif = true,
      bmp = true,
      ico = true,
      tiff = true,
      psd = true,
      pdf = true,
      dmg = true,
      zip = true,
      tar = true,
      gz = true,
      bz2 = true,
      xz = true,
      ["7z"] = true,
      rar = true,
      mp3 = true,
      mp4 = true,
      avi = true,
      mkv = true,
      mov = true,
      wmv = true,
      flv = true,
      webm = true,
      doc = true,
      docx = true,
      xls = true,
      xlsx = true,
      ppt = true,
      pptx = true,
    }
    if binary_extensions[extension] then
      -- can't edit binary files
      return false
    end
  end

  -- if there is no, or an unknown, extension, then assume
  -- that our trusty editor will do something reasonable

  return true
end

function extract_filename(uri)
  local start, match_end = uri:find("$EDITOR:")
  if start == 1 then
    -- skip past the colon
    return uri:sub(match_end+1)
  end

  -- `file://hostname/path/to/file`
  local start, match_end = uri:find("file:")
  if start == 1 then
    -- skip "file://", -> `hostname/path/to/file`
    local host_and_path = uri:sub(match_end+3)
    local start, match_end = host_and_path:find("/")
    if start then
      -- -> `/path/to/file`
      return host_and_path:sub(match_end)
    end
  end

  return nil
end

wezterm.on("open-uri", function(window, pane, uri)
  local name = extract_filename(uri)
  if name and editable(name) then
    -- Note: if you change your VISUAL or EDITOR environment,
    -- you will need to restart wezterm for this to take effect,
    -- as there isn't a way for wezterm to "see into" your shell
    -- environment and capture it.
    local editor = os.getenv("VISUAL") or os.getenv("EDITOR") or "vi"

    -- To open a new window:
    local action = wezterm.action{SpawnCommandInNewWindow={
        args={editor, name}
      }};

    -- To open in a pane instead
    --[[
    local action = wezterm.action{SplitHorizontal={
        args={editor, name}
      }};
    ]]

    -- and spawn it!
    window:perform_action(action, pane);

    -- prevent the default action from opening in a browser
    return false
  end
end)

-- Hyperlink rules for clickable file paths
config.hyperlink_rules = {
  -- These are the default rules, but you currently need to repeat
  -- them here when you define your own rules, as your rules override
  -- the defaults

  -- URL with a protocol
  {
    regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
    format = "$0",
  },

  -- implicit mailto link
  {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
  },

  -- new in nightly builds; automatically highly file:// URIs.
  {
      regex = "\\bfile://\\S*\\b",
      format = "$0"
  },

  -- Now add a new item at the bottom to match things that are
  -- probably filenames

  {
    regex = "\\b\\S*\\b",
    format = "$EDITOR:$0"
  },
}

return config