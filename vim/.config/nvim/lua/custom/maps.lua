local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<Space>", "", {})
vim.g.mapleader = " "

map("n", "<Leader>T", ":enew<CR>", opts)
map("n", "<Leader>n", ":bnext<CR>", opts)
map("n", "<Leader>p", ":bprev<CR>", opts)
map("n", "<Leader>bq", ":bp <Bar> bd #<CR>", opts)
map("n", "<Leader>bd", ":<C-u>up <Bar> %bd <Bar> e#<CR>", opts)

map("n", "<C-h>", ":wincmd h<CR>", opts)
map("n", "<C-j>", ":wincmd j<CR>", opts)
map("n", "<C-k>", ":wincmd k<CR>", opts)
map("n", "<C-l>", ":wincmd l<CR>", opts)

map("n", "<Leader>sl", ":set list!<CR>", opts)
map("n", "<Leader><Leader>", "za", opts)

map("v", "//", 'y/<C-r>"<CR>', { noremap = true })
map("x", "<Leader>sr", 'y:%s%<C-r>"%%g<left><left>', { noremap = true })
map("x", "<Leader>sc", 'y:%s%<C-r>"%%gc<left><left><left>', { noremap = true })

map("n", "<Esc>", ":nohlsearch<CR><Esc>", opts)
--map("n", "<Esc>^[", "<Esc>^[", opts)

local scroll_amount = 2
map("", "<C-e>", scroll_amount .. "<C-e>", opts)
map("", "<C-y>", scroll_amount .. "<C-y>", opts)
map("", "<C-Up>", "<C-U>", {})
map("", "<C-Down>", "<C-u>", {})

--map("n", "<C-j>", ":m .+1<CR>==", opts)
--map("n", "<C-k>", ":m .-2<CR>==", opts)
--map("i", "<C-j>", "<Esc>:m .+1<CR>==gi", opts)
--map("i", "<C-k>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("i", "<S-Tab>", "<C-d>", opts)

map("v", "p", '"_dP', opts)
map("v", "<C-c>", '"*y :let @+=@*<CR>:echo "Copied to system clipboard"<CR>', opts)
map("n", "<Leader>w", ":w<CR>", opts)
map("n", "<Leader>dw", ':call CleanTrailingSpaces()<CR>', opts)
map("v", "<Leader>tc", 'y:! timecalc.py <C-r>" <Bar> xclip -in -selection clipboard<CR>', opts)
map("n", "<F9>", ":setlocal spell! spelllang=en,sv<CR>", opts)
