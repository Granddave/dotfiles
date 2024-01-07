return {
  { "numToStr/Comment.nvim",  opts = {} },
  { "kylechui/nvim-surround", opts = {} },
  { "ojroques/nvim-osc52",    opts = {} },
  {
    "jkramer/vim-checkbox",
    config = function()
      vim.keymap.set("", "<Leader>x", ":call checkbox#ToggleCB()<CR>", { noremap = true, silent = true })
    end
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
