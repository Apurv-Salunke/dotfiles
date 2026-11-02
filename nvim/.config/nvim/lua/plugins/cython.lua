-- Cython (.pyx / .pxd / .pxi) — treesitter + light filetype polish.
-- Neovim's filetype is still "pyrex"; the parser language is "cython".
return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").cython = {
            install_info = {
              url = "https://github.com/b0o/tree-sitter-cython",
              revision = "756a20c4d601b715f7b321eaad144f4cb14031bf",
              queries = "queries",
            },
          }
        end,
      })
    end,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cython" })
      vim.treesitter.language.register("cython", { "pyrex" })
    end,
  },

  {
    "nvim-mini/mini.icons",
    opts = {
      extension = {
        pyx = { glyph = "", hl = "MiniIconsAzure" },
        pxd = { glyph = "", hl = "MiniIconsBlue" },
        pxi = { glyph = "", hl = "MiniIconsCyan" },
      },
      filetype = {
        pyrex = { glyph = "", hl = "MiniIconsAzure" },
      },
    },
  },
}
