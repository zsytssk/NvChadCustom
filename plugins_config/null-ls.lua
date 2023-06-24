local null_ls = require "null-ls"
local tool_bfr = require "custom.tools.buffer"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier,
  formatting.stylua,

  null_ls.builtins.diagnostics.eslint,
  null_ls.builtins.code_actions.eslint,
  lint.shellcheck,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, buffer)
    -- vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    vim.api.nvim_create_autocmd({ "FocusLost" }, {
      buffer = buffer,
      callback = function()
        local buffer_changed = tool_bfr.is_buffer_changed(buffer)
        if not buffer_changed then
          return
        end

        vim.schedule(function()
          vim.api.nvim_buf_call(buffer, function()
            vim.cmd "w"
          end)
        end, 100)
      end,
    })

    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = buffer }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = buffer,
        callback = function()
          vim.lsp.buf.format { bufnr = buffer }
        end,
      })
    end
  end,
}
