vim.lsp.enable({
  "lua_ls",
  -- TODO: Add more language servers here
})

vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- if client:supports_method('textDocument/implementation') then
    --   -- Create a keymap for vim.lsp.buf.implementation ...
    -- end
    local fzf = require("fzf-lua")

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = ev.buf })

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", function() fzf.lsp_definitions() end, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", function() fzf.lsp_implementations() end, bufopts)
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
      function() fzf.lsp_references() end,
      bufopts
    )
    vim.keymap.set({ "n", "v" }, "<Leader>fo",
      function() vim.lsp.buf.format({ async = false }) end,
      bufopts
    )
    vim.keymap.set("n", "<Leader>fs", -- 'ws' would have been better, but conflicts with 'w' for write
      function() fzf.lsp_workspace_symbols() end,
      bufopts
    )
    vim.keymap.set("n", "<Leader>ds",
      function() fzf.lsp_document_symbols() end,
      bufopts
    )

    -- float = false due to diagnostic hover config
    vim.keymap.set("n", "<Leader>dp", function() vim.diagnostic.goto_prev({ float = false }) end, bufopts)
    vim.keymap.set("n", "<Leader>dn", function() vim.diagnostic.goto_next({ float = false }) end, bufopts)

    -- Toggle between source and header file
    if client.name == "clangd" then
      vim.keymap.set("n", "<M-o>", [[<Cmd>ClangdSwitchSourceHeader<CR>]], bufopts)
    end

    -- Toggle between implementation and test files
    if vim.tbl_contains({ "gopls", "jedi_language_server", "pyright" }, client.name) then
      vim.keymap.set("n", "<M-o>", function()
        local current_file = vim.fn.expand("%:p")
        local base_name = vim.fn.expand("%:t:r")
        local extension = vim.fn.expand("%:e")
        local impl_file, test_file
        if base_name:match("_test$") then
          test_file = current_file
          impl_file = string.format("%s/%s.%s", vim.fn.expand("%:p:h"), base_name:gsub("_test$", ""), extension)
        else
          impl_file = current_file
          test_file = string.format("%s/%s_test.%s", vim.fn.expand("%:p:h"), base_name, extension)
        end
        if current_file ~= test_file and vim.fn.filereadable(test_file) == 1 then
          vim.cmd("edit " .. test_file)
        elseif current_file ~= impl_file and vim.fn.filereadable(impl_file) == 1 then
          vim.cmd("edit " .. impl_file)
        else
          print("No matching test/impl found.")
        end
      end, bufopts)
    end

    -- Auto format on save
    if vim.tbl_contains({ "gopls", "rust_analyzer" }, client.name) then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
