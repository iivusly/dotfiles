local colours = require("colours")
local icons = require("icons")

return {
  -- Global Settings
  font = {
    family = "JetBrainsMono Nerd Font Mono",
    style = "Bold",
    size = 12
  },

  padding = 3,

  -- Default Settings
  bar = {
    height = 22,
    background = colours.bar.background,
  },

  default = {
    colour = colours.white,
  },

}
