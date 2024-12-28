return {
  "ellisonleao/gruvbox.nvim",
  priority = false,
  init = function()
    require("gruvbox").setup({
      contrast = "hard",
      palette_overrides = {
        dark0_hard = "#1b1b1b",
      }
    })
    vim.cmd("colorscheme gruvbox")
  end
}
