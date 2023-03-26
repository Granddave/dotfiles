if not HAS({ "mason", "mason-lspconfig", "lspconfig" }) then
  return
end

-- LSP servers to configure and optional override opts
local servers = {
  ansiblels = {},
  bashls = {},
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
    }
  },
  cmake = {},
  dockerls = {},
  gopls = {},
  groovyls = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = {
            "vim",
            "use",
            "print",
            "require",
          },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false
      }
    }
  },
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = require("custom.utils").table_keys(servers)
})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local telescope = require("telescope.builtin")
  local telescope_opts = {
    sorting_strategy = "ascending",
    fname_width = 60,
    path_display = { "smart" },
    layout_strategy = "vertical",
    layout_config = {
      width = 0.95
    },
  }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", function() telescope.lsp_definitions(telescope_opts) end, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set('n', '<Leader>lw',
  --  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  --  bufopts
  --)
  vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<Leader>gr",
    function() telescope.lsp_references(telescope_opts) end,
    bufopts
  )
  vim.keymap.set("n", "<Leader>fo",
    function() vim.lsp.buf.format({ async = true }) end,
    bufopts
  )
  vim.keymap.set("n", "<Leader>fs",
    function() telescope.lsp_dynamic_workspace_symbols(telescope_opts) end,
    bufopts
  )
  if client.name == "clangd" then
    vim.keymap.set("n", "<M-o>", [[<Cmd>ClangdSwitchSourceHeader<CR>]], bufopts)
  end
  if client.name == "gopls" then
    vim.keymap.set("n", "<M-o>", function()
      local current_file = vim.fn.expand('%:p')
      local base_name = vim.fn.expand('%:t:r')
      local extension = vim.fn.expand('%:e')
      local impl_file, test_file

      if base_name:match("_test$") then
        test_file = current_file
        impl_file = string.format("%s/%s.%s", vim.fn.expand('%:p:h'), base_name:gsub("_test$", ""), extension)
      else
        impl_file = current_file
        test_file = string.format("%s/%s_test.%s", vim.fn.expand('%:p:h'), base_name, extension)
      end

      if current_file ~= test_file and vim.fn.filereadable(test_file) == 1 then
        vim.cmd('edit ' .. test_file)
      elseif current_file ~= impl_file and vim.fn.filereadable(impl_file) == 1 then
        vim.cmd('edit ' .. impl_file)
      else
        print("No matching test/impl found.")
      end
    end, bufopts)
  end
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("LSPFormatOnSave", {}),
    callback = function()
      for _, value in ipairs({ "gopls", "rust_analyzer" }) do
        if value == client.name then
          vim.lsp.buf.format({ async = true })
          break
        end
      end
    end,
  })

  if client.server_capabilities["documentHighlightProvider"] then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=Gray guibg=#504945
      hi! LspReferenceText cterm=bold ctermbg=Gray guibg=#504945
      hi! LspReferenceWrite cterm=bold ctermbg=Gray guibg=#504945
    ]]
    local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = lsp_document_highlight,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = lsp_document_highlight,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  vim.keymap.set("n", "<Leader>dp", function() vim.diagnostic.goto_prev({ float = false }) end, bufopts)
  vim.keymap.set("n", "<Leader>dn", function() vim.diagnostic.goto_next({ float = false }) end, bufopts)
  vim.keymap.set("n", "<Leader>dl", vim.diagnostic.setloclist, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lsp_opts = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}
for server_name, user_opts in pairs(servers) do
  local opts = vim.tbl_deep_extend("force", lsp_opts, user_opts)
  require("lspconfig")[server_name].setup(opts)
end

-- Attach to a remote Clangd server run by:
-- `socat tcp-listen:4444,reuseaddr exec:"$CLANGD_BIN --background-index"`
vim.keymap.set("n", "<Leader>cpp",
  function()
    local opts = vim.tbl_deep_extend("force", lsp_opts, {
      cmd = { "nc", "127.0.0.1", "4444" },
    })
    require("lspconfig")["clangd"].setup(opts)
  end,
  { noremap = true, silent = true }
)

-- Disable inline diagnostics and require hover for pop-up window
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  float = {
    format = function(diagnostic)
      return string.format(
        "%s (%s) [%s]",
        diagnostic.message,
        diagnostic.source,
        diagnostic.code or diagnostic.user_data.lsp.code
      )
    end,
  },
})
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("LSPDiagnosticsOnHover", {}),
  callback = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }
    -- Show the pop-up diagnostics window,
    -- but only once for the current cursor location (unless moved afterwards).
    if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
      vim.w.lsp_diagnostics_last_cursor = current_cursor
      vim.diagnostic.open_float(0, { scope = "cursor" })
    end
  end
})
