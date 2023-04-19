local nt = require("neo-tree")

local function nt_sort_content_asc(a, b)
  if a.type == b.type then
    return a.path < b.path
  else
    return a.type <= b.type
  end
end

local setup_arg = {
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  sort_function = nt_sort_content_asc,
  sources = {
    "filesystem",
    "buffers",
    -- "git_status"
  },
  source_selector = {
    winbar = false,
    statusline = true,
  },
  open_files_in_last_window = true, -- false = open files in top left window
  tabs_layout = "active",
  buffers = {
    follow_current_file = true,
  },
  filesystem = {
    follow_current_file = true,
  }
}

nt.setup(setup_arg)

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>nt", "<CMD>Neotree toggle<CR>", opts)
