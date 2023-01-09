local clangd_cfg = {}

-- settings for clangd plugin
local function on_attach_keymap(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<F4>", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
end

function clangd_cfg.on_attach(client, bufnr)
  on_attach_keymap(client, bufnr)
end

return clangd_cfg
