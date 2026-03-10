local settings = require("settings")

local battery = sbar.add("item", "battery", {
  position = "right",
  update_freq = 180,
  background = {
    color = _G.COLORS.ITEM_BG_COLOR,
    height = settings.bar.height,
  }
})

battery:subscribe({"forced", "routine", "power_source_change", "system_woke"}, function()
  sbar.exec("pmset -g batt", function(battery_info)
    local label = "?"

    local found, a, charge = battery_info:find("(%d+)%%")
    if (found) then
      charge = tonumber(charge)
      label = charge .. "%"
    end
    
    battery:set({
      label = label,
    })
 end)
end)
