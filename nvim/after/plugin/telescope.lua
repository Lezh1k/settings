local telescope = require("telescope")
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

local lsp_refs = function()
  return builtin.lsp_references({
    show_line = false,
    trim_text = true,
  })
end

local lsp_impls = function()
  return builtin.lsp_implementations({
    show_line = false,
    trim_text = true,
  })
end

vim.keymap.set("n", "<leader>sl", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>gr", lsp_refs, {})
vim.keymap.set("n", "gr", lsp_refs, {})
vim.keymap.set("n", "<leader>gi", lsp_impls, {})
vim.keymap.set("n", "gi", lsp_impls, {})
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "go", builtin.lsp_type_definitions, {})
vim.keymap.set("n", "<leader>go", builtin.lsp_type_definitions, {})

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


telescope.setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 120,
        flip_lines = 40,
      },
    },
    path_display = { "truncate" },
    file_ignore_patterns = {
      ".git", -- ignore everything in .git folder
    },
  }
}
