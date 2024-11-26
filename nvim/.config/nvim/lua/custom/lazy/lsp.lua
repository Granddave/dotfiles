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
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
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
  nil_ls = {
    settings = {
        ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
    },
  },
  pyright = {},
  rust_analyzer = {},
  taplo = {},
  ruff = {},
  ts_ls = {},
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false
      }
    }
  },
}

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
  vim.keymap.set("n", "gi", function() telescope.lsp_implementations(telescope_opts) end, bufopts)
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
  vim.keymap.set({ "n", "v" }, "<Leader>fo",
    function() vim.lsp.buf.format({ async = false }) end,
    bufopts
  )
  vim.keymap.set("n", "<Leader>fs", -- 'ws' would have been better, but conflicts with 'w' for write
    function() telescope.lsp_dynamic_workspace_symbols(telescope_opts) end,
    bufopts
  )
  vim.keymap.set("n", "<Leader>ds",
    function() telescope.lsp_document_symbols(telescope_opts) end,
    bufopts
  )
  if client.name == "clangd" then
    vim.keymap.set("n", "<M-o>", [[<Cmd>ClangdSwitchSourceHeader<CR>]], bufopts)
  end

  local impl_test_file_toggle = function()
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
  -- Enable for clients including "gopls", "jedi_language_server" and "pyright"
  if vim.tbl_contains({ "gopls", "jedi_language_server", "pyright" }, client.name) then
    impl_test_file_toggle()
  end
  if vim.tbl_contains({ "gopls", "rust_analyzer" }, client.name) then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end

  vim.keymap.set("n", "<Leader>dp", function() vim.diagnostic.goto_prev({ float = false }) end, bufopts)
  vim.keymap.set("n", "<Leader>dn", function() vim.diagnostic.goto_next({ float = false }) end, bufopts)
  -- vim.keymap.set("n", "<Leader>dl", vim.diagnostic.setloclist, bufopts)
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "j-hui/fidget.nvim",       opts = {} },
      { "folke/neodev.nvim",       opts = {} },
    },
    config = function()
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
              diagnostic.code or diagnostic.user_data.lsp.code or ""
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
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local trouble = require("trouble")
      trouble.setup()

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map("n", "<leader>qt", function() trouble.toggle() end, opts)
      map("n", "<leader>qw", function() trouble.toggle("workspace_diagnostics") end, opts)
      map("n", "<leader>qd", function() trouble.toggle("document_diagnostics") end, opts)
      map("n", "<leader>qq", function() trouble.toggle("quickfix") end, opts)
      map("n", "<leader>dl", function() trouble.toggle("loclist") end, opts)
      -- map("n", "<leader>dn", function() trouble.next({ skip_groups = true, jump = true }); end, opts)
      -- map("n", "<leader>dp", function() trouble.previous({ skip_groups = true, jump = true }); end, opts)
    end
  }
}
