local lsp = require("lsp-zero")
lsp.preset("recommended")

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- lua configuration
local lsp_cfg = require("lezh1k.lsp.lua_cfg")
lsp.configure("sumneko_lua", {
  settings = lsp_cfg.settings,
})

-- python configuration
local pylsp_cfg = require("lezh1k.lsp.pylsp_cfg")
lsp.configure("pylsp", {
  settings = pylsp_cfg.settings,
  on_attach = pylsp_cfg.on_attach,
})

-- clangd configuration
local clangd_cfg = require("lezh1k.lsp.clangd_cfg")
lsp.configure("clangd", {
  on_attach = clangd_cfg.on_attach,
})

lsp.setup()
