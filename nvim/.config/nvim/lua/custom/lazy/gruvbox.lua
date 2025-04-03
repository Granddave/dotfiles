return {
  "ellisonleao/gruvbox.nvim",
  priority = false,
  init = function()
    require("gruvbox").setup({
      contrast = "hard",
    })
    vim.cmd("colorscheme gruvbox")
  end
}
