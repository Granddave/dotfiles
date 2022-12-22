local ok, trouble = pcall(require, "trouble")
if not ok then
  return
end

trouble.setup({
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "<Leader>qt", "<Cmd>TroubleToggle<CR>", opts)
map("n", "<Leader>qw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", opts)
map("n", "<Leader>qd", "<Cmd>TroubleToggle document_diagnostics<CR>", opts)
map("n", "<Leader>ql", "<Cmd>TroubleToggle loclist<CR>", opts)
map("n", "<Leader>qq", "<Cmd>TroubleToggle quickfix<CR>", opts)
map("n", "gR", "<Cmd>TroubleToggle lsp_references<CR>", opts)
