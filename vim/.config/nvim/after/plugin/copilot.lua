local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup({
  panel = {
    --enabled = true,
    enabled = false,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    --enabled = true,
    enabled = false,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      --accept = "<M-l>",
      accept = "<C-j>",
      accept_word = false,
      accept_line = false,
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<C-h>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
