local lua_cfg = {}

lua_cfg.settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  }, -- Lua
}

lua_cfg.cmd = { "lua-language-server" }
lua_cfg.root_markers = { ".luarc.json" }
lua_cfg.filetypes = { "lua" }

function lua_cfg.save_and_run()
  vim.cmd([[w]])
  vim.cmd([[belowright split]])
  vim.cmd([[resize -10]])
  vim.cmd([[terminal lua %]])
end

local function on_attach_set_options(_, _)
end

local function on_attach_keymap(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "<C-R>", lua_cfg.save_and_run, opts)
end

function lua_cfg.on_attach(client, bufnr)
  on_attach_set_options(client, bufnr)
  on_attach_keymap(client, bufnr)
end

return lua_cfg
