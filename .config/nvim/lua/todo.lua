Augroup {
	SetupCursor = {
		-- disable cursorline when insert/visual mode
		{
			"InsertLeave,WinEnter",
			"*",
			function()
				vim.go.cursorline = true
			end,
		},
		{
			"InsertEnter,WinLeave",
			"*",
			function()
				vim.go.cursorline = false
			end,
		},
		-- restore-cursor
		{
			"BufReadPost",
			"*",
			function()
				-- :h restore-cursor or :h last-position-jump
				if vim.fn.line "'\"" >= 1 and vim.fn.line "'\"" <= vim.fn.line "$" and vim.bo.ft ~= "commit" then
					vim.cmd 'normal! g`"'
				end
			end,
		},
	},
	ProtectFile = {
		{
			"BufReadPost",
			"*.rs",
			function()
				-- protect rust source files under ~/.rustup/toolchains/
				-- idea from https://github.com/Xvezda/vim-readonly/blob/master/plugin/readonly.vim
				-- and https://github.com/rust-lang/rustup/issues/2550
				local protect_dirs = {
					"^" .. vim.fn.expand "~" .. "/.rustup/toolchains/",
					"^" .. vim.fn.expand "~" .. "/.cargo/git/",
					"^" .. vim.fn.expand "~" .. "/.cargo/registry/",
				}
				for _, prefix in ipairs(protect_dirs) do
					if string.match(vim.fn.expand "%:p", prefix) ~= nil then
						vim.bo.readonly = true
						vim.bo.modifiable = false
					end
				end
			end,
		},
	},
	RemoveTrailingWhitespace = {
		{
			-- must use BufWritePre, if use BufWritePost has problem with other formatters (whitespace not got removed)
			"BufWritePre",
			"*",
			function()
				-- https://github.com/cappyzawa/trim.nvim/blob/9959b6638432d4f6674194fab1a3c50c44cdbf08/lua/trim/config.lua#L6
				local patterns = {
					[[%s/\s\+$//e]],
					[[%s/\%u200b\+$//e]],
					-- [[%s/\($\n\s*\)\+\%$//]],
					-- [[%s/\%^\n\+//]],
					-- [[%s/\(\n\n\)\n\+/\1/]],
				}
				-- https://github.com/cappyzawa/trim.nvim/blob/9959b6638432d4f6674194fab1a3c50c44cdbf08/lua/trim/trimmer.lua#L6
				local save = vim.fn.winsaveview()
				for _, v in pairs(patterns) do
					vim.api.nvim_exec(string.format("silent! %s", v), false)
				end
				vim.fn.winrestview(save)
			end,
		},
	},
	SetupTabsListFold = {
		["FileType"] = {
			{
				"css,scss",
				function()
					vim.wo.foldmethod = "marker"
					vim.wo.foldmarker = { "," }
				end,
			},
			{
				"python",
				function()
					vim.wo.foldmethod = "indent"
				end,
			},
			{
				"markdown",
				function()
					vim.wo.list = false
				end,
			},
			{
				"vim",
				function()
					vim.wo.foldmethod = "indent"
					vim.bo.keywordprg = ":help"
				end,
			},
			--   " Gofmt formats Go programs. It uses tabs for indentation and blanks for alignment.
			--   " Alignment assumes that an editor is using a fixed-width font.
			--   " https://golang.org/cmd/gofmt/
			{
				"go",
				function()
					vim.bo.expandtab = false
					vim.bo.tabstop = 4
					vim.bo.softtabstop = 4
					vim.bo.shiftwidth = 4
				end,
			},
			{
				"vim,xml,html,yaml,dockerfile",
				function()
					vim.bo.tabstop = 2
					vim.bo.softtabstop = 2
					vim.bo.shiftwidth = 2
				end,
			},
			{
				"lua",
				function()
					vim.bo.expandtab = false
					vim.bo.tabstop = 2
					vim.bo.softtabstop = 2
					vim.bo.shiftwidth = 2
				end,
			},

			-- " in makefiles, don't expand tabs to spaces, since actual tab characters are
			-- " needed, and have indentation at 8 chars to be sure that all indents are tabs
			{
				"make",
				function()
					vim.bo.textwidth = 0
					vim.bo.expandtab = false
					vim.wo.wrap = false
					vim.bo.softtabstop = 0
					vim.bo.tabstop = 4
					vim.bo.shiftwidth = 4
					-- iunmap <Tab>
					-- https://github.com/nanotee/nvim-lua-guide#defining-mappings
					-- nvim_del_keymap disabled due to err:
					-- Error detected while processing BufReadPost Autocommands for "*":
					-- E5108: Error executing lua ...te/pack/packer/start/filetype.nvim/lua/filetype/init.lua:8: Vim(lua):E5108: Error executing lua /home/ttys3/.config/nvim/lua/general.lua:482: E31: No such mapping
					-- vim.api.nvim_del_keymap("i", "<Tab>")
				end,
			},
		},
	},
	-- " because global ftplugin will overrule this, we should set in after/ftplugin/ft.vim
	-- for gomod file it is: after/ftplugin/gomod.vim
	-- " see https://neovim.io/doc/user/filetype.html#ftplugin-overrule
	-- " autocmd FileType lisp setlocal commentstring=;;\ %s
	-- " au BufRead,BufNewFile *.el	setlocal commentstring=;;\ %s
	CommentString = {
		["FileType"] = {
			{
				"gomod",
				function()
					vim.bo.commentstring = "// %s"
				end,
			},
			{
				"toml",
				function()
					vim.bo.commentstring = "# %s"
				end,
			},
			{
				"nomad",
				function()
					vim.bo.commentstring = "# %s"
				end,
			},
		},
	},
	MiscFileType = {
		["BufNewFile,BufRead"] = {
			{
				".gitconfig",
				function()
					vim.api.nvim_command "setlocal filetype=dosini"
				end,
			},
			{
				"*.{automount,service,socket,target,timer}",
				function()
					vim.api.nvim_command "setlocal filetype=systemd"
				end,
			},
		},
	},
	Misc = {
		["TextYankPost"] = {
			{
				"*",
				function()
					-- Highlight on yank
					vim.highlight.on_yank { higroup = "IncSearch", timeout = 150, on_visual = true }
				end,
			},
		},
	},
}

-- file template
vim.api.nvim_command "augroup FileTemplate"
vim.api.nvim_command "autocmd!"
local template_files = vim.fn.glob(vim.fn.stdpath "config" .. "/template/new.*", 0, 1)
for _, tmpl in ipairs(template_files) do
	local ext = vim.fn.fnamemodify(tmpl, ":e")
	vim.api.nvim_command(string.format("autocmd BufNewFile *.%s  0r %s", ext, tmpl))
end
vim.api.nvim_command "augroup END"

