-- ==============================================================================
-- SECTION 1: BOOTSTRAP & GLOBALS
-- ==============================================================================

vim.g.do_filetype_lua = 1
vim.g.python_host_skip_check = 1
vim.g.python3_host_prog = ""

-- Disable some builtin vim plugins
local disabled_built_ins = {
    "node_provider",
    "perl_provider",
    "ruby_provider",
    "python_provider",
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "matchparen",
    "tar",
    "tarPlugin",
    "tutor_mode_plugin",
    "rrhelper",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","
if vim.fn.has("win32") == 1 then
    vim.o.shell = "bash"
else
    vim.o.shell = "zsh"
end

vim.g.hard_mode_enabled = false

vim.g.auto_format_enabled = true -- Set to true to enable, false to disable auto format
vim.g.note_dir = "~/Notes"
vim.g.block_comment_lines = 25   -- When selected block has more than x lines, use block comment syntax
-- vim.opt.iskeyword:remove("_")    -- Remove the underscore (_) from the list of keyword characters

-- ==============================================================================
-- SECTION 2: OPTIONS
-- ==============================================================================

local options = {
    -- nvim settings
    fileencoding = "utf-8",
    errorbells = false,
    guicursor = "",
    termguicolors = true,
    updatetime = 150,
    colorcolumn = "80",

    backup = false,
    swapfile = false,
    undofile = true,
    -- clipboard = "unnamedplus",
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
    relativenumber = true,

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

if vim.fn.has("win32") == 1 then
    vim.opt.undodir = os.getenv("USERPROFILE") .. "\\.vim\\undodir"
else
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

-- show invisible
local set = vim.opt
set.list = true
set.termguicolors = true
set.listchars = {
    tab = '│ ',
    trail = '•',
    space = ' ',
    precedes = '←',
    extends = '→',
    -- eol = '↩'
}
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
-- folding
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldtext = ""
set.foldlevel = 99
set.foldlevelstart = 5
set.foldnestmax = 4

set.conceallevel = 2


-- ==============================================================================
-- SECTION 3: UTILITIES (formerly lua/lib.lua)
-- ==============================================================================

local function map(mode, lhs, rhs, opts, bufnr)
    local o = { noremap = true }
    if opts then o = vim.tbl_extend("force", o, opts) end
    if bufnr then o["buffer"] = bufnr end
    vim.keymap.set(mode, lhs, rhs, o)
end

local function load_colorscheme(colorscheme, post)
    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
    end
    post()
end


-- ==============================================================================
-- SECTION 4: KEYMAPS
-- ==============================================================================

-- utility
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
-- Join with the line above, strip whitespace, clear search
map("n", "gk", ":-1join! | silent! s/\\v\\S\\zs\\s+\\ze\\S//e | let @/=''<CR>", { noremap = true })
-- Join with the line below, strip whitespace, clear search
map("n", "gj", ":join! | silent! s/\\v\\S\\zs\\s+\\ze\\S//e | let @/=''<CR>", { noremap = true })

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
local terminal = (function()
    local ter_emu = os.getenv('TERMINAL')
    if ter_emu == nil or ter_emu == '' then
        ter_emu = os.getenv('TERM')
    end
    return ter_emu
end)()
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

map("n", "]]", function()
    local buf = vim.api.nvim_get_current_buf()
    vim.cmd("vnew")
    vim.api.nvim_set_current_buf(buf)
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


-- ==============================================================================
-- SECTION 5: AUTOCOMMANDS
-- ==============================================================================

-- Highlight current line
vim.cmd([[
augroup BgHighlight
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
    autocmd!
augroup END
]])

-- auto format
local function ToggleAutoFormat()
    vim.g.auto_format_enabled = not vim.g.auto_format_enabled
    print("Auto-formatting " .. (vim.g.auto_format_enabled and "enabled" or "disabled"))
end

vim.api.nvim_create_user_command(
    'ToggleAutoFormat',
    ToggleAutoFormat,
    { nargs = 0 }
)

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
    pattern = "*",
    callback = function()
        if vim.g.auto_format_enabled == false then return end
        -- local ignore_files_type = { "java", "h" } -- List of file types to ignore
        local ignore_files_type = { "h" } -- List of file types to ignore
        if vim.tbl_contains(ignore_files_type, vim.bo.filetype) then
            return
        end
        vim.lsp.buf.format({ async = true })
    end,
})

-- open PDFs with Zathura, handling tmux absence
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.pdf",
    callback = function()
        local file_path = vim.api.nvim_buf_get_name(0)

        local function open_with(viewer)
            vim.fn.jobstart({ viewer, file_path }, { detach = true })
            vim.cmd("bdelete")
            vim.notify("Opened " .. file_path .. " in " .. viewer, vim.log.levels.INFO)
        end

        if vim.fn.executable("sioyek") == 1 then
            open_with("sioyek")
        elseif vim.fn.executable("zathura") == 1 then
            open_with("zathura")
        else
            vim.notify("No PDF viewer (sioyek/zathura) found in PATH.", vim.log.levels.ERROR)
        end
    end,
})

