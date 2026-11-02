-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function format_diagnostic(d)
  local severity = vim.diagnostic.severity[d.severity] or "UNKNOWN"
  local line = d.lnum + 1
  local src = d.source and (" [" .. d.source .. "]") or ""
  return string.format("%s:%d: %s:%s %s", vim.fn.expand("%:."), line, severity, src, d.message)
end

local function yank_diagnostics(diags, label)
  if #diags == 0 then
    vim.notify("No " .. label .. " diagnostics to copy", vim.log.levels.INFO)
    return
  end

  local lines = vim.tbl_map(format_diagnostic, diags)
  local text = table.concat(lines, "\n")
  vim.fn.setreg("+", text)
  vim.fn.setreg('"', text)
  vim.notify(string.format("Copied %d %s diagnostic(s)", #diags, label), vim.log.levels.INFO)
end

-- Live under <leader>x (diagnostics/quickfix). Avoid <leader>y — that prefix
-- has no LazyVim defaults, so a lone mapping there makes which-key look empty.
vim.keymap.set("n", "<leader>xy", function()
  yank_diagnostics(vim.diagnostic.get(0), "file")
end, { desc = "Yank File Diagnostics" })

vim.keymap.set("n", "<leader>xY", function()
  local lnum = vim.fn.line(".") - 1
  yank_diagnostics(vim.diagnostic.get(0, { lnum = lnum }), "line")
end, { desc = "Yank Line Diagnostics" })
