return {
  { "numToStr/Comment.nvim",  opts = {} },
  { "kylechui/nvim-surround", opts = {} },
  { "ojroques/nvim-osc52",    opts = {} },
  {
    "jkramer/vim-checkbox",
    config = function()
      vim.g.insert_checkbox_prefix = "- "
    end,
    keys = {
      {
        "<Leader>x",
        ":call checkbox#ToggleCB()<CR>",
        desc = "Toggle checkbox",
        ft = "markdown",
        mode = { "n", "v" },
      }
    }
  },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.g["strip_whitespace_on_save"] = false
      vim.g["better_whitespace_filetypes_blacklist"] = {
        "diff",
        "git",
        "gitcommit",
        "unite",
        "qf",
        "help",
        "fugitive",
      }
    end
  },
  {
    "windwp/nvim-autopairs",
    opts = {},
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("cmp").event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done()
      )
    end
  }
}
