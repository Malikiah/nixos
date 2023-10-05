" https://github.com/junegunn/vim-plug
" Plugins
call plug#begin('~/local/share/nvim/plugged')
" Nerd Tree allow you to browse files throw vim.
" https://github.com/preservim/nerdtree.git
Plug 'preservim/nerdtree'
"" This adds icons for nerdtree
Plug 'ryanoasis/vim-devicons'
"" LightLine is the status bar for vim
"" https://github.com/itchyny/lightline.vim.git
Plug 'itchyny/lightline.vim'
"" vim css color highlights the color for hex in vim files
"" https://github.com/ap/vim-css-color.git
"" Plug 'ap/vim-css-color'
"
Plug 'rust-lang/rust.vim'
"
Plug 'arcticicestudio/nord-vim'


call plug#end()
colorscheme nord

" This is a CTRL-F keybinding to open NERD TREE
nmap <C-F> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeChDirMode=3
" ------------------------------------------------------------------------------------------------------
" VIM LightLine
" https://github.com/itchyny/lightline.vim/blob/master/colorscheme.md
" ------------------------------------------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
" ------------------------------------------------------------------------------------------------------
" General Setup
" ------------------------------------------------------------------------------------------------------
nmap <C-t> :term<CR>
set mouse=v
set list
set hidden
set smartcase " smartcase only matches when you specify a capital 
set ignorecase " otherwise ignore cases sensitivity.
set relativenumber "shows the distance from your line top and bottom
set expandtab
set shiftwidth=4
set tabstop=4
set number
set nowrap
set scrolloff=12
set sidescrolloff=12
set autoindent
set smartindent
"set termguicolors
set clipboard^=unnamed,unnamedplus
set shell=zsh

syntax enable
filetype plugin indent on

set cursorline
set cursorcolumn
highlight CursorLine cterm=bold ctermbg=235
highlight CursorColumn cterm=bold ctermbg=235

set wildmode=longest,list,full

nnoremap <C-s> :w<CR>
" remapping window movement keys to not include pressing w
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" remapping window exit key to not include pressing w
nnoremap <C-q> <C-w>q

" Switch to the next tab
nnoremap <Tab> gt
" Switch to the previous tab
nnoremap <S-Tab> gT
" Open new tab
nnoremap <silent> <A-t> :tabnew<CR>

" Resize splits vertical and horizontal with hjkl
nnoremap <A-j> :resize -5<CR>
nnoremap <A-k> :resize +5<CR>
nnoremap <A-h> :vertical resize +5<CR>
nnoremap <A-l> :vertical resize -5<CR>

