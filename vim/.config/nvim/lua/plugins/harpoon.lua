local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "<Leader>aa", function() require("harpoon.mark").add_file() end, opts)
map("n", "<Leader>at", function() require("harpoon.ui").toggle_quick_menu() end, opts)
map("n", "<Leader>ah", function() require("harpoon.ui").nav_file(1) end, opts)
map("n", "<Leader>aj", function() require("harpoon.ui").nav_file(2) end, opts)
map("n", "<Leader>ak", function() require("harpoon.ui").nav_file(3) end, opts)
map("n", "<Leader>al", function() require("harpoon.ui").nav_file(4) end, opts)
map("n", "<Leader>an", function() require("harpoon.ui").nav_next() end, opts)
map("n", "<Leader>ap", function() require("harpoon.ui").nav_prev() end, opts)
