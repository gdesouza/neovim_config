return {
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        lazy = false,
        priority = 1000,
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}

-- return {
--   {
--     "folke/tokyonight.nvim",
--     config = function()
--       require("tokyonight").setup({
--         lazy = false,
--         priority = 1000,
--         opts = {},
--       })
--       vim.cmd([[colorscheme tokyonight-night]])
--     end,
--   },
-- }
