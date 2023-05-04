local opt = vim.opt

opt.number = true
opt.mouse = 'a'
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.g.mapleader = ' '
vim.cmd.colorscheme('iceberg')

require('packer').startup(function(use)
	local plugins = {
		-- Bootstrap --
		'wbthomason/packer.nvim',

		-- LSP --
		'neovim/nvim-lspconfig',
		{
			'williamboman/mason.nvim',
			run = ":MasonUpdate"
		},
		'williamboman/mason-lspconfig.nvim',
		{
			"glepnir/lspsaga.nvim",
			opt = true,
			event = 'LspAttach',
			branch = 'main',
			config = function()
				require('lspsaga').setup({})
			end,
			requires = {
				{'nvim-tree/nvim-web-devicons'},
				{'nvim-treesitter/nvim-treesitter'}
			}
    },

		-- Treesitter --
		{
			'nvim-treesitter/nvim-treesitter',
			run = ":TSUpdate"
		},

		-- Completion --
 	  'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
	  'hrsh7th/cmp-cmdline',
	  'hrsh7th/nvim-cmp',

		{
			'Exafunction/codeium.vim',
			config = function ()
				local bindings = {
					['<C-g>'] = 'codeium#Accept',
					['<c-;>'] = 'codeium#CycleCompletions',
					['<c-,>'] = 'codeium#CycleCompletions',
					['<c-x>'] = 'codeium#Clear',
				}

				for binding, funcname in pairs(bindings) do
					local func = function() return vim.fn[funcname]() end
					vim.keymap.set('i', binding, func, { expr = true })
				end
			end
		},

		-- Snippets --
		{
		   "L3MON4D3/LuaSnip",
			 tag = "v<CurrentMajor>.*",
			 run = "make install_jsregexp"
		},
		"rafamadriz/friendly-snippets",

		-- Fuzzy Finder --
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.1',
			requires = { {'nvim-lua/plenary.nvim'} }
		},

		-- Status Line --
		{
			'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		},

		-- Ident Guides --
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("indent_blankline").setup({
					show_current_context = true,
					show_current_context_start = true,
					use_treesitter = true,
				})
			end
		},

		-- Commenting -- 
		{
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup({})
			end
		},

		-- Git -- 
		'tpope/vim-fugitive',
	}

	for _, plugin in pairs(plugins) do
		use(plugin)
	end
end)

local configs_modules = {
	'lsp',
	'completion',
	'treesitter',
	'telescope',
	'lualine',
}
for _, file in pairs(configs_modules) do
	local config = require('config.' .. file)
	config.setup()
end
