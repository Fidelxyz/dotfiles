local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("keymaps").setup(config)
require("events")

config.set_environment_variables = {
    PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
    TERMINFO_DIRS = "/run/current-system/sw/share/terminfo",
}
config.term = "wezterm"

-- Window
config.initial_rows = 30
config.initial_cols = 100
config.window_background_opacity = 0.8
config.text_background_opacity = 0.8
config.macos_window_background_blur = 30
config.window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 30,
}
-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE | MACOS_FORCE_ENABLE_SHADOW"
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_frame = {
    font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono", weight = "Bold" }),
    font_size = 14,
}

-- Color scheme
config.color_scheme = "iTerm2 Smoooooth"

-- Font
-- config.font = wezterm.font("CaskaydiaMono Nerd Font Mono")
-- config.font = wezterm.font({
-- 	family = "JetBrainsMono Nerd Font Mono",
-- 	harfbuzz_features = { "calt=0" },
-- 	weight = "Medium",
-- })
-- config.font = wezterm.font("Monaspace Argon")
config.font = wezterm.font({
    family = "Maple Mono NF CN",
})
config.font_size = 16.0
config.line_height = 1.1

-- Keyboard
config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

return config
