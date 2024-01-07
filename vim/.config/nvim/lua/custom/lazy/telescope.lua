return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make"
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        winblend = 5,
        layout_config = {
          horizontal = {
            width = 0.95
          },
        },
        layout_strategy = "vertical",
      },
      pickers = {
        live_grep = {
          -- additional_args = function(opts)
          --   return { "--hidden" }
          -- end
        },
        find_files = {
          -- hidden = true,
        },
      },
    },
    config = function()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("harpoon")

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      local actions = require("telescope.actions")

      map("n", "<Leader>ff", function() builtin.find_files() end, opts)
      map("n", "<Leader>fdf", function()
        vim.cmd([[cd ~/.dotfiles]])
        builtin.find_files()
      end, opts)
      map("n", "<Leader>fnv", function()
        vim.cmd([[cd ~/.config/nvim]])
        builtin.find_files()
      end, opts)
      map("n", "<Leader>fg", function() builtin.git_files() end, opts)
      map("n", "<Leader>fr", function() builtin.live_grep() end, opts)
      map("n", "<Leader>fb", function()
        builtin.buffers({
          attach_mappings = function(_, attach_map)
            attach_map("n", "D", function(prompt_bufnr)
              actions.delete_buffer(prompt_bufnr)
            end)
            return true
          end
        })
      end, opts)
      map("n", "<Leader>fh", function() builtin.help_tags() end, opts)
      map("n", "<Leader>ss", function()
        builtin.spell_suggest(themes.get_cursor({
          layout_config = {
            height = 20
          },
        }))
      end, opts)
      map("n", "<Leader>sft", function() builtin.filetypes(themes.get_dropdown({})) end, opts)
      map("n", "<Leader>tr", function() builtin.resume() end, opts)
    end
  },
}
