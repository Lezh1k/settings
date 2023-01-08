-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

vim.g.mapleader = " "

-- fast goto navigation screen
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- big comment macros for C/C++ files
vim.keymap.set("i", "<A-/>", "//////////////////////////////////////////////////////////////")
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", "<CMD>resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", "<CMD>resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>", opts)

-- Naviagate buffers
vim.keymap.set("n", "<S-l>", "<CMD>bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", "<CMD>bprevious<CR>", opts)

-- Move text up and down
vim.keymap.set("n", "<C-S-j>", "<CMD>m .+1<CR>==", opts)
vim.keymap.set("n", "<C-S-k>", "<CMD>m .-2<CR>==", opts)
-- Move text up and down
vim.keymap.set("v", "<C-S-j>", "<CMD>m .+1<CR>==", opts)
vim.keymap.set("v", "<C-S-k>", "<CMD>m .-2<CR>==", opts)


-- Terminal --
-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
