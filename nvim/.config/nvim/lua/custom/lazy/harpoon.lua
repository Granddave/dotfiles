return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    local harpoon = require("harpoon")
    map("n", "<leader>aa", function() harpoon:list():add() end, opts)
    map("n", "<Leader>at", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)
    map("n", "<Leader>h", function() harpoon:list():select(1) end, opts)
    map("n", "<Leader>j", function() harpoon:list():select(2) end, opts)
    map("n", "<Leader>k", function() harpoon:list():select(3) end, opts)
    map("n", "<Leader>l", function() harpoon:list():select(4) end, opts)
  end

}
