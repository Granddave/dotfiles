" ---- Plugins {{{

set nocompatible
filetype off

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'scrooloose/nerdtree'        " File explorer
Plug 'junegunn/goyo.vim'          " Distraction free writing
Plug 'octol/vim-cpp-enhanced-highlight', {'for':['c', 'cpp']}
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
call plug#end()
let g:coc_disable_startup_warning = 1
filetype on
" }}}
" ---- Colors {{{
syntax on
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic=1
set background=dark
set termguicolors

let g:airline#extensions#tabline#enabled = 1

"hi Search ctermbg=Yellow ctermfg=Black
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

" CursorLine {{{
set cursorline

" Only show CursorLine in current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
" }}}

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

autocmd BufRead,BufNewFile ~/.ssh/config.d/* set syntax=sshconfig
" }}}
" ---- General {{{
let mapleader=" "

set wildmenu
set wildmode=longest:list,full
set showcmd
" http://vim.wikia.com/wiki/Indenting_source_code
set tabstop=4       " The width of a tab character
set shiftwidth=4    " Size of an 'indent', e.g. when pressing tab key
set expandtab       " Make tabs expand to spaces
set smartindent
set smarttab
set wrap            " wrap words visually
set linebreak       " Don't split words in a word wrap
set textwidth=0     " Prevent Vim from automatically inserting line breaks
set wrapmargin=0    " The number of spaces from right margin to wrap from. 0 disables newline
set numberwidth=5   " Width of numberline
set number          " Show line numbers
set mouse=a         " Enable mouse click to move cursor
if !has('nvim')
    set ttymouse=sgr
endif
set showmatch       " Show matching perenthesis
set backspace=indent,eol,start " Allow backspace in insert mode
set history=50      " Default 8

" Show/hide hidden characters
noremap <leader>sl :set list!<CR>
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

function! CleanTrailingSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

noremap <silent><leader>dw :call CleanTrailingSpaces()<cr>

autocmd FileType markdown,yaml setlocal shiftwidth=2 tabstop=2 colorcolumn=100
autocmd FileType cpp,cmake,python setlocal colorcolumn=100
autocmd BufRead,BufNewFile,BufEnter *.jrnl setlocal filetype=markdown
" }}}
" ---- Buffer handling {{{

set hidden
nmap <leader>T :enew<cr>
nmap <leader>n :bnext<cr>
nmap <leader>p :bprevious<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
nmap <leader>bd :<c-u>up <bar> %bd <bar> e#<cr>
nmap <leader>bl :ls<cr>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nnoremap <leader>m :MaximizerToggle!<CR>
" }}}
" ---- Folding {{{

" enable folding; http://vim.wikia.com/wiki/Folding
set foldmethod=marker

" Toggle fold
nnoremap <leader><leader> za

"}}}
" ---- Search {{{

set ignorecase
set smartcase
" Highlighting search
set hlsearch
set incsearch
" Search for selection
vnoremap // y/<C-R>"<CR>

xnoremap <leader>sr y:%s%<C-R>"%%g<left><left>
xnoremap <leader>sc y:%s%<C-R>"%%gc<left><left><left>
" Esc to remove search findings
nnoremap <silent> <esc> :noh<CR><esc>
nnoremap <esc>^[ <esc>^[

" Ripgrep
nnoremap <leader>sf :Files<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gr :Rg<CR>

" }}}
" ---- Navigation and editing {{{

" Scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
map <C-up> <C-y>
map <C-down> <C-e>

" Adds padding at top and bottom of screen when scrolling
set scrolloff=5

" Move lines up or down
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==
"inoremap <C-j> <Esc>:m .+1<CR>==gi
"inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Don't deselect lines when indenting
vnoremap < <gv
vnoremap > >gv

vnoremap <silent><c-c> "*y :let @+=@*<cr>:echo "copied to system clipboard"<cr>

vnoremap p "_dP

nnoremap <silent><leader>rc :so ~/.vimrc<CR>:echo "Config reloaded"<CR>
nmap <leader>w :w<CR>

" }}}
" ---- Function keys {{{
map <silent> <F4> :CocCommand clangd.switchSourceHeader<CR>
map <F9> :setlocal spell! spelllang=en,sv<CR>
map <silent><F10> :Goyo<CR>
inoremap <F10> <esc>:Goyo<CR>a
" <F11> for fullscreen
noremap § :NERDTreeToggle<CR>

" Build/run
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" }}}
" ---- CoC {{{
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=500

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
hi CocHighlightText ctermbg=Gray guibg=#555555

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)
"nmap <leader>pf  :CocCommand prettier.formatFile<CR>


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}
" ---- Debugging {{{
fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" Debugger remaps
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
"nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" <Plug>VimspectorStop
" <Plug>VimspectorPause
" <Plug>VimspectorAddFunctionBreakpoint
" }}}
