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

-- LSP signature
local function on_attach_lsp_signature(_, bufnr)
  local sign = require("lsp_signature")
  sign.setup()
  sign.on_attach({
    bind = true,
    hint_prefix = "->",
  }, bufnr)
end

require('mason').setup({})
-- TODO MAYBE MOVE ALL LANGUAGE SPECIFIC CONFIGURATIONS HERE
require('mason-lspconfig').setup({
  automatic_installation=true,
  ensure_installed = {},
  handlers = {
    ts_ls = function()
      require("lspconfig").ts_ls.setup({})
    end,
    pylsp = function()
      local pylsp_cfg = require("lezh1k.lsp.pylsp_cfg")
      require("lspconfig").pylsp.setup({
        settings = pylsp_cfg.settings,
        on_attach = function(client, bufnr)
          pylsp_cfg.on_attach(client, bufnr)
          on_attach_lsp_signature(client, bufnr)
        end,
      })
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
