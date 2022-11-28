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

vim.opt.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»'

vim.opt.showmatch = true
vim.opt.updatetime = 500

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.foldmethod = 'marker'

vim.opt.cursorline = true
local cursorline_au_group = vim.api.nvim_create_augroup("CursorLine", {})
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  callback = function() vim.opt.cursorline = true end,
  group = cursorline_au_group,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
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
    vim.o.shada = ""
    vim.o.swapfile = false
    vim.o.undofile = false
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.shelltemp = false
    vim.o.history = 0
    vim.o.modeline = false
    vim.o.secure = true
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {}),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 70 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  group = vim.api.nvim_create_augroup("GitCommitJiraKey", {}),
  callback = function()
    -- Get first line (Git commit subject line)
    local subject_line_index = 0
    local commit_subject_line = vim.api.nvim_buf_get_lines(0, subject_line_index, subject_line_index + 1, false)[1]
    if commit_subject_line ~= "" then
      -- Don't override subject line from e.g. `commit --amend`
      return
    end
    local branch = require("custom.utils").get_branch_name()
    if branch == "" then
      return
    end
    local jira_key = require("custom.utils").find_jira_key(branch)
    if jira_key == "" then
      return
    end
    -- Set the Jira key to the begining of the line and change to insert mode
    -- at the end of the line.
    commit_subject_line = jira_key .. " "
    vim.api.nvim_buf_set_lines(0, subject_line_index, subject_line_index + 1, false, { commit_subject_line })
    vim.cmd("startinsert!")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("HelpVertical", {}),
  pattern = "help",
  callback = function()
    vim.cmd("wincmd L")
    vim.cmd("vert resize 80")
  end,
})
