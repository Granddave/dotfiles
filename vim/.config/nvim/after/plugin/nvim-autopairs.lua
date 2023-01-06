local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

autopairs.setup({
})

require("cmp").event:on(
  "confirm_done",
  require("nvim-autopairs.completion.cmp").on_confirm_done()
)
