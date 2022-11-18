local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    --null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt.with({
      filetypes = { "sh", "bash" },
      extra_args = { "-i", "4", "-ci" },
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.pylint,
  },
})
