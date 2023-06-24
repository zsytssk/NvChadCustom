local M = {}

M.get_buffer_info = function(buffer)
  local info
  local list = vim.fn.getbufinfo(buffer)
  for _, v in pairs(list) do
    if v.bufnr == buffer then
      info = v
      break
    end
  end
  return info
end

M.is_buffer_changed = function(buffer)
  local info = M.get_buffer_info(buffer)
  if info == nil or info.changed == 0 then
    return false
  end
  return true
end

return M
