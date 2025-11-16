return {
  "WilliamHsieh/overlook.nvim",
  opts = {},
  keys = {
    { "<leader>ogd", function() require("overlook.api").peek_definition() end, desc = "Overlook: Peek definition" },
    { "<leader>oq", function() require("overlook.api").close_all() end, desc = "Overlook: Close all popup" },
    { "<leader>or", function() require("overlook.api").restore_popup() end, desc = "Overlook: Restore popup" },
    { "<leader>oo", function() require("overlook.api").open_in_original_window() end, desc = "Open popup in current window" },
  },
}
