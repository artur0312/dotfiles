local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system{
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init{
  display = {
    open_fn = function()
      return require("packer.util").float{border = "rounded"}
    end,
  },
}

-- Install plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" --Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the popup API from vim in neovim
  use "nvim-lua/plenary.nvim" -- Used in many plugins
  use "windwp/nvim-autopairs" -- Autopairs
  use "numToStr/Comment.nvim" -- Comment
  use "akinsho/toggleterm.nvim"

  --Colorscheme
  use "folke/tokyonight.nvim"

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- Completion plugin
  use "hrsh7th/cmp-buffer" -- Buffer completion
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions 
  use "hrsh7th/cmp-nvim-lsp" -- lsp support

  --snippets
  use {"L3MON4D3/LuaSnip", run="make install_jsregexp"} -- Snippet engine

  -- LSP 
  use "neovim/nvim-lspconfig"
  use {"williamboman/mason.nvim"}
  use {"williamboman/mason-lspconfig.nvim"} -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" --LSP diagnostics
  use 'rhysd/vim-clang-format'

  -- tmux & split window navigation
  use "christoomey/vim-tmux-navigator"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Git
  use "tpope/vim-fugitive"

  use "theprimeagen/harpoon"

  use 'ggandor/leap.nvim'

  use "tools-life/taskwiki"
  use "junegunn/goyo.vim"

  -- Treesitter
  use{
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects"
    }
  }
  use "nvim-treesitter/nvim-treesitter-textobjects"

  use "lervag/vimtex"

  use 'untitled-ai/jupyter_ascending.vim'
  --TODO searching
  use "folke/todo-comments.nvim"
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
