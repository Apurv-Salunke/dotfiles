-- Ctrl-h/j/k/l moves across nvim splits and WezTerm panes as one grid.
-- WezTerm side lives in wezterm/.wezterm.lua (checks the IS_NVIM user var this sets).
return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {},
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Go to Left Window" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Go to Lower Window" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Go to Upper Window" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Go to Right Window" },
    },
  },
}
