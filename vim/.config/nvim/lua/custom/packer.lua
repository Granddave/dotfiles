return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'lewis6991/gitsigns.nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'jkramer/vim-checkbox'
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use 'ThePrimeagen/harpoon'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'j-hui/fidget.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'onsails/lspkind.nvim'
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons"
  }
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'mfussenegger/nvim-dap-python'
  use 'numToStr/Comment.nvim'
  use 'ntpeters/vim-better-whitespace'
  use 'windwp/nvim-autopairs'
  use 'kylechui/nvim-surround'
  use 'nvim-tree/nvim-web-devicons'
  use 'ojroques/nvim-oscyank'
end)