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
      return (
          lang == "markdown" and vim.api.nvim_buf_line_count(bufnr) > 5000
              or vim.api.nvim_buf_get_option(0, "filetype") == "help"
          )
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
