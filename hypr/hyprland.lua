---@diagnostic disable: undefined-global

local mainMod = "SUPER"

local terminal = "alacritty"
local browser = "zen"
local fileManager = "nautilus"
local menu = "wofi --show drun"

-- monitors
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})

-- env
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- autostart
hl.on("hyprland.start", function()
  hl.exec_cmd("dunst")
  -- hl.exec_cmd("waybar")
  hl.exec_cmd("waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css")
end)

-- basic look
hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 12,
    border_size = 5,
    layout = "dwindle",
  },

  decoration = {
    rounding = 8,
  },

  input = {
    kb_layout = "us",
  },

  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
  },
})

-- survival binds
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

-- workspaces
for i = 1, 9 do
  local key = tostring(i)

  -- switch to workspace
  hl.bind(mainMod .. " + " .. key,
    hl.dsp.focus({ workspace = i })
  )

  -- move active window to workspace
  hl.bind(mainMod .. " + SHIFT + " .. key,
    hl.dsp.window.move({ workspace = i })
  )
end

-- workspace 10
hl.bind(mainMod .. " + 0",
  hl.dsp.focus({ workspace = 10 })
)

hl.bind(mainMod .. " + SHIFT + 0",
  hl.dsp.window.move({ workspace = 10 })
)
