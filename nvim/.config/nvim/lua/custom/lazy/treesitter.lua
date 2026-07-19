return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    opts = {
      enable = false,
    },
    keys = {
      { "<Leader>ct", "<Cmd>TSContext toggle<CR>", desc = "Toggle Treesitter Context" },
    },
  }
}
