local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvim_tree.setup({
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
  actions = {
    open_file = {
      resize_window = false,
    }
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
vim.keymap.set("n", "<Leader>fe", "<Cmd>NvimTreeFindFile<CR>", { noremap = true, silent = true })
