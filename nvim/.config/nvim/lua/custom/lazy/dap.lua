return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dap_ui = require("dapui")
    local dap_go = require("dap-go")

    dap_ui.setup()
    dap_go.setup()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-dap-virtual-text").setup({})

    require("which-key").add({
      { "<Leader>bc",  function() dap.continue() end,                                             desc = "Debug: Continue" },
      { "<Leader>bn",  function() dap.step_over() end,                                            desc = "Debug: Step Over" },
      { "<Leader>bi",  function() dap.step_into() end,                                            desc = "Debug: Step Into" },
      { "<Leader>bo",  function() dap.step_out() end,                                             desc = "Debug: Step Out" },
      { "<Leader>ba",  function() dap.terminate() end,                                            desc = "Debug: Terminate" },
      { "<Leader>bb",  function() dap.toggle_breakpoint() end,                                    desc = "Debug: Toggle Breakpoint" },
      { "<Leader>B",   function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set Conditional Breakpoint" },
      { "<Leader>bl",  function() dap.run_last() end,                                             desc = "Debug: Run Last" },
      { "<Leader>dap", function() dap_ui.toggle() end,                                            desc = "Debug: Toggle UI" },
    })

    dap.adapters.python = {
      type = "executable",
      command = "/usr/bin/env python3", --'path/to/virtualenvs/debugpy/bin/python'
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        program = "${file}",
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
            return cwd .. "/venv/bin/python3"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
            return cwd .. "/.venv/bin/python3"
          else
            return "/usr/bin/env python3"
          end
        end,
      },
    }

    -- Install codeLLDB with Mason
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" }
      }
    }
    -- dap.configurations.rust = {
    --   {
    --     name = "hello-world",
    --     type = "codelldb",
    --     request = "launch",
    --     program = function()
    --       return vim.fn.getcwd() .. "/target/debug/my-bin"
    --     end,
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    --   },
    -- }
    --
    -- Use this to load the launch.json:
    -- require('dap.ext.vscode').load_launchjs(nil, { codelldb = {"rust"} })
  end
}
