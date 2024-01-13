local opts = {noremap = true, silent = true}
local term_opts = {silent = true}

--Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Invert comma and colon
keymap("n", ";", ":", opts)
keymap("n", ":", ";", opts)
keymap("v", ";", ":", opts)
keymap("v", ":", ";", opts)

-- Normal mode

-- Change across splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- Open file explorer
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>c", ":NvimTreeFocus<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<cr>", opts)
keymap("n", "<C-Down>", ":resize -2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

--Navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)

-- Insert mode
keymap("i", "jk", "<ESC>", opts)

-- Visual mode

-- Indenting text manually
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

--Do not yank when replacing a word in visual mode
--keymap("v", "p", '"_dP', opts)

-- Visual Block mode
--Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-K>", ":move '<-2<CR>gv-gv", opts)

-- Terminal mode
-- Better terminal navigation
keymap("t", "<C-h>", "<C-//><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-//><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-//><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-//><C-N><C-w>l", term_opts)

-- Telescope
keymap("n", "<leader>j", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>",opts)
keymap("n", "<c-s>", "<cmd>Telescope live_grep<cr>", opts)
-- Find existing buffers
keymap("n", "<leader><space>", "<cmd>Telescope buffers<cr>", opts) 
-- Fuzzy find in current buffer
keymap("n", "<leader>/", "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({winblend = 10, previewer = false}))<cr>",opts)
-- Search git files
keymap("n", "<leader>lg", "<cmd>Telescope git_files<cr>", opts) 
-- Search neovim help tags
keymap("n", "<leader>lh", "<cmd>Telescope help_tags<cr>", opts) 
-- Search string under cursor 
keymap("n", "<leader>lw", "<cmd>Telescope grep_string<cr>", opts) 
-- Search diagnostics in open buffers
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts) 
-- Resume previous search
keymap("n", "<leader>lr", "<cmd>Telescope resume<cr>", opts) 

-- Change between header and source
keymap("n", "<leader>t", ":ClangdSwitchSourceHeader<cr>",opts)

-- Competitive programming
keymap("n", "cpf", ":0r ~/CP/template.cpp<CR>",opts)
keymap("n", "cpp", ":term g++ % && ./a.out<CR>",opts)

-- Goyo
vim.keymap.set("n", "<leader>r", 
  function()
    if vim.o.linebreak then
      vim.cmd ("Goyo")
      vim.cmd("set linebreak &")
    else
      vim.cmd("Goyo -100%x100%")
      vim.cmd("set linebreak")
    end
  end
  , opts
)

vim.keymap.set("n", "<C-d>", "<C-d>zz",opts);
vim.keymap.set("n", "<C-u>", "<C-u>zz",opts);
vim.keymap.set("n", "n", "nzzzv",opts);
vim.keymap.set("n", "N", "Nzzzv",opts);

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz",opts);
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz",opts);
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz",opts);
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz",opts);



vim.keymap.set("n", "<leader>x", "<Plug>JupyterExecute")
vim.keymap.set("n", "<leader>X", "<Plug>JupyterExecuteAll")
