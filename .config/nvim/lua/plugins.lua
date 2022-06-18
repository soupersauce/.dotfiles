-- Install packer
-- local utils = require("utils")

local packer = require("packer")
local packer_util = require("packer.util")
local use = packer.use

packer.init({
    -- always load default
    snapshot = "latest",
    snapshot_path = packer.util.join_paths(vim.fn.stdpath("config"), "packer_snapshots"),
    display = {
	open_fn = function()
	    return packer_util.float({ border = "single" })
	end
    },
})
-- Speeds up loading
-- needs to be loaded before any other plugin
use ({ "lewis6991/impatient.nvim", config = [[require('impatient')]] })

use("nathom/filetype.nvim")
-- Packer self-management and lazyload
use({
    "wbthomason/packer.nvim",
    cmd = {
	"PackerClean",
	"PackerCompile",
	"PackerInstall",
	"PackerLoad",
	"PackerProfile",
	"PackerSnapshot",
	"PackerSnapshotDelete",
	"PackerSnapshotRollback",
	"PackerStatus",
	"PackerSync",
	"PackerUpdate",
    },
    config = [[require("plugins")]]
})

    use({"nvim-treesitter/nvim-treesitter"})
use({ 
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter"
})
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use "RishabhRD/nvim-lsputils"
    use "mfussenegger/nvim-lint"
    use "L3MON4D3/LuaSnip"
    use "gennaro-tedesco/nvim-peekup"
    use "kyazdani42/nvim-web-devicons"
    use { 'ibhagwan/fzf-lua',
      requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use { 'yamatsum/nvim-nonicons',
      requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use "frabjous/knap"
    use {
	"projekt0n/github-nvim-theme",
	config = function() require('github-theme').setup {
	    theme_style = "dimmed",
	}
    end
    } 
    use "xiyaowong/nvim-cursorword"
    use {
	"lukas-reineke/indent-blankline.nvim",
	tag = '*',
    }
    use {
	"junnplus/nvim-lsp-setup",
	requires = {
	    'neovim/nvim-lspconfig',
	    'williamboman/nvim-lsp-installer',
	}
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
	"amrbashir/nvim-docs-view",
	opt = true,
	cmd = { "DocsViewToggle" },
	config = function()
	    require("docs-view").setup = {
	    position = "right",
	    width = 60,
	}
    end
    }
    use "hrsh7th/nvim-cmp"
    use "nkakouros-original/numbers.nvim"
    use "rafamadriz/friendly-snippets" 
    use "luukvbaal/nnn.nvim"
    use {
	"windwp/nvim-autopairs",
	config = function() require("nvim-autopairs").setup {} end
    }
    use {
	'declancm/cinnamon.nvim',
	config = function() require('cinnamon').setup {
	    extra_keymaps = true,
	    extended_keymaps = true,
	} end
    }
    use "sindrets/diffview.nvim"
    use "mizlan/iswap.nvim"
    use "vimwiki/vimwiki"
    use "rafi/awesome-vim-colorschemes"
    use "shoukoo/commentary.nvim"
    use "tpope/vim-unimpaired"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-fugitive"
    use "tpope/vim-eunuch"
    use "tpope/vim-vinegar"
    use "nvim-orgmode/orgmode"
    use "dhruvasagar/vim-table-mode"
    use {"michaelb/sniprun", run = "bash ./install.sh"}
    use "lukas-reineke/headlines.nvim"
    use "akinsho/org-bullets.nvim"
    use "sqwishy/vim-sqf-syntax"

-- Keymap hints
-- Load after rest of gui
use({
    "folke/which-key.nvim",
    config = function()
	require("plugins.whichkey").configure()
    end,
})
