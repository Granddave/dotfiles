local map = vim.keymap.set
local opts = { noremap = false, silent = true }

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

local resize_step = 4
map("n", "<M-C-h>", ":vertical resize -" .. resize_step .. "<CR>", opts)
map("n", "<M-C-j>", ":resize +" .. resize_step .. "<CR>", opts)
map("n", "<M-C-k>", ":resize -" .. resize_step .. "<CR>", opts)
map("n", "<M-C-l>", ":vertical resize +" .. resize_step .. "<CR>", opts)

map("n", "<Leader>qn", ":cnext<CR>", opts)
map("n", "<Leader>qp", ":cprev<CR>", opts)

map("n", "<Leader>sl", ":set list!<CR>", opts)
map("n", "<Leader>rt", ":retab!<CR>", opts)
map("n", "<Leader><Leader>", "za", opts)

map("x", "<Leader>sr", 'y:%s%<C-r>"%%g<Left><Left>', { noremap = true })
map("x", "<Leader>sc", 'y:%s%<C-r>"%%gc<Left><Left><Left>', { noremap = true })

map("n", "<Esc>", ":nohlsearch<CR>", opts)
--map("n", "<Esc>^[", "<Esc>^[", opts)

local scroll_step = 2
map("", "<C-e>", scroll_step .. "<C-e>", opts)
map("", "<C-y>", scroll_step .. "<C-y>", opts)
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
map("n", "<Leader>dw", require("custom.utils").clean_trailing_spaces, opts)
map("v", "<Leader>tc", [[y:! timecalc.py <C-r>" <Bar> tr -d "\n" <Bar> xclip -in -selection clipboard<CR>A = <Esc>"+p]], opts)
map("v", "<Leader>j", [[mj/\a\+-\d\+<CR><Cmd>noh<CR>y3e`jPa<Space>]], opts)
map("n", "<Leader>sp", ":setlocal spell! spelllang=en,sv<CR>", opts)
map("n", "<Leader>rc", require("custom.utils").reload_current_lua_file, opts)
map("n", "<Leader>rw",
  function()
    vim.cmd("write")
    require("custom.utils").reload_current_lua_file()
  end,
  opts
)

map("n", "<Leader>fj", "<Cmd>%!jq<CR>", opts)
map("v", "<Leader>fj", "<Cmd>'<,'>!jq<CR>", opts)
map("n", "<Leader>fcj", "<Cmd>%!jq --compact-output<CR>", opts)
map("v", "<Leader>fcj", "<Cmd>'<,'>!jq --compact-output<CR>", opts)
