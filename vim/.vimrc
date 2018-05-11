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
Plugin 'scrooloose/nerdtree'
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


set tabstop=4   " Tab set to 4 wide
set expandtab   " Tab expands to spaces
set wrap        " Wrap words visually
set linebreak   " Don't split words in a word wrap
set textwidth=0 " Prevent Vim from automatically inserting line breaks
set wrapmargin=0 " The number of spaces from right margin to wrap from. 0 disables newline
set nolist      " list shows hidden characters such as newline. 
set number      " Show line numbers
set mouse=a     " Enable mouse click to move cursor
" colorscheme slate
set backspace=indent,eol,start " Allow backspace in insert mode
set history=50  " Default 8


noremap <F12> :NERDTreeToggle<CR>
autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!python3' shellescape(@%, 1)<cr>
autocmd FileType r nnoremap <buffer> <F5> :w<cr>:exec '!Rscript' shellescape(@%, 1)<cr>
