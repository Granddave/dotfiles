local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

map("n", "<leader>T", ":enew<cr>", {})
map("n", "<leader>n", ":bnext<cr>", {})
map("n", "<leader>p", ":bprev<cr>", {})
map("n", "<leader>bq", ":bp <BAR> bd #<cr>", {})
map("n", "<leader>bd", ":<c-u>up <bar> %bd <bar> e#<cr>", {})
map("n", "<leader>bl", ":ls<cr>", {})

local noremap = { noremap = true }
map("n", "<C-h>", ":wincmd h<CR>", noremap)
map("n", "<C-j>", ":wincmd j<CR>", noremap)
map("n", "<C-k>", ":wincmd k<CR>", noremap)
map("n", "<C-l>", ":wincmd l<CR>", noremap)

map("n", "<leader>m", ":MaximizerToggle!<CR>", noremap)
