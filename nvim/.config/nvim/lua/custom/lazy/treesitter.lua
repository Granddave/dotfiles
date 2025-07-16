return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "ikatyang/tree-sitter-yaml",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        sync_install = false,
        modules = {},
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
            _ = lang
            local megabytes_in_buffer = require("custom.utils").bytes_in_buffer(bufnr) / (10 ^ 6)
            return megabytes_in_buffer >= 1
          end,
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
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    opts = {},
    keys = {
      { "<Leader>ct", "<Cmd>TSContext toggle<CR>", desc = "Toggle Treesitter Context" },
    },
  }
}
