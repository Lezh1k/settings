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
vim.g.maplocalleader = "\\"

-- fast goto navigation screen
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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
vim.keymap.set("n", "<leader>bd", "<CMD>bd<CR>", opts)

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

-- LSP (we want to delete old mappings because we have our own)
vim.keymap.del('n', 'gri')  -- vim.lsp.buf.implementation()
vim.keymap.del('n', 'grr')  -- vim.lsp.buf.references()
vim.keymap.del('n', 'gra')  -- vim.lsp.buf.code_action()
vim.keymap.del('n', 'grn')  -- vim.lsp.buf.rename()

-- Builtin commenter
do
    local operator_rhs = function()
      return require('vim._comment').operator()
    end
    vim.keymap.set({ 'n', 'x' }, '<leader>c', operator_rhs, { expr = true, desc = 'Toggle comment' })

    local line_rhs = function()
      return require('vim._comment').operator() .. '_'
    end
    vim.keymap.set('n', '<leader>cl', line_rhs, { expr = true, desc = 'Toggle comment line' })
end
