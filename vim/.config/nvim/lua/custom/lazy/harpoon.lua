return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    map("n", "<Leader>at", function() require("harpoon.ui").toggle_quick_menu() end, opts)
    map("n", "<Leader>aa", function() require("harpoon.mark").add_file() end, opts)
    map("n", "<Leader>ah", function() require("harpoon.mark").set_current_at(1) end, opts)
    map("n", "<Leader>aj", function() require("harpoon.mark").set_current_at(2) end, opts)
    map("n", "<Leader>ak", function() require("harpoon.mark").set_current_at(3) end, opts)
    map("n", "<Leader>al", function() require("harpoon.mark").set_current_at(4) end, opts)
    map("n", "<Leader>h", function() require("harpoon.ui").nav_file(1) end, opts)
    map("n", "<Leader>j", function() require("harpoon.ui").nav_file(2) end, opts)
    map("n", "<Leader>k", function() require("harpoon.ui").nav_file(3) end, opts)
    map("n", "<Leader>l", function() require("harpoon.ui").nav_file(4) end, opts)
    map("n", "<Leader>an", function() require("harpoon.ui").nav_next() end, opts)
    map("n", "<Leader>ap", function() require("harpoon.ui").nav_prev() end, opts)
  end

}
