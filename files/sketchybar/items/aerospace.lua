local settings = require("settings")

local items = {}

local aerospace_command = _G.AEROSPACE_COMMAND .. " "
local loaded = false

while loaded do
  sbar.exec(aerospace_command, function(result, exit_code)
    if (exit_code == 0) then
      loaded = true
    end
  end)
  wait()
end

function await_exec(command)
  local c = coroutine.running()

  sbar.exec(command, function(result, code)
    coroutine.resume(c, result, code)
  end)

  return coroutine.yield()
end

function async(task_func)
  return function(...)
    local co = coroutine.create(task_func)
    local function step(...)
      local success, result = coroutine.resume(co, ...)
      if not success then
        error("SketchyBar Async Error: " .. tostring(result))
      end
    end
    step(...)
  end
end

local setup = async(function()
  local current_workspace = await_exec(aerospace_command .. "list-workspaces --focused --json")
  local monitors = await_exec(aerospace_command .. "list-monitors --json")
  
  local workspaces = {}
  
  for _,monitor in pairs(monitors) do
    local n_workspaces = await_exec(aerospace_command .. "list-workspaces --monitor " .. monitor["monitor-id"] .. " --json")
    for i = 1, #n_workspaces do
      table.insert(workspaces, n_workspaces[i])
    end
  end
  
  for _,workspace in pairs(workspaces) do
    local workspace_item = sbar.add("item", "space." .. workspace["workspace"], {
      position = "left",
      background = {
        color = _G.COLORS.ITEM_BG_COLOR,
        drawing = current_workspace["workspace"] == workspace["workspace"],
        height = settings.bar.height
      },
      label = {
        string = workspace["workspace"],
      },
    })
  
    workspace_item:subscribe("aerospace_workspace_change", function(env)
      local selected = env.FOCUSED_WORKSPACE == workspace["workspace"]
      workspace_item:set({
        background = { drawing = selected }
      })
    end)
  
    workspace_item:subscribe("mouse.clicked", function()
      sbar.exec(aerospace_command .. "workspace " .. workspace["workspace"])
    end)
  end
end)

setup()
