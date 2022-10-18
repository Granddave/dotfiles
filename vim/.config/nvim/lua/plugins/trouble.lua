require("trouble").setup({
})

vim.keymap.set("n", "<Leader>qt", "<Cmd>TroubleToggle<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>qw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>qd", "<Cmd>TroubleToggle document_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>ql", "<Cmd>TroubleToggle loclist<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>qq", "<Cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<Cmd>TroubleToggle lsp_references<CR>", { silent = true, noremap = true })
