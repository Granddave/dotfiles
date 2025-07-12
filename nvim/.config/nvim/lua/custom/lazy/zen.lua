return {
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>go", function() require("zen-mode").toggle() end, desc = "Toggle Zen Mode" },
    },
  },
}
