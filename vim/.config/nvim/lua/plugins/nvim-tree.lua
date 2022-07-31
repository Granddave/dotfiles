require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      }
    }
  }
})

vim.keymap.set("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
