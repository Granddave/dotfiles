require('telescope').setup({
  defaults = {
    winblend = 5
  }
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('harpoon')

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')
map("n", "<Leader>ff",
  function()
    telescope.find_files({
      hidden = false,
    })
  end, opts
)
map("n", "<Leader>fnv",
  function()
    vim.cmd([[cd ~/.config/nvim]])
    telescope.find_files({
      no_ignore = true,
    })
  end, opts
)
map("n", "<Leader>fg", function() telescope.git_files() end, opts)
map("n", "<Leader>fr", function() telescope.grep_string({ search = '' }) end, opts)
map("n", "<Leader>fb", function() telescope.buffers() end, opts)
map("n", "<Leader>fh", function() telescope.help_tags() end, opts)
map("n", "<Leader>ss", function() telescope.spell_suggest() end, opts)
