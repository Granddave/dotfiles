require("nvim-tree").setup({
  view = {
    adaptive_size = true,
    width = 40,
  },
  renderer = {
    icons = {
      git_placement = "after",
    },
  },
  git = {
    ignore = false,
  },
})

vim.keymap.set("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
