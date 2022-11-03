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
  vim.keymap.set('n', '<Leader>lw',
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    bufopts
  )
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

  if client.server_capabilities["documentHighlightProvider"] then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=Gray guibg=#555555
      hi! LspReferenceText cterm=bold ctermbg=Gray guibg=#555555
      hi! LspReferenceWrite cterm=bold ctermbg=Gray guibg=#555555
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

for server_name, user_opts in pairs(servers) do
  local lsp_opts = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }
  lsp_opts = vim.tbl_deep_extend("force", lsp_opts, user_opts)
  require('lspconfig')[server_name].setup(lsp_opts)
end
