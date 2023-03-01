local lsp = require("lsp-zero")
lsp.preset("recommended")

-- LSP
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>fm", "<CMD>LspZeroFormat<CR>", opts)

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- LSP signature
local function on_attach_lsp_signature(_, bufnr)
  local sign = require("lsp_signature")
  sign.setup()
  sign.on_attach({
    bind = true,
    hint_prefix = "->",
  }, bufnr)
end

-- PER LANGUAGE SETTINGS
-- lua configuration
local lsp_cfg = require("lezh1k.lsp.lua_cfg")
lsp.configure("lua_ls", {
  settings = lsp_cfg.settings,
  on_attach = function(client, bufnr)
    lsp_cfg.on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

--  python configuration
--  python-lsp-server
local pylsp_cfg = require("lezh1k.lsp.pylsp_cfg")
lsp.configure("pylsp", {
  settings = pylsp_cfg.settings,
  on_attach = function(client, bufnr)
    pylsp_cfg.on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- clangd configuration
local clangd_cfg = require("lezh1k.lsp.clangd_cfg")
lsp.configure("clangd", {
  on_attach = function(client, bufnr)
    clangd_cfg.on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

lsp.setup()
