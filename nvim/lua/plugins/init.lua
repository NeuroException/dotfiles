-- Auto install Packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	-- Packer is not installed, so download it
	print("Installing Packer...")
	vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
	vim.cmd("packadd packer.nvim")
end

-- Load Plugins
if vim.fn.empty(vim.fn.glob(install_path)) < 1 then
	require('packer').startup(function(use)

		--- REQUIREMENTS
		use 'wbthomason/packer.nvim'		-- Plugin-Manager
		use 'kyazdani42/nvim-web-devicons'	-- Icons

		--- CORE
		use {'VonHeikemen/lsp-zero.nvim', branch = 'v1.x', requires = { {'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'}, {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-nvim-lua'}, {'L3MON4D3/LuaSnip'}, {'rafamadriz/friendly-snippets'},}}
		use 'nvim-treesitter/nvim-treesitter'
		use 'nvim-tree/nvim-tree.lua'
		use 'romgrk/barbar.nvim'
		use { 'CRAG666/betterTerm.nvim' }
		use 'nvim-lualine/lualine.nvim'
		use 'lewis6991/gitsigns.nvim'
		use 'johnfrankmorgan/whitespace.nvim'
		use 'windwp/nvim-autopairs'
		use "lukas-reineke/indent-blankline.nvim"
		use 'goolord/alpha-nvim'
		use 'ahmedkhalf/project.nvim'

		--- OPTIONAL
		use 'Exafunction/codeium.vim'
		use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep'}}
		use 'nvim-telescope/telescope-file-browser.nvim'
		use 'norcalli/nvim-colorizer.lua'
        use 'wojciechkepka/vim-github-dark'
	end)
end

require("plugins.configs")
