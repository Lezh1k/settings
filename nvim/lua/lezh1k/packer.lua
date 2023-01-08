-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")
return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  use("nvim-lualine/lualine.nvim") -- A better statusline

  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    -- or                            , branch = "0.1.x",
    requires = { { "nvim-lua/plenary.nvim" } }
  }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  use {
    "nvim-treesitter/nvim-treesitter", {
      run = ":TSUpdate"
    }
  }
  use("NLKNguyen/papercolor-theme")

  use {
    "VonHeikemen/lsp-zero.nvim",
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

  use {
    "ray-x/lsp_signature.nvim",
  }

  use ("ThePrimeagen/vim-be-good")
end)
