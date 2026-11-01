vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = "100"

if vim.fn.executable("presenterm") == 1 then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(event)
      vim.keymap.set("i", "<C-k>", function()
        local fzf = require("fzf-lua")
        fzf.fzf_exec("presenterm --list-comment-commands", {
          prompt = "Presenterm> ",
          winopts = {
            relative = "cursor",
            width = 50,
            height = 0.3,
            fullscreen = false,
          },
          fzf_opts = {
            ["--header"] = "Comment Command Selection",
            ["--no-hscroll"] = true,
          },
          actions = {
            ["default"] = function(selected)
              if selected and selected[1] then
                vim.api.nvim_put({ selected[1] }, "c", true, true)
              end
            end,
          },
        })
      end, {
        buffer = event.buf,
        desc = "Insert presenterm comment command",
      })
    end,
  })
end
