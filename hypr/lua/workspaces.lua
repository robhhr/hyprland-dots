local vars = require("lua.vars")
local mainMod = vars.mainMod

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
