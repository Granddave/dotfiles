return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "ikatyang/tree-sitter-yaml",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    opts = {},
    keys = {
      { "<Leader>ct", "<Cmd>TSContext toggle<CR>", desc = "Toggle Treesitter Context" },
    },
  }
}
