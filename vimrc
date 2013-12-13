" The Coeso VimRC

" General
set wildmenu
set viminfo=

" Disable backups
set nobackup
set noswapfile
set nowritebackup

" Colors - theme
filetype on
" filetype plugin on
syntax on
colorscheme elflord
set background=dark

" Tabs to spaces & column
set expandtab
set nostartofline
set shiftwidth=4
set tabstop=4

set number
set colorcolumn=80
set ruler
set title

" Cursor column & line
highlight CursorColumn ctermbg=DarkGray
highlight ColorColumn ctermbg=DarkGray
" set cursorline
set cursorcolumn

" Indentation
" filetype plugin indent on
" set autoindent

" Search
set hlsearch
set ignorecase
set incsearch

" Font and Window
set encoding=utf-8

" Shortcuts
map 0 ^
