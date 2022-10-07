require('telescope').setup({
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')
map("n", "<Leader>ff", function() telescope.find_files() end, opts)
map("n", "<Leader>fg", function() telescope.git_files() end, opts)
map("n", "<Leader>fr", function() telescope.live_grep() end, opts)
map("n", "<Leader>fb", function() telescope.buffers() end, opts)
map("n", "<Leader>fh", function() telescope.help_tags() end, opts)
