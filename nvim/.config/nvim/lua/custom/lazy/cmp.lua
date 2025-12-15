return {
  -- "hrsh7th/nvim-cmp",
  -- dependencies = {
  --   "hrsh7th/cmp-nvim-lua",
  --   "hrsh7th/cmp-nvim-lsp",
  --   "hrsh7th/cmp-buffer",
  --   "hrsh7th/cmp-path",
  --   "hrsh7th/cmp-cmdline",
  --   "rcarriga/cmp-dap",
  --   "L3MON4D3/LuaSnip",
  --   "saadparwaiz1/cmp_luasnip",
  --   "onsails/lspkind.nvim",
  -- },
  -- init = function()
  --   local cmp = require("cmp")
  --   vim.opt.completeopt = "menu,menuone,noinsert"
  --
  --   -- Copilot setup
  --   local lspkind = require("lspkind")
  --   lspkind.init({
  --     symbol_map = {
  --       Copilot = "",
  --     },
  --   })
  --   vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  --
  --   cmp.setup({
  --     snippet = {
  --       expand = function(args)
  --         require("luasnip").lsp_expand(args.body)
  --       end,
  --     },
  --     mapping = cmp.mapping.preset.insert({
  --       ["<C-n>"] = function()
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --         else
  --           cmp.complete()
  --         end
  --       end,
  --       ["<C-p>"] = function()
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         else
  --           cmp.complete()
  --         end
  --       end,
  --       ["<C-Space>"] = cmp.mapping.complete({}),
  --       ["<C-e>"] = cmp.mapping.abort(),
  --       ["<C-j>"] = cmp.mapping.confirm({ select = true }),
  --       ["<C-d>"] = function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item({ count = 5 })
  --         else
  --           fallback()
  --         end
  --       end,
  --       ["<C-u>"] = function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item({ count = 5 })
  --         else
  --           fallback()
  --         end
  --       end,
  --       ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --       ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --     }),
  --     sources = cmp.config.sources({
  --       { name = "copilot", group_index = 2 },
  --       { name = "nvim_lsp" },
  --       { name = "nvim_lua" },
  --       { name = "luasnip" },
  --       { name = "path" },
  --       { name = "buffer",  keyword_length = 4 },
  --     }),
  --     experimental = {
  --       ghost_text = true
  --     },
  --     formatting = {
  --       format = lspkind.cmp_format({
  --         mode = "symbol_text",
  --         maxwidth = 50,
  --         ellipsis_char = "...",
  --         menu = {
  --           buffer = "[buf]",
  --           nvim_lsp = "[LSP]",
  --           nvim_lua = "[api]",
  --           path = "[path]",
  --           luasnip = "[snip]",
  --           cmdline = "[cmd]",
  --           Copilot = "[cplt]",
  --         },
  --       })
  --     },
  --     enabled = function()
  --       return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  --           or require("cmp_dap").is_dap_buffer()
  --     end,
  --   })
  --
  --   cmp.setup.cmdline("/", {
  --     mapping = cmp.mapping.preset.cmdline(),
  --     sources = {
  --       { name = "buffer" }
  --     }
  --   })
  --
  --   cmp.setup.cmdline(":", {
  --     mapping = cmp.mapping.preset.cmdline(),
  --     sources = cmp.config.sources({
  --       { name = "path" }
  --     }, {
  --       { name = "cmdline", keyword_length = 2 }
  --     })
  --   })
  --
  --   cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  --     sources = {
  --       { name = "dap" },
  --     },
  --   })
  -- end

  {
    "giuxtaposition/blink-cmp-copilot",
    dependencies = {
      "copilot.lua",
    }
  },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      --
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "default",
        ["C-j"] = { "select_and_accept" },
        ["Enter"] = { "select_and_accept" },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono"
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "copilot",
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
        min_keyword_length = 2,
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" }
  }
}
