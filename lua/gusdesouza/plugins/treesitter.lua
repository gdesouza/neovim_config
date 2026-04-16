-- nvim-treesitter is now a parser manager only (rewritten API, no nvim-treesitter.configs).
-- Highlighting, indent, and selection are Neovim built-ins.

-- Enable treesitter highlighting for all supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- Enable treesitter indentation for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "bash", "c", "css", "dockerfile", "html",
    "javascript", "json", "lua", "markdown", "python",
    "typescript", "yaml",
  },
  callback = function()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Auto-close HTML/JSX tags
require("nvim-ts-autotag").setup()
