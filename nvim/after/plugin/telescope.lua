local builtin = require("telescope.builtin")
-- FIND
local function find_hidden_files()
  return builtin.find_files({hidden=true})
end

vim.keymap.set("n", "<leader>ff", find_hidden_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- LSP
-- -- symbols
vim.keymap.set("n", "<leader>sl", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
