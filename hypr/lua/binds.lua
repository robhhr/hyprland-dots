local vars = require("lua.vars")
local mainMod = vars.mainMod
local terminal = vars.terminal
local browser = vars.browser
local fileManager = vars.fileManager
local menu = vars.menu

-- basic binds
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V",
  hl.dsp.window.float({ action = "toggle" })
)

hl.bind(mainMod .. " + J",
  hl.dsp.layout("togglesplit")
)

hl.bind(mainMod .. " + L",
  hl.dsp.exec_cmd("hyprlock")
)

hl.bind(mainMod .. " + O",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh")
)

-- waybar toggle
hl.bind(mainMod .. " + W",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_waybar.sh")
)

-- app/window switcher
hl.bind(mainMod .. " + TAB",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/cycle_last_windows.sh")
)

hl.bind("SUPER + SHIFT + TAB",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/cycle_windows_reverse.sh")
)

-- lock screen
hl.bind(mainMod .. " + L",
  hl.dsp.exec_cmd("hyprlock")
)

-- screenshots
hl.bind(mainMod .. " + S",
  hl.dsp.exec_cmd([[bash -c 'grim -g "$(slurp)" ~/Pictures/screenshot_$(date +%s).png && notify-send "📸 taken"']])
)
hl.bind(mainMod .. " + C",
  hl.dsp.exec_cmd([[bash -c 'grim -g "$(slurp)" - | wl-copy && notify-send "📸 copied to 📋"']])
)

-- screen recording
hl.bind("ALT + R",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/record_toggle.sh")
)

-- audio
hl.bind("XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true }
)
hl.bind("XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)
hl.bind("XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true }
)
hl.bind("XF86AudioMicMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true }
)

-- brightness
hl.bind("XF86MonBrightnessUp",
  hl.dsp.exec_cmd("brightnessctl s 10%+"),
  { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessDown",
  hl.dsp.exec_cmd("brightnessctl s 10%-"),
  { locked = true, repeating = true }
)
