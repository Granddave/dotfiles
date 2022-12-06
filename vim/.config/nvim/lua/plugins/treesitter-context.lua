local ok, _ = pcall(require, "treesitter-context")
if not ok then
  return
end

require("treesitter-context").setup({
})
