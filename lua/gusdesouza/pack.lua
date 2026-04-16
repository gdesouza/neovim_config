-- Must be set before nvim-tree.lua is loaded via packadd
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Build hooks must be registered BEFORE vim.pack.add()
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= "install" and kind ~= "update" then return end

    if name == "nvim-treesitter" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    elseif name == "LuaSnip" then
      vim.fn.jobstart({ "make", "install_jsregexp" }, { cwd = ev.data.path })
    elseif name == "telescope-fzf-native.nvim" then
      vim.fn.jobstart({ "make" }, { cwd = ev.data.path })
    elseif name == "markdown-preview.nvim" then
      vim.fn.jobstart({ "yarn", "install" }, { cwd = ev.data.path .. "/app" })
    end
  end,
})

-- All plugins must be added to rtp BEFORE vim.loader.enable() builds its cache
vim.pack.add({
  -- Core utilities
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- Colorscheme
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

  -- UI
  { src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/goolord/alpha-nvim" },
  { src = "https://github.com/stevearc/dressing.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },

  -- File explorer & session
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/rmagatti/auto-session" },
  { src = "https://github.com/szw/vim-maximizer" },

  -- Git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  -- Indent guides
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },

  -- Telescope
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.x" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

  -- Treesitter (parsing runs per-buffer, not at startup)
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },

  -- Completion
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/onsails/lspkind.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },

  -- Presentation & markdown
  { src = "https://github.com/mpas/marp-nvim" },
  { src = "https://github.com/iamcco/markdown-preview.nvim" },

  -- Copilot
  { src = "https://github.com/github/copilot.vim" },
})

-- Build the Lua module cache now that all plugin paths are in the rtp
vim.loader.enable()

require("gusdesouza.plugins.colorscheme")
require("gusdesouza.plugins.bufferline")
require("gusdesouza.plugins.lualine")
require("gusdesouza.plugins.nvim-tree")
require("gusdesouza.plugins.auto-session")
require("gusdesouza.plugins.alpha")
require("gusdesouza.plugins.dressing")
require("gusdesouza.plugins.which-key")
require("gusdesouza.plugins.vim-maximizer")
require("gusdesouza.plugins.gitsigns")
require("gusdesouza.plugins.ident-blankline")
require("gusdesouza.plugins.telescope")
require("gusdesouza.plugins.treesitter")
require("gusdesouza.plugins.nvim-cmp")
require("gusdesouza.plugins.autopairs")
require("gusdesouza.plugins.marp-nvim")
require("gusdesouza.plugins.markdown-preview")
