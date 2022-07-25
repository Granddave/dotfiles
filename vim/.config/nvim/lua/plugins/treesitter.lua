require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = {
    enable = true,
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
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})
