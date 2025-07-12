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
    on_attach = function(bufnr)
      _ = bufnr
      local map = vim.keymap.set
      local opts = { noremap = false, silent = true }
      local gitsigns = require("gitsigns")

      -- Navigation
      map("n", "<leader>gn", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)
      map("n", "<leader>gp", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)

      -- Staging
      map("n", "<leader>ga", gitsigns.stage_hunk)
      map("v", "<leader>ga", function() gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
      map("n", "<leader>gA", gitsigns.reset_hunk)
      map("v", "<leader>gA", function() gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)

      map("n", "<leader>gdp", gitsigns.preview_hunk)
      map("n", "<Leader>gd", gitsigns.diffthis, opts)
      map("n", "<Leader>do", function() vim.cmd("windo diffoff") end, opts)
      map("n", "<Leader>gD", function() gitsigns.diffthis("~") end, opts)
      map("n", "<Leader>gs", function() gitsigns.show() end, opts)
      map("n", "<Leader>gb", function() gitsigns.blame_line() end, opts)
    end
  },
}
