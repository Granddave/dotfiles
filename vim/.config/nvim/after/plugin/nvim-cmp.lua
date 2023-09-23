local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

vim.opt.completeopt = "menu,menuone,noinsert"


local lspkind = require("lspkind")

-- Copilot setup
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- Cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end,
    ["<C-p>"] = function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end,
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-j>"] = cmp.mapping.confirm({ select = true }),
    ["<C-d>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ count = 5 })
      else
        fallback()
      end
    end,
    ["<C-u>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ count = 5 })
      else
        fallback()
      end
    end,
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 4 },
  }),
  experimental = {
    ghost_text = true
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        cmdline = "[cmd]",
        Copilot = "[cplt]",
      },
    })
  },
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end,
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline", keyword_length = 2 }
  })
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})
