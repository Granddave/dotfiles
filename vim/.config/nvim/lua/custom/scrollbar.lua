local M = {}

local is_shown = false

M.show = function(show)
  is_shown = show
  require('scrollbar').setup({
    show = show,
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true, -- Requires gitsigns
      handle = true,
      search = false, -- Requires hlslens
    },
  })
end

M.is_shown = function()
  return is_shown
end

M.show(true)

return M
