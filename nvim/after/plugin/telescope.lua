local builtin = require("telescope.builtin")
-- FIND
local function find_all_files()
  return builtin.find_files({ hidden = true })
end

-- vim.keymap.set("n", "<leader>ff", find_all_files, {})
vim.keymap.set("n", "<leader>ff", find_all_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- LSP
-- -- symbols
vim.keymap.set("n", "<leader>sl", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
vim.keymap.set("n", "gr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})


--
local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size >= 100 * 1024 then return end

    previewers.buffer_previewer_maker(filepath, bufnr, opts)
  end)
end

require('telescope').setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}
