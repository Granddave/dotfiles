return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        fullscreen = true,
      },
    },
    keys = {
      { "<Leader>tr", function() require("fzf-lua").resume() end,    desc = "Resume FZF" },
      { "<Leader>ff", function() require("fzf-lua").files() end,     desc = "Find Files" },
      { "<Leader>fg", function() require("fzf-lua").git_files() end, desc = "Find Git Files" },
      {
        "<Leader>fr",
        function()
          require("fzf-lua").live_grep(
            {
              actions = {
                ["ctrl-h"] = require("fzf-lua.actions").toggle_hidden,
              },
            }
          )
        end,
        desc = "Live Grep"
      },
      {
        "<Leader>fr", -- live_grep on selected text
        mode = "v",
        function()
          local _, start_line, start_col, _ = unpack(vim.fn.getpos("v"))
          local _, end_line, end_col, _ = unpack(vim.fn.getpos("."))

          -- Ensure start <= end
          if start_line > end_line or (start_line == end_line and start_col > end_col) then
            start_line, end_line = end_line, start_line
            start_col, end_col = end_col, start_col
          end

          local text = vim.api.nvim_buf_get_text(
            0,              -- current buffer
            start_line - 1, -- 0-indexed
            start_col - 1,
            end_line - 1,
            end_col,
            {}
          )
          local query = table.concat(text, "\n")
          require("fzf-lua").live_grep(
            {
              search = query,
              actions = {
                ["ctrl-h"] = require("fzf-lua.actions").toggle_hidden,
              },
            }
          )
        end,
      },
      { "<Leader>fb", function() require("fzf-lua").buffers() end,  desc = "Buffers" },
      { "<Leader>fh", function() require("fzf-lua").helptags() end, desc = "helptags" },
      {
        "<Leader>ss",
        function()
          require("fzf-lua").spell_suggest({
            winopts = {
              backdrop = 100,
              fullscreen = false,
            },
          })
        end,
        desc = "Spell Suggest"
      },
      {
        "<Leader>sft",
        function()
          require("fzf-lua").filetypes({
            winopts = {
              height = 20,
              width = 50,
              fullscreen = false,
            },
          })
        end,
        desc = "Filetypes",
      },
    },
  }
}
