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

-- All plugins must be added to rtp BEFORE vim.loader.enable() builds its cache.
-- vim.pack only supports: src, name, version, data — no config callbacks.
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

  -- Treesitter
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

-- ── Plugin setup ──────────────────────────────────────────────────────────────

-- Colorscheme
require("catppuccin").setup()
vim.cmd([[colorscheme catppuccin]])

-- Bufferline
require("bufferline").setup({
  options = {
    mode = "tabs",
    separator_style = "slant",
  },
})

-- Lualine
local colors = {
  blue = "#65D1FF",
  green = "#3EFFDC",
  violet = "#FF61EF",
  yellow = "#FFDA7B",
  red = "#FF4A4A",
  fg = "#c3ccdc",
  bg = "#112638",
  inactive_bg = "#2c3043",
}

local my_lualine_theme = {
  normal = {
    a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  insert = {
    a = { bg = colors.green, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  visual = {
    a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  command = {
    a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  replace = {
    a = { bg = colors.red, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  inactive = {
    a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
    b = { bg = colors.inactive_bg, fg = colors.semilightgray },
    c = { bg = colors.inactive_bg, fg = colors.semilightgray },
  },
}

require("lualine").setup({
  options = {
    theme = my_lualine_theme,
  },
  sections = {
    lualine_x = {
      { "encoding" },
      { "fileformat" },
      { "filetype" },
    },
  },
})

-- Alpha dashboard
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                                ",
  "  █████╗ ██╗   ██╗██╗██████╗ ██████╗  ██████╗ ████████╗███████╗ ",
  " ██╔══██╗██║   ██║██║██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝ ",
  " ███████║██║   ██║██║██║  ██║██████╔╝██║   ██║   ██║   ███████╗ ",
  " ██╔══██║╚██╗ ██╔╝██║██║  ██║██╔══██╗██║   ██║   ██║   ╚════██║ ",
  " ██║  ██║ ╚████╔╝ ██║██████╔╝██████╔╝╚██████╔╝   ██║   ███████║ ",
  " ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═════╝ ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝ ",
  "                                                                ",
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
  dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
  dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
  dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
  dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
}

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt_local.foldenable = false
  end,
})

-- Dressing
require("dressing").setup()

-- Which-key
vim.o.timeout = true
vim.o.timeoutlen = 500
require("which-key").setup()

-- Nvim-tree
require("nvim-tree").setup({
  view = {
    width = 35,
    relativenumber = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open = "",
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  filters = {
    custom = { ".DS_Store" },
  },
  git = {
    ignore = false,
  },
})

local keymap = vim.keymap
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- Auto-session
local auto_session = require("auto-session")

auto_session.setup({
  auto_restore_enabled = false,
  auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
})

keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })

-- Vim-maximizer
keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })

-- Gitsigns
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    map("n", "]h", gs.next_hunk, "Next Hunk")
    map("n", "[h", gs.prev_hunk, "Prev Hunk")
    map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
    map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Stage hunk")
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Reset hunk")
    map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
    map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
    map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
    map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, "Blame line")
    map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
    map("n", "<leader>hd", gs.diffthis, "Diff this")
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end, "Diff this ~")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
  end,
})

-- Indent-blankline
require("ibl").setup({
  indent = { char = "┊" },
})

-- Telescope
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
})

telescope.load_extension("fzf")

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "bash", "c", "css", "dockerfile", "html", "javascript",
    "json", "lua", "markdown", "python", "typescript", "yaml",
  },
  callback = function()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Nvim-ts-autotag
require("nvim-ts-autotag").setup()

-- Nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

-- Nvim-autopairs
local autopairs = require("nvim-autopairs")

autopairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Marp
require("marp").setup({
  port = 45678,
  wait_for_response_timeout = 30,
  wait_for_response_delay = 1,
})

-- Markdown-preview
vim.g.mkdp_filetypes = { "markdown" }
