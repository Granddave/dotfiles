vim.keymap.set("n", "<Leader>go", "<Cmd>Goyo<CR><Cmd>Goyo<CR><Cmd>Goyo<CR>", { noremap = true, silent = true })

vim.cmd([[
autocmd! User GoyoEnter nested :luado require('lualine').hide({unhide=false})
autocmd! User GoyoLeave nested :luado require('lualine').hide({unhide=true})
]])
