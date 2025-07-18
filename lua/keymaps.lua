local map = require("lib").map

-- utility
-- map("n", "<leader>q", vim.cmd.exit);
map("n", "<leader>h", ":noh<CR>")                                             -- no highlight
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>") -- search and replace word at cursor
map("n", "<C-a>", "ggVG")                                                     -- select all
map("n", "<leader>|", ":vsplit<CR>")
map("n", "<leader>_", ":split<CR>")
map("n", "<leader>se", "<C-w>=")
map("n", "<leader>sx", ":close<CR>")
map("n", "yc", "yygccp", { remap = true }) -- copy current line & comment it
map("n", "<leader><leader>", "ciw")


-- copy & paste
map({ "n", "v", "x" }, "$", 'g_');     -- go to the end line but not trailling char . THE BEST
map({ "n", "v" }, "<leader>y", '"+y'); -- copy to clipboard
map("n", "<leader>Y", '"+yg_');        -- copy to the end of line to clipboard
map("n", "<leader>yy", '"+yy');        -- copy the current line to clipboard

map({ "n", "v" }, "<leader>P", '"+P')  -- paste from from clipboard
map({ "n", "v" }, "<leader>p", '"+p')  -- paste from from clipboard
map("x", "p", "P")
-- copy & paste current line
map("n", "<leader>ll", "mayyp`aj")

-- line navigation and movements
map("v", "<Tab>", ">gv")          -- intent forward 1 tab
map("v", "<S-Tab>", "<gv")        -- intent backward 1 tab
map("v", "w", "iw")               -- select exactly a word in visual mode
map({ "n", "v", "o" }, "H", "^")  -- jump to first non-blank character of the line
map({ "n", "v", "o" }, "L", "g_") -- jump to last non-blank character of the line
map({ "n", "v", "o" }, "J", "<C-D>zz")
map({ "n", "v", "o" }, "K", "<C-U>zz")
map("n", "<", "<ESC>v<gv<ESC>")
map("n", ">", "<ESC>v>gv<ESC>")

-- move block
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

-- window navigation
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", function()
    if vim.fn.winnr() == vim.fn.winnr("h") then
        return "<cmd>tabprev<cr>"
    else
        return "<C-w>h"
    end
end, { expr = true, silent = true })

map("n", "<C-l>", function()
    if vim.fn.winnr() == vim.fn.winnr("l") then
        return "<cmd>tabnext<cr>"
    else
        return "<C-w>l"
    end
end, { expr = true, silent = true })

