local cached_opts = {}

local backup_opts = function()
  cached_opts.limelight = vim.fn.exists("#limelight")
  cached_opts.whitespace = vim.api.nvim_buf_get_var(0, "better_whitespace_enabled")
  cached_opts.cursorline = vim.opt.cursorline:get()
  cached_opts.showmode = vim.opt.showmode:get()
  cached_opts.showtabline = vim.opt.showtabline:get()
  cached_opts.scrolloff = vim.opt.scrolloff:get()
  cached_opts.scrollbar = require("custom.scrollbar").is_shown()
end

local restore_opts = function()
  if cached_opts.limelight == 0 then
    vim.cmd("Limelight!")
  end
  if cached_opts.whitespace == 1 then
    vim.cmd("EnableWhitespace")
  end
  vim.opt.cursorline = cached_opts.cursorline
  vim.opt.showmode = cached_opts.showmode
  vim.opt.showtabline = cached_opts.showtabline
  vim.opt.scrolloff = cached_opts.scrolloff
  require("custom.scrollbar").show(cached_opts.scrollbar)
end

return {
  {
    "junegunn/goyo.vim",
    dependencies = { "junegunn/limelight.vim", },
    init = function()
      vim.keymap.set("n", "<Leader>go", "<Cmd>Goyo<CR>", { noremap = true, silent = true })

      local goyo_group = vim.api.nvim_create_augroup("GoyoEvents", {})
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoEnter",
        callback = function()
          backup_opts()
          if vim.fn.executable("tmux") == 1 and os.getenv("TMUX") then
            io.popen("tmux set status off")
          end
          require("lualine").hide({})
          vim.cmd("Limelight")
          vim.cmd("DisableWhitespace")
          vim.opt.cursorline = false
          vim.opt.showmode = false
          vim.opt.showtabline = 0
          vim.opt.scrolloff = 0
          require("custom.scrollbar").show(false)
        end,
        group = goyo_group,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoLeave",
        callback = function()
          if vim.fn.executable("tmux") == 1 and os.getenv("TMUX") then
            io.popen("tmux set status on")
          end
          restore_opts()
          require("lualine").hide({ unhide = true })
          require("bufferline").setup() -- TODO: save previous state
        end,
        group = goyo_group,
      })
    end,
  }

}
