local ok, dap = pcall(require, "dap")
if not ok then
  return
end

require("dapui").setup()

local dap_go = require("dap-go")
dap_go.setup()

require("nvim-dap-virtual-text").setup()

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader>bc", function() dap.continue() end, opts)
vim.keymap.set("n", "<Leader>bn", function() dap.step_over() end, opts)
vim.keymap.set("n", "<Leader>bi", function() dap.step_into() end, opts)
vim.keymap.set("n", "<Leader>bo", function() dap.step_out() end, opts)
vim.keymap.set("n", "<Leader>ba", function() dap.terminate() end, opts)
vim.keymap.set("n", "<Leader>bb", function() dap.toggle_breakpoint() end, opts)
vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, opts)
vim.keymap.set("n", "<Leader>bl", function() dap.run_last() end, opts)
vim.keymap.set("n", "<Leader>dap", function() require("dapui").toggle() end, opts)
--vim.keymap.set("n", "<Leader>bt", function() dap_go.debug_test() end, opts)

dap.adapters.python = {
  type = "executable",
  command = "/usr/bin/python3", --'path/to/virtualenvs/debugpy/bin/python'
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
        return "/usr/bin/python3"
      end
    end,
  },
}
