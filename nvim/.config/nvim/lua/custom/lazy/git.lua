return {
  "lewis6991/gitsigns.nvim",
  opts = {
    numhl = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',   -- 'eol' | 'overlay' | 'right_align'
      delay = 100,
    },
    on_attach = function(bufnr)
      _ = bufnr
      -- TODO: Add range based staging and reset
      local map = vim.keymap.set
      local opts = { noremap = false, silent = true }
      local gitsigns = require("gitsigns")
      map("n", "<Leader>ga", function() gitsigns.stage_hunk() end, opts)
      map("n", "<Leader>gp", function() gitsigns.preview_hunk() end, opts)
      map("n", "<Leader>gu", function() gitsigns.undo_stage_hunk() end, opts)
      map("n", "<Leader>gd", function() gitsigns.diffthis() end, opts)
      map("n", "<Leader>gs", function() gitsigns.show() end, opts)
      map("n", "<Leader>gb", function() gitsigns.blame_line() end, opts)
    end
  },
}
