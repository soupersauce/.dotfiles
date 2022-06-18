--require "utils"

-------------------------------------------------------------------
-- let global vars (let g:xx = xxx)
-------------------------------------------------------------------


    local g = vim.g
	-- this will save almost 20ms
	g.python3_host_skip_check = 1
	g.python3_host_prog = "/usr/bin/python3"

	-- " enable embeded lua syntax
	-- " see https://github.com/neovim/neovim/pull/14213
	g.vimsyn_embed = "l"
	g.mousehide = true --  "hide when characters are typed

	-- see https://github.com/rust-lang/rust.vim/blob/87c745d8d506fc1eecc1d81df15d5bde1658a2fc/doc/rust.txt#L61
	-- Set this option to enable vim indentation and textwidth settings to
	-- conform to style conventions of the rust standard library (i.e. use 4
	-- spaces for indents and sets 'textwidth' to 99). This option is enabled by default
	g.rust_recommended_style = false


-------------------------------------------------------------------
-- set global options (set xxx = xxx)
-------------------------------------------------------------------

 
     local o = vim.o
	o.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
	o.encoding = "utf-8" -- "set encoding for text
	--     " enable true colors
	-- " If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
	-- " (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
	-- " Tmux
	-- " Tmux version must >= v2.2
	-- " set your $TERM to "xterm-256color"
	-- " add this line to your .tmux.conf:
	-- " set-option -ga terminal-overrides ",xterm-256color:Tc"
	-- " enable "true color" in the terminal
	o.termguicolors = true

	-- " Neovim ignores t_Co and other terminal codes
	-- " see https://github.com/neovim/neovim/wiki/FAQ#colors-arent-displayed-correctly
	-- " set t_Co=256

	-- enable cursorline
	o.cursorline = true

	-- for simnalamburt/vim-mundo
	-- enable persistent undo so that undo history persists across vim sessions
	o.undofile = true
	o.cmdheight = 2
	o.laststatus = 2
	--  -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline
	o.showmode = false
	-- Set completeopt to have a better completion experience
	-- https://github.com/hrsh7th/nvim-cmp#completioncompleteopt-type-string
	o.completeopt = "menu,menuone,noselect"
	-- Avoid showing message extra message when using completion
	o.shortmess = vim.o.shortmess .. "c"
	-- lua print(vim.bo.list)
	-- E5108: Error executing lua /usr/local/share/nvim/runtime/lua/vim/_meta.lua:94: 'list' is a window option, not a buffer option. See ":help list"
	-- but it is OK: lua print(vim.bo.list)
	-- highlight whitespace
	o.list = true

	-- stylua: ignore
	o.listchars = "tab:│ ,trail:•,extends:❯,precedes:❮"

	-- " The delay is governed by vim's updatetime option,
	-- " default updatetime 4000ms is not good for async update
	o.updatetime = 100

	-- set signcolumn to 2 to avoid git gutter sign conflict with linter sign
	o.signcolumn = "yes:2"

	o.background = "dark"

	-- base configuration
	o.timeoutlen = 300 --mapping timeout
	o.ttimeoutlen = 50 --keycode timeout

	o.history = 1000 --number of command lines to remember
	o.ttyfast = true -- assume fast terminal connection
	o.viewoptions = "folds,options,cursor,unix,slash" -- unix/windows compatibility
	o.hidden = true -- allow buffer switching without saving
	o.autoread = true -- auto reload if file saved externally
	o.fileformats = "unix,dos,mac" -- add mac to auto-detection of file format line endings
	-- nrformats = "bin,hex"
	o.showcmd = true
	o.showfulltag = true
	o.modeline = false

	o.shelltemp = false -- use pipes
	-- whitespace
	o.backspace = "indent,eol,start" --" allow backspacing everything in insert mode
	o.autoindent = true --          " automatically indent to match adjacent lines
	o.expandtab = true --" spaces instead of tabs
	o.smarttab = true --" use shiftwidth to enter tabs
	o.tabstop = 4 --" number of spaces per tab for display
	o.softtabstop = 4 --" number of spaces per tab in insert mode
	o.shiftwidth = 4 --" number of spaces when indenting
	o.shiftround = true
	o.linebreak = true
	o.showbreak = "↪ "
	o.wrap = false

	o.scrolloff = 5 --always show content after scroll
	o.scrolljump = 5 --minimum number of lines to scroll
	o.display = "lastline,msgsep"
	o.wildmenu = true --show list for autocomplete
	o.wildmode = "list:full" -- Command-line completion mode
	o.wildignorecase = true

	o.splitbelow = true
	o.splitright = true

	-- disable sounds
	o.visualbell = false

	-- searching
	o.hlsearch = true --"highlight searches
	o.incsearch = true --"incremental searching
	o.ignorecase = true --"ignore case for searching
	o.smartcase = true --"do case-sensitive if there's a capital letter

	--  backups
	o.backup = true
	o.backupdir = vim.fn.expand(vim.fn.stdpath "data" .. "/backup")
	-- no swap files
	o.swapfile = false

	-- ui configuration
	o.showmatch = true --"automatically highlight matching braces/brackets/etc.
	o.matchtime = 2 --"tens of a second to show matching parentheses
	o.number = true
	o.lazyredraw = true
	o.foldenable = true --"enable folds by default
	o.foldmethod = "indent" --"do not use syntax as fdm due to performance issue
	o.foldlevelstart = 99 --"open all folds by default

	o.colorcolumn = 80 --highlight column 80
	o.formatoptions=tcqron


-- fixupSHELL env in docker (for example: FTerm.nvim depends on SHELL env)
if not os.getenv "SHELL" then
	vim.fn.setenv("SHELL", "sh")
end

if string.match(os.getenv "SHELL" or "bash", "/fish$") then
	-- VIM expects to be run from a POSIX shell.
	vim.go.shell = "sh"
end

if vim.fn.executable "rg" then
	-- " When the --vimgrep flag is given to ripgrep, then the default value for the --color flag changes to 'never'.
	vim.go.grepprg = "rg --no-heading --vimgrep --smart-case --follow"
	vim.go.grepformat = "%f:%l:%c:%m"
end

-- local options
-- https://neovim.io/doc/user/options.html#local-options

-- window options

-- buffer options

