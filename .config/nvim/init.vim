call plug#begin()
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'dense-analysis/ale'
Plug 'liuchengxu/vista.vim'
"Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf.vim'
Plug '~/.fzf'
Plug 'itchyny/lightline.vim' 
" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
Plug 'mcchrish/nnn.vim'
Plug 'benmills/vimux'
Plug 'rust-lang/rust.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vimwiki/vimwiki'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ron-rs/ron.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentline'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme space-vim-dark

set nocompatible
set nomodeline
filetype plugin on
syntax on
"" Show Line Numbers
set number

" Underline current line
set cursorline

" Show a line at column 80
set colorcolumn=80
" Always show tabline
setglobal showtabline=2

" Indentation - Hard tabs, No Spaces, 4 Char width
set autoindent " indent when moving to the next line while writing code
set tabstop=8  " Size of tab indentation
set shiftwidth=4
set softtabstop=4
set expandtab " Don't use spaces for tab

" show the matching part of the pair for {} [] ()
set showmatch

"lets you use backspace on previously inserted words
set backspace=indent,eol,start

" Diff mode options
set diffopt=filler,iwhite

" No automatic C style indentation
set nocindent

" Comment formatting options
set formatoptions=tcqron

" Highlight searches
set hlsearch

" Ignore case unless the search patter has capitals
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
set mouse=n

" Show partial command in last line of the screen
set showcmd

" Where new splits will open
set splitbelow splitright

" Undo file location and enable
set undodir=~/.vim/undo
set undofile

" Characters allowed to wrap to next line on first/last character of line
set whichwrap=b,s,

" Wrap lines when they exceed edge of window
set wrap

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
noremap      <silent> <C-l> :nohlsearch <bar> redraw<CR>
inoremap     <silent> <C-l> <C-O>:nohlsearch <bar> redraw<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config Recommendations for coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if hidden is not set, TextEdit might fail
set hidden

" Some servers have issues with backup files,
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion
" Use command ':verbose imap <tab>' to make sure tab is not mapped by another
" plugin
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger complete.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position
" Coc only does snippet and addtional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostics-prev)
nmap <silent> ]c <Plug>(coc-diagnostics-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in a preview window
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

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetypes(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex `<leader>aap` for current
" paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>

" Add diagnostic info for https://github.com/itchny/lightline.vim
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\	'left': [ [ 'mode', 'paste' ],
	\		[ 'cocstatus', 'readonly', 'filename', 'modified', 'coc_git_status' ] ]
	\ },
	\ 'component_function': {
	\	'cocstatus': 'coc#status'
	\ },
	\ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent> <space>j :<C-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<cr>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<cr>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
imap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

"inoremap <silent><expr> <TAB>
   "\ pumvisible() ? coc#_select_confirm() :
   "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
   "\ <SID>check_back_space() ? "\<TAB>" :
   "\ coc#refresh()

function! s:check_back_space() abort
   let col = col('.') - 1
	 return !col || getline('.')[col - 1]  =~# '\s'
 endfunction

 let g:coc_snippet_next = '<tab>'

" Use ctrl l for right in insertmode
imap <C-l> <right>

" vim-test strategy
let test#strategy = "neovim"

""""""""""""""""""""""""""""""""""""""""""""""""
" 	vimux config
""""""""""""""""""""""""""""""""""""""""""""""""

"Orientation of tmux split "h" or "v"
let g:VimuxOrientation = "v"

" Use nearest existing split(1) or open new(0)
let g:VimuxUseNearest = 0

" Sequnce to send to terminal before running
let g:VimuxResetSequence = "<C-[> cc"

" Percentage of screen new vimux pane will take up
let g:VimuxHeight = "30"

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

""""""""""""""""""
" Vista "
""""""""""""""""""
let g:vista_default_executive="coc"

"""""""
" ALE "
"""""""
let g:ale_rust_rls_executable = 'ra_lsp_server'
let g:ale_rust_rls_toolchain  = ''

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
nmap <leader>zr :Rg
nmap <leader>zt :Tags<CR>
nmap <leader>zc :History:<CR>
nmap <leader>zl :Lines<CR>
