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

function pylsp_cfg.save_and_run()
  vim.cmd([[w]])
  vim.cmd([[belowright split]])
  vim.cmd([[resize -10]])
  vim.cmd([[terminal python %]])
  -- vim.cmd([[TermExec cmd="python %"]])
end

local function on_attach_set_options(_, _)
end

local function on_attach_keymap(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "<C-R>", pylsp_cfg.save_and_run, opts)
end

function pylsp_cfg.on_attach(client, bufnr)
  on_attach_set_options(client, bufnr)
  on_attach_keymap(client, bufnr)
end

return pylsp_cfg
