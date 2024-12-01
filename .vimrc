" Show cursor's line number
set number

" Use line numbers relative to the cursor's line
set relativenumber

" Always see 10 lines at bottom or top
set scrolloff=10

" Use space characters instead of tabs and set tabs to 4 (https://vim.fandom.com/wiki/Indenting_source_code#Indentation_without_hard_tabs)
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Color column #100, good for knowing when you nested too deeply
set colorcolumn=100

" Set the color of the column to gray
highlight ColorColumn ctermbg=238

" Use the clipboard as the default register
" (https://vim.fandom.com/wiki/Accessing_the_system_clipboard)
set clipboard=unnamedplus

" Enable file type detection
filetype on

" Enable plugins
filetype plugin on

" Turn syntax highlighting on
syntax on

" Ignore case when searching
set ignorecase

" If search pattern contains uppercase letter, then search is case-sensitive
set smartcase

" Highlight matching characters as you type when searching
set incsearch

" Highlight the current word Vim is on differently when searching
highlight IncSearch ctermbg=238

" Highlight when searching
set hlsearch

" Do not wrap around when searchin
set nowrapscan

" Enable Vim autocompletion
set wildmenu

" List all commands when autocompleting commands
set wildmode=list:longest,full

" Turn off highlighting
nmap <ESC> :nohlsearch<CR>

" Center view when navigating
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzz
nnoremap N Nzz
