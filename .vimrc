"call plug#begin()
"Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install  }  }
"Plug '~/.fzf'
"Plug 'itchyny/lightline.vim'
"Plug 'mcchrish/nnn.vim'
"Plug 'rust-lang/rust.vim'
"Plug 'jiangmiao/auto-pairs'
"Plug 'rafi/awesome-vim-colorschemes'
"Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'tpope/vim-unimpaired'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-vinegar'
"Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
"Plug 'Yggdroot/indentline'
"Plug 'psliwka/vim-smoothie'
"Plug 'sqwishy/vim-sqf-syntax'
"Plug 'godlygeek/tabular'
"Plug 'whiteinge/diffconflicts'
"call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"colorscheme space-vim-dark

set nocompatible
set nomodeline
filetype plugin on
syntax on

"" Show Line Numbers
set number relativenumber

"" Toggles numbering based on current mode and buffer focus
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Underline current line
set cursorline

" Show a line at column 80
set colorcolumn=80
" Always show tabline
setglobal showtabline=2

" Indentation - Hard tabs, No Spaces, 4 Char width
set autoindent " indent when moving to the next line while writing code
set tabstop=8  " Size of tab indentation
set shiftwidth=2
set softtabstop=2

" show the matching part of the pair for {} [] ()
set showmatch

"lets yoiu use backspace on previously inserted words
set backspace=indent,eol,start

" Diff mode options
set diffopt=filler,iwhite

" No automatic C style indentation
set nocindent

" Comment formatting options
set formatoptions=tcqron

" Highlight searches
set hlsearch

" Ignore case unless the search pattern has capitals
set ignorecase
set smartcase

" Searching show pattern as it's being typed
set incsearch

" Make sure status line always appears, regardless of splits
set laststatus=2

" Characters that form pairs (Jump between with %)
set matchpairs=(:),{:},[:],<:>

" How long to show matching pairs (10th of a second)
set matchtime=3

" Enable mouse for (n)ormal, (v)isual, (i)nsert, (c)ommand-line, all modes in
" (h)elp files, (a)ll modes
set mouse=a

" Show partial command in last line of the screen
set showcmd

" Where new splits will open
set splitbelow splitright

" Undo file location and enable
set undodir=~/.vim/undo
set undofile

" Characters allowed to wrap to next line on first/last character of line
set whichwrap=b,s,

" Line wrapping
set nowrap

" Set conceal level
set conceallevel=99

"How many lines to keep visibly above or below the active line
set scrolloff=6 " Vertical
set sidescrolloff=3 " Horizontal

" Autoread file if changed outside VIM
set autoread

" Allow color schemes to do bright coloers without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
    set t_Co=16
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FileType specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" YAML
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Execute the current line of text as a shell command
noremap      Q !!$SHELL<CR>

" Use <C-L> to clear search highlighting as well as refresh the screen
noremap      <silent><C-l> :let @/ = ""<CR>
inoremap     <silent><C-l> <esc>:let @/ = ""<CR>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	nnn config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start nnn in the current file's directory
nnoremap <leader>n :NnnPicker '%:p:h'<CR>

let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit',
	  \}

"""""""
" fzf "
"""""""
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d%s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'git ls-files | ctags --links=no -L-'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
let g:fzf_colors =
			\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nmap <leader>zf :Files<CR>
nmap <leader>zb :Buffers<CR>
nmap <leader>zr :Rg<CR>
nmap <leader>zt :Tags<CR>
nmap <leader>zc :History:<CR>
nmap <leader>zl :Lines<CR>
