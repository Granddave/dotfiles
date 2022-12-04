local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
  return
end

lsp_installer.setup({
})
