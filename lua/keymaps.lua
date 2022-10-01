local map = require("lib.core").map

-- utility
map("n", "<leader>h", ":noh<CR>") -- no highlight
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>") -- search and replace word at cursor
map("n", "<leader>]", ":vsplit<CR>") -- vertical split
map("n", "<C-a>", "ggVG") -- select all
-- line navigation and movements
map("v", "<Tab>", ">gv") -- intent forward 1 tab
map("v", "<S-Tab>", "<gv") -- intent backward 1 tab
map("v", "w", "iw") -- select exactly a word in visual mode
map({"n", "v", "o"}, "H", "^") -- jump to first non-blank character of the line
map({"n", "v", "o"}, "L", "$") -- jump to last non-blank character of the line
map("n", ">", "<ESC>v>gv<ESC>")
map("n", "<", "<ESC>v<gv<ESC>")

-- move block
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '<+1<CR>gv-gv")

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- window resize
map("n", "<C-S-Up>", "<cmd>resize +2<CR>")
map("n", "<C-S-Down>", "<cmd>resize -2<CR>")
map("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>")

-- tab
map("n", "<leader>tn", function() -- new tab
    vim.cmd [[ tabnew ]]
    if vim.g.loaded_telescope == 1 then
        require("telescope.builtin").find_files()
    end
end)
map("n", "<leader>tq", ":tabclose<CR>")
map("n", "<C-Left>", ":tabprevious<CR>")
map("n", "<C-Right>", ":tabnext<CR>")

-- term

local default_shell = "sh"
if not vim.o.shell then
    vim.o.shell = default_shell
end

map("n", "<leader>T", ":vsp term://" .. vim.o.shell .. "<CR>")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<C-c>", "<C-\\><C-n><C-w>")
vim.cmd [[
  augroup terminal_settings
    autocmd!

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    autocmd TermClose term://*
          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
          \   call nvim_input('<CR>')  |
          \ endif
  augroup END
]]


-- disable anoying delete with ky motions
map({"n", "v"}, "dh", "<Nop>")
map({"n", "v"}, "dj", "<Nop>")
map({"n", "v"}, "dk", "<Nop>")
map({"n", "v"}, "dl", "<Nop>")

-- delete without yank
map({"n", "v"}, "x", '"_x', { noremap = false }) -- detele without yank

-- enter othhers mode from insert mode
map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>")
map("i", "ddd", "<ESC>")
map("i", "AA", "<ESC>")
map("i", "VV", "<ESC>V")

-- easy save
-- fixing that stupid typo when trying to [save]exit
vim.cmd [[
    cnoreabbrev <expr> W     ((getcmdtype()  is# ':' && getcmdline() is# 'W')?('w'):('W'))
    cnoreabbrev <expr> Q     ((getcmdtype()  is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
    cnoreabbrev <expr> WQ    ((getcmdtype()  is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
    cnoreabbrev <expr> Wq    ((getcmdtype()  is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
    cnoreabbrev <expr> w;    ((getcmdtype()  is# ':' && getcmdline() is# 'w;')?('w'):('w;'))
    cnoreabbrev <expr> ;w    ((getcmdtype()  is# ':' && getcmdline() is# ';w')?('w'):(';w'))
]]
map({"n", "i"}, "<C-s>", "<ESC>:w<CR>")

-- easy exit
map("n", "<C-x>", ":wq<CR>")
map("n", "<C-c>", ":wq<CR>")
map({"n"}, "<leader>q", ":wq<CR>")
map("n", "<leader>q", function()
    require('bufdelete').bufdelete(0, true)
end)

-- disable command history modes
map({"n", "v"}, "q:", "<nop>")
map({"n", "v"}, "q/", "<nop>")
map({"n", "v"}, "q?", "<nop>")

HARD_CODE_MODE = 0

if HARD_CODE_MODE == 1 then

    map({"n", "i"}, "<Up>", "<Nop>")
    map({"n", "i"}, "<Down>", "<Nop>")
    map({"n", "i"}, "<Left>", "<Nop>")
    map({"n", "i"}, "<Right>", "<Nop>")

end
