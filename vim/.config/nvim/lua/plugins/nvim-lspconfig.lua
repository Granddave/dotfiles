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
  vim.keymap.set('n', 'gd',
    function() telescope.lsp_definitions(telescope_opts) end,
    bufopts
  )
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wl',
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
  vim.keymap.set('n', '<Leader>fo', vim.lsp.buf.formatting, bufopts)
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

local lsp_flags = {
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['bashls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require('lspconfig')['pyright'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require('lspconfig')['cmake'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require('lspconfig')['yamlls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require('lspconfig')['vimls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require('lspconfig')['sumneko_lua'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
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
  capabilities = capabilities
}
require('lspconfig')['jsonls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require('lspconfig')['groovyls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
