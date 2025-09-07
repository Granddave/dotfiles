return {
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = { "copilot.lua", "hrsh7th/nvim-cmp" },
  --   opts = {},
  -- },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = {
        -- enabled = true,
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
        -- enabled = true,
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
        yaml = true,
        markdown = false,
        txt = false,
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
    },
  },
}
