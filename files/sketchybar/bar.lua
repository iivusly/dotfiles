local settings = require("settings")

sbar.bar({
  height = settings.bar.height,
  notch_display_height = 30, -- TODO: add this to settings
  color = settings.bar.background,
  blur_radius = 30
})

