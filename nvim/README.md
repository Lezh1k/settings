## How to enable all plugins.

1. run `vim lua/lezh1k/packer.lu`
2. inside vim source this file (`:so` or `:source` command)
3. run `:PackerSync`
4. restart and enjoy.

## How to enable LSP servers

Use `:Mason` command. See [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim) repository.

## Roadmap

- [x] base config

- [ ] list of functions for each type of source files (C/C++ , Python, Lua, Golang)

- [ ] debug in nvim (dap or termdebug)

- [x] ability to config workspace for each project independently 
