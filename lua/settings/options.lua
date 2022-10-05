local options = {
    -- nvim settings
    fileencoding = "utf-8",
    errorbells = false,
    guicursor = "",
    termguicolors = true,
    updatetime = 150,
    colorcolumn = "120",

    backup = false,
    swapfile = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
    clipboard = "unnamedplus",
    cmdheight = 2,
    mouse = "a",
    showmode = false,
    showtabline = 2,
    cursorline = false,
    splitbelow = true,
    splitright = true,
    wrap = false,
    -- search
    hlsearch = true,
    incsearch = true,
    ignorecase = false,

    -- number
    number = true,
    relativenumber = false,

    -- indent
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,

    -- scroll
    scrolloff = 8,
    sidescrolloff = 8
}

for k, v in pairs(options) do
    vim.opt[k] = v
end


-- show invisible
local set = vim.opt
set.list = true
set.termguicolors = true
set.listchars = { tab = '│ ', --[[eol = '↩' ,--]] trail = '•', space = '⋅', precedes = '←', extends = '→' }
set.fillchars = {
    stl = ' ',
    stlnc = ' ',
    diff = '∙',
    eob = ' ',
    fold = '·',
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┫',
    vertright = '┣',
    verthoriz = '╋'
}
