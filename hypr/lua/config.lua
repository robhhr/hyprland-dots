hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 12,
    border_size = 3,
    layout = "dwindle",

    col = {
      -- active_border = "rgba(fabd2fff)",
      active_border = "rgba(fb4934aa)",
      inactive_border = "rgba(928374aa)"
    },
  },

  decoration = {
    rounding = 8,
  },

  input = {
    kb_layout = "us",
    kb_options = "caps:escape",
    natural_scroll = true,
  },

  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
    -- hyprland-guiutils isn't packaged for Fedora; skip the startup nag
    disable_hyprland_guiutils_check = true,
  },
})

-- wifi menu (scripts/wifi.sh) runs wofi as a normal window, not a layer,
-- so lua/binds.lua can close it on outside clicks; this pins it where
-- the layer version sat and strips hyprland's decorations so wofi's own css shows
hl.window_rule({
  name = "wifi-menu",
  match = { class = "^wofi$" },
  float = true,
  move = "monitor_w-window_w-22 48",
  border_size = 0,
  rounding = 0,
  no_shadow = true,
  stay_focused = true,
})
