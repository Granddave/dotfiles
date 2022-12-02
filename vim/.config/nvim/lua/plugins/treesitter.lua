require("nvim-treesitter.configs").setup({
  auto_install = true,
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "java",
    "json",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "python",
    "sql",
    "toml",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      local megabytes_in_buffer = require("custom.utils").bytes_in_buffer(bufnr) / (10 ^ 6)
      return megabytes_in_buffer
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = "gnn",
      node_decremental = "grm",
      node_incremental = "grn",
      scope_incremental = "grc"
    },
  },
  indent = {
    enable = true,
    disable = {},
  }
})