-- set conceallevel to 0 for some filetypes
vim.cmd [[
augroup ConcealFileTypes
    autocmd!
    autocmd FileType json,markdown,help,tex setlocal conceallevel=0
augroup END
]]

-- show line count after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankLineCount", { clear = true }),
    callback = function()
        local register_content = vim.fn.getreg('"')
        local line_count = #vim.split(register_content, "\n") - 1
        vim.notify("Yanked " .. line_count .. " lines")
    end,
})

-- skip opening files
local media = { "*.gif", "*.png", "*.jpg", "*.jpeg", "*.mp4", "*.webp" }
local offices = { "*.pptx", "*.docx", "*.xlsx", ".pdf" }

vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = vim.list_extend(vim.list_extend({}, media), offices),
    callback = function()
        print("Skipped opening file.")
        vim.cmd("bdelete")
    end,
})

-- relative line number when not in insert mode
local relnum_augroup = vim.api.nvim_create_augroup("RelativeNumber", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
    pattern = "*",
    group = relnum_augroup,
    callback = function()
        if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
            vim.opt.relativenumber = true
        end
    end,
})

-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
--     pattern = "*",
--     group = relnum_augroup,
--     callback = function()
--         if vim.o.nu then
--             vim.opt.relativenumber = false
--             -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
--             -- Workaround for https://github.com/neovim/neovim/issues/32068
--             if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
--                 vim.cmd "redraw"
--             end
--         end
--     end,
-- })

-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})


