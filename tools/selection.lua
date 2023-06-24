local tool_str = require "custom.tools.str"
local tool_tab = require "custom.tools.table"
local M = {}

M.get_select_region = function()
  local mode = vim.fn.mode()
  local s1 = vim.fn.getcharpos "v"
  local e1 = vim.fn.getcharpos "."
  local s2, e2 = tool_tab.unpack(M.normal_range({ s1[2], s1[3] }, { e1[2], e1[3] }))
  if mode == "V" then
    s2[2] = 1
    local ev_end = vim.fn.strlen(vim.fn.getline(e2[1])) + 1
    if ev_end > e2[2] then
      e2[2] = ev_end
    end
  end
  return { s2, e2 }
end

-- 处理 选区颠倒的问题
M.normal_range = function(s, e)
  if s[1] > e[1] then
    return { e, s }
  end
  if s[1] == e[1] and s[2] > e[2] then
    return { e, s }
  end
  return { s, e }
end

M.is_on_line_break = function(buffer, pos)
  local line_index = pos[1]
  local line_str = vim.api.nvim_buf_get_lines(buffer, line_index - 1, line_index, false)[1]
  if pos[2] > tool_str.len(line_str) then
    return true
  end
  return false
end

M.get_next_line_break = function(buffer, pos)
  local line_index = pos[1]
  local line_str = vim.api.nvim_buf_get_lines(buffer, line_index - 1, line_index, false)[1]
  if pos[2] == tool_str.len(line_str) then
    return { pos[1], pos[2] + 1 }
  end
  return nil
end

M.get_prev_line_break = function(buffer, pos)
  local line_index = pos[1]
  if pos[2] ~= 0 then
    return nil
  end
  local prev_line_str = vim.api.nvim_buf_get_lines(buffer, line_index - 2, line_index - 1, false)[1]
  local prev_line_len = tool_str.len(prev_line_str)
  return { pos[1] - 1, prev_line_len + 1 }
end

M.set_selection = function(s, e)
  vim.cmd ':normal! v"_y'
  vim.fn.setcharpos("'<", { 0, s[1], s[2], 0 })
  vim.fn.setcharpos("'>", { 0, e[1], e[2], 0 })
  vim.cmd ":normal! gv"
end

M.get_range_text = function(buffer, range)
  local s = range[1]
  local e = range[2]
  local text = {}
  for i = s[1], e[1] do
    local line_str = vim.api.nvim_buf_get_lines(buffer, i - 1, i, false)[1]
    local line_len = tool_str.len(line_str)
    if i == s[1] and i == e[1] then
      local si = s[2]
      local ei = e[2]
      if ei > line_len then
        ei = line_len
      end
      local str = tool_str.sub_str(line_str, si, ei)
      table.insert(text, str)
    elseif i < e[1] then
      if i == s[1] then
        local str = tool_str.sub_str(line_str, s[2], line_len)
        table.insert(text, str)
      else
        table.insert(text, line_str)
      end
    else
      local ei = e[2]
      if ei > line_len then
        ei = line_len
      end
      if ei <= 1 then
        table.insert(text, "")
      else
        local str = tool_str.sub_str(line_str, 1, ei)
        table.insert(text, str)
      end
    end
  end
  return text
end

M.dulp_range_text = function(buffer, range)
  local s = range[1]
  local e = range[2]
  local text = {}
  local lines_text = {}
  for i = s[1], e[1] do
    local line_str = vim.api.nvim_buf_get_lines(buffer, i - 1, i, false)[1]
    local line_len = tool_str.len(line_str)
    table.insert(lines_text, line_str)

    if i == s[1] and i == e[1] then
      local si = s[2]
      local ei = e[2]
      if ei > line_len then
        ei = line_len
      end
      local str = tool_str.sub_str(line_str, si, ei)
      table.insert(text, str)
    elseif i < e[1] then
      if i == s[1] then
        local str = tool_str.sub_str(line_str, s[2], line_len)
        table.insert(text, str)
      else
        table.insert(text, line_str)
      end
    else
      local ei = e[2]
      if ei > line_len then
        ei = line_len
      end
      if ei <= 1 then
        table.insert(text, "")
      else
        local str = tool_str.sub_str(line_str, 1, ei)
        table.insert(text, str)
      end
    end
  end
  return text
end

-- 将坐标位置转化为 整个文本的index
M.pos_to_index = function(buffer, pos, eol)
  local cur_line = pos[1]
  local cur_col = pos[2]
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, cur_line, false)
  local index = 0
  for i, v in pairs(lines) do
    if i < cur_line or eol then
      index = index + tool_str.len(v)
    else
      index = index + cur_col
    end
  end
  return index
end

-- 将index转化为坐标位置
M.index_to_pos = function(buffer, index)
  local buffer_lines = vim.api.nvim_buf_line_count(buffer)
  local move_index = 0
  for i = 1, buffer_lines do
    -- for i = 1, 1 do
    local line_str = vim.api.nvim_buf_get_lines(buffer, i - 1, i, false)[1]
    local line_len = tool_str.len(line_str)
    local line_end_index = move_index + line_len
    if line_end_index >= index then
      return { i, index - move_index }
    end
    move_index = move_index + line_len
  end
end

return M
