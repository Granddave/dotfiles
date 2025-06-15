---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
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
	filetypes = { "lua" },
	root_markers = { ".luarc.json", "luarc.lua", ".git" },
}
