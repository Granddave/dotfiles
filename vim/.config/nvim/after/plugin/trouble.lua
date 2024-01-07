local ok, trouble = pcall(require, "trouble")
if not ok then
  return
end

trouble.setup({
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "<leader>qt", function() trouble.toggle() end, opts)
map("n", "<leader>qw", function() trouble.toggle("workspace_diagnostics") end, opts)
map("n", "<leader>qd", function() trouble.toggle("document_diagnostics") end, opts)
map("n", "<leader>qq", function() trouble.toggle("quickfix") end, opts)
map("n", "<leader>dl", function() trouble.toggle("loclist") end, opts)
-- map("n", "<leader>dn", function() trouble.next({ skip_groups = true, jump = true }); end, opts)
-- map("n", "<leader>dp", function() trouble.previous({ skip_groups = true, jump = true }); end, opts)
