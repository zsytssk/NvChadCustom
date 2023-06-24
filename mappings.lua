-- n, v, i, t = mode names
local M = {}

M.general = {
  i = {
    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "save file" },
    ["<A-S-i>"] = {
      function()
        require("custom.utils").insert_cur_time()
      end,
      "insert time",
    },
  },
  n = {
    ["<A-S-i>"] = {
      function()
        require("custom.utils").insert_cur_time()
      end,
      "insert time",
    },
    ["<C-d>"] = { "<C-d>zz", "move down" },
    ["<C-u>"] = { "<C-u>zz", "move up" },
    ["n"] = { "nzzzv", "find down" },
    ["N"] = { "Nzzzv", "find up" },
    ["<leader>hh"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "harpoon open" },
    ["<leader>ha"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "harpoon add file" },
    ["<leader>h1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "harpoon nav_file 1" },
    ["<leader>h2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "harpoon nav_file 2" },
    ["<leader>h3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "harpoon nav_file 3" },
    ["<leader>h4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "harpoon nav_file 4" },
    -- save
    ["<leader>fs"] = {
      function()
        require("telescope.builtin").resume()
      end,
      "telescope last search",
    },
    ["z="] = {
      function()
        require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor {})
      end,
      "telescope spell suggest",
    },
    ["gr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "telescope lsp_references",
    },
    ["<leader>S"] = { "<cmd>lua require('spectre').open()<CR>", "global find replace" },
    ["<leader>gg"] = { "<cmd> VimBeGood <CR>", "open vim_be_good" },
    ["<leader>gm"] = { "<cmd> messages <CR>", "open vim_be_good" },
    ["<leader>tc"] = { "<cmd> TextCaseOpenTelescope <CR>", "textcase open" },
    ["<leader>na"] = { "<cmd> Nvdash <CR>", "toggle nvdash" },
    ["<leader>u"] = { "<cmd> UndotreeToggle <CR>", "undo tree" },
    ["<leader>m"] = { "<cmd> TSJToggle <CR>", "treesj toggle" },
    ["<leader>og"] = { "<cmd> OrganizeImports <CR>", "organize imports" },
    ["<leader>kw"] = {
      function()
        require("close_buffers").wipe { type = "all", force = true }
      end,
      "close all buffers",
    },
    ["<leader>cf"] = { "<cmd> echo expand('%:p') <CR>", "show current file name" },
    ["<A-z>"] = {
      function()
        require("custom.utils").toggle_wrap()
      end,
      "save file",
    },
    ["<leader>pp"] = {
      "<cmd> Telescope workspaces <CR>",
      "find workspaces",
    },
    ["<A-t>"] = {
      "<cmd>lua require('custom.utils').toggle_qfw()<CR>",
      "toggle_quick_menu",
    },
  },
  v = {
    ["<A-t>"] = {
      function()
        require("custom.utils").test()
      end,
      "test",
    },
    -- save
    ["<A-p>"] = { "yP<esc>gv", "copy lines down", opts = { silent = true } },
    ["<A-S-P>"] = { "ygv<esc>pgv", "copy lines up", opts = { silent = true } },
    ["J"] = { ":m '>+1<CR>gv=gv", "move lines down", opts = { silent = true } },
    ["K"] = { ":m '<-2<CR>gv=gv", "move lines up", opts = { silent = true } },
    ["R"] = { '"xy:@x<CR>', "vim.cmd select text" },
  },
}

return M
