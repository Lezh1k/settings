local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({
    buffer = bufnr,
    -- definitions for these are in telescope.lua
    exclude = { "gd", "gi", "gr" },
  })
  local opts = { buffer = bufnr }

  vim.keymap.set({ "n", "x" }, "<leader>fm", function()
    vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
  end, opts)
end)

require('mason').setup({})
-- TODO MAYBE MOVE ALL LANGUAGE SPECIFIC CONFIGURATIONS HERE
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    -- lsp_zero.default_setup,
    -- lua_ls = function()
    --   local lua_opts = lsp_zero.nvim_lua_ls()
    --   require('lspconfig').lua_ls.setup(lua_opts)
    -- end,
    tsserver = function()
      require("lspconfig").tsserver.setup({})
    end,
  }
})

local cmp = require('cmp')
local cmp_format = lsp_zero.cmp_format()

cmp.setup({
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    -- scroll up and down the documentation window
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
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
local lua_cfg = require("lezh1k.lsp.lua_cfg")
lsp_zero.configure("lua_ls", {
  settings = lua_cfg.settings,
  on_attach = function(client, bufnr)
    lua_cfg.on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

--  python configuration
--  python-lsp-server
local pylsp_cfg = require("lezh1k.lsp.pylsp_cfg")
lsp_zero.configure("pylsp", {
  settings = pylsp_cfg.settings,
  on_attach = function(client, bufnr)
    pylsp_cfg.on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- clangd configuration
local clangd_cfg = require("lezh1k.lsp.clangd_cfg")
lsp_zero.configure("clangd", {
  on_attach = function(client, bufnr)
    clangd_cfg.on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- golang configuration
local golang_cfg = require("lezh1k.lsp.golang_cfg")
lsp_zero.configure("gopls", {
  settings = golang_cfg.settings,
  on_attach = function(client, bufnr)
    -- golang_cfg.on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
  cmd = golang_cfg.cmd,
  filetypes = golang_cfg.filetypes,
})

lsp_zero.setup()
