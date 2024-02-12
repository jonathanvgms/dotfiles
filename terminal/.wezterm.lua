-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'

-- Spawn a fish shell in login mode
config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash', '-l' }

config.enable_tab_bar = false

config.font = wezterm.font 'Hack'
config.font_size = 10.0
config.default_cwd = "C:\\Users\\Jonathan\\Desktop"
config.window_close_confirmation = 'NeverPrompt'


-- and finally, return the configuration to wezterm
return config