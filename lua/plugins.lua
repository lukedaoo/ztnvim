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
if not status_ok then
    return
end

-- Install your plugins here
return packer.setup({
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
            require('plug-config/nvimtree')
        end,
    },
    -- finder
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function() require("plug-config/telescope_") end
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
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function() require('plug-config/treesitter') end,
        lazy = true,
        run = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        lazy = true,
        config = function()
            require("treesitter-context").setup({
                enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = false,      -- Enable multiwindow support.
                max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20,     -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })
        end
    },
    -- comments
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function() require('plug-config/comment') end
    },
    -- harpoon - bookmark file tool
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        branch = "harpoon2",
        lazy = true,
        config = function() require('plug-config/harpoon') end,
    },

    -- completion
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        event = "VeryLazy",
        lazy = true,
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy", },
            { "hrsh7th/cmp-buffer",   event = "VeryLazy", },
            { "hrsh7th/cmp-path",     event = "VeryLazy", },
        },
        config = function() require('plug-config/cmp') end
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
            require('plug-config/lsp')
        end
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons", event = "VeryLazy", },
        config = function() require('plug-config/trouble') end
    },
    -- Notes
    {
        "nvim-neorg/neorg",
        event = "VeryLazy",
        version = "*", -- Pin Neorg to the latest stable release
        lazy = true,
        config = function() require('plug-config/neoorg') end,
    },
    {
        "dhruvasagar/vim-table-mode",
        lazy = true,
        event = "VeryLazy",
        init = function()
            vim.g.table_mode_map_prefix = "<leader>tm"
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        after = { 'nvim-treesitter' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
    {
        "wakatime/vim-wakatime",
        lazy = true,
        event = "VeryLazy"
    },
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function() require('plug-config/image') end,
    },
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
})
