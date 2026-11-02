return {
  -- 1. Configure Formatter (Conform)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Use "ruff_format" instead of "black"
        -- "isort" is usually not needed if using ruff, as ruff handles imports too
        -- python = { "black" },

        -- To use Ruff instead, uncomment line below and comment line above:
        python = { "ruff_format" },
      },
    },
  },

  -- 2. Configure Linter (nvim-lint)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- Use flake8 instead of (or alongside) ruff
        -- python = { "flake8" },
      },
    },
  },

  -- 3. Configure LSP (Pyright / Basedpyright)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
    },
  },
}
