-- Cython filetype polish (Neovim detects .pyx/.pxd/.pxi as "pyrex")
vim.opt_local.commentstring = "# %s"
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.suffixesadd:append({ ".pyx", ".pxd", ".pxi", ".py" })

-- Jump between matching .pyx ↔ .pxd next to the current file.
vim.keymap.set("n", "<leader>cy", function()
  local ext = vim.fn.expand("%:e")
  local base = vim.fn.expand("%:r")
  local target ---@type string?
  if ext == "pyx" then
    target = base .. ".pxd"
  elseif ext == "pxd" then
    target = base .. ".pyx"
  else
    vim.notify("No .pyx/.pxd companion for ." .. ext, vim.log.levels.INFO)
    return
  end
  if vim.fn.filereadable(target) == 0 then
    vim.notify("Companion not found: " .. vim.fn.fnamemodify(target, ":."), vim.log.levels.WARN)
    return
  end
  vim.cmd.edit(target)
end, { buffer = true, desc = "Toggle Cython Companion (.pyx/.pxd)" })
