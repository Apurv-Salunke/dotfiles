return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_horizontal" },
      },
    },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
      { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView File History" },
      { "<leader>gB", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView Branch History" },
    },
  },
}
