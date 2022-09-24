vim.keymap.set("n", "<Leader>go", "<Cmd>Goyo<CR><Cmd>Goyo<CR><Cmd>Goyo<CR>", { noremap = true, silent = true })

vim.cmd([[
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
  endif
  luado require('lualine').hide()
  Limelight
  set cursorline!
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
  endif
  luado require('lualine').hide({unhide=true})
  Limelight!
  set cursorline
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
]])
