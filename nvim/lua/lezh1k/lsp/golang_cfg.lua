local golang_cfg = {}

golang_cfg.settings = {
  gopls = {
    completeUnimported = true,
    usePlaceholders = true,
    gofumpt = true,
    -- analyzes = {
    --   unusedparams = true,
    -- },
  },
}

golang_cfg.cmd = { "gopls" }
golang_cfg.filetypes = { "go", "gomod", "gowork", ".git" }


return golang_cfg
