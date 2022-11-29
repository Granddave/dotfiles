require('telescope').setup({
  defaults = {
    winblend = 5,
    layout_config = {
      horizontal = {
        width = 0.95
      },
    },
  },
  pickers = {
    live_grep = {
      additional_args = function(opts)
        return { "--hidden" }
      end
    },
    find_files = {
      hidden = true,
    },
  },
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('harpoon')

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')
local themes = require('telescope.themes')

map("n", "<Leader>ff", function() telescope.find_files() end, opts)
map("n", "<Leader>fnv",
  function()
    vim.cmd([[cd ~/.config/nvim]])
    telescope.find_files()
  end, opts
)
map("n", "<Leader>fg", function() telescope.git_files() end, opts)
map("n", "<Leader>fr", function() telescope.live_grep() end, opts)
map("n", "<Leader>fb", function() telescope.buffers() end, opts)
map("n", "<Leader>fh", function() telescope.help_tags() end, opts)
map("n", "<Leader>ss",
  function()
    telescope.spell_suggest(themes.get_cursor({
      layout_config = {
        height = 20
      },
    }))
  end, opts
)
map("n", "<Leader>sft", function() telescope.filetypes(themes.get_dropdown({})) end, opts)
