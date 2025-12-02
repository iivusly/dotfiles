local colours = require("colours")
local settings = require("settings")

local date = sbar.add("item", {
  position = "right",
  update_freq = 5,
  background = {
    color = colours.nord.polar_night[4],
    height = settings.bar.height,
  },
})

date:subscribe({ "forced", "routine", "system_woke" }, function()
  date:set({ label = os.date("%y-%m-%d %H:%M:%S%z") })
end)
