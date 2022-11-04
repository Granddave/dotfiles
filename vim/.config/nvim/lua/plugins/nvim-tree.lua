require("nvim-tree").setup({
  view = {
    adaptive_size = true,
    width = 35,
    mappings = {
      list = {
        { key = "<C-e>", action = "" },
        { key = "h", action = "close_node" },
        { key = "l", action = "open" },
      },
    },
  },
  renderer = {
    icons = {
      git_placement = "after",
    },
  },
  git = {
    ignore = false,
  },
  diagnostics = {
    enable = true,
  },
})

vim.keymap.set("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
