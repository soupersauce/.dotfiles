return require("packer").startup(function()
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-lua/plenary.nvim"
    use "RishabhRD/nvim-lsputils"
    use "mfussenegger/nvim-lint"
    use {
	"junnplus/nvim-lsp-setup"
	requires = {
	    'neovim/nvim-lspconfig',
	    'williamboman/nvim-lsp-installer',
	}
    }
    use {
	"amrbashir/nvim-docs-view"
	opt = true,
	cmd = { "DocsViewToggle" },
	config = function()
	    require("docs-view").setup = {
	    position = "right",
	    width = 60,
	}
    }
    use "hrsh7th/nvim-cmp"
    use "junegunn/fzf.vim", { "do": { -> fzf#install  }  }
    use "~/.fzf"
    use "itchyny/lightline.vim" 
    use "luukvbaal/nnn.nvim"
    use {
	"windwp/nvim-autopairs",
	config = function() require("nvim-autopairs").setup {} end
    }
    use "vimwiki/vimwiki"
    use "rafi/awesome-vim-colorschemes"
    use "scrooloose/nerdtree"
    use "Xuyuanp/nerdtree-git-plugin"
    use "tpope/vim-unimpaired"
    use "shoukoo/commentary.nvim"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-fugitive"
    use "tpope/vim-eunuch"
    use "tpope/vim-vinegar"
    use "nvim-orgmode/orgmode"
    use "dhruvasagar/vim-table-mode"
    use "michaelb/sniprun", {"do": "bash install.sh"}
    use "lukas-reineke/headlines.nvim"
    use "akinsho/org-bullets.nvim"
    use "Yggdroot/indentline"
    use "psliwka/vim-smoothie"
    use "sqwishy/vim-sqf-syntax"
    use "whiteinge/diffconflicts"
end)
