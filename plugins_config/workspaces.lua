-- /Users/zsy/.local/share/nvim/
local workspaces = require "workspaces"
local sessions = require "sessions"
local close_buffers = require "close_buffers"
local utils = require "custom.plugins_config.utils"

sessions.setup {
  events = { "WinEnter", "VimLeavePre" },
  session_filepath = utils.sessions_path,
  absolute = true,
}

local is_init = false
local init_fn = function()
  if is_init then
    return
  end
  -- is_init = true
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = { "NvimTree" },
  --   callback = function(args)
  --     vim.api.nvim_create_autocmd("VimLeavePre", {
  --       callback = function()
  --         vim.api.nvim_buf_delete(args.buf, { force = true })
  --         return true
  --       end,
  --     })
  --   end,
  -- })
  --
  -- vim.api.nvim_create_autocmd({ "BufEnter" }, {
  --   pattern = "NvimTree*",
  --   callback = function()
  --     local view = require "nvim-tree.view"
  --     local is_visible = view.is_visible()
  --
  --     local api = require "nvim-tree.api"
  --     if not is_visible then
  --       api.tree.open()
  --     end
  --   end,
  -- })
end

workspaces.setup {
  hooks = {
    open_pre = function()
      sessions.stop_autosave()
      close_buffers.wipe { type = "all", force = true }
    end,
    open = function()
      local cur_config = utils.get_cwd_workspaces_config()

      if utils.has_session(cur_config.name) then
        local session_filepath = utils.get_cwd_session_path()
        sessions.load(session_filepath, { autosave = true, silent = true })
        init_fn()
      else
        utils.save_cur_session()
      end
      print("workspaces: open " .. cur_config.name)
    end,
  },
}
vim.defer_fn(function()
  vim.schedule(function()
    local cur_config = utils.get_cwd_workspaces_config()
    if cur_config then
      workspaces.open(cur_config.name)
    end
  end)
end, 500)