-- ==============================================================================
-- SECTION 6: PLUGINS (lazy.nvim)
-- ==============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
local status_ok, packer = pcall(require, "lazy")
if status_ok then
    packer.setup({
        -- custom
        {
            "custom",
            name = "custom",
            lazy = true,
            event = "VeryLazy",
            dir = vim.fn.stdpath("config") .. "/lua/custom",
            config = function() require("custom") end,
        },
        -- colorschemes
        {
            "nyoom-engineering/oxocarbon.nvim",
            lazy = true,
            event = "VeryLazy",
        },
        {
            "dgrco/deepwater.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("deepwater")
            end,
        },
        {
            'projekt0n/github-nvim-theme',
            name = 'github-theme',
            event = "VeryLazy",
            lazy = true,
            config = function()
                require('github-theme').setup({})
            end,
        },
        {
            "blazkowolf/gruber-darker.nvim",
            lazy = true,
            event = "VeryLazy",
        },
        {
            "olimorris/onedarkpro.nvim",
            lazy = true,
            event = "VeryLazy"
        },
        -- utilities
        {
            "nvim-lua/plenary.nvim",
            event = "VeryLazy",
        },
        {
            "nvim-lua/popup.nvim",
            event = "VeryLazy",
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            lazy = true,
            opts = {},
            event = "VeryLazy",
            config = function()
                require("ibl").setup({
                    indent = {
                        char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
                    },
                    scope = {
                        show_start = false,
                        show_end = false,
                    },
                })
                -- disable indentation on the first level
                local hooks = require("ibl.hooks")
                hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
                hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
            end
        },
        {
            "hedyhli/outline.nvim",
            lazy = true,
            cmd = { "Outline", "OutlineOpen" },
            keys = {
                { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
            },
            config = function()
                require("outline").setup {
                    outline_items = {
                        auto_set_cursor = false,        -- Disable auto cursor sync to code position
                        highlight_hovered_item = false, -- Disable auto highlight of current/hovered symbol
                        auto_update_events = {
                            follow = {},                -- Disable auto-follow on CursorMoved etc.
                        },
                    },

                    -- Keep your existing settings
                    keymaps = {
                        peek_location = "<Tab>",
                    },
                    symbol_folding = {
                        autofold_depth = 1,
                    },
                }
            end,
        },
        -- folder explorer
        {
            "kyazdani42/nvim-tree.lua",
            lazy = true,
            dependencies = {
                {
                    "kyazdani42/nvim-web-devicons", -- optional, for file icons
                    event = "VeryLazy",
                }
            },
            event = "VeryLazy",
            config = function()
                local ok, nvim_tree = pcall(require, "nvim-tree")
                if not ok then
                    return
                end

                local to_hide = {
                    "^\\.git$" -- git folder
                }

                nvim_tree.setup({
                    sort_by = "case_sensitive",
                    view = {
                        -- adaptive_size = true,
                        width = 35
                    },
                    renderer = {
                        group_empty = true,
                        icons = {
                            glyphs = {
                                git = {
                                    untracked = "U",
                                    unstaged = "X"
                                },
                            },
                        },
                        special_files = { ".gitignore", ".env" },
                    },
                    update_focused_file = {
                        enable = true,
                        update_cwd = true,
                    },
                    filters = {
                        dotfiles = false, -- show dotfiles
                        custom = to_hide,
                    },
                    actions = {
                        change_dir = { enable = false },
                        open_file = {
                            window_picker = {
                                enable = false
                            }
                        }
                    }
                })

                if not vim.g.vscode then
                    map("n", "<leader>e", ":NvimTreeToggle<CR>")
                end

                vim.api.nvim_create_autocmd("BufEnter", {
                    pattern = "*",
                    callback = function()
                        if #vim.api.nvim_list_bufs() == 1 and vim.bo.filetype == "NvimTree" then
                            vim.cmd("quit")
                        end
                    end,
                })
            end,
        },
        -- finder
        {
            "nvim-telescope/telescope.nvim",
            event = "VeryLazy",
            lazy = true,
            config = function()
                local status_ok2, telescope = pcall(require, "telescope")
                if not status_ok2 then
                    return
                end

                local ignores_file = {
                    -- global
                    ".git", ".zsh_", ".vscode/extensions", ".DS_Store",
                    -- JS
                    "node_modules", ".npm",
                    -- Java
                    "target", ".settings", ".idea", ".m2", ".metadata", "mvnw*",
                    -- Rust
                    ".lock",

                    "%.png$", "%.jpg$", "%.jpeg$", "%.gif$", "%.bmp$", "%.ico$",
                    "%.pdf$", "%.zip$", "%.tar$", "%.gz$", "%.7z$", "%.exe$",
                    "%.dll$", "%.so$", "%.dylib$", "%.mp3$", "%.mp4$", "%.avi$",
                    "%.mov$", "%.iso$", "%.class$", "%.jar$", "%.bin$", "%.dat$",
                }

                telescope.setup({
                    defaults = {
                        file_sorter = require("telescope.sorters").get_fzy_sorter,
                        seletion_caret = " ",
                        prompt_prefix = " ",
                        color_devicons = true,
                        initial_mode = "normal",
                        path_display = { "smart" },
                        file_ignore_patterns = ignores_file,
                        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

                        borderchars = { "", "", "", "", "", "", "", "" },

                        mappings = {
                            i = {
                                ["<C-x>"] = false,
                                ["<C-q>"] = require("telescope.actions").send_to_qflist,
                            },
                        },

                        layout_strategy = "horizontal",
                        layout_config = {
                            width = 150,
                            height = 450,
                            prompt_position = "bottom",
                            preview_cutoff = 40,
                        },

                    },
                    pickers = {
                        colorscheme = {
                            enable_preview = true
                        },
                        live_grep = {
                            additional_args = function()
                                return { "--ignore-binary" }
                            end,
                        },
                    },
                })

                -- telescope.load_extension("git_worktree")
                -- telescope.load_extension("media_files")
                --
                -- telescope.load_extension("flutter")

                map("n", "<C-f>", ":Telescope")

                map("n", "<leader>fS", function()
                    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
                end)

                map("n", "<leader>ff", function()
                    require('telescope.builtin').find_files()
                end)

                map("n", "<leader>fg", function()
                    require('telescope.builtin').git_files()
                end)

                map("n", "<leader>fs", function()
                    require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })
                end)

                map("n", "<leader>gf", function()
                    require('telescope.builtin').git_files()
                end)

                map("n", "<leader>gb", function()
                    require('telescope.builtin').git_branches()
                end)
            end
        },
        {
            'kevinhwang91/nvim-bqf',
            lazy = true,
            event = "VeryLazy"
        },

        -- snippets
        {
            "L3MON4D3/LuaSnip",
            event = "VeryLazy",
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            lazy = true,
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            dependencies = {
                { "rafamadriz/friendly-snippets", event = "VeryLazy", },
                { "saadparwaiz1/cmp_luasnip",     event = "VeryLazy", },
            },
        },

        -- treesitter
        {
            "romus204/tree-sitter-manager.nvim",
            dependencies = {}, -- tree-sitter CLI must be installed system-wide
            config = function()
                require("tree-sitter-manager").setup()
            end,
        },
        -- comments
        {
            "folke/ts-comments.nvim",
            event = "VeryLazy",
            lazy = true,
            opts = {},
            config = function(_, opts)
                require("ts-comments").setup(opts)

                local function toggle_comment()
                    local mode = vim.api.nvim_get_mode().mode
                    local line1, line2

                    local upbound = vim.g.block_comment_lines or 10

                    if mode == "v" or mode == "V" or mode == "\22" then
                        line1 = vim.fn.line("v")
                        line2 = vim.fn.line(".")
                        local count = math.abs(line2 - line1) + 1 -- Calculate selected line count

                        if count > upbound then
                            vim.api.nvim_feedkeys("gb", "x", true)
                            vim.notify("Commented out " .. count .. " lines")
                        else
                            vim.api.nvim_feedkeys("gcc", "x", true)
                        end
                    else -- Normal mode
                        vim.api.nvim_feedkeys("gcc", "x", true)
                    end
                end

                map("n", "<leader>/", toggle_comment, { noremap = true, silent = true })
                map("v", "<leader>/", toggle_comment, { noremap = true, silent = true })
            end
        },
        -- harpoon - bookmark file tool
        {
            "ThePrimeagen/harpoon",
            event = "VeryLazy",
            branch = "harpoon2",
            lazy = true,
            config = function()
                local status_ok2, telescope = pcall(require, "telescope")
                if not status_ok2 then
                    return
                end

                local h_status_ok, harpoon = pcall(require, "harpoon")
                if not h_status_ok then
                    return
                end
                telescope.load_extension("harpoon")

                local conf = require("telescope.config").values
                local function toggle_telescope(harpoon_files)
                    local file_paths = {}
                    for _, item in ipairs(harpoon_files.items) do
                        table.insert(file_paths, item.value)
                    end

                    require("telescope.pickers").new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    }):find()
                end

                harpoon:setup()
                -- REQUIRED
                map("n", "<leader><Tab>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

                map("n", "mm", function() harpoon:list():add() end)
                map("n", "mq", function() harpoon:list():select(1) end)
                map("n", "mw", function() harpoon:list():select(2) end)
                map("n", "me", function() harpoon:list():select(3) end)
                map("n", "mr", function() harpoon:list():select(4) end)

                -- Toggle previous & next buffers stored within Harpoon list
                map("n", "mn", function() harpoon:list():prev() end)
                map("n", "mp", function() harpoon:list():next() end)
                map("n", "m;", function()
                    toggle_telescope(harpoon:list())
                end)
            end,
        },

        -- completion
        {
            "hrsh7th/nvim-cmp", -- The completion plugin
            event = "VeryLazy",
            lazy = true,
            dependencies = {
                { "hrsh7th/cmp-nvim-lsp",        event = "VeryLazy", },
                { "hrsh7th/cmp-buffer",          event = "VeryLazy", },
                { "hrsh7th/cmp-path",            event = "VeryLazy", },
                { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
            },
            config = function()
                local cmp_status_ok, cmp = pcall(require, "cmp")
                if not cmp_status_ok then
                    return
                end

                local snip_status_ok, luasnip = pcall(require, "luasnip")
                if not snip_status_ok then
                    return
                end

                local check_backspace = function()
                    local col = vim.fn.col "." - 1
                    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
                end

                -- find more here: https://www.nerdfonts.com/cheat-sheet
                local kind_icons = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = " ",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                    Misc = " ",
                }

                require("luasnip.loaders.from_vscode").lazy_load()
                cmp.setup {
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body) -- For `luasnip` users.
                            vim.snippet.expand(args.body)
                        end,
                    },
                    mapping = {
                        ["<C-k>"] = cmp.mapping.select_prev_item(),
                        ["<C-j>"] = cmp.mapping.select_next_item(),
                        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                        ["<C-e>"] = cmp.mapping {
                            i = cmp.mapping.abort(),
                            c = cmp.mapping.close(),
                        },
                        ["<CR>"] = cmp.mapping.confirm { select = true },
                        ["<Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expandable() then
                                luasnip.expand({})
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            elseif check_backspace() then
                                fallback()
                            else
                                fallback()
                            end
                        end, {
                            "i",
                            "s",
                        }),
                        ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, {
                            "i",
                            "s",
                        }),
                    },
                    formatting = {
                        fields = { "kind", "abbr", "menu" },
                        format = function(entry, vim_item)
                            -- Kind icons
                            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                            vim_item.menu = ({
                                luasnip = "[Snippet]",
                                buffer = "[Buffer]",
                                path = "[Path]",
                            })[entry.source.name]
                            return vim_item
                        end,
                    },
                    sources = {
                        { name = "luasnip" },
                        { name = "buffer" },
                        { name = "path" },
                        { name = "nvim_lsp" },
                        { name = "codeium" }
                    },
                    confirm_opts = {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    },
                    widow = {
                        documentation = {
                            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                        },
                    },
                    experimental = {
                        ghost_text = false,
                        native_menu = false,
                    },
                }
            end
        },

        -- LSP
        {
            "williamboman/mason.nvim",
            dependencies = {
                { "williamboman/mason-lspconfig.nvim", event = "VeryLazy", },
                { "neovim/nvim-lspconfig",             event = "VeryLazy", },
                -- java
                -- "mfussenegger/nvim-jdtls",
            },
            event = "VeryLazy",
            config = function()
                local status_mason, mason = pcall(require, "mason")
                if not status_mason then return end

                local status_mason_lsp_config, mason_lsp_config = pcall(require, "mason-lspconfig")
                if not status_mason_lsp_config then return end

                mason.setup()
                mason_lsp_config.setup({
                    ensure_installed = { "lua_ls" }
                })

                local capabilities = vim.lsp.protocol.make_client_capabilities();

                local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
                if not status_cmp_ok then
                    return
                end

                capabilities.textDocument.completion.completionItem.snippetSupport = true
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

                vim.diagnostic.config {
                    virtual_text = false,
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = "",
                            [vim.diagnostic.severity.WARN] = "",
                            [vim.diagnostic.severity.INFO] = "󰋼",
                            [vim.diagnostic.severity.HINT] = "󰌵",
                        },
                    },
                    float = {
                        border = "rounded",
                        format = function(d)
                            return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
                        end,
                    },
                    underline = true,
                    jump = {
                        float = true,
                    },
                }

                local on_attach = function()
                    map("n", "gd", function()
                        require('telescope.builtin').lsp_definitions(
                            require('telescope.themes').get_dropdown({})
                        )
                    end)
                    map("n", "gr", function()
                        require('telescope.builtin').lsp_references(
                            require('telescope.themes').get_dropdown({})
                        )
                    end)

                    map("n", "gi", function()
                        require('telescope.builtin').lsp_implementations(
                            require('telescope.themes').get_dropdown({})
                        )
                    end)
                    map("n", "<leader>k", function() vim.lsp.buf.hover() end)
                    map("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end)
                    map("n", "<leader>ld", function() vim.diagnostic.open_float() end)
                    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
                    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
                    map("n", "<leader>lrn", function() vim.lsp.buf.rename() end)
                    map("n", "<leader>la", function() vim.lsp.buf.code_action() end)
                    map("n", "<leader>lo", function()
                        vim.lsp.buf.code_action({
                            filter = function(code_action)
                                if not code_action or not code_action.data then
                                    return false
                                end

                                local data = code_action.data.id
                                return string.sub(data, #data - 1, #data) == ":0"
                            end,
                            apply = true
                        })
                    end)
                    map("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
                end

                local default_config = function(_config)
                    return vim.tbl_deep_extend("force", {
                        capabilities = capabilities,
                        on_attach = on_attach
                    }, _config or {})
                end

                -- Helper: define and enable LSP configs
                local function setup_lsp(name, opts)
                    local cfg = vim.lsp.config(name, default_config(opts))
                    vim.lsp.enable(name, cfg)
                end

                -- Lua
                setup_lsp("lua_ls")

                -- Python
                -- setup_lsp("jedi_language_server")
                setup_lsp("pyright")
                setup_lsp("ruff")

                -- C / C++
                setup_lsp("clangd")

                -- HTML
                setup_lsp("html", {
                    init_options = {
                        configurationSection = { "html", "css", "javascript" },
                        embeddedLanguages = { css = true, javascript = false },
                        provideFormatter = true,
                    },
                })

                -- CSS
                setup_lsp("cssls")

                -- TS/JS
                setup_lsp("ts_ls", {
                    init_options = {
                        preferences = { disableSuggestions = true },
                    },
                    single_file_support = true,
                })

                -- Go
                setup_lsp("gopls")

                -- Typst
                setup_lsp("tinymist")

                -- Java
                setup_lsp("jdtls")

                -- LaTeX (optional)
                -- setup_lsp("texlab")
                -- setup_lsp("ltex")
                -- setup_lsp("dartls")
                -- setup_lsp("csharp_ls")
            end
        },
        {
            "folke/trouble.nvim",
            event = "VeryLazy",
            lazy = true,
            dependencies = { "nvim-tree/nvim-web-devicons", event = "VeryLazy", },
            config = function()
                local status_ok2, trouble = pcall(require, "trouble")
                if not status_ok2 then
                    return
                end
                trouble.setup()

                local function toggle_trouble(bufnr, retried)
                    local winid = vim.fn.getqflist({ winid = 1 }).winid
                    if winid == 0 then
                        local diagnostics
                        if bufnr then
                            diagnostics = vim.diagnostic.get(bufnr)
                        else
                            diagnostics = vim.diagnostic.get()
                        end

                        if vim.tbl_isempty(diagnostics) then
                            if not retried then
                                -- Try once more in case diagnostics are delayed
                                vim.defer_fn(function()
                                    toggle_trouble(bufnr, true)
                                end, 100) -- retry after 100ms
                            else
                                vim.notify("No diagnostics found", vim.log.levels.INFO)
                            end
                            return
                        end
                        vim.fn.setqflist({}, ' ', {
                            title = 'Diagnostics (current buffer)',
                            items = vim.diagnostic.toqflist(diagnostics, bufnr)
                        })
                        vim.cmd("copen")
                    else
                        vim.cmd("cclose")
                    end
                end

                -- toggle diagnostics for workspace
                map("n", "<leader>xa", function()
                    toggle_trouble(nil)
                end)

                -- toggle diagnostics for current dir
                map("n", "<leader>xx", function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    toggle_trouble(bufnr)
                end)
            end
        },

        {
            'chomosuke/typst-preview.nvim',
            lazy = false, -- or ft = 'typst'
            version = '1.*',
            opts = {},    -- lazy.nvim will implicitly calls `setup {}`
        },
        -- Notes
        -- {
        --     'MeanderingProgrammer/render-markdown.nvim',
        --     after = { 'nvim-treesitter' },
        --     config = function()
        --         require('render-markdown').setup({})
        --     end,
        -- },
        {
            "wakatime/vim-wakatime",
            lazy = true,
            event = "VeryLazy"
        },
        -- {
        --     "3rd/image.nvim",
        --     event = "VeryLazy",
        --     lazy = true,
        --     config = function() require('plug-config/image') end,
        -- },
        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {
                keywords = {
                    FIX        = { icon = "F", alt = { "Fix", "fix", "FIXME", "BUG", "FIXIT", "ISSUE" } },
                    TODO       = { icon = "T", alt = { "Todo", "todo" } },
                    HACK       = { icon = "H", alt = { "Hack", "hack" } },
                    WARN       = { icon = "W", alt = { "Warn", "warn", "WARNING" } },
                    PERF       = { icon = "P", alt = { "Perf", "perf", "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE       = { icon = "N", alt = { "Note", "note", "INFO", "Info", "info" } },
                    TEST       = { icon = "t", alt = { "Test", "test", "TESTING", "PASSED", "FAILED" } },
                    CLEANUP    = { icon = "C", alt = { "Cleanup", "cleanup", "CLEAN", "CLEANUP_NEEDED" } },
                    INCOMPLETE = { icon = "I", alt = { "Incomplete", "incomplete", "INCOMPLETE_FEATURE", "INCOMPLETE_TASK" } },
                    REFACTOR   = { icon = "R", alt = { "Refactor", "refactor", "REFACTOR_NEEDED", "REFACTORING" } },
                },
                highlight = {
                    before = "",
                    keyword = "",
                    after = "",
                    pattern = { [[\c.*\zs<(KEYWORDS)\s*:]], [[\c.*\zs\@(KEYWORDS)\s*:]], [[\c.*\zs\@(KEYWORDS)\s*\(.*\)]] },
                },
                search = {
                    pattern = [=[(?i)@(KEYWORDS)[:(]]=],
                },
            },
            config = function(_, opts)
                require("todo-comments").setup(opts)

                vim.keymap.set("n", "]t", function()
                    require("todo-comments").jump_next()
                end, { desc = "Next todo comment" })

                vim.keymap.set("n", "[t", function()
                    require("todo-comments").jump_prev()
                end, { desc = "Previous todo comment" })
            end
        },
        -- AI
        {
            "Exafunction/windsurf.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "hrsh7th/nvim-cmp",
            },
            config = function()
                require("codeium").setup({
                    -- Optionally disable cmp source if using virtual text only
                    enable_cmp_source = false,
                    virtual_text = {
                        enabled = true,

                        -- These are the defaults

                        -- Set to true if you never want completions to be shown automatically.
                        manual = false,
                        -- A mapping of filetype to true or false, to enable virtual text.
                        filetypes = {},
                        -- Whether to enable virtual text of not for filetypes not specifically listed above.
                        default_filetype_enabled = true,
                        -- How long to wait (in ms) before requesting completions after typing stops.
                        idle_delay = 75,
                        -- Priority of the virtual text. This usually ensures that the completions appear on top of
                        -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
                        -- desired.
                        virtual_text_priority = 65535,
                        -- Set to false to disable all key bindings for managing completions.
                        map_keys = true,
                        -- The key to press when hitting the accept keybinding but no completion is showing.
                        -- Defaults to \t normally or <c-n> when a popup is showing.
                        accept_fallback = nil,
                        -- Key bindings for managing completions in virtual text mode.
                        key_bindings = {
                            -- Accept the current completion.
                            accept = "<C-o>",
                            -- Accept the next word.
                            accept_word = false,
                            -- Accept the next line.
                            accept_line = false,
                            -- Clear the virtual text.
                            clear = false,
                            -- Cycle to the next completion.
                            next = "<M-]>",
                            -- Cycle to the previous completion.
                            prev = "<M-[>",
                        }
                    }
                })
            end
        },

        {
            "folke/sidekick.nvim",
            opts = {
            },
            keys = {
                {
                    "<tab>",
                    function()
                        -- if there is a next edit, jump to it, otherwise apply it if any
                        if not require("sidekick").nes_jump_or_apply() then
                            return "<Tab>" -- fallback to normal tab
                        end
                    end,
                    expr = true,
                    desc = "Goto/Apply Next Edit Suggestion",
                },
                {
                    "<c-.>",
                    function() require("sidekick.cli").toggle() end,
                    desc = "Sidekick Toggle",
                    mode = { "n", "t", "i", "x" },
                },
                {
                    "<leader>aa",
                    function() require("sidekick.cli").toggle() end,
                    desc = "Sidekick Toggle CLI",
                },
                {
                    "<leader>as",
                    function() require("sidekick.cli").select() end,
                    -- Or to select only installed tools:
                    -- require("sidekick.cli").select({ filter = { installed = true } })
                    desc = "Select CLI",
                },
                {
                    "<leader>ad",
                    function() require("sidekick.cli").close() end,
                    desc = "Detach a CLI Session",
                },
                {
                    "<leader>at",
                    function() require("sidekick.cli").send({ msg = "{this}" }) end,
                    mode = { "x", "n" },
                    desc = "Send This",
                },
                {
                    "<leader>af",
                    function() require("sidekick.cli").send({ msg = "{file}" }) end,
                    desc = "Send File",
                },
                {
                    "<leader>av",
                    function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                    mode = { "x" },
                    desc = "Send Visual Selection",
                },
                {
                    "<leader>ap",
                    function() require("sidekick.cli").prompt() end,
                    mode = { "n", "x" },
                    desc = "Sidekick Select Prompt",
                },
                -- Example of a keybinding to open Claude directly
                {
                    "<leader>ac",
                    function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                    desc = "Sidekick Toggle Claude",
                },
            },
        },
        {
            "ej-shafran/compile-mode.nvim",
            version = "^5.0.0",
            -- you can just use the latest version:
            -- branch = "latest",
            -- or the most up-to-date updates:
            -- branch = "nightly",
            dependencies = {
                "nvim-lua/plenary.nvim",
                -- if you want to enable coloring of ANSI escape codes in
                -- compilation output, add:
                -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
            },
            config = function()
                ---@type CompileModeOpts
                vim.g.compile_mode = {
                    -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
                    -- set this to fix tab completion in command mode:
                    -- input_word_completion = true,

                    -- to add ANSI escape code support, add:
                    -- baleia_setup = true,

                    -- to make `:Compile` replace special characters (e.g. `%`) in
                    -- the command (and behave more like `:!`), add:
                    -- bang_expansion = true,
                }
            end
        }
    })
end


-- ==============================================================================
-- SECTION 7: COLORSCHEME
-- ==============================================================================

load_colorscheme("gruber-darker", function()
    if vim.g.colors_name == "gruber-darker" then
        local palette = require("gruber-darker.palette")
        local bg_color = "#000000"

        vim.api.nvim_set_hl(0, "@property", {
            fg = palette["fg"]:to_string()
        })

        -- Active buffer
        vim.api.nvim_set_hl(0, "Normal", {
            bg = bg_color,
            fg = palette["fg"]:to_string()
        })

        -- Inactive buffer (keep same background)
        vim.api.nvim_set_hl(0, "NormalNC", {
            bg = bg_color,
            fg = palette["fg"]:to_string()
        })

        -- Optional: other UI elements
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = bg_color })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = bg_color })
        vim.api.nvim_set_hl(0, "Todo", {})
    end
end)
