local M = {}

local dulplicate_in_line = function()
  print()
end

local dulplicate_lines = function()
  print()
end

local dulplicate = function()
  local mode = vim.fn.mode()
  if mode == "V" then
    return dulplicate_lines()
  else
    return dulplicate_in_line()
  end
end

return {
  dulplicate,
}
