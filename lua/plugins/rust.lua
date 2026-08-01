-- Keep Rust quiet until it's a daily language.
-- Mason already has rust-analyzer installed; mason-lspconfig would auto-start it
-- on .rs files, which triggers cargo downloads / indexing.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = { enabled = false },
      },
    },
  },
}
