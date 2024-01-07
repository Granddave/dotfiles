return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  init = function()
    require("gruvbox").setup({
      contrast = "hard",
    })
    vim.cmd("colorscheme gruvbox")
  end
}
