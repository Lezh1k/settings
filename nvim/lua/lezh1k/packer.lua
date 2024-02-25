-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")
return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  use("nvim-lualine/lualine.nvim") -- A better statusline

  use {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    requires = { {
      "nvim-lua/plenary.nvim",
    } }
  }

  use {
    "mg979/vim-visual-multi",
    branch = "master",
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    {
      run = ":TSUpdate",
    }
  }

  use("NLKNguyen/papercolor-theme")

  use {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    }
  }

  use { "https://git.sr.ht/~p00f/clangd_extensions.nvim" }

  use {
    "ray-x/lsp_signature.nvim",
  }

  use {
    "mfussenegger/nvim-dap",

    requires = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
    }
  }
  use 'mfussenegger/nvim-dap-python'

  use("terrortylor/nvim-comment")
  use("akinsho/toggleterm.nvim")
end)
