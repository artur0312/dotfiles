vim.opt.backup = false				-- Backup files
--vim.opt.clipboard = "unnamedplus"		-- System clipboard on the '+' register
vim.opt.cmdheight = 2				-- More space for neovim command line for displaying messages
vim.opt.completeopt = {"menuone", "noselect"} 	-- Completion selection options
vim.opt.conceallevel = 0			-- So that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"			-- The encoding written to a file
vim.opt.hlsearch = false				-- Highlight all matches on previous search pattern
vim.opt.incsearch = true;
vim.opt.ignorecase = true			-- Ignore case in search patterns
vim.opt.mouse = "a"				-- Allow the mouse to be used on neovim
vim.opt.pumheight = 10				-- Change the max size of autocompletion menu
vim.opt.showmode = true			-- Do not show the mode on status bar
vim.opt.showtabline = 2				-- Always show tabs
vim.opt.smartcase = true			-- Disable ignorecase when search pattern contains upper case characters
vim.opt.smartindent = true			-- Smart indentation
vim.opt.splitbelow = true			-- Always split below the current window
vim.opt.splitright = true			-- Always split to the right of the current window
vim.opt.swapfile = false			-- Create swap file
vim.opt.termguicolors = true 			-- Set term gui colors
vim.opt.timeoutlen = 1000 			-- Time to wait for a mapped sequence to complete
vim.opt.updatetime = 300			-- Faster completion (4000 by default)
vim.opt.writebackup = false			-- If a file is being edited by another program, it is not allowed to be edited
vim.opt.expandtab = true			-- Convert tabs to spaces
vim.opt.shiftwidth = 2				-- The number of spaces for each indentation
vim.opt.tabstop = 2				-- Insert 2 spaces for a tab
vim.opt.softtabstop = 2
vim.opt.cursorline = false			-- Highlight the current line
vim.opt.number = true				-- Set numbered lines
vim.opt.relativenumber = true			-- Set relative numbered lines
vim.opt.numberwidth = 4				-- Set number column width (default 4)
vim.opt.signcolumn = "yes"			-- Always shows the sign column, otherwise it would shift the text each time
vim.opt.wrap = true				-- Line wrapping
vim.opt.scrolloff = 8				-- Context lines around the cursor
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
--vim.opt.colorcolumn = "100"

vim.api.nvim_create_augroup('AutoFormatting', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*.rs', '*.h', '*.hpp', '*.c', '*.cpp'},
  group = 'AutoFormatting',
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = "cpp",
  callback = function()
    vim.opt_local.formatprg = "clang-format"
  end,
})
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
