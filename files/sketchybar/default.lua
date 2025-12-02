local settings = require("settings")

sbar.default({
  updates = "when_shown",

  icon = {
    font = settings.font,
    color = settings.default.colour,
    padding_left = settings.padding,
    padding_right = settings.padding,
  },

  label = {
    font = settings.font,
    color = settings.default.colour,
    padding_left = settings.padding,
    padding_right = settings.padding * 3
  }
})

