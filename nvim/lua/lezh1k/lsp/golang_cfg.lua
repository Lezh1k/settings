local golang_cfg = {}

local function get_root_dir(fname)
  local marker = vim.fs.find({ "go.work", "go.mod", ".git" }, {
    path = fname,
    upward = true,
  })[1]
  return vim.fs.dirname(marker) or vim.fs.dirname(fname)
end

local function on_attach_keymap(_, _)
  vim.keymap.set("i", "<A-/>", "//////////////////////////////////////////////////////////////")
end

function golang_cfg.on_attach(client, bufnr)
  on_attach_keymap(client, bufnr)
end

golang_cfg.settings = {
  gopls = {
    -- completeUnimported = true,
    -- usePlaceholders = true,
    -- analyzes = {
    --   unusedparams = true,
    -- },
    gofumpt = true,
    -- staticcheck = false,
    -- diagnosticsTrigger = "Save",
    -- vulncheck = "Off",
  },
}

golang_cfg.cmd = { "gopls" }
golang_cfg.filetypes = { "go", "gomod", "gowork", "gotmpl" }
golang_cfg.pf_get_root_dir = get_root_dir

return golang_cfg
