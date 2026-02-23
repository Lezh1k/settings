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

-- Language-specific configurations

-- Lua
local lua_cfg = require("lezh1k.lsp.lua_cfg")
vim.lsp.config("lua_ls", {
  settings = lua_cfg.settings,
  on_attach = function(client, bufnr)
    lua_cfg.on_attach(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
  cmd = lua_cfg.cmd,
  root_markers = lua_cfg.root_markers,
  filetypes = lua_cfg.filetypes,
})

-- Clangd
local clangd_cfg = require("lezh1k.lsp.clangd_cfg")
vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    clangd_cfg.on_attach(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
  cmd = clangd_cfg.cmd,
  root_markers = clangd_cfg.root_markers,
  filetypes = clangd_cfg.filetypes,
})

-- Go
local golang_cfg = require("lezh1k.lsp.golang_cfg")
vim.lsp.config("gopls", {
  settings = golang_cfg.settings,
  on_attach = function(client, bufnr)
    -- golang_cfg.on_attach(client, bufnr) -- uncomment if needed
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
  cmd = golang_cfg.cmd,
  filetypes = golang_cfg.filetypes,
  root_dir = golang_cfg.pf_get_root_dir(vim.api.nvim_buf_get_name(0)),
})

-- Python
local pylsp_cfg = require("lezh1k.lsp.pylsp_cfg")
vim.lsp.config("pylsp", {
  cmd = { "pylsp" },
  settings = pylsp_cfg.settings,
  filetypes = pylsp_cfg.filetypes,
  on_attach = function(client, bufnr)
    pylsp_cfg.on_attach(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- TypeScript
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
})

-- Rust
vim.lsp.config("rust-analyzer", {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    on_attach_lsp_signature(client, bufnr)
  end,
  cmd = { "rust-analyzer" },
  filetypes = { "rs", "rust" },
})

local ft_servers = {
  lua = { "lua_ls" },

  c = { "clangd" },
  cpp = { "clangd" },
  objc = { "clangd" },
  objcpp = { "clangd" },
  cuda = { "clangd" },

  go = { "gopls" },

  python = { "pylsp" },

  javascript = { "ts_ls" },
  javascriptreact = { "ts_ls" },
  typescript = { "ts_ls" },
  typescriptreact = { "ts_ls" },

  rust = { "rust-analyzer" },
}

-- 3) start/attach on demand when a buffer with that filetype opens
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(ft_servers),
  callback = function(arg)
    local servers = ft_servers[arg.match]
    if not servers then return end
    for _, name in ipairs(servers) do
      -- avoid duplicates for this buffer
      local already = vim.lsp.get_clients({ name = name, bufnr = arg.buf })
      if #already == 0 then
        -- registers/starts the server for this buffer on demand
        vim.lsp.enable(name)
      end
    end
  end,
})

-- Make the menu appear but don't insert or select automatically
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "popup" }
-- vim.opt.shortmess:append("c") -- quieter completion messages

-- Built-in LSP completion on-demand
local aug = vim.api.nvim_create_augroup("LspEnableNativeCompletion", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    -- Enable native LSP completion if the server supports it
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- Optional: manual trigger with <C-Space> (buffer-local)
    local opts = { buffer = ev.buf, noremap = true, silent = true, expr = true }
    vim.keymap.set("i", "<C-Space>", function()
      if vim.lsp.completion and vim.lsp.completion.trigger then
        vim.lsp.completion.trigger()
        return ""
      else
        return "<C-x><C-o>" -- fallback: built-in omnifunc completion
      end
    end, opts)
  end,
})
