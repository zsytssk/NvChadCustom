local M = {}
local tool_tab = require "custom.tools.table"

M.toggle_wrap = function()
  if vim.wo.wrap == false then
    vim.wo.wrap = true
  else
    vim.wo.wrap = false
  end
end

M.organize_imports = function(buffer)
  -- gets the current bufnr if no bufnr is passed
  if not buffer then
    buffer = vim.api.nvim_get_current_buf()
  end

  -- params for the request
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(buffer) },
    title = "",
  }

  -- perform a syncronous request
  -- 500ms timeout depending on the size of file a bigger timeout may be needed
  vim.lsp.buf_request_sync(buffer, "workspace/executeCommand", params, 500)
end

M.insert_cur_time = function()
  local mode = vim.fn.mode()
  local text = vim.fn.strftime "%Y-%m-%d %H:%M:%S"
  vim.api.nvim_put({ text }, "c", mode == "n", true)
end

M.toggle_qfw = function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd('cclose')
  else
    vim.cmd('copen')
  end
end

M.dulplicate_selection = function()
  local direction = "next"
  local mode = vim.fn.mode()

  local buffer = vim.api.nvim_get_current_buf()
  local tool_sel = require "custom.tools.selection"

  local selection = tool_sel.get_select_region()
  local text = tool_sel.get_range_text(buffer, selection)

  local start_on_line_break = tool_sel.is_on_line_break(buffer, selection[1])
  local end_on_line_break = tool_sel.is_on_line_break(buffer, selection[2])
  local start_index = tool_sel.pos_to_index(buffer, selection[1], false)
  local end_index = tool_sel.pos_to_index(buffer, selection[2], mode == "V")
  local new_start_index = end_index + 1
  local new_end_index = new_start_index + end_index - start_index

  if mode == "V" then
    text = tool_tab.dulplicate(text)
    print(vim.inspect { selection[1][1] - 1, selection[2][1] - 1, text })
    vim.api.nvim_buf_set_lines(buffer, selection[1][1] - 1, selection[2][1], false, text)
  else
    if end_on_line_break then
      table.insert(text, 1, "")
    end
    vim.api.nvim_put(text, "c", true, false)
  end

  if direction == "next" then
    if end_on_line_break and mode ~= "V" then
      new_start_index = new_start_index - 1
      new_end_index = new_end_index - 2
    end
    local new_start_pos = tool_sel.index_to_pos(buffer, new_start_index)
    local new_end_pos = tool_sel.index_to_pos(buffer, new_end_index)
    -- print(vim.inspect { selection, { new_start_pos, new_end_pos } })
    if end_on_line_break then
      new_end_pos[2] = new_end_pos[2] + 1
    end
    tool_sel.set_selection(new_start_pos, new_end_pos)
  else
    tool_sel.set_selection(selection[1], selection[2])
  end

  if mode == "V" then
    vim.api.nvim_input "V"
  end
end

M.dulplicate_selection1 = function()
  local direction = "next"
  local mode = vim.fn.mode()

  local buffer = vim.api.nvim_get_current_buf()
  local tool_sel = require "custom.tools.selection"

  local selection = tool_sel.get_select_region()
  local text = tool_sel.get_range_text(buffer, selection)

  print(vim.inspect { selection })
  local start_on_line_break = tool_sel.is_on_line_break(buffer, selection[1])
  local end_on_line_break = tool_sel.is_on_line_break(buffer, selection[2])
  local start_index = tool_sel.pos_to_index(buffer, selection[1], false)
  local end_index = tool_sel.pos_to_index(buffer, selection[2], mode == "V")
  local new_start_index = end_index + 1
  local new_end_index = new_start_index + end_index - start_index

  if mode == "V" then
    text = tool_tab.dulplicate(text)
    print(vim.inspect { selection[1][1] - 1, selection[2][1] - 1, text })
    vim.api.nvim_buf_set_lines(buffer, selection[1][1] - 1, selection[2][1], false, text)
  else
    if end_on_line_break then
      table.insert(text, 1, "")
    end
    vim.api.nvim_put(text, "c", true, false)
  end

  if direction == "next" then
    if end_on_line_break and mode ~= "V" then
      new_start_index = new_start_index - 1
      new_end_index = new_end_index - 2
    end
    local new_start_pos = tool_sel.index_to_pos(buffer, new_start_index)
    local new_end_pos = tool_sel.index_to_pos(buffer, new_end_index)
    -- print(vim.inspect { selection, { new_start_pos, new_end_pos } })
    if end_on_line_break then
      new_end_pos[2] = new_end_pos[2] + 1
    end
    tool_sel.set_selection(new_start_pos, new_end_pos)
  else
    tool_sel.set_selection(selection[1], selection[2])
  end

  if mode == "V" then
    vim.api.nvim_input "V"
  end
end

M.test = function()
  -- local tool_sel = require "custom.tools.selection"
  -- local selection = tool_sel.get_select_region()
  -- local buffer = vim.api.nvim_get_current_buf()
  M.toggle_qfw()
  -- local text = tool_sel.get_range_text(buffer, selection)
  -- M.dulplicate_selectio1()
end

return M
