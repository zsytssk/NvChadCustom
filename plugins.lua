-- test
local plugins = {
  --- override default plugins setting - start
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.plugins_config.null-ls"
      end,
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins_config.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      matchup = {
        enable = true,
      },
      ensure_installed = { "markdown", "html", "css", "javascript", "typescript", "tsx", "bash" },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  --- override default plugins setting - end
  { "uga-rosa/utf8.nvim" },
  { "ThePrimeagen/harpoon",           event = "VeryLazy" },
  { "ThePrimeagen/vim-be-good",       cmd = { "VimBeGood" } },
  { "christoomey/vim-tmux-navigator", lazy = false },
  { "mbbill/undotree",                cmd = { "UndotreeToggle" } },
  -- 在顶部显示当前的scope
  {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = { "TSContextEnable" },
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  { "kazhala/close-buffers.nvim" },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
  },
  -- 展开收紧函数对象等
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup {}
    end,
  },
  {
    "natecraddock/workspaces.nvim",
    cmd = { "WorkspacesAdd", "WorkspacesRemove" },
    dependencies = { "natecraddock/sessions.nvim" },
    event = "VeryLazy",
    config = function()
      require "custom.plugins_config.workspaces"
      require("telescope").load_extension "workspaces"
    end,
  },
  { "kevinhwang91/nvim-bqf",     event = "VeryLazy" },
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
  },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("barbecue").setup {}
    end,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  },
  {
    "johmsalas/text-case.nvim",
    cmd = { "TextCaseOpenTelescope" },
    config = function()
      require("textcase").setup {}
      require("telescope").load_extension "textcase"
    end,
  },
}
return plugins
