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

vim.opt.scrolloff = 4 -- Pad at top and bottom of buffer when scrolling

vim.opt.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

vim.opt.showmatch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.mouse = 'a'

vim.opt.foldmethod = "marker"

vim.opt.cursorline = true
vim.cmd([[
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
]])

vim.cmd([[
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
]])

vim.cmd([[
function! CleanTrailingSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun
]])

vim.cmd("autocmd BufRead,BufNewFile ~/.ssh/config.d/* set syntax=sshconfig")
vim.cmd("autocmd FileType markdown,yaml,lua setlocal shiftwidth=2 tabstop=2 colorcolumn=100")
vim.cmd("autocmd FileType cpp,cmake,python setlocal colorcolumn=100")
vim.cmd("autocmd BufRead,BufNewFile,BufEnter *.jrnl setlocal filetype=markdown colorcolumn=0")
