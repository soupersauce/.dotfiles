
-------------------------------------------------------------------
-- keybinds
-------------------------------------------------------------------
local key = vim.keymap

-- Execute current visual selection as a shell command
key.set('v', 'Q', '!!$SHELL<CR>')

-- Use <C-L> to clear search highlighting
key.set( 'n', '<C-l>', '<cmd>let @/=""<CR>', { noremap = true, silent = true})

-- " quick list/nolist toggle
-- :set list! list?<cr>
-- nnoremap {
-- 	"<leader>lt",
-- 	function()
-- 		if vim.wo.list then
-- 			vim.wo.list = false
-- 		else
-- 			vim.wo.list = true
-- 		end
-- 	end,
-- }
-- time
--   " change cursor position in insert mode
key.set('i', '<C-h>', '<left>')
-- key.set('i', '<C-l>', '<right>')

--   " reselect visual block after indent
key.set('v', '<', '<gv')
key.set('v', '>', ">gv")

