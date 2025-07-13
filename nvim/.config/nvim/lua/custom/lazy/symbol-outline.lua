return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<Leader>ol", function() require("outline").toggle() end, desc = "Toggle outline" },
  },
  opts = {},
}
