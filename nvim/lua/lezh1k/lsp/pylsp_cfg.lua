local pylsp_cfg = {}

-- settings for pylsp plugin
pylsp_cfg.settings = {
  pylsp = {
    plugins = {
      pycodestyle = {
        maxLineLength = 120
      } -- pycodestyle
    } -- plugins
  } -- pylsp
}

local function on_attach_keymap(_, bufnr)
  -- local opts = { buffer = bufnr, remap = false }
  -- vim.keymap.set("n", "<C-F5>", "<cmd>:terminal python %<cr>", opts)
end

local function on_attach_lsp_signature(_, bufnr)
    local sign = require("lsp_signature")
    sign.setup()
    sign.on_attach({
      bind = true,
      hint_prefix = "->",
    }, bufnr)
end

function pylsp_cfg.on_attach(client, bufnr)
  on_attach_keymap(client, bufnr)
  on_attach_lsp_signature(client, bufnr)
end

return pylsp_cfg
