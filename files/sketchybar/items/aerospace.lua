local colours = require("colours")
local settings = require("settings")

local items = {}

local aerospace_command = "/run/current-system/sw/bin/aerospace "
local loaded = false

while loaded do
  sbar.exec(aerospace_command, function(result, exit_code)
    if (exit_code == 0) then
      loaded = true
    end
  end)
  wait()
end

sbar.exec(aerospace_command .. "list-workspaces --focused --json", function(current_workspace)
  sbar.exec(aerospace_command .. "list-monitors --json", function(monitors)
    table.sort(monitors, function(a, b)
      return a["monitor-id"] < b["monitor-id"]
    end)
  
    for _,monitor in pairs(monitors) do
      print(monitor["monitor-id"])
      sbar.exec(aerospace_command .. "list-workspaces --monitor " .. monitor["monitor-id"] .. " --json", function(workspaces)
        for _,workspace in pairs(workspaces) do
          local workspace_item = sbar.add("item", "space." .. workspace["workspace"], {
            position = "left",
            background = {
              color = colours.nord.polar_night[4],
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
    end
  end)
end)
