-- Universal Ctags + gutentags for fast jumps across Python/Cython/Rust.
-- Requires: brew install universal-ctags
return {
  {
    "ludovicchabant/vim-gutentags",
    event = "VeryLazy",
    init = function()
      local ctags = vim.fn.executable("ctags") == 1 and vim.fn.exepath("ctags") or ""
      -- Prefer Homebrew universal-ctags over macOS/Xcode ctags.
      for _, candidate in ipairs({
        "/opt/homebrew/bin/ctags",
        "/usr/local/bin/ctags",
      }) do
        if vim.fn.executable(candidate) == 1 then
          ctags = candidate
          break
        end
      end

      vim.g.gutentags_ctags_executable = ctags
      vim.g.gutentags_project_root = {
        ".git",
        "Cargo.toml",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "Makefile",
      }
      vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/tags"
      vim.g.gutentags_generate_on_new = true
      vim.g.gutentags_generate_on_missing = true
      vim.g.gutentags_generate_on_write = true
      vim.g.gutentags_generate_on_empty_buffer = false
      vim.g.gutentags_file_list_command = "rg --files"

      vim.g.gutentags_ctags_extra_args = {
        "--tag-relative=yes",
        "--fields=+ailmnS",
        "--extras=+q",
        "--exclude=.git",
        "--exclude=target",
        "--exclude=build",
        "--exclude=dist",
        "--exclude=.venv",
        "--exclude=venv",
        "--exclude=__pycache__",
        "--exclude=*.egg-info",
        "--exclude=node_modules",
        "--languages=Python,Rust,C,C++",
        -- Treat Cython as Python so defs/classes in .pyx/.pxd are indexed.
        "--langmap=Python:+.pyx.pxd.pxi",
      }

      vim.g.gutentags_ctags_exclude = {
        "*.min.js",
        "*.min.css",
        "*.svg",
        "*.json",
        "*/vendor/*",
        "*/node_modules/*",
        "*/.venv/*",
        "*/venv/*",
        "*/target/*",
        "*/build/*",
        "*/dist/*",
        "*.so",
        "*.dylib",
        "*.o",
      }
    end,
    keys = {
      { "<leader>cT", "<cmd>GutentagsUpdate!<cr>", desc = "Rebuild Ctags" },
    },
  },
}
