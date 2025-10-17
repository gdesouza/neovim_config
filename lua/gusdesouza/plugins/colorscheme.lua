return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()

      require("tokyonight").setup({
      })
      -- load the colorscheme here
      local theme_file = vim.fn.expand("~/.config/nvim/theme")
      local f = io.open(theme_file, "r")
      local theme = "tokyonight-day"
      if f then
        local line = f:read("*l")
        f:close()
        if line and #line > 0 then
          theme = line
        end
      end
      vim.cmd("colorscheme " .. theme)
    end,
  },
}
