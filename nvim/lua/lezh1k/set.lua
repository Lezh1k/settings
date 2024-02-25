vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.nuw = 4
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.title = true
vim.opt.clipboard = "unnamedplus"

vim.opt.ex = true
-- colorcolumn

local function set_color_col()
  local dct_ft_width = {
    ["lua"] = "120",
    ["python"] = "120",
    ["c"] = "120",
    ["cpp"] = "120",
    ["h"] = "120",
    ["go"] = "120",
  }
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local cc = dct_ft_width[ft]
  if cc == nil then cc = "80" end
  vim.opt.colorcolumn = cc
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.schedule(set_color_col)
  end,
})
