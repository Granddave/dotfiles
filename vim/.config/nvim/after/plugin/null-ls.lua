if not HAS("null-ls") then
  return
end

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Shell
    null_ls.builtins.formatting.shfmt.with({
      filetypes = { "sh", "bash" },
      extra_args = { "-i", "4", "--case-indent", "--space-redirects" },
    }),

    -- Python
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.flake8,

    -- C++
    null_ls.builtins.diagnostics.cmake_lint,

    -- Yaml
    null_ls.builtins.diagnostics.yamllint,
  },
})
