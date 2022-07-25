return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'gruvbox-community/gruvbox'
  use 'nvim-lualine/lualine.nvim'
  use 'airblade/vim-gitgutter'
  use 'kyazdani42/nvim-tree.lua'
  use 'junegunn/goyo.vim'
  use 'jkramer/vim-checkbox'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
end)
