set nocompatible              " be iMproved, required
filetype off                  " required <<========== We can turn it on later

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" <============================================>
" Specify the plugins you want to install here.
" We'll come on that later
"Plugin 'lyuts/vim-rtags'
Plugin 'scrooloose/nerdtree'        " File explorer
Plugin 'ctrlpvim/ctrlp.vim'         " Fuzzy file finder
Plugin 'tpope/vim-commentary.git'   " Comment/Uncomment
Plugin 'junegunn/goyo.vim'          " Distraction free writing
" <============================================>
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Put the rest of your .vimrc file here

syntax on
filetype on

"colorscheme slate

set tabstop=4       " Tab set to 4 wide
set expandtab       " Tab expands to spaces
set wrap            " Wrap words visually
set linebreak       " Don't split words in a word wrap
set textwidth=0     " Prevent Vim from automatically inserting line breaks
set wrapmargin=0    " The number of spaces from right margin to wrap from. 0 disables newline
set nolist          " list shows hidden characters such as newline. 
set number          " Show line numbers
set relativenumber  " Show line numbers relative to the cursor position
set mouse=a         " Enable mouse click to move cursor
set showmatch       " Show matching perenthesis
set backspace=indent,eol,start " Allow backspace in insert mode
set history=50  " Default 8

" Search
set ignorecase
set smartcase
" Highligting search
set hlsearch
set incsearch

" Esc to remove search findings
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
"map <ScrollWheelUp> <C-Y>
"map <ScrollWheelDown> <C-E>

" I need to break my habit...
" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Map ctrl+c to copy to system clipboard when in visual mode
" Requires gvim(arch?) or vim-gui-common (Debian)
vnoremap <C-c> "*y :let @+=@*<CR>  

noremap <F12> :NERDTreeToggle<CR>

autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!python3' shellescape(@%, 1)<cr>
autocmd FileType r nnoremap <buffer> <F5> :w<cr>:exec '!Rscript' shellescape(@%, 1)<cr>

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
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>

