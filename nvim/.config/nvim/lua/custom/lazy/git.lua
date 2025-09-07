return {
  "lewis6991/gitsigns.nvim",
  opts = {
    numhl = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 100,
    },
    sign_priority = 50,
    on_attach = function(bufnr)
      _ = bufnr
      local gitsigns = require("gitsigns")

      require("which-key").add({
        -- Navigation
        {
          "<leader>gn",
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end,
          desc = "Git: Next Hunk",
        },
        {
          "<leader>gp",
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end,
          desc = "Git: Previous Hunk",
        },

        -- Staging
        { "<leader>ga",  gitsigns.stage_hunk,                   desc = "Git: Stage/Unstage Hunk", mode = { "n" } },
        {
          "<leader>ga",
          function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
          desc = "Git: Stage Hunk/Unstage (Visual)",
          mode = { "v" }
        },
        {
          "<leader>gR",
          function()
            local confirm = vim.fn.confirm("Are you sure you want to reset this hunk?", "&Yes\n&No", 2)
            if confirm == 1 then
              gitsigns.reset_hunk()
            end
          end,
          desc = "Git: Reset Hunk",
          mode = { "n" }
        },
        {
          "<leader>gR",
          function()
            local confirm = vim.fn.confirm("Are you sure you want to reset the selection?", "&Yes\n&No", 2)
            if confirm == 1 then
              gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end
          end,
          desc = "Git: Reset Hunk (Visual)",
          mode = { "v" }
        },

        { "<leader>ghp", gitsigns.preview_hunk,                 desc = "Git: Preview Hunk" },
        { "<Leader>gd",  gitsigns.diffthis,                     desc = "Git: Diff This (Index)" },
        { "<Leader>gD",  function() gitsigns.diffthis("~") end, desc = "Git: Diff This (HEAD)" },
        { "<Leader>gs",  gitsigns.show,                         desc = "Git: Show" },
        { "<Leader>gb",  gitsigns.blame_line,                   desc = "Git: Blame Line" },
        { "<Leader>gB",  gitsigns.blame,                        desc = "Git: Blame File" },
      })
    end
  },
}
