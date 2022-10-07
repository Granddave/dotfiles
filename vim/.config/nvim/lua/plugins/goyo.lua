vim.keymap.set("n", "<Leader>go", "<Cmd>Goyo<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoEnter",
  callback = function()
    if vim.fn.executable('tmux') == 1 and os.getenv('TMUX') then
      io.popen('tmux set status off')
    end
    require('lualine').hide()
    vim.cmd("Limelight")
    vim.opt.cursorline = false
    vim.opt.showmode = false
    vim.opt.showtabline = 0
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoLeave",
  callback = function()
    if vim.fn.executable('tmux') == 1 and os.getenv('TMUX') then
      io.popen('tmux set status on')
    end
    require('lualine').hide({ unhide = true })
    vim.cmd("Limelight!")
    vim.opt.cursorline = true
    vim.opt.showmode = true
    vim.opt.showtabline = 1
  end,
})
