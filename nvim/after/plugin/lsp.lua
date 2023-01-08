local lsp = require("lsp-zero")
lsp.preset("recommended")

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.configure("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 120
        } -- pycodestyle
      } -- plugins
    } -- pylsp
  }, -- settings
  on_attach = function(_, bufnr)
    local sign = require("lsp_signature")
    sign.setup()
    sign.on_attach({
      bind = true,
      hint_prefix = "->",
    }, bufnr)
  end
})

lsp.configure("clangd", {
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<F4>", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
  end
})

lsp.setup()
