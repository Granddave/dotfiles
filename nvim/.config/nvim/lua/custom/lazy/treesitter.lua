return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter", },
  },
  {
    "ikatyang/tree-sitter-yaml",
    dependencies = { "nvim-treesitter/nvim-treesitter", },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        auto_install = true,
        ignore_install = { "yaml" }, -- https://stackoverflow.com/a/76688955/4774715
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
            return megabytes_in_buffer >= 1
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
    end
  },
}
