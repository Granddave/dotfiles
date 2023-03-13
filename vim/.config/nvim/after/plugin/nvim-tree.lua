local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvim_tree.setup({
  view = {
    adaptive_size = false,
    width = 35,
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
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    api.config.mappings.default_on_attach(bufnr)

    local opts = function(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    local remove = function(mode, binding)
      -- The dummy set before del is done for safety, in case a default mapping does not exist.
      vim.keymap.set(mode, binding, '', { buffer = bufnr })
      vim.keymap.del(mode, binding, { buffer = bufnr })
    end
    remove("n", "<C-e>") -- Scroll

    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
    remove("n", "C")
    vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
  end
})

vim.keymap.set("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fe", "<Cmd>NvimTreeFindFile<CR>", { noremap = true, silent = true })
