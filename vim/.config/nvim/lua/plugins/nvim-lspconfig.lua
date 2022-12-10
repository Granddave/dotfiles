local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

-- LSP servers to configure and optional override opts
local servers = {
  bashls = {},
  pyright = {},
  clangd = {},
  cmake = {},
  yamlls = {},
  vimls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim', 'use' },
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
  jsonls = {},
  groovyls = {},
  tsserver = {},
}

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
--vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<Leader>dp', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local telescope = require('telescope.builtin')
  local telescope_opts = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = "top"
    }
  }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', function() telescope.lsp_definitions(telescope_opts) end, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set('n', '<Leader>lw',
  --  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  --  bufopts
  --)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<Leader>gr",
    function() telescope.lsp_references(telescope_opts) end,
    bufopts
  )
  vim.keymap.set('n', '<Leader>fo',
    function() vim.lsp.buf.format({ async = true }) end,
    bufopts
  )
  vim.keymap.set("n", "<Leader>fs",
    function() telescope.lsp_dynamic_workspace_symbols(telescope_opts) end,
    bufopts
  )
  vim.keymap.set("n", "<M-o>", [[<Cmd>ClangdSwitchSourceHeader<CR>]], bufopts)

  if client.server_capabilities["documentHighlightProvider"] then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=Gray guibg=#504945
      hi! LspReferenceText cterm=bold ctermbg=Gray guibg=#504945
      hi! LspReferenceWrite cterm=bold ctermbg=Gray guibg=#504945
    ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local lsp_opts = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}
for server_name, user_opts in pairs(servers) do
  lsp_opts = vim.tbl_deep_extend("force", lsp_opts, user_opts)
  require('lspconfig')[server_name].setup(lsp_opts)
end

-- Attach to a remote Clangd server run by:
-- `socat tcp-listen:4444,reuseaddr exec:"$CLANGD_BIN --background-index"`
vim.keymap.set("n", "<Leader>cpp",
  function()
    lsp_opts = vim.tbl_deep_extend("force", lsp_opts, {
      cmd = { "nc", "127.0.0.1", "4444" },
    })
    require('lspconfig')['clangd'].setup(lsp_opts)
  end,
  { noremap = true, silent = true }
)

-- Disable inline diagnostics and require hover for pop-up window
vim.diagnostic.config({
  virtual_text = false,
})
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("LSPDiagnosticsOnHover", {}),
  callback = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }
    -- Show the pop-up diagnostics window,
    -- but only once for the current cursor location (unless moved afterwards).
    -- TODO: Don't show diagnostics if it's already opened.
    if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
      vim.w.lsp_diagnostics_last_cursor = current_cursor
      vim.diagnostic.open_float(0, { scope = "cursor" })
    end
  end
})
