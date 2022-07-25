require('telescope').setup({
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<Leader>fg", ":Telescope git_files<CR>", opts)
map("n", "<Leader>fr", ":Telescope live_grep<CR>", opts)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opts)
map("n", "<Leader>fs", ":Telescope lsp_dynamic_workspace_symbols<CR>", opts)
