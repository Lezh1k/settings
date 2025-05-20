local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- Common on_attach function
local function on_attach(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  -- These keymappings are defined in telescope.lua and handled by telescope
  -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  -- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  -- !!!!

  -- default lsp keybindings listed here are deleted in common_remaps.lua
  -- vim.keymap.del('n', 'gri', opts)  -- vim.lsp.buf.implementation()
  -- vim.keymap.del('n', 'grr', opts)  -- vim.lsp.buf.references()
  -- vim.keymap.del('n', 'gra', opts)  -- vim.lsp.buf.code_action()
  -- vim.keymap.del('n', 'grn', opts)  -- vim.lsp.buf.rename()

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set({ 'n', 'x' }, '<leader>fm', '<cmd>lua vim.lsp.buf.format({ async = false })<cr>', opts)
  -- Optional: Add more keymaps here if needed
end

-- LSP Signature
local function on_attach_lsp_signature(_, bufnr)
  local sign = require("lsp_signature")
  sign.setup()
  sign.on_attach({
    bind = true,
    hint_prefix = "->",
  }, bufnr)
end

-- Setup Mason
mason.setup()

-- Setup global cmp (Autocompletion)
local cmp = require("cmp")
cmp.setup({
  -- formatting = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 }),
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  },
})

-- Language-specific configurations

-- Lua
local lua_cfg = require("lezh1k.lsp.lua_cfg")
lspconfig.lua_ls.setup({
  settings = lua_cfg.settings,
  on_attach = function(client, bufnr)
    lua_cfg.on_attach(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- Clangd
local clangd_cfg = require("lezh1k.lsp.clangd_cfg")
lspconfig.clangd.setup({
  on_attach = function(client, bufnr)
    clangd_cfg.on_attach(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- ASM
-- lspconfig.asm_lsp.setup({
--   on_attach = function(client, bufnr)
--     on_attach(client, bufnr)
--     on_attach_lsp_signature(client, bufnr)
--   end,
-- })

-- Go
local golang_cfg = require("lezh1k.lsp.golang_cfg")
lspconfig.gopls.setup({
  settings = golang_cfg.settings,
  cmd = golang_cfg.cmd,
  filetypes = golang_cfg.filetypes,
  on_attach = function(client, bufnr)
    -- golang_cfg.on_attach(client, bufnr) -- uncomment if needed
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- Python
local pylsp_cfg = require("lezh1k.lsp.pylsp_cfg")
lspconfig.pylsp.setup({
  settings = pylsp_cfg.settings,
  on_attach = function(client, bufnr)
    pylsp_cfg.on_attach(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- TypeScript
lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})
