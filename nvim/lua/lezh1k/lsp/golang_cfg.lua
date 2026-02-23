local golang_cfg = {}

local function get_root_dir(fname)
  return vim.fs.dirname(
    vim.fs.find({ "go.work", "go.mod", ".git" }, {
      path = fname,
      upward = true,
    })[1]
  )
end

golang_cfg.settings = {
  gopls = {
    -- completeUnimported = true,
    -- usePlaceholders = true,
    -- analyzes = {
    --   unusedparams = true,
    -- },
    gofumpt = true,
    staticcheck = true,
  },
}

golang_cfg.cmd = { "gopls" }
golang_cfg.filetypes = { "go", "gomod", "gowork", "gotmpl" }
golang_cfg.pf_get_root_dir = get_root_dir

return golang_cfg
