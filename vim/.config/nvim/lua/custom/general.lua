vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:list,full'

vim.opt.tabstop = 4 -- The width of a tab character
vim.opt.shiftwidth = 4 -- Size of an 'indent', e.g. when pressing tab key
vim.opt.expandtab = true -- Make tabs expand to spaces
vim.opt.smartindent = true

vim.opt.wrap = true -- Wrap words visually
vim.opt.linebreak = true -- Don't split words in a word wrap

vim.opt.number = true -- Show line numbers
vim.opt.numberwidth = 5 -- Width of numberline
vim.opt.signcolumn = 'yes'

vim.opt.scrolloff = 4 -- Pad at top and bottom of buffer when scrolling

vim.opt.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

vim.opt.showmatch = true
vim.opt.updatetime = 500

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.foldmethod = 'marker'

vim.opt.cursorline = true
local cursorline_au_group = vim.api.nvim_create_augroup("CursorLine", {})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  buffer = 0,
  callback = function() vim.opt.cursorline = true end,
  group = cursorline_au_group,
})
vim.api.nvim_create_autocmd("WinLeave", {
  buffer = 0,
  callback = function() vim.opt.cursorline = false end,
  group = cursorline_au_group,
})

-- vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg="red" })
-- vim.cmd([[match ExtraWhitespace /\s\+$/]])
-- local trailing_whitespace_au_group = vim.api.nvim_create_augroup("TrailingWhitespace", {})
-- vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave"}, {
--   group = trailing_whitespace_au_group,
--   callback = function() vim.cmd([[match ExtraWhitespace /\s\+$/]]) end,
-- })
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   group = trailing_whitespace_au_group,
--   callback = function() vim.cmd([[match ExtraWhitespace /\s\+\%#\@<!$/]]) end,
-- })

local filetypes_au_group = vim.api.nvim_create_augroup("FiletypeSettings", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
  pattern = "*/.ssh/config.d/*",
  group = filetypes_au_group,
  callback = function() vim.opt.filetype = "sshconfig" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
  pattern = "*.jrnl",
  group = filetypes_au_group,
  callback = function()
    vim.opt.filetype = "markdown"
    vim.opt.colorcolumn = ""
    vim.keymap.set("n", "<Leader>qs", "<Cmd>read ~/sync/loggbok/qs.txt<CR>", { noremap = true })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {}),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  group = vim.api.nvim_create_augroup("GitCommitJiraKey", {}),
  callback = function()
    local commit_summary = vim.api.nvim_buf_get_lines(0, 0, 1, false)[0]
    if commit_summary ~= nil then
      return
    end
    local branch = require("custom.utils").get_branch_name()
    if branch == "" then
      return
    end
    local jira_key = require("custom.utils").find_jira_key_from_string(branch)
    if jira_key ~= "" then
      commit_summary = jira_key .. " "
      vim.api.nvim_buf_set_lines(0, 0, 1, false, { commit_summary })
      vim.cmd("startinsert!")
    end
  end
})
