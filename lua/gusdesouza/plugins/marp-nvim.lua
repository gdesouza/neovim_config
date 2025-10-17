return {
    "mpas/marp-nvim",
    config = function()
      require("marp").setup({
        port = 45678,
        wait_for_response_timeout = 30,
        wait_for_response_delay = 1,
      })
    end,
  }
