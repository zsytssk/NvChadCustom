local M = {}

M.len = function(ta)
  local count = 0
  for _ in pairs(ta) do
    count = count + 1
  end
  return count
end

M.unpack = function(...)
  if table.unpack ~= nil then
    return table.unpack(...)
  end
  ---@diagnostic disable-next-line: deprecated
  return unpack(...)
end

M.dulplicate = function(tab)
  local t2 = {}
  local len = M.len(tab)
  for k, v in pairs(tab) do
    t2[k] = v
    t2[len + k] = v
  end
  return t2
  -- return {
  --   M.unpack(tab),
  --   M.unpack(tab),
  -- }
end
return M