-- window resize
local terminal = require('lib').get_terminal()
if string.find(terminal, 'kitty') then
    map("n", "<S-Up>", "<cmd>resize +2<CR>")
    map("n", "<S-Down>", "<cmd>resize -2<CR>")
    map("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
    map("n", "<S-Right>", "<cmd>vertical resize +2<CR>")
else
    map("n", "<C-S-Up>", "<cmd>resize +2<CR>")
    map("n", "<C-S-Down>", "<cmd>resize -2<CR>")
    map("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>")
    map("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>")
end
-- tab
map("n", "<leader>tn", function() -- new tab
    vim.cmd [[ tabnew ]]
    if vim.g.loaded_telescope == 1 then
        require("telescope.builtin").find_files()
    end
end)
map("n", "<leader>tN", ":tabnew <CR>")
map("n", "<leader>tq", ":tabclose<CR>")
map("n", "<C-Left>", ":tabprevious<CR>")
map("n", "<C-Right>", ":tabnext<CR>")
map("n", "<leader>]", function()
    vim.cmd [[ vnew ]]
    require("telescope.builtin")
        .find_files(require('telescope.themes').get_dropdown({
            previewer = false
        }))
end)
-- term

local default_shell = "sh"
if not vim.o.shell then
    vim.o.shell = default_shell
end

map("n", "<leader>t_", ":split term://" .. vim.o.shell .. "<CR>")
map("n", "<leader>t|", ":vsplit term://" .. vim.o.shell .. "<CR>")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<C-c>", "<C-\\><C-n><C-w>")
vim.cmd [[
  augroup terminal_settings
    autocmd!

    " autocmd BufWinEnter,WinEnter term://* startinsert
    " autocmd BufLeave term://* stopinsert

    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    autocmd TermClose term://*
          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
          \   call nvim_input('<CR>')  |
          \ endif
  augroup END
]]


-- disable annoying delete with ky motions
map({ "n", "v" }, "dh", "<Nop>")
map({ "n", "v" }, "dj", "<Nop>")
map({ "n", "v" }, "dk", "<Nop>")
map({ "n", "v" }, "dl", "<Nop>")

-- disable uppercase/lowercase with v mode
map("v", "u", "<Nop>")
map("v", "U", "<Nop>")

-- delete without yank
-- map({ "n", "v" }, "x", '"_x', { noremap = false }) -- detele without yank
map({ "n", "v" }, "<leader>x", '"+x', { noremap = false })
map({ "n", "v" }, "vd", "dd")
-- enter others mode from insert mode
map("i", "jj", "<ESC><Right>")
map("i", "jk", "<ESC><Right>")
map("i", "kk", "<ESC><Right>")
-- map("i", "ddd", "<ESC>")
map("i", "AA", "<ESC><Right>")
map("i", "VV", "<ESC>V<Right>")

-- easy save
-- fixing that stupid typo when trying to [save]exit
vim.cmd [[
    cnoreabbrev <expr> W     ((getcmdtype()  is# ':' && getcmdline() is# 'W')?('w'):('W'))
    cnoreabbrev <expr> Q     ((getcmdtype()  is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
    cnoreabbrev <expr> WQ    ((getcmdtype()  is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
    cnoreabbrev <expr> Wq    ((getcmdtype()  is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
    cnoreabbrev <expr> Wqa    ((getcmdtype()  is# ':' && getcmdline() is# 'Wqa')?('wqa'):('Wqa'))
    cnoreabbrev <expr> w;    ((getcmdtype()  is# ':' && getcmdline() is# 'w;')?('w'):('w;'))
    cnoreabbrev <expr> ;w    ((getcmdtype()  is# ':' && getcmdline() is# ';w')?('w'):(';w'))
    cnoreabbrev <expr> Wqa    ((getcmdtype()  is# ':' && getcmdline() is# 'Wqa')?('wqa'):('wqa'))
    cnoreabbrev <expr> Wq    ((getcmdtype()  is# ':' && getcmdline() is# 'Wq')?('wq'):('wq'))
    cnoreabbrev <expr> qwa    ((getcmdtype()  is# ':' && getcmdline() is# 'qwa')?('wqa'):('wqa'))
    cnoreabbrev <expr> qw    ((getcmdtype()  is# ':' && getcmdline() is# 'qw')?('wq'):('wq'))
]]
-- map({ "n", "i" }, "<C-s>", "<ESC>:w<CR>")

-- easy exit
-- map("n", "<C-x>", ":wq<CR>")
-- map({ "n" }, "<leader>q", ":wq<CR>")

-- disable command history modes
map({ "n", "v" }, "q:", "<nop>")
map({ "n", "v" }, "q/", "<nop>")
map({ "n", "v" }, "q?", "<nop>")
map({ "n", "v" }, "qq", "<nop>");
map({ "v" }, "Q", "<nop>");
-- Q + a: write macro to register a
map('n', 'Q', 'q', { noremap = true, silent = true }) -- Q to write macro;
map('n', 'q', '', { noremap = true, silent = true })

-- search by selected text
map({ "v" }, "n",
    [[:<c-u>let temp_variable=@"<CR>gvy:<c-u>let @/='\V<C-R>=escape(@",'/\')<CR>'<CR>:let @"=temp_variable<CR>]])

-- open tmux session in new window
map("n", "<leader>op", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- format selected text
map("v", "<leader>f", function()
    if vim.g.auto_format_enabled == true then
        print("Work only with auto_format_enabled = false")
        return
    end
    vim.lsp.buf.format({
        async = true,
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        }
    })
end)
