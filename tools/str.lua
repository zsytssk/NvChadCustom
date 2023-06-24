local utf8 = require "utf8"
local M = {}

-- 计算lines的字符总数
M.get_lines_len = function(lines)
  local len = 0
  for _, v in pairs(lines) do
    len = len + M.len(v)
  end
  return len
end

M.len = function(str)
  -- print(vim.inspect { "len", str })
  -- if str == "" or str == nil then
  if str == "" then
    return 0
  end
  return utf8.len(str)
end

M.sub_str = function(str, s, e)
  return string.sub(str, utf8.offset(str, s), utf8.offset(str, e + 1) - 1)
end

return M
