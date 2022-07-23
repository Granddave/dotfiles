local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<F10>", ":Goyo<CR>", opts)
map("i", "<F10>", "<Esc>:Goyo<CR>a", opts)
