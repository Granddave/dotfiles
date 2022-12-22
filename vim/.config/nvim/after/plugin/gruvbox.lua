local ok, gruvbox = pcall(require, "gruvbox")
if not ok then
  return
end

gruvbox.setup({
  contrast = "hard",
})
vim.cmd("colorscheme gruvbox")
