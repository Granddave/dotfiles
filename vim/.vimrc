" ---- Vundle {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'lyuts/vim-rtags'
Plugin 'scrooloose/nerdtree'        " File explorer
Plugin 'ctrlpvim/ctrlp.vim'         " Fuzzy file finder
Plugin 'tpope/vim-commentary.git'   " Comment/Uncomment
Plugin 'junegunn/goyo.vim'          " Distraction free writing
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
call vundle#end()
filetype plugin indent on

" }}}
" ---- YouCompleteMe {{{

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
nnoremap <F2> :YcmCompleter GoTo<CR>

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" }}}

syntax on
filetype on

" ---- Colors {{{
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic=1
set background=dark
set termguicolors

let g:airline#extensions#tabline#enabled = 1

hi Search ctermbg=Yellow ctermfg=Black
hi MatchParen ctermfg=Black ctermbg=Yellow

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?


hi Pmenu ctermbg=Blue
hi PmenuSel ctermbg=Green

if &diff
    syntax off
endif

set cursorline
noremap <leader>cl :set cursorline!<CR>
"hi CursorLine term=none cterm=none ctermbg=236
" Only show CursorLine in current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Set darker background after 80 chars (https://stackoverflow.com/a/13731714)
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=235 guibg=#2c2d27

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

autocmd BufRead,BufNewFile ~/.ssh/config.d/* set syntax=sshconfig
" }}}

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
set wrap            " Wrap words visually
set linebreak       " Don't split words in a word wrap
set textwidth=0     " Prevent Vim from automatically inserting line breaks
set wrapmargin=0    " The number of spaces from right margin to wrap from. 0 disables newline
set numberwidth=5   " Width of numberline
set number          " Show line numbers
"set relativenumber  " Show line numbers relative to the cursor position
set mouse=a         " Enable mouse click to move cursor
set ttymouse=sgr    " Enable mouse drag in tmux
set showmatch       " Show matching perenthesis
set backspace=indent,eol,start " Allow backspace in insert mode
set history=50      " Default 8

"set nolist          " Hides characters such as newline.
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
noremap <leader>sl :set list!<CR>
" Delete unwanted whitespace
noremap <silent> <leader>dw :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" ---- Buffer handling {{{

set hidden
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
nmap <leader>bl :ls<cr>

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
vnoremap // y/<C-R>"<CR>
xnoremap <leader>sr y:<C-U>let replacement = input('Enter replacement string: ') <bar> %s!<C-R>"!\=replacement!g<CR>
xnoremap <leader>sc y:<C-U>let replacement = input('Enter replacement string: ') <bar> %s!<C-R>"!\=replacement!gc<CR>
" Esc to remove search findings
nnoremap <silent><esc> :noh<CR><esc>
nnoremap <esc>^[ <esc>^[

" }}}
" ---- Navigation and editing {{{

" Scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
"map <ScrollWheelUp> <C-Y>
"map <ScrollWheelDown> <C-E>
map <C-up> <C-y>
map <C-down> <C-e>
" I need to break my habit...
" Disable Arrow keys in Normal mode
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
" Disable Arrow keys in Insert mode
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

" Move lines up or down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Don't deselect lines when indenting
vnoremap < <gv
vnoremap > >gv

set scrolloff=5
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap * *zz
"nnoremap # #zz
"nnoremap g* g*zz
"nnoremap g# g#zz

" Toggle between relative and absolute numbering
nnoremap <silent><C-l> :set rnu!<CR>

" Map ctrl+c to copy to system clipboard when in visual mode
" Requires gvim(arch?) or vim-gui-common (Debian)
vnoremap <C-c> "*y :let @+=@*<CR>:echo "Copied to system clipboard"<CR>

vnoremap p "_dP

nnoremap <leader>rc :so ~/.vimrc<CR>:echo "Config reloaded"<CR>

" }}}
" ---- Function keys {{{
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>
map <F9> :setlocal spell! spelllang=en,sv<CR>
map <silent><F10> :Goyo<CR>
inoremap <F10> <esc>:Goyo<CR>a
" <F11> for fullscreen
noremap <F12> :NERDTreeToggle<CR>

" Build/run
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType r nnoremap <buffer> <F5> :w<CR>:exec '!Rscript' shellescape(@%, 1)<CR>
nnoremap <F5> :w<CR>:!%:p<CR>

" }}}

" Snippets
autocmd FileType cpp inoremap ;co std::cout<Space><<<Space>f<Space><<<Space> std::endl;<Esc>Ffcw

function! ToggleBetweenHeaderAndSourceFile()
  let bufname = bufname("%")
  let ext = fnamemodify(bufname, ":e")
  if ext == "h"
    let ext = "cpp"
  elseif ext == "cpp"
    let ext = "h"
  else
    return
  endif
  let bufname_new = fnamemodify(bufname, ":r") . "." . ext
  let bufname_alt = bufname("#")
  if bufname_new == bufname_alt
    execute ":e#"
  else
    execute ":e " . bufname_new
  endif
endfunction

function! s:goyo_leave()
    "highlight ColorColumn ctermbg=235 guibg=#2c2d27
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

