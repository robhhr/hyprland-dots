local vars = require("lua.vars")
local monitors = require("lua.monitors")
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

hl.bind(mainMod .. " + O",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh")
)

-- waybar toggle
hl.bind(mainMod .. " + W",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_waybar.sh")
)

-- displays: step the focused monitor through the scales that are safe for it
hl.bind(mainMod .. " + P", monitors.cycle_scale)

-- app/window switcher
hl.bind(mainMod .. " + TAB",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/cycle_last_windows.sh")
)

hl.bind("SUPER + SHIFT + TAB",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/cycle_windows_reverse.sh")
)

hl.bind(mainMod .. " + L",
  hl.dsp.exec_cmd("loginctl lock-session")
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

-- wifi menu (scripts/wifi.sh): close it when another window is clicked.
-- the window rule makes it stay_focused so hovering (follow_mouse) can't steal
-- focus; non_consuming lets the click still reach the clicked window.
-- clicks on the bar/desktop are ignored, so the bar icon can toggle it itself
local function under_cursor(w, c)
  return c.x >= w.at.x and c.x < w.at.x + w.size.x
     and c.y >= w.at.y and c.y < w.at.y + w.size.y
end

hl.bind("mouse:272", function()
  local wins = hl.get_windows()
  local menu
  for _, w in ipairs(wins) do
    if w.class == "wofi" then menu = w end
  end
  if not menu then return end
  local c = hl.get_cursor_pos()
  if under_cursor(menu, c) then return end
  -- ponytail: menu's workspace only, other monitors' windows don't close it
  for _, w in ipairs(wins) do
    if w.address ~= menu.address and w.workspace and menu.workspace
       and w.workspace.name == menu.workspace.name and under_cursor(w, c) then
      hl.dispatch(hl.dsp.window.close({ window = "address:" .. menu.address }))
      return
    end
  end
end, { non_consuming = true })
