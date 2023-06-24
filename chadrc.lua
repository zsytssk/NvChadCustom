---@type ChadrcConfig

local M = {}
M.ui = {
  theme = "ashes",
  transparency = true,
  nvdash = { load_on_startup = true },
  hl_override = require "custom.highlights",
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
